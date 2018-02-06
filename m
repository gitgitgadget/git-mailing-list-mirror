Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E54101F404
	for <e@80x24.org>; Tue,  6 Feb 2018 04:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeBFEUq (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 23:20:46 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36313 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeBFEUp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 23:20:45 -0500
Received: by mail-qk0-f176.google.com with SMTP id 15so738857qkl.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 20:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=67X18y0EQqkcnJqrU96J9m0PKBFPuXv/JHNEfrok4yg=;
        b=I0CdqrC1kuAWRGgqn+FVvATP8a23TEKqJU7+iz41WEhw9XUaAtb85zMYCIaMRfKslL
         hEnTqnv76KpbWcg0m5VqkR0Deiw3zQaCh5tEXTB+NGtcP0cm3hA8+xbTtJxyoWOPbOsV
         R/6eOa5ENm9yUUvYa16aoGYx9atNREBa8tLEK7sbFLHU9Ga40Xp3TmU7Is2IXhIfnm+w
         IEITZ5UHePr6b2wDl86FwaAE7Ll0XwCD++XVeWOzr1hL9pBC4HjtUx4/h1OjLAnDeYt7
         b200o6nHhDIL9upMDwsUqqZzRXjikBF0adzKLEytPfcnWD70ocBRzrJVPXLrxuilC+nY
         7jEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=67X18y0EQqkcnJqrU96J9m0PKBFPuXv/JHNEfrok4yg=;
        b=Vv3gH9aM7YqPc9kEjyjoOsmbs4cGjTdrSSFPWLYn2bUffRwiU62CQwv3XrkyCTgzmk
         QfuHfBQGUO4bPqX4DMpxZ8TWhAEADWzn3NPDyV6qr89GPRNvx7PpOsibpREU82/5RB99
         pzmXeolFAUzYMZ47zyUwLkZTMmz9T9/E6JixKwH7rKozK9paoDgwY5km8r2JD4jgq64K
         XsTMUrP/VdpEA2i8Tb1eQHR0ajFIYqxiO6ecKMmsBpZ+xNFG3eUyP6oTx7HsSDenXyvK
         pBnE1gAaq+tJ8brm0W3iKrfIDtoQOBlURQc7wbFnvxOdXah+nI6BZb9D2AgpD5977Fv7
         QYBg==
X-Gm-Message-State: APf1xPALf+tndpeYddnWlNMOllRY7oaJiOA+KpiFxv+OHyMWpXwDjbr3
        44dQpZQdmRLh4RkVjC1pCEzu2aGUOz24e5oVtFw=
X-Google-Smtp-Source: AH8x224RY3EBxjZozsValSSYjAFMwKjEgEsjeEfjRL84ujrPyqgb570Pf2V/YTJ5KRWErmxRJGDSTxvRWqd1en5nsPA=
X-Received: by 10.55.177.135 with SMTP id a129mr1669757qkf.112.1517890844439;
 Mon, 05 Feb 2018 20:20:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Mon, 5 Feb 2018 20:20:44 -0800 (PST)
In-Reply-To: <20180205235735.216710-55-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com> <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-55-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Feb 2018 23:20:44 -0500
X-Google-Sender-Auth: 94yucWxK029UChjlW9jn7EgJbQY
Message-ID: <CAPig+cTjUAYRbaF_CLAmtYf56cL2hhvYc4VLrE8DX-MiryCWXA@mail.gmail.com>
Subject: Re: [PATCH 075/194] fetch, push: do not use submodule as alternate in
 has_commits check
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 6:55 PM, Stefan Beller <sbeller@google.com> wrote:
> Both fetch and push still use alternates to access submodules in some
> other code paths, but this is progress towards eliminating the alternates
> hack that conflates access to the_repository and other repositories.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/submodule.c b/submodule.c
> @@ -832,24 +833,43 @@ static int check_has_commit(const struct object_id *oid, void *data)
> +static int open_submodule(struct repository *out, const char *path)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       if (submodule_to_gitdir(&sb, path))
> +               return -1;

submodule_to_gitdir() makes no promise that it has not made
allocations to 'sb' when it returns -1, so this is potentially
leaking. Therefore, you should strbuf_release() here.

> +
> +       if (repo_init(out, sb.buf, NULL)) {
> +               strbuf_release(&sb);
> +               return -1;
> +       }

Or just combine these two error cases:

    if (submodule_to_gitdir(...) || repo_init(...)) {
        strbuf_release(...);
        return -1;
    }

> +       out->submodule_prefix = xstrdup(path);
> +
> +       strbuf_release(&sb);
> +       return 0;
> +}
