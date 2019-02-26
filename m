Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4D5320248
	for <e@80x24.org>; Tue, 26 Feb 2019 12:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfBZMON (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 07:14:13 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39081 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfBZMOM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 07:14:12 -0500
Received: by mail-io1-f66.google.com with SMTP id x3so10275159ior.6
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 04:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xdZFinpg90GbUzKvvJvz1dGzHNLpcskYB7eFxYVRI8E=;
        b=mHdbbX/3gSfWGErozll/T2nEDJ1uAX5GolrTA+dYyTmvc9JEmy0XX6thZW0gwbg6H1
         Kt9E2LPkEZMctbStK5a41y2EnuystfPGwZV9vrYkDXwSiOyT1hdqc1nz42AMb3C9Wdb3
         SA/j6BZuZvbvs5aeQC+Jpg7JajKjqw5UUx1UkFToOt/JvuMzGdHYYPhPTeiWdjEOioPU
         uws5IbZqUsADWUp+t/wdXjv0uwS+FAv6+t/RuYGZ3gBYOg3BWr4eP5byRVn3pXGfJOwp
         0VlwqFQna6qPf93uPogXBFHPHnk7UYZvJUm5fCSilDxuHWfm36AABcvC57HLtwU2JgJT
         EMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xdZFinpg90GbUzKvvJvz1dGzHNLpcskYB7eFxYVRI8E=;
        b=UTtNA2zlMCr8n16onhD4WHXjgy/OwbZUB8NX4OmsJ0+834CLtLhsiBD9zVNj6nqY3X
         BSKj72QgCQLlrP4D2Q0NQuX1rU1yBydXITw3ZPx/Ymg3l7Dh1Zh3sG47WAAxaUDM4/6a
         Ip3z3q7gFNWhFi+4lJOrtz4JRBeE2eMgx4TTLH6Xf6Dj6sNsOxiFaE1Bg//mMH97hy4B
         SMK6nQFKU3KWQOPVQBI6oO2njuA26fTzV9IYOPHjrliyn6ZMo4Crlgw5EIPflLgE4yrg
         1iC8KZ+UGJTjnmrqRmPlMRHVpVF4h7neoqVyKoTYzAyS3wpjyidiIJGeKvlh0+dJrx3y
         12tQ==
X-Gm-Message-State: AHQUAuYYOrBV2ipGYoqcKslycIMxm0DuoKifsMzagaN6mG+pT9VTEVg7
        VRsFKa+jmvLZVLmVe/jyV6DpEjgpQFAK1aKWAnc=
X-Google-Smtp-Source: AHgI3IbYZtQc4J16q9nk5Q8W2CCl/QRCWW7XN36VGwwmru3KAsIwnOBvImTeT2SqTn6fYO+lfB/GwB/qo51re5kaz3k=
X-Received: by 2002:a5d:9357:: with SMTP id i23mr10312556ioo.236.1551183251883;
 Tue, 26 Feb 2019 04:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20190226051804.10631-1-matheus.bernardino@usp.br> <20190226051804.10631-4-matheus.bernardino@usp.br>
In-Reply-To: <20190226051804.10631-4-matheus.bernardino@usp.br>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 26 Feb 2019 19:13:45 +0700
Message-ID: <CACsJy8B=NT8F4-gHwomSu39iY0pbJqJjCi+yqgPs_D_6ELx5+Q@mail.gmail.com>
Subject: Re: [WIP RFC PATCH v2 3/5] clone: copy hidden paths at local clone
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 12:18 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Make the copy_or_link_directory function no longer skip hidden paths.

It's actually only hidden directories because of the S_ISDIR check
right above. Not that it matters much...

> This function, used to copy .git/objects, currently skips all hidden
> directories but not hidden files, which is an odd behaviour. The reason
> for that could be unintentional:

This goes back to the very first version of clone.c in 8434c2f1af
(Build in clone - 2008-04-27). If you look at git-clone.sh back then,
which is the version before the C conversion, it does something like
this

    find objects -depth -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/"

and I'm pretty sure 'find' will not attempt to hide anything. So yes I
think this is just for skipping '.' and '..' and accidentally skips
more. From that view, it's actually a regresssion but nobody ever
bothers to hide anything in 'objects' directory to notice.

> probably the intention was to skip '.'
> and '..' only but it ended up accidentally skipping all directories
> starting with '.'. Besides being more natural, the new behaviour is more
> permissive to the user.
>
> Also adjusted tests to reflect this change.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/clone.c            | 2 +-
>  t/t5604-clone-reference.sh | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 50bde99618..cae069f03b 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -428,7 +428,7 @@ static void copy_or_link_directory(struct strbuf *src=
, struct strbuf *dest,
>                         continue;
>                 }
>                 if (S_ISDIR(buf.st_mode)) {
> -                       if (de->d_name[0] !=3D '.')
> +                       if (!is_dot_or_dotdot(de->d_name))
>                                 copy_or_link_directory(src, dest,
>                                                        src_repo, src_base=
len);
>                         continue;
> diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
> index 6f9c77049e..f1a8e74c44 100755
> --- a/t/t5604-clone-reference.sh
> +++ b/t/t5604-clone-reference.sh
> @@ -262,16 +262,25 @@ test_expect_success SHA1,SYMLINKS 'clone repo with =
manually symlinked objects/*'
>         test_cmp expected actual &&
>         find S-* -name "*some*" | sort >actual &&
>         cat >expected <<-EOF &&
> +       S--dissociate/.git/objects/.some-hidden-dir
> +       S--dissociate/.git/objects/.some-hidden-dir/.some-dot-file
> +       S--dissociate/.git/objects/.some-hidden-dir/some-file
>         S--dissociate/.git/objects/.some-hidden-file
>         S--dissociate/.git/objects/some-dir
>         S--dissociate/.git/objects/some-dir/.some-dot-file
>         S--dissociate/.git/objects/some-dir/some-file
>         S--dissociate/.git/objects/some-file
> +       S--local/.git/objects/.some-hidden-dir
> +       S--local/.git/objects/.some-hidden-dir/.some-dot-file
> +       S--local/.git/objects/.some-hidden-dir/some-file
>         S--local/.git/objects/.some-hidden-file
>         S--local/.git/objects/some-dir
>         S--local/.git/objects/some-dir/.some-dot-file
>         S--local/.git/objects/some-dir/some-file
>         S--local/.git/objects/some-file
> +       S--no-hardlinks/.git/objects/.some-hidden-dir
> +       S--no-hardlinks/.git/objects/.some-hidden-dir/.some-dot-file
> +       S--no-hardlinks/.git/objects/.some-hidden-dir/some-file
>         S--no-hardlinks/.git/objects/.some-hidden-file
>         S--no-hardlinks/.git/objects/some-dir
>         S--no-hardlinks/.git/objects/some-dir/.some-dot-file
> --
> 2.20.1
>


--=20
Duy
