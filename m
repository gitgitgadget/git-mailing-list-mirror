Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99FBC433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 19:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351546AbiCOT6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 15:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351863AbiCOT6E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 15:58:04 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C4B5B3E0
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 12:56:35 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id y17so358631ljd.12
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 12:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KZyjJm/KXuaE6HlGsSJ8cNtJ4eIFXNnuNZ9HMqRMhH8=;
        b=adVPmHiO6YDS0o6xhPR+yio31jK3wH7x7TSVkjsLzrWyeH5x0+kh3pDwFe/XMkTsy7
         4klCK5fsXspli4MZnYSbTIlTAj74enNssIppwldfKgpA834IPXCZ6FXa9A49NRsL0KUi
         DOmsE6AyAzLT4VLLWM3WUFCpCUXOzEKyKSiZnKyIsCwvpOOe7qTpLOLT/LfoXEk9r1fa
         MiKY83Ixty6JAd6oLYCqLBa8/5h3bXWdEMIez+S4yl8vGs65o7hCMmy1D/MO3dtvyy44
         LbfG2ttYJ3HNINCXYy7brChZ3cILLDPkMjg9tYU5gxzDunar+iAdK6XIK4ouEdOpVmcO
         4upQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KZyjJm/KXuaE6HlGsSJ8cNtJ4eIFXNnuNZ9HMqRMhH8=;
        b=ltVdGiEdxKLdQM9EhKwkbPN25MEHtL5Wz2Z+26gcImwxJfPc84P3CgKNHOh5//L7Is
         ZSkrVjYXIW/E1j1Pr53IK5lxolBvbFR8P/9z1lVwetVZOOTGnNci6aY3XtBlX5v2lMJl
         AxRmPsyzUBzkXEBJGxMGEPMO+J3xnYdLIsVfRsQ1svyT5qYC9A+bIPuQnKigBh6bXznT
         pWim7/YW/4d40HkYA6EMNzIBiJbDiclI38NQJ4jc+sRi8c4Q4a/X2AdgJ4UYPnZngKYG
         Wg+bJF0Vds5n8xbjkjfvuz9wtCOParITJjP5rgC+421FLm439L96PdkaukNm3bjzptJi
         T4SQ==
X-Gm-Message-State: AOAM5315J16LxKMQATS0KofoMOyu00T8atA57tpKqGVg69XH0Yr6Xehe
        XBC810rgsZ55Rt0KNZ/EnujVcn7gy/1qbDheY88=
X-Google-Smtp-Source: ABdhPJw1TCILAqpnU38NH4OYb+Gi7rEpiGYXtS4ObmdujHeurCtKq0DbTDZ0C94D88JLRynSMeck1Oqw6fFow/1Bmvs=
X-Received: by 2002:a2e:9c04:0:b0:249:3cc7:48a1 with SMTP id
 s4-20020a2e9c04000000b002493cc748a1mr5896248lji.413.1647374193758; Tue, 15
 Mar 2022 12:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <7e4cc6e10a5d88f4c6c44efaa68f2325007fd935.1646952205.git.gitgitgadget@gmail.com>
 <20220315191245.17990-1-neerajsi@microsoft.com> <xmqqv8wfc8qb.fsf@gitster.g>
In-Reply-To: <xmqqv8wfc8qb.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 15 Mar 2022 12:56:23 -0700
Message-ID: <CANQDOdcL7N=GOCf2iz0Pofxd=aR2qUD5uUarnMGO578edUPV_Q@mail.gmail.com>
Subject: Re: [PATCH v7] core.fsync: documentation and user-friendly aggregate options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 15, 2022 at 12:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Neeraj Singh <nksingh85@gmail.com> writes:
>
> > This commit adds aggregate options for the core.fsync setting that are
> > more user-friendly. These options are specified in terms of 'levels of
> > safety', indicating which Git operations are considered to be sync
> > points for durability.
> >
> > The new documentation is also included here in its entirety for ease of
> > review.
> >
> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> > ---
> > This revision fixes a grammatical mistake in the core.fsync documentation.
>
> Is this meant to be [PATCH v7 6/6] where 1-5/6 of v7 are supposed to
> be identical to their counterparts of v6 and therefor not sent?  Not
> complaining, just double-checking, as I do not want to assume and
> end up missing the final updates to the other 5.
>
> In the meantime, I'd assume that it is the case, and will fix the
> author ident (you sent this from your gmail address) before
> replacing the last bit.
>
> The only change from the previous round is "the platform default on
> most platform" -> "the default on most platforms", which looks
> sensible.
>
> Thanks.

Yes, that's right.  I was trying out git-send-email for the first
time.   I didn't want to spam the list with a whole new series where
only one patch had a change.

>
> 1:  39f4b94c2c ! 1:  dfeab99d23 core.fsync: documentation and user-friendly aggregate options
>     @@
>       ## Metadata ##
>     -Author: Neeraj Singh <neerajsi@microsoft.com>
>     +Author: Neeraj Singh <nksingh85@gmail.com>
>
>       ## Commit message ##
>          core.fsync: documentation and user-friendly aggregate options
>     @@ Documentation/config/core.txt: core.whitespace::
>      +is ignored.
>      ++
>      +The empty string resets the fsync configuration to the platform
>     -+default. The platform default on most platform is equivalent to
>     ++default. The default on most platforms is equivalent to
>      +`core.fsync=committed,-loose-object`, which has good performance,
>      +but risks losing recent work in the event of an unclean system shutdown.
>      ++
>
> Thanks.
