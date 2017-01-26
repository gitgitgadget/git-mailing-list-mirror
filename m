Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 178A01F437
	for <e@80x24.org>; Thu, 26 Jan 2017 09:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbdAZJ2u (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 04:28:50 -0500
Received: from mail-ot0-f176.google.com ([74.125.82.176]:35717 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbdAZJ2s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 04:28:48 -0500
Received: by mail-ot0-f176.google.com with SMTP id 65so171062399otq.2
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 01:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iDpXrdnLsq1K1cJ6Tq6k1eVBufOzw2yDleDJQT5Bia4=;
        b=T+/XJ1w6uHliRmD1AlRG1XwR9T/0/ky5Ol8b1vxGAkWM/Hb2VrjtivAC5KCyxxSJ9O
         ph97gfr7fakpThkEWvmQTMW1nzuHkYXeLO9wvEI8+Lf7y+bns6LkKbU5MNshkRmwSyq4
         nyxgOnAgrJiu6FM5/DSZGwIxpWeGdMDdvsoXdsoG8eLwu4iL5kDWIFzs3jAldMeNE/W1
         iauMQEmQSdrdCVeDlS6gybbPyo41QA7rkw+LsvpFfv3GWz0MdNeEXcnaUovP6JpMvjWn
         Dq3hEkoEzq9jFfeIbVpXgkFWewvtUeLUyzaioWHyXavvd4he26BGIoq70htyTlb6+9F2
         6PeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iDpXrdnLsq1K1cJ6Tq6k1eVBufOzw2yDleDJQT5Bia4=;
        b=YFz5XRMYzFJPyS3F62JEFm1AK+h5cL0AvUQGb678KCdFoT1mVii4No7W5ITYzvK/uU
         NXPGaLI/kk1q8qz+c1IW/aO1VwF1elBdfEmEguu5GKqWHdDtfeIUlk4oIiI5nmiL8BnB
         ccicYlvTiqfcK97VjZ0t0oRsqxELHyoE9qG7ikRRclh33q0UBw86dnvNGA25lQN+8zef
         uG+kSDL0XhGV0U9/UziO7I8noezj07ckLrStKC5Rvsoc9y/Rsd1KtvR0qrue3eo9oPZU
         9t75brgZyd9iWAL8rZ+EElvoO6Q+rABkiuPzNoLZ8ByIt/gqlQK4L1DUNca7JCF1zH+2
         JdzA==
X-Gm-Message-State: AIkVDXJH4rzjYy8H3ppCD7dpocmXRieUczBc9073Z+IU3gBWcJQLniN7gl4/Z0krwW6ZAnRHGwSwOapsVdTV6A==
X-Received: by 10.157.37.54 with SMTP id k51mr783320otb.271.1485422927636;
 Thu, 26 Jan 2017 01:28:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Thu, 26 Jan 2017 01:28:17 -0800 (PST)
In-Reply-To: <20170125205718.ksqstdnazmgbkehy@sigill.intra.peff.net>
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
 <20170125125054.7422-1-pclouds@gmail.com> <20170125125054.7422-5-pclouds@gmail.com>
 <20170125205718.ksqstdnazmgbkehy@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 26 Jan 2017 16:28:17 +0700
Message-ID: <CACsJy8ATM_kc5SPY0dqprUefRy3vtpKW-4QEyJFK54jw0QgeJA@mail.gmail.com>
Subject: Re: [PATCH 4/5] revision.c: refactor ref selection handler after --exclude
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2017 at 3:57 AM, Jeff King <peff@peff.net> wrote:
> I don't think it means either. It means to include remotes in the
> selected revisions, but excluding the entries mentioned by --exclude.
>
> IOW:
>
>   --exclude=foo --remotes
>         include all remotes except refs/remotes/foo
>
>   --exclude=foo --unrelated --remotes
>         same
>
>   --exclude=foo --decorate-reflog --remotes
>         decorate reflogs of all remotes except "foo". Do _not_ use them
>         as traversal tips.
>
>   --decorate-reflog --exclude=foo --remotes
>         same
>
> IOW, the ref-selector options build up until a group option is given,
> which acts on the built-up options (over that group) and then resets the
> built-up options. Doing "--unrelated" as above is orthogonal (though I
> think in practice nobody would do that, because it's hard to read).

This is because it makes sense to combine --exclude and
--decorate-reflog. But what about a new --something that conflicts
with either --exclude or --decorate-reflog? Should we simply catch
such combinations and error out (which may be a bit more complicated
than this patch, or maybe not)?
-- 
Duy
