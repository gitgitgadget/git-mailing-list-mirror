Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946CDC433DF
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 19:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6972920657
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 19:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrZXyC1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgGJTal (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGJTal (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 15:30:41 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFBDC08C5DC
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 12:30:40 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o18so7260463eje.7
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 12:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Cq+uj2y0BfNi9FTxnM3VM2lOHOsEMavrOB5/twyfiPw=;
        b=jrZXyC1Zx6hTzKZaa8NfTAxmrA5B/eAbzxs+jllbFM/pDIy+Rqc5P0X6R0SbfyIqFT
         fmSGQcmG8FBku05fUNzxVr5rItYWK0o4aV6pAY4Yy552cz79Gp9XqCT6auUyYxO0iq50
         U+X0KvCNXsFfXKuJnHnW1JIf8oZcZebgdXeu19OH2TM4i9ab5hUWQakZgeUymAkwQjKo
         33GvjPIe8T7lXjaLIQXDj9qfES45gwCRRk5gpixViwg6TRuKPVt1K9ow3UBlC0UCff41
         qyh/x+nVSBghjrW6yYWhaNzw3Xezm/5VGXEgfT7hfYBkRxrm5efxWX67icqWsk4IvPtZ
         KHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Cq+uj2y0BfNi9FTxnM3VM2lOHOsEMavrOB5/twyfiPw=;
        b=iGW7UEIJ3C6ZTzJVnrwx7QkV81Sbf4rFxokvz2lhEWxwOx7IMEiPlaVnfzW9X7RNLa
         I4eJdk0u/6g+KJFr3mFC9FabxHtn2WYT+gLE4WZOwFoY/MkXds5bgOWfaxcdHcG19EAL
         9/Mk3YlGDV3TRGZkkXJdsgZjKu39xSOYPgE90vzVoPtnY//9BVKxC4nKguUyHmkqRP/Z
         fTKv8InuhkiBmm1wuZ0vildVuyeZgdXwOMptUsDaXviTTfk3X3TTmnDSe1wtkfmSFJR/
         eSv+G4qHk0Kqkv6/wFeqSAO72mMq5CP7JV2NCdce+CTTygWnG5hhounUx9W2i4wMXljM
         RzsQ==
X-Gm-Message-State: AOAM533Wn+f/4+8zu7BfHOx9UwtyDG5pglfx0nMWdzgoPlOJw/U87jXe
        dtsbbgQAnVcXYrOVArLNM/Y=
X-Google-Smtp-Source: ABdhPJy20BW6aX93K7aNepM1t1yVszZzUnmCNEztIehRpMgT8XOtEBwXwjGevmag2rcVvnSletHzsA==
X-Received: by 2002:a17:906:87c8:: with SMTP id zb8mr61650824ejb.35.1594409439556;
        Fri, 10 Jul 2020 12:30:39 -0700 (PDT)
Received: from ?IPv6:2a02:a210:ca2:9c00:dcd5:7799:7fa7:4588? ([2a02:a210:ca2:9c00:dcd5:7799:7fa7:4588])
        by smtp.gmail.com with ESMTPSA id n5sm4233948eja.70.2020.07.10.12.30.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2020 12:30:39 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 00/21] Maintenance builtin, allowing 'gc --auto'
 customization
From:   Son Luong Ngoc <sluongng@gmail.com>
In-Reply-To: <20200710184651.GB3189386@google.com>
Date:   Fri, 10 Jul 2020 21:30:37 +0200
Cc:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, congdanhqx@gmail.com,
        phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <23F67854-B596-4728-86CD-A9927546DD43@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <20200708235719.GA3189386@google.com>
 <ef6e2704-b122-f620-a952-75f3f9efab78@gmail.com>
 <d0d30dab-7883-199a-3beb-48c87cde3550@gmail.com>
 <20200709231624.GE664420@coredump.intra.peff.net>
 <28c72d69-f524-7c4f-4cc3-847ca91cad33@gmail.com>
 <20200710184651.GB3189386@google.com>
To:     Emily Shaffer <emilyshaffer@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jul 10, 2020, at 20:46, Emily Shaffer <emilyshaffer@google.com> =
wrote:
>=20
> On Thu, Jul 09, 2020 at 07:45:47PM -0400, Derrick Stolee wrote:
>>=20
>> On 7/9/2020 7:16 PM, Jeff King wrote:
>>> On Thu, Jul 09, 2020 at 08:43:48AM -0400, Derrick Stolee wrote:
>>>=20
>>>>>> Is it infeasible to ask for 'git maintenance' to learn something =
like
>>>>>> '--on /<path-to-repo> --on /<path-to-second-repo>'? Or better =
yet, some
>>>>>> config like "maintenance.targetRepo =3D /<path-to-repo>"?
>>>>=20
>>>> Sorry that I missed this comment on my first reply.
>>>>=20
>>>> The intention is that this cron entry will be simpler after I =
follow up
>>>> with the "background" part of maintenance. The idea is to use =
global
>>>> or system config to register a list of repositories that want =
background
>>>> maintenance and have cron execute something like "git maintenance =
run --all-repos"
>>>> to span "git -C <repo> maintenance run --scheduled" for all repos =
in
>>>> the config.
>>>>=20
>>>> For now, this manual setup does end up a bit cluttered if you have =
a
>>>> lot of repos to maintain.
>>>=20
>>> I think it might be useful to have a general command to run a =
subcommand
>>> in a bunch of repositories. Something like:
>>>=20
>>>  git for-each-repo --recurse /path/to/repos git maintenance ...
>>>=20
>>> which would root around in /path/to/repos for any git-dirs and run =
"git
>>> --git-dir=3D$GIT_DIR maintenance ..." on each of them.
>>>=20
>>> And/or:
>>>=20
>>>  git for-each-repo --config maintenance.repos git maintenance ...
>>>=20
>>> which would pull the set of repos from the named config variable =
instead
>>> of looking around the filesystem.
>>=20
>> Yes! This! That's a good way to make something generic that solves
>> the problem at hand, but might also have other applications! Most
>> excellent.
>=20
> I'm glad I wasn't the only one super geeked when I read this idea. I'd
> use the heck out of this in my .bashrc too. Sounds awesome. I actually
> had a short-lived fling last year with a script to summarize my
> uncommitted changes in all repos at the beginning of every session
> (dropped because it became one more thing to gloss over) and could =
have
> really used this command.

I was planning to build a CLI tool that help manage multiple repos =
maintenance
like what was just described here.
My experience using my poor-man-scalar [1] bash script is: For multiple =
repositories,
the process count could get out of control quite quickly and there are =
probably other
issues that I have not thought of / encountered...

There is definitely a need to keep all the repos updated with pre-fetch=20=

and updated commit-graph, while staying compact / garbage free.
Having this in Git does simplify a lot of daily operations for end =
users.

>=20
>>=20
>>> You could use either as a one-liner in the crontab (depending on =
which
>>> is easier with your repo layout).
>>=20
>> The hope is that we can have such a clean layout. I'm particularly
>> fond of the config option because users may want to opt-in to
>> background maintenance only on some repos, even if they put them
>> in a consistent location.
>>=20
>> In the _far_ future, we might even want to add a repo to this
>> "maintenance.repos" list during 'git init' and 'git clone' so
>> this is automatic. It then becomes opt-out at that point, which
>> is why I saw the _far, far_ future.
>=20
> Oh, I like this idea a lot. Then I can do something silly like
>=20
>  alias reproclone=3D"git clone --no-maintainenance"
>=20
> and get the benefits on everything else that I plan to be using
> frequently.

This started to remind me of automatic updates in some of the popular =
OS.
Where download/install/cleanup update of multiple software components =
are
managed under a single tool.

I wonder if this is the path git should take in the 'new world' that =
Junio mentioned. [2]

But I am also super geeked reading this. :)

>=20
> - Emily

Regards,
Son Luong.

[1]: https://github.com/sluongng/git-care
[2]: =
https://lore.kernel.org/git/xmqqmu48y7rw.fsf@gitster.c.googlers.com/=
