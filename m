From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] am: quote string for translation before passing to eval_gettextln
Date: Wed, 22 Aug 2012 21:48:03 +0700
Message-ID: <1345646883-18746-1-git-send-email-pclouds@gmail.com>
References: <20120822141726.GA674@mannheim-rule.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 16:54:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4CK6-0004Az-J7
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 16:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869Ab2HVOyP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Aug 2012 10:54:15 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:41597 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab2HVOyN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 10:54:13 -0400
Received: by ghrr11 with SMTP id r11so744020ghr.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0xR028W5Y3H7c9DmtFDLCL81x6dwFEV9UiYw6AMKdm4=;
        b=W58lH/HrDFfGCT8RVz96EGWpw5pkvRFDBUHb6P/kEpMGun7JxHLh3zsFHnYxskOcFa
         n4/Ygzj1EdFe0oUnRKuZvFby2PIo6zK2Y2C9VLjOZC1hda/s46nnOGKFD3LpNdkvOzzV
         n+WXz+okKGMbkVVZmCqbnoSoQjGs1lpmpdeXI0lB7TSQSX+gw6eE6jd+s7jNErI9sAVv
         SljrAiEWDROSn002goF7Pile+Xk5B0lKntJ+JQcxlKeTv7Col26LXZI4jGUVJjyPJYKB
         RNrc4umY9a4tfDsabDApwluEKM99Tz9cYu/lRWjmUBgwwAvjUB+LxVfruOV/14f108Tl
         IPIg==
Received: by 10.68.237.38 with SMTP id uz6mr48110248pbc.23.1345647252845;
        Wed, 22 Aug 2012 07:54:12 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.35.79])
        by mx.google.com with ESMTPS id ro7sm3881438pbc.8.2012.08.22.07.54.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Aug 2012 07:54:10 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 22 Aug 2012 21:48:08 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <20120822141726.GA674@mannheim-rule.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204019>

If it's not quoted, the string is expanded before it gets looked up in
gettext database and obviously nothing is returned.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Wed, Aug 22, 2012 at 9:17 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
 > Nguyen Thai Ngoc Duy wrote:
 >
 >> which means git performed a lookup on that string. It is from git-a=
m.sh:
 >>
 >> eval_gettextln "The copy of the patch that failed is found in:
 >>    $dotest/patch"
 >
 > Good catch.  It should use single-quotes.

 Yep. Verified. Also checked that no other places have this problem.
 xgettext probably detects this too. Without this patch it does not
 collect this string. With this patch, it does.

 git-am.sh | 4 ++--
 1 t=E1=BA=ADp tin =C4=91=C3=A3 b=E1=BB=8B thay =C4=91=E1=BB=95i, 2 =C4=
=91=C6=B0=E1=BB=A3c th=C3=AAm v=C3=A0o(+), 2 b=E1=BB=8B x=C3=B3a(-)

diff --git a/git-am.sh b/git-am.sh
index bd9620c..c682d34 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -855,8 +855,8 @@ did you forget to use 'git add'?"
 		eval_gettextln 'Patch failed at $msgnum $FIRSTLINE'
 		if test "$(git config --bool advice.amworkdir)" !=3D false
 		then
-			eval_gettextln "The copy of the patch that failed is found in:
-   $dotest/patch"
+			eval_gettextln 'The copy of the patch that failed is found in:
+   $dotest/patch'
 		fi
 		stop_here_user_resolve $this
 	fi
--=20
1.7.12.rc2.18.g61b472e
