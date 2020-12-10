Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBC7C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265BF23B98
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgLJAlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 19:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730230AbgLJAlh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 19:41:37 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FBCC0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 16:40:57 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l9so3662100wrt.13
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 16:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOhtjyGDeLQPGtXtkJYU2uLd3WpHp8U38q0JKbkH1xM=;
        b=Na6PPCcemgY5+tb3WoZYU8qeamy1eb54fLl8BhsjGvuHWUgp0sfonTSCWZ19cmPGzN
         HfmSCLGW1RNafZvV/wXPNCSxkl96lXyp1BQaeO0W5+mCulV0E592pKojC55IZ5GSbQoB
         pnF+QIgK6DeMG/6uuX47Bc3M9j/djO9lLDS2y8ZwRuhNh3Y0/EQed1LwjexmQMXH4+kV
         +lQmEVPs1dNjxHLXxZ+4bvNSfQbOIzsLs6V4D9tahZUH3l5astkW0JA8IcQaGE6NzAAg
         eM7SZkNd8WkJSQXozT4kgfkJZb6oIhN0dfdcKBIgsjxM1bOZSNkuoVZF18MrvrcId4Sq
         MYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOhtjyGDeLQPGtXtkJYU2uLd3WpHp8U38q0JKbkH1xM=;
        b=tBAlDIFmDjgVkvIsfU3EOjJ0El+y/2HV2T5u7SOx4BsA8SS9VOH4iSFMHmUv9NjqyM
         NfyY2c7iWWB7UAzVn9hHI/bY5w3VHYdpHGokoqbgWFhTlTghsD7qQxbP5KHwfuHuImP8
         0evKhU4YhH+yPkEutix/H6VfKOMoj858NpMOWiywXXAX0xIju0BMtiqEYWOgEOndWn7m
         rubH98hMhW2B9uZDmTxN2KkLcw3YzUfoTAQfNArz1O6TO490/z+cc5ISEw+736d6FV47
         s0nb0+QOtjhI7rs+kWOYVdGaRCtXD2vOe63wUS3n1uH5eq7/ct4xz0muQCv3iCaYLMcZ
         IZWw==
X-Gm-Message-State: AOAM5319tKj5Th71mu4FIyIwg/KuGlh9o87lxMF6IjcaGGysurQHv4iz
        9MarzdHVW7iCjT6ycrJ9jR/Ks5iGJKB73acehts=
X-Google-Smtp-Source: ABdhPJyoKiYUjbDcRksY3CvVh0eYPsYBHeDJEcghJxrt+o5y8XKvy3OwBLCDTvGHi30pvGQgyMBGc5M5U6IDgeZR2yA=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr5136533wrr.319.1607560855916;
 Wed, 09 Dec 2020 16:40:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
 <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com> <bccef953913da629057b3e9b211bc54081fa4475.1606173607.git.gitgitgadget@gmail.com>
 <xmqq8sarljfn.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2011240648160.56@tvgsbejvaqbjf.bet>
 <xmqq8saqjx2n.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2012091513540.25979@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2012091513540.25979@tvgsbejvaqbjf.bet>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 9 Dec 2020 18:40:45 -0600
Message-ID: <CAMP44s0H-bpmYF-iTy1n=kGgn9sGdofNLoG0-w_S9+9jU-259A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] init: provide useful advice about init.defaultBranch
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 5:24 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Tue, 24 Nov 2020, Junio C Hamano wrote:

> The distribution already can add patches, so this objection is a red
> herring. The sysadm can pick a different value for `init.defaultBranch`
> and dictate to the user silently what initial branch name to use, so that
> is also a red herring.

Yes, but if they do; they have picked the ball. The user would blame
them--and not Git--for any unexpected change in behavior.

Cheers.

-- 
Felipe Contreras
