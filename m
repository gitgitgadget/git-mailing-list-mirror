From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 12/16] index-helper: kill mode
Date: Wed,  6 Apr 2016 18:11:58 -0400
Message-ID: <1459980722-4836-13-git-send-email-dturner@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
X-From: git-owner@vger.kernel.org Thu Apr 07 00:13:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anvhB-0004rp-Kb
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 00:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbcDFWNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 18:13:00 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33993 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205AbcDFWMt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 18:12:49 -0400
Received: by mail-qg0-f52.google.com with SMTP id c6so48312779qga.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 15:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N5TSp4ZOaju8vhrj8jMLZDO/0RR0Ifa7yd+MJZwjFgE=;
        b=WpLwlM3O3QJJ86r64z0o/rlcxxgoyLQWpbtb8IF3byJXAaSHnHBgApagNc9WNKbAPs
         zhZZiTNQPeYBFWlIUc97atWqp0v783whFbj0AOjf6kO7hTuT5UyuSu5mpngVlt2S2rDG
         9NjKxvJYVy4XP1SmIwwTMmrB7zFNebp6v1obfzn+jV1eBnP1nrcjwxs/aax8E6VJ+t/u
         YAKuA36bcvLgKjAaLcrlEXBNWxrpZd7mkSqJWlANN33A7GDPDwyimlvFkqffzdhfhnHc
         RE0cjgnN5uQQV9HpB6YoDUFmsgvs1JnKX+qtcJgMJUgCkP+38XaoFYlmw6Pjvl8/j8hx
         GOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N5TSp4ZOaju8vhrj8jMLZDO/0RR0Ifa7yd+MJZwjFgE=;
        b=ciVo4+81jdxcUhlnva/dusW/NLEgmdFUAJga7GhztnJ0R8zUMaj+SxdvLaqM3nwRKX
         Se9xKgC9vc92svx1yCJiAWRmEA7odQ6k/Rh4ImSyWbYYDLLdaBoulpfxwGrfgHuVeBCh
         cLs+vurV2MuvqRqseHA58Nx/oFLwoVd2DkRZVXI84tRLGGTBPvffvoUSCDxCh/XFd6BX
         a9TUYsup89G2tvi8lmmIBZLxe4WXXPJfu/o1S3yYhPOq4rcXFe+3e5Cjt9sJ5lYbgTEw
         /3tseT1vi66UOqzgvefl/nk21bS2HDhLSYKxjBEBRIpV07V6MzhZjOEuOUPS414eX4ub
         KWkg==
X-Gm-Message-State: AD7BkJL6widpXU1lVcG8nz2cDNV3Y9frssHgtnga1FjVOSevp3swsSm6D7qnK1Gdzy2rpw==
X-Received: by 10.140.248.8 with SMTP id t8mr31191979qhc.50.1459980768235;
        Wed, 06 Apr 2016 15:12:48 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l33sm2165241qge.11.2016.04.06.15.12.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 15:12:47 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290881>

Add a new command (and command-line arg) to allow index-helpers to
exit cleanly.

This is mainly useful for tests.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 index-helper.c          | 31 ++++++++++++++++++++++++++++++-
 t/t7900-index-helper.sh | 13 +++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/index-helper.c b/index-helper.c
index f993ae6..a3f6a74 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -276,6 +276,8 @@ static void loop(int fd, int idle_in_seconds)
 					 * alive, nothing to do.
 					 */
 				}
+			} else if (!strcmp(command.buf, "die")) {
+				break;
 			} else {
 				warning("BUG: Bogus command %s", command.buf);
 			}
@@ -358,10 +360,29 @@ static void make_socket_path(struct strbuf *path)
 	strbuf_addstr(path, "/s");
 }
 
+static void request_kill(void)
+{
+	int fd = connect_to_index_helper();
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
+	unlink(git_path("index-helper.path"));
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
@@ -370,6 +391,7 @@ int main(int argc, char **argv)
 		OPT_BOOL(0, "strict", &to_verify,
 			 "verify shared memory after creating"),
 		OPT_BOOL(0, "detach", &detach, "detach the process"),
+		OPT_BOOL(0, "kill", &kill, "request that existing index helper processes exit"),
 		OPT_END()
 	};
 
@@ -384,6 +406,13 @@ int main(int argc, char **argv)
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
index 6a06094..b1fa96e 100755
--- a/t/t7900-index-helper.sh
+++ b/t/t7900-index-helper.sh
@@ -20,4 +20,17 @@ test_expect_success 'index-helper smoke test' '
 	test_path_is_missing .git/index-helper.path
 '
 
+test_expect_success 'index-helper creates usable path file and can be killed' '
+	test_when_finished "git index-helper --kill" &&
+	test_path_is_missing .git/index-helper.path &&
+	git index-helper --detach &&
+	test -L .git/index-helper.path &&
+	sock="$(readlink .git/index-helper.path)" &&
+	test -S "$sock" &&
+	dir=$(dirname "$sock") &&
+	ls -ld "$dir" | grep ^drwx...--- &&
+	git index-helper --kill &&
+	test_path_is_missing .git/index-helper.path
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
