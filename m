Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7092CD6E7C
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 14:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjJKOtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 10:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbjJKOtL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 10:49:11 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88340C9
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 07:49:09 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c1807f3400so12751301fa.1
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 07:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697035748; x=1697640548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neGYL/5Z0rbea5USmWGlDIzzCHToZ6LzbXKUf4Ier2Q=;
        b=VgDz5VvWdYdvg3LEcCdbyK1N5QZ5tti5GpWpFhDy0e1T9QzKTg1WPVAATD9/BLtPuf
         WjHCaHwGPCQcZ48VYW+wJL9dflygKSrugfm+iIMhIj6PsZ8fh8Ucd4q23slpfR65P2XV
         M5kAnPZLhNek4bsRfpkzhP75Y+uojqaiy2jKHr4tVGruXxuAnicLYA3VWKsTtWNXBweT
         0yMhux0a5hdHM6EuL2OquWNe8bmcAAXN8nlqUEBCeX3RTpnAB50wT2gWdcVeQNSjyvdc
         mfTJrMW2u8cc3TB3LNjeJ/6LFUFmnDFpcd6qfa2kmggCo8PnDbzxMyZLg3h/qkYUAzpy
         NEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697035748; x=1697640548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neGYL/5Z0rbea5USmWGlDIzzCHToZ6LzbXKUf4Ier2Q=;
        b=RStC9cwWCrY1m++h6poeiWzbpjDlnxedySmOPEcjH7FkMeXi/MU/L9mzYLRcEOSxiT
         8QFnXO1JEw/TH95lNm9302yUi6rguUBhTRNbast47bxzS+CDiquybdDoGTom0L84ObIu
         WRzxXGalUQIRm45N2yIoH+dVsNNUVQSNz1ss1lmeolG05AaoXwmvSRBQDZKbPkH6gzvQ
         9jhlv/VEOtV0D0REKI4FLkDuNZRQRavv5fxBxgMchp1qRO53TRIAsuruQrIhXqxsKhAe
         2+rv6NI8V8K75UT/ydcncjAOTwqP/hHZXrnfistXlKMSLAhmqa9ebYTFD1lKFN+TDsvA
         XAJw==
X-Gm-Message-State: AOJu0YylDkEu8S2awyx0HRL53lGyqUeT+OSj/+NjG/frCSb6IJVO1dKe
        zUGlbcQLJ1MJGUoyxTcdhHOtpTZyPIwL5kl/V3A/+NiXYTY=
X-Google-Smtp-Source: AGHT+IH/0iLM0ZntXiBdeRosTHzn2Lrd+9dTw2ekmquo09L5EW7IQrJoXKpdmhhDYr8F3ztb8d0R6PRtzH7AC3qhXpQ=
X-Received: by 2002:a2e:8889:0:b0:2bf:af0c:f695 with SMTP id
 k9-20020a2e8889000000b002bfaf0cf695mr12953396lji.22.1697035747526; Wed, 11
 Oct 2023 07:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <CANhBNnvUx=KG2RkkJEamr2KHerXoDrvW2qe5zKq_xiV1t9V92g@mail.gmail.com>
 <CACS=G2w+_o_85DBrv2vpR6Ym8R7XeijJDbaB1y8a5xkNztyoRA@mail.gmail.com>
In-Reply-To: <CACS=G2w+_o_85DBrv2vpR6Ym8R7XeijJDbaB1y8a5xkNztyoRA@mail.gmail.com>
From:   Doreen Wanyama <doreenwanyama20@gmail.com>
Date:   Wed, 11 Oct 2023 17:48:55 +0300
Message-ID: <CANhBNnvn1LYGJ8c=GW1PUmKRNHvTjjib8TyuOamKryKKLjbeXA@mail.gmail.com>
Subject: Re: [Outreachy] Introduction and Interest in Contributing to the Git Community
To:     Naomi Ibe <naomi.ibeh69@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for this. Let me check them out


On Wed, Oct 11, 2023 at 9:07=E2=80=AFAM Naomi Ibe <naomi.ibeh69@gmail.com> =
wrote:
>
> Good morning, I followed this link
> https://github.com/gitgitgadget/git/issues?q=3Dis%3Aissue+is%3Aopen+label=
%3A%22good+first+issue%22
> We're not expected to pick something too tasking like working on heavy
> code fixes, just pick a project you know you can round up and
> contribute to. A project that doesn't involve plenty of major code
> manipulations. For task submission, you'd need to learn how to
> navigate "git format-patch" and "git send-email" commands(If you read
> up on these two and their applications and you should be fine), or how
> to use GitGitGadget pull requests to send code patches directly to
> this mailing list (https://github.com/gitgitgadget/git)
>
> On Mon, Oct 9, 2023 at 7:32=E2=80=AFPM Doreen Wanyama <doreenwanyama20@gm=
ail.com> wrote:
> >
> > Dear Git community,
> >
> > I hope you are all doing well. I am writing to show my interest in
> > working in the project titled move existing tests to a unit testing
> > framework. This is because I have always been intrigued by the work
> > the git community does and hence I am interested in being part of
> > this. I have gone through the links provided about getting started on
> > this. I spent yesterday evening and a better part of today trying to
> > understand the resources. As of now I would like to start working on a
> > microproject since I understand this is the first step. I am finding
> > it difficult though to start. Someone to please help me understand how
> > I should go about this or how I should go about finding my first
> > microproject. Just a brief explanation will help.
> > Thank you in advance.
> >
> > Best regards,
> >
> > Doreen Wanyama
