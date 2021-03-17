Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F88C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9054C64F4D
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCQNGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhCQNGD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 09:06:03 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAFCC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:05:52 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so1692218ote.6
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hqhQqSppy4WAWyf9SVOHHOxja48zhhHRwnFqlAn3RZc=;
        b=pjwZhvFdKIM/nALZnpKv5rfL2xpdmO97SlO0H4SE9LG0balHT7k5xnsnvF06168zuA
         6XnKOVJsDZ6dMz6AVePg9q+dz25+LzHbwNKaMX/fEnSmyN+CF30tyblkEYupeRxpoNKy
         fADCjub3cNXe2p04j+EznHTkYZpzJ+EBBLB2Ynfs7p7sOWweHqRgY/mbWFV9uHuranwN
         SBWI53b4kPpau+ITMO9sUYmqYHOw6NjwharfWX105u660sltxgXPsphp7clTGMvWruJZ
         m8+QM7V+FwcJ+SCKKUNYzpCA5RF/yuSA/DrnHUphBGLV2Im8BGO/SurEDST5FAwQK2Az
         dTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hqhQqSppy4WAWyf9SVOHHOxja48zhhHRwnFqlAn3RZc=;
        b=rD4zMet3R/BP3vhXJnevgROvq7Wfjwlq+0/l/Rh2a4I0d7PEbts3XkGG75zm61GfRR
         eQVFzFtbuUJsxfLjRzW/5wKXUx4Anc0M+Kusu2U5kz3sW5wbfYZUnZcOwAY8Fm9GXM33
         Ng6mwji/wSUMr+kzouv/x5/VSwN9gzQA8JdZ669dkKaS0qkEb++MTae4HkNNycg95bUY
         f4ApaPW9/5W+dhv4IaJglF7eicMPNS0ZGJgFIGqgm+FfyMPa5zMN+94a+Z2iaCe0mnAY
         h1nsarPb37nt8RIUy6C4/sM47a/UYG7HTpWQXUqssB5K6NQW5YZ4cDvay/3BguUf+y4e
         412A==
X-Gm-Message-State: AOAM532kPJ0+AXpyHmJd64i+QLyYaMKilE0LVf3Vw2Y4j8/TtA8HQiol
        cvrDqjI4ohJzNhPteydfqh4=
X-Google-Smtp-Source: ABdhPJxwmxXlipOYkHGdBpwZLaQ0l2jZGwC9yIhrrQ9JdFnp/NlnZDBp85jsne3hRW7jXDPglUteKw==
X-Received: by 2002:a9d:470b:: with SMTP id a11mr3209136otf.254.1615986351549;
        Wed, 17 Mar 2021 06:05:51 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5df9:6440:37ca:197f? ([2600:1700:e72:80a0:5df9:6440:37ca:197f])
        by smtp.gmail.com with ESMTPSA id r22sm8852217otg.4.2021.03.17.06.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 06:05:51 -0700 (PDT)
Subject: Re: [PATCH v3 02/20] t/perf: add performance test for sparse
 operations
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <d2197e895e4d4160fa369e2ba7d82e2e5a7fbc01.1615912983.git.gitgitgadget@gmail.com>
 <87tupadve8.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <792a1249-166b-56f4-1e7d-0c5d7a1ba0e5@gmail.com>
Date:   Wed, 17 Mar 2021 09:05:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87tupadve8.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2021 4:41 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 16 2021, Derrick Stolee via GitGitGadget wrote:
>> +test_expect_success 'setup repo and indexes' '
>> +	git reset --hard HEAD &&
>> +	# Remove submodules from the example repo, because our
>> +	# duplication of the entire repo creates an unlikly data shape.
>> +	git config --file .gitmodules --get-regexp "submodule.*.path" >modules &&
>> +	git rm -f .gitmodules &&
>> +	for module in $(awk "{print \$2}" modules)
>> +	do
>> +		git rm $module || return 1
>> +	done &&
>> +	git commit -m "remove submodules" &&
> 
> Paradoxically with this you can no longer use a repo that's not git.git
> or another repo that has submodules, since we'll die in trying to remove
> them.

Good point.

> Also you don't have to "git rm .gitmodules", the "git rm" command
> removes submodule entries.

Sure.

> Perhaps just:
> 
>     for module in $(git ls-files --stage | grep ^160000 | awk -F '\t' '{ print $2 }')
>     do
>         git rm "$module"
>     done
> 
> Or another way of guarding against rm getting the empty list && commit?
> 
> But it seems odd to be doing this at all, the point of the perf
> framework is that you can point it at any repo, and some repos you want
> to test will have submodules.

You're right that it should handle all repos. However, the point of
the test is to have many copies of the repo, but most of them are
excluded by sparse-directory entries. We don't collapse sparse-directory
entries if there is a submodule inside, so the data shape is wrong after
making all the copies.

So, I disagree with your approach in your suggested diff, and instead
offer this one. I've tested this with git.git and another local repo
without submodules and checked that everything works as expected.

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index e527316e66d..5c0d78eeeea 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -10,15 +10,17 @@ SPARSE_CONE=f2/f4/f1
 
 test_expect_success 'setup repo and indexes' '
 	git reset --hard HEAD &&
+
 	# Remove submodules from the example repo, because our
-	# duplication of the entire repo creates an unlikly data shape.
-	git config --file .gitmodules --get-regexp "submodule.*.path" >modules &&
-	git rm -f .gitmodules &&
-	for module in $(awk "{print \$2}" modules)
-	do
-		git rm $module || return 1
-	done &&
-	git commit -m "remove submodules" &&
+	# duplication of the entire repo creates an unlikely data shape.
+	if (git config --file .gitmodules --get-regexp "submodule.*.path" >modules)
+	then
+		for module in $(awk "{print \$2}" modules)
+		do
+			git rm $module || return 1
+		done &&
+		git commit -m "remove submodules" || return 1
+	fi &&
 
 	echo bogus >a &&
 	cp a b &&

> Seems like something like the WIP patch at the end on top would be
> better.
> 
>> +	echo bogus >a &&
>> +	cp a b &&
>> +	git add a b &&
>> +	git commit -m "level 0" &&
>> +	BLOB=$(git rev-parse HEAD:a) &&
> 
> Isn't the way we're getting this $BLOB equivalent to just 'echo bogus |
> git hash-object --stdin -w' why commit it?

We are committing it so we can add commits that deepen the copies,
but within those copies we have these known file paths.

> This whole thing makes me think you just wanted a test_perf_fresh_repo
> all along, but I think this would be much more useful if you took the
> default repo and multiplied the size in its tree by some multiple.
> 
> E.g. take the files we have in git.git, write a copy at prefix-1/,
> prefix-2/ etc.

That is essentially what is happening here, but using multiple levels
of directories. Using these multiple levels presents extra tree
lookups and parsing in the event of expanding a sparse index to a
full one.

Thanks,
-Stolee
