From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/9] completion: document tilde expansion failure in tests
Date: Sat, 27 Apr 2013 15:10:00 -0500
Message-ID: <1367093407-8898-3-git-send-email-felipe.contreras@gmail.com>
References: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 22:11:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWBT7-00008y-PR
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 22:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216Ab3D0ULd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 16:11:33 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:48952 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756117Ab3D0ULb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 16:11:31 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp18so4409320obc.6
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=NBWDV1exrdDkekmso1xqtLYVg+qaqexBc+Qz7AoV7I0=;
        b=vaR2h66psTc6WVMuWyoh0vszu/A//pNq3BQm0fjZY7xyCFgg1huQM0gRiQpKGdJyWn
         hfQvNWwsL8FpI9inPeDRo6dLNzBwsKtCmoXE8CIHN3KrcEFU7pF3VpNuyJZd12UKTgT4
         50oqUEP/uYcezGF+blZsGlB152EqQouOQs+EkPWkFsYSeqkfpe7igqowcLNFu3h+w7G1
         HXClTzaWsbyijRmy3PKZrKHVq+Qc+W9rfjsMsfumgjRYZ9V597jaWAbVfAhwT9zCldvV
         rXVPZEivvbtiLmcgt7LHkgbsiWZlsRi+fivh8VPFnANvW1LPsq+NZ00c5nJ6TOuryJGn
         W8kg==
X-Received: by 10.182.14.39 with SMTP id m7mr24669608obc.96.1367093491116;
        Sat, 27 Apr 2013 13:11:31 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ns4sm13344459obc.2.2013.04.27.13.11.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 13:11:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222683>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 385e1e4..81a1657 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -415,4 +415,13 @@ test_expect_success 'complete files' '
 	test_completion "git add mom" "momified"
 '
 
+test_expect_failure 'complete with tilde expansion' '
+	git init tmp && cd tmp &&
+	test_when_finished "cd .. && rm -rf tmp" &&
+
+	touch ~/tmp/file &&
+
+	test_completion "git add ~/tmp/" "~/tmp/file"
+'
+
 test_done
-- 
1.8.2.1.1031.g2ee5873
