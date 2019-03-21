Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D635120248
	for <e@80x24.org>; Thu, 21 Mar 2019 09:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfCUJV7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 05:21:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34625 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfCUJV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 05:21:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id a16so4392104edn.1
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=VFru44UET/QxSnRW+hHc94nDa79BjZoNo5Ay2fkTlFw=;
        b=dWEuxJsViRYh6HQFJzvQYd0ZE/AT1Q9IHxTqcz5Ff5h/rhN9HuTas+jUPYOybZpw58
         +6pEVYvIvyIzNQA97c5CRW98eMvMfaRmMpolvX2IuqeRt4SkJ8l14AR6i7Pf+hil1vkd
         zcKmcJifk+eGSpbj4iUek7iaDgBWGyxDQkhrchs0+iC/SP22LkTRKgdv44XrZPX0MnOI
         fTtsBqCQGP7FkaoJbN0DDx8HHZM6JWG8efXcwK0RyjOdVtN7NIpUVck3Uz1nJjhxX428
         5lQtzCNk4ZIoiK+51Ap2PQz89D/00Pl7Nr6Stzhb6vwLuOpGehX3aqmYq0RqzLVSYH7v
         cSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=VFru44UET/QxSnRW+hHc94nDa79BjZoNo5Ay2fkTlFw=;
        b=WvewiqDkKitL/pDbPNldmj+fn/luT6alD33wXsUpt80yWoIJPmeSLrPA2Tk/tZVVjn
         oxWeO37yj2Ydqb4YPrFINeI2bh8uToP8cM3MU31jl97GMtBgZf8Nag2/DoGwrhvJ9eSJ
         c3IKibFWgEptg9W/nIeJl0/vWGwSM+t5xRUHljQiFu94UwfC2zmuoIzUYM5KW4h9t7tS
         8EgxlRgYTfzJdrglJVI83zm5VMWdfxedLeCvym4ODZDBSXfPwg4oqY+vcirVX346coLi
         HU0s4/n8x9J93H2j1A2uNsIrZEEnsZ2cMy+5e/ZEBjhdk2dpkf5rMNOCOIj4/ecWlg0x
         KNIQ==
X-Gm-Message-State: APjAAAXI71ILEFFaA8jUaEydXffwon5z/6vr26zYO1NN3gjut6/FKGNZ
        nIkLe0s42w/G96GDbc2KVAs=
X-Google-Smtp-Source: APXvYqyz499hFYpc+7gzAPStjs+hzbGCeZvYbKx7Kqobbc5phkYrioHYBmIce2XsamxpvedA607goA==
X-Received: by 2002:a17:906:2a9b:: with SMTP id l27mr1714936eje.89.1553160117638;
        Thu, 21 Mar 2019 02:21:57 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id e2sm933271ejc.53.2019.03.21.02.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 02:21:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 5/6] commit-graph: implement file format version 2
References: <pull.112.git.gitgitgadget@gmail.com> <c55e0a738c79c30affcf2cb68564c01c36c66dff.1548280753.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <c55e0a738c79c30affcf2cb68564c01c36c66dff.1548280753.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Mar 2019 10:21:55 +0100
Message-ID: <87tvfwd1l8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 23 2019, Derrick Stolee via GitGitGadget wrote:

>  	graph_version = *(unsigned char*)(data + 4);
> -	if (graph_version != 1) {
> -		error(_("graph version %X does not match version %X"),
> -		      graph_version, 1);
> +	if (!graph_version || graph_version > 2) {
> +		error(_("unsupported graph version %X"),
> +		      graph_version);
>  		goto cleanup_fail;
>  	}

Just noticed this while writing
https://public-inbox.org/git/87va0cd1zp.fsf@evledraar.gmail.com/ i.e. to
resolve the conflict with my commit-graph segfault fixing series.

This really should be something like:

	/* earlier */
	#define GRAPH_MAX_VERSION 2

	if (!graph_version || graph_version > GRAPH_MAX_VERSION) {
		error(_("commit-graph unsupported graph version %X, we support up to %X"),
			graph_version, GRAPH_MAX_VERSION);

Also, I'm confused as to what these patches are based on. Your is doing
"!= 1", but on "master" and ever since 2a2e32bdc5 ("commit-graph:
implement git commit-graph read", 2018-04-10) this has been the macro
"GRAPH_VERSION" instead of "1".
