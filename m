From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2 1/4] t4014: more tests about appending s-o-b lines
Date: Sun, 02 Dec 2012 08:06:44 +0100
Message-ID: <50BAFE04.4080100@web.de>
References: <CACsJy8BiJRK7N3_HZ2WXpMd1YkDSW00AxuYqiCWJgij+Kq6AiQ@mail.gmail.com> <1353602289-9418-1-git-send-email-pclouds@gmail.com> <1353602289-9418-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 08:07:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tf3du-0004xO-OE
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 08:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458Ab2LBHGv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2012 02:06:51 -0500
Received: from mout.web.de ([212.227.17.12]:61271 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869Ab2LBHGu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 02:06:50 -0500
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb103) with
 ESMTPA (Nemesis) id 0MDgDS-1TQ8sd0a6w-00H9UC; Sun, 02 Dec 2012 08:06:45 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <1353602289-9418-2-git-send-email-pclouds@gmail.com>
X-Provags-ID: V02:K0:lHSokcHyrI7DDajF0njSeRcnPI6OVTLlPV6WTkkxl+X
 ZtZ2pFMgk8PtTxt3sLTCL7zOsVU+9QLT0Yv8YvahD28rutwiFw
 qJ3ZZE9AsfLEASW9igvtYyvvD1priM701TAdOziJjdXn90ZgG5
 OD3lDT8C1wpGy76y7hFhrn1twjMW2pqonuf2ec2s7jfxN1nGFV
 mYF75LfVpgH0FhwN0izgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211002>

On 22.11.12 17:38, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  t/t4014-format-patch.sh | 145 ++++++++++++++++++++++++++++++++++++++=
++++++++++
>  1 file changed, 145 insertions(+)
> +	echo -n subject | append_signoff >actual &&


"echo -n" is not portable, and we use printf everywhere.=20
I found one "echo -n" in line  996.

Can we squeeze that in, before going to next?

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 6cfad13..f460930 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -993,7 +993,7 @@ EOF
 '
=20
 test_expect_success 'signoff: commit with only subject that does not e=
nd with NL' '
-       echo -n subject | append_signoff >actual &&
+       printf subject | append_signoff >actual &&
        cat >expected <<\EOF &&
 4:Subject: [PATCH] subject
 8:
