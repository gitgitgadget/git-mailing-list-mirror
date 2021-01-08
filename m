Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46393C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EA0623AAC
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 20:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbhAHUJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 15:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbhAHUJa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 15:09:30 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A8BC0612EA
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 12:08:50 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id w79so9611088qkb.5
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 12:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MriwwnGPEzsZuPjJQuxKEUH1r2i9p3ZEl+/Fd+WSqW8=;
        b=Zucz6aLQI+fX8ActqR1fnTEnFGtXBle98GFIKxiKW7Md7ZjImUqvC3TovZp7bkGXrr
         wSaoI3J5yRnC/dxS9P8wpzQA6i2+jHB4oyMUmi7k/gGvLwm0MRZQhASX1r3Nz1yt3l8l
         nEg8A9Gk2Hne44alXh0sdOOCNN+28774BGCqCIfbYkMaPi8B8KebWU7v2yvEYBYY9GcR
         pLW4DgVzgqUHZIKvEucE/Qq9ch0YsGDw0v5kGBlu9mn57tEvXiceteHSBCZvW9fM7IZz
         sG8a492YYnzWePgugtE1VOe/IHc/m/OHgjT23x/Q+gRP1Ki4cVPOqD2JNwQZCY1hzq1Q
         g5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MriwwnGPEzsZuPjJQuxKEUH1r2i9p3ZEl+/Fd+WSqW8=;
        b=Qx9uAJtVtl74jVfeM+SX3INM/SMpsJ4jnt5MCoCNqsLqTk4MPtcOMuw5iqM97vItNe
         TrpwWT+a//7il+j4RlOWQhRhP0k39d0Gme+jDhL812sm6ptmCz8oRNX4nkqrd37KFVNw
         Wt3EFBDBOEt1T7+pAQRs22Y8RmIbd8Y+JZIygkBaNjBzqtxrsl6C5CBpLcSYRvozl9Th
         DBn865Ka42DaaUun0uCTOEOUDcfke0K8z05wta2azjGBnkCLL95hfADlJCuua6u68toI
         ydWNg3jV2dUObPMM8HorCx5UwUop3BtpJH48eT0JWK7u4O5BEq2uub+gvuQx8byXOiTH
         klVg==
X-Gm-Message-State: AOAM532qdW6bd+wtu5rYepFqCNC1eEgZ6hEZTyYXbfO2tiD5C/DCntSP
        Dcql29ByGFtVtRNYY3z6TzzxcQ==
X-Google-Smtp-Source: ABdhPJzmQZWTPPIKo6Ws+Ot7GnrIg6+Vkg0KuqbyslMrhihPRBOtAku6CXSsqJKaErDDjwYOBTV24g==
X-Received: by 2002:a37:b105:: with SMTP id a5mr5442417qkf.83.1610136529357;
        Fri, 08 Jan 2021 12:08:49 -0800 (PST)
Received: from localhost ([8.9.92.205])
        by smtp.gmail.com with ESMTPSA id c7sm4949308qtm.60.2021.01.08.12.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:08:48 -0800 (PST)
Date:   Fri, 8 Jan 2021 15:08:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Re: Cc'ing the Git maintainer on GitGitGadget contributions, was Re:
 [PATCH 0/1] add--interactive: skip index refresh in reset patch mode
Message-ID: <X/i7zvgMJHfOmyZG@nand.local>
References: <pull.475.git.1574539001.gitgitgadget@gmail.com>
 <xmqqwobpzubw.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1911251523530.31080@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1911251543430.31080@tvgsbejvaqbjf.bet>
 <xmqqpnhfwibn.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2101071517260.2213@tvgsbejvaqbjf.bet>
 <87wnwordzh.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2101071718470.2213@tvgsbejvaqbjf.bet>
 <xmqqft3cl9rw.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2101081534380.2213@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2101081534380.2213@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 08, 2021 at 03:56:20PM +0100, Johannes Schindelin wrote:
> Hi Junio,
>
> On Thu, 7 Jan 2021, Junio C Hamano wrote:
>
> > We may not be able to automate the thinking part to decide when
> > submitter may want to get help, but an automation can help by giving
> > the submitter cues and clues when to ask for help and from whom.
>
> I fear that we're striking the balance on the side of expecting too much
> knowledge about project-specific lore from contributors.

I think that this could be reasonably addressed. When someone opens a PR
(but before the hit /submit), GGG could say:

    Your change touches these files, and so suggested reviewers include
    X, Y, Z. When you believe your submission is in its last round,
    please also include the maintainer, M.

> We already have a ticket suggesting to add reviewers:
> https://github.com/gitgitgadget/gitgitgadget/issues/219
>
> With this suggestion, too, we could go and extend that wall of text even
> further and expect contributors to just know what they are supposed to do.
> But I don't see how that would make this process more inviting to new
> contributors.

Yeah, I agree that adding this as a separate step does not make sense,
since it's hard to discover such things (especially by individuals who
merely want to send a single contribution to the project). Having this
happen automatically upon creating a PR would make more sense to me.

Thanks,
Taylor
