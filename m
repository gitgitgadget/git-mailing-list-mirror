Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70CDC433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 11:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7862664E09
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 11:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhA3LOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 06:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhA3LOg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 06:14:36 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CCDC061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 03:13:55 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bl23so16793331ejb.5
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 03:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=gaFqQoB+524W3VnZ4yYV72MjU6AhFyzfl4aEF3B5zsI=;
        b=RBgJPHJ77zO5ii4BSRMa7DGQCVj/LrHXKpCKpH2VlubpqoRlIMWWCUBhvgmPjd3YKp
         4u0nOlKa1+2UI+4NZH8UeK1gKQrTRcIlpOv36oaxkgGwIukhjFGThKVi/pQCLP92Tv2T
         a2jvtQG/vF5F6CSdvdedNB6vQXnTbziiirvRnDWxGLwFLPh7WVHsJMLi25mT3koB19+5
         688XLdQtNSNTt0OP6d0UnxZYyaXDnV/Bg4BoXy5UvOEG5kys2ks12neBOKNcnJzeYx+Q
         fRN9f8UtBYbij9t1z54wiXZBigIMH477pcmhMvvrGmkKTuKFRLhLjXweFlQn+Sq56KKA
         OVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=gaFqQoB+524W3VnZ4yYV72MjU6AhFyzfl4aEF3B5zsI=;
        b=GvQuqgofMzmI5/9cB0PTIdDbfiVQICnOjd8wQt4OFl8JA36thAs+mbjbLzs/fkmMju
         Y8s6o4p9leSW+RPTwf1CXW10zudp4+t4SCi/Cp5WCDkTIJTJ/nqe7aa9lidCizkHB1zS
         /Qhre9Nyr8JejpNPEyVqfCMGYSdnwjuLT5j1TwInF0gUdVyGQS8JuWzjs1D+RpD8rK0E
         mn/6UFuvv78BjOKQSFQz4wgMWme5x4pdj3VBUxscenu0aOtE4BXmww4EVwqhP4SnMMQ5
         DuySd3fgxQXIjv4pBSn+WUzoz91VnspliyzbapSPLPycE2qy55jvBadoHJF7Fril3bDV
         UkTg==
X-Gm-Message-State: AOAM5317fhxCZGbI80C2BK1aeWw+c1Nur/AeDH9Zl6HyPYVwEz1Puflv
        4VWr3GXkMH+CVymuV+RTHhtXQGVannG5Tw==
X-Google-Smtp-Source: ABdhPJxRZxNLtmboSJoCoRBdDIcI4c4Kc8jttxP1pAczduI+0hN+EmkvkxLWUPIVf+doCRyZskYoyg==
X-Received: by 2002:a17:906:3514:: with SMTP id r20mr8486218eja.202.1612005234021;
        Sat, 30 Jan 2021 03:13:54 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id a2sm5042892ejk.80.2021.01.30.03.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 03:13:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, felipe.contreras@gmail.com
Subject: Re: [PATCH v5 0/3] Cloning with remote unborn HEAD
References: <87h7n3p363.fsf@evledraar.gmail.com>
 <20210130044142.808860-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <20210130044142.808860-1-jonathantanmy@google.com>
Date:   Sat, 30 Jan 2021 12:13:52 +0100
Message-ID: <878s8apthr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jan 30 2021, Jonathan Tan wrote:

>> On Tue, Jan 26 2021, Jonathan Tan wrote:
>> 
>> [For some reason the patches didn't reach my mailbox, but I see them in
>> the list archive, so I'm replying to the cover-letter]
>> 
>> >  Documentation/config.txt                |  2 +
>> >  Documentation/config/init.txt           |  2 +-
>> 
>> Good, now we have init.defaultBranch docs, but they say:
>>     
>>      init.defaultBranch::
>>             Allows overriding the default branch name e.g. when initializing
>>     -       a new repository or when cloning an empty repository.
>>     +       a new repository.
>> 
>> So this still only applies to file:// and other "protocol" clones, but
>> not "git clone /some/path"?
>
> Ah...that's true.
>
>> Re my reply to v1, do we consider that a bug, feature, something just
>> left unimplemented?
>> 
>> I really don't care much, but this really needs a corresponding
>> documentation update. I.e. something like:
>> 
>>     init.defaultBranch::
>>         Allows overriding the default branch name e.g. when initializing a
>>         new repository or when cloning an empty repository.
>>     
>>         When cloning a repository over protocol v2 (i.e. ssh://, https://,
>>         file://, but not a /some/path), and if that repository has
>>         init.defaultBranch configured, the server will advertise its
>>         preferred default branch name, and we'll take its configuration over
>>         ours.
>
> Thanks - I'll use some of your wording, but I think it's best to leave
> open the possibility that cloning using protocol v0 or the disk clone
> (/some/path) copies over the current HEAD as well.

Sure, and maybe a test_expect_failure for those cases? I.e. to
explicitly say in the current docs/tests what does / doesn't work, and
if we consider that intentional or not.

>> Which, just in terms of implementation makes me think it would make more
>> sense if the server just had:
>> 
>>     uploadPack.sendConfig = "init.defaultBranch=xyz"
>> 
>> The client:
>> 
>>     receivePack.acceptConfig = "init.defaultBranch"
>> 
>> And in terms of things on the wire we'd say:
>> 
>>     "set-config init.defaultBranch=main"
>> 
>> You could have many such lines, but we'd just harcode only accepting
>> "init.defaultBranch" by default for now.
>> 
>> I.e. we set "init.defaultBranch" on the server, and the client ends up
>> interpreting things as if though "init.defaultBranch" was set to exactly
>> that value. So why not just ... send a line saying "you should set your
>> init.defaultBranch config to this".
>> 
>> Makes it future-extensible pretty much for free, and I think also much
>> easier to explain to users. I.e. instead of init.defaultBranch somehow
>> being magical when talking with a remote server we can talk about a
>> remote server being one source of config per git-config's documented
>> config order, for a very narrow whitelist of config keys.
>>
>> Or (not clear to me, should have waited with my other E-Mail) are we
>> ever expecting to send more than one of:
>> 
>>     "unborn <refname> symref-target:<target>"
>> 
>> Or is the reason closer to us being able to shoehorn this into the
>> existing ls-refs response, as opposed to some general "here's config for
>> you" response we don't have?
>
> It's not the same - from what I understand, what you're suggesting is
> setting a config in the repo that has just been cloned[...]

No, not to set config, i.e. during/after clone doing "git config
init.defaultBranch <remote>" wouldn't make any sense. Since that would
set config in .git/config, and that would (also?) apply /after/ the
clone, e.g. if you did "git init /tmp/somewhere/else" afterwards.

> [...]but this patch set does not set any such config[...].

It does, within the scope of the runtime of the process. I.e. just like
"git -c" or whatever. In builtin/clone.c you set "branch" from local
init.defaultBranch only if the remote did not provide us a value for it,
i.e. remote config for that config key overrides local config.

> Also, it may be strange for the server to be able to change the config
> of a currently running command - I would expect such a thing to only
> take effect on future runs of Git on that repo.

Yes, as I noted on v1 I think the semantics of this whole thing are a
bit strange :)

But if we're keeping the "strangeness" all I'm saying is that I think
it's more obvious to a user if we just declare the remote to be a
limited config source in tems of explaining this special-case.

And that once we're doing that it's also more obvious IMO to have that
be what's happening on the protocol level, if we're not expecting more
than one of these values.

I.e. if you ignore your current implementation internal and just view
git as a black box, then the functionality of this thing is
indistinguishable from the remote being a (limited) source of config.

So isn't in simpler to explain it to the user in those terms?
