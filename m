Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D5DC433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD6322A84
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbhAWVHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 16:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhAWVHv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 16:07:51 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C03C0613D6
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 13:07:10 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id o18so6868329qtp.10
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 13:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i//gTJdCEJfBXfS5HiHrjvNxBCz2IgCFSkyq8YOmVqc=;
        b=t10vViwDd47p1mOq2Ma0LuPOexnjXMrPfPVgm50PwsZM19t6IPAqAO5O3evN/FzAUc
         w6s6SiZ8QxaRnPXTdGyJ0FfOpDGPKEmXJvhq4A4NMSZmVZ4I6KkWTf5RdXXCjZtrfUwg
         VzvKhJUYi5M8KlxqAKma1LUDuQa4PbBiSt3wlwI646MEUMkq+7m4eVeL9Xm8dVg+8UB6
         os6dltnYA4/yPzr9vq0N2vB8Eyz/oAonrKglG7rhvcJ52c8bWzxN6H9glgnaYrKFkTZX
         BGo0RgVudY2B/gXDXJHgR1Oln6nFTxyOlKxP9Ygz5Uw789nQk58LmYD/kNO0unMxXxa4
         u6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i//gTJdCEJfBXfS5HiHrjvNxBCz2IgCFSkyq8YOmVqc=;
        b=TL2HZVO9tuyxG3zn/LoB29T+KRhEXijgPii4woASKfBJuZjlNZpUguA4OpkMc0dXzI
         Nz/3vwFNuHLkY699UDE7xUtDuiniqLpjEdATRmfR0S/Xr/HAAF2jZF9P4Hm9nH0Pec/z
         CQT+vAz59BXp8B7mpkIBacuLJmCb9I8PUW1pvqaEcCBdJHGNuvOyPtl5euUMDF3guSqm
         F+yCi8o3Qm4h6nTALT1w6XCIKCBwadjnQYWXEldHVP2zWfxZr69EWwkvlW42dk+hvpMb
         FWxNhUw5IERvPsRdZPWgmFsNBrJ44pchjqrzSiEeE1dtksK/vevTu3fS43O2jazS7ABR
         EEfg==
X-Gm-Message-State: AOAM531f1rbqx6Xy/1ZQiZGjcFn6cCVBOWgp0jpHiuej+K21BlvFgtDG
        SAHJfSaQyt1mBx3WTwsoTeQF5nRrzK6JTA==
X-Google-Smtp-Source: ABdhPJyEhpXE5xKjflOEFVkQBlJcavm1CCKnArq4Iv1aTWSkU9IZ8yuSlFk2dlYLe77RJhRS/ouXgg==
X-Received: by 2002:ac8:5a82:: with SMTP id c2mr1882180qtc.90.1611436029882;
        Sat, 23 Jan 2021 13:07:09 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:98e8:103:e6ee:9536? ([2600:1700:e72:80a0:98e8:103:e6ee:9536])
        by smtp.gmail.com with UTF8SMTPSA id p26sm1193118qkk.6.2021.01.23.13.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 13:07:09 -0800 (PST)
Subject: Re: [PATCH v3 8/9] test-lib: test_region looks for trace2 regions
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
 <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
 <b37181bdec43cfc798740f2bdd19f6d2482beb26.1611431900.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <096e2969-60d2-3ebe-3855-a9c954ebd07e@gmail.com>
Date:   Sat, 23 Jan 2021 16:07:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <b37181bdec43cfc798740f2bdd19f6d2482beb26.1611431900.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/23/2021 2:58 PM, Derrick Stolee via GitGitGadget wrote:
...
> +	if test $exitcode != $expect_exit = 1]
...
> +	if test $exitcode != $expect_exit = 1]
As Elijah pointed out, these lines are bogus. I'm not sure how
they passed the tests without failure, but here is a replacement
for this patch:

--- >8 ---


From ff15d509b89edd4830d85d53cea3079a6b0c1c08 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Mon, 11 Jan 2021 08:53:09 -0500
Subject: [PATCH 8/9] test-lib: test_region looks for trace2 regions

Most test cases can verify Git's behavior using input/output
expectations or changes to the .git directory. However, sometimes we
want to check that Git did or did not run a certain section of code.
This is particularly important for performance-only features that we
want to ensure have been enabled in certain cases.

Add a new 'test_region' function that checks if a trace2 region was
entered and left in a given trace2 event log.

There is one existing test (t0500-progress-display.sh) that performs
this check already, so use the helper function instead. Note that this
changes the expectations slightly. The old test (incorrectly) used two
patterns for the 'grep' invocation, but this performs an OR of the
patterns, not an AND. This means that as long as one region_enter event
was logged, the test would succeed, even if it was not due to the
progress category.

More uses will be added in a later change.

t6423-merge-rename-directories.sh also greps for region_enter lines, but
it verifies the number of such lines, which is not the same as an
existence check.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t0500-progress-display.sh |  3 +--
 t/test-lib-functions.sh     | 42 +++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 1ed1df351c..84cce345e7 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -303,8 +303,7 @@ test_expect_success 'progress generates traces' '
 		"Working hard" <in 2>stderr &&
 
 	# t0212/parse_events.perl intentionally omits regions and data.
-	grep -e "region_enter" -e "\"category\":\"progress\"" trace.event &&
-	grep -e "region_leave" -e "\"category\":\"progress\"" trace.event &&
+	test_region progress "Working hard" trace.event &&
 	grep "\"key\":\"total_objects\",\"value\":\"40\"" trace.event &&
 	grep "\"key\":\"total_bytes\",\"value\":\"409600\"" trace.event
 '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 999982fe4a..9fc4cf8476 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1655,3 +1655,45 @@ test_subcommand () {
 		grep "\[$expr\]"
 	fi
 }
+
+# Check that the given command was invoked as part of the
+# trace2-format trace on stdin.
+#
+#	test_region [!] <category> <label> git <command> <args>...
+#
+# For example, to look for trace2_region_enter("index", "do_read_index", repo)
+# in an invocation of "git checkout HEAD~1", run
+#
+#	GIT_TRACE2_EVENT="$(pwd)/trace.txt" GIT_TRACE2_EVENT_NESTING=10 \
+#		git checkout HEAD~1 &&
+#	test_region index do_read_index <trace.txt
+#
+# If the first parameter passed is !, this instead checks that
+# the given region was not entered.
+#
+test_region () {
+	local expect_exit=0
+	if test "$1" = "!"
+	then
+		expect_exit=1
+		shift
+	fi
+
+	grep -e	'"region_enter".*"category":"'"$1"'","label":"'"$2"\" "$3"
+	exitcode=$?
+
+	if test $exitcode != $expect_exit
+	then
+		return 1
+	fi
+
+	grep -e	'"region_leave".*"category":"'"$1"'","label":"'"$2"\" "$3"
+	exitcode=$?
+
+	if test $exitcode != $expect_exit
+	then
+		return 1
+	fi
+
+	return 0
+}
-- 
2.30.0

