Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2561F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbeACA64 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:58:56 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36089 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeACA6z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:58:55 -0500
Received: by mail-wm0-f46.google.com with SMTP id b76so124940wmg.1
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zSdLTgDBnh+XIjfdwKctQ5lLHX8aFSm+saZDrW2H2yw=;
        b=cZxvQWy5+0FsC4QwOGk1+wg767QUILnXO4ojMOAnMDdek6LZBBbXWlhzq1h50aPo6I
         uuH+Y8Nw9DiGnvX/p5Ax97NccZbuuTgZgeoMCB7vT5ZskuzGXXoDKlEU8BpBMSnZ+qif
         pnPTo7QwfEcULIL3fdjQo/2dTkAlE5r7HGEBrLSUfyknn8WDYQbgNTsVoVfPnikhsO+j
         ANq3mzQCWBIu/ga/TtmijG8utGdgIBn6toNYSXUW4hQN7QDkcY/24Q9bBNCxq2Fv+n9d
         V5ST93cyljObw+Dl+ffgj1EOi8q+zo2s9g4A8Jd7S/M6719rfwLGhLA8LBhETU8reRJd
         4wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zSdLTgDBnh+XIjfdwKctQ5lLHX8aFSm+saZDrW2H2yw=;
        b=JZvLcepmYGwCZc472aEHRCs9wK0n/moOQuVe+kVZaxtbSwNLVDo5DHGn3/Jshuhg66
         77bB0mKn/89C/6r2YL0iUqTxGJlRzNkD8HMPIg5NqHGDUwj4bpEy87teNd4SujFwSbV/
         F45SpEB2DhBBYv/SEOe4kJyoa22qZJESZXBXrkm1O7xZyrJdYLjCibEOXG80gequTFw/
         vykSUBOgEn6bF/3kHaCiPjdmaa90ur4698zazX9Yn6QmlJIabyroBMhxvlcxwwhUnUqN
         nVStP99t2Ly1HDc8XnxifaIq6d0EXTOckp1xp92aGZ/8RJ2Xt1eRBHqk2+LL866354/B
         FMAA==
X-Gm-Message-State: AKGB3mIHmRi6xNvT/hNY0/2LgPE1Q80AVvb2Mj28KSF05pClwtbKRN2c
        n2npoD10Y10ol5XCaFqQa85W8GgkTsl4PMbZb0c=
X-Google-Smtp-Source: ACJfBouLWbizfMNLzPwY80eG69bMZgcUWIOoQHGeUJwMLev/y/u8h9dlu1FKSEUxwPc38RvEs3Yq59r6ByfYe5ChylA=
X-Received: by 10.80.208.195 with SMTP id g3mr263422edf.246.1514941134143;
 Tue, 02 Jan 2018 16:58:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Tue, 2 Jan 2018 16:58:33 -0800 (PST)
In-Reply-To: <20180103004624.222528-6-sbeller@google.com>
References: <20180103004624.222528-1-sbeller@google.com> <20180103004624.222528-6-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 2 Jan 2018 16:58:33 -0800
Message-ID: <CA+P7+xr7W2sTtUBAhQDZXOTVypuiCU0fL+-W4tbVPd++QbUJcA@mail.gmail.com>
Subject: Re: [PATCH 5/5] diff: properly error out when combining multiple
 pickaxe options
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 2, 2018 at 4:46 PM, Stefan Beller <sbeller@google.com> wrote:
>                 die(_("--name-only, --name-status, --check and -s are mutually exclusive"));
> +       count = 0;
> +
> +       if (options->pickaxe_opts & DIFF_PICKAXE_KIND_S)
> +               count++;
> +       if (options->pickaxe_opts & DIFF_PICKAXE_KIND_G)
> +               count++;
> +       if (options->pickaxe_opts & DIFF_PICKAXE_KIND_OBJFIND)
> +               count++;
> +       if (count > 1)
> +               die(_("-G, -S, --find-object are mutually exclusive"));

Nit: I'd put an "and" in the sentence.
