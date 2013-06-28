From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/4] completion: add completer for status
Date: Fri, 28 Jun 2013 19:48:06 +0530
Message-ID: <1372429088-385-3-git-send-email-artagnon@gmail.com>
References: <1372429088-385-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 28 16:21:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsZYR-0001hh-Bv
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 16:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430Ab3F1OVb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jun 2013 10:21:31 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:33610 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194Ab3F1OVa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 10:21:30 -0400
Received: by mail-pb0-f42.google.com with SMTP id un1so2330462pbc.29
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QUlXH+swlpFR+BWVL1btOXycxNBKOWdHBBkyuozaRdY=;
        b=wAWCF7K0JobtZ91hbYCbRt8QgSXbtNmVMHyX/DbXXYjIyevvA5rb5BehBeiXQR8C6M
         4M2eDIQU4zNkRb4p5pqgaOSnp5ikZALP/afaC+wSKoYFFpZUhDcnQfTysMnAxLLBM14n
         xNnUAYtA00/ktM5mU1KmLvjA5414fJ36wjbPGS0b1jgRUV6l/1oEMlZQ7daXZfd+8VsQ
         l6EfQ3kXgeX+ZumOCdX7RVwyWqxPRk2rw+dRj1BzqKe1mGmeays0aE6aNJxk4Ly7t024
         gV0zO0OKjjNoYQOVjuLUVqszHsO0Ykq7rjpyTbsn427sUOFQ6H6QtjyJoy63CG+Ny1DK
         TGcA==
X-Received: by 10.68.184.100 with SMTP id et4mr11770147pbc.48.1372429290219;
        Fri, 28 Jun 2013 07:21:30 -0700 (PDT)
Received: from localhost.localdomain ([122.164.185.186])
        by mx.google.com with ESMTPSA id iq6sm8397665pbc.1.2013.06.28.07.21.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 07:21:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.585.g9832cb9
In-Reply-To: <1372429088-385-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229204>

Helped-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 27 ++++++++++++++++++++++++++=
+
 1 file changed, 27 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index b51c9e3..278018f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1699,6 +1699,33 @@ _git_stage ()
 	_git_add
 }
=20
+_git_status ()
+{
+	case "$cur" in
+	--untracked-files=3D*)
+		__gitcomp "no normal all" "" "${cur##--untracked-files=3D}"
+		return
+		;;
+	--ignore-submodules=3D*)
+		__gitcomp "none untracked dirty all" "" "${cur##--ignore-submodules=3D=
}"
+		return
+		;;
+	--column=3D*)
+		__gitcomp "always never auto column row plain dense nodense" "" "${c=
ur##--column=3D}"
+		return
+		;;
+	--*)
+		__gitcomp "
+			--short --branch --long --porcelain --ignored
+			--untracked-files --ignore-submodules --column
+			--untracked-files=3D --ignore-submodules=3D --column=3D
+			"
+		return
+		;;
+	esac
+	__git_complete_index_file "--with-tree=3DHEAD --cached --others"
+}
+
 __git_config_get_set_variables ()
 {
 	local prevword word config_file=3D c=3D$cword
--=20
1.8.3.1.585.g9832cb9
