Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3D5C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 11:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57FF60F21
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 11:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhINLsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 07:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbhINLsT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 07:48:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507FBC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 04:47:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v24so13199216eda.3
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 04:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=X8DS1TTrI3z9AUV+5qQ055SEOlLEu+B7+oAtsCsTKEM=;
        b=eFOdWblux6HVP2REmBgnR4TF6x57NtUb7kbkkjDtKl2ZDLkwQKLDivQob9i+DvelGI
         qlXczxmFjvARLhXCvaeVsDnTmhKUUI4182IqElcvXPnbToigPV4nQo6V0HPqYhz0P67G
         SQmE8PU/puDw8arhP5LHpx/hpNuufTHx6qIitF54ay6370w/SiXowp/hYg2LiqK9fQD9
         eDiFzowAnncWH5znAi9+F0r+qP2BgOxK+Q8Hu3EqsL7E+X7fhlTIRGJv9BOiRobXnSh1
         ofuAgQbvtv3VYHPhpPJXPYPZcDu2abv164QxoIEexsdbexc0ONxQWxaciry2DhkhdOQv
         mH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=X8DS1TTrI3z9AUV+5qQ055SEOlLEu+B7+oAtsCsTKEM=;
        b=JtoDTaeuMNX2kdlqUftHNkUj/mUOSamnKLynX+KYUj182FrT60FsHXh7qbD6vod8ga
         j3FiSbHXo6a3TIF4ijqM45dyz53uoMNWVW98FxK1qXOQprMPDfAkWZjKTJzEyIK0fPXj
         mncirtE8EpDDpBrGas4MRqYV3xf1pOodrQ2Y8oV0V+hnyxJuHAMHoDKQz3Sr9Y8nnPsV
         ZN/PJhcGIjSBr6S89hGlCNJH7ye/vRZkTLl0hJYWwDECkYSA6VKV2JmCneJJjFNv53Kj
         xIbQtYmfIoucfFcEEW/mcZeGPGOiMDddZbHpER5GBpfvtVsxXlGzDSse2rYw+D2Hr2lA
         VnSA==
X-Gm-Message-State: AOAM532Yz53fGOJ8hIX+g1GCIv4vO9b6dUxOMxkTnD9FdbJSJQLlgJkk
        SZ+RTm04DiNVmS9Dwx4ltTU=
X-Google-Smtp-Source: ABdhPJydgpODp1aPsZF9IgCy6ctLVRdUSMFv6Bnq6al/CRHdXPud+1qSMc26fTDNjyUBODh5rHhL0g==
X-Received: by 2002:a05:6402:54:: with SMTP id f20mr19456616edu.382.1631620019830;
        Tue, 14 Sep 2021 04:46:59 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w11sm5362726edl.12.2021.09.14.04.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 04:46:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 00/15] [RFC] Upstreaming the Scalar command
Date:   Tue, 14 Sep 2021 12:59:56 +0200
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com>
 <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
 <87r1dydp4m.fsf@evledraar.gmail.com> <87ilz44kdk.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2109131914080.55@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <nycvar.QRO.7.76.6.2109131914080.55@tvgsbejvaqbjf.bet>
Message-ID: <87mtofnzv1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 13 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Mon, 13 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>
>> On Thu, Sep 09 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> > On Wed, Sep 08 2021, Johannes Schindelin via GitGitGadget wrote:
>> >
>> >> Changes since v2:
>> >>
>> >>  * Adjusted the description of the list command in the manual page , =
as
>> >>    suggested by Bagas.
>> >>  * Addressed two style nits in cmd_run().
>> >>  * The documentation of git reconfigure -a was improved.
>> >>
>> >> Changes since v1:
>> >>
>> >>  * A couple typos were fixed
>> >>  * The code parsing the output of ls-remote was made more readable
>> >>  * The indentation used in scalar.txt now consistently uses tabs
>> >>  * We no longer hard-code core.bare =3D false when registering with S=
calar
>> >
>> > In the summary I had on v1->v2 points 1-3 are for v2->v3, respectively,
>> > outstanding, addressed, outstanding:
>> >
>> >     https://lore.kernel.org/git/877dfupl7o.fsf@evledraar.gmail.com/
>> >
>> > In addition the discussion ending here:
>> > https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109082112270.55@tvgsbej=
vaqbjf.bet/
>> >
>> > For that point: I think it's fair enough not to properly handle the
>> > cleanup case in "scalar clone", but perhaps add a note in the commit
>> > message that unlike "git clone" this is known not to clean after itself
>> > properly on ctrl+c?
>>
>> Seeing [1] about the planned re-roll I have the above a shot a few days
>> ago, see the original discussion at [2] (indirectly linked above).
>
> There is a good reason why I did not engage in that tangent about
> deviating from the established `contrib/*/Makefile` paradigm: I find it
> particularly unrelated to what this here patch series is trying to
> accomplish, and I cannot bring myself to be interested in the proposed
> build system changes, either, because I do not see any benefit in the
> changes, only downsides.
>
> I find the distraction unnecessary.

Perhaps I'm reading too much between the lines here, so forgive any
undue knee-jerk reaction.

But aside from any technical disagreement we may have I find this way of
handling reviews quite disrespectful of other people's time.

Sure, maybe I'm wrong, and maybe you either don't see any value in the
proposed changes or maybe they're just bad suggestions.

I still took the time to review and comment on a series you're
submitting. I think the least you can do is to include some comment in a
re-roll like:

    Skimmed =C3=86var's proposal about an alternate build system
    implementation, sorry, I just don't think it's worth it, going to
    not change anything there.

Which would be fair enough, and would leave the ball in my court in
terms of either dropping it, submitting any patch on top etc.

As opposed to just ignoring that whole thread, leaving both me wondering
if it's even been seen (and sending a few reminders like the linked
upthread), as well as others trying to track the state of the series.

> Besides, the way I designed it, the code in `contrib/scalar/` intrudes as
> little as possible on the core Git build system. The impact on the
> top-level `Makefile` is quite minimal, which is just the way I firmly
> believe it should be.
>
> In short: I do not want those intrusive changes to the top-level
> `Makefile`, not in this patch series, and not as a follow-up, either.

Communication grievances aside:

 * Saying that we have an "established `contrib/*/Makefile` paradigm"
   doesn't really follow in this case. Most of that isn't C code, and
   the bits that are C code are not using libgit.a.

   And as I've argued elsewhere I think that whole pattern was a mistake
   in the first place, it makes inter-Makefile dependencies a pain to
   manage, has resulted in bitrot of things like git-subtree.sh and
   mw-to-git, all because we conflate whether we want to build/test
   things with what we'd like in a default installation.

 * Because of that any number of targets / workflows in the Makefile
   aren't going to work by default, e.g. try checking it out and doing
   "make TAGS".

   That specific one happens to because we exclude contrib explicitly,
   that could be fixed, but there's going to be any number of things
   like that, but current and future ones.

 * One target that seems missing (maybe I've somehow missed it) is any
   support for installing the build command, its docs etc.

 * I hacked a bit more on this today and came up with a not-quite-ready
   change that both for the Makefile and Documentation/Makefile will
   build scalar.c like any other top-level command, and we'll always get
   a bin-wrapper/scalar, we'll only do something different at "install"
   time.

   This means that just like the "all:: $(FUZZ_OBJS)" we'll always build
   a scalar.o, so that'll prevent others from e.g. breaking a library
   function you rely on (which'll only be annoying caught in CI, or
   integration or whatever).

 * I think it's fair to say that whatever one thinks of my argument,
   your [1] leaves the reader hanging about *why* you went for this
   "make -C contrib/scalar/Makefile".

   As summarized there you tried to have it completely separate, but
   failed.

   So now there's a bit of integration in the top-level Makefile
   already. But why try in the first place? Just slavish conformance to
   existing "contrib/" convention?

   The dependency back on assets in subdirs there is deep, so surely
   it's not to build this independently somehow.

> We have much bigger fries to fry: namely, how to migrate the improvements
> for large-scale operations from Scalar to core Git, so that all Git users
> can benefit. Granted, it will take a lot effort, and it would be easier to
> move around `Makefile` rules instead. But ultimately, the benefit of
> allowing users to handle larger repositories with ease will be worth that
> effort.

It's your implementation that requires mostly moving around / copying
Makefile rules, if you piggy-back on the existing Makefile rules you'll
get most of the behavior you've duplicated for free without any moving
or copying.

But in any case, re the last bullet point above and your "[...]and not
as a follow-up, either" comments it's not clear whether you're saying
that you don't have time to work on this, or that you wouldn't want it
at all in any shape or form, even if someone else did it.

Which is not to say that I'm promising to do so even if that's the case,
I do think the onus is on the person proposing the change, and to take
productive feedback about things that are introducing unnecessary
complexity, and won't saddle others with undue technical debt going
forward.

1. https://lore.kernel.org/git/b8c7d3f84508ae0fb300f47c726764f4cbf46be9.163=
1129086.git.gitgitgadget@gmail.com/
