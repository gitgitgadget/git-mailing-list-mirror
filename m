Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14584C433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85C62087E
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbhAUX0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 18:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbhAUX0S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 18:26:18 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A62C06174A
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 15:25:38 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id x23so4461946lji.7
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 15:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/bspqzR7e4WdXA8Fsr4imO+A8C6n2vE2uXagvKazNM=;
        b=SXvkKT/sIYUGvHudP+HgC75bvOtnxgEyhobiUOoNTZxNGR35aPP005MmfJFS4f4iui
         n0WTiek03bJeaHG4zvqpYw8etRI6q+EUyRFOnyajHjXB6XaIUZU3/cRdEiv79St1HGCT
         z97Y2NCdRdhKDCXZnUXNTk6/8Qbg3mkb38/Ietvp3BycWw52/3MhEq4+y/7umTJO8Y5D
         0QraXubxpBGpU7J4Lg20n6v6LfKzsL8FUzXhRmGp43SD2Xr7d7Rx5ueHL9y6qIaPRzVs
         rld+QrINwn3thd3cp/gWZlH7RGYbWxQ+3PfBWuWTLokmyXKzZYE+1jOMoSngcl00v9hV
         zVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/bspqzR7e4WdXA8Fsr4imO+A8C6n2vE2uXagvKazNM=;
        b=r3UP1JMJx1agPjMl8oUS7ASoPVqrwBnfUPDjEghyoMbITd/bAzDiUfVmvgVc7adAT9
         eEQrQM53POskQNQQRRiXS6fg9yE4ronzxlPxxoqaCK8Pp240KRbSGaGjxEGPOMTPtOoG
         a0dJFx+XsaVUzv/HlUdQBFKlsBT2r/1NlZJeremamRaeXa1cbPKnp46ZdSOXN2AKAefz
         zSt+r3UCPhNwZmu1Gv9KyAxWlRl9vwukJyD9awPh75b7OwZZcRYH7J8VFsVJi09oFpY+
         R2ABiEEVLyUDn60ohUwp0Ozo45C0htOFCNCKIx1UtC8QC8KrHUO1NH8ZnoHVFtUFc4BZ
         ptRQ==
X-Gm-Message-State: AOAM531fyXLdNiDzM9wzLGbBtWxIYaVCHTGUf8diqu5exuUWg7IprbOE
        YHVIel6QJ0Kx8gG+xuessNnztGSbyqSIlqvrnfhv0zB5ZS1dtg==
X-Google-Smtp-Source: ABdhPJxvZ/zwEqe66bIUmFhkl0on4dbg/WIKsmaZdfreatk9o1boGK49HFmw03j8f0cu8TUBBYa/f0BSDe93TpA8G7I=
X-Received: by 2002:a2e:8685:: with SMTP id l5mr168678lji.261.1611271536741;
 Thu, 21 Jan 2021 15:25:36 -0800 (PST)
MIME-Version: 1.0
References: <20210120044435.53509-1-alexhenrie24@gmail.com>
 <xmqqturbdxi2.fsf@gitster.c.googlers.com> <CAMMLpeQM7JCP0=TMqf0DxDCVJvkCGDEPSKN6vYTU_xc7+QaA1Q@mail.gmail.com>
 <xmqqo8hiaptn.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8hiaptn.fsf@gitster.c.googlers.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 21 Jan 2021 16:25:25 -0700
Message-ID: <CAMMLpeQ5ga_e5-YeVuArYBrui+ps7HWzNjWNQgeJK3sEjo2zhA@mail.gmail.com>
Subject: Re: [PATCH] rebase: add a config option for --no-fork-point
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 21, 2021 at 3:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> By the way, is the feature itself something we can test easily?  I
> think I saw the "we must interact with --root sensibly" test, but
> the actual feature not being tested include
>
>  - rebase.forkpoint set to false and then to true; does it use the
>    fork-point feature (your patch as-is would have failed this test);
>
>  - rebase.forkpoint set to false and command line says --fork-point;
>
>  - rebase.forkpoint set to true and command line says --no-fork-point;
>
> I offhand do not know if it is easy to observe it the fork-point
> feature gets triggered, but it seems that the difference in
> behaviour is big enough for you to care, so I am hoping you may
> think of a way.

This blog post describes the same problem that I had with fork-point:
https://commaok.xyz/post/fork-point/

I didn't see any fork-point tests in the current codebase, but I can
work on adding some. Do you want them in a separate patch (that would
make the most sense to me), or squashed into the rebase.forkPoint
patch?

-Alex
