Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837F9C28CBC
	for <git@archiver.kernel.org>; Sat,  9 May 2020 17:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D6C21582
	for <git@archiver.kernel.org>; Sat,  9 May 2020 17:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFl9SzME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgEIRsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 13:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgEIRsV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 13:48:21 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516CCC061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 10:48:20 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c3so4170730otp.8
        for <git@vger.kernel.org>; Sat, 09 May 2020 10:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ef1wV+xe16ZERGv66DB0vU4m8peeHBbl5c96QJCfNRE=;
        b=dFl9SzMEBR74Z7Hs80MmyVsL1QFOUfHeKZ+x9ejL7hKESUG9YgsMIT2OCUWqIwq+0K
         UVm9ZMPZIhsPe/GpKe5Prlu45S9mRX2TghZUQ73mE/B1DgLzXvDDmwBfSt8CjMCCuk16
         +vvFdI7LgPwmNM8+yNYC6NYxtofzvM48/CGD+uYWiUcprN5X4JF2ERJnCabjS21DrBJg
         tP4RneL/NEKtNbWBWJ0GUMbrKXaf1grdTRDdw9+PA/Z/2DF9kHlhrImyHlF+4I8QpDwP
         Fxs2aXqVPRnWj7/r1KQR/hXt+wN8HE2pZMSmgRLpbCxWb843ChtldtAdFwEK1L6XOvAl
         pooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ef1wV+xe16ZERGv66DB0vU4m8peeHBbl5c96QJCfNRE=;
        b=oODKloqXIbRG2I+2qkraR25t2fFUjHk5WK2PAv4FDg4hG7wa2FYnWcXgi1LSEYcTIC
         juA0CYPqchEhYQaB3J9CHQSYa6ESFLjLoHkmd1w8c8SpImaNKStIAOifeoB+FGIeuhjW
         Sbrq065XAS1XQjv53Ob5i4FLnPSYvFUJKQrWHrWVo1PqrBqEc5/tmI5T2/+VtGRPF+hG
         Cw8t6wdx25yXYdlymKMT6AfduFbeTjCY5fZUlLwymev7UsoRVSnOJCR934I4KSOK/oNo
         LpjY0Z2U9AI/k2yQXS9ep3IfXkgfICWrMKAXoRpjvXIBQNKTkwxwO64U86YneX0uyqXX
         m7MQ==
X-Gm-Message-State: AGi0PuYX+r8kVx+fj6+VkKXBenLb2llWGL+5w6KKCjtYFxSRFKYaL+7I
        LMv7485nDSMXlRnLvh4jlFcU2jACkq9Vj5EvFXA=
X-Google-Smtp-Source: APiQypIJU6h+l7mZ4AhC9ylCR4++6ih4+5CUS+svCtsq0Ga2WIKCI317Uy+vBIGanllF1GgIC9mxI3PJqvgF2/XVJR8=
X-Received: by 2002:a9d:3637:: with SMTP id w52mr5991228otb.177.1589046499543;
 Sat, 09 May 2020 10:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.606.git.1587412477.gitgitgadget@gmail.com>
 <eb0cbeeeed080596c130f657186894999ae6121b.1587412477.git.gitgitgadget@gmail.com>
 <CAP8UFD2b_27VeLFg3BrbacoJ5+GAxa+JrF3E2jS_dN-xyCRP_Q@mail.gmail.com> <xmqqmu6j4wlq.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqmu6j4wlq.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sat, 9 May 2020 23:18:08 +0530
Message-ID: <CA+CkUQ-5UObKvsZK1y0YPo4Aii0f4ELFnk8Fw6EN4A+TL3GbZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fetch-pack: remove fetch_if_missing=0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 7, 2020 at 8:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > It's ok to refer to a previous commit, but I think it would be better
> > if you could repeat a bit the reasons why removing the
> > fetch_if_missing global is a good idea, and not just rely on the
> > previous commit.
> >
> > "it is plausible" also doesn't make it very clear that it's what the
> > patch is actually doing.
>
> I had the same reaction.  You could even write a random gibberish in
> your patch and write "it's plausible this set of random changes made
> without understanding what is going on in the current code might
> have some chance to work" in your log message, and we would not even
> want to touch such a patch with 10-foot pole.
>
> The proposed log message above unfortunately makes this patch
> indistinguishable from such a trash, unless we follow the codepaths
> that are *not* touched by this patch and think about ramifications
> of the removal *ourselves*.  In other words, it does nothing to help
> the readers to support the change.
>

I understand it must be too hard for you to deal with such [trash]patches.
My apologies. Will improve in next revision

Thanks,
Hariom
