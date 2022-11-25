Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA777C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 16:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiKYQBa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 11:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKYQBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 11:01:25 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9781DF26
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 08:01:24 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so4547027pjb.0
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 08:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2U4SkLIhINik3SS5khPCONywgwcHP0YLI6vt39rLCes=;
        b=hs2yCEpMhdCwSQ1XIKA3ocPXk4A3pBD/VNni+2EnIhoJeODvdQcnr+BCJZFJJDQwv2
         sXRR3pvWHvoIq8eatIxekh6lGRF6/viVYxTI67OoFeppwNLFuKrO/OGyXrZu1DSsZ1+b
         5ocXRL5wWR4AF6eVfuFzkWSL0fhJ0MFInNVyGIuy3GuGLJP3i0OnLusmE84/emyNDM3q
         R6jAWC4HUwkJxt2paMmtdQUZOf//wdCFfVLmCCZu4oL4Olm2z/KxnoHsWUXv6Ps1+oBp
         XFWXnLYbAWsuBP4JgVN54OfGdcM6630clA78ptEpvS5XFseBYAdANFuwlYtdSgRrefjQ
         7QNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2U4SkLIhINik3SS5khPCONywgwcHP0YLI6vt39rLCes=;
        b=HDll1PqggTeG84bme35YfX0NST15qFZrp6O9+qS5lExCVWjQpv6Tvt8NQQVULa0giJ
         BRpZnsHJTzAQ/bPJ+X+DMg4zJ7wTYbD7pA42M7HEGVNXoV/9dLsO7Nrgszd+b0W2JiZR
         eP7lbYJYpWPN4N6iEYalx+ssZBLy4/iVG+vgC3IuzsCeHGNiDxPafHQeDsLCS0DEQx1Y
         FEiLVz0bOq3LyPta2hPhNI7P2zDz1T5uX/8+I6zrXhBuYV3hBTNdxyTc0c4NigKZFcn0
         gn7yDq9dvH/dI/MUl5d0EM7UwUFT9Bdcu9YzZldKTzEq4hIW8viPSWxNp7Bc2yquQ3dm
         H0DA==
X-Gm-Message-State: ANoB5pkACWi042iqZk6iTs2SqNXlUQtanLAuBpABYlMTNw/yJQKEgZEq
        l1LamIMdbgy6xqBj4Sgho7ug9RqVLCU18hwcz2k=
X-Google-Smtp-Source: AA0mqf6ltX0FiMgm2TmTHIY3WjNHCpPRbG9v2PluKGo/Y2hjRB5fob7Uy7exI5TSLZtWWi3g/8c57Pqw9lH/5SeiapI=
X-Received: by 2002:a17:90a:bd86:b0:213:8cf1:4d9d with SMTP id
 z6-20020a17090abd8600b002138cf14d9dmr41983513pjr.5.1669392084327; Fri, 25 Nov
 2022 08:01:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
 <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com> <d8233f9617563d7c7168afc6e1abfaba57e54038.1669347422.git.gitgitgadget@gmail.com>
 <221125.8635a7o123.gmgdl@evledraar.gmail.com>
In-Reply-To: <221125.8635a7o123.gmgdl@evledraar.gmail.com>
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Sat, 26 Nov 2022 01:01:12 +0900
Message-ID: <CAF5D8-uxZOFi8p0bUMaqJCLFxipXCB9fo_Kx=QE6s=DW8Jspgg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] git-jump: invoke emacs/emacsclient
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 25, 2022 at 6:08 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> I'd really like to have some closer and smarter emacs integration like
> this.
>
> But I don't see why we need to run the grep ourselves, pipe it to a
> temporary file, and then discover that we're using emacs, and --eval
> code into it to switch to that buffer, and fake up a "M-x grep" command
> with a compilation buffer to make it look like we ran M-x grep in the
> first place.
>
> Let's just ... run M-x grep earlier? Then we can skip all the earlier
> steps.

There are two reasons.

First, I want to reuse the modes that git-jump already have. In
addition to mode_grep,
mode_{diff,merge,ws} exist, and if we re-implement each for editor
support, I think it will be
difficult to maintain.

Second, there is a difficulty passing arbitrary arguments properly to
Emacs Lisp properly.
For example, your version will cause error with
        git jump grep "hello world"
My early patch was doing something similar. But the second problem was
hard to deal with,
so I switched to using a temporary file.
--=20
Yoichi NAKAYAMA
