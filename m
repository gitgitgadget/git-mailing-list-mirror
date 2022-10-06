Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05A4C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 18:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiJFS1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 14:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJFS1l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 14:27:41 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71249B275A
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 11:27:40 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id i9so1738778qvo.0
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 11:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GuHImz7U4Z/Wqd0xqnP7LyjnYtSh6toTtYFZYk8E2Cg=;
        b=fG1X7/ugAOB7XkZ67J9m22G5OIcIE9ic1tpOtc651lZXJcLs2AYXiRrv3r1PZzeyuX
         eqY/+AlUoC8JoWh2RbWHhi5wifocAuA1f9qGY5FZe+fXBxENojAU6MVCg9JZMigfpy9N
         piHtl/8c/z0VuE++5sthhBYi2UQbjkxpz//4N7HsFqUgQFTPrWKgKAQDeSHgxuckYLH5
         V5iy0rGpNJoWeXU/LwcdZIkJSnEiyLLeCN5XtLJKQ9+5yqOfDMr9nMfBTAQ3PFXP7Z2+
         qYl0beeYtggZQC6dqPKmVhnBZZ5E5fcDK4lPrd4P9Uh0mZNighz1GNpfF2r5OWGRu6gl
         iF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GuHImz7U4Z/Wqd0xqnP7LyjnYtSh6toTtYFZYk8E2Cg=;
        b=XODvu3IYpF/RA5TGq0DZIYdEGbxewdM/26hCPr5l7NwNXQNPlQfcNHCAzxYZEVDP9d
         tO92c6tUgh/dNlhdq3mhEOmr4oVKIvSc2O1stJI45RTlqYnTf2dd14YPBYFQufRPp4fi
         A8MQVMui+ot9iLuUvgFP4woHns2es2+ceofIb+SPfyLP/KK8DbJcepJsXJaTdCNPRSte
         +3bfX82zYRQ7FUCHhdgTU8mmBj19gv5/g/+9AlLgPgFPZ0X/5vIaYXgZP63WGWw7oR9a
         CJuB3cPYk/7k5oDlETp1ofTfhpXjPTnVrXvAYUUb1K9zspTSR/uocDd+grwan7hElKBH
         hogw==
X-Gm-Message-State: ACrzQf2bVbNtuAZZpaGAvnmW4xdW/MmwJT9G/7a1I6erRnYSzndO6BIS
        8uh5RaSBRtRCHvPK3UxCAkdL
X-Google-Smtp-Source: AMsMyM6yMif70MQdMRjdDzf1KtjUDKXqADHDCNs1U0pR1KafuFn98HTU6ZOftuRIWidKLKWiOvD7LA==
X-Received: by 2002:a0c:9c8b:0:b0:4b1:ac82:5c50 with SMTP id i11-20020a0c9c8b000000b004b1ac825c50mr995834qvf.15.1665080859471;
        Thu, 06 Oct 2022 11:27:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:2185:e582:857d:e0db? ([2600:1700:e72:80a0:2185:e582:857d:e0db])
        by smtp.gmail.com with ESMTPSA id f14-20020ac8014e000000b0034355a352d1sm169354qtg.92.2022.10.06.11.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 11:27:37 -0700 (PDT)
Message-ID: <66eaae96-7b6a-ca87-fee5-e185a560744a@github.com>
Date:   Thu, 6 Oct 2022 14:27:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] sparse-checkout.txt: new document with sparse-checkout
 directions
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1367.git.1664064588846.gitgitgadget@gmail.com>
 <07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com>
 <CABPp-BEjVv1ASdQhXGh6KuDfPt_nhZpRO_Q0i1pCqrV2wVQ9yQ@mail.gmail.com>
 <5d926706-6ca3-ce07-f8f2-771fe126450b@github.com>
 <CABPp-BGoJqtx_=p+GfqAhgs+4Zic1mcbs6pkMKy7QAnxTwB4AA@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BGoJqtx_=p+GfqAhgs+4Zic1mcbs6pkMKy7QAnxTwB4AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/6/22 3:10 AM, Elijah Newren wrote:
> On Wed, Sep 28, 2022 at 6:22 AM Derrick Stolee <derrickstolee@github.com> wrote:
>>
>> On 9/28/22 1:38 AM, Elijah Newren wrote:
>>> On Tue, Sep 27, 2022 at 9:36 AM Derrick Stolee <derrickstolee@github.com> wrote:
>>>>
>>>> On 9/24/2022 8:09 PM, Elijah Newren via GitGitGadget wrote:
>>>>> From: Elijah Newren <newren@gmail.com>
>>>>
> [...]
>>>>> +  * Commands whose default for --restrict vs. --no-restrict should vary depending
>>>>> +    on Behavior A or Behavior B
>>>>> +    * diff (with --cached or REVISION arguments)
>>>>> +    * grep (with --cached or REVISION arguments)
>>>>> +    * show (when given commit arguments)
>>>>> +    * bisect
>>>>> +    * blame
>>>>> +      * and annotate
>>>>> +    * log
>>>>> +      * and variants: shortlog, gitk, show-branch, whatchanged
>>>>> +
>>>>> +    For now, we default to behavior B for these, which want a default of
>>>>> +    --no-restrict.
>>>>
>>>> I do feel pretty strongly that we'll want a --no-restrict default here
>>>> because otherwise we will present confusion. I'm not even sure if we would
>>>> want to make this available via a config setting, but likely a config
>>>> setting makes sense in the long term.
>>>
>>> You've got me slightly confused.  You did say the same thing a long time ago:
>>>
>>>     "But I also want to avoid doing this as a default or even behind a
>>> config setting."[A]
>>>
>>> BUT, when Shaoxuan proposed making --restrict/--focus the default for
>>> one of these commands, you seemed to be on board[B].
>>
>> I'm specifically talking about 'git log'. I think that having that be
>> in a restricted mode is extremely dangerous and will only confuse users.
>> This includes 'git show' (with commit arguments) and 'git bisect', I
>> think.
> 
> Thanks, that helps me understand your position better.
> 
> I'm curious if, due to the length of the document and this thread,
> you're just skimming past the idea I mentioned of showing a warning at
> the beginning of `diff`, `log`, or `show` output when restricting
> based on config or defaults.  Without such a warning, I agree that
> restricting might be confusing at times, but I think such a warning
> may be sufficient to address the concerns around partial/incomplete
> results.  The one command that this warning idea doesn't help with is
> `grep` since it cannot safely be applied there, which potentially
> leaves `grep` giving confusing results when users pass either
> `--cached` or revisions, but you seem to not be concerned about that.

I'm not convinced that warnings are enough for some cases, especially
for output that is fed to a pager. Do the warnings stick around in
the pager? I'm not sure.

> I'm also curious if the problem partially stems from the fact that
> with `git log` there is no way to control revision limiting and diff
> generation paths independently.  If there was a way to make `git log
> -p` continue showing the regular list of commits but restrict which
> paths were shown in the diffs, and we made the --scope-sparse handling
> do this so that only diffs were limited but not the revisions
> traversed/printed, would that help address your concerns?

My biggest issue is with the idea of simplifying the commit history
based on the sparse-checkout path definitions. The '-p' option having
a diff scoped to the sparse-checkout paths would be fine.

>> The rest, (diff, grep, blame) are worktree-focused, so having a restrict
>> mode by default makes sense to me.
> 
> I was specifically calling out diff & grep when passed revision
> arguments, which are definitely *not* worktree-focused operations.

You're right. I'm not using the right terminology. They _are_
operations on a single tree, where path scopes make sense.

> Also, blame incorporates a component of changes from the worktree, but
> it's mostly about history (and one or more -C's make it check other
> paths as well).

Since each input is a specific file path, I'm not sure we need
anything here except perhaps a warning that they are requesting
a file outside the sparse-checkout definition (if even that).

>>> Anyway...I will note that without a configurable option to give these
>>> commands a behavior of `--restrict`, I think you make working in
>>> disconnected partial clones practically impossible.  I want to be able
>>> to do "git log -p", "git diff REV1 REV2", and "git grep TERM REV" in
>>> disconnected partial clones, and I've wanted that kind of capability
>>> for well over a decade[H].  So, don't be surprised if I keep bringing
>>> up a config option of some sort for these commands.  :-)
>>
>> Now, if we're talking about "don't download extra objects" as a goal,
>> then we're thinking about things not just related to sparse-checkout
>> but even history within the sparse-checkout. Even if we make the
>> 'backfill' command something that users could run, there isn't a
>> guarantee that users will want to have even that much data downloaded.
>> We would need a way to say "yes, I ran 'git blame' on this path in my
>> sparse-checkout, but please don't just fail if you can't get new objects,
>> instead inform me that the results are incomplete."
>>
>> I think the sparse-checkout boundary is a good way to minimize the
>> number of objects downloaded by these commands, but to actually
>> remove the need for downloads at all we need a way to gracefully
>> return partial results.
> 
> There may be some merits to a partial clone with shallow blob history,
> but I've never really been all that interested in it. ......
> But you've got me curious.  You seem to be suggesting that partial
> results are okay if the user is informed.  I have suggested making
> diff-with-revisions, log -p, etc. show a warning that results may be
> incomplete when restricting them to the sparse checkout based on
> config.  So, aren't you suggesting that my proposal is safe after all?

I think the following things are true:

1. It's really important to keep the current partial clone default of
   only downloading blobs on-demand. Even with a limited sparse-checkout,
   it's rare that users will need every version of every file in that
   sparse-checkout, and they may not want that tax on their local storage.

2. Adding an opt-in backfill for a sparse-checkout definition will
   prevent most on-demand downloads (although it might want to be
   integrated into 'git fetch' behind an option to be really sure that
   state continues in the future).

3. Updating Git features to scope down to sparse-checkout will prevent
   many of the remaining on-demand downloads.

4. To be _absolutely sure_ that on-demand downloads don't happen, we
   need an extra mode for Git and new ways of reporting partial results.
   Without this mode, Git commands fail when triggering an on-demand
   download and the network is unavailable.

So, I'm saying that (4) is a direction that we could go. It also seems
extremely difficult to do, so we should do (2) & (3) first, which will
get us 99% of the way there.

Thanks,
-Stolee
