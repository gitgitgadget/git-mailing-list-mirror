Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAB8C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 13:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1DBB207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 13:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTIlWMYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgHDNJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgHDNJY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 09:09:24 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5449C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 06:09:23 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j187so38212416qke.11
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 06:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8N7I257PCNm9pa9iVS6FdBNYygb+cIm2ETeEyYYVQV0=;
        b=dTIlWMYmKCZAeq5yv71cFDVb+uS+h3V0Q3zTI/RvqN4bWmlFQofu6/9J3p75C0sAL4
         FA8FMlI+G5fHOWPYt2U8jhK0bZfybuxRkw5uP0+AbBMyRr+Y2tI3dYHsPL0DTZj8BAPy
         CxbOeQbmDCa/b51fiIn65GZo57yEWZ8ht6zwTWfdxK8D7cgxT35vah6xvPDDp5AK9yI6
         W4dMrmE025g18594srzbb70hNtcxa+WTsZmOsVFT5KlACUU6zqV/C2adMQ5wOj2/YKdF
         X7BG6SCG0gAfQ6BtBdnnmhpOyk6tbXZXHeRLrKcbaiRCWMCkMXwTxeXnqq5fsPyd8Brg
         e4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8N7I257PCNm9pa9iVS6FdBNYygb+cIm2ETeEyYYVQV0=;
        b=Ry+nTNjf7Yv/n/DwARCNELkuANnrQcyrmuIFgpNlnrQLCGN2/FsrHMrxfsGuyNtvF0
         zxcP0hozhSMKegY4H3TlsXP43RHRz4bAQC5VAoXcGlSj5kOWMvAXzJkxw8TYh7cdCbam
         S7q8SvynJeI0CdrugLUai21dSW03Sh8cGHjER43RTEdHfWEn/n6JifOpPjQfpmIhVLyY
         6ljOH7cZ3HtUt6zPmn3f5wjuHOYwjBwo5k1liE+F7eQPIN8oZ926bE23qaTNt6JLq3dO
         kduPZUSHO4qyBNW1ZG/k+ga6iul17mweA04jTqphhQjQvP16lUWKjQ0s+5tvx0ylE7wt
         1mrQ==
X-Gm-Message-State: AOAM533hGSBdx7PT9nisxPWBSPp5wSQ3IyX7oq4RvR/c7zDhyMR3aNs9
        CDcr7TLzwbFUWSb7USk8QdU=
X-Google-Smtp-Source: ABdhPJwqUL5kI0l1bEsJ+0RbANhpbPxYgJWvA4QKBqRMzpdOnC0hUmNgtuWj4ZVdl6tSKou7sJmHCg==
X-Received: by 2002:a37:9c7:: with SMTP id 190mr17147042qkj.303.1596546562807;
        Tue, 04 Aug 2020 06:09:22 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:359e:33e7:c1bc:799? ([2600:1700:e72:80a0:359e:33e7:c1bc:799])
        by smtp.gmail.com with ESMTPSA id n6sm22065587qkh.74.2020.08.04.06.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 06:09:22 -0700 (PDT)
Subject: Re: [PATCH 3/3] revision: avoid leak when preparing bloom filter for
 "/"
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
References: <20200804074146.GA190027@coredump.intra.peff.net>
 <20200804075017.GC284046@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5159cfbb-55a4-8010-66a3-f6b4e4b05d7e@gmail.com>
Date:   Tue, 4 Aug 2020 09:09:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200804075017.GC284046@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2020 3:50 AM, Jeff King wrote:
> If we're given an empty pathspec, we refuse to set up bloom filters, as
> described in f3c2a36810 (revision: empty pathspecs should not use Bloom
> filters, 2020-07-01).
> 
> But before the empty string check, we drop any trailing slash by
> allocating a new string without it. So a pathspec consisting only of "/"
> will allocate that string, but then still cause us to bail, leaking the
> new string. Let's make sure to free it.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Just noticed while reading the function to fix the previous patch.
> 
> I'm not even sure if it's possible to get here with a pathspec of "/",
> since we'd probably give a "/ is outside repository" error before then.
> 
> So maybe this case doesn't even matter. If it doesn't, then it might
> simplify the function a bit to do the empty-pathspec check before
> handling trailing slashes. But handling it does help make it more clear
> this function is doing the right thing no matter what input it is given,
> so that's what I went with here.

Works for me. Thanks for your careful attention here.

-Stolee

>  revision.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/revision.c b/revision.c
> index 5ed86e4524..b80868556b 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -702,6 +702,7 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  	len = strlen(path);
>  	if (!len) {
>  		revs->bloom_filter_settings = NULL;
> +		free(path_alloc);
>  		return;
>  	}
>  
> 

