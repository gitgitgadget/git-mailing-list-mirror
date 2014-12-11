From: Florian Hassanen <florian.hassanen@gmail.com>
Subject: [PATCH] git-check-ignore.txt: Clarify exit codes
Date: Thu, 11 Dec 2014 19:42:35 +0100
Message-ID: <1418323355-23935-1-git-send-email-florian.hassanen@gmail.com>
Cc: Florian Hassanen <florian.hassanen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 19:42:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xz8hQ-0003Vp-Uu
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 19:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757271AbaLKSms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 13:42:48 -0500
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35719 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbaLKSms (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 13:42:48 -0500
Received: by mail-wg0-f41.google.com with SMTP id y19so7207436wgg.28
        for <git@vger.kernel.org>; Thu, 11 Dec 2014 10:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=h+Zv7hqktkQbgOacOTm+BrOwzVfsMXaymhztHXnCmqk=;
        b=aYsna3QQy8Imgo4/yI+vPahQ3nKs80OCl+zDr62CyvtKAruBw4C6xT8H1/j+RMuKOu
         im9lN1v8Or6huG7y2yIz0csUSF9VMQVnhTNxhIgNNVn/28tafrQITAemid5imoNYXaeq
         Yc7FA1AzSm548yweLTqfwSF8rjG38xga8RJt8aJSU3vJCjppvet4D4x9nxRj+12sgeLn
         5DyfQaFedJoxX2v5mOCtNKnwxlA8qGAm4ZqMrt6UiL6RfKWOjHCyt9Xf2zCgJ1rymVYu
         /T31InZjdj5bAtLEFwPLftpIrQE4FjiXLDV7FTeNDMaEQCOGsEml+6OJK3oFLVcHbvgg
         aZSQ==
X-Received: by 10.180.109.45 with SMTP id hp13mr676804wib.4.1418323367064;
        Thu, 11 Dec 2014 10:42:47 -0800 (PST)
Received: from localhost.localdomain ([84.113.191.94])
        by mx.google.com with ESMTPSA id qg11sm235790wic.17.2014.12.11.10.42.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Dec 2014 10:42:46 -0800 (PST)
X-Mailer: git-send-email 2.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261286>

check-ignore disregards whether a path is matched by a
positive or negative pattern. Thus for a file that is _not_
ignored, but is captured by negative pattern in .gitignore,
the exit code is 0. The docs suggested otherwise.

Clarify docs to explain that only the match matters, not
whether the path is actually ignored or not.

Signed-off-by: Florian Hassanen <florian.hassanen@gmail.com>
---
Today when working with the check-ignore command, I misunderstood
the docs into thinking, that I could use check-ignore's exit code
to determine, whether a file is ignored or not - but this is not
how the exit code works :(
Here is a suggestion, on how to update the docs to describe the 
exit code's behavior more clearly.

 Documentation/git-check-ignore.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index ee2e091..bdd8b7c 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -97,10 +97,11 @@ EXIT STATUS
 -----------
 
 0::
-	One or more of the provided paths is ignored.
+	At least one of the provided paths matches some (possibly negative)
+	pattern.
 
 1::
-	None of the provided paths are ignored.
+	None of the provided paths match any pattern.
 
 128::
 	A fatal error was encountered.
-- 
2.1.3
