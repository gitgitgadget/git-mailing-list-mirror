From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/34] git-stash: avoid hardcoding $GIT_DIR/logs/....
Date: Sun, 30 Nov 2014 15:24:39 +0700
Message-ID: <1417335899-27307-15-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:28:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuzrS-00088a-RC
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:28:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbaK3I2B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:28:01 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35377 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbaK3I2A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:28:00 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so9144085pac.39
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Nr8luJUZCe5dqtYDTuMd7FbMHEgLImZLII/Np/BRxrU=;
        b=AQ+W6isw8JRz056qoEqayavcObXN4GWSgkkoXb/VlrC5O+VNaOOo0YTBJ2YV81oU/F
         JDfciev0bL/YLhbyvDfWE16vgQyJH0l98iTn0aIPV1VTZOLpN+Gm+RMxhwFXHlHEwtRb
         oHsF9sPl3wbMRNKj5RuCRDHOPe/A+/9rmnpOUmeZ6K38G+qIEfO0I21e9VyvWxc38BDR
         SZe7vD9IcZfWbbR7E+EzLB98BlRTjGs0IRXKp7B27+Y6N155mxG/xauJOAPgkEbGp+/C
         wbOuoPedV52Qf+ilmeCDhTJvdYn/hjDOCu0va7ZwZpS1TDqxEjZfaAlBJLYHwGxmUIaw
         sHaQ==
X-Received: by 10.68.211.104 with SMTP id nb8mr36208297pbc.29.1417336079946;
        Sun, 30 Nov 2014 00:27:59 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id ki6sm14311356pdb.85.2014.11.30.00.27.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:27:59 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:27:57 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260401>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 git-stash.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index b6d4b06..6846b18 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -184,7 +184,7 @@ store_stash () {
 	fi
=20
 	# Make sure the reflog for stash is kept.
-	: >>"$GIT_DIR/logs/$ref_stash"
+	: >>"$(git rev-parse --git-path logs/$ref_stash)"
 	git update-ref -m "$stash_msg" $ref_stash $w_commit
 	ret=3D$?
 	test $ret !=3D 0 && test -z $quiet &&
@@ -259,7 +259,7 @@ save_stash () {
 		say "$(gettext "No local changes to save")"
 		exit 0
 	fi
-	test -f "$GIT_DIR/logs/$ref_stash" ||
+	test -f "$(git rev-parse --git-path logs/$ref_stash)" ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
=20
 	create_stash "$stash_msg" $untracked
--=20
2.1.0.rc0.78.gc0d8480
