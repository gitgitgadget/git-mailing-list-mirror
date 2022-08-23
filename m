Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7E7C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 19:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiHWTIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 15:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiHWTI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 15:08:28 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAE7133641
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 10:47:00 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id d6so6142739ilg.4
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 10:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc;
        bh=zuXKxyOyV5ZaiVu6wHk4ppA/HPhM/rBJYnl1Mf237No=;
        b=gxbMgwWaaJ8uL+g+0OPK+es1xuaCC0GIIwtfmJ9m/edEoXWW7jvz38af9oh28rYk1Z
         r3X6ayJ9fPmcWqnQTi2vSuR3/9tllPTK7rgG/fVkuve3T2dj21ScnnvK+QIsOcVOxWQl
         wcZFiTfTnPiV96mKCl1yHEV3MGZSCPeo6oKdzL/QHwb8BeA0WZqJMyvzuGd+6wkfYpBC
         IkHlOv6KqFKnUI2ZeCD7n1dN/nBDBYU6YETVz0ua4IViXAOONm46uz9ESWvnipgQQAWw
         RuEmqYhWQ4etoZwQ+GGlKuC0Qd9hKW8Q0wl1Hew4PZ7q7J+MPJuv+A/MDwPF4Ic/4V2K
         diZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=zuXKxyOyV5ZaiVu6wHk4ppA/HPhM/rBJYnl1Mf237No=;
        b=HOaN/dLr2syruLHO9ifR1uAPi7uTLljZnozWcJg8ls04VzaRnVRwuG+ANtBhYCHYYB
         /JUsv5dHWahRhnqDAcdt/1bdUf4MizbSuC7svkBjqvDlIInJESTgdvoK/1u8SQ4KA73+
         jA/LReNibwb7S2z0wn+NkOxKB+JIXqvWrf+YiQoUcn8CtW2YWY/xeW5cMzg3b4j/INVa
         cSo0dIT7xjgLqRSdk2wKw0JizaBbg++hT2jYm684EQjwEWXljjOhtlHcf/7/z3cPb9k6
         3KKnyiSJ26FzLNGKw1iyT4IdeHfFcUm8iUSibudT+pTIyxwaEBJ0lvfIaRAr8icdTsk7
         sLRw==
X-Gm-Message-State: ACgBeo1J88CgGWhEi4fhxSdHOD860VjzGTMorWqmF31ZuW4iEKAX8dmV
        v9cASL529U0v1T+KFmdjKHpz7rC2mYEM0wpbDNLI
X-Google-Smtp-Source: AA6agR4VFWD8hFt3OaPVoWKxl58GbWq333XfwjGAz7+B3PtsWFLpZxhQSbyPVxpaE327pb6PBATbR8endDFzZ2E8I/g=
X-Received: by 2002:a92:ca4e:0:b0:2e9:67ff:8b29 with SMTP id
 q14-20020a92ca4e000000b002e967ff8b29mr357696ilo.294.1661276736835; Tue, 23
 Aug 2022 10:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAO_RewbD+BJd1hPKCmCNM8wYBSUmZ2TuOoy6t1up1CT-rbn4DA@mail.gmail.com>
 <xmqq8rniikrg.fsf@gitster.g> <CAO_RewZPXP1EUP90kU6uEQ3_CqqC7yWedjfNd7RaVASFSfrg0Q@mail.gmail.com>
 <xmqq4jy6igb2.fsf@gitster.g> <CAO_RewaZHL34WBaoXVyXh6ZNVuG+fi5uGUbpRMsc9N=orHzx1Q@mail.gmail.com>
 <xmqqzgfyh0vj.fsf@gitster.g> <YwQki4nAEOp4wvv9@tapette.crustytoothpaste.net>
In-Reply-To: <YwQki4nAEOp4wvv9@tapette.crustytoothpaste.net>
From:   Tim Hockin <thockin@google.com>
Date:   Tue, 23 Aug 2022 10:45:24 -0700
Message-ID: <CAO_RewZCjdGcC3fx7pPZEZ9iTk8_Xs7eBqaf8208da3fD=40mA@mail.gmail.com>
Subject: Re: rev-parse: -- is sometimes a flag and sometimes an arg?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Tim Hockin <thockin@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks!  That helps a lot.

On Mon, Aug 22, 2022 at 5:51 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2022-08-21 at 00:54:40, Junio C Hamano wrote:
> > Tim Hockin <thockin@google.com> writes:
> >
> > > Sorry, I assumed it was clear, but that was dumb of me.
> > >
> > > I have a string - might be a tag name, might be a branch name, might
> > > be a SHA (complete or partial).  I want to resolve that into a
> > > canonical SHA.
> >
> > "git rev-parse --verify string" would insist that 'string' is an
> > object name and show it as an object name to the standard output, or
> > gives an error message and exits with a non-zero status.
>
> Note that this will print a full hex object ID whether it exists in the
> repo or not if one is given (for example, the all-zeros object ID).  If
> you want to verify that the object exists, write this:
>
> git rev-parse --verify string^{object}
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
