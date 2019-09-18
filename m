Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 302F51F463
	for <e@80x24.org>; Wed, 18 Sep 2019 20:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389570AbfIRUCL (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 16:02:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43774 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389565AbfIRUCK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 16:02:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id h126so762329qke.10
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gFW9z18oHwuj4s8FDdBeDVEBhXpEJCRfdUQnRSQMYFw=;
        b=FgI1hoH6gc8NtUppgDmSX4q5RpdptfPIZtSzLZAiCVAYKwy7uemD1X1/Bi0akrV+VK
         PamCyAri5C63g5qeWXipBrFIS+sk7SYhUwcmTBelSA1TEFGDPtxCudAQCJ24oTPE6Npd
         HNqi1AfFYL3uy65AEu5TeizrXd5ZUPlQJ4Ri9zZFWSmwPKSnFGZ35dHEhl5d/ApQx3Su
         MYEGIUt32VpJk6eDbatkNj4gUr2fIBPlR/7Tk7+zd14D8+8Rjy/jqe/kMdhq+0cr+PDL
         vC/RhqIgoDZZAqiVrKwQBjW2sNamFHH4UQMze2toJI9bAyxYI3MdaSwUOfwmkvlcG5HQ
         w/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gFW9z18oHwuj4s8FDdBeDVEBhXpEJCRfdUQnRSQMYFw=;
        b=XqndEu46uZr3aOm+wZzD8+2GD1sd7gokN0jI/Zr8nKOc2PJjGxLf7gELoScsbb8YmV
         VbhKRSmAZ4EnC6LXxibIFNzqEdcRKx6KTjkLaKaxcvgPfXZsvjqZ1FT7tbT79x/S1x8/
         x9nK2wc/tkst5RJk/I/T3nMsgQZcGqP+jzYgm86aoPhWhF/kSb129oSzoD8q3RyLKdX8
         +xrYI/1fouhN15gVckVdC3b4DxCOMAprDJ493Q5c123YVYMW032naNc1iGVj52QJsJC5
         ocE2gaPcc70Wi5qqNw8A5K7JZetjPqA3Y5nl2YbPWzP36HG3WJYAqWpjabtvKEvSzzko
         rllA==
X-Gm-Message-State: APjAAAWFXw25aCXFZlM5Vhh07EUeas6e7klKs69ktI0P9P2kCUMJwjwv
        X+RbA6Cq/UQ5RgaKpwODnig=
X-Google-Smtp-Source: APXvYqwrtu37LDbvlqSTdgb2CtFyUkr3BaEGZouJAl+Xwnp8qTVsPPWLr4KAxOY051hFSDXazt8NYA==
X-Received: by 2002:a37:4049:: with SMTP id n70mr6326477qka.326.1568836929750;
        Wed, 18 Sep 2019 13:02:09 -0700 (PDT)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id p199sm3380771qke.18.2019.09.18.13.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 13:02:09 -0700 (PDT)
Subject: Re: [PATCH] sha1_name: simplify strbuf handling in
 interpret_nth_prior_checkout()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <582d8659-dd5e-440e-6f00-a59c7017dff6@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9a7e07ea-dd88-b1f0-125a-bc0f2a6d1fe9@gmail.com>
Date:   Wed, 18 Sep 2019 16:02:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <582d8659-dd5e-440e-6f00-a59c7017dff6@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/18/2019 12:35 PM, René Scharfe wrote:
> Pass the target strbuf to the callback function grab_nth_branch_switch()
> by reference so that it can add the result string directly instead of
> having it put the string into a temporary strbuf first.  This gets rid
> of an extra allocation and a string copy.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Patch formatted with --function-context for easier reviewing.

I appreciate this. I needed to look through the whole method to see that
previously "buf" was used to take the resulting value on a successful
parse.

>  sha1-name.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/sha1-name.c b/sha1-name.c
> index c665e3f96d..85196929c7 100644
> --- a/sha1-name.c
> +++ b/sha1-name.c
> @@ -1286,70 +1286,67 @@ static int get_oid_oneline(struct repository *r,
> 
>  struct grab_nth_branch_switch_cbdata {
>  	int remaining;
> -	struct strbuf buf;
> +	struct strbuf *sb;
>  };
> 
>  static int grab_nth_branch_switch(struct object_id *ooid, struct object_id *noid,
>  				  const char *email, timestamp_t timestamp, int tz,
>  				  const char *message, void *cb_data)
>  {
>  	struct grab_nth_branch_switch_cbdata *cb = cb_data;
>  	const char *match = NULL, *target = NULL;
>  	size_t len;
> 
>  	if (skip_prefix(message, "checkout: moving from ", &match))
>  		target = strstr(match, " to ");
> 
>  	if (!match || !target)
>  		return 0;
>  	if (--(cb->remaining) == 0) {
>  		len = target - match;
> -		strbuf_reset(&cb->buf);
> -		strbuf_add(&cb->buf, match, len);
> +		strbuf_reset(cb->sb);
> +		strbuf_add(cb->sb, match, len);
>  		return 1; /* we are done */

It seems that now "buf" is still only being replaced on a successful parse, since
this strbuf_reset and strbuf_add is happening only on a return 1, which terminates
the refs_for_each... method.

>  	}
>  	return 0;
>  }
> 
>  /*
>   * Parse @{-N} syntax, return the number of characters parsed
>   * if successful; otherwise signal an error with negative value.
>   */
>  static int interpret_nth_prior_checkout(struct repository *r,
>  					const char *name, int namelen,
>  					struct strbuf *buf)
>  {
>  	long nth;
>  	int retval;
>  	struct grab_nth_branch_switch_cbdata cb;
>  	const char *brace;
>  	char *num_end;
> 
>  	if (namelen < 4)
>  		return -1;
>  	if (name[0] != '@' || name[1] != '{' || name[2] != '-')
>  		return -1;
>  	brace = memchr(name, '}', namelen);
>  	if (!brace)
>  		return -1;
>  	nth = strtol(name + 3, &num_end, 10);
>  	if (num_end != brace)
>  		return -1;
>  	if (nth <= 0)
>  		return -1;
>  	cb.remaining = nth;
> -	strbuf_init(&cb.buf, 20);
> +	cb.sb = buf;
> 
>  	retval = refs_for_each_reflog_ent_reverse(get_main_ref_store(r),
>  			"HEAD", grab_nth_branch_switch, &cb);
>  	if (0 < retval) {
> -		strbuf_reset(buf);
> -		strbuf_addbuf(buf, &cb.buf);
>  		retval = brace - name + 1;
>  	} else
>  		retval = 0;
> 
> -	strbuf_release(&cb.buf);
>  	return retval;
>  }
> 

The reaction in this method appears correct, too.

Thanks,
-Stolee

