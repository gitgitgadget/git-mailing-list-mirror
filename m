Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795A1C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 23:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344043AbiBKXEi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 18:04:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiBKXEi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 18:04:38 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAF8C65
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 15:04:36 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id i17so19270266lfg.11
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 15:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/53RrJTpRzHJ1WG80o0JBxQrZcBpeHhGedqq8e3Q14=;
        b=gLE0QV8Vtwr93xExABdOZr/wZEwxl1jgLZYwER3dxvWdYYu+MyjaK6yI39wRFTMiWU
         E9uMi/FQsHVULCNBpcMMqG4huCM9WHf9TXULditvouZ1O1YyQJLb0BDCLLsPLLqOe9yD
         iIa88Ts+KDPi6eXedwuhclAZau/iYlzUoGZAG43zdHiG63DTDUv8c9pchzzPHGX/kNJX
         KcgV+WdOhQ02Gv1Lvld80DLnpwvpCQkkmrlB9XLBaL7IHlb9SPPTw/DxSF/c3q5avD3p
         vItNFIC7YHKf7zYUKerj/wCErd/2go6ljYCri/2Koxo3kOP+KmFWek1uB9FR/cRc/8Vd
         D9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/53RrJTpRzHJ1WG80o0JBxQrZcBpeHhGedqq8e3Q14=;
        b=corLTnqmLG2uNAsz3zCEZo7SXUy1nCnBorx7krl+JvT/ia4IktGWQ0IckfXtpwTVn2
         SKdjjPEfhMcL25N2P9qy/Gsmd/mMNuEYDFFI4BPbhTnKua1I0kptPE9mjN0aWNwyRZRJ
         pXMPTtfeDM1OD5eX+kt20F4FoCdKsE48hv1L+qMYbOKG7GzHDhc1MTdnA66viA6NzuO1
         8qkEx2p5ii3f5D6Fxpu2YhfpuChXHIo5/Hsb0A85+/JdpyfRMu0KimpVO9EA0p2Mee+w
         EvMtKKPU2zqq8c3O4VBx+Ir+4e3Jrjl62NXt0qrdHK4uqs3TiYmH+UywbAcNVj969sff
         6kig==
X-Gm-Message-State: AOAM532ONSJ1YwbVL0yibLbPEsPjbmbe96U05LwSegJJlws0nbLEQkn9
        b+isdRr9+lAe9Vpz49DsMuFWzZ0FWs8zd/YGGl9RRTJoA2g=
X-Google-Smtp-Source: ABdhPJwU8Bee8Xnukc2vXeermhkesel8mDMJvORh/DHl1bvzlcyVz0Ng4IO0sYd+H4jmMDqNYY1Qmjn+U6tWlQ28b2E=
X-Received: by 2002:a19:7518:: with SMTP id y24mr2574866lfe.557.1644620674299;
 Fri, 11 Feb 2022 15:04:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
 <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com> <7a164ba95710b4231d07982fd27ec51022929b81.1643686425.git.gitgitgadget@gmail.com>
 <xmqqr18m8514.fsf@gitster.g> <xmqqy22u6o3d.fsf@gitster.g> <CANQDOdfVg4e=nLLAynm261_R5z+rjZV3QgE8nLwGEmj1wQm_uA@mail.gmail.com>
 <xmqqczjt9hbz.fsf@gitster.g>
In-Reply-To: <xmqqczjt9hbz.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Fri, 11 Feb 2022 15:04:23 -0800
Message-ID: <CANQDOdcRM-GdxQ6iiV6pSBZifzpn+vJrBi0f88um9Rk4YJMFng@mail.gmail.com>
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

On Fri, Feb 11, 2022 at 2:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Neeraj Singh <nksingh85@gmail.com> writes:
>
> > The main motivation for this more granular scheme is that I didn't
> > think the current configuration follows a sensible principle. We
> > should be fsyncing the loose objects, index, refs, and config
> > files in addition to what we're already syncing today.  On macOS,
> > we should be doing a full hardware flush if we've said we want to
> > fsync.
>
> If the "robustness vs performance" trade-off is unevenly made in the
> current code, then that is a very good problem to address first, and
> such a change is very much justified on its own.
>
> Perhaps "this is not a primary work repository but is used only to
> follow external site to build, hence no fsync is fine" folks, who do
> not have core.fsyncObjectFiles set to true, may appreciate if we
> stopped doing fsync for packs and other things.  As the Boolean
> core.fsyncObjectFiles is the only end-user visible knob to express
> how the end-users express the trade-off, a good first step would be
> to align other file accesses to the preference expressed by it, i.e.
> others who say they want fsync in the current scheme would
> appreciate if we start fsync in places like ref-files backend.
>

In practice, almost all users have core.fsyncObjectFiles set to the
platform default, which is 'false' everywhere besides Windows.  So at
minimum, we have to take default to mean that we maintain behavior no
weaker than the current version of Git, otherwise users will start
losing their data. The advantage of introducing a new knob is that we
don't have to try to divine why the user set a particular value of
core.fsyncObjectFiles.

> Making the choice more granular, from Boolean "yes/no", to linear
> levels, would also be a good idea.  Doing both at the same time may
> make it harder to explain and justify, but as long as at the end, if
> "very performant" choice uniformly does not do any fsync while
> "ultra durable" choice makes a uniform effort across subsystems to
> make sure bits hit the platter, it would be a very good idea to do
> them.
>

One path to get to your suggestion from the current patch series would
be to remove the component-specific options and only provide aggregate
options.  Alternatively, we could just not document the
component-specific options and leave them available to be people who
read source code. So if I rename the aggregate options in terms of
'levels of durability', and only document those, would that be
acceptable?

Thanks for the review!
-Neeraj
