Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B28C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C50B6056B
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 22:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhHCWsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 18:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhHCWsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 18:48:25 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EC0C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 15:48:13 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so24349oti.0
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 15:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ia00VthI0n/j/M7CxUug42gSubT9c4mo8ep+vN36NsQ=;
        b=Ep1vIO10vYQXLXWiLh5kp8N8hGU9ttFbnigFTp/7TqtcuH68i/LNkrg3GeWjnTLlxw
         bH7Z5T2qBNt3luLjC2xZAeuWZyIQhS9UBqFPStsFzot40v9j9YfmHjjKJZKHigR54X7z
         fyhsnCacxzfrCnZ5IphJQkPsMuOp66mm8tyWMB2Y0F2hFyqEzZXV2mWJ1DbI9v5hEZkG
         Z1+jU30yG7glFxGQgvMUqHnOOcDXuZLKTxwSCuCol3FFdH7ZZANVPhTPyqBRa28lJZw1
         fOUva5svz5rzKxVn2cHmrWZqQosVhus5YCoefG1W5bz+7YvaPwJR9IyOSkqFkd5mxptL
         Xvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ia00VthI0n/j/M7CxUug42gSubT9c4mo8ep+vN36NsQ=;
        b=Hkgjq5xQH7OKzJlI2VWq44UH95uS4HbBUwR/JYhaiPEK885j3YU2TFVOm666ZsLF+Q
         OfuG1Y5/m3LREBrh+zi5zs86VihpObJW68tvFPgKg0eHJFwTla0luwQ9N/AfYalkt2Ng
         VFlc1RMEo8WeVBDH3whykZkuaVzvoi18RMl/uEoXv+vDk91wu4WrnUHBI0utl4AYywdJ
         g5+TSZNxPrdKPqAHmmZuOocCO9bbJLPu5RfImSbcmyGy+wQ0Xebn/dKUA6gv/B9Lazll
         pDK4FW+KxGX0FaLcaMcp6bj8/wJP1INOn7Gv3h5M6JiA7/k2Wgtchf+hmbC8SI1UlcXi
         TIzg==
X-Gm-Message-State: AOAM532NdjSFpHBNnOIDx837R9RfiKDdDCluMqdvkXqpmDgM3dtkfuUj
        M+5CHihHMOHLRONyDLmXXTCZc8Fgd3uLfnC0fjM=
X-Google-Smtp-Source: ABdhPJxIy/KYwGToVB5sOP8TfD6tRZtqSeHRBvtlcqhdizLF0pECjQJASc1OwXjl74WmQHLloW9043+vU8TGDU/sX4k=
X-Received: by 2002:a9d:3a08:: with SMTP id j8mr16654956otc.247.1628030893283;
 Tue, 03 Aug 2021 15:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
 <YQlnNXgk3qcGb5Bk@coredump.intra.peff.net> <xmqqim0mtc3u.fsf@gitster.g> <YQnFMmyd744Oolep@coredump.intra.peff.net>
In-Reply-To: <YQnFMmyd744Oolep@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Aug 2021 16:48:02 -0600
Message-ID: <CABPp-BFyjDzwLgdpWZC59y4=t5=QZ8e8XFZ8HiPzFK=vSJkc4g@mail.gmail.com>
Subject: Re: [PATCH 0/2] [RFC] Switch default merge backend from recursive to ort
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 3, 2021 at 4:37 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 03, 2021 at 03:08:53PM -0700, Junio C Hamano wrote:
>
> > Jeff King <peff@peff.net> writes:
> >
> > > It would make sense to me to do the switch in 'next' early in the
> > > post-v2.33 cycle. It can cook there for a bit, but I think we have found
> > > that it's much more likely to see actual use once it hits 'master'. So I
> > > don't see a particular reason to have it sit in 'next' for a long time.
> > > We should get as much exposure in 'master' during the v2.34 cycle as
> > > possible.
> >
> > I do not mind queuing what is available today to 'next' to gain 2
> > more weeks of dogfood time during the pre-release freeze.  If an
> > simple escape hatch that lets us say "anytime we ask ort, use
> > recursive instead as an emergency measure" can be added with a
> > trivially obvious small patch, that would be a plus.
>
> Yeah, I am happy even starting the 'next' portion sooner than the
> release. :) As Elijah explained, we already have that emergency measure
> in place (pull.merge).

s/pull.merge/pull.twohead/  Relevant commits:

1c7b76be7d ("Build in merge", 2008-07-07)

14c4586c2d ("merge,rebase,revert: select ort or recursive by config or
environment", 2020-11-02)
