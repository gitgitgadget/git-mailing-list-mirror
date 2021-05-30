Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8249FC4708F
	for <git@archiver.kernel.org>; Sun, 30 May 2021 03:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A85161107
	for <git@archiver.kernel.org>; Sun, 30 May 2021 03:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhE3DOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 May 2021 23:14:18 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:46051 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhE3DN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 May 2021 23:13:56 -0400
Received: by mail-ed1-f54.google.com with SMTP id a25so9405136edr.12
        for <git@vger.kernel.org>; Sat, 29 May 2021 20:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfDfAs1nZlUbKsRHvgeC+05QNSlzqDw65Q1LWLcBPcY=;
        b=gdCPYEcXfwm2IZGHkxCNDODdP+iVUfpmUC9a+T8BpMX2ygWMWO7ODhOaFUQln0sFbQ
         JpagNzDI7Zt6PbgKNEmWxyCrZtyNrfeiBDF7oqNPPY3vqiE4BhwMCXA8sPw6PhTkFipI
         dEp+QtqUOxVBVyx5VYplcVo9nymbLbDG8H5SpFDkwnl+k5/s5K84p/6c102ZZhg4r4R3
         5o6p7ZHuQQcsHA3FlBpKT9n9aWysa10JTN8p2pA+vtztl2cXhHf8TUSK6brFWPQGvIh5
         AkkQyEovk5qFMoWYpf2Flp7Whw+pWWq+cJ3u/4KexM/xzaGN/r/U/K6FspeWBuDZBA3q
         POaw==
X-Gm-Message-State: AOAM533ZnjyuhVRbcqJwaV46gXehGaNrNy+YK4op+yXZ2hyuD1g1F7eO
        OZYE+NtT9iiriVElJrXf5dk9FVmx0+LqC4hnTlA=
X-Google-Smtp-Source: ABdhPJwDofY6vrxWQCaJqqxkZVZLGJRhu33ejJeCXB0OOp+NX9+vPFoRQhQYJxOTSL4qf7kx+DkwtmoALLUBNDfa0ng=
X-Received: by 2002:aa7:d3c8:: with SMTP id o8mr18275865edr.181.1622344337468;
 Sat, 29 May 2021 20:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210530024928.24158-1-davvid@gmail.com>
In-Reply-To: <20210530024928.24158-1-davvid@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 29 May 2021 23:12:06 -0400
Message-ID: <CAPig+cTOFySGeUKM2oa9nHmkGVaWUbq8ghcid0hHxxSbV6jAjg@mail.gmail.com>
Subject: Re: [PATCH] contrib/completion: fix remote completion for "git push/remote"
To:     David Aguilar <davvid@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 29, 2021 at 10:49 PM David Aguilar <davvid@gmail.com> wrote:
> If __git_cmd_idx is empty then zsh will silelntly fail to
> complete remotes when doing "git push <tab>".

s/silelntly/silently/

> Ensure that __git_cmd_idx is non-empty before using it in
> __git_complete_remote_or_refspec.
>
> This was tested on zsh 5.7.1 (x86_64-apple-darwin19.0).
> Other versions of zsh, eg. zsh 5.0.2 (x86_64-redhat-linux-gnu),
> do not exhibit this behavior.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
