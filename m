Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691ADC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 19:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8A822268
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 19:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhkZW/2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgKBTlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBTlI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 14:41:08 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01637C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 11:41:08 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id c11so14011717iln.9
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 11:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4vI79PCYeHno4x9FIbk9m4zrmEPU4+KmyzdoSNMs5KU=;
        b=EhkZW/2gYHUiPXt97rD1zC7nj+UZYmkLn9t8s5UHEQ0oruuFOhTF+dWm+We6Je126m
         r6h+hwcg+zgXL9xlw0xy8p4jANvUMu71omxeBlWKbKLKtaXwPU2jNIQMkEWsBbbbXbef
         ZgJB27sMw8SJlb6wau2dcPsZJDt9g7vkUzRrVLSYCdIjSb50/fxTpJ3KAN6qcux/srnE
         kfRZLcQqU9FWne80IfPNgtmM+5YAIT5iT72tXt66Zt4LIWumicxyJkiUCHmYIHuKeXXv
         //QaO8NjojZL8Oz0AF1DOcmXnPIJAnhkB+M8EqYToawcFoTUwUHnpFI90C2+94uD35KF
         Pxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4vI79PCYeHno4x9FIbk9m4zrmEPU4+KmyzdoSNMs5KU=;
        b=poheCX2bYV3geBb+0ky5zeDkuyDbRzAhX3TRCa5wYF1WklyKln6XbLZ9rO72WmS8gf
         G8H0pkt5f9Ve7wfURDwig/wCYlwaRLpPn42qXWh+H5/Gx2G9TGMN/v45DchrJGJ4y8gI
         ljS8OpJYd7JLefMlcjxUQjaCEJg4WSuC3jvwNwczQYK4s2NnLjuMtjb0erG6CTjIVHuH
         J+6mIYmhLEDN9kzNiXq2GzWJtMwHdkEMI810oIr0Wl7pSnlc/8t+b5wIFcsO1gKy+LmI
         I+c5hOHMTTO0lp1XdQgfJ4xf0Jq5ElGJqAgMVeYY4j8RNEzFLwy3KXGQYsi7M4FHUzHI
         plyA==
X-Gm-Message-State: AOAM530Myk6EZ1ea5YstPirtX1v3r7ImtZ9CIoqfAExhmRr66omX8+6H
        9WxfGESGiKPO0QBwTDH+YRDusQ4jyAhn+yWbhJ0=
X-Google-Smtp-Source: ABdhPJxNRnFUeitV5yUcjaxZLoT44paUidkNWiiiMrOxDg01WQt14thUWf5fsZEnd2l1tO9weXGtOVXMEEPVX5+jBfo=
X-Received: by 2002:a05:6e02:4ad:: with SMTP id e13mr11015145ils.59.1604346067377;
 Mon, 02 Nov 2020 11:41:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.773.git.1603807337.gitgitgadget@gmail.com>
 <24f2c4a62317231f4eabed23bb24d345abc9d67e.1603807338.git.gitgitgadget@gmail.com>
 <xmqq7drbbcj5.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7drbbcj5.fsf@gitster.c.googlers.com>
From:   "herr.kaste" <herr.kaste@gmail.com>
Date:   Mon, 2 Nov 2020 20:40:42 +0100
Message-ID: <CAFzd1+7wzPZa9brWzWzSQdcMEnbEcV28zqBBAV_rsdsKNaKaFg@mail.gmail.com>
Subject: Re: [PATCH 1/4] rebase -i: stop overwriting ORIG_HEAD buffer
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Di., 27. Okt. 2020 um 22:10 Uhr schrieb Junio C Hamano <gitster@pobox.com>:
>
> My initial impression after seeing the recent report about ORIG_HEAD
> was "hmph, these days, rebasing is done on detached HEAD and the
> final step updates the target branch only once, so @{1} is much
> easier to use---perhaps it is time to deprecate use of ORIG_HEAD?".
> After all, ORIG_HEAD was invented way before we had reflog, and
> given that one of the goal of reflog was to give more general
> recovery mechanism than going back one-step like ORIG_HEAD allowed
> us to, and "rebase" were taught to work on detached HEAD to make
> @{1} more useful, it would not be too bad to eventually retire
> ORIG_HEAD in a distant future, I thought.

Phillip pointed out that ORIG_HEAD is actually not save *if* there is
a `reset` or `rebase --skip` during the rebase.  Otherwise, by design,
ORIG_HEAD would be easier to use, as in the form `<branch_name>@{<n>}`
two things have to be decided and can go wrong.

Wouldn't it be better for the mid-term run to set ORIG_HEAD at the end
of the rebase operation, basically during cleanup, and make the commitment
that it always points to the right thing for undoing the recent rebase
or to compare it (`git diff ORIG_HEAD`) to see possible unwanted merge
resolutions.

I say mid-term because a `git rebase --undo` with additional safety checks
and a `--autostash` for example is IMO the better long-run UX, in a very
distant future.

>
> But it is a good initiative anyway to make ORIG_HEAD again work as
> documented.  Thanks for working on it.
>

Regards
Caspar Duregger
