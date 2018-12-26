Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FB9F1F804
	for <e@80x24.org>; Fri, 28 Dec 2018 20:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388037AbeL1UNB (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 15:13:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46827 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbeL1UNB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 15:13:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so21793621wrt.13
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 12:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=X0jJOn59M2vtDmy1+YfHVPQfisolKm3+fzeBkh6dLCg=;
        b=gmSNa9HZpwB84e5MgRLYCFrXJNfnPknjSpb6QdDwoIZE7q4J8KZHsdZ5nFb/vOPyFG
         6fBi0bDT4/eT3SGRcEg+SzTYv5tnuQ9iT6XKe9PaB7RcgTjbYa/OihiDIhNAszxMddZD
         o0HtC1ubqjZn2vfmdKqzll3iVXcpQAYCI8wYEuVMXQR9wM3NRXgZmTwGn6W7gMPmfP+P
         t7IRTiHvuT5xGuAlP1l90UzlArYZyQitienxBaFV7pt8fofsmqJvFTJGai8xQTff/5Y5
         mVY15u/fwvbUI6dojXCHtIublIihuSB0Pso76Z5B705VykB7+04tn2hAY4OhddOEYXLA
         aIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=X0jJOn59M2vtDmy1+YfHVPQfisolKm3+fzeBkh6dLCg=;
        b=gMNbQYXafmr0E94Vot8w/V6YoLmQms5ShuAl+uZxHrokxP9BSKxTfNC6nMhBLRNFsJ
         bwK+uBZv2SAiRqskn5DigI0ZaEDz1qzUGu8f5tepElhhZF2NQic5QhYIi3ZFrWADauWP
         9RRNBwk3HotbUXxawEd/X2obnkAm7aR9x1AV9VEKGagy6xFCXcd1WmFNA5ZHJ6gGDuvt
         31t1aBVa95QnSUrK9QL9md2hu1s/2odbTAO1EEeFZ1f6tLz4vGIbaJOt8f49ETSNNFCk
         HvOxyPj0xHSYtLqXQ5qrieEsaBY/GB/s5a8BKs/t61mxz7N+zu7w4l09B4mKEzs2qHDw
         kVzg==
X-Gm-Message-State: AJcUukeeEeHr1v7WXWcLUawDNM4e/L+MQU2H6FbodVR+HUNJlEMBUiju
        a1fW+iQZ+hkaKiCZWv/VTco=
X-Google-Smtp-Source: ALg8bN4w4kCheaotweKwjGmMo8JPGQdTp4f2b2RjnBC5CtJ/vWNdHjVjT9OuIz8P3FiyHbc7JRj+qg==
X-Received: by 2002:adf:fbc8:: with SMTP id d8mr25779903wrs.318.1546027978924;
        Fri, 28 Dec 2018 12:12:58 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c15sm17903299wml.27.2018.12.28.12.12.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 12:12:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Allow 'cherry-pick -m 1' for non-merge commits
Date:   Wed, 26 Dec 2018 14:52:07 -0800
References: <xmqq5zvwesvz.fsf@gitster-ct.c.googlers.com>
        <cover.1544762343.git.sorganov@gmail.com> <87tvj1ok4k.fsf@javad.com>
Message-ID: <xmqqr2e1mmuu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com>, Sergey Organov
<sorganov@gmail.com> writes:

> Hi Junio,
>
> What's the status of these patches?

The status of these patches is "Just updated on the list", as far as
I am concerned, and its cover letter would have described what's
improved relative to the previous round better than whatever answer
I could give here ;-)

I checked the overall diff between the previous round and the result
of applying all four patches to find out that the updates are only
to the tests.  The changes in the code (still) looked correct.




diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
index b1602718f8..3259bd59eb 100755
--- a/t/t3502-cherry-pick-merge.sh
+++ b/t/t3502-cherry-pick-merge.sh
@@ -40,12 +40,12 @@ test_expect_success 'cherry-pick -m complains of bogus numbers' '
 	test_expect_code 129 git cherry-pick -m 0 b
 '
 
-test_expect_success 'cherry-pick a non-merge with -m should fail' '
+test_expect_success 'cherry-pick explicit first parent of a non-merge' '
 
 	git reset --hard &&
 	git checkout a^0 &&
-	test_expect_code 128 git cherry-pick -m 1 b &&
-	git diff --exit-code a --
+	git cherry-pick -m 1 b &&
+	git diff --exit-code c --
 
 '
 
@@ -84,12 +84,12 @@ test_expect_success 'cherry pick a merge relative to nonexistent parent should f
 
 '
 
-test_expect_success 'revert a non-merge with -m should fail' '
+test_expect_success 'revert explicit first parent of a non-merge' '
 
 	git reset --hard &&
 	git checkout c^0 &&
-	test_must_fail git revert -m 1 b &&
-	git diff --exit-code c
+	git revert -m 1 b &&
+	git diff --exit-code a
 
 '
 
diff --git a/t/t3506-cherry-pick-ff.sh b/t/t3506-cherry-pick-ff.sh
index fb889ac6f0..127dd0082f 100755
--- a/t/t3506-cherry-pick-ff.sh
+++ b/t/t3506-cherry-pick-ff.sh
@@ -64,10 +64,10 @@ test_expect_success 'merge setup' '
 	git checkout -b new A
 '
 
-test_expect_success 'cherry-pick a non-merge with --ff and -m should fail' '
+test_expect_success 'cherry-pick explicit first parent of a non-merge with --ff' '
 	git reset --hard A -- &&
-	test_must_fail git cherry-pick --ff -m 1 B &&
-	git diff --exit-code A --
+	git cherry-pick --ff -m 1 B &&
+	git diff --exit-code C --
 '
 
 test_expect_success 'cherry pick a merge with --ff but without -m should fail' '
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index c84eeefdc9..941d5026da 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -61,7 +61,11 @@ test_expect_success 'cherry-pick mid-cherry-pick-sequence' '
 
 test_expect_success 'cherry-pick persists opts correctly' '
 	pristine_detach initial &&
-	test_expect_code 128 git cherry-pick -s -m 1 --strategy=recursive -X patience -X ours initial..anotherpick &&
+	# to make sure that the session to cherry-pick a sequence
+	# gets interrupted, use a high-enough number that is larger
+	# than the number of parents of any commit we have created
+	mainline=4 &&
+	test_expect_code 128 git cherry-pick -s -m $mainline --strategy=recursive -X patience -X ours initial..anotherpick &&
 	test_path_is_dir .git/sequencer &&
 	test_path_is_file .git/sequencer/head &&
 	test_path_is_file .git/sequencer/todo &&
@@ -69,7 +73,7 @@ test_expect_success 'cherry-pick persists opts correctly' '
 	echo "true" >expect &&
 	git config --file=.git/sequencer/opts --get-all options.signoff >actual &&
 	test_cmp expect actual &&
-	echo "1" >expect &&
+	echo "$mainline" >expect &&
 	git config --file=.git/sequencer/opts --get-all options.mainline >actual &&
 	test_cmp expect actual &&
 	echo "recursive" >expect &&
