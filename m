From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] t5541: test more combinations of --progress
Date: Tue, 1 May 2012 04:43:08 -0400
Message-ID: <20120501084307.GC4998@sigill.intra.peff.net>
References: <20120501084048.GA21904@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, dfowler <davidfowl@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com,
	Paul Betts <paul@github.com>, David Ebbo <david.ebbo@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: msysgit+bncCN2hpKqZChCkxP78BBoE_rDyDw@googlegroups.com Tue May 01 10:43:18 2012
Return-path: <msysgit+bncCN2hpKqZChCkxP78BBoE_rDyDw@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f186.google.com ([209.85.213.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCN2hpKqZChCkxP78BBoE_rDyDw@googlegroups.com>)
	id 1SP8g1-0007oA-EF
	for gcvm-msysgit@m.gmane.org; Tue, 01 May 2012 10:43:17 +0200
Received: by yenl4 with SMTP id l4sf3952996yen.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 01 May 2012 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=qUYG1BWaX5j0HtKHTwdNb4l4d8ennYA45u7OkxHPNzU=;
        b=n9QwRLQszO7kyekcjDGB6Kz0Y+pqdnrp9Q/GOtp/liNY1bdrNjW0k7AhYxu0mTJ3YA
         MJX9iQGDFsZDbqkrq4C1T1VovJzD4+QP5qq5p5Iq0RWqgOzDN8ipFvzJqeu/8a17BWag
         Au7ptX7HOEn1gostmRmMPw44hQtnT4LOJOCN4=
Received: by 10.50.155.233 with SMTP id vz9mr144045igb.1.1335861796325;
        Tue, 01 May 2012 01:43:16 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.231.50.74 with SMTP id y10ls4070719ibf.4.gmail; Tue, 01 May
 2012 01:43:15 -0700 (PDT)
Received: by 10.42.150.2 with SMTP id y2mr18399279icv.7.1335861795496;
        Tue, 01 May 2012 01:43:15 -0700 (PDT)
Received: by 10.42.150.2 with SMTP id y2mr18399278icv.7.1335861795487;
        Tue, 01 May 2012 01:43:15 -0700 (PDT)
Received: from peff.net (99-108-226-0.lightspeed.iplsin.sbcglobal.net. [99.108.226.0])
        by gmr-mx.google.com with ESMTPS id md3si7814886igc.1.2012.05.01.01.43.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 May 2012 01:43:15 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 99.108.226.0 as permitted sender) client-ip=99.108.226.0;
Received: (qmail 1849 invoked by uid 107); 1 May 2012 08:43:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 04:43:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 04:43:08 -0400
In-Reply-To: <20120501084048.GA21904@sigill.intra.peff.net>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff@peff.net designates 99.108.226.0 as permitted sender) smtp.mail=peff@peff.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196672>

Previously, we tested only that "push --quiet --no-progress"
was silent. However, there are many other combinations that
were not tested:

  1. no options at all (but stderr as a tty)
  2. --no-progress by itself
  3. --quiet by itself
  4. --progress (when stderr not a tty)

These are tested elsewhere for general "push", but it is
important to test them separately for http. It follows a
very different code path than git://, and options must be
relayed across a remote helper to a separate send-pack
process (and in fact cases (1), (2), and (4) have all been
broken just for http at some point in the past).

We can drop the "--quiet --no-progress" test, as it is not
really interesting (it is already handled by testing them
separately in (2) and (3) above).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5541-http-push.sh |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index d66ed24..a1b10bd 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -215,12 +215,35 @@ test_expect_success 'push --mirror to repo with alternates' '
 	git push --mirror "$HTTPD_URL"/smart/alternates-mirror.git
 '
 
-test_expect_success TTY 'quiet push' '
+test_expect_success TTY 'push shows progress when stderr is a tty' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	test_commit noisy &&
+	test_terminal git push 2>&1 | tee output &&
+	grep "^Writing objects" output
+'
+
+test_expect_success TTY 'push --quiet silences status and progress' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_commit quiet &&
-	test_terminal git push --quiet --no-progress 2>&1 | tee output &&
+	test_terminal git push --quiet 2>&1 | tee output &&
 	test_cmp /dev/null output
 '
 
+test_expect_success TTY 'push --no-progress silences progress but not status' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	test_commit no-progress &&
+	test_terminal git push --no-progress 2>&1 | tee output &&
+	grep "^To http" output &&
+	! grep "^Writing objects"
+'
+
+test_expect_success 'push --progress shows progress to non-tty' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	test_commit progress &&
+	git push --progress 2>&1 | tee output &&
+	grep "^To http" output &&
+	grep "^Writing objects" output
+'
+
 stop_httpd
 test_done
-- 
1.7.10.630.g31718

-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en
