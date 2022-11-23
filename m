Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6970C4332F
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 11:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbiKWLyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 06:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbiKWLyt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 06:54:49 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DFB4E420
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 03:54:48 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id k5so15692913pjo.5
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 03:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzJwSdYaDzLlNhk6YQ/h/s5Zl3+Ivs11nC/xvO1tgcs=;
        b=XDYHeD4ZITBbzAxvAzI1CuHXhwGgUHyZ71zHSqd9WuiHdIFjis+6pqiL/OwmSnifgg
         CHr8G5irsxb1AYkbN7FWma/v1rXyuZCb/CG0gp5u3sEDxp7BURxkEXPLKzajKuPjvoAl
         JJu/KgxRva2Nd33KyBrkiSgv6AqqHSffQPa1wHJHK7QllR7muO87NWVlzyzNroCcNKSq
         bhU0Ukc0g2MUx5iRzXtBC2QbXy9XGgMoGeUFlzmXiFfY/cDzM4zthmQjO7AuEWXmCvm+
         VFE7/vdGhlqXikVk5E3jkXu7fTanpA5JGUSK1vta74R63wXKSdALhWxdwCA65hJN3yE3
         SeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzJwSdYaDzLlNhk6YQ/h/s5Zl3+Ivs11nC/xvO1tgcs=;
        b=KzOYzH5/o8mdxwKT9Ss3b4dNv9wIMY0KO+VqWHDKUhBCSH33sHW4l0kuTDIuXcMtts
         ILv7Spx3/epSLwDZ/xM1GuSVsge7Rwa1HqswtzohfICIyEAJdBfFb53LxxuC6amzFumM
         xFGqGmHfYTp2NNPpsSdeGTfaQ1zk86Qm0hZoliY3lA8uhMX+7OpIAnsYRfVYVxlFLtof
         gM3nL2I/WdeckRgSVvpkkNRNVabaSKiZoZC6ztT9qu1/tR5XNNF7CkGGpMk4nmWGX8eA
         /JaSPvHAuZSl1Lw198Vs8++BNvh9HAgUPnrVPqP6rJWKCrdLKnffLML39xFYGFm84BQv
         sHlg==
X-Gm-Message-State: ANoB5pnSyu1ppvIPBWoDVp7fF6cRWyXJIa8F2FAgth3xGMm6HM3icvcQ
        ONxF33o78gaYNIy4s6xQk+0=
X-Google-Smtp-Source: AA0mqf5c0gD8foysWIYLjWf5ngArAXghdaEJ44rxEN9MKBhLN7cK1D7txvDTIYtqfqnWV7MWYocH8g==
X-Received: by 2002:a17:902:d68b:b0:188:cca8:df29 with SMTP id v11-20020a170902d68b00b00188cca8df29mr14523566ply.148.1669204488103;
        Wed, 23 Nov 2022 03:54:48 -0800 (PST)
Received: from localhost ([2001:ee0:4f8b:a070:2a99:1bbd:b117:5037])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903231100b00178b77b7e71sm10671720plh.188.2022.11.23.03.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 03:54:47 -0800 (PST)
Date:   Wed, 23 Nov 2022 18:54:45 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
Message-ID: <Y34KBTx+gQB13GRv@danh.dev>
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
 <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
 <Y3wKe7aO7I7bpmLm@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3wKe7aO7I7bpmLm@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-21 18:32:11-0500, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 21, 2022 at 07:19:48PM +0000, Johannes Schindelin via GitGitGadget wrote:
> 
> > It is relatively common for users to maintain identical `~/.gitconfig`
> > files across all of their setups, using the `includeIf` construct
> > liberally to adjust the settings to the respective setup as needed.
> 
> This seems like a reasonable thing to have in general, but I wonder if
> you have an example of how people use this. Mostly I am wondering:
> 
>   - is it sometimes a misuse, where users _think_ that the OS is
>     correlated with some feature of Git.  And they would be better off
>     with some flag like "does the current platform support fsmonitor".

A possible use-case is setting credential.helper based on OS, let's say
libsecret on Linux, and osxkeychain on macOS. Of course, users can
have their own helper on specific OS.

> 
>   - for cases where it really  is "uname -s" the best differentiator? Or
>     would they commonly want to lump FreeBSD and Linux into the same
>     category, or to tell the difference between Debian versus Fedora?
> 
> -Peff

-- 
Danh
