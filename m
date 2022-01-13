Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64E2C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 08:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiAMICC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 03:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiAMICB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 03:02:01 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0EDC06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 00:02:01 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id k15so19853025edk.13
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 00:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwHwF51a1lFjPDxxViuRVeHiaiup/QF+EMjjpMAljoA=;
        b=OTyKFjRLv5HOFGP02ZbYoVRrs4rMOUvhBIgOkdmS2CwVw1lcTPxa+z9qlAQPAviNgd
         tqo5iqA0wm4cUZsJU//2CcqKEOdlTxXrvlBGL3TRKjAi0+orGBHX8OcBa4BC/w6Wr2E4
         Gvh44le7GTYgIWoP65Fk6t01LpuHZBtuL6Q+wlKAGoedOtpP0JcPMnVugwCrlBUwDrJv
         oHrwOMwCOTQ9xCT9aLAPDwvBx59vllHrPEphl2siAF21U2PY5qi+4ux5vqizqv/AJm5t
         OO0skqVkmwkio9ZgM5f0Ij3BehEPQXsgiRM9hyfuM7FF5HJtqIh6vXhtUh5n77sdaQ8I
         J/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwHwF51a1lFjPDxxViuRVeHiaiup/QF+EMjjpMAljoA=;
        b=yLMo6TZ4i33fvFBQU9Nbty6khw/P+wZh/TBA7AWkSKAf7YeJ36zLskYJ/Nq584Et3g
         3PlyrXDA07SEK0OY1P9oPlKowS1ZswRxm3Gn5t9SSqY3VWVyG15p6PusFd3RLWqlkhpg
         xkzP6T5OITRSRxeXynUwvr5nOZKgYIaCTLdfyWCTiIlfmBp6CGZQQRjmiO34s2DdE5vo
         nTOUEfKJqZBvicFnES+5tG/3ezl0NJp2gZmKUTKtBShLWKYCrygspWQinbx2J2/ATPOU
         U1oYf7/nxYQ3fCInt/QVCHzAMkeEqPmvlGHb9G+IdlhvNFnXCyFFvrTJXx0YMCLeVY6S
         aegA==
X-Gm-Message-State: AOAM532Br/gGPz++6vB29R7xV4iJz1IBxz1JCD2f+11gtIUH7dkxkqhB
        6BV6AKntmPIy7oW/9HqeyJdkbdga0yIQtv5T2Gs=
X-Google-Smtp-Source: ABdhPJyAuPzmzrZDeikcSMWxvaVBgXw1IJ90+3PbJZSrsQo4MjfGfbv7UH0sHDNkmpfgYgIEJ9T6Nw9u/AjE1P69nXs=
X-Received: by 2002:a50:f086:: with SMTP id v6mr3176378edl.94.1642060919863;
 Thu, 13 Jan 2022 00:01:59 -0800 (PST)
MIME-Version: 1.0
References: <20220105163324.73369-1-chriscool@tuxfamily.org>
 <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com>
 <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
 <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet> <xmqq8rvn1nkw.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2201111439190.1081@tvgsbejvaqbjf.bet> <220111.86mtk2xb1y.gmgdl@evledraar.gmail.com>
 <CABPp-BFei07srZBgyKs6HCm+G+hmPR-3_EkKjRK8WwGL1Uf2oA@mail.gmail.com>
 <xmqqk0f4x20a.fsf@gitster.g> <CABPp-BHQdkhAEmTrtc+XMgj5A5ASBVRw0_bXH10NSrMsyRK+oA@mail.gmail.com>
 <xmqqk0f4jhh8.fsf@gitster.g>
In-Reply-To: <xmqqk0f4jhh8.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 13 Jan 2022 00:01:47 -0800
Message-ID: <CABPp-BGZrcdAw369snSi3EOMcEFP77KUcfux1VNG5f2xorzGQA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 10:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> so it may be quite simple to deprecate "merge -s recursive".
> >
> > Yes...but why deprecate?  I thought the plan was to (eventually) make
> > requests for either `recursive` or `ort` be handled by running the
> > `ort` backend.  Making that kind of switch is much smaller than the
> > one we already made to switch the default backend from `recursive` to
> > `ort`, so I'm not sure I see what we gain by doing such a switch in
> > stages.  Maybe I'm missing something?
>
> Didn't we "deprecate" but still indefinitely support "annotate"?  I
> have been assuming that recursive will be in that category after ort
> establishes itself.

But in that case, we suggested folks use "blame" instead of "annotate", right?

From a user point of view, my intention was that "ort" is just the
newer version of "recursive" (which happens to be an essentially total
rewrite).  ort only got a separate name because we wanted a special
testing period and a way for users to select the old version of
recursive or the new version of recursive.  Of course, that period is
multiple release cycles, so both names will persist, but they'll just
be aliases.

Once we switch "recursive" to mean "ort" so they both run the exact
same code, I was intending to have the documentation prefer the term
"recursive" over "ort" since it is a more meaningful user-facing name.
