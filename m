Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA99C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 20:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350981AbiCOUCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 16:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237038AbiCOUCD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 16:02:03 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278992FFDE
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 13:00:51 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id kd12so374227qvb.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 13:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xfTusgrqWtWJzvNCa68K28J65rClGTH6rgoQX44daT0=;
        b=iTLpU8BwkZ8VirEzym6CVpCw1F+gexUHtSgmI9Nx2RY2vKpSvYWY4p+22UqvWw112Z
         2ZduBqBnCahhPHhbsU82OHKa2yi2aws/8faA540EGItNDwZYOEuAy+1ZPw0ybtl86kCe
         0GQ4UiMypXYfrMAV6PAGyXQm1wpB3qdGTqX38bCVEP8KIHld7odT0D1a9R2RIaXFmtf0
         h+TlbDY6Yt4YwibUkVuGIubcMFe7EDagjOKPntc8bQ1J5Y3fqIJ6lZbqVBxas4aw48HS
         HS6Yz3QM/oTLHmu8kd5c+DZ/Svti7Y78waTnL/DjMKTXU6NfXoEvUZEADmzSwbSnOKUI
         0rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xfTusgrqWtWJzvNCa68K28J65rClGTH6rgoQX44daT0=;
        b=1BAXcdUZK2hHlTw9QbO6j+GhapGW4aJbdV/BcX5viG8h5gDLvjrpcCE1cqMGZKRBAc
         IDf4BORzvP0jC5dVc0YwznhtnyrY9UxkPYHTfaHcGCWGSzESlXVLShCwsPxc8HzOnzS5
         vG6Qmxf4GUZtglusM1aih0nVFs0StDiqoOtAzNtxeJdlVI6fqRY678MZDU3xhEV1mSPl
         9eFmW+ZicyQPXvm/O0PXIs+Xr8ysnkNnCf0xswOvpkKHUfjBHh4GerefI17xwTj61gMS
         CqCaKQmtnDMoy4f+mrmrKG93RK+Ad0RF5MgjVuZI+/ezyKgO6Y7tsjxWt8iuix24Ik+H
         eZCg==
X-Gm-Message-State: AOAM531d9A/4uNqSQDEBgLI11xRYD+FPPMl3ixzABkv6D2EkHNX3SYQl
        b9cWw6kN8gr7ssuF5Pl/fyU9
X-Google-Smtp-Source: ABdhPJwGnScvXykLkxu1StSUOlrTaPpkqfgkKIcMV0bpoDzVD0fGiGqKvP07NYFGIUiYeoDOxJhA5g==
X-Received: by 2002:a05:6214:238b:b0:433:a73:7713 with SMTP id fw11-20020a056214238b00b004330a737713mr22183278qvb.54.1647374450175;
        Tue, 15 Mar 2022 13:00:50 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s5-20020a37a905000000b0067d35f2fdb1sm9594738qke.37.2022.03.15.13.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 13:00:49 -0700 (PDT)
Message-ID: <f634f89c-b4b8-6736-d519-a4c554bac959@github.com>
Date:   Tue, 15 Mar 2022 16:00:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
 <20220315100145.214054-2-shaoxuan.yuan02@gmail.com>
 <xmqq8rtbf7uz.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq8rtbf7uz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/15/2022 1:23 PM, Junio C Hamano wrote:
> Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:
> 
>> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>> ---
>>  builtin/mv.c                             |  3 +++
>>  t/t1092-sparse-checkout-compatibility.sh | 34 ++++++++++++++++++++++++
>>  2 files changed, 37 insertions(+)
>>
>> diff --git a/builtin/mv.c b/builtin/mv.c
>> index 83a465ba83..111360ebf5 100644
>> --- a/builtin/mv.c
>> +++ b/builtin/mv.c
>> @@ -138,6 +138,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>>  
>>  	git_config(git_default_config, NULL);
>>  
>> +	prepare_repo_settings(the_repository);
>> +	the_repository->settings.command_requires_full_index = 0;
>> +
> 
> The command used to be marked as one of the commands that require
> full index to work correctly.  Why did it suddenly become not to
> require it, especially without any other changes to make it so?
> 
> This patch needs a lot more explaining to do in itse proposed log
> message.

Right. Some builtins already work safely with the sparse index,
but we just were not sure without creating the proper tests for
it. In this case, I expect 'git mv' uses index_name_pos() to find
the locations of a given index entry, which can cause the index
to expand naturally.

I can definitely imagine a bug where index_name_pos() fixes the
location of the in-cone path within the sparse index, then the
index_name_pos() for the out-of-cone path expands the index and
causes the position of the in-cone path to no longer be correct.

Testing with a variety of in-cone and out-of-cone paths will
help here.

While I was writing this reply, I realized that our default cone
in `t1092` doesn't have a sparse directory before the typical in-cone
path of "deep/a". I set out to make one.

This diff _should_ apply to `t1092` without causing any failures:

--- >8 ---

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 2a04b532f91..e9533832aab 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -16,7 +16,9 @@ test_expect_success 'setup' '
 		echo "after deep" >e &&
 		echo "after folder1" >g &&
 		echo "after x" >z &&
-		mkdir folder1 folder2 deep x &&
+		mkdir folder1 folder2 deep before x &&
+		echo "before deep" >before/a &&
+		echo "before deep again" >before/b &&
 		mkdir deep/deeper1 deep/deeper2 deep/before deep/later &&
 		mkdir deep/deeper1/deepest &&
 		mkdir deep/deeper1/deepest2 &&
@@ -1311,6 +1313,7 @@ test_expect_success 'ls-files' '
 
 	cat >expect <<-\EOF &&
 	a
+	before/
 	deep/
 	e
 	folder1-
@@ -1358,6 +1361,7 @@ test_expect_success 'ls-files' '
 
 	cat >expect <<-\EOF &&
 	a
+	before/
 	deep/
 	e
 	folder1-

--- >8 ---

However, it causes failures in these tests:

1. `8 - add outside sparse cone`
2. `10 - status/add: outside sparse cone`
3. `21 - reset with pathspecs inside sparse definition`

After talking with @vdye about this, it seems that they are all
failing based on a common issue regarding an index-based diff.
Somehow the diff is not finding a version of the paths so is
reporting them as added.

For example, at the point of failure in `8 - add outside sparse
cone`, we have these results for some Git commands:

$ git diff
diff --git a/folder1/a b/folder1/a
index 7898192..8e27be7 100644
--- a/folder1/a
+++ b/folder1/a
@@ -1 +1 @@
-a
+text

$ git diff --staged

$ git diff --staged -- folder1/a
diff --git a/folder1/a b/folder1/a
new file mode 100644
index 0000000..7898192
--- /dev/null
+++ b/folder1/a
@@ -0,0 +1 @@
+a

$ git diff --staged -- deep
diff --git a/deep/later/a b/deep/later/a
new file mode 100644
index 0000000..7898192
--- /dev/null
+++ b/deep/later/a
@@ -0,0 +1 @@
+a
```

The impact must be pretty low and specific to these prefixed diffs
(the reset test also uses prefixed resets, so pathspecs are somehow
involved) which are rare for users to actually use. Still, we
should fix this and strengthen our tests.

After trying for an hour to fix this myself, I have failed to find
the root cause of this issue. I'm about to head out on vacation, so
I won't have time to look into this again until Monday. I wanted to
share this information so it doesn't cause Shaoxuan too much pain
while working on this 'git mv' change.

Thanks,
-Stolee
