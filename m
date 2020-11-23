Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3950C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7EC20691
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZX0AXBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgKWXWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKWXWn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 18:22:43 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934F4C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 15:22:41 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id i17so19946904ljd.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 15:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FL4k8rWnqYula7M7+GyNYPG866OWWYWpvYyjvHifzJQ=;
        b=mZX0AXBUs2CDK/KNhFIJItAauZmN+uDK18CMtxmx0MtP4hUpEZ4lH4h51oyz+FYE1X
         vvV+mK0w67yiDHqVZU81ipzuPt0uJrYqZ1nR1VOzc5GZYwkOJAF5yVrNiBThug4x5RaG
         vFnu7113Q2mWdE2jMAvVDKoIG1x5NjTYF+RDkgThB1L9E4zZ7poP5aIHXbe1XUipE2Lc
         g+2L+Lr2Ry2AJbFfu3zslV8qoACClLUIxWTFmZAZsDzk/CArqgkLNjfKyGJs0t3h8VXr
         Ju/Z9jkwCxrIndf1UdI/6oXh7dRDnd9WMNEKaLertqijbpgOcd0QzW4xZQ2l9qKzq/gL
         PloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FL4k8rWnqYula7M7+GyNYPG866OWWYWpvYyjvHifzJQ=;
        b=q7pnXD52d+lvToEn1yXy19PDGMJqFJhJOhOVkJEnDE5S/cr5BgtETNmbM7xW1NvfLp
         HM+9+vYjFD6miXjSC4fFs7+cUkwvPb3OFakYCp7IE1rOzrjv9e9ur1SZoy/SXmcfr1Li
         kvNR+NOTo0/ir6/YwQ9G1X5sdFF0viHTHrtodplAE9BZ4ZihEN97GfV1KBMc334VuJ1X
         mmoDQAp6nHebiFo4XIitoq4oJqWZ1aNSe+/Lu0FWd1/HnCvEGhq6ztzl0FV/8vLOLPrF
         SpoFnrmFZxlKK0YMbvyH+xyMLzJvw2h5yEV+C/nAxGqbnl0UdiqCuWe3AqKOa2w/Hl3I
         ZUnQ==
X-Gm-Message-State: AOAM532UggVV5b//LD8WXBfoCMoVfoqqO0LLZpxodgMAlr/QEIQ/mhoC
        Oxuy9yJv+OPX6wIUVjLyS23yzJ2Wc1T9m+IQfRdrPadefe8ukg==
X-Google-Smtp-Source: ABdhPJwzqwIBXe48EcEWxiKhfwdaTjHLXNL5AL/82pAxb2DJ51HU28N0WnSG1vtE9+ikcVZu9XbPMHFYCN+GcAqKhRc=
X-Received: by 2002:a2e:9216:: with SMTP id k22mr653228ljg.138.1606173760075;
 Mon, 23 Nov 2020 15:22:40 -0800 (PST)
MIME-Version: 1.0
References: <20201123224621.2573159-1-felipe.contreras@gmail.com>
 <20201123224621.2573159-2-felipe.contreras@gmail.com> <CAMP44s2FRZUvUy+F3banxd9MEdL=RMqEdJL3JLYEGDQkOz3vNA@mail.gmail.com>
In-Reply-To: <CAMP44s2FRZUvUy+F3banxd9MEdL=RMqEdJL3JLYEGDQkOz3vNA@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 23 Nov 2020 16:22:28 -0700
Message-ID: <CAMMLpeR8_fshsaqSF6idOY-KyFw2+AK_5683a-7wDXhsO=iFVQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] pull: add ff-only option
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>,
        Andreas Krey <a.krey@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 3:46 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> This patch leaves everything in place to enable this new mode, but it
> only gets enabled if the user specifically configures it;
>
>   pull.rebase = ff-only.

Why not use the existing pull.ff=only option instead of adding a new one?

-Alex
