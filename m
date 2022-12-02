Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C46C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 18:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiLBS2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 13:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbiLBS2X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 13:28:23 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFC5B5D9E
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 10:28:21 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gu23so13408866ejb.10
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 10:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lPYRONNx3rwD9/zuS5ABqFhVFwrZcjreXRLhUdLPMcY=;
        b=b09ZDfkNs1EVpoaaKFXVDBd96jns4MMC+iwU0rVOkBhi5wqlJDg9Oz5c9sNjsOxB/Z
         +bWmcPKHQui6MDlW81hOKyHIBVawwcT1yxene3JxBeeMo2ZKkcOebSE8KoGNEFSMkAnD
         bl4q2lhMNc926jF//2DhGvn6GtZiT4Fuk6EGU0lEtvi4XMLUPfs+d8dCUiEaXYqoPay1
         Y9HRgUoHImFv44Aaeg1UC55wQ0EuAS0rranutPQpmENA7/fzw0DCN8Krr1gF9HwCZ+VI
         vsTpSDYYo67tfJZfCTjmdDYXITHWS8WvEOGGLIummh41kEd7TYJI5BKl7QOM6YWq1p1t
         GxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPYRONNx3rwD9/zuS5ABqFhVFwrZcjreXRLhUdLPMcY=;
        b=5+/Ib8CTVV6l4RPBmhtgvkfoKcz9umYtck9ILATj6qCOAeXOChan5o4A5uj7vJeepC
         4jKcPewv8geOCS44f8ZGFuNvAysCQECtflquMGEYg7GVW5chpJNrHXEKF9plnvdqOhK0
         FYgVQ7Ekoqv7bvr+B6iJO9+XbNMYt2FZbBsOIQQzZIg6ygbnXcNTpxW8WOzVYkhDsjfN
         seQOXv1A6W3m9f1rakqnI1uko6iFyADfE/Z6GuEISsBeghTqDArLZJesApX/oDBPZXx3
         vHrIgbtt2A40In6tzv7AG3LNug1eawBLPYri31UlDaECvBn2avf2bU/3XUW4NgWxhOYB
         g+0A==
X-Gm-Message-State: ANoB5pkv5D8vhNwK6xAsrx3HO6OB1uHO3Zm37iswHA727ZlIWwsVjw1e
        ItagJXGq+ONWzUk+gtp8ntB2raxHzAkn1w==
X-Google-Smtp-Source: AA0mqf4TeV6yH133naK63fln0qyqMAprXeIJx73R5VoQ9ncULkrtqo6TktYwSqSHhZMF9LTwbFB4UQ==
X-Received: by 2002:a17:906:3a41:b0:78d:9caa:31b7 with SMTP id a1-20020a1709063a4100b0078d9caa31b7mr48303318ejf.263.1670005699839;
        Fri, 02 Dec 2022 10:28:19 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id r2-20020aa7da02000000b0046aba24985esm3159210eds.91.2022.12.02.10.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 10:28:18 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p1All-002oM7-18;
        Fri, 02 Dec 2022 19:28:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2
 file format
Date:   Fri, 02 Dec 2022 19:24:34 +0100
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
 <CAFQ2z_MZd150kQNTcxaDRVvALpZcCUbRj_81pt-VBY8DRaoRNw@mail.gmail.com>
 <f1c45bd5-692e-85db-90c3-c516003f47e5@github.com>
 <CAFQ2z_MLwUoaSTG04LJYHgJH-QYJEuZ9bQcTsV8mXwxBbz7Egg@mail.gmail.com>
 <f5370fec-d517-eaa9-8e16-82fa20ac8532@github.com>
 <CAFQ2z_NKpgsEsrDdkdp=HDajrzpUDjiUcUdR8TMkYpXZBU0k+g@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAFQ2z_NKpgsEsrDdkdp=HDajrzpUDjiUcUdR8TMkYpXZBU0k+g@mail.gmail.com>
Message-ID: <221202.86fsdxfyny.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 02 2022, Han-Wen Nienhuys wrote:

> On Thu, Dec 1, 2022 at 9:19 PM Derrick Stolee <derrickstolee@github.com> wrote:
>> >> The reason to start with this step is that the benefits and risks are
>> >> clearly understood, which can motivate us to establish the mechanism for
>> >> changing the ref format by defining the extension.
>> >
>> > I believe that the v2 format is a safe change with performance
>> > improvements, but it's a backward incompatible format change with only
>> > modest payoff. I also don't understand how it will help you do a stack
>> > of tables,
>> > which you need for your primary goal (ie. transactions/deletions
>> > writing only the delta, rather than rewriting the whole file?).
>>
>> The v2 format doesn't help me on its own, but it has other benefits
>> in terms of size and speed, as well as the "ref count" functionality.
>>
>> The important thing is that the definition of extensions.refFormat
>> that I'm proposing in this RFC establishes a way to make incremental
>> progress on the ref format, allowing the stacked format to come in
>> later with less friction.
>
> I guess you want to move the read/write stack under the loose storage
> (packed backend), and introduce (read loose/packed + write packed
> only) mode that is transitional?
>
> Before you embark on this incremental route, I think it would be best
> to think through carefully how an online upgrade would work in detail
> (I think it's currently not specified?) If ultimately it's not
> feasible to do incrementally, then the added complexity of the
> incremental approach will be for naught.
>
> The incremental mode would only be of interest to hosting providers.
> It will only be used transitionally. It is inherently going to be
> complex, because it has to consider both storage modes at the same
> time, and because it is transitional, it will get less real life
> testing. At the same time, the ref database is comparatively small, so
> the availability blip that converting the storage offline will impair
> is going to be small. So, the incremental approach is rather expensive
> for a comparatively small benefit.
>
> I also thought a bit about how you could make the transition seamless,
> but I can't see a good way: you have to coordinate between tables.list
> (the list of reftables active or whatever file signals the presence of
> a stack) and files under refs/heads/. I don't know how to do
> transactions across multiple files without cooperative locking.

A multi-backend transaction would be hard to do at the best of times,
but we'd also presumably run into the issue that not all ref operations
currently use the transaction mechanism (e.g. branch copying/moving). So
if one or the other fails there all bets are off as far as getting back
to a consistent state.

Perhaps a more doable & interesting approach would be to have a "slave"
backend that would follow along, i.e. we'd replay all operations from
"master" to "slave" (as with DB replication, just within a single
repository).

We might get out of sync, but as the "master" is always the source of
truth presumably we could run some one-off re-exporting of the refspace
get back up-to-date, and hopefully not get out of sync again.

Then once we're ready, we could flip the switch indicating what becomes
the canonical backend.

For reftable the FS layout under .git/* is incompatible, so we'd also
need to support writing to some alternate directory to make such a thing
work...
