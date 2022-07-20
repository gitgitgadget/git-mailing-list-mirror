Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4883EC433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 01:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbiGTBvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 21:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbiGTBvD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 21:51:03 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0197127B27
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 18:51:01 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id c17so7650207ilq.5
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 18:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=d04+Djh1T/rNSIejoUv9geZmofJNQhEhpmDJ9t+OE3U=;
        b=LbDAPC9mFCPzUhDTz3pDUcZ++s6FgqFUPfebaKVi2KSl1kyXtKzvC1faBTi8XCUBQh
         gNjwsHzYsmBPRSkrXvavt5X2pxugCgJL8LNkQkHSDsUR88m/ZJbm7JUY/CIh+qUqZe4p
         SpL4EN3S+6JsBrweI3ZZdmLs5sRfut/GrBs1qpSji1UecSND/jJ9Byle8J2lPaWcoDzP
         PAcUL5F3u5TUO3o9/sLc0XxxkxKDlcAawCNSOUWYeHVaELVjnyguhfueaYRCozObEvvV
         V6OBGJByuE5mk9i+Yxe5L8qeZDMYOIPLzXT8bTsdEIk8D5h292vPDM1NvshxSFdnUfx1
         2BWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d04+Djh1T/rNSIejoUv9geZmofJNQhEhpmDJ9t+OE3U=;
        b=IxKkgYzGvH+crm7zfQpfs1zXOLzl9rg3QoGaqvBr0chVonlUa4f4VOlzdolu+rKGvF
         T9zBPulX3+zc/50onkC28tuOehEZ+5efHmXSfc8R04sEFHly95HmfVgHD9vDapYbywPJ
         7Li8hb4MwFIfebsVnpmC1IOKy79WJzrdeeXyvKD32kAA4EGUisNh++ruf6mAQVWUgvWR
         mzSvD4wAOtia6euQcyLM+benqSbfTWLXsSmStMxX+NrO52pWH1MX7vn7SXUuBQuf7Q1f
         o9Z+TR0A/DbAmCW6sKFZMBvrnf04VexghHwgOBxZVNZ5t+ww3pmArFgfaTTvfbrV1qWT
         fIyA==
X-Gm-Message-State: AJIora+TDJ5bSMxg9/DzaL578ctmb1al0pGIMq3z5Qvli/VKMyZ+EYlw
        mlgNEC0KtPs9H5//F9LtLb5n
X-Google-Smtp-Source: AGRyM1vgOi3JvBewPrcLQ2RLTCAjhkk3++Md2WVKh+dDqa/pK3to2arweLw6MWgL1+wsmZo/zSvN6w==
X-Received: by 2002:a92:da4c:0:b0:2dc:f5c2:e425 with SMTP id p12-20020a92da4c000000b002dcf5c2e425mr5091360ilq.22.1658281860386;
        Tue, 19 Jul 2022 18:51:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d574:b134:aa04:ad2c? ([2600:1700:e72:80a0:d574:b134:aa04:ad2c])
        by smtp.gmail.com with ESMTPSA id z15-20020a056638214f00b0033ecf524aecsm7461715jaj.3.2022.07.19.18.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 18:51:00 -0700 (PDT)
Message-ID: <fa01e4af-3744-e719-6916-4d7776da3d9a@github.com>
Date:   Tue, 19 Jul 2022 21:50:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 09/10] leak tests: mark passing SANITIZE=leak tests as
 leak-free
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com>
 <patch-09.10-b75b93822e1-20220719T205710Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <patch-09.10-b75b93822e1-20220719T205710Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2022 5:05 PM, Ævar Arnfjörð Bjarmason wrote:
> Mark those remaining tests that pass when run under SANITIZE=leak with
> TEST_PASSES_SANITIZE_LEAK=true, these were either omitted in
> f346fcb62a0 (Merge branch 'ab/mark-leak-free-tests-even-more',
> 2021-12-15) and 5a4f8381b68 (Merge branch 'ab/mark-leak-free-tests',
> 2021-10-25), or have had their memory leaks fixed since then.
> 
> With this change there's now a a 1=1 mapping between those tests that

nit: here's another use of "1=1" which I read as "one equals one" and
not "one-to-one", so please expand into the words.

> we have opted-in via "TEST_PASSES_SANITIZE_LEAK=true", and those that
> pass with the new "check" mode:
> 
>     GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_SANITIZE_LEAK_LOG=true make test SANITIZE=leak

Maybe split this line?

	GIT_TEST_PASSING_SANITIZE_LEAK=check \
		GIT_TEST_SANITIZE_LEAK_LOG=true \
		make test SANITIZE=leak

> Note that the "GIT_TEST_SANITIZE_LEAK_LOG=true" is needed due to the
> edge cases noted in a preceding commit, i.e. in some cases we'd pass
> the test itself, but still have outstanding leaks due to ignored exit
> codes.
> 
> The "GIT_TEST_SANITIZE_LEAK_LOG=true" corrects for that, we're only
> marking those tests as passing that really don't have any leaks,
> whether that was reflected in their exit code or not.

This paragraph repeats the previous one, but with different words.
Consider removing it.
 
>  t/t0027-auto-crlf.sh                | 1 +
>  t/t0032-reftable-unittest.sh        | 1 +
>  t/t0033-safe-directory.sh           | 1 +
>  t/t0050-filesystem.sh               | 1 +
>  t/t0095-bloom.sh                    | 2 ++
>  t/t1405-main-ref-store.sh           | 1 +
>  t/t1407-worktree-ref-store.sh       | 1 +
>  t/t1418-reflog-exists.sh            | 1 +
>  t/t1701-racy-split-index.sh         | 1 +
>  t/t2006-checkout-index-basic.sh     | 1 +
>  t/t2023-checkout-m.sh               | 1 +
>  t/t2205-add-worktree-config.sh      | 1 +
>  t/t3012-ls-files-dedup.sh           | 1 +
>  t/t4017-diff-retval.sh              | 1 +
>  t/t4051-diff-function-context.sh    | 1 +
>  t/t4057-diff-combined-paths.sh      | 1 +
>  t/t4114-apply-typechange.sh         | 1 +
>  t/t4301-merge-tree-write-tree.sh    | 1 +
>  t/t5315-pack-objects-compression.sh | 1 +
>  t/t5351-unpack-large-objects.sh     | 1 +
>  t/t5402-post-merge-hook.sh          | 1 +
>  t/t5503-tagfollow.sh                | 1 +
>  t/t6404-recursive-merge.sh          | 1 +
>  t/t6405-merge-symlinks.sh           | 1 +
>  t/t6408-merge-up-to-date.sh         | 1 +
>  t/t6411-merge-filemode.sh           | 1 +
>  t/t6413-merge-crlf.sh               | 1 +
>  t/t6415-merge-dir-to-symlink.sh     | 1 +
>  t/t6425-merge-rename-delete.sh      | 1 +
>  t/t6431-merge-criscross.sh          | 1 +
>  t/t7060-wtstatus.sh                 | 1 +
>  t/t7062-wtstatus-ignorecase.sh      | 1 +
>  t/t7110-reset-merge.sh              | 1 +
>  t/t7111-reset-table.sh              | 1 +
>  t/t7609-mergetool--lib.sh           | 1 +
>  t/t9100-git-svn-basic.sh            | 1 -
>  t/t9901-git-web--browse.sh          | 1 +

That's a lot of tests that we can mark as having no leaks. Nice.

I imagine that after this series cooks for a while we can consider
running this check in CI. That is, unless it's prohibitively
expensive to run under SANITIZE=leak.

Thanks,
-Stolee
