Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F542C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 03:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FCD823440
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 03:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgLJD0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 22:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbgLJD0G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 22:26:06 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12773C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 19:25:26 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r3so3941673wrt.2
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 19:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jfs+UfolIU6rpbNVQkaZ+E3fTj8IDAIa/U1NDCRWS8=;
        b=ghFEV4W7Moj6cOojNWz4ctJV/IkoYRKkbfonbqfs670mxAHV4hzPiBtv1CnLUR/XWf
         tZEuphsfjH1X4/nlyVdw05N5Se0DpNFexLEgS5fBoqnA5Xp5ePreEUOA3hiMeqnr50TR
         ohr8htQZezryetvMkT4tHqiOu70zDcBHXZT8A6M7MwbcrweCm3GuJybWQiIHdV6tnLb7
         WMO9flCCSI+TE/Afg+WaHEt6pXIXe8eWtOzi5xgwmh9iIplHlElVfTZVyco4nU5XRiP8
         KHIE481jVaNpPEinzLjERRKR06eXyRA3XSWcKCKmDHQIMc2CYH7lhIBBWI5S6xczk0v7
         bt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jfs+UfolIU6rpbNVQkaZ+E3fTj8IDAIa/U1NDCRWS8=;
        b=ewI9zrR5IShqttpk8F5ygXm1MJAJgDSJLdA/5rCyZzZkLWhvaPnAYVs0GjIpm4JRYg
         NUbruqdkZBpESGILXzkNOC9BeMKG6u7vnSgmoiQCuYsC1VAcpG6gbYMaaKeItBJx7SJO
         apLZGUu/A3qvn61gC6vQlRYHfFNBGJSgROMThwEIK3/NxNDAdGDyAOs6rLt2XM89zyso
         XJfIT43rq7YdtbUDdT49udriJoO7kHIzNa/SSOvCQM6Zgqh4xbYFj3HoOqNND/IzyUOt
         vc2ySzse2fy8wgi6J8AjalCB0+ol6RsrhIzu/2g70xuPOJtaegrbEKtjMFt8CzG91uTt
         tL3A==
X-Gm-Message-State: AOAM532aX9CivtOpa77E/1L621tOm/aHfjH+/+suHFPXD2YzCfiVd5t2
        vGOoF2iFQFSknLHvZD+MYSZfhJQY67/vHwLZmURVHINaJcs=
X-Google-Smtp-Source: ABdhPJxoUBOVm7ZEtEJVIB6t14kG1SDZTC2w6foAanf4dSjehndcHG+vAM9XewEk00g7B0Pla7AHqFG+Yi2eFP9KAqs=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr5764605wrv.255.1607570724874;
 Wed, 09 Dec 2020 19:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20201209065537.48802-1-felipe.contreras@gmail.com> <X9EFVIlm8sYKtLwr@coredump.intra.peff.net>
In-Reply-To: <X9EFVIlm8sYKtLwr@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 9 Dec 2020 21:25:14 -0600
Message-ID: <CAMP44s24shbskATDCyffE4HC9vP6fnxQcWc-SBHLZQ2DEXaiwg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] vim: configuration and sharness syntax
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 11:11 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Dec 09, 2020 at 12:55:35AM -0600, Felipe Contreras wrote:
>
> > After investigating alternatives for exrc I found too many, doing a wide
> > range of irrelevant stuff, many unmaintained, others requiring multiple
> > dependencies, and some loaded the configuration too late.
>
> I'm not opposed to this solution, but I probably wouldn't use it myself.
> I wonder if it would be sufficient to just say "here are some sensible
> vim options", coupled with human-readable instructions for how to
> integrate them into your .vimrc, along with some path-selection.
>
> It's perhaps not quite as turnkey. On the other hand, it's easy for
> people who are even moderate vim users to understand what each line
> does. In the plugin solution, there are more lines dedicated to loading
> the config than there are actual config lines.

If they only code for Git, it's straightforward to tell them how to
configure vim.

But if the user contributes to two projects with two different
code-styles it gets to get tricky to tell them what to do. And when
you get to three, my bet is that the vast majority of people wouldn't
know what's the best solution for the user.

This is the most non-intrusive solution.

Cheers.

-- 
Felipe Contreras
