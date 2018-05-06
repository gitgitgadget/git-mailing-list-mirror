Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D8C2200B9
	for <e@80x24.org>; Sun,  6 May 2018 17:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeEFR1N (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 13:27:13 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:40635 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751818AbeEFR1I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 13:27:08 -0400
Received: by mail-ot0-f194.google.com with SMTP id n1-v6so29598331otf.7
        for <git@vger.kernel.org>; Sun, 06 May 2018 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q81+mGBrutgbOm4q0fB/N55KVVsSCx9+T8bPQzFi/8A=;
        b=jtuwUPPA3BjVX0f8bh0l1YKuZwY+CS8f3HuE/I9f9x6jIs2zdgJIPTJl0v+54UZSW7
         BrvFqSL0WEciYIBaUly7fQMfiNDohVT/4E5/rCdnuK3d1r542v1YE2lpvPSoCOEsBfo0
         Hxf9EQkuxGafEiMVOGa4N8KY9XL00tmTJWGpnav6rpZwO9DPSYO3+9BhV4uwsGwaPKzd
         MyivwmCfSzycZ3p0wET7e7brK/na7MmDyLpx7P566vLdEV24oEJ/DRMyVDS00MX4Z2AX
         xf2O7a8HLN3m/J8YeiEtYbuxvJ+48tyacCCMAu25WBkEoum6NBAAj/eHICXAjARVrK4R
         9zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q81+mGBrutgbOm4q0fB/N55KVVsSCx9+T8bPQzFi/8A=;
        b=LW7guDGWnhpLwvHu1Jn5Yl6iS7QiZoH5goQlxWE+WOwrJaZsdPfs3vBaPtyMq8oKC1
         ocWPcMqsX1YKCxPa43zjeD3t8KGvp+cBCA7eQXIHfA1h/nYT7T9HXDhrqbCFMhU8zu7E
         84/EqFf6DSI7p4vmMAq55a6W6Gl3FIeVRBk9ro9SAZGs0grvqwQDpU2OjkLK62jkaz3F
         6N9ETScuaiMp+XjjrCdErlfkjaB0iQlPWyu0VRlizbDCVI1VIRrMMiExLdMX58dX53OQ
         +3zofbLY/NF90bYCP1r2budBx/Xlzqzau4Io8H5OM8Fe48Wg2inMOnyIyh0uPCNWj+SP
         Skpw==
X-Gm-Message-State: ALQs6tCzzKvjctpd47chjzoslBvo7cLNd65cOkcYl5EcxVjse8XKpHBw
        hlD+1gW/JDHwRlhWISVwXLd5SEcICXUdOxD6ZDQ=
X-Google-Smtp-Source: AB8JxZryxw4AE9aeiDehuD8iOaUEiVZrs19kkBh4D9jf0zgDFhhTBKGmYE6wWakQiMTDcNs7NBx9Mk2w6ELroBqNTWY=
X-Received: by 2002:a9d:1d92:: with SMTP id y18-v6mr23962993otd.304.1525627627976;
 Sun, 06 May 2018 10:27:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Sun, 6 May 2018 10:26:37 -0700 (PDT)
In-Reply-To: <20180506141031.30204-5-martin.agren@gmail.com>
References: <20180506141031.30204-5-martin.agren@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 6 May 2018 19:26:37 +0200
Message-ID: <CACsJy8DyRhQ0DKy8UyK+r7Kmw=0hHD=W6aXXKutk4e-wtGTdNg@mail.gmail.com>
Subject: Re: [PATCH 4/5] lock_file: make function-local locks non-static
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 6, 2018 at 4:10 PM, Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
> These `struct lock_file`s are local to their respective functions and we
> can drop their staticness.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  apply.c                | 2 +-
>  builtin/describe.c     | 2 +-
>  builtin/difftool.c     | 2 +-
>  builtin/gc.c           | 2 +-
>  builtin/merge.c        | 4 ++--
>  builtin/receive-pack.c | 2 +-
>  bundle.c               | 2 +-
>  fast-import.c          | 2 +-
>  refs/files-backend.c   | 2 +-
>  shallow.c              | 2 +-
>  10 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 7e5792c996..07b14d1127 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4058,7 +4058,7 @@ static int build_fake_ancestor(struct apply_state *=
state, struct patch *list)
>  {
>         struct patch *patch;
>         struct index_state result =3D { NULL };
> -       static struct lock_file lock;
> +       struct lock_file lock =3D LOCK_INIT;

Is it really safe to do this? I vaguely remember something about
(global) linked list and signal handling which could trigger any time
and probably at atexit() time too (i.e. die()). You don't want to
depend on stack-based variables in that case.
--=20
Duy
