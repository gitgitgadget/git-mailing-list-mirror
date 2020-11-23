Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963E3C64E75
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 18:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D51120758
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 18:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du+kRRKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390592AbgKWR71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 12:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732624AbgKWR70 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 12:59:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF93DC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 09:59:26 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e7so1953554wrv.6
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 09:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4cPgQBj1WxGHTUMEYqzlhOIV23QiZS9VaAS+hapmdiY=;
        b=Du+kRRKtk372gUjQ/V2QuTWdO1Zldy+5P9jYgnZWo1N4bT5mhz32PmTPIWqLh3CvId
         UtMLAzkGhLhG3DYNq2/qX/qFOBZ3POLrDMRag6d9YCWeAu/qt/9dbTUoWeOpK2BH8KKY
         2SjOGF/GBqlPcIx2axlbBNVyNcFrxUMZvgZY/jv+ecBN6nmxsISHweKGPp8Xl8fL9ds9
         nqYpJzb2vsVmdi1TdNq39GLE1Py4vxsF2g2geCjshKcBos8Uil4e56fAmU2DS6Hw5H0j
         YmeVI+WPh9fynjvbU89EU4Rv/bvTrRxXd8ftMrmNwKeF02u3xnNZRpUmrgytRfyUvu4l
         yvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4cPgQBj1WxGHTUMEYqzlhOIV23QiZS9VaAS+hapmdiY=;
        b=WXwLxqN0bRjYHWylxilGzmt3kP1B8eht1YYMcBXe7S6i0PWxkmAdEhRJ3fQjhZb1uU
         y/4nqWWuvq61rnFZFFBdztY9Xsb2PecS1fI057AKTcerV9ZhWU4nMzThSFRVK20mkwsX
         2BmUd/TZNSnWv8zN9t0XSrrVCGoezCNmuzAVuE5K05YIYuLGX8CfWVrSN4gS7yUnVoPp
         QEKi4PNrBTdspO+yS+RnYutqgzmgKiygNxBsN2lNLvH83/TmNlsJz+qRR3tjkR+92NUj
         AtPJlO1IBcCNSH7iI9ZwOXzv6J7JxJQtCRDUQKpsfPiNJx5WeqpVZZd4k+I3/olp2RsG
         RdmA==
X-Gm-Message-State: AOAM5328oodfqFk0+heh4sXAwd5tOpPM3JtaBy5hMQUJKyhYw90PJ74M
        UoPF7r2SDsO8xJSBhKj5HatJ3vjmU/vFpJMvwLJruzPzTOM=
X-Google-Smtp-Source: ABdhPJzpY4aSEeQokcvvV0WhIF63CeAoZ7hw50WAGX18hoBIbaWxOfoWNpw/HGNuFWY9Mj4rHZXeI/9s8FUW+UTg75Y=
X-Received: by 2002:adf:ed02:: with SMTP id a2mr932842wro.81.1606154365374;
 Mon, 23 Nov 2020 09:59:25 -0800 (PST)
MIME-Version: 1.0
References: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
In-Reply-To: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 23 Nov 2020 10:59:13 -0700
Message-ID: <CAMMLpeRLsE=zNDjCRKmEMFxJBYcnTOdDGxEL9cZuVhuDMF=sLg@mail.gmail.com>
Subject: Re: Pick the right default and stop warn on `git pull`
To:     =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 8:14 AM V=C3=ADt Ondruch <vondruch@redhat.com> wrot=
e:
>
> Hi,
>
> While I understand that the merge after `git pull` is probably not the
> best strategy (as explained in [1]), asking people to change their
> configuration to choose their default strategy with every `git pull` is
> not any better. Please select any strategy considered more appropriate
> and stop warning me. I know I could change my configuration, but I'll
> change it just if I want to differ from defaults. I don't need to be
> told that I am using wrong default. I'd like to keep my trust in Git
> upstream, but this is was not trustworthy decision IMO.
>
> BTW, I was motivated to open this discussion by this [2] Fedora ticket.
>
>
> V=C3=ADt
>
>
>
> [1] https://github.com/git/git/commit/d18c950a69
>
> [2] https://bugzilla.redhat.com/show_bug.cgi?id=3D1900441

Hi Vit, as the message explains, you can use `git config --global
pull.rebase false` to permanently silence the warning for all of your
repositories. The idea is that in a future version of Git, users will
not be allowed to pull at all without specifying a reconciliation
strategy. This will prevent users (novices in particular) from
accidentally creating messes by merging branches that should have been
rebased instead.

Personally, I would rather have pull.rebase be true by default (and
I'm sure many others would like that too), but there are so many users
who really do want to merge that it's not reasonable to make rebasing
the default. The most reasonable solution is to ask the user to be
explicit about what they want and not make assumptions.

-Alex
