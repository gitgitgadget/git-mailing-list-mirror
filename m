Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B9CC77B61
	for <git@archiver.kernel.org>; Mon,  1 May 2023 05:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjEAFva (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 01:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjEAFv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 01:51:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B849EE55
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 22:51:27 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94f6c285d22so449134066b.2
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 22:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google; t=1682920286; x=1685512286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajtKioqz8oiUY0yeX4/XdYHcvKTfkuVHfCBOpsiKJEk=;
        b=SS4Pid/amks8/n7y/YUvnwiITT+3lwzRyPo8QkBRdCjltHMXBAGNg6/MIJMn1FcAPa
         CMMkH3z+fgnjuGNwS5myhcPXpEQ9GJPqgKDGL2HmIYYRsiLE7ihxT6+EPMjMzy2N20ng
         MPsi5SYidgf6T3q11bu2yk1emk01z0Sp/mU8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682920286; x=1685512286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajtKioqz8oiUY0yeX4/XdYHcvKTfkuVHfCBOpsiKJEk=;
        b=bK0e3FKd93N9o+2GkiYh1BwRjNRB72E7i/wUGn+lJoqPrK8wJSA6BfZgtsaMgPJ5y1
         Ye4IevR/R3luaO+KG0AeFgIxAF2UZZdFLOig4BzICrg2VJDJ1eZQl39dNfIPm5gEm1U5
         Vv5HqP/u1ZAzGGGTisYhksUqCwRutSnJVhHz2hfSZfVn3ZkDIAFJGdL+DL1aYi/MMMdp
         XRfxSJ5E9uQQpYA5PzRhxmFGFYR6Y0Nvgearrw9387H9eHas5LBnf+MbFmZx4zbBaSLi
         n+P4Hcs9ZzMB4h2HJbjvxE99YLF2lP95uw4Kf5gP/86b4+chMN/RPUFnvvqselgfOOjN
         osWw==
X-Gm-Message-State: AC+VfDwQHzJjCNdzOQFONo70Z5nizQIsba23I0Z8OKYrm7Mrwel5iOFj
        u4wBntu1B/8Ybvc0SeVwRR+g+WjM/7+pjCibJ9Z+NuZbPOclFfFCfmc=
X-Google-Smtp-Source: ACHHUZ5KlNLzZISuqdW0jZi68u6TEFJvQ6DpV21CWiRPHOJcYJJKWMbhWjw8LAhqRJYsG8ruE6tIWbHR7B8wv00q8eg=
X-Received: by 2002:a17:907:36c4:b0:94f:39d7:6454 with SMTP id
 bj4-20020a17090736c400b0094f39d76454mr14026027ejc.63.1682920285997; Sun, 30
 Apr 2023 22:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpohyoaH92B9f46hwdX2S5WOYeRB2yMSKW-4UCrHe29SAZQ@mail.gmail.com>
 <CAPx1GveK2J8Wu4cBYzO535c4bQ7P_t2fd1KFJqqphrm2HGQPSA@mail.gmail.com>
In-Reply-To: <CAPx1GveK2J8Wu4cBYzO535c4bQ7P_t2fd1KFJqqphrm2HGQPSA@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 1 May 2023 07:51:14 +0200
Message-ID: <CAPMMpognK_g5GL4EDamUmA5bzWiy9_VPf=a+0D5AnFtngUNa+A@mail.gmail.com>
Subject: Re: Change branch in the middle of a merge
To:     Chris Torek <chris.torek@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(background note: Chris accidentally sent a non-plaintext response,
and I failed to respond for some time, but I still believe this is
something worth fixing)

On Mon, Feb 27, 2023 at 10:16=E2=80=AFPM Chris Torek <chris.torek@gmail.com=
> wrote:
>
> On Mon, Feb 27, 2023 at 4:18 AM Tao Klerks <tao@klerks.biz> wrote:
>>
>>
>> All three of these strategies are quite awful things to have to teach us=
ers.
>
>
> I agree.
>

Thanks for confirming, this helped motivate my at least attempting a patch.

It's not ready yet, but what I have so far seems to work.

>>
>> I'd like to understand whether this behavior, the fact that you can't
>> easily/straightforwardly/intuitively complete a merge onto a new
>> branch (with the exact same "first parent" commit of course), is
>> intentional for some reason that I am failing to grasp, or just a
>> missing feature.
>
>
> I don't know the answer to this.
>
> Internally, it seems trivial to fix: for the "create new branch" cases,
> simply *don't* remove the `MERGE_HEAD` ref.  This has an
> annoying side effect: you can now create new branch names but
> not switch among existing branches.  But that's kind of inherent to
> this state.

I don't understand this bit, but I'm probably missing something.

The approach I've taken here is to, when the original commit and the
new commit are the same (you're switching to a same-head branch, or
creating a new branch at the current head), change the
"remove_branch_state()" call at
https://github.com/git/git/blob/2807bd2c10606e590886543afe4e4f208dddd489/bu=
iltin/checkout.c#L1012
/ implemented at
https://github.com/git/git/blob/2807bd2c10606e590886543afe4e4f208dddd489/br=
anch.c#L818,
to not do the "remove_merge_branch_state()" bit - that is, avoid all
the removals at
https://github.com/git/git/blob/2807bd2c10606e590886543afe4e4f208dddd489/br=
anch.c#L808.

This behaves as expected for switching to new and expected branches.
To change the "git checkout" behavior this change is basically all
that's needed (plus tests etc), but for "git switch" we also need to
change some validation which would refuse to do the switch in the
middle of a merge.

With these changes things behave in what I think is a very reasonable
way, with one potentially-surprising aspect: the merge message
proposed when you go to commit still refers to the branch you were on
when you prepared the merge, rather than the one you're on now. I
personally believe this is quite reasonable (you'd still see this if
you followed any other process involving fast-forwarding for example),
but I can see how it's not perfect.

The bit I'm having more conceptual difficulty with is considering what
to "say" when a checkout/switch completes with a merge-in-progress.
Historically, this happened "as normal", with no special messaging.
Now, I think there should be a message depending on whether the merge
state was discarded (head commit changed) or not:
 * If the commit remained the same and so the merge state was
retained, state as much and warn about the commit message referring to
the previous branch name.
 * If the commit changed and so the merge state was discarded ("git
checkout" only - not possible with "git switch"), state as much and
suggest that using "git switch" would prevent this happening
accidentally in future.

Does this kind of messaging make sense to you?

>
> (Whether this is generally acceptable to others, I don't know. It would
> break backwards compatibility with `git checkout -b`, obviously, and
> making `git checkout -b` and `git switch -c` behave *differently* here
> feels wrong to me, but that's a different thing.)
>

After thinking about this a bit more, I agree that having divergent
different behavior for checkout and switch would suck. The current
existing divergences, as far as I can tell, are around
validation/safety, not behavior when actions are completed.

I think the best thing is to propose a patch that incorporates a
change in checkout behavior (stop throwing away merge metadata when
you do a checkout/switch in the middle of a merge), with new messaging
as outlined above, and see how people feel about it. I'm hopeful that
a patch will see some more reactions than this thread did in its first
round.
