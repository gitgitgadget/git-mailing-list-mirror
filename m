Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D898C433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4723B64F21
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhCQU4B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbhCQUzf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:55:35 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3EEC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:55:35 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso3109929ott.13
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9uK0IuMZqPQBSIsP91pGf/+QnZhyE+TSMjC1LpXw7nc=;
        b=tNWY6NLr6o4Y+afC7loUYsLmm/kWe5HJDapkU47xxYMBZehiH3Vxsm3Fzmwirw41wc
         fvaE0h7yhcJRwwOk+NlxbM1F6iYH9pwS2WP08pF0uOavZ53q8qnmyUs2PSjdmcKYTcDK
         jFmRc0/st5Plm0/nziODWWMqciPvQ+QVbRvzh2lYKqZQJWijErSHOnSYvUO7ieUL2o31
         T/noaqW9iM5y3H0o3GC6HFMs1242LAq9cXC7doDPlydoEI3z8bcTY/j+/RquzGxMVvIw
         +WhXIIY0MBJHRHT2g9uSQvCN31nyMYqnOBZ/zRiI/SRDbgWGtzSdOIsyDHfePt4AADSu
         sF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9uK0IuMZqPQBSIsP91pGf/+QnZhyE+TSMjC1LpXw7nc=;
        b=R9drklCaoEPNdS+uhjacZlFec2zzjGF9uny0/8FuH0QE7XrCAL1LfQXyLCtMSlWbbn
         AKUgRZOsS8LshfZVAwbHgAKxtUKY6RkXCJGKr418ITTDEaCrZxCCG4IpQjkjtsrWFMSp
         4FFaMzgGBMhh8hTJQq/vmRkDtVUsZubqNMLzy5kRgjvwrYSZ6irztpCZQhoR3g6XFUP1
         rZtOIBfuUKMWbeAO8ksq+O1Zk3mWw4tJkr0jqHFWLf5IQkcSH4gVLGXSIspIQVQDo37L
         haIFMDK+jNvbbXGncUWDhqmW2XaZkrW4/lR2aEeR2lPpAuDedONHv7VkQU+5UyKbOPG0
         cxdg==
X-Gm-Message-State: AOAM531HZVDAY8rTyfyfmLkOTerygc2WS26hpkkijPuxzPXbf/wMRCA3
        rKgL9RPpl5KcyR6roV4EkuY=
X-Google-Smtp-Source: ABdhPJw79d9QvRGQeP/NRitzQxFEYoTD8SJEyMRHsJ70M/8jw0pnPNZ0VDkRY+AeYXtjmL4tOeG4UQ==
X-Received: by 2002:a05:6830:1613:: with SMTP id g19mr4841156otr.157.1616014534540;
        Wed, 17 Mar 2021 13:55:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5df9:6440:37ca:197f? ([2600:1700:e72:80a0:5df9:6440:37ca:197f])
        by smtp.gmail.com with ESMTPSA id f8sm40079oij.4.2021.03.17.13.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 13:55:34 -0700 (PDT)
Subject: Re: [PATCH 05/27] add: ensure full index
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
 <142df1ab8e3e8ea5e213f2477e271e60e5b62f84.1615929436.git.gitgitgadget@gmail.com>
 <CABPp-BHyCDJH-78XGdW5TxAOPjDE669LL21yTY3NdmCP7iSMRA@mail.gmail.com>
 <CAHd-oW4DMAjQ_Gjbzkx6csFRAK1iKHsTfuJLniOjWehwrnHdVQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <862197d9-ca71-f682-f03f-62e45ea921ee@gmail.com>
Date:   Wed, 17 Mar 2021 16:55:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHd-oW4DMAjQ_Gjbzkx6csFRAK1iKHsTfuJLniOjWehwrnHdVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2021 4:35 PM, Matheus Tavares Bernardino wrote:
> On Wed, Mar 17, 2021 at 2:36 PM Elijah Newren <newren@gmail.com> wrote:
>>
>> On Tue, Mar 16, 2021 at 2:17 PM Derrick Stolee via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:>> I'm not so sure about this one; from git-add(1):
>>
>>        --renormalize
>>            Apply the "clean" process freshly to all tracked files to forcibly
>>            add them again to the index. This is useful after changing
>>            core.autocrlf configuration or the text attribute in order to
>>            correct files added with wrong CRLF/LF line endings. This option
>>            implies -u.
>>
>> ... to "all tracked files".  Should that be interpreted as all files
>> within the sparsity paths, especially considering that we're trying to
>> enable folks to work within the set of files of interest to them?

I wrote in reply to another similar comment that I'm being overly
cautious in creating these protections. When I can come back later
with careful tests, we can ensure that everything behaves properly.

> I had the same question when working on the add/rm sparse-checkout
> series. As seen at [1], --renormalize and --chmod are, currently, the
> only options in git-add that do not honor the sparsity patterns and do
> update SKIP_WORKTREE paths too.
> 
> But is this by design or possibly just an oversight? In my series I
> ended up making both options honor the sparsity rules, with a warning
> when requested to update any sparse path. (If we are going with this
> approach, perhaps should we also amend the docs to remove any
> ambiguity as for what "all tracked files" means in this case?)

I'd be happy to see a resolution here, and it can happen in parallel
to what I'm doing here.

>> The code below already has the following check below:
>>
>>     if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
>>       continue; /* do not touch non blobs */
>>
>> suggesting that it'd correctly skip over the sparse directories, so I
>> think this one just isn't needed.
> 
> But if sparse index is not enabled, it does not skip over the sparse
> files, right? So isn't the ensure_full_index() call here (and in
> chmod_pathspec()) important to be consistent with the case when sparse
> index is not in use?

The tests I am adding in t1092-sparse-checkout-compatibility.sh are
focused on ensuring the same behavior across sparse-checkouts with
and without the sparse-index, and also a full checkout (when possible).

Since the sparse-index requires cone-mode sparse-checkout (currently),
and the sparse files to be within a directory (or no index change
happens), the tests you created in t3705-add-sparse-checkout.sh don't
seem to apply. I'll need to find some important scenarios to duplicate
in t1092 without the full depth of t3705.

> Or maybe Stolee could rebase this on top of my
> series, where both these places already skip the sparse paths?
> (Assuming that's the behavior we are looking for. If not, I can also> fix my series.)

I think they can proceed in parallel and then continue more carefully
in the future. The series _after_ this one makes 'git status' and
'git add' work with the sparse-index, so at that point we will be
removing these protections at the right time, with tests. In addition,
those tests will ensure that we don't expand the sparse-index unless
absolutely necessary.

If that work collides with your approach, then I'll rebase onto a
merge of that topic and this one.

> [1]: https://lore.kernel.org/git/d93c3f51465a3e409819db63bd81802e7ef20ea9.1615588108.git.matheus.bernardino@usp.br/
 
(I will go take a look over here. I've been ignoring the thread for
too long.)

Thanks,
-Stolee
