Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC311201A7
	for <e@80x24.org>; Mon, 15 May 2017 19:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966488AbdEOTWt (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 15:22:49 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35988 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966483AbdEOTWq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 15:22:46 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so67793537pfg.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 12:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mICcQp7OGYGd3d8EfifjTSa4BL15czvobta16wPvRzY=;
        b=PDoImLUvnXZG05KgbDigu6LWAQgZye5B/Tq2zEEisvCYYg+51IpahwbMfaZWGRDk8x
         uKj6AcrtNdU5phAVAG10Ja+b+zO8wSGJso0iHXYWdNyJmGKT5E8X6LhHNowOSXPIEiWf
         UipZSFZTP3zJb9cd8fINC7wMXp4gvGNrTrL9+Y96vwcr/4bma+RMGYBzLW9chMuejP38
         /3BJeD26f/jRmGxLgHoT4hcCJNiAMDKMRem/RhVb4eiAI3GSRgZW1EGwODg6urYOIt/J
         5TWC6ZJAVbsogNM7zNneHi6KumXH8/M7xsTLXPYdO4TSeeBkJgoaCzR97snaBJ+nLtsG
         7ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mICcQp7OGYGd3d8EfifjTSa4BL15czvobta16wPvRzY=;
        b=cyK0KYPAHhQFbMpQaVOSSk489Bghlae6f7QeNBHpapmqZ4914vFK93fjIR83EbH7+G
         c2PpVhce2dl0rpAYtKH/JvWODWS3wOtfOkUUF1f1tR21nrPrGQJs85Q0D32kuN+TLylZ
         U8gfm7+Ry2oa8Fmb3UK7GCUyeIdnfUNu5mJn/ObSCByl4bD1E232+DYE/I+YDVOjWvPb
         SQj74ZZ1R2or24lwlXHiXAGKjYKH+P0qivyahpyZ3Sr5RjDV0BSn4bUumbvzcvZTZ1rK
         GTm0jgsP6jke+gFLjKGPMt4vnSIs7zltNA/IquqDh4Pwpxjsu+40jtx6MqHm7bTspFDT
         Xpkg==
X-Gm-Message-State: AODbwcAttO+P/3jY0VxTLwNAwSLsdLOw4q8PLd1E0qos7zXhc4xlv8O3
        kAy+/UIV+r1NXcdE
X-Received: by 10.99.113.20 with SMTP id m20mr7719045pgc.120.1494876164999;
        Mon, 15 May 2017 12:22:44 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:8923:f8dd:f0f0:f864])
        by smtp.gmail.com with ESMTPSA id l7sm28789206pgn.10.2017.05.15.12.22.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 12:22:44 -0700 (PDT)
Date:   Mon, 15 May 2017 12:22:42 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, peff@peff.net,
        gitster@pobox.com, mhagger@alum.mit.edu, jrnieder@gmail.com
Subject: Re: [PATCH 03/19] diff.c: drop 'nofirst' from emit_line_0
Message-ID: <20170515192242.GB79147@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170514040117.25865-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170514040117.25865-4-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/13, Stefan Beller wrote:
> In 250f79930d (diff.c: split emit_line() from the first char and the rest
> of the line, 2009-09-14) we introduced the local variable 'nofirst' that
> indicates if we have no first sign character. With the given implementation
> we had to use an extra variable unlike reusing 'first' because the lines
> first character could be '\0'.
> 
> Change the meaning of the 'first' argument to not mean the first character
> of the line, but rather just containing the sign that is prepended to the
> line. Refactor emit_line to not include the lines first character, but pass
> the complete line as well as a '\0' sign, which now serves as an indication
> not to print a sign.
> 
> With this patch other callers hard code the sign (which are '+', '-',
> ' ' and '\\') such that we do not run into unexpectedly emitting an
> error-nous '\0'.
> 
> The audit of the caller revealed that the sign cannot be '\n' or '\r',
> so remove that condition for trailing newline or carriage return in the
> sign; the else part of the condition handles the len==0 perfectly,
> so we can drop the if/else construct.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index c2ed605cd0..4269b8dccf 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -517,33 +517,24 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
>  }
>  
>  static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
> -			int first, const char *line, int len)
> +			int sign, const char *line, int len)
>  {
>  	int has_trailing_newline, has_trailing_carriage_return;
> -	int nofirst;
>  	FILE *file = o->file;
>  
>  	fputs(diff_line_prefix(o), file);
>  
> -	if (len == 0) {
> -		has_trailing_newline = (first == '\n');
> -		has_trailing_carriage_return = (!has_trailing_newline &&
> -						(first == '\r'));
> -		nofirst = has_trailing_newline || has_trailing_carriage_return;
> -	} else {
> -		has_trailing_newline = (len > 0 && line[len-1] == '\n');
> -		if (has_trailing_newline)
> -			len--;
> -		has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
> -		if (has_trailing_carriage_return)
> -			len--;
> -		nofirst = 0;
> -	}
> +	has_trailing_newline = (len > 0 && line[len-1] == '\n');
> +	if (has_trailing_newline)
> +		len--;
> +	has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
> +	if (has_trailing_carriage_return)
> +		len--;

Does the order of newline/carriage return always the same?

>  
> -	if (len || !nofirst) {
> +	if (len || sign) {
>  		fputs(set, file);
> -		if (!nofirst)
> -			fputc(first, file);
> +		if (sign)
> +			fputc(sign, file);
>  		fwrite(line, len, 1, file);
>  		fputs(reset, file);
>  	}
> @@ -556,7 +547,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
>  static void emit_line(struct diff_options *o, const char *set, const char *reset,
>  		      const char *line, int len)
>  {
> -	emit_line_0(o, set, reset, line[0], line+1, len-1);
> +	emit_line_0(o, set, reset, 0, line, len);
>  }
>  
>  static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
> @@ -4822,9 +4813,12 @@ void diff_flush(struct diff_options *options)
>  
>  	if (output_format & DIFF_FORMAT_PATCH) {
>  		if (separator) {
> -			fprintf(options->file, "%s%c",
> -				diff_line_prefix(options),
> -				options->line_termination);
> +			char term[2];
> +			term[0] = options->line_termination;
> +			term[1] = '\0';
> +
> +			emit_line(options, NULL, NULL,
> +				  term, 1);
>  			if (options->stat_sep) {
>  				/* attach patch instead of inline */
>  				fputs(options->stat_sep, options->file);
> -- 
> 2.13.0.18.g183880de0a
> 

-- 
Brandon Williams
