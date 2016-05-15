From: tboegi@web.de
Subject: [PATCH v2 0/3] CRLF-Handling: bug fix around ce_compare_data()
Date: Sun, 15 May 2016 15:02:08 +0200
Message-ID: <1463317328-2632-1-git-send-email-tboegi@web.de>
References: <20160513134953.GE2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 14:57:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1vbP-0004ab-7M
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 14:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251AbcEOM4u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2016 08:56:50 -0400
Received: from mout.web.de ([212.227.15.14]:57794 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754165AbcEOM4t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 08:56:49 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LqXBp-1bX7gi0Fov-00e0qu; Sun, 15 May 2016 14:56:45
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <20160513134953.GE2345@dinwoodie.org>
X-Provags-ID: V03:K0:gjjafGWQtPt2J8j0JM/IKVabhLcg83YY820aYQXcAapXApiXcVY
 hfN3BVc1hig/en+CLrSyIp+aThhayYM/LbPjZpksgOc7I4rn8GTEUrXy4VCLtCzbr/GIwHH
 HzbpI7H913vS0Dw4CYdXizLroho5KtzKRD6sD8NZ/PCUL/YYL7tlHtxEHrQhmgrHoPARjaU
 4BDgev8d4sJF+l8PkYUOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e1KXCV2qgwA=:z2/TGaFaiHhywesc5MvkWQ
 MbndJh75Q0JA4g+3ffjtEe81WgsJEs+FwPJy9vhHY1XFHlWxQ1Ga/uHf2go3pWhcqWtrR7s34
 nnAffXP6JAnIY8FBv8kw/hcsmMsShhd78djxU7pyNW6i6/weJtFmhc7TRDcstTAUP2fdHoCkb
 6BVH7vr+mxMKKOXCabvVz3zhPzWlAJL3xAstJRNvbzPQEqXf6V4lIFtWZLKMPQx5eKtEU6DXO
 yliZOB7L0khFLrgySCB1FihmRDiFo7oEKhmHVIZmuaKPGERT0TjKAfe0FT6t83pj47VbA2qHG
 hJRYLvCuOXGmv0orG3d4qPQKQtnENeYmlAci0R2iOGvLft9/4BXGE80ZIRsJuvl5ZswrCYpg7
 +37tUMnNk0ay3YsK06PtNPD19L+DpDRzvSNRS0fqEPfn/e0Bms7HezLNDWkYs02mOaUVgM/AD
 E29yCVjFDsILgUBuB4B1HGHbcWqWdsJ33WYI900av2QM9Z/a5Uc/ArHhOIb/3nBor7XtJ2Lc0
 CcGbI1ggUA5M77LeryX37p0LGo9aw1uYTxEjMee18fHuJ+4U2iyAmzJwFsQkOlGxZB2G6KF/Y
 srmQPsjAfTup2SCLqWDY6cI+U4Ch53wlLraIHGmTL8uK0H/+vaTjlJ3+0rI7BBeAhLWbMufgX
 Sakk2SfZK/JCHMyQn/9ymlpZvif6i6C0zG8Bz9Y/2xNcgvh2+IOBAPHxtHNQ9oRSgtaiy66QQ
 CUNpeeEGn9Dq+CLG8btueBGtb3ON0kncTWxRYsVhdX5F9i2idejmoq7JyIfYWnXj56Nte6Wr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294667>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Changes since v1:
  - Re-order the patches
  - t6038; use crlf on all platforms
    This did actually not break anything (without old 7/10)
    Adapt the commit message
  - ce_compare_data():
    Simplify the logic around free() in has_cr_in_index(),
    Thanks Eric Sunshine

Break up the old 10/10 series about CLRF handling into smaller
series.

1/10..4/10 are now found in tb/core-eol-fix

This series includes 3 from the 10/10 series:
05/10 read-cache: factor out get_sha1_from_index() helper #now 1/3
10/10 Fix for ce_compare_data(), done right.              #now 2/3
09/10 t6038; use crlf on all platforms                    #now 3/3

The most important patch is 2/3

The reminding 3 patches,
stream-and-early-out,
convert-unify-the-auto-handling-of-CRLF
more-safer-crlf-handling-with-text-attr
Need to be re-done, re-sorted and re-written, thanks for all the commen=
ts.

Torsten B=C3=B6gershausen (3):
  read-cache: factor out get_sha1_from_index() helper
  convert: ce_compare_data() checks for a sha1 of a path
  t6038; use crlf on all platforms

 cache.h                    |  4 ++++
 convert.c                  | 34 ++++++++++++++++++++++------------
 convert.h                  | 23 +++++++++++++++++++----
 read-cache.c               | 33 +++++++++++++++++++++------------
 sha1_file.c                | 17 +++++++++++++----
 t/t6038-merge-text-auto.sh | 37 +++++++++++--------------------------
 6 files changed, 90 insertions(+), 58 deletions(-)

--=20
2.0.0.rc1.6318.g0c2c796
