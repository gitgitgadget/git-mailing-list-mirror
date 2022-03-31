Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DCAC433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 19:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbiCaTLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbiCaTK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 15:10:59 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A268A320
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:09:11 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q14so996239ljc.12
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3RTVZHw9bOkQKWOyF4r3i7lAn6JnOBLNDkPpgpi2BY0=;
        b=AooOpp85OgcIeLzTpAP8rumZ5oLUJGS7MJQ1xshMELFWfvq4vFD3pHIH0MFoIl2AQp
         5fj6dPoIitc5d+iGvk33w1R0jTMZk9Z4CyCBNx25SDq6V6JkkrL8bkvElrjK74pvWFn4
         SRFCmHNFje5q3nejLu4QvxfNF7bCvmuS86noADZEbVyzjqBnJo5RopiHAjmGvQZ1f8Kj
         7w78odlDg/Un6f8I/Jcy/4XlOsd7Rg/dMYQq/OltQ5LHSUDKx1xc0GqXx9GT3uDdKztl
         +7PISbbKIDfUPxZtGhNiI0TF7EqY+PdF2YOcybXS/e1C7P7XRQMU5f4cJ5TRhKl+6PQ7
         3B2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3RTVZHw9bOkQKWOyF4r3i7lAn6JnOBLNDkPpgpi2BY0=;
        b=Il+oSHpJb4jtDw3U6tgvxSnDgcLp68LSffvZTFf9Y1tPp1LHo6bTQucKP3QC1oPCRT
         gRg5rs2p8+x2AenByuHgvuc2pTkhaj7S9ljj0+Wh9bEzLJAP7zC0geeWpaniSQpg8Car
         287FK8ticq6a8A7WppIaQw5/+pjDSL8/nN0H9uxxyaaySyX3mHwXy28+0nWln3MdqGGg
         6mM+iOnYHVdTQWANpnGxhUlhjVXNsquNZhRltP3zHXeovWZ9OFMQHjLqW1q9HBsncOVc
         tcYSKxVjIVHHTYjoB3tpcQiFGpnTEuGDx50DcyrYO0RKeYBtHLixOcEeQon8KR74r1QC
         yD7g==
X-Gm-Message-State: AOAM530UJ8E0LybsBWY9ydYOAXNsnO3DrMUpQmu+/myZ2F68iiPGFojo
        IjvzQjABQJt8K1Qx3drqAdAvwafd63qZRY5jqDs=
X-Google-Smtp-Source: ABdhPJzDVTC8O6YbrNHW4bIRBLaeemX7HdxhqNWrmJWvwd8ZV3nG1hkg45SAgWv1IPTaTYlak4nFa39WLbag21VtaTA=
X-Received: by 2002:a2e:bc1e:0:b0:249:896f:6dbf with SMTP id
 b30-20020a2ebc1e000000b00249896f6dbfmr11441474ljf.180.1648753749737; Thu, 31
 Mar 2022 12:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
 <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com> <c7a2a7efe6d532fc7fce1352b1dfce640cc9f2f6.1648616734.git.gitgitgadget@gmail.com>
 <xmqqpmm39xhx.fsf@gitster.g> <CANQDOdfWTufEn0NRSAOG991JcS4x8GsCC62UCLUTEc3gD6tfGA@mail.gmail.com>
 <xmqqr16j6ve3.fsf@gitster.g> <CANQDOdcDY-8TZzCHx+tWZJoD0rsULnfaWRhAOox3drSgxW_+ow@mail.gmail.com>
 <xmqqy20q2eqn.fsf@gitster.g>
In-Reply-To: <xmqqy20q2eqn.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 31 Mar 2022 12:08:57 -0700
Message-ID: <CANQDOde9+x087efFad+y9ir_amv-Km61-+7BnBn2CShw22rkcg@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] bulk-checkin: rename 'state' variable and
 separate 'plugged' boolean
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 31, 2022 at 10:50 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Neeraj Singh <nksingh85@gmail.com> writes:
>
> > Just to understand your feedback better, is it a problem to separate
> > the state of each separate "thing" under ODB transactions into
> > separate file-scope global(s)?  In this series I declared the fsync
> > state as completely separate from the packfile state.  That's why I
> > was thinking of it as more of a naming problem, since the remaining
> > state aside from the plugged boolean is entirely packfile related.
>
> Ahh, sorry, my mistake.
>
> I somehow thought that you would be making the existing "struct
> bulk_checkin_state" infrastructure to cover not just the object
> store but much more, perhaps because I partly mistook the motivation
> to rename the structure (thinking again about it, since "checkin" is
> the act of adding new objects to the object database from outside
> sources (either from the working tree using "git add" command, or
> from other sources using unpack-objects), the original name was
> already fine to signal that it was about the object database, and
> the need to rename it sounded like we were going to do much more
> than the object database behind my head).
>
> > My argument in favor of having separate file-scoped variables for each
> > 'pluggable thing' would be that future implementations can evolve
> > separately without authors first having to disentangle a single
> > struct.
>
> That is fine.  Would the trigger to "plug" and "unplug" also be
> independent?  As you said elsewhere, the part to harden refs can
> piggyback on the existing ref-transaction infrastructure.  I do not
> know offhand what things other than loose objects that want "plug"
> and "unplug" semantics, but if there are, are we going to have type
> specific begin- and end-transaction?
>

With regards to bulk-checkin.h, I believe for simplicity of interface
to the callers, there should be a single pair of APIs for plug or
unplug of the entire ODB regardless of what optimizations happen under
the covers.  For eventual repo-wide transactions, there should be a
single API to initiate a transaction and a single one to commit/abort
the transaction at the end.  We may still also want a flush API so
that we can make the repo state consistent prior to executing hooks or
doing something else where an outside process needs consistent repo
state.

Thanks,
Neeraj
