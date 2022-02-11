Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9889BC433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 21:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349282AbiBKVSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 16:18:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiBKVSY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 16:18:24 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6F0C58
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 13:18:22 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id c10so1493607ljr.9
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 13:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cpDGhWWbwxavwmNWMjVlEiVlpa5K/igApkJwtrkJgvw=;
        b=hi7BhWNsm6yoq1n40eDwFje9gNG1Qxluu8Klb/LZrcz99Eoj0QCKHhfXx+D3FLu2EB
         KYe0v9NP4APP+oXJmpi4RpsOhRZszB0Jt8z0cOotTad8eS3KeIDKNYK/TtlfwX/TbM+4
         G5XM1kOIukE4tBihoZUgqhL22HLbCFt6vHpGBTJPicgeRhK5iMkim95ZcrcIaV/7pydd
         MNio/XCo6EP6wcZzxbKML0Ykayb/2Sp274OV7rfDe+FavvGYXBFpuTOZbDlSNeTfwm4Q
         +bUwtDx91FtQix7gjS+3HAQbdIMRFIYSVtU5X3iYN6td91W/+fvHmT1oDHU2Nkh2XMMf
         92Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpDGhWWbwxavwmNWMjVlEiVlpa5K/igApkJwtrkJgvw=;
        b=483++MHWKpYnnkZdw2quSxzni13RmKB/o4PRBH7qZMsLeJCbyhcn4miI2hK+T3Kvae
         erWAtDbMTgyKqYOtGSjOazqtCC2wUpx5l6GZzzY6M1pBKum/1axBKoj+h/gNujCiu1qX
         lhuYx2kaRRv7zBCYFag+/lzVcz5zIRZreCQ9NhmM38z/dl2qP/7V+pz/Mr2Ozhi7qazT
         Fg8i76s1tbeyAD+x91Kf6hR2ZIgYOIqwyUgOKQvaKdRl1iroFuxCnjXKWXcPA4PyT6Nn
         hlzsRDsti50kSQaU2VPH4BQQkdJ6/WYr/GO/LwdizCNyG1UTqww8imoLFtO8bZ5Abh2V
         hjsA==
X-Gm-Message-State: AOAM532I7bOq3V6T3yJ0ZBt1a5VnI6LW9xtoSux5rsRgJUjMVUBrUxQS
        RV9AJMGaPH9xiAz9ghWc/r3G0PUChIsb6uDQrEw=
X-Google-Smtp-Source: ABdhPJwRGFjzL4LhIORHo5QEfrhk8rRkqrhvhO23zAuuNyjj/aGg6+r29D65J/R+2kWod9SJY63ZBZsw4qEEpbUr3FA=
X-Received: by 2002:a2e:a594:: with SMTP id m20mr1993997ljp.491.1644614300458;
 Fri, 11 Feb 2022 13:18:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
 <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com> <7a164ba95710b4231d07982fd27ec51022929b81.1643686425.git.gitgitgadget@gmail.com>
 <xmqqr18m8514.fsf@gitster.g> <xmqqy22u6o3d.fsf@gitster.g>
In-Reply-To: <xmqqy22u6o3d.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Fri, 11 Feb 2022 13:18:09 -0800
Message-ID: <CANQDOdfVg4e=nLLAynm261_R5z+rjZV3QgE8nLwGEmj1wQm_uA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] core.fsync: introduce granular fsync control
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 1, 2022 at 5:42 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > I am not quite sure if this is way too complex (e.g. what does it
> > mean that we do not care much about loose-object safety while we do
> > care about commit-graph files?) and at the same time it is too
> > limited (e.g. if it makes sense to say a class of items deserve more
> > protection than another class of items, don't we want to be able to
> > say "class X is ultra-precious so use method A on them, while class
> > Y is mildly precious and use method B on them, everything else are
> > not that important and doing the default thing is just fine").
> >
> > If we wanted to allow the "matrix" kind of flexibility,...
>
> To continue with the thinking aloud...
>
> Sometimes configuration flexibility is truly needed, but often it is
> just a sign of designer being lazy and not thinking it through as an
> end-user facing problem.  In other words, "I am giving enough knobs
> to you, so it is up to you to express your policy in whatever way
> you want with the knobs provided" is a very irresponsible thing to
> tell end-users.
>
> And this one smells like the case of a lazy design.
>
> It may be that it makes sense in some workflows to protect
> commit-graph files less than object files and pack.idx files can be
> corrupted as long as pack.pack files are adequately protected
> because the former can be recomputed from the latter, but in no
> workflows, the reverse would be true.  Yet the design gives such
> needless flexibility, which makes it hard for lay end-users to
> choose the best combination and allows them to protect .idx files
> more than .pack files by mistake, for example.
>
> I am wondering if the classification itself introduced by this step
> actually can form a natural and linear progression of safe-ness.  By
> default, we'd want _all_ classes of things to be equally safe, but
> at one level down, there is "protect things that are not
> recomputable, but recomputable things can be left to the system"
> level, and there would be even riskier "protect packs as it would
> hurt a _lot_ to lose them, but losing loose ones will typically lose
> only the most recent work, and they are less valuable" level.
>
> If we, as the Git experts, spend extra brain cycles to come up with
> an easy to understand spectrum of performance vs durability
> trade-off, end-users won't have to learn the full flexibility and
> easily take the advice from experts.  They just need to say what
> level of durability they want (or how much durability they can risk
> in exchange for an additional throughput), and leave the rest to us.
>
> On the core.fsyncMethod side, the same suggestion applies.
>
> Once we know the desired level of performance vs durability
> trade-off from the user, we, as the impolementors, should know the
> best method, for each class of items, to achieve that durability on
> each platform when writing it to the storage, without exposing the
> low level details of the implementation that only the Git folks need
> to be aware of.
>
> So, from the end-user UI perspective, I'd very much prefer if we can
> just come up with a single scalar variable, (say "fsync.durability"
> that ranges from "conservative" to "performance") that lets our
> users express the level of durability desired.  The combination of
> core.fsyncMethod and core.fsync are one variable too many, and the
> latter being a variable that takes a list of things as its value
> makes it even worse to sell to the end users.

I see the value in simplifying the core.fsync configuration to a
single scalar knob of preciousness. The main motivation for this more
granular scheme is that I didn't think the current configuration
follows a sensible principle. We should be fsyncing the loose objects,
index, refs, and config files in addition to what we're already
syncing today.  On macOS, we should be doing a full hardware flush if
we've said we want to fsync.  But you expressed the notion in [1] that
we don't want to degrade the performance of the vast majority of users
who are happy with the current "unprincipled but mostly works"
configuration.  I agree with that sentiment, but it leads to a design
where we can express the current configuration, which does not follow
a scalar hierarchy.

The aggregate core.fsync options are meant to provide a way for us to
recommend a sensible configuration to the user without having to get
into the intricacies of repo layout. Maybe we can define and document
aggregate options that make sense in terms of a scalar level of
preciousness.

One reason to keep core.fsyncMethod separate from the core.fsync knob
is that it's more a property of the system and FS the repo is on,
rather than the user's value of the repo.  We could try to auto-detect
some known filesystems that might support batch mode using 'statfs',
but having a table like that in Git would go out of date over time.

Please let me know what you think about these justifications for the
current design.  I'd be happy to make a change if the current
constraint of "keep the default config the same" can be relaxed in
some way.  I'd also be happy to go back to some variation of
expressing 'core.fsyncObjectFiles = batch' and leaving the rest of
fsync story alone.

Thanks,
Neeraj

[1] https://lore.kernel.org/git/xmqqtuilyfls.fsf@gitster.g/
