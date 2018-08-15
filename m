Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98D411F404
	for <e@80x24.org>; Wed, 15 Aug 2018 16:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbeHOTYZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 15:24:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38270 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbeHOTYY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 15:24:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14-v6so1632035wro.5
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Vdd6m5eT0Lamdger85MmVUxG8hdULPR0lk9NZF0U8lE=;
        b=H0N0O5f9wzvj9S6oLD/GSp8i7vChlwgBygALD14uHet54HbB8014ZE/F+w59SJgppW
         /Gdx92Yvdy7tw+RfwWc7hrEN1HOo4tUJa/IcnDv9uz5qYJxzr3APfjwlyOtxK8xgb1NY
         UUa+YfE+TYtKu4vq1zUH46bsn3u2Cnndych9Vp2oRKFU2sUcracXYh3l2iQjBwQW+Qei
         Xkwgp38XNvKA/Oamp0nJDTTTmY8xwsQWmhcJhQc0Y+2TLKsVBMDvHHR85mPSwu/Vg1Fq
         NIH66JxsQGYvnvLvXQpEFJIWFEtQiygnrRu2fsK0fx40WyEmlRY4lhBeKP7yjTEtbafV
         ArYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Vdd6m5eT0Lamdger85MmVUxG8hdULPR0lk9NZF0U8lE=;
        b=So357+2yVteeoo6TlI1bfzACRzZyYm2G1K3uk1tEDczkVMNjA24dMbxONmEf2Nx/E7
         PdLuvvXGLr0T9Kfy41oBRYIus/O8WmIwwybNuE/ind/LcZRRjfCw4dVMqgYON/3OCA74
         yRv/FgjVO5RIFv8760LryO1yLxtefvyvI2Hn0r0V4h/rapjvraDw/ZVFxl4yCt1HpkxW
         MaPOcU4rhOi+OLUrsdbPf+SQ9To04jIXoCY9W4q/ZRrPzzQTJ8o87DohH+x+yL9mFnfC
         M7J50RNy7yz8UX40BFJMupC3/W76Q25lQO3SZfc1rw3AQsoGNsZiMe0fBAVUuCUu2KMs
         ioYg==
X-Gm-Message-State: AOUpUlHqwDzgObeE/X9LwPp7gza9xWekialPhJkGblx8IuFZMUd16Vnm
        gnJuOhj/BUk1M4ctU6WREbE=
X-Google-Smtp-Source: AA+uWPwjeDQlu0u/BIyezkIwAptir7GRUjyPL89HF0sZiGAl7guxG3zeRw14sZsRnLXi8yhiw9nxPQ==
X-Received: by 2002:adf:ac66:: with SMTP id v93-v6mr15813987wrc.7.1534350693027;
        Wed, 15 Aug 2018 09:31:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h7-v6sm23233735wrs.8.2018.08.15.09.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 09:31:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] chainlint: fix for core.autocrlf=true
References: <pull.19.git.gitgitgadget@gmail.com>
        <d0d1d49d6f3e741e9c048041a2f467742bce4bdc.1534343621.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Aug 2018 09:31:32 -0700
In-Reply-To: <d0d1d49d6f3e741e9c048041a2f467742bce4bdc.1534343621.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 15 Aug 2018
        07:33:44 -0700 (PDT)")
Message-ID: <xmqqmutnk2vv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `chainlint` target compares actual output to expected output, where
> the actual output is generated from files that are specifically checked
> out with LF-only line endings. So the expected output needs to be
> checked out with LF-only line endings, too.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/.gitattributes | 1 +
>  1 file changed, 1 insertion(+)

Good spotting.  A help like this from those on different platforms
than what the original author uses is the ideal model of how we
collaborate together.

Will queue.

>
> diff --git a/t/.gitattributes b/t/.gitattributes
> index 3bd959ae5..9d09df5a6 100644
> --- a/t/.gitattributes
> +++ b/t/.gitattributes
> @@ -1,4 +1,5 @@
>  t[0-9][0-9][0-9][0-9]/* -whitespace
> +/chainlint/*.expect eol=lf
>  /diff-lib/* eol=lf
>  /t0110/url-* binary
>  /t3900/*.txt eol=lf
