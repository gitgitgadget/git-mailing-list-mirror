Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C357B1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 19:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932264AbeDWTIk (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 15:08:40 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:43483 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932175AbeDWTIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 15:08:39 -0400
Received: by mail-yw0-f195.google.com with SMTP id y3-v6so3934024ywi.10
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 12:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0oAJ171vEWCAOycOuGHhf0+JqkLtStwynwXGSKhoBrA=;
        b=uTpudfosDdZRRbaOev//FVst8VQLReElZxlo9rgg28OGq5HCdI6Fvh4nddzj0utR8I
         83i4iIYvslqzuw61RMJ1TNpYoG0b7D2JnnVX4ZwAyx/LUFNLL1Ox4w42e22zzXyKOVq8
         Y7ZprHxriHx7TxhsLoxp6mKUtfriGjS8PJrtNq0vj8QSysfbQKMGz+8mg84OiUI+0j1t
         nrW+Zyn/3Chp2U4AYslHA4vM25dY505X94PdusmUEK73qfsdMyht4/OWigTfiwxiHD+Z
         SaWxJ/asD4pUNHkBXF8sBFSNwqKSVZkaabIKOYF3IRNLpeNItBdrpcxomW43Qr3Y+rjB
         RXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0oAJ171vEWCAOycOuGHhf0+JqkLtStwynwXGSKhoBrA=;
        b=gC/CV1rpWeX5f+FF86HiemNc4zRJNP6ZtCpL4lapnodEZTK5dNAgdN6dgcuaIkk7r/
         W0+JS7AQgHbdQVDJt6gkhJTaysX3HeBB5W6FMCPlgyaNaadpzyLMaZZGgxvTl2hxOTfO
         dd4Abz3YsEsUU+7zq0vrk9flheql6yNz3RctAeNuIvIJ7msJA0FwZznXDMDE38c8p6CB
         674ySg5UNxtXuLrc87yerMcxhtYjLqdZSHpGCoVIsxfsDi8EAiwm7O4sxRebU2cGbN/U
         pFfxIGtSmITffU6hwKqYGb1JGyQLXibIJ38oVUai1rDm96uLiuXBsdE2lxR0jzSQS3Y0
         NBXw==
X-Gm-Message-State: ALQs6tBQ19acdTVIGuYfBNaFPT9OYVAvwdUvS3X2ZAbvUaxn+RhylLRq
        81rzKhDatuJ2OazZz/6NKyufCLC6X+rc/zcXVHPrJw==
X-Google-Smtp-Source: AIpwx481ulzsanbJFg3UxeSXTYushgBvHj4omu64iDSzLu9cZ17izMM9+GA2tq0Dd78ZiFjMIokLi1wi/POjCTBiFKM=
X-Received: by 2002:a0d:e28e:: with SMTP id l136-v6mr11404327ywe.500.1524510518548;
 Mon, 23 Apr 2018 12:08:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 23 Apr 2018 12:08:37
 -0700 (PDT)
In-Reply-To: <f962f8043fb1125b47090a82c35e2d67d3d9d216.1524303776.git.johannes.schindelin@gmx.de>
References: <cover.1524262793.git.johannes.schindelin@gmx.de>
 <cover.1524303776.git.johannes.schindelin@gmx.de> <f962f8043fb1125b47090a82c35e2d67d3d9d216.1524303776.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Apr 2018 12:08:37 -0700
Message-ID: <CAGZ79ka=BLGCCTOw848m0SE9O+ZKhQfiW9RUz99W4=Gdg+7ofQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] replace: "libify" create_graft() and callees
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Fri, Apr 20, 2018 at 3:21 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> @@ -250,27 +257,38 @@ static void import_object(struct object_id *oid, enum object_type type,
> -               if (strbuf_read(&result, cmd.out, 41) < 0)
> -                       die_errno("unable to read from mktree");
> +               if (strbuf_read(&result, cmd.out, 41) < 0) {
> +                       close(fd);
> +                       close(cmd.out);
> +                       return error_errno("unable to read from mktree");

So before the errno is coming directly from strbuf_read,
which will set errno on error to the desired errno.
(It will come from an underlying read())

However close() may fail and clobber errno,
so I would think we'd need to

    if (strbuf_read(&result, cmd.out, 41) < 0) {
      int err =  errno; /* close shall not clobber errno */
      close(fd);
      close(cmd.out);
      errno = err;
      return error_errno(...);
    }

> -               if (fstat(fd, &st) < 0)
> -                       die_errno("unable to fstat %s", filename);
> +               if (fstat(fd, &st) < 0) {
> +                       close(fd);
> +                       return error_errno("unable to fstat %s", filename);
> +               }

Same here?

An alternative would be to do
    ret = error_errno(...)
    close (..)
    return ret;


> @@ -288,19 +307,23 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
>         struct strbuf ref = STRBUF_INIT;
>
>         if (get_oid(object_ref, &old_oid) < 0)
> -               die("Not a valid object name: '%s'", object_ref);
> +               return error("Not a valid object name: '%s'", object_ref);
>
>         type = oid_object_info(&old_oid, NULL);
>         if (type < 0)
> -               die("unable to get object type for %s", oid_to_hex(&old_oid));
> +               return error("unable to get object type for %s",
> +                            oid_to_hex(&old_oid));
>
> -       check_ref_valid(&old_oid, &prev, &ref, force);
> +       if (check_ref_valid(&old_oid, &prev, &ref, force))
> +               return -1;
>         strbuf_release(&ref);
>
> -       export_object(&old_oid, type, raw, tmpfile);
> +       if (export_object(&old_oid, type, raw, tmpfile))
> +               return -1;
>         if (launch_editor(tmpfile, NULL, NULL) < 0)
> -               die("editing object file failed");
> -       import_object(&new_oid, type, raw, tmpfile);
> +               return error("editing object file failed");
> +       if (import_object(&new_oid, type, raw, tmpfile))
> +               return -1;
>
>         free(tmpfile);

Do we need to free tmpfile in previous returns?

> @@ -394,24 +422,29 @@ static int create_graft(int argc, const char **argv, int force)
>         unsigned long size;
>
>         if (get_oid(old_ref, &old_oid) < 0)
> -               die(_("Not a valid object name: '%s'"), old_ref);
> -       commit = lookup_commit_or_die(&old_oid, old_ref);
> +               return error(_("Not a valid object name: '%s'"), old_ref);
> +       commit = lookup_commit_reference(&old_oid);
> +       if (!commit)
> +               return error(_("could not parse %s"), old_ref);
>
>         buffer = get_commit_buffer(commit, &size);
>         strbuf_add(&buf, buffer, size);
>         unuse_commit_buffer(commit, buffer);
>
> -       replace_parents(&buf, argc - 1, &argv[1]);
> +       if (replace_parents(&buf, argc - 1, &argv[1]) < 0)
> +               return -1;
>
>         if (remove_signature(&buf)) {
>                 warning(_("the original commit '%s' has a gpg signature."), old_ref);
>                 warning(_("the signature will be removed in the replacement commit!"));
>         }
>
> -       check_mergetags(commit, argc, argv);
> +       if (check_mergetags(commit, argc, argv))
> +               return -1;
>
>         if (write_object_file(buf.buf, buf.len, commit_type, &new_oid))
> -               die(_("could not write replacement commit for: '%s'"), old_ref);
> +               return error(_("could not write replacement commit for: '%s'"),
> +                            old_ref);
>
>         strbuf_release(&buf);

Release &buf in the other return cases, too?

Thanks,
Stefan
