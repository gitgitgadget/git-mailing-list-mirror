Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001AEC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 03:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D410860BD3
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 03:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhIBDlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 23:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbhIBDlS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 23:41:18 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1531FC061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 20:40:21 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id e7so333849plh.8
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 20:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5wi31mwXwtNZbe8Gf39XkK5bj6O5hjqeJphNJYhsUC8=;
        b=i9z2OI2EJyx3DXxhFVS84iuHecVZg2/k7JLDstftaBLQgnsnExxb0lmzizuuBNCwFk
         iaqaLfOjHV7m5WH+GHrs9vZ2ipDzEvRdQtwRHTIVVfIZXrmKlmYkVA1g4KUsRUtRolyP
         +Ju+4tGxmm/lV65DXCa9KqCc3eH9sCrShdZW7U5ppMwIi0SS9TQ3Z7hVuSw6Ppb1+Wl9
         KBqjCgyiGkfXGgJvd8PobOi1y9YvUtytlAjgv5aZd7GQo0cop9s/OtdIO8bU2/1fTizb
         f/T2LQrbwLxKM2bndbx61/1d/Y10kcy+Kduj+kSmW0dMvzQYTCDm/Si3i1KKtlfbtpTG
         rKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5wi31mwXwtNZbe8Gf39XkK5bj6O5hjqeJphNJYhsUC8=;
        b=uJUhGfRjDnUqSDqVg22MgtH2vso3x9++okEvVHRYreqZ9VyscBm8Ta680omUWcFnyn
         fBnejg9ASKdIysJu/NoO1huRV3HYHCsa9GwIlXWO+tMmBAA7nW1WaZhyWx0e7KZMEtLh
         eF1p5ZYNqMN44AC0vBALnHApjEnmHIw7KU7cd8+z39mIdPXol186L9kvAfOhTL1zNWcL
         9/zTDHDrvI6rl0wL05sqyqIpFEFTmnDYPPaLSIddVAhb4VfQxn8sto7wIIiaJqoG+o9I
         kl8aK3Rf0Of46Pev4vJBUh3T3RtFCmEk25iuCfH1MG+bwvMDafIibybUW5oAuEoWstpQ
         3LgA==
X-Gm-Message-State: AOAM533ufe0xmkNoQg1AJjXt4wQvgVC8dOm6BRgFvc/mPLw7cMhUnCNZ
        QwoAEA/bzkH2JFN+a+GSYwg=
X-Google-Smtp-Source: ABdhPJzKtPuyA1NFsL8yd4dLlqvyXIelgWwGM237Umug73iaO8YfIcf86WWlkTWiLDXot6G4gINd5Q==
X-Received: by 2002:a17:90a:7345:: with SMTP id j5mr1408988pjs.48.1630554020557;
        Wed, 01 Sep 2021 20:40:20 -0700 (PDT)
Received: from localhost ([2402:800:63b8:c1e5:7ba1:cab2:978b:f7f6])
        by smtp.gmail.com with ESMTPSA id y12sm364540pjm.42.2021.09.01.20.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 20:40:20 -0700 (PDT)
Date:   Thu, 2 Sep 2021 10:40:18 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Maksym Sobolyev via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matheus Tavares <matheus.bernardino@usp.br>,
        Maksym Sobolyev <sobomax@gmail.com>,
        Maksym Sobolyev <sobomax@sippysoft.com>
Subject: Re: [PATCH v3] Make ident dynamic, not just a hardcoded value of
 "$Id".
Message-ID: <YTBHk+cS7WluKGL2@danh.dev>
References: <pull.1074.v2.git.git.1629952119446.gitgitgadget@gmail.com>
 <pull.1074.v3.git.git.1630462385587.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1074.v3.git.git.1630462385587.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-09-01 02:13:05+0000, Maksym Sobolyev via GitGitGadget <gitgitgadget@gmail.com> wrote:
> diff --git a/convert.h b/convert.h
> index 5ee1c322058..2422e289784 100644
> --- a/convert.h
> +++ b/convert.h
> @@ -76,11 +76,16 @@ enum convert_crlf_action {
>  
>  struct convert_driver;
>  
> +struct ident_action {
> +	const char *id;
> +	size_t id_len;
> +};

Just out of curiousity, can we use strbuf instead of inventing new
structure for this one? This struct is purely a string representation?


-- 
Danh
