Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6745C761A6
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 15:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjC3PXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 11:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjC3PXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 11:23:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E743ED50F
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 08:22:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u38so12753406pfg.10
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 08:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680189711;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ObpfzPEr4Lfb5yeLcPjj2hwKA4yX+eN34vW7TlH0o4=;
        b=BIiMUBsRyozZSEMF7Wun1ATqxV2ttz/E18S6YkJ0/5hy3xSjZD24v3OpcNTSg9FMBm
         QDQdQS9NvIb+yW35wqLlRPdx3E8+CEjNLfcesuKVzlmVVIUvzptAHZr3xrjkc1lhO+Nb
         nATNK/F8OssuNC7NgQW1+HNQtI9CUXVJiIFFp5bAPOOQ+AG94zY47D+97VBqGJcYZYAg
         D9naRjW7bWYgXNfDJXi4wwPBZFlFZFl2Zkq4p7H45ifxYuqEJIgfKFUVVO7DEUEwklBS
         pPRm/kMEpOVeYpuK837asSu1MVWzvITBKe5CFngMd60XBw3XoIOOO4ypyHBRhRE7aU7L
         c7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680189711;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ObpfzPEr4Lfb5yeLcPjj2hwKA4yX+eN34vW7TlH0o4=;
        b=jM6nLPtaqpe/KApWc7YOKPUBukEwj9TYe6IrQXjNO2v1h6k0WNI5ZQqa0TDwtvb7dC
         dgYDWYztHutuxlB2NoWGJ6sRs9+ucDx/eXFcSyzbVd5QzMm7aYuiKG4FnXP08x4skQa3
         nritymNU550TLsNwO67eGSgDKiN7qqKFLwLmbfktH56kMcCK5rXPZbsZLdk9VDGVghvg
         fXnoxxyh/dAe5l8JIFIC6mhgMuzuJaDRJ7GjAOurErbRc0DJO4foYmZL42RTRTbi7qJw
         RjW+AKaiFgPnY6wujiFh64OxX0wv9Ddc87skPzrM5bDQRVitKohNBLRkcFIq2huzZM04
         QC7g==
X-Gm-Message-State: AAQBX9dVKhXqBg3DWx7T3M1rCFNCC458T6ckD/gxw4huPZ6DTMP2PYA6
        Lj/r2y0atxGAL9Nd3NePXJc=
X-Google-Smtp-Source: AKy350bunLP1wyYGSTysRqFqvrp27x+pBI+yxV+OLCuthOTYtUPNsfvBhjU6qQgiEd5d1TeTzaEumw==
X-Received: by 2002:a62:4e05:0:b0:5cb:eecd:387b with SMTP id c5-20020a624e05000000b005cbeecd387bmr21235998pfb.33.1680189711291;
        Thu, 30 Mar 2023 08:21:51 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id a24-20020a62e218000000b00627f2f23624sm21326651pfi.159.2023.03.30.08.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:21:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] ref-filter: remove unused ref_format member
References: <20230330112133.4437-1-oystwa@gmail.com>
        <20230330112133.4437-2-oystwa@gmail.com>
Date:   Thu, 30 Mar 2023 08:21:43 -0700
In-Reply-To: <20230330112133.4437-2-oystwa@gmail.com> (=?utf-8?Q?=22=C3=98?=
 =?utf-8?Q?ystein?= Walle"'s
        message of "Thu, 30 Mar 2023 13:21:32 +0200")
Message-ID: <xmqqo7oa2rjs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Øystein Walle <oystwa@gmail.com> writes:

> use_rest was added in b9dee075eb (ref-filter: add %(rest) atom,
> 2021-07-26) but was never used. As far as I can tell it was used in a
> later patch that was submitted to the mailing list but never applied.
>
> Signed-off-by: Øystein Walle <oystwa@gmail.com>
> ---
> Would be nice to have a link to the email thread here, but I don't know
> how.


Here is a link to the patch that led to that commit you cited:

https://lore.kernel.org/git/207cc5129649e767036d8467ea7c884c3f664cc7.1627270010.git.gitgitgadget@gmail.com/

It indeed is cumbersome to add, as the Message-Ids for patches from
GitGitGadget tend to be ultra long.

But b9dee075eb was the last one in the 5-patch series; I do
not see any "later patch there in the thread.

>  ref-filter.h | 1 -
>  ref-filter.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/ref-filter.h b/ref-filter.h
> index aa0eea4ecf..0f4183233a 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -75,7 +75,6 @@ struct ref_format {
>  	const char *format;
>  	const char *rest;
>  	int quote_style;
> -	int use_rest;
>  	int use_color;
>  
>  	/* Internal state to ref-filter */
> diff --git a/ref-filter.c b/ref-filter.c
> index ed802778da..20e0a72f24 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -596,7 +596,6 @@ static int rest_atom_parser(struct ref_format *format,
>  {
>  	if (arg)
>  		return err_no_arg(err, "rest");
> -	format->use_rest = 1;
>  	return 0;
>  }
