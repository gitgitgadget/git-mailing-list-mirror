Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E47921FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 10:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbcLHK5p (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 05:57:45 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:33084 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbcLHK5n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 05:57:43 -0500
Received: by mail-io0-f194.google.com with SMTP id k5so168700ioi.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 02:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mlpoSmvhhg8nJXx69alb5uHKQalt3sarbyvaSmG6qtE=;
        b=it9rTNZLWM/eDvo4r80oGgEsSTlAHL+/8RM6Qt9GF4MlmOWf3eRjnQbMy61pvj2K3F
         WiFcV/UmdJ4RPUpeS77tu/cGw6lm+iTW4cNK5IEil8jkRhkAsQrffl5qBeXPJyR4q52t
         Ws1wBix6zExlEenXQkbSdRlhdQM0a/o9U4M2PnjBkfs0POTzdxuGXBJx5jAB4edDc2lK
         RV0Cv67XNMJiI4cXYAnfYY9MK72VdGKj9X9qTbyV7Oij8eH07eOkOcSHSsRJnUijmQpT
         fB1OABXv7jpj4yB1BcQh+wPgMWGJbbGUYoD8meBSnHBhs97ZvzeVa06mlxmXA+5jsdso
         d6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mlpoSmvhhg8nJXx69alb5uHKQalt3sarbyvaSmG6qtE=;
        b=gKowaQi96vuPuCNAteXBuj7N9rQn1dpjpFys/25YEVpF/vh/3kL/6XaChoATuccxuS
         9cZ9SIyWGIzfk9HC0Ocl3bHyUphhlZ246/4R/hOKCQw7gZwYqqgmlc+vK3xdHhukdJm1
         NIFJU1td3MjassuktO5SOaUBsKelZaECDUYdkiUoEr08Nf3qFCqMMzWLi/iqKECNojQf
         SOaFpqs8xtZj3+PUq4JAmkkAON7Bsjub2B1ib/G27tTcePkX+ZCqcmKURJJpv0Eh8Qvc
         N5tmARmhEKWueGGNM5jjI9KsYCAdMNIE7zPOHQCIVv6S4bKN11km1c+91BqHmD844APh
         weWw==
X-Gm-Message-State: AKaTC00jv8bSJhnimAoJGDOdwkuWBBwuWbEbigvnGuEatqBrIE96znfYm7qyVf+zcXcN7DaLGNuCiyT74gnuEg==
X-Received: by 10.107.132.74 with SMTP id g71mr63980443iod.19.1481194605958;
 Thu, 08 Dec 2016 02:56:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 8 Dec 2016 02:56:15 -0800 (PST)
In-Reply-To: <20161208014623.7588-8-sbeller@google.com>
References: <20161208014623.7588-1-sbeller@google.com> <20161208014623.7588-8-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Dec 2016 17:56:15 +0700
Message-ID: <CACsJy8DTeVVKjqT+eKGTDyoMQJ_ddh=Y-v46JCj6dqcQoSw7fg@mail.gmail.com>
Subject: Re: [PATCHv6 7/7] submodule: add absorb-git-dir function
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 8:46 AM, Stefan Beller <sbeller@google.com> wrote:
> diff --git a/dir.c b/dir.c
> index 8b74997c66..cc5729f733 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2774,3 +2774,15 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
>         free(real_work_tree);
>         free(real_git_dir);
>  }
> +
> +/*
> + * Migrate the git directory of the given path from old_git_dir to new_git_dir.
> + */
> +void relocate_gitdir(const char *path, const char *old_git_dir, const char *new_git_dir)
> +{
> +       if (rename(old_git_dir, new_git_dir) < 0)
> +               die_errno(_("could not migrate git directory from '%s' to '%s'"),
> +                       old_git_dir, new_git_dir);
> +
> +       connect_work_tree_and_git_dir(path, new_git_dir);
> +}

Thank you!
-- 
Duy
