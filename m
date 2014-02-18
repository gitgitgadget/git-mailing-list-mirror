From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 13/25] git-stash: avoid hardcoding $GIT_DIR/logs/....
Date: Tue, 18 Feb 2014 20:40:02 +0700
Message-ID: <1392730814-19656-14-git-send-email-pclouds@gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 14:41:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFkvm-0007tj-7E
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 14:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710AbaBRNlj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 08:41:39 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:59222 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693AbaBRNlc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 08:41:32 -0500
Received: by mail-pa0-f42.google.com with SMTP id kl14so16871705pab.1
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 05:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0kiaLC6mmg1IOeLN1yNZDAkgXTQfMQ3zsukAQgVIYf4=;
        b=b0LqPJzVd0VEU9RShWk34hMObjGQKOBSPviCmCLUxsdznHIbTdqoEBjyqs1rEV7gTS
         dNN5dEwDVV/LgstJdhYKAN1Wv04khaNWacTG9ZI4xBnDn4Ii5hZwrRXIRnH2EMxCvhuH
         /aen+lFEDmM3sTk0iB7X3QL3wt70jRh2NZwT/nPJ9rGMOXs3PsKEzeYU87fqltJ7dxJV
         HSEyB5kc6z5l08jcLOmtCWrNe3gUnNmXj64KfG/RGIWBEdRcfCPFwXReC21eprriKHss
         xxfIJ0CbojvXcKUqykq8jOU79bfoMQq8w+JMLFU7E7SpsfyHAZbdA6lAzn2Iy4hk8333
         0gYg==
X-Received: by 10.68.218.65 with SMTP id pe1mr32930953pbc.1.1392730892193;
        Tue, 18 Feb 2014 05:41:32 -0800 (PST)
Received: from lanh ([115.73.228.211])
        by mx.google.com with ESMTPSA id rb6sm56082258pbb.41.2014.02.18.05.41.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 05:41:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 18 Feb 2014 20:41:45 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242311>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-stash.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index ae7d16e..12d9b37 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -183,7 +183,7 @@ store_stash () {
 	fi
=20
 	# Make sure the reflog for stash is kept.
-	: >>"$GIT_DIR/logs/$ref_stash"
+	: >>"`git rev-parse --git-path logs/$ref_stash`"
 	git update-ref -m "$stash_msg" $ref_stash $w_commit
 	ret=3D$?
 	test $ret !=3D 0 && test -z $quiet &&
@@ -258,7 +258,7 @@ save_stash () {
 		say "$(gettext "No local changes to save")"
 		exit 0
 	fi
-	test -f "$GIT_DIR/logs/$ref_stash" ||
+	test -f "`git rev-parse --git-path logs/$ref_stash`" ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
=20
 	create_stash "$stash_msg" $untracked
--=20
1.8.5.2.240.g8478abd
