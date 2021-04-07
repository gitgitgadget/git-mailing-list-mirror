Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA493C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 13:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899CF61284
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 13:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhDGNJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 09:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbhDGNJc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 09:09:32 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A682C061756
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 06:09:23 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id a8so18662168oic.11
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 06:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y7JweH8e3YnZcCa5ZOIP1OtHMWQDD3Nx4qG2d4PAjG8=;
        b=V5MtOC6B+RKagm8IJREP2UZrWRClw4z0pwC2phoe/ilgHRnGIad1paciT8fMbFw5PM
         O44GHtIcScKUgGO8R0RkepstWZzyesMwycbwXoAu2CIhfvLPF6DAeuBXTDouD74KYXDq
         rXOzhJSo1LHPkZl9wwpC6EFvpKq4p2N9zVCNMfxKHH6H7gA62iEioq5H0TBdkkuIS2iR
         /v7o3RyMqeVgK1jpWjB1n6dfMYgOmqNKqvkNcFhBRH3Eu+nafr5KFlbnxpGSf0isd/G7
         OXgcefY8qMosGQ+ok0xjfvdrd3iJZSy3OCs/TBKvU9t9v2BQz2aO/G2XP6ChK6W7hHzK
         JWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y7JweH8e3YnZcCa5ZOIP1OtHMWQDD3Nx4qG2d4PAjG8=;
        b=biDwkIem6E7uUZ1l3FKS4ePIzQrMoad1U5ZfbC/rnuVoGeajEjBp7vnO8T50Rre6Bc
         hA8WJqwJRYoMxqi9BQXIzJAmI4BSHYqjq0c3jPhB0iDqd1RJqwfcVkfx2oF+wIVU2b6X
         dR4h/ce2AXkJZ6bCZrltAVXkrLxodXQCKVHWLbDLq37BPapjsoUhDR/SkiohuwsA/w9R
         5JlbtlRMe5p+gqOKSRAXEq19fW7/K1Ctp24AOPsKNkWGPraJSHDJWDeKz1xH6sqtuZST
         lG0KRe4Q2sssmQF47hvx0yfzA+7nGG2I0IpUkG1r/4iz3PyIUZK28V+Ve98Nfc/Wru2r
         4IyA==
X-Gm-Message-State: AOAM530TN5v5g1LL1LOcXCr1sSJElQ7vX9iSt0EQnGbobvS+HwIpQ1ho
        spF9i+eAvDt6L9kDWh3I1OuNK84tyFtshg==
X-Google-Smtp-Source: ABdhPJzK7Q58e95L1jFU6gYryuXHypDE+VjNjK4UNmnEE28GYpZ8rvm4RPWrd2K7Wzt+DGDqNsq1LA==
X-Received: by 2002:aca:c087:: with SMTP id q129mr2192998oif.32.1617800962270;
        Wed, 07 Apr 2021 06:09:22 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f1c4:b701:47c1:603f? ([2600:1700:e72:80a0:f1c4:b701:47c1:603f])
        by smtp.gmail.com with ESMTPSA id i25sm5553351otf.37.2021.04.07.06.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 06:09:21 -0700 (PDT)
Subject: Re: [PATCH v2] hooks: propose project configured hooks
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Albert Cui <albertqcui@gmail.com>,
        Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com>
 <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
 <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com>
 <YGzrfaSC4xd75j2U@camp.crustytoothpaste.net>
 <87tuoijzsy.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9af3770f-204b-253b-d7f2-c9d5e7cf2fdb@gmail.com>
Date:   Wed, 7 Apr 2021 09:09:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87tuoijzsy.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/7/2021 3:53 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Apr 07 2021, brian m. carlson wrote:
>>
>> I continue to have serious reservations about this series and approach,
>> and I'm not sure that any proposal we can adopt here will address the
>> security concerns.  To be frank, I don't think this proposal should move
>> forward in its current state or otherwise, since I think the security
>> problems are inherent in this approach and fundamentally can't be fixed.
>>
>> This is, as should be obvious from my email address, my personal
>> opinion, despite my reference to my employer above.  Unless otherwise
>> stated, I don't speak for my employer and they don't speak for me.
> 
> I agree with pretty much every word you said, in particular the social
> engineering aspect of this. In past mails I've referred to elsewhere
> I've proposed some Emacs-like "ask" facility for git, but you've
> convinced me that that default would be a bad idea for the "user just
> clicks yes no matter what" reasons you noted.

These replies definitely speak from a perspective common to mine.
This is very dangerous territory and should be handled carefully.

There is also a legitimate user need to use hooks _to contribute_
to some repositories. Hooks are not needed to read the repositories
or interact with them as a document.

The current mechanisms require ad-hoc approaches that are custom to
each project, so there would be value in creating a standard inside
the Git client itself. I think the proposal goes too far in making
this an automatic configuration, either because it assumes trust or
assumes sufficient skepticism on behalf of the users. Either is not
acceptable for the Git project.

Here are the hard lines I draw:

1. This should not happen in "git clone" (other than maybe a message
   over stderr that hooks are available to be configured through a
   different command).

2. Hooks should not update in "git checkout" (other than a message
   that hooks have updated).

3. Whatever document triggers a hook configuration should live at
   HEAD and should not be configured or updated until HEAD has been
   updated by one Git command (git clone, git checkout), time
   passes for the user to inspect the worktree, then _another_
   command (git hooks?) is run manually to reconfigure the hooks.

I think there is a potential way forward if these items are followed.

But I'd like to ask a different question: What problems are these
custom hooks solving, and can Git solve those problems in-core?

If we care about checking commits for format or something, is that
a common enough problem that we could implement it in Git itself and
enable it through a Git config option? It might be interesting to
pursue this direction and maybe we'll solve 80% of the need with
extensions like that.

I'm aware of some hooks that insert things like a Gerrit change-id
that would probably not be appropriate for such an in-core change.

There is always the extreme option of requiring users to use a
specific fork of Git in order to work with your repository. That
has its own pains, believe me. But, it does allow for the ultimate
flexibility in how these things are done. Optional config can be
enabled by default. Hooks can be replaced with in-core functionality.

Thanks,
-Stolee
