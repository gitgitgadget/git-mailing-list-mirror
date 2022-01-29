Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA834C433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 06:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241669AbiA2Gqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 01:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiA2Gqm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 01:46:42 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7512CC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 22:46:41 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u18so14507561edt.6
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 22:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=p0TVzSaRraChCqsXVZY4uvZv7AfTcBz0jNFOIhK5c5I=;
        b=VIudr39VtvxQoSDd+Y6BcNQwylgunupPoWy8kGVTLdpS2RGUqniVMBL8MdCF4k2b9e
         aM5iIQvA2PUknqJQqEU/+C3FJAOwFXnRjurQzvVjZHLlUWaOmy66Tf9KAczX+B/qtE+L
         WB7barvHsOLbmio9SofjV7wkvugzBa2I/HJBORJbO1Gap7Xeiy2Tw9jAc5DOlhDS8Bo7
         Mn746Jf1YheHWJA5sdmJcDpGxittI3tL5tgj9yCst4uY4S6W7GMfIj/VGc74TSTseTxb
         kRN6D+Hv1GhY2ilLxTz5+K4Ao0IgpOBqs+UqIw6dm/WvM3bNLQwSKb6sdml6vkgLlZFz
         rFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=p0TVzSaRraChCqsXVZY4uvZv7AfTcBz0jNFOIhK5c5I=;
        b=toWq8ntUx4OeOOLa0Zrs41wLK5GuU+d2M7M+uhwn+7eoE3ztKFUoq80/Mi5rY3Qv9A
         Mm4LVk3hwvGlIwFn95kT0ALbYzXJHE7dQZLlLU1MR0XtTVi29JHXMo/saKKQgxGC6KS7
         re5sF5juothnq4/aVKs9iZyIxIFpuGTnA08E63clq6JCzHI2Bd4WfmdqbdBGCkvwEpEK
         PTes9BH+SJx/aRYnPECUiAE8uLvwfwU3KkqpmdJf5wzJ9EokMq34ZWBrjsLw2cu/RPd0
         7n5LYXLybArB2EgIjmX9nu0NFyw0nyoGLYQ+TBaWCfmDZb9J+vnFdNRvU2L0sbvZIJXC
         eb0A==
X-Gm-Message-State: AOAM532hRi0oR0D7f7aZE7awrU6wDVLDCD2GKqax7Ti9Pv25+S0I/Lc5
        5a95rvhQ8cDdERUwvDVkrXM=
X-Google-Smtp-Source: ABdhPJwG7auYM0C6fs0mTdxXG7531TDKldT+dRbl51K8u6VDnxhK3+zidEiOKulcW7QScgRreIRIGg==
X-Received: by 2002:a05:6402:254a:: with SMTP id l10mr11296163edb.318.1643438799748;
        Fri, 28 Jan 2022 22:46:39 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d17sm14143193ede.88.2022.01.28.22.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 22:46:39 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nDhVO-003lDt-JL;
        Sat, 29 Jan 2022 07:46:38 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] scalar: accept -C and -c options before the subcommand
Date:   Sat, 29 Jan 2022 07:39:45 +0100
References: <pull.1130.git.1643195729608.gitgitgadget@gmail.com>
 <220127.86v8y5dgus.gmgdl@evledraar.gmail.com>
 <0f8d5d04-e86c-48e2-fea0-32c25c3f9325@gmail.com>
 <nycvar.QRO.7.76.6.2201281148310.347@tvgsbejvaqbjf.bet>
 <220128.8635l7d7y6.gmgdl@evledraar.gmail.com>
 <2150a170-bf02-f510-3995-c103650ad8fc@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <2150a170-bf02-f510-3995-c103650ad8fc@gmail.com>
Message-ID: <220129.86tudnavjl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 28 2022, Derrick Stolee wrote:

> On 1/28/2022 1:21 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Fri, Jan 28 2022, Johannes Schindelin wrote:
>>=20
>>> On Thu, 27 Jan 2022, Derrick Stolee wrote:
>>>
>>>> The biggest benefits of using handle_options() is for other pre-command
>>>> options such as --exec-path, which I use on a regular basis when testi=
ng
>>>> new functionality.
>>>>
>>>> There are other options in handle_options() that might not be
>>>> appropriate, or might be incorrect if we just make handle_options()
>>>> non-static. For example, `scalar --list-cmds=3Dparseopt` wouldn't show=
 the
>>>> scalar commands and would instead show the git commands.
>>>
>>> Right, and since `handle_options()` lives in the same file as `git`'s
>>> `cmd_main()` function, we would not only have to disentangle options th=
at
>>> work only for `git` from those that would also work for `scalar`, but we
>>> would have to extract the `handle_options()` function into a separate
>>> file.
>>>
>>> And while at it, a tangent someone with infinite time on their hands mi=
ght
>>> suggest is: why not convert `handle_options()` to the `parse_options()`
>>> machinery? Which would of course solve one issue by adding several new
>>> ones. Don't get me wrong: I would find it useful to convert
>>> `git.c:handle_options()` to a function in `libgit.a` which uses the
>>> `parse_options()` machinery. It'll just require a lot of time, and I do
>>> not see enough benefit that would make it worth embarking on that
>>> particular journey.
>>>
>>> But since I had a look at `handle_options()` anyway, I might just as we=
ll
>>> summarize my insights about how applicable the supported options are for
>>> `scalar` here:
>>> [...]
>>> # Detrimental
>>>
>>>   --exec-path
>>>
>>> 	Since `scalar` is tightly coupled to a specific Git version, it
>>> 	would cause much more harm than benefit to encourage users to use
>>> 	a different Git version by offering them this option.
>>=20
>> So just to clarify, do you and Stolee disagree about scalar supporting
>> --exec-path, per his comments above?
>
> I think it would be nice, but it's also not a blocker for me.
>
>> In this case I don't mind much, but speaking generally I see you and
>> Stolee tying yourselves in knots again about scalar being in contrib so
>> we shouldn't use libgit.
>>=20
>> It already uses libgit, there's even (last I checked) at least one
>> function in it only used directly by the scalar code.
>
> My concern is not that we shouldn't use libgit (because we do) but that
> we shouldn't make significant changes to libgit.a only for Scalar's
> benefit until it is incorporated in a more final way.
>
> In my opinion, well-architected code is code that is easy to delete.
> Until we have Scalar mostly feature-complete and can make a decision
> about it living in the Git tree long-term (and _where_ it resides), I
> would like to have the following property: If I were to revert all
> commits that touch contrib/scalar/ and squash them into a single commit,
> then we would have a bunch of file deletions and a very small set of
> edits to the Makefile. I don't know how much the ship has sailed there
> already, but keeping the size of that "revert diff" small means that we
> are keeping the coupling low during this review process.

Fair enough.

I think there's cases where it won't make sense, and cases where it
will.

Maybe it doesn't make sense here, but generally I wouldn't take it being
needed for scalar heavily into account per-se, for the review & i18n
reasons I mentioned.

I.e. the list is already looking at these patches, and translators are
being presented these strings as part of our existing set.

So "this reuses existing tested code" and "you won't need to translate
this new thing" will be benefits whatever the current state of scalar
is.

>> I don't remember anyone having any objection to scalar using libgit
>> code, or even that there's libgit code just to help it along. That's a
>> self-imposed limitation you two seem to have invented.
>>=20
>> Personally I find a patch like the below much easier to review. It's the
>> parts that aren't easy to review boilerplate are all things that we have
>> in-tree already.
>>=20
>> Whereas proposing a new way to parse -c or -C will lead (at least me) to
>> carefully eyeballing that new implementation, looking at how it differs
>> (if at all) from the existing one, wondering why the i18n strings are
>> subtly different etc (I saw one reason is that since the code was
>> copy/pasted initially the git.c version was updated, but your patch
>> wasn't updated to copy it).
>
>> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
>> index 1ce9c2b00e8..ee793ff6ccc 100644
>> --- a/contrib/scalar/scalar.c
>> +++ b/contrib/scalar/scalar.c
>
>> diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
>> index 1ce9c2b00e8..ee793ff6ccc 100644
>> --- a/contrib/scalar/scalar.c
>> +++ b/contrib/scalar/scalar.c
>
> Was this diff double-copied or something?

Yes, sorry the first 3 hunks are the same. I manually re-copied this
into my editor (I forgot a stray debugging printf) and screwed it up.
