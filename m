Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 107141F404
	for <e@80x24.org>; Sun,  7 Jan 2018 12:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753922AbeAGMpW (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 07:45:22 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43214 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753847AbeAGMpU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 07:45:20 -0500
Received: by mail-ot0-f196.google.com with SMTP id r42so1885835otb.10
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 04:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SRulSzloCNIRLPBmr6spo9djNNc1JLgWoYS6nAN+N64=;
        b=ZGSMoCId4KfWUFpF9b4a9HEYnIW8j3pB+5kDTE1sPN1urlxA0q4gcPOE/eK1WRaBxg
         HstgfHIBdE7NG/kVFYkIWwBr0DQ6WDWGcUEk/2o/EiKBXsKB4FmAlrtR9dp5RbCW/xzT
         eiBbLiQfJxlSk6oUdxRRefQM3mZpyrLxRNWr/RS4mIZDuXwGLCWnuyN2CNzOj7GJyZvh
         uVZbQkmXJLfHHCHAAPptPLUAuEbL1xBCR2bqXklcP9PwR3pNsmHUwb0nd/HVqQ4fQooE
         79ur4aoTFRC5haAtMHLwY+tC+r61lnNzYtoYFP862Xs7GACXTHvlcawadQbkSH/WTLsu
         V1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SRulSzloCNIRLPBmr6spo9djNNc1JLgWoYS6nAN+N64=;
        b=pdofuJtW//s98gZdtc7p5Sar34Q2L4tmS+7iKj3gloeTFj9bXQvdE6Q4MzpynbxetK
         xlpKhSxW01lg7d5nffMnZu3OTJFDnVVTolQ1+i9EtI/ETvgj3+lAJ+GcxO7WK1Bj/cud
         hXE2xfCOWCrUV4im3DTN0+rXXjfzZKLAXQe6GNd77t9SxQVILG/vpEbBfEKP1KnBOYqb
         StT0Dn6D/r7Cxt6u1EpvuuWWJdu46ldsUId1oTZbCHBfUrFl33Qrz02f1KrivRzdBg00
         Hqajm7cnbjZOJaUoc3A7m4o2kdPmVDVO0JpsUuKJDa4Xk4YZ70s1vDqLcEn2dNveLgH8
         wfxQ==
X-Gm-Message-State: AKwxytfY9FFdJkxsDOTf26/0NEVPI8jzUaRpGMdoR293og9ESsNcE77C
        VNCy1RuL4cteL17HsYAyJd5OSyFNu60LayAmtKA=
X-Google-Smtp-Source: ACJfBou31NolWfEbz3I8UfWF5OEImkYFPW6ATKZmmgoxR7gbtFNWZIIyMnfEUibnPd7O9QQea/OzrytUoPX+nhyQcTk=
X-Received: by 10.157.32.108 with SMTP id n99mr5511005ota.301.1515329119200;
 Sun, 07 Jan 2018 04:45:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Sun, 7 Jan 2018 04:44:48 -0800 (PST)
In-Reply-To: <20180103204928.3769-6-avarab@gmail.com>
References: <CACsJy8BnxOz9brnkyZ58guTsUhgKKN_XQvbYaZJz17888pgHoQ@mail.gmail.com>
 <20180103204928.3769-1-avarab@gmail.com> <20180103204928.3769-6-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 7 Jan 2018 19:44:48 +0700
Message-ID: <CACsJy8DG8H4r+-yAzo0Z8xuzb3FpDCayGaj0jqO4btkymrGN6Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] dir.c: stop ignoring opendir() error in open_cached_dir()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 4, 2018 at 3:49 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> A follow-up to the recently fixed bugs in the untracked
> invalidation. If opendir() fails it should show a warning, perhaps
> this should die, but if this ever happens the error is probably
> recoverable for the user, and dying would just make things worse.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  dir.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 163ca69df0..a605e01692 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1857,17 +1857,22 @@ static int open_cached_dir(struct cached_dir *cdi=
r,
>                            struct strbuf *path,
>                            int check_only)
>  {
> +       const char *c_path;
> +
>         memset(cdir, 0, sizeof(*cdir));
>         cdir->untracked =3D untracked;
>         if (valid_cached_dir(dir, untracked, istate, path, check_only))
>                 return 0;
> -       cdir->fdir =3D opendir(path->len ? path->buf : ".");
> +       c_path =3D path->len ? path->buf : ".";
> +       cdir->fdir =3D opendir(c_path);
>         if (dir->untracked) {
>                 invalidate_directory(dir->untracked, untracked);
>                 dir->untracked->dir_opened++;
>         }
> -       if (!cdir->fdir)
> +       if (!cdir->fdir) {
> +               warning_errno(_("could not open directory '%s'"), c_path)=
;

This should be closer to opendir(). The code in between,
invalidate_directory(), could have modified errno and we would print
incorrect message here.

But you can't simply move the whole "if (!cdir->fdir) { .. }" block up
either because we want to invalidate before returning -1, so perhaps

       cdir->fdir =3D opendir(c_path);
       if (!cdir->fdir)
               warning_errno(_("could not open directory '%s'"), c_path);
       if (dir->untracked) { ... }
       if (!cdir->fdir)
               return -1;

>                 return -1;
> +       }
>         return 0;
>  }
>
> --
> 2.15.1.424.g9478a66081
>



--=20
Duy
