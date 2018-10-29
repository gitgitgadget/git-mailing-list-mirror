Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D2971F453
	for <e@80x24.org>; Mon, 29 Oct 2018 12:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbeJ2U7K (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 16:59:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42456 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbeJ2U7K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 16:59:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id y15-v6so8402289wru.9
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 05:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AsKaXAM+E5G+lZ53DQUaQHr49S6/8QYMd+dH+so0QEA=;
        b=Vt9He9jBqVeIWMnY0nGle7suNAnnZqg0XURIUMQwixqcdbC2lmFVD3oK/ErA930mrV
         /HevggbROt3n1MZ0EZbBdBboOunm6wg7uw+9sQYOFP/Qes/Wgomx1L03JQ/+7yOXSwhA
         DEoulfia+tqXLN9gHY49bsEDvtydJ7JQK7mmWN42VicOa5KT4Zr7QztbeA0dmQEVKAv9
         id7SMecrjVB1Vlplqm9gelgnQeaD8fofY7g7iz9P9GvYtuG+Qf7GBIzH7QDlOmkIqgOB
         7b6nhU6oTeTyRyXppuPp4xcf90vX9eq8DiRs2zmX2vT4j5pM5OI+YtA4dYT1ePBKWq8Y
         Vp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AsKaXAM+E5G+lZ53DQUaQHr49S6/8QYMd+dH+so0QEA=;
        b=KIXsmITXeRxn8pcnnKBCze4iX8xzzTKwBhUbi0C2YhV6l3FhWME4Pk1+7TJ5lWXxRD
         5P3ik6+aOmNuvv+nccusSjZjfHvKCLE7w5fgqbpuDZCuf/z0znI4WjjCO5eDkWl/iogk
         I6xnpnrzwPStbmc0wyTw8O9oe2CzUa1xCAqLI/iSlXL2I/GHbOLRhlUh3Aih62uun4uI
         /uaBO+a9OTNZwgNRXQZUeKfHQ+XHcaO7lYAd94Uo5AeLCjkQt15Fdqm7uRaLeRRepFKk
         h8GcOczjHNtvF+G/qzBsmGp+i+VRivZGmEJvkKYIJszFyoCllyRLgdR26H9tMcZ/HdjU
         IcbA==
X-Gm-Message-State: AGRZ1gLq0LmZDgZ9/3I/99YwR5QLPnuwnle5+u5xKLlmV+U0UUzRMYjQ
        1fj7Tuils9GFzy339aTZcHw=
X-Google-Smtp-Source: AJdET5fo1jiHLdSh4HxDinX5dOBiZWYQhxzRE52K6Rvb/jq2QYBZ8GshcNAXWiQr2hInva5erFW2Og==
X-Received: by 2002:adf:c6c7:: with SMTP id c7-v6mr14942069wrh.243.1540815044516;
        Mon, 29 Oct 2018 05:10:44 -0700 (PDT)
Received: from szeder.dev (x4d0c66d6.dyn.telefonica.de. [77.12.102.214])
        by smtp.gmail.com with ESMTPSA id o17-v6sm30995986wro.2.2018.10.29.05.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 05:10:43 -0700 (PDT)
Date:   Mon, 29 Oct 2018 12:10:41 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com
Subject: Re: [PATCH] packfile: close multi-pack-index in close_all_packs
Message-ID: <20181029111041.GQ30222@szeder.dev>
References: <20181025111557.GL30222@szeder.dev>
 <20181025125405.30351-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181025125405.30351-1-dstolee@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 25, 2018 at 12:54:05PM +0000, Derrick Stolee wrote:
> Whenever we delete pack-files from the object directory, we need
> to also delete the multi-pack-index that may refer to those
> objects. Sometimes, this connection is obvious, like during a
> repack. Other times, this is less obvious, like when gc calls
> a repack command and then does other actions on the objects, like
> write a commit-graph file.
> 
> The pattern we use to avoid out-of-date in-memory packed_git
> structs is to call close_all_packs(). This should also call
> close_midx(). Since we already pass an object store to
> close_all_packs(), this is a nicely scoped operation.
> 
> This fixes a test failure when running t6500-gc.sh with
> GIT_TEST_MULTI_PACK_INDEX=1.
> 
> Reported-by: Szeder Gábor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
> 
> Thanks for the report, Szeder! I think this is the correct fix,
> and more likely to be permanent across all builtins that run
> auto-GC. I based it on ds/test-multi-pack-index so it could easily
> be added on top.

OK, avoiding those errors in the first place is good, of course...
However, I still find it disconcerting that those errors didn't cause
'git gc' to error out, and, consequently, what other MIDX-related
errors/bugs might do the same.

> -Stolee
> 
>  packfile.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/packfile.c b/packfile.c
> index 841b36182f..37fcd8f136 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -339,6 +339,11 @@ void close_all_packs(struct raw_object_store *o)
>  			BUG("want to close pack marked 'do-not-close'");
>  		else
>  			close_pack(p);
> +
> +	if (o->multi_pack_index) {
> +		close_midx(o->multi_pack_index);
> +		o->multi_pack_index = NULL;
> +	}
>  }
>  
>  /*
> 
> base-commit: 0465a50506023df0932fe0534fe6ac6712c0d854
> -- 
> 2.17.1
> 
