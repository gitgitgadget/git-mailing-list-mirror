Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E63C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 11:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjARLsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 06:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjARLqS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 06:46:18 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C306C53B37
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 03:07:43 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id az20so63242473ejc.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 03:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=grvmAS4FNNAVuY66MCe4GKU1XCPJ3NpOEO57ZLA4aoc=;
        b=Pl/KfxMd+qiJ/q4oENuFLfLcHicCDWNEtrHvI1kONpK7jwzz0mk+nXjtk+1l5vNnwZ
         rtUOplBkwUs0o0rbJF55GmW+lkvOdxC9RyaBpc+vZfhqmEMROCQ+42OGa0F9NigQ5mJ2
         q+SwUgi2gicL90+LFUtJrA4RoqggzR+XnJqv2bRZqzEWYGQYQtLngMgmZZMOMoTYC9Q4
         4lNYoAU0i7ROUJtSDYckXPdkbYJBtA0tSsaatk6V3DQJdI9re+qSmU3a1TPLa4OmJ7Zs
         ZKFXHy0Fcgmldvrag3cpUhDsG0VfMTBohvn7mIyyySAoqslWAFSZm0/VvimIz2IJ1vcW
         jYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grvmAS4FNNAVuY66MCe4GKU1XCPJ3NpOEO57ZLA4aoc=;
        b=5urZyk7iojAZbTHtxifG4uPSQU8Jz784zUObt6T599MlfyguVuL5dyDR3OUPEQaGKc
         Hqjh5sPdm5j8h09qR8AU816QzqhhtOTlP5VTdqfgusEiBZZ4bryDZkcaDfwWjKxxxq1N
         GcmbM/DqAzQL+NTvTnNNct95ASuyQys+onmYoZZCfk1yFx225w3grdfK50RatLxJRn0F
         CEzIH7Vm7rPqDcriavxge5c3NzllYOUM8c8mKCus+KQOtCHHsDuN7OhsC/v3oMv6MMa0
         hYFR5MweEpJkG7b1EODtbUq5ZeUVnpIa2+H47C6lfGOiLzvzU6Xtvn+sCo+rJnjpqi+S
         nBug==
X-Gm-Message-State: AFqh2kocdnVLUn6zdbNFm9+GiFOLDmDwjhkntgXbvDjkmfkoZPWzWwuo
        ay8TkzXT712XH/xlNfG7eAKk1PQMzPhx/A==
X-Google-Smtp-Source: AMrXdXvWWEyO9wmUEkoIF+mWobSteIJ6ELptSWzhm/yHy8PrYlbo9V3JClDjwFh8Y1CScEIw88/Nwg==
X-Received: by 2002:a17:907:d492:b0:7aa:491c:6cdf with SMTP id vj18-20020a170907d49200b007aa491c6cdfmr2912447ejc.18.1674040061743;
        Wed, 18 Jan 2023 03:07:41 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id fs37-20020a170907602500b0086ffe3a99f9sm4236489ejc.82.2023.01.18.03.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 03:07:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pI6I8-002nlL-0t;
        Wed, 18 Jan 2023 12:07:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v6 04/12] test-http-server: add stub HTTP server test
 helper
Date:   Wed, 18 Jan 2023 12:04:24 +0100
References: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <d6e5e8825e8454242820738f0dfb03a9f1c01ced.1674012618.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <d6e5e8825e8454242820738f0dfb03a9f1c01ced.1674012618.git.gitgitgadget@gmail.com>
Message-ID: <230118.86k01kxfr7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 18 2023, Matthew John Cheetham via GitGitGadget wrote:

> From: Matthew John Cheetham <mjcheetham@outlook.com>
> [...]
> +enum worker_result {
> +	/*
> +	 * Operation successful.
> +	 * Caller *might* keep the socket open and allow keep-alive.
> +	 */
> +	WR_OK       = 0,
> [...]
> +	enum worker_result wr = WR_OK;
> +
> +	if (client_addr)
> +		loginfo("Connection from %s:%s", client_addr, client_port);
> +
> +	set_keep_alive(0, logerror);
> +
> +	while (1) {
> +		if (write_in_full(STDOUT_FILENO, response, strlen(response)) < 0) {
> +			logerror("unable to write response");
> +			wr = WR_IO_ERROR;
> +		}
> +
> +		if (wr != WR_OK)
> +			break;
> +	}
> +
> +	close(STDIN_FILENO);
> +	close(STDOUT_FILENO);
> +
> +	return !!(wr & WR_IO_ERROR);
> +}

We have cases where we assign "0" to a bitfield-looking structure like
this, but only in cases where we're planning to use it as a boolean too.

Or, in other cases where we want some to be explicitly <-1.

Here though we're adding a mixed "OK" and error use, which seems a bit
odd. Shouldn't we pick one or the other?

So far (maybe in later commits?) nothing uses WR_HANGUP, and oddly we
also use the bitfield-looking thing as a return value from main()....
