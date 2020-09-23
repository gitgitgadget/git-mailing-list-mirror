Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27819C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 18:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A347F235FD
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 18:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhe6OHz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgIWSdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 14:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWSdv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 14:33:51 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F496C0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 11:33:51 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d15so947467lfq.11
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5tAdvKfMVBJZFNEDsYKcZ+RmA4z1K/BQ6mAcwf5FUI=;
        b=lhe6OHz9uHkNxwa+6GKJ7SkNjyjNwnAKonnDm7yHFjh1AWaeupQgF4XqgsGBjgt7vo
         aHztV0GhYpvxBr6lW+waiBnhq/RA5gJ20RSqqBJFeXwizzhWyE9A/f4UvgWNzRFV/BIt
         ALNqYtdgiMcjwpf1KDHSf7mM8pRtogp+54w/fim84eAYwfSkAkEJqyQWEmVl1dPuroAg
         KjxY6L0CFr2vsc9Aq1ToCaQz4Al/0K1SJzWRwlvNtdIrvULfQ4OGuE0uf86w3xqzBC0b
         OCtpOLsHhHQSl1E47KKTOZ+ulf+FjT5D92KSASKNnOIf6ijQIWdBQjQ2FyVb9KTy/rzE
         1dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5tAdvKfMVBJZFNEDsYKcZ+RmA4z1K/BQ6mAcwf5FUI=;
        b=VngLViAIvfEARnbnnQ2lwJg0YLFmiGtBP4jkrZ76oGmAMxZeWFR/fdDA5sSb88+WOe
         HI7ExmrW2yonms3H4EGU4fwbHOj7bccsPTSP+qgGIEf/MkseqC+4VK6vKqEDO5GAJIpv
         7PEIeWa/fOfBrvSdtPcmamdBa4bsvZQmRaClFetQapeDvm61h3NdNe4Z/w2NnSzQqcJe
         0lKVEqiKFA7ckIwLTytyXfGJeiWA2n6OiMFcIhGi/v4ZIXZRiFjF4Zuji8F9Lte9UW6w
         uKQyEB9vAzmSnqcMCWLzAfK83L5/2JYCSf6pwdIkDGE40EgZgP1OdR3PiJKh2FBJj6gy
         xNDw==
X-Gm-Message-State: AOAM533L+X6w9tC03W1lIHYk7T5+r2Pd8uHH5LJoumdQNmpmBaketR22
        d0fcpmh4XqBeX6uYO2Lt2X5MWCNYQmfLOUCZNwFQQJW+QRE=
X-Google-Smtp-Source: ABdhPJzgKRjAaCh84LsbkyQ3CxxUGDH0AttFPO9J3PkUyBjQbyyiFoBBDSPVIRQx4gRWZqLPq6wLcryGc0U4r8VUeZc=
X-Received: by 2002:a19:a41a:: with SMTP id q26mr381699lfc.467.1600886029528;
 Wed, 23 Sep 2020 11:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <1093128c646b154a14d89321454f5361c0e616b4.1600854717.git.liu.denton@gmail.com>
 <CAMMLpeRD6hKuAHjHh2AXrx1PVXHx7m9haUPAR_uNHR=YuT5xbQ@mail.gmail.com>
In-Reply-To: <CAMMLpeRD6hKuAHjHh2AXrx1PVXHx7m9haUPAR_uNHR=YuT5xbQ@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 23 Sep 2020 12:33:38 -0600
Message-ID: <CAMMLpeR=g6gfjokxpmcj5kfnJxPO-ZLTUpa_QMT_oAcQQ6AR=Q@mail.gmail.com>
Subject: Re: [PATCH] pull: do not warn when opt_ff is explicitly specified
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 23, 2020 at 12:25 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> Hi Denton, thanks for working on this! We can also assume that the
> user knows what they are doing and does not need a warning if they
> have run `git config --global pull.ff no`. So really, we can just get
> rid of the check for strcmp(opt_ff, "--ff-only") altogether and
> instead only check !opt_ff. Could you do that and add some more tests
> to t5521-pull-options.sh?

Actually, never mind, I'll send the patch myself. When I originally
put in the warning I didn't stop to think that if the user is
proficient enough to set pull.ff to any value, they really don't need
a warning.

-Alex
