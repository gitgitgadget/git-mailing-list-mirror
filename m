Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63975C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 03:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiAMD3L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 22:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiAMD3K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 22:29:10 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929E8C061751
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:29:10 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id i5so8636666uaq.10
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZPLfeReuMuY5x69VVeFiK0UgQedoOGS0OEOcvIghP8=;
        b=dTQLyFmNmBZ79+cmMDtd5BLSRa1vgkLFCw0OnrpF4fPcVpWWQkT+llK7y0nuSVEUZf
         JQGFhxn3O6/vNh3ILtQalr+6LrwIxuF+qnww48SXxiAfgn99LwuxNIOZxxpVTC6zYbyt
         7Wc9BYUpaJI8xTCzGDuXkTC2/jP7d9Fj59K7HC83HRhl65AesSI+2lS9PCGtKorebARO
         XPuFAqc15E1DO6i4FJevs5ekGCaJq5xGr2sWDqvrG22phKjXwLxb/WbVfxZHEwxfh+ZI
         B1LoY+xeJlNU+L7CT1LTasN+i8dZ+YUvTFI+Gf5UOtLWZhBxsCI+a/9XIEN9XgfJSlRS
         l2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZPLfeReuMuY5x69VVeFiK0UgQedoOGS0OEOcvIghP8=;
        b=QEu6YQrIhI0KXOpbtXUu0bklNi+/Tpg4q5LM+QxozSeibMHFVqrbF5sJmZCplOLXGH
         CBOTDDPxmfoQ9WPdgr3G8eD+hxa4amZyxjlZBtrUQv1GU1dV9NQXsUycb5bB7VuaMc7x
         aRLZ0MTJDen+qixC/Gnib1JXlowg5OAvodciyWH0fDQG7tM923S6kV0ZGloFVtfieAWe
         yOELw9EgZl34Y1u4nl9+c1kLKw1aFEa7COWWcqn+aLUAWsJdcFBcgAyiQghGKIk9U8+w
         WZjWltMLpm2qLcOOfFCkVl3O5Uc+W6JklfPA5kLPkQa8fT/33nRuuButSbfAaeqjWlBC
         WBCA==
X-Gm-Message-State: AOAM530cPelii9ZkssE2c8q9I/j9hZL4evm/UHIj/PjFYoGZ9krUaJjo
        GR0Su5XqxsVEwnbGhZ9CTQZMOoqt1n1HfJxyI8k=
X-Google-Smtp-Source: ABdhPJxNQEjCUXi9gfawtnFRyQY1cWq8esziVf7BJKOmLLYYtZJYkPwOCEACPmsFpoob1dlClKdECErEboKhH4/rKBI=
X-Received: by 2002:ab0:43e3:: with SMTP id l90mr1500680ual.6.1642044549736;
 Wed, 12 Jan 2022 19:29:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641440700.git.dyroneteng@gmail.com> <8dafb2b3779715aa277eb825a94af87b72f3e093.1641440700.git.dyroneteng@gmail.com>
 <220110.86ilurzcxo.gmgdl@evledraar.gmail.com> <Yd2zXOrf+4qX8VLD@nand.local>
In-Reply-To: <Yd2zXOrf+4qX8VLD@nand.local>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Thu, 13 Jan 2022 11:28:58 +0800
Message-ID: <CADMgQST=4mmJSMYVY5i_ka_ONMDFCEYnrA3tNvoHE+L3VT83PA@mail.gmail.com>
Subject: Re: [PATCH v9 9/9] cocci: allow padding with `strbuf_addf()`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, tenglong.tl@alibaba-inc.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 12:42 AM Taylor Blau <me@ttaylorr.com> wrote:

>
> I find it helpful to have an alias like:
>
>     $ git config alias.ll
>     !git always --no-pager log -1 --pretty='tformat:%h (%s, %ad)' --date=short
>
> in my $HOME/.gitconfig so that I can easily format commits in the
> standard way.
>
> I think that this alias came from Peff, but I can't remember.

Wow. That's cool and efficient.

Thanks.
