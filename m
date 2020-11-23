Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAB4C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 15:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC5320773
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 15:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8gLWoxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389438AbgKWPSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 10:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732106AbgKWPSo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 10:18:44 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0F0C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 07:18:44 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 79so16189485otc.7
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 07:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ne/N0p1SY+oUqe+J7uyqfVYBMGwnSFqJazBPJlTBYO8=;
        b=P8gLWoxoijnnL4CXclt6ZnkDX7IjwvBHvqDASiQ4VUPJhEtrNcOQpJvXDc5BSyyiIn
         thrhCYGIyOhasR+rPuvNzA4FveMQsyXMQ01VGpdnDAFsW5VUb1KSqy8B2W1g27CIMAuh
         o+vlwDOho4CZlkkC1ImDKk9k2M3ph0qnGfMKUORRpnw0Gor+SdzblvsZKzGLg4+0LUju
         T/6RN/avtfoLRuathixtUN2594jEFG5+8eAOIqKkxdUPFWU6Y4S5/06ZnBZlHuVEc26/
         5UgFksM9MM8QJe+NOFw5FnUtWko6f5MfU3J6hQntt/4iMYp1CbzCp61NtNg1ExTfLrp3
         WQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ne/N0p1SY+oUqe+J7uyqfVYBMGwnSFqJazBPJlTBYO8=;
        b=g10PfEc/TXXKmHMCqwMN8cePayrxkAlToO2k3vevTKIEfEPxe7vBpwoxNg6XMn+Whi
         4jVqZGpqG0Jne5pjiDsvKNVtCwdsH9FXNE1Sumtwk0prEb+IKYPRbMRq98njqd2pvKGV
         rMqtBjKImluPi04PlxIjcqQUx09HlvZWeHvHcBAtWqkHN1RgXYtidWr1Z86o4+dOocHD
         NoL6O1/+GkfLS014Eqljybqw35JbNRlslEBAXZw4MKm0Lm1iQSAuLtKCK/INena26HWT
         uF0ZizWTdJY4/QCVeAUSG2Nd+8wb0n6PFY9jaTwpSO9b+oCOlo9hqA1WVSeweejCWHeS
         u9mw==
X-Gm-Message-State: AOAM531sGfvEJn3DCqwNU12vRDIZKko4QQee6duEumlGWfk0I2GYGm/v
        pZHNIenNBf/2NFylKaWgHz0=
X-Google-Smtp-Source: ABdhPJxIlSV3N8ODmK81v6kPgoN7Q/XRWunBKba4vQ9IdvgRPgbmFAH1tkrfzrHmZd4PmuZRRa3mzQ==
X-Received: by 2002:a05:6830:104f:: with SMTP id b15mr4315231otp.20.1606144723771;
        Mon, 23 Nov 2020 07:18:43 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id r4sm7585418ooa.29.2020.11.23.07.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 07:18:43 -0800 (PST)
Subject: Re: [PATCH] clone: --filter=tree:0 implies fetch.recurseSubmodules=no
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.797.git.1605904586929.gitgitgadget@gmail.com>
 <20201121000436.GB353076@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8a31af0e-4440-d957-11fb-48c4d2abd5c7@gmail.com>
Date:   Mon, 23 Nov 2020 10:18:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201121000436.GB353076@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20/2020 7:04 PM, Jeff King wrote:
> On Fri, Nov 20, 2020 at 08:36:26PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> I decided that even if I did populate the submodules, the nature of
>> treeless clones makes me not want to care about the contents of commits
>> other than those that I am explicitly navigating to.
>>
>> This loop of tree fetches can be avoided by adding
>> --no-recurse-submodules to the 'git fetch' command or setting
>> fetch.recurseSubmodules=no.
>>
>> To make this as painless as possible for future users of treeless
>> clones, automatically set fetch.recurseSubmodules=no at clone time.
> 
> I think it's definitely worth adjusting the defaults here to make this
> less painful out of the box. But I wonder if this is too big a hammer,
> and the on-demand logic just needs to be a bit less aggressive.

Yes, you are probably right.

I really should have labeled this patch as "RFC" as that was my intent.

> If I clone with tree:0, I'm still going to get the tree for the thing
> I'm actually checking out (assuming a non-bare repo). It would be
> reasonable to recursively fetch the submodules in that commit to
> check them out (assuming you specified --recurse-submodules).
> 
> If I then fetch again, I'll end up with another tree that I'm about to
> checkout. So likewise, would it make sense to fetch any updates from
> there?

One thing that is different is that we will fetch the trees we need
_during that checkout_, so why do it preemptively in the fetch?

Further, the number of trees being fetched is _not_ the number of ref
tips, but seems to be related to the total number of commits different.
There must be a rev walk looking for which commits changed the modules
file or the commit link in the root tree.

> I.e., I think the problem is that whether or not cared about submodules
> in the first place, the default "on-demand" setting of fetch.submodules
> is very eager to poke through history looking at the .gitmodules file to
> see if there is anything worth also fetching. But:
> 
>   - if we know there are no active submodules in the first place
>     (because you did not say --recurse-submodules), should it skip that
>     poking? That seems like it shouldn't be too hard.

This is a good direction to pursue.

>   - during its poking, should it set the necessary variables so that it
>     never demand-fetches from a promisor remote? I suspect this part
>     may be hard, because "fetch" and "checkout" are distinct operations
>     (so during the "fetch" we don't yet have the new tree demand-fetched
>     by checkout; in fact the user might not even be interested in
>     checking it out yet).

I also think this is a good idea. In particular, should we consider
making the "submodule fetch" be part of the "promisor"? That is, we
only fetch our submodule on checkout? Can we assume that the commit
will still exist on the remote, to some extent?

Naturally, this only really applies for --filter=tree:0, since in cases
like blobless clones, we would still want the commits and trees from the
submodule.

> Given the difficulties in the latter case, this may be the best we can
> do. But in that case, what happens when we _do_ care about submodules,
> and do:
> 
>   git clone --recurse-submodules --filter=tree:0 ...
>   git fetch
>   git merge origin
> 
> Will we correctly fetch-on-demand the submodules we need during the
> merge operation? If so, then that user experience is probably pretty
> reasonable.

Hopefully. Notably, the filter option does _not_ apply recursively
to the submodules, so even if we try to make the superproject a partial
clone, the submodule is not partial.

More research is required. Let's drop this patch, as I don't currently
have time to do the necessary deep dive. If someone else has time to
look into this, I'd be happy to review a better patch.

Thanks,
-Stolee


