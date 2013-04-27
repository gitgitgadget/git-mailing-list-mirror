From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/9] completion: use __gitcompadd for __gitcomp_file
Date: Sat, 27 Apr 2013 15:10:02 -0500
Message-ID: <1367093407-8898-5-git-send-email-felipe.contreras@gmail.com>
References: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 22:11:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWBTH-0000Il-Lf
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 22:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756377Ab3D0ULi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 16:11:38 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:43265 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756266Ab3D0ULh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 16:11:37 -0400
Received: by mail-ob0-f173.google.com with SMTP id xn12so4500631obc.18
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=zvj66VWhRy6mzQXQOdfA6Uu6hCIzEk+ziq+vXi/u/N4=;
        b=oWb8qlN8iNbYytKNKbMn+L/NnhhGQJnLFuCXd0VTcqNGQQYqgZPrsdTVAHFoKOGwby
         ZhoScrrG1XSE9AAj/yTgDmj809wediySKr0pQ4WUu6mhFE34T1O5x6pJIJOhiiZ66in/
         hoWLsSJ+Vnxe4IgsVSe2kdMpiG4ONzisL+N1ve7coPmFuIH7DNgGN1XLDoQLmtoLqNJq
         Bb9+x7HKDW79U687DZNooY+rJ7JOufBsrqpYGHvRDlf5C7CoRObYX/p1k7N7OYFvZJfO
         5TLUz1bKiDpO50/6w+m2zDA9E3WArOv0b8+L3+7g87qVWrKIhzmQUUIwqWxoHiUNj84b
         KvKQ==
X-Received: by 10.60.125.161 with SMTP id mr1mr7898662oeb.24.1367093497436;
        Sat, 27 Apr 2013 13:11:37 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b2sm13341220oby.5.2013.04.27.13.11.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 13:11:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222687>

Like the rest of the script does; let's not access COMPREPLY directly.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f7b0f3c..7f1ebe4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -252,7 +252,7 @@ __gitcomp_file ()
 	# since tilde expansion is not applied.
 	# This means that COMPREPLY will be empty and Bash default
 	# completion will be used.
-	COMPREPLY=($(compgen -P "${2-}" -W "$1" -- "${3-$cur}"))
+	__gitcompadd "$1" "${2-}" "${3-$cur}" ""
 
 	# Tell Bash that compspec generates filenames.
 	compopt -o filenames 2>/dev/null
-- 
1.8.2.1.1031.g2ee5873
