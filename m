Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E636201A7
	for <e@80x24.org>; Mon, 15 May 2017 19:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965046AbdEOTb3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 15:31:29 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36041 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933207AbdEOTb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 15:31:28 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so67896656pfg.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 12:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cyp3OfukQVuLz9FS+42Lr4JygZ/69gRSbMpNhGxCnbM=;
        b=cYdUEuXPWrDKx8PxFxuPVZlco0ZrRqswRqWSh16B3v9KNNZuCSPV+sJ5CZiZ5NIon7
         sKruEokKJa7FmqfXIorCulKOMNd1rtR8mJDelLXFXxQLMlCAfAq7yomnK24Vwvb4lFzb
         dLMOF4heDRG20Wh8DfPw70GtrcKt84HrUX4rhZK9qlYvPBmLzfktyEpQ7r+HSjDFZUF1
         wr6nlk077UUTH6XBsO1FzVTycVATSV91h8Isge2xs9FoFjzvrlA6ZxLw6TWwrNBl4j2T
         93GzGz41SsAHAd1aw5HpfskcPKGuVHtH4Uduf8xm2cyFwlcPFY2/lIK2P7R11a88BOjt
         yGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cyp3OfukQVuLz9FS+42Lr4JygZ/69gRSbMpNhGxCnbM=;
        b=lYo6YblzmBPxAeb91/JL7/BDyhJHzGv6xzqIlblHV2gGejJoZ6g+yn7a8uBnbkAP0O
         8wyD5ZInel4KY/Occ9dAMP0JmE4MulWxrzEqK+3hLtmS0V2GwTZFxy7wikLOM8nD7rD5
         KHxFUFIlX5doJmjY/kNfmOIkhbsdWCDgqQgpOpSjOGqlSFDUqigzar4IbX7t4tlExXEN
         21YoYxGNNeAtX4V+Nd05Es8sDdO+36ljtOKcm56tBYXtjzRhpig9cICaoG//p0FYplcZ
         5V5QkMJMupWCpvztQHOC01Osyr6tv2HsxdG5jDApBE+chGYnx9KzmnDieS4SP7ttatZV
         2hpQ==
X-Gm-Message-State: AODbwcC7QlNUXPap2Sv1LlAjzx0bKa1Y0nsZjMv3TpLEqYeV22K5UMms
        05lRFDcWShX1zBP+7wwrfA==
X-Received: by 10.84.236.67 with SMTP id h3mr10554778pln.86.1494876687294;
        Mon, 15 May 2017 12:31:27 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:8923:f8dd:f0f0:f864])
        by smtp.gmail.com with ESMTPSA id u9sm22787053pgn.55.2017.05.15.12.31.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 12:31:26 -0700 (PDT)
Date:   Mon, 15 May 2017 12:31:24 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, peff@peff.net,
        gitster@pobox.com, mhagger@alum.mit.edu, jrnieder@gmail.com
Subject: Re: [PATCH 06/19] diff: add emit_line_fmt
Message-ID: <20170515193124.GC79147@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170514040117.25865-7-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170514040117.25865-7-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/13, Stefan Beller wrote:
> In the following patches we'll convert all printing functions to use
> the emit_line_* family of functions.
> 
> Many of the printing functions to be converted are formatted. So offer
> a formatted function in the emit_line function family as well.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/diff.c b/diff.c
> index 48f0fb98dc..aef159a919 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -552,6 +552,20 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
>  	emit_line_0(o, set, reset, 0, line, len);
>  }
>  
> +static void emit_line_fmt(struct diff_options *o,
> +			  const char *set, const char *reset,
> +			  const char *fmt, ...)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	va_list ap;
> +	va_start(ap, fmt);
> +	strbuf_vaddf(&sb, fmt, ap);
> +	va_end(ap);
> +
> +	emit_line(o, set, reset, sb.buf, sb.len);
> +	strbuf_release(&sb);
> +}
> +
>  static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
>  {
>  	if (!((ecbdata->ws_rule & WS_BLANK_AT_EOF) &&
> -- 
> 2.13.0.18.g183880de0a
> 

Since this is a new function, and it is marked static, this patch
shouldn't compile or the compiler should throw a warning or something.

-- 
Brandon Williams
