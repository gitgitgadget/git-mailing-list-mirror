Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BC8ECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 16:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiIBQwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbiIBQw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 12:52:27 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C8E10950C
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 09:52:26 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id w139so2421456pfc.13
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=0tbK7KZEYUWINTj9NMC1n2+nHWOT6+APCFqsHsWUFU8=;
        b=Vgv0lpIMk2vJrq032AMr498C9HWQXOaT3t0SBc3ONjFj2G9kKJCXCI30qVldf1HyIT
         LAWE32dB/ICYPQx59gwJZl3V0zj4Kj9Gtw/zZ85NKQXxVfCECgZOpyHFwLWq3xuCKvui
         uvSyOnhsgUWaniFM4Q7wtQjtwcx97Q1hCllQN4XD4ecZOpWZapqfxO1erqJEJJNmX7rv
         FbPtUttkA417tEv6tU2tgWBcQV74Pg87lcIhE7Ywqzknq34flqupl5F13B3G1pA0z1Ge
         BrPX/xg1CL3QCOW1pKRq2mKLEtqvNkWrqU/boSMR9rUjfylGuU0Snvb2henoDmOfWXz7
         lp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=0tbK7KZEYUWINTj9NMC1n2+nHWOT6+APCFqsHsWUFU8=;
        b=dPZRURQNnOj7UrYCQHCOwvy2eUtF3ayhabTyDAwla1UWFSq1j08CLgSyAitpUpYaiF
         hSeJf6k5ckrzPW1+Gq7s+8yIHWFceHoS7NewwLYaB8sHDantUod2atLow3OCcdtsmyid
         SrZpRxzbOiwXJfqAzSY3HckDcsaHLQ1PbgdtEzCfQdJs1DD0GFWOzcGP238O+GlzLDCm
         NpWR4qAhyArZimDu1ocL0ywQ8PaAS7JBbCMTHTFfpNKayoFH0jm+fzdJIr6Q5lY9bV85
         DGOqg9c2mu3fN++7qtlR+xlbm8yyV/d1mARyQWTXIQuFNJvtd34XbXB9CO5DQaJVAM7H
         HBtw==
X-Gm-Message-State: ACgBeo3+OKfK2AHH/3MB/+ZlbXTCVIEsckUv+jMAYrIs/P4z/KF1mkpx
        9MTu6wXlr98h8kqAIfoRAt0=
X-Google-Smtp-Source: AA6agR4tdhNpZSqiGS+q/JsYKPS4pwKnCi7CnGWwvWlJa/DzPcqRrWI1GeALECS0WSfHr/0KfUR9JQ==
X-Received: by 2002:aa7:9739:0:b0:538:4931:f7bb with SMTP id k25-20020aa79739000000b005384931f7bbmr24408848pfg.68.1662137546021;
        Fri, 02 Sep 2022 09:52:26 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b00174a5e1afe9sm1852017plm.114.2022.09.02.09.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 09:52:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Victoria Dye <vdye@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com
Subject: Re: [PATCH 5/8] scalar-clone: add test coverage
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
        <a3b7cb0a3bd1f56172db8420b9e80a26be1fda5d.1661961746.git.gitgitgadget@gmail.com>
        <o429p430-sp18-rr20-p2ro-4r60qs2n83o5@tzk.qr>
        <23e8901f-b543-dbb5-c7e1-fa653fdf3d57@github.com>
        <9n46p076-q126-o813-8s39-936s6667o7o1@tzk.qr>
Date:   Fri, 02 Sep 2022 09:52:25 -0700
In-Reply-To: <9n46p076-q126-o813-8s39-936s6667o7o1@tzk.qr> (Johannes
        Schindelin's message of "Fri, 2 Sep 2022 11:07:13 +0200 (CEST)")
Message-ID: <xmqqwnal90s6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> That being said, even if I update 't9211', my experience with Git's test
>> suite is that very few tests preserve test repos this way. Do you expect
>> these artifacts to be especially helpful for 'scalar clone' in particular,
>> or is this more of a "gently nudge contributors to make this standard
>> practice" sort of recommendation?
>
> Thank you for this question, which helps me clarify even to myself what my
> intention is.
>
> After considering this, yes, I would like this to be a gentle nudge to
> take a tiny step toward improving Git's test suite by recommending a new
> standard practice.

I agree that it would in general be a good idea to leave more cruft
for those who want to postmortem.  It will nudge a sequence of tests
to use distinct test directories and output files, in order to avoid
letting the later ones overwrite the earlier ones, which would be a
deviation from what we have done historically.

For those who diagnose breakage manually after seeing "tXXXX.sh -i"
fail, cruft left by earlier successful tests are quite distracting
nuisance and that certainly was why we tried to remove them after
each test piece succeeds.  These days, we seem to be relying much
more on unattended bulk tests at CI than before, which changes the
equation.


