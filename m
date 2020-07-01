Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EB6C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 10:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C21BE20722
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 10:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU1Z2Inv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgGAKJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbgGAKJW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 06:09:22 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098C4C061755
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 03:09:22 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id e64so19428870iof.12
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 03:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=2fiUUD61U7LVew7AJAErZHAeSnk1ODbbIsmDOr0QmQ4=;
        b=nU1Z2InvYtRWvVjmlFaJ+Gmefzc8ER1XhKNFv9+2MyjZ7btvJunmAlB7rlPms4lhay
         awssMjcdJzOt8uRDBPVpMKFzzevB9XKTWJSFn3mPvdS1V4WrpESeDCBnRq9Jgzp9H6ck
         Mj+j9HhX4ea42VP+bdOIeJUZ2u3CfJKqxcZxMUjUY0KYu+RkcbfYrEERG8GkEk5E8p6x
         k5AbFymT4hPSJGGlwLor1gHMQfepjhhJWFT4pmbqM1rBJWQLsDW4q9LZ0kjV1as+nlz4
         +Mbo5zvF49oMH8EAbCEMhaGB5rgGo+k+xD1dtarvHoMabRtNS++rNMVATUSu6Hk6YhX9
         X69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=2fiUUD61U7LVew7AJAErZHAeSnk1ODbbIsmDOr0QmQ4=;
        b=Ez5R8+iRGnOcjrMNTXonGY0Of/CyV/wOHajZt4BJO4oeciVkslmSmZUffLneMq2u2a
         J/H8uVTk6hni1oTJDIdK0QG/jh3kvZBQgw1XT91atbUS6Hh0SKoas7kFIYbBtD0Gcxos
         1ateCIjGpRrBYb+duz8YKF4b+iRapG80Wh3qcc8FRVFrWy132jp3YCZYbdjZ2n/Mvx2W
         xQRUz+0HmK9SXJSs6rNOIIiY9eJskFOSQsbzF7Du9v3UGBBRpn2w6YOrghhjbqVvL2ED
         8zNP7p3M76jTObLARX+mgCu1/aTAHoxs8A+Oe3KzPQB/a3Kzkvg6K/4MN8wtMS1lVrJC
         fuFw==
X-Gm-Message-State: AOAM530JoOKMUfBl+/q8dvvCIeIEa6efHyDY5F+C5TxZfX4b8XktTa6u
        3ZuPeVU1kzaLIMBX2jUWnvzEGoDoqGG2iGFGNXw9oQNa
X-Google-Smtp-Source: ABdhPJyjQJnkpCfGAN2qjdTPcmRibagPs8GsUOam+7W8OUWdQEBpjd/OC6N0wgcO/sMSJbzli/cT6s9MkF42LKafmmE=
X-Received: by 2002:a05:6602:2805:: with SMTP id d5mr1486997ioe.124.1593598161323;
 Wed, 01 Jul 2020 03:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8m1=0n8zzoW--g_XLebJFqFSXpBpTr+1S58z7snLTt-0Q@mail.gmail.com>
 <87tuyrd0ng.fsf@igel.home>
In-Reply-To: <87tuyrd0ng.fsf@igel.home>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 1 Jul 2020 06:09:10 -0400
Message-ID: <CAH8yC8kxY5mV0p-98W0uDN7PLxmNR4LkNcz9vbKsq21aTd-qQg@mail.gmail.com>
Subject: Re: Why won't git checkout a branch?
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 1, 2020 at 5:50 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Jul 01 2020, Jeffrey Walton wrote:
>
> > $ git checkout m4
>
> Try a newer git version:
>
> $ git checkout m4
> fatal: 'm4' could be both a local file and a tracking branch.
> Please use -- (and optionally --no-guess) to disambiguate

Ack, thanks.

This does not look normal, either. I don't want to create a new
branch. I want to work on the existing branch.

$ git checkout origin/m4
Note: checking out 'origin/m4'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new-branch-name>

HEAD is now at 5c3967f Merge branch 'm4' of
https://github.com/noloader/libb2 into m4

Jeff
