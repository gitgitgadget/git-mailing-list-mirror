Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153E9C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 21:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241620AbhLGVEC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 16:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbhLGVDi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 16:03:38 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25D8C0698D0
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 13:00:04 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso496910ots.6
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 13:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mB3J1g/2xaXDFBoRnNUcXD45IYF3B/Hv1Q0El3/ERno=;
        b=TSEUMBvM4BuMJhRhShPHpJ/5Zf8oh11NOikxc+qs3qFWgNfEOhXxmPc+ON5NtOr8hB
         Xv9bfRDNfQcQHjrdW5D/Xk/ff+OnRAUvRVTV1ZEaW2XqEMLQ9q30rbIzuN4TiMNE2iON
         PYZwVap/lbAr+SBmHL4T+LGyzmPM0CK9P5kyWAs+g2g0uKW9ueQsYCWyZQNN8FwkqFET
         neIGdK4GzvL5ybkPBGJtsehwaHufZ3WmoG19fmzKQwPmMQokLbvsnIE0LN+D/4FuBs6U
         fMpf4+TUGGwf2Us7Ox+yG16N5WTP3e8JtRHCc7N00LcQy1WFz2uyfOF3VIj5opxvUe2J
         TDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mB3J1g/2xaXDFBoRnNUcXD45IYF3B/Hv1Q0El3/ERno=;
        b=IRivYkJp9KALPVs7c58b53kUvTJGhlwwKHkLyxn+pJ247Gc0Tn3St/f29eQqQ2a5/O
         oZQZL96jJ/I1nNJoTumyxIpdN3QN2eDU0ZuFKhgaK/RPLoPEq2kGiIfmDsGpOUGUdGjf
         WiVf4CCnKrVh6Qc/u4eokumITY7ikX+PTC+CgZZFKSZ6Ra3FB9KFh0wkmKsDSYG8Tb/y
         wQCFb21EoHsjWObGqH4eq7yg7TsWENWKoeIgwOdv7p80JYtQgyihEQaYLIN8K+yUYLKZ
         qq68j4GMIZ9WSAYII3KiYZvw0DLJMPDAewvtowF2mgk4dmJLSb5dSjopEf9USxWKeLS4
         +6mA==
X-Gm-Message-State: AOAM533CEFFWkR7GTFVlCk792UfUTWHqqNFeahiNQLBPruXToZKUiZVT
        4bm3HBf/6nQLCFbIkicDsTQ=
X-Google-Smtp-Source: ABdhPJyJBKlKw2N5/actioIXq9QjGgEE4WP+ZhIxyLmgP5kF1KJD1wCQ755nofOgB00+c/tb9G9Tqw==
X-Received: by 2002:a05:6830:1d49:: with SMTP id p9mr37222446oth.108.1638910804035;
        Tue, 07 Dec 2021 13:00:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1d54:16a5:5c65:4b5? ([2600:1700:e72:80a0:1d54:16a5:5c65:4b5])
        by smtp.gmail.com with ESMTPSA id w80sm169289oif.2.2021.12.07.13.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 13:00:03 -0800 (PST)
Message-ID: <a6730006-bc30-d1c6-2d9a-c00df505d38d@gmail.com>
Date:   Tue, 7 Dec 2021 16:00:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v5 00/11] Avoid removing the current working directory,
 even if it becomes empty
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
 <aa85e35d-143e-93e4-f54b-146b38dd4b88@gmail.com>
 <CABPp-BHRse4BwXTjd4cRruOdymt=DJRPDL1jyPzX5HDqx4ymDw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BHRse4BwXTjd4cRruOdymt=DJRPDL1jyPzX5HDqx4ymDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2021 3:43 PM, Elijah Newren wrote:
> On Tue, Dec 7, 2021 at 8:09 AM Derrick Stolee <stolee@gmail.com> wrote:
>> There is _also_ more work to do, as follow-ups. In particular, the thing
>> that I thought about was sparse-checkout and created this test which still
>> fails at the end of your series (as an addition to t1092)
> 
> Interesting testcase...
> 
>> test_expect_success 'remove cwd' '
>>         init_repos &&
>>
>>         test_sparse_match git sparse-checkout set deep/deeper1/deepest &&
>>         for repo in sparse-checkout sparse-index
>>         do
>>                 (
>>                         cd $repo/deep/deeper1 &&
>>                         test-tool getcwd >"$TRASH_DIRECTORY/expect" &&
>>                         git sparse-checkout set &&
>>
>>                         test-tool getcwd >"$TRASH_DIRECTORY/actual" &&
>>                         test_sparse_match git status --porcelain &&
> 
> However, this line is broken even if the directory weren't removed.
> Not because of the "git status --porcelain" part, but because of two
> other reasons:
> 
> 1) test_sparse_match presumes it is run from the directory above the
> repos while you still have it in $repo/deep/deeper1
> 2) The point of test_sparse_match is to compare the results in two
> different repositories, but it'll do this twice and the first time
> without the changes having been made to the sparse-index repo.
> Perhaps this belonged outside the surrounding for loop?

You're right! I had first written this test with test_sparse_match
everywhere, but test_sparse_match uses subshells to 'cd' into different
places, so it doesn't let us get a failure in the 'test-tool getcwd'.

I missed this one because the test fails with 'test-tool getcwd' so I
never get to the broken line.

> I think I'd either drop the "test_sparse_match" or else just drop the
> whole line; the real comparison is the expect/actual files.  Dropping
> this line makes it a good test.

I agree.

>>                         cd "$TRASH_DIRECTORY" &&
>>                         test_cmp expect actual
>>                 )
>>         done
>> '
>>
>> Please do not let this test delay the advancement of this series. As we
>> find these kinds of issues, we can fix them one-by-one as needed.
> 
> Yeah, sounds good.  Since you piqued my interest, though, the problem
> is that we're passing an absolute path to remove_dir_recursively()
> inside clean_tracked_sparse_directories() when we should be passing a
> relative path.  (We always chdir(r->worktree) in setup.c, so there's
> no need to prepend the path with r->worktree+'/'.)
> 
> Still, the current series is long enough and unless there are issues
> others have spotted with it, I'd rather just let it proceed as-is and
> then send this fix and a correction of your testcase in separately.

Absolutely. Let's pick up this fix another time.

Thanks,
-Stolee
