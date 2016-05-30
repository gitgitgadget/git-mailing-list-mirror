From: tboegi@web.de
Subject: [PATCH v1 0/1] t6038-merge-text-auto.sh
Date: Mon, 30 May 2016 19:00:42 +0200
Message-ID: <1464627642-23994-1-git-send-email-tboegi@web.de>
References: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 18:59:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7QXZ-0004fu-8d
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 18:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161641AbcE3Q7l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2016 12:59:41 -0400
Received: from mout.web.de ([217.72.192.78]:59032 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161220AbcE3Q7k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 12:59:40 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 May 2016 12:59:40 EDT
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0M89mf-1bTkhl2j4r-00vioi; Mon, 30 May 2016 18:54:32
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:gJal2FPvfRt9JLBFjmjHGzbA2Ph+t/l9aCra2gYRHuGQyw011cG
 d1HZcEY6BMy5wv1U+m3pkaOeJ63YkxpITjNoUTTKiVGN3EUgOiuuEboWwWbN6ehy03iKuSx
 B/GwnSho54mTfT2HRlYOpn9bHWvkeOwyYZ4i4ZU4rQnja0tk2L03mErE/gifqqXW+KCoTIy
 KKfstSvsqpr9oLloc3NDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e7FE5N5q9Ng=:mmdeB+gyMqpQRlCrXX1Wuq
 2UXUaumCxAafqFJX/6RmzIK4Hsgtif/uhkMqL6YSEQDZHj1AzsSe4+IcapnXLXlFwcuS+WZqu
 DqSy468WO/SFD7yODIKravS1vF/GH5cE2uKW//qPpxty9rXGC2we8OL1GS/CF48j3w79KDsDi
 3KZhKRHXL+4NNmTSR3tsAShaJqXmeSAtuMA2ZpVTyZg4wRD8w1K2CB3cqsKmpudkPpUgBJ6b8
 lBwz72TvuI+BNDJhrFMlltb78Tvp5i2CC6vnIAygI8bHFZjEqgDr6zVvGxG1Tq7mVChHPy7b7
 48Cndt8ksQ2CEIfePx+PVaHrLQcId6grO+bl2n0MpkdxLKd4hd2xA5hRHmsbbDxwDiSZjbbRB
 V+DJ7R983dNm1u7B8WerQ/2qmEtyywCjh0CD3ubcWxJZ1Wbb8GyaXxHThF4LBcU+eviFqG+gk
 XN0SwDc+UxowctJ7urhZYrsn0Te+qtsOSaPh37Q7Hf/T2ZE7Llp4rgvbDDZfJieeT4C8yO5u2
 1ae/s+yPIw9JmTf4SXQqPYKnDrVokYn+12vMPJdAE1iIOxyult4krHcbF8UIKf2d2nZlTNnRm
 xnRnt71MV26Bf2AwalduHD9Csw4CPTuMZ7Z+GbijnMf9oexU1LNzBmJZdJz2uXl1kPJ12P+uq
 peJ/EVRdzG/Fb1EztW+a3I/Bq5HvcPBgLk3vBFoqYXJxZA16stk/P0xWD3p/8k2PfbFQ1pVo0
 aIDZbCPy90XhYcH3DINzcebRKTUmt4n/TGcos21G5wCjR/nKpAaZRBoVDRmS4EprijSHEu+K 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295912>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Split of the old 10/10 series.
This is the update of t6038, which is needed to
motivate the patch
   `convert: ce_compare_data() checks for a sha1 of a path`
on top of
   `convert: unify the "auto" handling of CRLF`

When files with different eols are merged with
merge.renormalize =3D true,
it is important to look at the right blob to determine if
the crlf came from the blob or are a result of a coversion.
This is a little bit of a hen-and-egg problem:
The problem comes up after the "unified auto handling".
In theory, it should have been since before:
get_sha1_from_index() says:

 * We might be in the middle of a merge, in which
 * case we would read stage #2 (ours).

This seams wrong, as in the merge we sometimes need to
look at "theirs".
(But I haven't managed to construct a TC)

t6038-merge-text-auto.sh

Torsten B=C3=B6gershausen (1):
  t6038: different eol for "Merge addition of text=3Dauto"

 t/t6038-merge-text-auto.sh | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

--=20
2.0.0.rc1.6318.g0c2c796
