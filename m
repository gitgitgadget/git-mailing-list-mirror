Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B36C433E0
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA2D206D8
	for <git@archiver.kernel.org>; Sat, 16 May 2020 11:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExWB9UXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgEPLS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 07:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbgEPLS0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 07:18:26 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82471C061A0C
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:18:24 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id g35so1763926uad.0
        for <git@vger.kernel.org>; Sat, 16 May 2020 04:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4VnSoTE+Dn1mTXMetY+cp42F8jL84HRI5LZeU/ExhE=;
        b=ExWB9UXcW42lq2VrHePXjS7rPkqvEea7YseZC6gQrcBbsZH8tuBUCnbw53agRz3+x5
         k1NDD7gajnOzIi/nsaItoQc44ezyDUeKyAQLaXWw4GuvyNFMi8DncNiHBeZchp8dxetS
         1g71rmDSKYo5nzHGYS5nW5kPk66yiZqD5jhWkVGfGDb1SR17VwfAR0F7LAUeIW1OnaM/
         RTdut34rD+GNyGiQshTEU8YCnEklt55ioSq4Ytc4SkBrqZCmJESLxLNJucw6ETjZcvHf
         uUdEsMJwbWhoZulcSJCfhmvdoQwNndCR1bCyFWHrRZ+cECXfzFbQyOGhr0teqJwIMO8K
         9P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4VnSoTE+Dn1mTXMetY+cp42F8jL84HRI5LZeU/ExhE=;
        b=DDF/p9XG2Zj8kXWS8UFCL3zJRuHeYF5fKYdgYasyNXt8pQk9Ykpn+ZRUkivT9LR9kU
         V+ewIyoT+hnvnD5AzkRm2eTxOpwCSjC9gE/ZCAvLup4+q0kypXQWgzgSHK9wq8jmbX14
         9fV9sJY5ERu/IImeH66HVYom/OpX5w5O7LkLh3SGhco+J2aYppeSCE9rMiIQUG/h8XB8
         EhjXwiXvZhdX4+hHLDh2zkpU++MgIzr8esZfwMWRSZof7ftgqBUUPLK9lsQgTMLHndcl
         uPwFWzPNQAlaJmBjoBjx2CXXu2IWUtSiY+omIHdjeaQEPB7MuTE7wT64MPqYGaGz6jFJ
         VMng==
X-Gm-Message-State: AOAM531WNiI8YBxAMqxmj52oNXWXLOpBdBIjXaoDGvZTKoW00G5du+/B
        tIwaULEs3J3lqPhpoznVtmBpMt5zVoFP3wxfr0eGWQ==
X-Google-Smtp-Source: ABdhPJwCE3WbZBKSoGystz9AxDVC66F7oPOmKLf7/ojMCSdE3yPMK/TRcacQKO4LP8h23O4LHu5zCg0E6BIHUsTSzU4=
X-Received: by 2002:ab0:544a:: with SMTP id o10mr5741318uaa.15.1589627903712;
 Sat, 16 May 2020 04:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200513005424.81369-1-sandals@crustytoothpaste.net> <20200513005424.81369-37-sandals@crustytoothpaste.net>
In-Reply-To: <20200513005424.81369-37-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 16 May 2020 13:18:12 +0200
Message-ID: <CAN0heSqpqAyKyaz+Er-SppR8k5W=zfw31rLR=Z8yZzqu=BCnTA@mail.gmail.com>
Subject: Re: [PATCH 36/44] builtin/index-pack: add option to specify hash algorithm
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 13 May 2020 at 02:56, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> git index-pack is usually run in a repository, but need not be. Since
> packs don't contains information on the algorithm in use, instead
> relying on context, add an option to index-pack to tell it which one
> we're using in case someone runs it outside of a repository.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/index-pack.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 7bea1fba52..89f4962a00 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1760,6 +1760,11 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
>                                         die(_("bad %s"), arg);
>                         } else if (skip_prefix(arg, "--max-input-size=", &arg)) {
>                                 max_input_size = strtoumax(arg, NULL, 10);
> +                       } else if (skip_prefix(arg, "--object-format=", &arg)) {
> +                               int hash_algo = hash_algo_by_name(arg);
> +                               if (hash_algo == GIT_HASH_UNKNOWN)
> +                                       die(_("unknown hash algorithm '%s'"), arg);
> +                               repo_set_hash_algo(the_repository, hash_algo);
>                         } else

Patch 27 added `--hash` to `git show-index` and I almost commented on
"hash" vs "object-format". In the end I figured the object format was a
more technical (protocol) term. But now I wonder. Should we try to align
such options from the start? Or is there perhaps a reason for those
different approaches?

Similar to an earlier patch where we modify `the_hash_algo` like this, I
feel a bit nervous. What happens if you pass in a "wrong" algo here,
i.e., SHA-1 in a SHA-256 repo? Or, given the motivation in the commit
message, should this only be allowed if we really *are* outside a repo?


Martin
