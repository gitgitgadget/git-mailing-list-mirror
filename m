Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E22C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725826115C
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 19:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241759AbhIHTrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbhIHTro (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:47:44 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D50C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 12:46:34 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id w78so3887100qkb.4
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DEKAikD3cz7czfnlTlJzHKxLrFrCESe0Fy1xSqQe4IA=;
        b=bCxgLh5nbIGlRBF36KaRDYE1/p7WL92Axz0FXuBNhjlGnk2KglvoyuE6aQvcX4UUra
         FT9TE2JtIZu6BtAnJ/5uYydKMrbeqOvNZiwiAqWmqZBh7SutB5Jm3QRiCiN/EduNNz5E
         7eAsymgWUioCqtY/oSQp/SzUQ+QvT3N4oHJTBVkg6KcPoWq841KR3SY+J1SviUUXlgBn
         h98LVoz7YMI098WzClGydCsDNh9J5QS5IFhPD3Ypp6wc61KcackgK2liPGGMC1NcDJtA
         8Dx1qvjpnWwPpe3Xmtv/Ql3a/MGWt+ACtWkJEkrp/UCVmGqO33IImoacPaONL/+Yznzz
         LxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DEKAikD3cz7czfnlTlJzHKxLrFrCESe0Fy1xSqQe4IA=;
        b=UbtXoxKDBZtTCchC+r04KctfG5WabUqWFWFnjdNy8D7AgyVWsqKa83i0PQ4pWHXBHy
         ayVSTmtdzx3CWdXh+CQ1mXWtIzCMDdhB2aRSjkvFpETSU4SJL2daRQm9UTdDDqokHxW8
         fOGeTlqlNJlDcsvABq6OfxcwmbZXVZTxC9oNjL/F13QZwouC0zzfEL3qLH7j1JrzXZv3
         IO3a3PvfzdSYxLuoDcyjJ6kcSDhAeYG40NxA93vxpBQhmdb0KCfH1AxRIVBnEPCN3LGK
         vcNoEwOYp2olXdD3eU4NX+/wpgQXZnX5BelCt+/wEfHwoIV4sRyXcxJoeenIFSfh93D5
         KF5A==
X-Gm-Message-State: AOAM5327WGlJcj6kbnYABfa193m7ogwLIXYLygbn9XeHjiuQqAFwitPF
        oAVNYthtLwGMvG5snFIOwh4=
X-Google-Smtp-Source: ABdhPJz3luw9fF6bKy7pmsimyCDNLiQ3pVgjXQg/bexd28WLRKYhjqtfx5e1lIoSx3xbC0BTiM5bLg==
X-Received: by 2002:a37:a596:: with SMTP id o144mr5346287qke.135.1631130393735;
        Wed, 08 Sep 2021 12:46:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79fe:8f64:ef46:a881? ([2600:1700:e72:80a0:79fe:8f64:ef46:a881])
        by smtp.gmail.com with ESMTPSA id v14sm53295qkb.88.2021.09.08.12.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 12:46:33 -0700 (PDT)
Subject: Re: [PATCH 06/13] add: skip paths that are outside sparse-checkout
 cone
To:     Matheus Tavares <matheus.bernardino@usp.br>, gitgitgadget@gmail.com
Cc:     derrickstolee@github.com, dstolee@microsoft.com,
        git@vger.kernel.org, gitster@pobox.com, newren@gmail.com
References: <eeba97ad492307302637faf33f6bf6ae8965faa3.1629842085.git.gitgitgadget@gmail.com>
 <20210827211310.108999-1-matheus.bernardino@usp.br>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <28762f8f-d9b4-caf8-18b5-3cdbf6b59a7d@gmail.com>
Date:   Wed, 8 Sep 2021 15:46:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210827211310.108999-1-matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/27/2021 5:13 PM, Matheus Tavares wrote:
> On Tue, Aug 24, 2021 at 6:54 PM Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com> wrote:
>>
>> Subject: [PATCH 06/13] add: skip paths that are outside sparse-checkout cone
> 
> Perhaps this could be "skip _tracked_ paths that ..." (to help
> differentiate the end goal of this patch from the previous one).
> 
>> diff --git a/pathspec.c b/pathspec.c
>> index 44306fdaca2..0e6e60fdc5a 100644
>> --- a/pathspec.c
>> +++ b/pathspec.c
>> @@ -39,7 +39,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>>                 return;
>>         for (i = 0; i < istate->cache_nr; i++) {
>>                 const struct cache_entry *ce = istate->cache[i];
>> -               if (sw_action == PS_IGNORE_SKIP_WORKTREE && ce_skip_worktree(ce))
>> +               if (sw_action == PS_IGNORE_SKIP_WORKTREE &&
>> +                   (ce_skip_worktree(ce) || !path_in_sparse_checkout(ce->name, istate)))
> 
> Hmm, even though we skip the sparse paths here, cmd_add() will call
> add_files_to_cache() at the end and still update these paths in the
> index. I think there are two ways to fix this. We could either change
> run_diff_files() to skip these paths (but I don't know how other callers
> of this functions want to handle this, so maybe this needs to hide
> behind an option flag):

You are absolutely right to point this out. I had missed this interaction.
But, this is also already broken. The patch below adds a check to show that
'git add' does not add the sparse_entry, but it does (even when applied
before any patch in this series). That is: all the modified tests fail
after this change. I'll work to fix this issue before the next version of
this series.

Thanks,
-Stolee

--- >8 ---

From 21dab466d221e8632d98553f5f1fa900a2d47c7f Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Wed, 8 Sep 2021 15:40:32 -0400
Subject: [PATCH] t3705: test that 'sparse_entry' is unstaged

The tests in t3705-add-sparse-checkout.sh check to see how 'git add'
behaves with paths outside the sparse-checkout definition. These
currently check to see if a given warning is present but not that the
index is not updated with the sparse entries. Add a new
'test_sparse_entry_unstaged' helper to be sure 'git add' is behaving
correctly.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t3705-add-sparse-checkout.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 2b1fd0d0eef..d31a0d4f550 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -36,6 +36,11 @@ setup_gitignore () {
 	EOF
 }
 
+test_sparse_entry_unstaged () {
+	git status --porcelain >actual &&
+	! grep "A  sparse_entry" actual
+}
+
 test_expect_success 'setup' "
 	cat >sparse_error_header <<-EOF &&
 	The following pathspecs didn't match any eligible path, but they do match index
@@ -55,6 +60,7 @@ test_expect_success 'git add does not remove sparse entries' '
 	setup_sparse_entry &&
 	rm sparse_entry &&
 	test_must_fail git add sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	test_sparse_entry_unchanged
 '
@@ -73,6 +79,7 @@ test_expect_success 'git add . does not remove sparse entries' '
 	rm sparse_entry &&
 	setup_gitignore &&
 	test_must_fail git add . 2>stderr &&
+	test_sparse_entry_unstaged &&
 
 	cat sparse_error_header >expect &&
 	echo . >>expect &&
@@ -88,6 +95,7 @@ do
 		setup_sparse_entry &&
 		echo modified >sparse_entry &&
 		test_must_fail git add $opt sparse_entry 2>stderr &&
+		test_sparse_entry_unstaged &&
 		test_cmp error_and_hint stderr &&
 		test_sparse_entry_unchanged
 	'
@@ -98,6 +106,7 @@ test_expect_success 'git add --refresh does not update sparse entries' '
 	git ls-files --debug sparse_entry | grep mtime >before &&
 	test-tool chmtime -60 sparse_entry &&
 	test_must_fail git add --refresh sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	git ls-files --debug sparse_entry | grep mtime >after &&
 	test_cmp before after
@@ -106,6 +115,7 @@ test_expect_success 'git add --refresh does not update sparse entries' '
 test_expect_success 'git add --chmod does not update sparse entries' '
 	setup_sparse_entry &&
 	test_must_fail git add --chmod=+x sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	test_sparse_entry_unchanged &&
 	! test -x sparse_entry
@@ -116,6 +126,7 @@ test_expect_success 'git add --renormalize does not update sparse entries' '
 	setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
 	echo "sparse_entry text=auto" >.gitattributes &&
 	test_must_fail git add --renormalize sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	test_sparse_entry_unchanged
 '
@@ -124,6 +135,7 @@ test_expect_success 'git add --dry-run --ignore-missing warn on sparse path' '
 	setup_sparse_entry &&
 	rm sparse_entry &&
 	test_must_fail git add --dry-run --ignore-missing sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp error_and_hint stderr &&
 	test_sparse_entry_unchanged
 '
@@ -148,6 +160,7 @@ test_expect_success 'do not warn when pathspec matches dense entries' '
 test_expect_success 'add obeys advice.updateSparsePath' '
 	setup_sparse_entry &&
 	test_must_fail git -c advice.updateSparsePath=false add sparse_entry 2>stderr &&
+	test_sparse_entry_unstaged &&
 	test_cmp sparse_entry_error stderr
 
 '
-- 
2.33.0.vfs.signtest.55.g904c8365e91
