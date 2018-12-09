Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2E420A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 22:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeLIW4l (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 17:56:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38897 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbeLIW4k (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 17:56:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so9386398wml.3
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 14:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BAwS1q3Ains27HZCF9BhsHWlL0kpSnwF9IaV7bb31JU=;
        b=KjNRfB+iGdZ+7Zu1ZqJltwk79Jbc5YQ/A3wu7b6G+yiufX/heOFLdqnet5wcZhGIY9
         5ZqAoqCmT2QlmY3ZVhq+hu9idpnGMUtYT/O9xm+CkA2mOVP/XoefgaooUgssBuUtmsvs
         ftwsVoWjuiI7ubaLTcQ4w9EvSPpc2UX+GVSfo9F4mYlNA8yklTGK1M9txtt0WumZ/DAu
         w7wb04UcnEaQUqXrit3FfW+WmWEKuOa6dgFXPMEot27ttowIP5kiIYCxd2CgHy8ZmfVu
         IFGjFEnXZM/UsQixyI+yTPPPtWOt4O8dLGc2/NoSNT4OgUEpa9TKDPfLBYy1vd1QRrCm
         wRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BAwS1q3Ains27HZCF9BhsHWlL0kpSnwF9IaV7bb31JU=;
        b=i2xYivG+6tNfxFrKEtWBiff1cF03BsHWSQKJPk6jJjoHv4XK5yTeatzrZhLayQBUhf
         BDmaDCrCvGm4iS/WAz5C0XbkbyTsYIyS+Y1tNHe+vrcigURVhuFoB6h9ARJXGtbspoVB
         zWQhdCmfSwu0qcF2Ts9Q9z+UohhigA5dSRm82kQp+C/Zy7dkA4Bngv98+ceoTZx3jJDe
         9aMHXRGWwi6a9modUR23rvm+hhCpYOePLUam/iuMoNnXjQ7C0yRl4YQNMUwEpIw4K470
         9WVy0O51G/YRJheGqTAhrzghbIpuYKbiYQ3MGK7+2Iy7F6OBr4xm4sP/09fq4L8xe84b
         R1rg==
X-Gm-Message-State: AA+aEWYmgaoFu+7z0bnjZgHk51JE4tFO2W+D6hwhzItXIwSkLg9TfvfA
        0uidTy6TclahCTjTqaCb+2Sha0Pe
X-Google-Smtp-Source: AFSGD/XH5M1rhVoEzCcOaGjbNjmGEtpcNYnNZyF+uKSB9uUxji/nDczDM5izpqtTpL1M31ToutJCpA==
X-Received: by 2002:a1c:630a:: with SMTP id x10mr8832051wmb.63.1544396198465;
        Sun, 09 Dec 2018 14:56:38 -0800 (PST)
Received: from localhost.localdomain (x4db97970.dyn.telefonica.de. [77.185.121.112])
        by smtp.gmail.com with ESMTPSA id w6sm12581807wme.46.2018.12.09.14.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Dec 2018 14:56:37 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 2/7] test-lib: parse some --options earlier
Date:   Sun,  9 Dec 2018 23:56:23 +0100
Message-Id: <20181209225628.22216-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.156.g5a9fd2ce9c
In-Reply-To: <20181209225628.22216-1-szeder.dev@gmail.com>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181209225628.22216-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'test-lib.sh' looks for the presence of certain options like '--tee'
and '--verbose-log', so it can execute the test script again to save
its standard output and error.  This happens way before the actual
option parsing loop, and the condition looking for these options looks
a bit odd, too.  This patch series will add two more options to look
out for, and, in addition, will have to extract these options' stuck
arguments (i.e. '--opt=arg') as well.

Add a proper option parsing loop to check these select options early
in 'test-lib.sh', making this early option checking more readable and
keeping those later changes in this series simpler.  Use a 'for opt in
"$@"' loop to iterate over the options to preserve "$@" intact, so
options like '--verbose-log' can execute the test script again with
all the original options.

As an alternative, we could parse all options early, but there are
options that do require an _unstuck_ argument, which is tricky to
handle properly in such a for loop, and the resulting complexity is,
in my opinion, worse than having this extra, partial option parsing
loop.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib.sh | 53 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9a3f7930a3..5577d9dc5a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -71,13 +71,33 @@ then
 	exit 1
 fi
 
+# Parse some options early, taking care to leave $@ intact.
+for opt
+do
+	case "$opt" in
+	--tee)
+		tee=t ;;
+	-V|--verbose-log)
+		verbose_log=t ;;
+	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
+		valgrind=memcheck ;;
+	--valgrind=*)
+		valgrind=${opt#--*=} ;;
+	--valgrind-only=*)
+		valgrind_only=${opt#--*=} ;;
+	*)
+		# Other options will be handled later.
+	esac
+done
+
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
-case "$GIT_TEST_TEE_STARTED, $* " in
-done,*)
-	# do not redirect again
-	;;
-*' --tee '*|*' --va'*|*' -V '*|*' --verbose-log '*)
+if test "$GIT_TEST_TEE_STARTED" = "done"
+then
+	: # do not redirect again
+elif test -n "$tee" || test -n "$verbose_log" ||
+     test -n "$valgrind" || test -n "$valgrind_only"
+then
 	mkdir -p "$TEST_OUTPUT_DIRECTORY/test-results"
 	BASE="$TEST_OUTPUT_DIRECTORY/test-results/$(basename "$0" .sh)"
 
@@ -94,8 +114,7 @@ done,*)
 	 echo $? >"$BASE.exit") | tee -a "$GIT_TEST_TEE_OUTPUT_FILE"
 	test "$(cat "$BASE.exit")" = 0
 	exit
-	;;
-esac
+fi
 
 # For repeatability, reset the environment to known value.
 # TERM is sanitized below, after saving color control sequences.
@@ -296,17 +315,6 @@ do
 		with_dashes=t; shift ;;
 	--no-color)
 		color=; shift ;;
-	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
-		valgrind=memcheck
-		shift ;;
-	--valgrind=*)
-		valgrind=${1#--*=}
-		shift ;;
-	--valgrind-only=*)
-		valgrind_only=${1#--*=}
-		shift ;;
-	--tee)
-		shift ;; # was handled already
 	--root=*)
 		root=${1#--*=}
 		shift ;;
@@ -336,9 +344,12 @@ do
 			echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
 		fi
 		shift ;;
-	-V|--verbose-log)
-		verbose_log=t
-		shift ;;
+	--tee|\
+	-V|--verbose-log|\
+	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind|\
+	--valgrind=*|\
+	--valgrind-only=*)
+		shift ;; # These options were handled already.
 	*)
 		echo "error: unknown test option '$1'" >&2; exit 1 ;;
 	esac
-- 
2.20.0.rc2.156.g5a9fd2ce9c

