Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D3D81F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 03:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbeGKDLk (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 23:11:40 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33661 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732316AbeGKDLk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 23:11:40 -0400
Received: by mail-yw0-f195.google.com with SMTP id c135-v6so8643414ywa.0
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 20:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pPC9Bol+Zg/Auwqa9q+D3CoLDZjHkxRnortYnUxGkrA=;
        b=C/vu6+hW1G565hXdQnZ1S35x9y4M0Yvz7z3Zf1NQcpxgr4yH1v3z2Xf4XJRQ0LU82S
         pzHC/3MkJiothmwRfcmo6VgWzYorppuYz60IMxzUcii4Ca3pQoUn6pcMTdH3cmjR1Jy6
         WXt8gB9DO8TddIQ7V/+3LGtPDtam/vr76MxeDD1FSre0++HwFFPqQYoSK7e4nlSWkv8w
         tO7XRcMq9F9ISjn+PIbtgRvzN69tsjXghOX3a3hAxrs3bq6EFF7Um5g25c5mRnlyzLUJ
         7HktR5R5n+roMSn0ph3ROOf8gWqG5fZy0jby1BoCKdYU/7srioBovwFkjSCxsVr358dD
         dEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pPC9Bol+Zg/Auwqa9q+D3CoLDZjHkxRnortYnUxGkrA=;
        b=I7s6zw5LShtB9/HFLdcx2V9hiEnTdGt5R/mKh50pA5aeTaHDysyN9Fzr9IxJQ8naNr
         FrGswrQ/rHhKdxYPuB8o8DQGotPMN0otSVsr6kYO9QMqMddFzznmBomOXbQZ3+0077AP
         oHvYR/msPTB3w2uKxIxAlNyaUwU+R7enF0jdZ+6l0f4npbOLCl/Y8oa9fAO3izswdcm7
         GSxwMnyVJNwsvQ7Q7svwY4ByBxwJDfkl+YRG/GMccN0GWvTYOhhySZitRxfLgvi1Uhi1
         1PVw2amE9ulp2a4NRhytmnjTWrfqwu/smue/0b6DJWeqMYa9bsIPaPPCfLChTbg8sXSt
         6IOQ==
X-Gm-Message-State: APt69E0vksLua8CuW2wVIV8HRPA0tBUUFZ6ZgykklyLdniq1/24MuWbH
        f1AeZr0O7EMz2NcQ9ZM2Jhc=
X-Google-Smtp-Source: AAOMgpcMMTqZ/G7i7prEwAkY9GbZjbyVuaJV3YFYggK1vDO93O7TKAsqGsz3Zgxc5aj5O25E/AL1cA==
X-Received: by 2002:a81:2d57:: with SMTP id t84-v6mr13941263ywt.152.1531278572618;
        Tue, 10 Jul 2018 20:09:32 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id d189-v6sm3538108ywh.93.2018.07.10.20.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 20:09:31 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     szeder.dev@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: Re: [RFC PATCH 2/7] t6044: add a testcase for index matching head, when head doesn't match HEAD
Date:   Tue, 10 Jul 2018 20:09:23 -0700
Message-Id: <20180711030923.26499-1-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.132.g6e63b23f4
In-Reply-To: <20180710203922.26367-1-szeder.dev@gmail.com>
References: <20180710203922.26367-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 1:39 PM, SZEDER Gábor <szeder.dev@gmail.com> wrote:
>> diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
>> index f9c2f8179..92ec55255 100755
>> --- a/t/t6044-merge-unrelated-index-changes.sh
>> +++ b/t/t6044-merge-unrelated-index-changes.sh
>> @@ -126,6 +126,17 @@ test_expect_failure 'recursive, when merge branch matches merge base' '
>>       test_path_is_missing .git/MERGE_HEAD
>>  '
>>
>> +test_expect_failure 'merge-recursive, when index==head but head!=HEAD' '
>> +     git reset --hard &&
>> +     git checkout C^0 &&
>> +
>> +     # Make index match B
>> +     git diff C B | git apply --cached &&
>
> Branch 'C' contains the file 'c', which creates ambiguity on
> case-insensitive file systems and makes the test fail:
>
>   ++git reset --hard
>   HEAD is now at ed5d5a6 B
>   ++git checkout 'C^0'
>   Previous HEAD position was ed5d5a6 B
>   HEAD is now at 4fa59ce C
>   ++git diff C B
>   ++git apply --cached
>   fatal: ambiguous argument 'C': both revision and filename
>   Use '--' to separate paths from revisions, like this:
>   'git <command> [<revision>...] -- [<file>...]'
>   error: unrecognized input
>   error: last command exited with $?=128
>   not ok 8 - merge-recursive, when index==head but head!=HEAD
>

Good catch; thanks for pointing it out.  Here's a fix:

-- 8< --

Subject: [PATCH] fixup! t6044: add a testcase for index matching head, when
 head doesn't match HEAD

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6044-merge-unrelated-index-changes.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
index 6e0ecab9c..5e3779ebc 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -131,7 +131,7 @@ test_expect_success 'merge-recursive, when index==head but head!=HEAD' '
 	git checkout C^0 &&
 
 	# Make index match B
-	git diff C B | git apply --cached &&
+	git diff C B -- | git apply --cached &&
 	# Merge B & F, with B as "head"
 	git merge-recursive A -- B F > out &&
 	test_i18ngrep "Already up to date" out
-- 
2.18.0.132.g6e63b23f4

