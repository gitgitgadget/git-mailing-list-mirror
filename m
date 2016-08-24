Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60A1D1F859
	for <e@80x24.org>; Wed, 24 Aug 2016 07:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbcHXHZ3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 03:25:29 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36686 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbcHXHZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 03:25:28 -0400
Received: by mail-it0-f67.google.com with SMTP id j124so1259814ith.3
        for <git@vger.kernel.org>; Wed, 24 Aug 2016 00:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yegnbJnq4XFAdq0WSTVv5i2yAK7B49YvyxpJTKulSCY=;
        b=U+nBlYYDsax94rSfVZu1IjzXmRPNlc/qZl6C4Skdc6gISjY1bzfNV4LUqYe4BZFWeV
         +TCgCtPZNtDNZV9YN2wesfAgojmI7lGoGpl/naAlgDEB0amGsimWB17fiqSj9GFwAXZc
         nJC9mIst8/wHnJKzcX5u0wsijOY9G4xoBeQ/CCHu0ckTe2tqXjPRYCh6nIW4/S7yFXh6
         8dU69JrDP4/sYpizhnuJEj04UUOsKNczB59tJtCPi+J4kaRtm88UjdvtWvYLoCDSMdO+
         1gU0bMgxGGpiFEVSL+vd3Vk/k/JPm+sYt2iWHLd6zLo62q3NYCFytyPB6kvrLQr0W3vM
         G+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yegnbJnq4XFAdq0WSTVv5i2yAK7B49YvyxpJTKulSCY=;
        b=kY8ZWwx5atIvaZta8Xdfz9R2yuHdqoH8TRSYaJPr4C2iHsxCKwehjQJIelztxTEiD0
         guouCAz09pwRu2jF9aeECunh44OMWFDkoCrKiieFk9gkExusjbsiajy9HLMB6o7PAT50
         vqpTf0JEddASchDnhhJg6HEqsP+R8e86dFhv5SMvNZuufYxneP60PqWuLKh0HP4wNGYV
         HvteY1fHK4vUfuHdmG/xUhr9fVxSSA/YwZ5NDgeuW52EfFiHO7hH2otlwyNmL8rNxDv1
         ZTww3LR2y/wEarcgs98a2hssHnuDISSFNxgRHDOQt39POA7U6kM88y44cLBLiMum4B28
         zFzg==
X-Gm-Message-State: AEkoousYIjIvLvlOlS64CrnptOrlfVJh0scblf8vByf6USSi99bYTAJHA93+8hWymc5lHPvwbqJNaoxeAF8HBw==
X-Received: by 10.36.31.18 with SMTP id d18mr2509138itd.84.1472023486676; Wed,
 24 Aug 2016 00:24:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.1 with HTTP; Wed, 24 Aug 2016 00:24:46 -0700 (PDT)
In-Reply-To: <0de75bbce8ade0c6e5cf87d3647faa71a89c6275.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <0de75bbce8ade0c6e5cf87d3647faa71a89c6275.1471968378.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Aug 2016 03:24:46 -0400
X-Google-Sender-Auth: LdJb83eW5tUZ4G50ZS0oFeA1J_g
Message-ID: <CAPig+cSR8BHFdMJz5mFkpJ3UU6w0Xmjav+tu6f3DrkG4Gi-v6A@mail.gmail.com>
Subject: Re: [PATCH 06/15] sequencer: lib'ify read_populate_todo()
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 12:07 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> To be truly useful, the sequencer should never die() but always return
> an error.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -754,18 +754,21 @@ static void read_populate_todo(struct commit_list **todo_list,
>
>         fd = open(git_path_todo_file(), O_RDONLY);
>         if (fd < 0)
> -               die_errno(_("Could not open %s"), git_path_todo_file());
> +               return error(_("Could not open %s (%s)"),
> +                       git_path_todo_file(), strerror(errno));

error_errno() perhaps?

>         if (strbuf_read(&buf, fd, 0) < 0) {
>                 close(fd);
>                 strbuf_release(&buf);
> -               die(_("Could not read %s."), git_path_todo_file());
> +               return error(_("Could not read %s."), git_path_todo_file());
>         }
>         close(fd);
>
>         res = parse_insn_buffer(buf.buf, todo_list, opts);
>         strbuf_release(&buf);
>         if (res)
> -               die(_("Unusable instruction sheet: %s"), git_path_todo_file());
> +               return error(_("Unusable instruction sheet: %s"),
> +                       git_path_todo_file());

Neither 'fd' nor 'buf' are leaked by these two new error returns. Good.

> +       return 0;
>  }
