Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06BBECAAD3
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 03:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiIQDe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 23:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIQDeR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 23:34:17 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D4A80505
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 20:34:15 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id a20so14674726qtw.10
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 20:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=z3Kx9DYyzTaqPNDeS3iO2UtAOrcYwd+TN3LhVVibnYw=;
        b=cRPmfS5CkI/CFRTN3jR7l5JAMTJtu3HSfcV6Sd3ZfCAoX8JHauO350+jfUlkpLtLx/
         vL27UiGZsD/luXKxH4LitmSInME5CiR+svBxKUdM8O/58CYJjkiocKsKG/Q8zLKvZ+an
         luoJwl+rP3MoL3kn6mTRrj3t+f/8HVzTXbKUdd4N1n++X04X32NUHE0l7F0c4i7fC5RI
         Lz8VoixWWo2p07XhanSk9qgvYI1J+KF9bLLdzBre6ESfutBpYV/8Av0BV33PpGyOodY9
         qv5v+va4VPcm5RMmAsopk69Rx92pj2GMbNDEdvE0LcoWT83dfCE5dKuZK/qeX4sqE3zS
         6BmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=z3Kx9DYyzTaqPNDeS3iO2UtAOrcYwd+TN3LhVVibnYw=;
        b=pTpKMGiZe7f+Bd8ugG5w5N9/wVGopN5WFmDPSZCNABhoVfeNv93AwX8+2AvocK5h8R
         kl1BkQEBDNcnSJpsJBLkBsK2uXuoFsa75sk49amqKVUPAjmB5pfA8DeE1IWuJ+fWPxH9
         geNFYJlu14h+FDeCwvVtonPCM4Qlc23oScroRilJMg1JJLiFG7ZlQu3L8+Bb2BweZDUI
         DvGq/u0W2eeA+jYotkP5J2L1EwizzV4q3i8oRplfluaE6F4aM2WKnPejjAsmhZwMNtvF
         epP2LAVZ7z4vkIBr/9dLCqdkfhPSrFiod4baraqT+xVyhH/B6Ezai6EBRKfLrCE7cBkU
         rArg==
X-Gm-Message-State: ACrzQf2cfzqGlLcAH2o78rAqb0dLmRauDSkSTcWfTxApZqH8M8HhPW0S
        njq5gqxZP/a1031JBrWgGpjvHWqpgbQ=
X-Google-Smtp-Source: AMsMyM4Ncftr+cI9mKIZVkQrxL6PWZJXRug5x5yoBnI/zSppxLUyGCs+WdMUaWS8kKSPpX++U8ID3w==
X-Received: by 2002:a05:622a:1909:b0:344:9f41:9477 with SMTP id w9-20020a05622a190900b003449f419477mr7011743qtc.619.1663385654163;
        Fri, 16 Sep 2022 20:34:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:5a60:7720:391f:afa1:7d4f:f031? ([2600:1700:5a60:7720:391f:afa1:7d4f:f031])
        by smtp.gmail.com with ESMTPSA id l11-20020ac8148b000000b0035a691cec8esm6030582qtj.29.2022.09.16.20.34.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 20:34:13 -0700 (PDT)
Message-ID: <fed3c401-6cba-c729-74a8-d0bf53e12699@gmail.com>
Date:   Fri, 16 Sep 2022 20:34:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 1/3] builtin/grep.c: add --sparse option
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-2-shaoxuan.yuan02@gmail.com>
 <CABPp-BF-z72=hY_Jf8h3g95s+wwZOsV_S=+dDNs_AVskQxoaTw@mail.gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <CABPp-BF-z72=hY_Jf8h3g95s+wwZOsV_S=+dDNs_AVskQxoaTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/13/2022 11:08 PM, Elijah Newren wrote:
> Hi Shaoxuan,
> 
> Please note that it's customary to cc folks who have commented on
> previous versions of your patch series when you re-roll.

Hi Elijah,

Sorry for the delay, I didn't have my computer with me during Merge 2022
and couldn't respond.

I'm sorry that I somehow lost you along the way :(

> On Wed, Sep 7, 2022 at 5:28 PM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
>>
>> Add a --sparse option to `git-grep`.
> 
> It's awesome you're working on this.  Adding more of "behavior A"
> (restricting querying commands to the sparse cone) is something I've
> wanted for a long time.

Thanks :)

> I think most of your code is beneficial, but I do have some issues
> with high level direction you were implementing, which may require
> some tweaks...

OK.

>> When the '--cached' option is used with the 'git grep' command, the
>> search is limited to the blobs found in the index, not in the worktree.
>> If the user has enabled sparse-checkout, this might present more results
>> than they would like, since the files outside of the sparse-checkout are
>> unlikely to be important to them.
> 
> "files outside of the sparse-checkout are unlikely to be important to
> [users]" is certainly an issue.  But it's *much* wider than this.
> Beyond `grep --cached`, it also affects `grep REVISION`, `log`, `diff
> [REVISION]`, and related things...perhaps even something like `blame`.

Agree. Keep reading...

> I think all those other commands probably deserve a mode where they
> restrict output to the view associated with the user's cone.  I've

Agree.

> brought that up before[1].  I was skeptical of making it the default,
> because it'd probably take a long time to implement it everywhere.
> Slowly changing defaults of all commands over many git releases seems
> like a poor strategy, but I'm afraid that's what it looks like we are
> doing here.

True.

> I'm also worried that slowly changing the defaults without a
> high-level plan will lead to users struggling to figure out what
> flag(s) to pass.  Are we going to be stuck in a situation where users
> have to remember that for a dense search, they use one flag for `grep
> --cached`, a different one for  `grep [REVISION]`, no flag is needed
> for `diff [REVISION]`, but yet a different flag is needed for `git
> log`?

I think the inconsistency is certainly unsettling.

> I'm also curious whether there shouldn't be a config option for
> something like this, so folks don't have to specify it with every
> invocation.  In particular, while I certainly have users that want to
> just query git for information about the part of the history they are
> interested in, there are other users who are fully aware they are
> working in a bigger repository and want to search for additional
> things to add to their sparse-checkout and predominantly use grep for
> things like that.  They have even documented that `git grep --cached
> <TERM>` can be used in sparse-checkouts for this purpose...and have
> been using that for a few years.  (I did warn them at the time that
> there was a risk they'd have to change their command, but it's still
> going to be a behavioral change they might not expect.)  Further, when
> I brought up changing the behavior of commands during sparse-checkouts
> to limit to files matching the sparsity paths in that old thread at
> [1], Stolee was a bit skeptical of making that the default.  That
> suggests, at least, that two independent groups of users would want to
> use the non-sparse searching frequently, and frequently enough that
> they'd appreciate a config option.

A config option sounds good. Though I think

1. If this option is for global behavior: users may better off turning
off sparse-checkout if they want a config to do things densely everywhere.

2. If this option is for a single subcommand (e.g. 'grep'): I don't have
much thoughts here. It certainly can be nice for users who need to do
non-sparse searching frequently. This design, if necessary, should
belong to a patch where this config is added for every single subcommand?

> I also brought up in that old thread that perhaps we want to avoid
> adding a flag to every subcommand, and instead just having a
> git-global flag for triggering this type of behavior.  (e.g. `git
> --no-restrict grep --cached ...` or `git --dense grep --cached ...`).

This looks more like the answer to me. It's a peace of mind for users if
they don't have to worry about whether a subcommand is sparse-aware, and
how may their behaviors differ. Though we still may need to update the
actual behavior in each subcommand over an extended period of time
(though may not be difficult?), which you mentioned above "seems like a
poor strategy".

> [1] https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/
> and the responses to that email>
>> Change the default behavior of 'git grep' to focus on the files within
>> the sparse-checkout definition. To enable the previous behavior, add a
>> '--sparse' option to 'git grep' that triggers the old behavior that
>> inspects paths outside of the sparse-checkout definition when paired
>> with the '--cached' option.
> 
> I still think the flag name of `--sparse` is totally backwards and
> highly confusing for the described behavior.  I missed Stolee's email
> at the time (wasn't cc'ed) where he brought up that "--sparse" had
> already been added to "git-add" and "git-rm", but in those cases the
> commands aren't querying and I just don't see how they lead to the
> same level of user confusion.  This one seems glaringly wrong to me
> and both Junio and I flagged it on v1 when we first saw it.  (Perhaps
> it also helps that for the add/rm cases, that a user is often given an
> error message with the suggested flag to use, which just doesn't make
> sense here either.)  If there is concern that this flag should be the
> same as add and rm, then I think we need to do the backward
> compatibility dance and fix add and rm by adding an alias over there
> so that grep's flag won't be so confusing.

I guess I'm using "--sparse" here because "add", "rm" and "mv" all imply
that "when operating on a sparse path, ignores/warns unless '--sparse'
is used". I take it as an analogy so "when searching a sparse path,
ignores/warns unless '--sparse' is used". As the idea that "Git does
*not* care sparse contents unless '--[no-]sparse' is specified" is sort
of established through the implementations in "add", "rm", or "mv", I
don't see a big problem using "--sparse" here.

I *think*, as long as the users are informed that the default is to
ignore things outside of the sparse-checkout definition, and they have
to do something (using "--sparse" or a potential better name) to
override the default, we are safe to use a name that is famous (i.e.
"--sparse") even though its literal meaning is not perfectly descriptive.

One outlier I do find confusing though, is the "--sparse" option from
"git-ls-files". Without it, Git expands the index and show everything
outside of sparse-checkout definition, which seems a bit controversial.

...

> 
> I read over this patch and the other two patches.  Other than things
> like variable names propagating the sparse/dense confusion, and the
> high level goals already discussed, I didn't spot any other issues.

Thanks,
Shaoxuan
