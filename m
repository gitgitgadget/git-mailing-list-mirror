From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 12/15] index-helper: kill mode
Date: Tue, 19 Apr 2016 19:28:06 -0400
Message-ID: <1461108489-29376-13-git-send-email-dturner@twopensource.com>
References: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 20 01:28:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asf4e-0008QM-Uj
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 01:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbcDSX2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 19:28:49 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34230 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbcDSX2a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 19:28:30 -0400
Received: by mail-qg0-f47.google.com with SMTP id c6so19267793qga.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 16:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XG+WRcaA+KV4DDtXAHYHeVYxJE7GioFiPraYoJ6mTPw=;
        b=w9uH/33nIfpFW2dppZr/2y6Rv1rD0c2Tm5mVf3GHvqKIiYcECNEbrL7JxUW6HlgJCs
         iseJdsbXPw20GP5hqkLTdiOLBddKiFz8Qu6YADdS8n95D/1NKPENWq8eIafZkiA21a/p
         eTTU640XpaY4VIbeO5XS44CA5pyF99dVyceI6cL4s2W5syuwRq2SYhTAZw3YsMHFQAEN
         85J5jzga1TtiPkplbBnnYEg1hh08183JJkQBhL1uABnNWssu6nbHCrylEIrd+dsm6AeS
         8skIW5PBAHsDFCptrufyszhIAlV5v17ivWDZ4P5ERDMbNNp4SLrAxwvHqtqg26N9QAhO
         aysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XG+WRcaA+KV4DDtXAHYHeVYxJE7GioFiPraYoJ6mTPw=;
        b=OqPLIgl0CkQOGS9xKpXJsHfMy7RB4HMaXlbnyuVvpQEELrtnDpEtriYkZxx06TVdrq
         G98eh9wO0sBu5pkCxUDpCPHTJ1dKf2iiQIxFJ+EeiAXYEYhu/APdZMEHbFg02+0x5hZd
         sI1RX8zQeQkMaP39ma/u4Cz95SgClhsGVQDfvRb8iapyhz+4gk2odZskKwilU9wAwgpx
         MnT4Rh1sg+2o4TgHR3i/kyjqoYggpdjSxlZ1M9/e6wEUaQ97i7n0uaNZ3mdwexJO+JHa
         IFCOpkHudw6x9DwcbhskqBbcLRY70wPM6mrntgxm6BXcq7YR61l3MF7sW5WBHokuOUFJ
         A5cQ==
X-Gm-Message-State: AOPr4FVCriODpF7ZSoshx18OJ9PhLLlIAowOAS0Tn7X9HSvwJeLPjCoM2smx9rx220tPOg==
X-Received: by 10.140.250.5 with SMTP id v5mr7603139qhc.9.1461108508971;
        Tue, 19 Apr 2016 16:28:28 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id h34sm29879663qge.30.2016.04.19.16.28.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2016 16:28:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461108489-29376-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291963>

Add a new command (and command-line arg) to allow index-helpers to
exit cleanly.

This is mainly useful for tests.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-index-helper.txt |  3 +++
 index-helper.c                     | 31 ++++++++++++++++++++++++++++++-
 t/t7900-index-helper.sh            |  9 +++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-index-helper.txt
index dd039a1..7d80638 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -37,6 +37,9 @@ OPTIONS
 --detach::
 	Detach from the shell.
 
+--kill::
+	Kill any running index-helper and clean up the socket
+
 NOTES
 -----
 
diff --git a/index-helper.c b/index-helper.c
index 9d85a7c..6af01c9 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -327,6 +327,8 @@ static void loop(int fd, int idle_in_seconds)
 					 * alive, nothing to do.
 					 */
 				}
+			} else if (!strcmp(command.buf, "die")) {
+				break;
 			} else {
 				warning("BUG: Bogus command %s", command.buf);
 			}
@@ -357,10 +359,29 @@ static const char * const usage_text[] = {
 	NULL
 };
 
+static void request_kill(void)
+{
+	int fd = unix_stream_connect(git_path("index-helper.sock"));
+
+	if (fd >= 0) {
+		write_in_full(fd, "die", 4);
+		close(fd);
+	}
+
+	/*
+	 * The child will try to do this anyway, but we want to be
+	 * ready to launch a new daemon immediately after this command
+	 * returns.
+	 */
+
+	unlink(git_path("index-helper.sock"));
+	return;
+}
+
 int main(int argc, char **argv)
 {
 	const char *prefix;
-	int idle_in_seconds = 600, detach = 0;
+	int idle_in_seconds = 600, detach = 0, kill = 0;
 	int fd;
 	struct strbuf socket_path = STRBUF_INIT;
 	struct option options[] = {
@@ -369,6 +390,7 @@ int main(int argc, char **argv)
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
+		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
 		OPT_END()
 	};
 
@@ -383,6 +405,13 @@ int main(int argc, char **argv)
 			  options, usage_text, 0))
 		die(_("too many arguments"));
 
+	if (kill) {
+		if (detach)
+			die(_("--kill doesn't want any other options"));
+		request_kill();
+		return 0;
+	}
+
 	atexit(cleanup);
 	sigchain_push_common(cleanup_on_signal);
 
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
index 114c112..e71b5af 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -20,4 +20,13 @@ test_expect_success 'index-helper smoke test' '
 	test_path_is_missing .git/index-helper.sock
 '
 
+test_expect_success 'index-helper creates usable path file and can be killed' '
+	test_when_finished "git index-helper --kill" &&
+	test_path_is_missing .git/index-helper.sock &&
+	git index-helper --detach &&
+	test -S .git/index-helper.sock &&
+	git index-helper --kill &&
+	test_path_is_missing .git/index-helper.sock
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
