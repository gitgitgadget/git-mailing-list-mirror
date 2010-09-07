From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 14/20] gettextize: git-am eval_gettext messages
Date: Tue,  7 Sep 2010 16:48:28 +0000
Message-ID: <1283878113-19533-5-git-send-email-avarab@gmail.com>
References: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 18:51:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot1OA-0004K7-Qo
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 18:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147Ab0IGQtp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 12:49:45 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65530 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081Ab0IGQtn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 12:49:43 -0400
Received: by wyf22 with SMTP id 22so4443062wyf.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 09:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=gmSmgkoaLl/wpHh7RBKC3Y2GCQ4qlTju8StNh9RvORE=;
        b=RnmUIVRxMJdW0l9QTLkYijNNseUhYHTdXOLyIsJMbjY+kenZZ14JzME6E4C1Vqo4ng
         k4EeaZMieAPcu4xJgDy4IN4ndqrM79XupVm1Bwv5wxSNwouDH7vBMQ2Rl7gxNgNNf4e6
         E3TNWQoE+T5+S9F6qd9ZL6YvNdFtfBV6PGqeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lvUh+IWW2fniUr56s33hTULnZOFVrSrHN9c1D9IY5tjs+n/S1yi6+AREIgjfhunhKo
         kdxfmnGbNDlxm2tQz7STxUrqOp8qn22Ka4YloST5pzYjr3fD8WoPXR2JghHzhlCEpcKJ
         NY7iEd+JjtfNsiHtF6pHILlCdHubviWAmHqDw=
Received: by 10.227.146.4 with SMTP id f4mr20231wbv.14.1283878182601;
        Tue, 07 Sep 2010 09:49:42 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k46sm4304936weq.34.2010.09.07.09.49.39
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 09:49:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283877955-19105-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155727>

Messages that use variables to be interpolated need to use
eval_gettext(), this wrapper will eval the message and expand the
variable for us.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-am.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 73a4046..98819e6 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -77,9 +77,9 @@ stop_here_user_resolve () {
 	    printf '%s\n' "$resolvemsg"
 	    stop_here $1
     fi
-    echo "When you have resolved this problem run \"$cmdline --resolve=
d\"."
-    echo "If you would prefer to skip this patch, instead run \"$cmdli=
ne --skip\"."
-    echo "To restore the original branch and stop patching run \"$cmdl=
ine --abort\"."
+    eval_gettext "When you have resolved this problem run \"\$cmdline =
--resolved\".
+If you would prefer to skip this patch, instead run \"\$cmdline --skip=
\".
+To restore the original branch and stop patching run \"\$cmdline --abo=
rt\"."; echo
=20
     stop_here $1
 }
@@ -592,9 +592,9 @@ do
 			go_next && continue
=20
 		test -s "$dotest/patch" || {
-			echo "Patch is empty.  Was it split wrong?"
-			echo "If you would prefer to skip this patch, instead run \"$cmdlin=
e --skip\"."
-			echo "To restore the original branch and stop patching run \"$cmdli=
ne --abort\"."
+			eval_gettext "Patch is empty.  Was it split wrong?
+If you would prefer to skip this patch, instead run \"\$cmdline --skip=
\".
+To restore the original branch and stop patching run \"\$cmdline --abo=
rt\"."; echo
 			stop_here $this
 		}
 		rm -f "$dotest/original-commit" "$dotest/author-script"
--=20
1.7.2.3.313.gcd15
