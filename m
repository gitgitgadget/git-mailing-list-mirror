Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60752C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 18:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbiAJSCr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 13:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238706AbiAJSCq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 13:02:46 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA39C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:02:46 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m4so15393817edb.10
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=sTozB4Dkg33aUC817u9C+NmpEzKoJSHuLgjl3pb3CXw=;
        b=S0X4yRiRqDcYMl9WjDBKseD6hzfNZQShoPY1bJlHLvIXDx0KneATAgxcLV1ktSq2jY
         iaRpjtkLlSJsA1RM6TiDwylUG3rkrRTb8NKdB9Y7hN0QSCVSiORy1GerwLG4+tUNZY/X
         S9+5UtayReDWUDpi4bt+xFjFF6kToQps6r95ddh6W/Dp9IdMcgemjCz3L3/GrHhEKJZC
         GPJ9UBW/SsDdvQIU+fOHcK/PpP1vh5ixMZqrqikPYgGg6u2e2xRG+qsNPiL0mbEz/jm2
         7hx31IXs4PJt+jPUZd4S9yIEjCKHx3jevgbv1n45Rb9ZlOTmGK6Wv9JT+gvbRFAaYG1E
         EDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=sTozB4Dkg33aUC817u9C+NmpEzKoJSHuLgjl3pb3CXw=;
        b=VPi+hsQd33rR8uYzxtzEULD3mwucgQbiY71e/GD0JZFCWsmdywTPbjrEHO6WzHErJc
         w77bPIjw7keWTZ9UDW0ife00ue08ZukV99sMX/TaF9ZYUejzvESrYvXu3AdKD3U7vvFK
         +KmCsCi9fOnfMnG3d1VQtBvq+7hkKQo0Q5qterk6FV3OXW2t4g3aIu+1VqG6OpaVuRJO
         ct6uMujobf5olLJzTNnp/qcEngDuXlgmYObLofbGi+qB+LMZ6xHmapKBP547BBSOhXOq
         Qp3grQrASWeajTFyQAzCUknw3o8VVQlEgLoEI5mrH3qRwAQK7ZW39aYwACNqUMJZExUn
         MiAw==
X-Gm-Message-State: AOAM533AxT5ncQv9y3XK0KCQDE/KPxoJKg9AGMaj4q0dG/xGHBa1UEy3
        d9jkc2q15Jh2jxeLCVP0Bns=
X-Google-Smtp-Source: ABdhPJzfEzh0cvrrWHhIxeYWe5qS0iQSwgQsv587qDV/CxTxGBQIy9JTNXGj1hkt7nqClh4YDeQk1g==
X-Received: by 2002:a05:6402:26c1:: with SMTP id x1mr815551edd.188.1641837764748;
        Mon, 10 Jan 2022 10:02:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gn36sm1154288ejc.29.2022.01.10.10.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 10:02:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n6z0F-000O3a-5T;
        Mon, 10 Jan 2022 19:02:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     congdanhqx@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v9 9/9] cocci: allow padding with `strbuf_addf()`
Date:   Mon, 10 Jan 2022 19:00:59 +0100
References: <cover.1641440700.git.dyroneteng@gmail.com>
 <8dafb2b3779715aa277eb825a94af87b72f3e093.1641440700.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <8dafb2b3779715aa277eb825a94af87b72f3e093.1641440700.git.dyroneteng@gmail.com>
Message-ID: <220110.86ilurzcxo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 06 2022, Teng Long wrote:

> A convenient way to pad strings is to use something like
> `strbuf_addf(&buf, "%20s", "Hello, world!")`.
>
> However, the Coccinelle rule that forbids a format `"%s"` with a
> constant string argument cast too wide a net, and also forbade such
> padding.
>
> The original rule was introduced by commit:
>
>     https://github.com/git/git/commit/28c23cd4c3902449aff72cb9a4a703220be0d6ac

Let's refer to commits like this:

    28c23cd4c39 (strbuf.cocci: suggest strbuf_addbuf() to add one strbuf to an other, 2019-01-25)

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  contrib/coccinelle/strbuf.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/coccinelle/strbuf.cocci b/contrib/coccinelle/strbuf.cocci
> index d9ada69b43..2d6e0f58fc 100644
> --- a/contrib/coccinelle/strbuf.cocci
> +++ b/contrib/coccinelle/strbuf.cocci
> @@ -44,7 +44,7 @@ struct strbuf *SBP;
>  
>  @@
>  expression E1, E2;
> -format F =~ "s";
> +format F =~ "^s$";
>  @@
>  - strbuf_addf(E1, "%@F@", E2);
>  + strbuf_addstr(E1, E2);

That file currently has:

     18:format F =~ "s";
     26:format F =~ "s";
     47:format F =~ "s";

If we're fixing these let's fix the other logic errors as well.
