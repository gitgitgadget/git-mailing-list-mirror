Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEBAC433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 13:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B952207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 13:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amqkGLCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgHDNIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgHDNIf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 09:08:35 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDDBC06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 06:08:35 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id w9so30758429qts.6
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 06:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HmZuk8mjxTvPnqqk3yoyQF84g4zLY6gwsqcWj1ZzCfk=;
        b=amqkGLCMISUL96wbMGjUHlvU1rGaRexyPugvwDjM2yRRajf92to2GOMNKzAtvb09/B
         LCzHBGBmMe+Jfy1I04lMNpz8Ki1oYOUkglSIcVWpy1QoSvIymeW+6fqA6M2pEZVqqld7
         28SPTxIkGq9rNvTLbk4+zfvHoBHY/cvtQdjq6jkb7Zqrn0cguWddjPXSo5qfHBxQrlZN
         MJDYPEBuZ6oeWet7+8hP9na4+pun7ABmHZLU9dMwKPXqL3B0J8iFSV0ZfzE7pN9OXdwV
         M/1U39be/wYbhP1kpvR9+atX4HdCcMFbU7Sp/5/ObkKRTJr0J5WRuHa6anKRUjBknPhQ
         Vlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HmZuk8mjxTvPnqqk3yoyQF84g4zLY6gwsqcWj1ZzCfk=;
        b=Gi6AWyLrVU2Va+ZmUPiI8eE74ChRODjpYxaQTsRZoKNBbfzxMts6oLGQmwKaGFqE+O
         BG+Eh1JFMW2ijQcPFQK51yxJnG7XB9vQPpjP2CfLu+nrX/aPgM68bmGJkzfvuvk/jc60
         L3iXqAruOCIkvHJ4gjh3YIDquD9XJxIKjacj8ezB369ao3peee7Agtg64y33XCQrX/Vl
         We8BijtX3xkJCshXbiFhKdqxBkYwLcPnyqPqwRZ6vAGOn36u1yVq/xAKQSWcznA3MuOA
         zOrPRkhV5Xzy9K/bf3D4pujoUzOT52GZ6P0v3uSUbWk7iyAEF4qe3EjHvIIW16SVq3n9
         7alA==
X-Gm-Message-State: AOAM53101eKjdmx+EShIkgEqDOn5CVJdswmZkGcZnBB76CxMq3okt0uc
        0thZzVIc59MYeIgZPkH7xxE=
X-Google-Smtp-Source: ABdhPJwJSHPmAEln+4cqHJJ+bcx6yvi5QAX7bMnAVFw+OZ3oxA9jMtWvKbS3Knb3F9LDsdAhrRwH1A==
X-Received: by 2002:ac8:1c6c:: with SMTP id j41mr22011860qtk.226.1596546514298;
        Tue, 04 Aug 2020 06:08:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:359e:33e7:c1bc:799? ([2600:1700:e72:80a0:359e:33e7:c1bc:799])
        by smtp.gmail.com with ESMTPSA id h144sm21194233qke.83.2020.08.04.06.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 06:08:33 -0700 (PDT)
Subject: Re: [PATCH 2/3] revision: avoid out-of-bounds read/write on empty
 pathspec
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
References: <20200804074146.GA190027@coredump.intra.peff.net>
 <20200804074652.GB284046@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f05b2a13-d8c6-62c4-4efd-90cba216b263@gmail.com>
Date:   Tue, 4 Aug 2020 09:08:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200804074652.GB284046@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2020 3:46 AM, Jeff King wrote:
> Running t4216 with ASan results in it complaining of an out-of-bounds
> read in prepare_to_use_bloom_filter(). The issue is this code to strip a
> trailing slash:
> 
>   last_index = pi->len - 1;
>   if (pi->match[last_index] == '/') {
> 
> because we have no guarantee that pi->len isn't zero. This can happen if
> the pathspec is ".", as we translate that to an empty string. And if
> that read of random memory does trigger the conditional, we'd then do an
> out-of-bounds write:
> 
>   path_alloc = xstrdup(pi->match);
>   path_alloc[last_index] = '\0';
> 
> Let's make sure to check the length before subtracting. Note that for an
> empty pathspec, we'd end up bailing from the function a few lines later,
> which makes it tempting to just:
> 
>   if (!pi->len)
>           return;
> 
> early here. But our code here is stripping a trailing slash, and we need
> to check for emptiness after stripping that slash, too. So we'd have two
> blocks, which would require repeating some cleanup code.
> 
> Instead, just skip the trailing-slash for an empty string. Setting
> last_index at all in the case is awkward since it will have a nonsense
> value (and it uses an "int", which is a too-small type for a string
> anyway). So while we're here, let's:
> 
>   - drop last_index entirely; it's only used in two spots right next to
>     each other and writing out "pi->len - 1" in both is actually easier
>     to follow
> 
>   - use xmemdupz() to duplicate the string. This is slightly more
>     efficient, but more importantly makes the intent more clear by
>     allocating the correct-sized substring in the first place. It also
>     eliminates any question of whether path_alloc is as long as
>     pi->match (which it would not be if pi->match has any embedded NULs,
>     though in practice this is probably impossible).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Another variant is to actually stop assigning revs->bloom_filter_settings
> so early, so that we don't have to clean it up. And then once we're sure
> we're going to use it and have passed all of our early-return checks,
> then assign it. But that conflicts with the get_bloom_filter_settings()
> patch in:
> 
>   https://lore.kernel.org/git/08479793c1274d5ee0f063578bb0f4d93c910fa9.1596480582.git.me@ttaylorr.com/
> 
> so I didn't go that way.
> 
>  revision.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/revision.c b/revision.c
> index 6de29cdf7a..5ed86e4524 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -669,7 +669,6 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  	struct pathspec_item *pi;
>  	char *path_alloc = NULL;
>  	const char *path, *p;
> -	int last_index;
>  	size_t len;
>  	int path_component_nr = 1;
>  
> @@ -692,12 +691,10 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  		return;
>  
>  	pi = &revs->pruning.pathspec.items[0];
> -	last_index = pi->len - 1;
>  
>  	/* remove single trailing slash from path, if needed */
> -	if (pi->match[last_index] == '/') {
> -		path_alloc = xstrdup(pi->match);
> -		path_alloc[last_index] = '\0';
> +	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
> +		path_alloc = xmemdupz(pi->match, pi->len - 1);
>  		path = path_alloc;
>  	} else
>  		path = pi->match;

This change has the advantage of looking simpler than the previous
implementation. Thanks.

-Stolee
