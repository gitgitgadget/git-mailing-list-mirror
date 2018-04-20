Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 026201F404
	for <e@80x24.org>; Fri, 20 Apr 2018 17:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeDTReO (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 13:34:14 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35578 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeDTReN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 13:34:13 -0400
Received: by mail-wr0-f196.google.com with SMTP id w3-v6so24950142wrg.2
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EVO7DsXFUh8enVMbR4Ci0ua4wETPgHF7Tm6JAofFf64=;
        b=ABCWgAsin6JsEjmsfGQczQ1gB1Vu4sUrYFLXWfJjhPu7vbliG4V9e3fjL5atKClk5W
         scO0ksrDKC+Z1o9fw/vJgWuadZ+PiUoH7XulaXKaGRLd/u5BDWaN3GyvjYnmMPVqFdLo
         j5ornqY5Dffe5lQEZbYN3f6/O0DvDJ3LgLplq6H8EGRcA/jzy/jDQxNutCfsGeUHqgQE
         OYTaPoPXB3fz29lt4kI4WhNmXMi70IlXFaTJd5KtuO40q86adE6RVnZ1T1CauKaiRvG9
         fvPAvW4tr4RWKy6qqKbMix9AW2XmMiuxeRvP0ZwDJA5rAvLZKUbyivL4tqlBXA3Au8pZ
         R7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=EVO7DsXFUh8enVMbR4Ci0ua4wETPgHF7Tm6JAofFf64=;
        b=fXXEf+L+zua06zT4So/gAXTrKHAEesABHuWnKqB44HqFRYqe7+H3ayewRn67bmNyx8
         SxyAUaqwVvIGVpz8WxAIbXbcIQ0P382tQ5mc+vVRkqu8GmWfRN7IjFW3X6avtph+yA7I
         OOi18nwH0B4Htxq0OH4ss1x+WON0iKg8QL6RBylr10qDFVRUzbUPy7jJ2B6GdhuC4jFv
         TEyLuafgCkKAL0D07GxkGj6ML6kUUTJvJpfT+QNQSQK0tj08smrFiim4Hh2awaspUSb1
         VLfiWzfSiqKZt2ivXqJuAQ8WIVSaqkvLBeRs7dV8odqOHCzr1ejWGJhrjt4yy3HclWKD
         FIrg==
X-Gm-Message-State: ALQs6tBbx2xzAJeSDf7EOncqiAo3icoEhgcG7SRKJc/Hpvc4dwy4ln/W
        c5R+29IDpIvKZgz72Wjwwg4=
X-Google-Smtp-Source: AIpwx4/V0AeVW+F72ZpPalNQu/cvpp8S/ORcmhVma7ncDzpwntFRg56v8voKQkVayEBnsHLn0uSg6w==
X-Received: by 10.28.245.13 with SMTP id t13mr2671265wmh.129.1524245652366;
        Fri, 20 Apr 2018 10:34:12 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egc153.neoplus.adsl.tpnet.pl. [83.21.66.153])
        by smtp.gmail.com with ESMTPSA id b13sm2348596wmi.42.2018.04.20.10.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 10:34:11 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 11/12] gc: automatically write commit-graph files
References: <20180417181028.198397-1-dstolee@microsoft.com>
        <20180417181028.198397-12-dstolee@microsoft.com>
Date:   Fri, 20 Apr 2018 19:34:11 +0200
In-Reply-To: <20180417181028.198397-12-dstolee@microsoft.com> (Derrick
        Stolee's message of "Tue, 17 Apr 2018 18:10:45 +0000")
Message-ID: <86wox1dbos.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The commit-graph file is a very helpful feature for speeding up git
> operations. In order to make it more useful, write the commit-graph file
> by default during standard garbage collection operations.
>
> Add a 'gc.commitGraph' config setting that triggers writing a
> commit-graph file after any non-trivial 'git gc' command.

Other than the question if 'gc.commitGraph' and 'core.commitGraph'
should be independent config variables, and the exact wording of the
git-gc docs, it looks good to me.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-gc.txt | 4 ++++
>  builtin/gc.c             | 8 ++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 571b5a7e3c..17dd654a59 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -119,6 +119,10 @@ The optional configuration variable `gc.packRefs` determines if
>  it within all non-bare repos or it can be set to a boolean value.
>  This defaults to true.
>  
> +The optional configuration variable 'gc.commitGraph' determines if
> +'git gc' runs 'git commit-graph write'. This can be set to a boolean
> +value. This defaults to false.
> +
>  The optional configuration variable `gc.aggressiveWindow` controls how
>  much time is spent optimizing the delta compression of the objects in
>  the repository when the --aggressive option is specified.  The larger

[...]
