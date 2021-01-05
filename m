Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3980C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 15:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E3522B51
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 15:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbhAEPZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 10:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAEPZk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 10:25:40 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCD6C061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 07:24:59 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id x16so158321ejj.7
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 07:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=cinvmuKBagPTLC/Af2WSy1fXkj79MJLUlgaH04kfhyk=;
        b=hgigWVEEyzVbD053J3+xbluTsDaIfBCau2knxOfS/xnrXnEsUCW12iy950MxfwsBKp
         6CafAw+04eEc5rsoSxzUTq9p6KpcmjVtpPu5Vh0sUrcZWVLLfEmikL3i3W+wBeOyWMxH
         dvvpzpw+1JPtLb5tt+5Q+FFCDMH3nS+xXZKDGrCHUDwm+hRSyO3xHg9BogAny1HYmaT4
         hxvjSF5In1zlQm/M7F8KxfcL658oERI/QqI1ze/4UJWr8mmxBe2r4Ko7wpr30shbZywn
         aVJGeiKn7p4+JWyYb3FlrSC8WmBJrhWk+OLlk7rLYZo1MjfdkMbjvZ2P0PSKWCls7PKZ
         uIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=cinvmuKBagPTLC/Af2WSy1fXkj79MJLUlgaH04kfhyk=;
        b=qhQJqLxXpbdME54XV/RrDjLcsQrOhtlHzOMjP0BXVGMRRrub/Pw3ELm6SlBbp5QZFE
         uxyAkE1CX47QjPWEUnWJUa5li7UHZ9Y0l+VylO9+frz8XIjKKWsEQge8gVJKyMCoUqFB
         72fKjD5bpfTOns2rskVe79tzHeUdh0Vw5xiVpNTaKemGpP61JF7cZ2SpBbXluPygMXpn
         qVLi7Aa9K3/Zd/Y1UksjBd/A/0EOho9BR1Bp7GyURq8OxEIP7zfvTBf9tyyOpMjrmCI1
         UdTm9yCwviQ0NtXZ3NwR5YKL5IztjvsHHgCnS4QZkSJ5WV8HEMS/fPg2433PA3fqan9x
         fYMQ==
X-Gm-Message-State: AOAM531+s7kA+S1NCjRamEys/dRplj+sJFxVPLIY+C7JmwB+MJjBXjjz
        VVbh/1Kvxzf9c09oevseOj0=
X-Google-Smtp-Source: ABdhPJzLBV+MsP2GgaNoFTYyjF4GhXIrFRp7/YrVaVuNOp86S5Dp3lnbmlJXZnD2igI0Xa4SH/elbQ==
X-Received: by 2002:a17:907:101c:: with SMTP id ox28mr66983045ejb.201.1609860297312;
        Tue, 05 Jan 2021 07:24:57 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id ef11sm689ejb.15.2021.01.05.07.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 07:24:56 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Utku <ugultopu@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: How to get the branch HEAD points to using a plumbing command?
References: <132D030A-AAD3-4EFC-9858-7EA39503A746@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <132D030A-AAD3-4EFC-9858-7EA39503A746@gmail.com>
Date:   Tue, 05 Jan 2021 16:24:56 +0100
Message-ID: <8735zfs8xj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 05 2021, Utku wrote:

> If HEAD points to a branch, then `cat .git/HEAD` returns (at least on my Git version):
>
>     ref: refs/heads/2.x
>
> So, to understand which branch HEAD points to, I can:
>
> - Read file contents of `.git/HEAD`.
> - Try to match the contents with the regular expression `^ref: refs\/heads\/(.*)$`. If the capturing group is not empty, then HEAD points to the branch indicated by the capturing group. Otherwise, HEAD does not point to a branch.
>
> To do this using only plumbing commands, I came up with:
>
> - Run `git show-ref --head --heads`.
> - Parse the output first by newlines, then by spaces and test if the commit hash of HEAD is present in other lines. If it is, then extract the branch name and return it. If not, return empty string.
>
> My question is, is there a "better" (more idiomatic, less "expensive", etc.) way of doing it using only one plumbing command? This solution is OK but it is more work than just matching one line with a regular expression. The reason I want to do this using only plumbing commands is because I think that plumbing command interface would be more stable than the format (organization, structure) of files under the `.git/` directory across Git versions. Please correct me if I'm wrong in this idea as well.

You'll want to use git-rev-parse for this, e.g.:

    $ git rev-parse --symbolic-full-name HEAD
    refs/heads/master
