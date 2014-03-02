From: Guanglin Xu <mzguanglin@gmail.com>
Subject: [PATCH] branch.c: change install_branch_config() to use skip_prefix()
Date: Sun,  2 Mar 2014 19:52:27 +0800
Message-ID: <1393761147-13590-1-git-send-email-mzguanglin@gmail.com>
Content-Type: text/plain; charset="utf-8"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 12:53:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WK4x5-0007Ca-Jv
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 12:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbaCBLw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 06:52:56 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36354 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbaCBLwz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 06:52:55 -0500
Received: by mail-pa0-f51.google.com with SMTP id kq14so2660181pab.38
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 03:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:content-type;
        bh=4rCfIa5Nmvg4yQ5k0YG2kfj7KKQJGYr65H7YFbUXe70=;
        b=tOz2QTn9gsD1EQLs3/SK5Myh3zi5MBsUZJbFuhtK5+ETUFEg0xksL+hRDyFbrXstOO
         5qu4oRG9egB6AThp8JFK9rLybeGXxGuzHDbB9rESHppbzIXLQF1MV7Wrl2WWFrCW5cnp
         4kR4KUji9PDQqLpf+3hJ3JZ1P04BKOIG/HCnEdvtcySv9yxA53vo6Zc4ezfMzXR0qil8
         SrSzOxw+QSFb6FY5xxziUaiCGC2Mdt/+oXk3w9SRPca40HNjAIFmNWQaOJAdEuhHeXNT
         T2reTEiAEZTuykS8mo+cLXymE9VZ8sSb/qEEONUQNE35IIZMacVzrdFiqeatIHi59KK3
         agLg==
X-Received: by 10.69.31.171 with SMTP id kn11mr13861239pbd.47.1393761174559;
        Sun, 02 Mar 2014 03:52:54 -0800 (PST)
Received: from localhost.localdomain ([113.107.25.71])
        by mx.google.com with ESMTPSA id qf7sm60023900pac.14.2014.03.02.03.52.52
        for <git@vger.kernel.org>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Mar 2014 03:52:54 -0800 (PST)
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243147>

GSoC2014 Microproject: according to the idea#2 for microprojects, change install_branch_config() to use skip_prefix() and make it conform to the usage of previous starts_with().

Signed-off-by: Guanglin Xu <mzguanglin@gmail.com>
---
 branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/branch.c b/branch.c
index 723a36b..ca4e824 100644
--- a/branch.c
+++ b/branch.c
@@ -50,7 +50,7 @@ static int should_setup_rebase(const char *origin)
 void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
 	const char *shortname = remote + 11;
-	int remote_is_branch = starts_with(remote, "refs/heads/");
+	int remote_is_branch = (NULL != skip_prefix(remote ,"refs/heads/"));
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
 
-- 
1.9.0

Hi,
I am Guanglin Xu. I plan to apply for GSoC 2014.
