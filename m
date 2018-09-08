Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E04501F404
	for <e@80x24.org>; Sat,  8 Sep 2018 08:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeIHNhM (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 09:37:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54941 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbeIHNhM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 09:37:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so16771621wmb.4
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2REwnqQYIpM6PPrBV02wwD0O4+lyR88DVxQh2rL2fbA=;
        b=PSu3uxhEex+x+S9XlONxh6N33dp+99stTxldcURD+6NTQx5TjHfufqrwtrnZTevdIk
         JTAFqnMwKN49GmFo3BuhcrVs0+fDe5si9PEU6V8+1nV2hy0YKGQ1h5bqm5lwzIXbA4oz
         yeuGixUt29tlzKyIoUu8v/pAJP+UYmcNlU1wXLRKfuJQE2SabckrTrgO7+O8pJ1se5b3
         5UXeExzKrgj0A3v9P3zN7/zebRJkt4XfCG8aGmRIRgT4HSH6Gvkpc4nErHL+J+gZI5aR
         qUhJwVsN7zcz9bAJdRdvKj6nIbkXvxQ1YJaxuliOQ0rEzofQZdT2FJruof/XhX4S9LvA
         MNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2REwnqQYIpM6PPrBV02wwD0O4+lyR88DVxQh2rL2fbA=;
        b=FI1Zyd0/xRehsetY06fZ6Kwx4U2s5Wywh2/03BZJg+h0M8oJfV623wtwoGuPUqkzbH
         VpH4C35a75GLQOyrI8OZGQLMbT7hWsKVEYILk9N38oYgdMCNPXribQOnDYDXXoOvLIZh
         2Jbw+83NyFAaCB/LQ0cD2jixzIMJ/kxbZiSa1idnb9jfHfcYPHrs7UhGt4/fuIPK4p2J
         dE55npDorm5VyC+UPjdhiel3bN3r/d6FfplDTx1BaMufYq0Qrpgrbl2i1on6vY68HKx9
         kH1coFPfxja2chvNQgezhJ/r3ahMTFKu/2YysYgNiiYFcpBhzAEILUKujTjt1683iTQi
         nTkg==
X-Gm-Message-State: APzg51As7XKNubBCb+v9XxNSuy17lTHDFXsNU0lmSX1/xlsETet2/Ujj
        dr6XnRhXoJr6jLo44XhZ/24=
X-Google-Smtp-Source: ANB0Vda6CCVZ3qRoxtH/w+bK22heIryEg0Ph/0AWOxxdQK44idDhyFxTPNsUBCX6JbDpJmbJdt+HyQ==
X-Received: by 2002:a1c:7d51:: with SMTP id y78-v6mr7254050wmc.37.1536396730369;
        Sat, 08 Sep 2018 01:52:10 -0700 (PDT)
Received: from localhost (x4db2bdac.dyn.telefonica.de. [77.178.189.172])
        by smtp.gmail.com with ESMTPSA id d12-v6sm13080337wru.36.2018.09.08.01.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 01:52:09 -0700 (PDT)
Date:   Sat, 8 Sep 2018 10:52:07 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Pratik Karki via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 10/11] builtin rebase: only store fully-qualified refs
 in `options.head_name`
Message-ID: <20180908085207.GB10370@localhost>
References: <20180808134830.19949-1-predatoramigo@gmail.com>
 <pull.32.v2.git.gitgitgadget@gmail.com>
 <aab01f0b8e15db37bc17630b4298148aeacf41e2.1536096424.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aab01f0b8e15db37bc17630b4298148aeacf41e2.1536096424.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 04, 2018 at 02:27:20PM -0700, Pratik Karki via GitGitGadget wrote:
> From: Pratik Karki <predatoramigo@gmail.com>
> 
> When running a rebase on a detached HEAD, we currently store the string
> "detached HEAD" in options.head_name. That is a faithful translation of
> the shell script version, and we still kind of need it for the purposes of
> the scripted backends.
> 
> It is poor style for C, though, where we would really only want a valid,
> fully-qualified ref name as value, and NULL for detached HEADs, using
> "detached HEAD" for display only. Make it so.
> 
> Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/rebase.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index d45f8f9008..afc75fe731 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c

> @@ -575,7 +579,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  				branch_name = options.head_name;
>  
>  		} else {
> -			options.head_name = xstrdup("detached HEAD");
> +			free(options.head_name);
> +			options.head_name = NULL;

Please use FREE_AND_NULL(options.head_name) here.

>  			branch_name = "HEAD";
>  		}
>  		if (get_oid("HEAD", &options.orig_head))
> -- 
> gitgitgadget
> 
