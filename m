Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF0CC07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 13:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE3261459
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 13:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhGHNyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 09:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhGHNyS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 09:54:18 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0D3C061574
        for <git@vger.kernel.org>; Thu,  8 Jul 2021 06:51:35 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v7so6038257pgl.2
        for <git@vger.kernel.org>; Thu, 08 Jul 2021 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YtSibhdusfXpJanO87FJS1cPkJ4YUOFW6hpxrAK1oKg=;
        b=iwoJozPoD/g+2g6R7Jy69Ht3EzAMwCraOPWrmDPZ6JfMK2mZpsWEJi2Ryn6nJ3mN5n
         hjmzwujk8o7YAF9KbxGtLJHUe3Ruozl9dQKHfJpBdtFrjnP/BNqPd0Kxk40zcYZmOOew
         AGBEAT+jjY6FVh91Grv14LaaDMKP1CkZsuJxDbvkJ3QGwWOKyGbZZpE1vAezDCDXx3jT
         /ktz82nYUB1ZMBjcX18v4cSFLI578gpnFDmawMO3jaNZOU0OXkAzq2qLdhSIeLgC8ujZ
         dAfVepBmJGJ6/Y3ymAmowkHYI9jHP7HIrUgDetRbr2vPZwazAYErCJPKm0F17U6SUzWp
         f92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YtSibhdusfXpJanO87FJS1cPkJ4YUOFW6hpxrAK1oKg=;
        b=bcj+iI6A8qJmIlZVHkUjRsZ55LwXd6hJpaLgHjOKE+0Gz0L34yG8Qx+ty8HRWN2++H
         Ss8atGH/rLSI8NZtXuCiwedsYC6PqduN0tuqh/YG9kwCzf3bOJGRdVa6HMC+uus1lW36
         6+Xd6ETufS5X9au6ATV8P0VMcpzMQW+Z4ntd7gf4rDKaa1LxxAIOzn0eUSHFvO5FkmgU
         NKZX/pnkHC4UIhOIAXCINSTQ2BVIjqCvj78tro8rJ+oDAGzBrHs98qvXmwS19dW/1LI4
         Eb9oe85GfSTCAmacJjgfqO8ZVR3VElEY2Oy9ei22xQXRvNOV4IldB8MPge6QkC6EQ05R
         gdjg==
X-Gm-Message-State: AOAM530F+e+UbjNPjgvu6m3kME9I+2vmcco7N/vhiC/lv8F5y7ibWMRP
        NM1xV5e1E0bv/dyIHP19zyvLv5p0lrNs14GiHrpfG/SS
X-Google-Smtp-Source: ABdhPJy0VB52e/cvK4M4m6lxPLqL5SW6+kFRqegnsdIGrrH4ik4QApTuUHyLX4INwQThKImCfTDPzBSO/tWjdsuOcVs=
X-Received: by 2002:a63:1c1f:: with SMTP id c31mr31785965pgc.380.1625752294821;
 Thu, 08 Jul 2021 06:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <CADrEZfE+LuDnhWkRHPMwHq7aGYcvDeqken8uZzPgHREtf0iqjA@mail.gmail.com>
 <xmqqczrugahy.fsf@gitster.g> <CADrEZfGHAi=Lr6QMsJbXGy1Rs9VDzTVxQPNH4xHHj6ataEAvVA@mail.gmail.com>
 <CADrEZfHJZT47nNZJ8v2T4vOJkMN7ccaai6DKdzFLF8Zoc42hWw@mail.gmail.com>
 <CADrEZfEVbtbovTbFM2BEuK_cWp4jcV3CZyrzasvsvFbuu1rmWg@mail.gmail.com> <YOWsNk4GqNUPyHD5@camp.crustytoothpaste.net>
In-Reply-To: <YOWsNk4GqNUPyHD5@camp.crustytoothpaste.net>
From:   Aaron Hall <aaronchallmba@gmail.com>
Date:   Thu, 8 Jul 2021 09:50:58 -0400
Message-ID: <CADrEZfEzCzB1wq5_FaqH-pSK6vqYXXF0LFbXZ8fPKX_Mfr3QBw@mail.gmail.com>
Subject: Re: Default ssh command
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Do you maybe have RequestTTY set in some SSH configuration file, like
> ~/.ssh/config?  You can also run "ssh -vvv HOSTNAME" to see if there are
> any config files.

That's it! Not sure why I put a wildcard RequestTTY force... I was probably
just going through the man page and putting down things that looked like
were what I wanted...

My urgency on this issue is gone. But unless git expects escape codes,
perhaps it still should set them to none.

> The problem is that on some systems "ssh" is something other than
> OpenSSH and we will likely break those systems.  That doesn't mean we
> can't do it if it's necessary, but it does mean that if this is a
> configuration issue, it would be better to fix the configuration if we
> can rather than potentially break systems needlessly.

I would expect it would be a compatible change but I don't have time
to research it.

> This problem will also occur for tools like rsync and various other
> programs which expect the standard behavior for the ssh binary, so
> making a change here in Git is also not the right place if we can avoid
> it.

To me, it's weird that an improperly configured tool breaks another
tool, and it seems that we could be more robust to that sort of
problem without breaking anyone, but as you say we would need to
verify we're not breaking anyone.

I suggest keeping this open as an issue, but that's up to you all.
