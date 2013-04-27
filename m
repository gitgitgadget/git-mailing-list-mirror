From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/11] completion: document tilde expansion failure in tests
Date: Sat, 27 Apr 2013 05:19:45 -0500
Message-ID: <1367057994-19887-3-git-send-email-felipe.contreras@gmail.com>
References: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 12:21:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW2GT-0003W0-SF
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 12:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728Ab3D0KVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 06:21:25 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:57127 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595Ab3D0KVR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 06:21:17 -0400
Received: by mail-oa0-f48.google.com with SMTP id f4so4726585oah.35
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=NBWDV1exrdDkekmso1xqtLYVg+qaqexBc+Qz7AoV7I0=;
        b=SjRCq3emVkdBZ7F7r/1UV/Bnh395657mXqhJ0+WZNzV7RIT6aQZc33fDyRvjZ+BxH7
         Ww8AOq4mw3+Ix1eb+FyFwNipg6q1WPNvHbXeQcAMqtjJihzPKH7TQe2D+bLTRDsSMdq9
         PtDl/YVID7s78zG4kw0sRJXCAttO5dKBQZPkABeWI82MvtmVlurHg1Svp8kn5fII7WBo
         Vy85OqWslLh/1fk3AClytyhE7fK6A7QZKjtq37qAicSj/5qAE2z1eb0X5pCQghGEohwB
         m4Gxip7tWFVpkz5qy+ONw1DWBCyt2mAlKFi5moMH/ij0VW5jhDYXCvv+xrWR4poWRS7V
         b47Q==
X-Received: by 10.182.120.134 with SMTP id lc6mr1243929obb.34.1367058077387;
        Sat, 27 Apr 2013 03:21:17 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id qt5sm12075404oeb.4.2013.04.27.03.21.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 03:21:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367057994-19887-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222633>

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
