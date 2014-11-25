From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] t1402: check to delete broken refs
Date: Tue, 25 Nov 2014 14:56:06 -0800
Message-ID: <1416956166-20341-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: mhagger@alum.mit.edu, gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 23:56:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtP1q-0000ru-KO
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 23:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbaKYW4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 17:56:11 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:39160 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbaKYW4J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 17:56:09 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so1578032ieb.12
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 14:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vDVk3de4NBADu8yQFe378emxZ7BtUCJt7RlLDJJzZXo=;
        b=BDrDtdKbZKulTzusr/55nIou8DbZocHEy/dVTrg5NyKAw2WO/x/+zrxs1wx0tzAz2P
         YtigYpls3ugxwaNjDYi+hHNGAAPfSkiWBLwDkRDnwetMvvyl086u35OPojIIvQlzpwgw
         5RUY7xu7DM96fVQreNyE8YyKn27WpTwIOCUmjXmYlRHA3NLHXJlyvdNiJ32xYPJVXlMf
         Z+jHNXQ0A5E2K3UFlr7EUGWFeDBk/l5K0uFyv+b3dGMVRJQmUB1yjSMOyyq0vLDRKQpn
         GRix7xzQfU+nhH0ySZZC0yTLoMNIOQMEgUbK4x+vyNaxvaNtVosbo7JQwMvfJ4Tb5Y5u
         eWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vDVk3de4NBADu8yQFe378emxZ7BtUCJt7RlLDJJzZXo=;
        b=AU7r4CTPkqOC6na+FnXAnJbCY9WkMsHYG9/6X1rEpITQLBEow9WmJ50FenmOTthNVa
         QhmfiAW5L9ZiEJPdwdUxev/x0u4ZIqpI3OK/ct11X7yfO40IUVBKPlKDLWSi0a3KAlYm
         D9TGtDmZ0Mq9/o17APCwoL0+XgUTDKgY2q7CELWw2ht0KdQ7D6D6A1pl4x+1PCZY6I3v
         TEkiGGK0G3t4vuSezxx1NJcLBNJAGSGoaNakwqEuN/v7vtlxt+bYIxPpOUjZ0vvibty3
         i4kA5wAWbnXnhVe5DmDybq1C/3PQyhdLmmv4s7QfRkob7RTAEETnEp9q9vGs/S1yLN3N
         B1mw==
X-Gm-Message-State: ALoCoQnaj+m318xOUQHrljb/w+ttw0+8Dm7hA8dxPj+ZR+nzZa7x9pT3ufF3Uce07pme9Pl+BQtK
X-Received: by 10.43.132.137 with SMTP id hu9mr30773552icc.27.1416956169183;
        Tue, 25 Nov 2014 14:56:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:79de:6365:bed8:92ea])
        by mx.google.com with ESMTPSA id oq6sm6748135igb.2.2014.11.25.14.56.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Nov 2014 14:56:08 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260249>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 
 This was also part of the ongoing series from Ronnie.
 But I think the patch in this form is rather independant, 
 documenting the current state of "git branch -d", so it's 
 fine to have it in now.

 t/t1402-check-ref-format.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index e5dc62e..08af156 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -197,4 +197,12 @@ invalid_ref_normalized 'heads///foo.lock'
 invalid_ref_normalized 'foo.lock/bar'
 invalid_ref_normalized 'foo.lock///bar'
 
+test_expect_failure 'git branch -d can delete ref with broken sha1' '
+	echo "pointing nowhere" > .git/refs/heads/brokensha1 &&
+	test_when_finished "rm -f .git/refs/heads/brokensha1" &&
+	git branch -d brokensha1 &&
+	git branch >output &&
+	! grep -e "brokensha1" output
+'
+
 test_done
-- 
2.2.0.rc3
