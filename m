Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9A5C20248
	for <e@80x24.org>; Tue, 26 Feb 2019 12:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfBZMSz (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 07:18:55 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35950 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfBZMSz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 07:18:55 -0500
Received: by mail-it1-f196.google.com with SMTP id v83so3717778itf.1
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 04:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6LNCjlRRtmMgbMuwtaumMWxeQpA82Pj1J9GlifdRYjY=;
        b=gJlBZR7L5v16+RxAhJ5NGuFg0betg321q74eQxZDs4mpkay5TXTxlpd3T8F1J1Gn6X
         1S6C6b5YPTIOvc46prSkHftMdbcjETvhFxb3Bnxb+IPWfQjpbZgfDpCyBGAMmp4TBkai
         sqk2HfDBGyAH2SwEI6IksP8hyVXMnrHiX1vhC6nL1FMpNmCPi5L9chmWWbF8JktIUz1w
         rai5pILh4RLyBRQlh9DDJBFRzpKXhpBauA8pmCHdTzF+EtvGaWJ89pAW5GRmqgJidAC0
         diAAy5YJ4UM9kdB2s41DOS1cqu+y+b99V3oUOqfU02f+UVqXMj08VocufgYD8K06mvXh
         Q8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6LNCjlRRtmMgbMuwtaumMWxeQpA82Pj1J9GlifdRYjY=;
        b=p5LKZJZRN53h96fx40jYnsVvVjD9TO+BOUL3FFiyoosbHz3yU/Kj0lHwZHQcAxWgjp
         NXA9KMIcHImIQ023fYjUD5ybP8llfHdXvT5ntIFSPX5ki1WC9pHlTIW7j9SMlFQIiGYx
         fsR9m5Cs0fl+jaPhEiB406dzywVy8P/E8jF9yV0BhF0+yvnhlcPsdkV1Z71GKmZlfWr2
         29mMZ5X5+vynYjqHpjEW8TeY6HrrKKb7vLiXFapqRM7TJYGtdX79Li+MOux4+IzS6mxb
         /yUnZSrQhHZlSlIyfTeDea+xiinlqgUYK35Q6qJNMHMYY4KH9R/vkEFDdIDtR/cvOnTY
         /5Dg==
X-Gm-Message-State: APjAAAVbfoseQzq8kSJ/hgCP22foMJvQR5MTx9T+y2NMGwFwthVXKr8Z
        JsItT9WMdJoM4RNJk231wCFNHXX7qD64xbjY//0=
X-Google-Smtp-Source: AHgI3IZxvjUFz+CnOis+Hf1NWhjk2SMU+9+qd4e4xq6VpaUcQModq6bVC/fbMiCUUvaNkc2S1ie0QgPKpanSHmWxsZw=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr2164516itf.123.1551183534423;
 Tue, 26 Feb 2019 04:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20190226051804.10631-1-matheus.bernardino@usp.br> <20190226051804.10631-5-matheus.bernardino@usp.br>
In-Reply-To: <20190226051804.10631-5-matheus.bernardino@usp.br>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 26 Feb 2019 19:18:28 +0700
Message-ID: <CACsJy8BztC=GNuPU_CuLbPSmhsjrSk8MmkyeK6ahgjEOzY=yOQ@mail.gmail.com>
Subject: Re: [WIP RFC PATCH v2 4/5] clone: extract function from copy_or_link_directory
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 12:18 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Extract dir creation code snippet from copy_or_link_directory to its own
> function named mkdir_if_missing. This change will help removing
> copy_or_link_directory's explicit recursion, which will be done in a
> following patch. Also makes code more readable.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  builtin/clone.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index cae069f03b..fd580fa98d 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -392,6 +392,24 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
>         fclose(in);
>  }
>
> +static void mkdir_if_missing(const char *pathname, mode_t mode)
> +{
> +       /*
> +        * Create a dir at pathname unless there's already one.

This confused me for a second because I thought it described "st"
variable. I think we usually put the description of the function on
top (before the "void mkdir_if.." line). But with a such a short
function and clear name like this, I don't think we need any comments.

> +        */
> +       struct stat st;
> +
> +       if (mkdir(pathname, mode)) {

Good opportunity to unindent this by doing

    if (!mkdir(...
         return;

but it's up to you.

> +               if (errno != EEXIST)
> +                       die_errno(_("failed to create directory '%s'"),
> +                                 pathname);
> +               else if (stat(pathname, &st))
> +                       die_errno(_("failed to stat '%s'"), pathname);
> +               else if (!S_ISDIR(st.st_mode))
> +                       die(_("%s exists and is not a directory"), pathname);
> +       }
> +}
> +
>  static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>                                    const char *src_repo, int src_baselen)
>  {
> @@ -404,14 +422,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>         if (!dir)
>                 die_errno(_("failed to open '%s'"), src->buf);
>
> -       if (mkdir(dest->buf, 0777)) {
> -               if (errno != EEXIST)
> -                       die_errno(_("failed to create directory '%s'"), dest->buf);
> -               else if (stat(dest->buf, &buf))
> -                       die_errno(_("failed to stat '%s'"), dest->buf);
> -               else if (!S_ISDIR(buf.st_mode))
> -                       die(_("%s exists and is not a directory"), dest->buf);
> -       }
> +       mkdir_if_missing(dest->buf, 0777);
>
>         strbuf_addch(src, '/');
>         src_len = src->len;
> --
> 2.20.1
>


-- 
Duy
