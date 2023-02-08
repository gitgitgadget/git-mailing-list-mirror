Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A672C636D3
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 21:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjBHVGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 16:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjBHVGH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 16:06:07 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D79DBEE
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 13:05:54 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id i2so295615ple.13
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 13:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+OC7HuB/NZMid7aban/vArT5Tk15PGky0eZn0CP8H5c=;
        b=jnZD7SM05SjeExskbHYJaMhB6uvvDt6YfsMdGkkRSnPoMFeBRrPv2+KWU/tAEPOjTC
         k4nI6VwenPoPk2tg8acYQ9vTNEZL/2Pc9YV+dV4m/Sey/wpnmyVfFPnxrSj5XJVUiNGX
         KE8ubY6YWnTymlWVkJA/mkTaROd6VK+1huUE4R9L2rn33sn64Auavdr+pSErPMwWXWwJ
         aWI3HgSQi9tgksmPpP1xC2LQpuhISx8iJE6zECT5xbW8afMLKinixEgCbELDLwmpQZls
         iY6zEtOebBlhFZJ+eWB+ARrBuBj3L18+6J+Mc+v1t5lzaQCP78l2CxLFEh+/5nnXbuLt
         Gpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OC7HuB/NZMid7aban/vArT5Tk15PGky0eZn0CP8H5c=;
        b=btbyc2aNvcTJSuS7AaaMX6d0bh1wGz8d42QGwoyT2g0U8swTHCEWZoNt7gYw/2ZSCX
         MMaB8cbYCnKQDzHCkbA9JxTln335ZCeIhhSNGCbBuA3oNO7oS9/KzuyKnHXBfn9sgNEP
         Zs8O7ThWovU2gaJPxuT+irabJzH7exAidLSco62PzEdSOqGDVJZy/GRQb7xKlrxIgfZi
         sFOFidMCAcTSe4QZD8f3Muq+fW1iUVWASimZ+o4tGbRniswG43DA7qAwqR6a4hmldDyc
         Cbes2Gbj3MClM9FVGEz3mbJhazgJCRUiSMlEtoA8rA0xfxDTMASPmEY0wzJPKw4rySV3
         Ca6w==
X-Gm-Message-State: AO0yUKVfstp90EcE74dReBjtgzzpjhpwTSDbc0wTUrssrdi35jPVG7pM
        X45xVXEutysK/ayY7PghMQsQ
X-Google-Smtp-Source: AK7set+UAVXiOnhu/rFkxhmtpPQRWVI04v8I2oDk+HVCmThpqxjt7x1Zjx6BorlLmqhXrRlhnn1dOA==
X-Received: by 2002:a17:902:e9c2:b0:199:2185:230c with SMTP id 2-20020a170902e9c200b001992185230cmr2608074plk.15.1675890354256;
        Wed, 08 Feb 2023 13:05:54 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b0019904abc93dsm7822390pld.250.2023.02.08.13.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 13:05:53 -0800 (PST)
Message-ID: <983fc35b-55e8-50df-5035-191a10b4ddac@github.com>
Date:   Wed, 8 Feb 2023 13:05:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v8 2/3] http: read HTTP WWW-Authenticate response headers
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
 <cd9a02ba94e9eb59b07d0b95140d5b880f122941.1675711789.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <cd9a02ba94e9eb59b07d0b95140d5b880f122941.1675711789.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
> diff --git a/git-compat-util.h b/git-compat-util.h
> index a76d0526f79..f11c44517d7 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1266,6 +1266,28 @@ static inline int skip_iprefix(const char *str, const char *prefix,
>  	return 0;
>  }
>  
> +/*
> + * Like skip_prefix_mem, but compare case-insensitively. Note that the
> + * comparison is done via tolower(), so it is strictly ASCII (no multi-byte
> + * characters or locale-specific conversions).
> + */
> +static inline int skip_iprefix_mem(const char *buf, size_t len,
> +				   const char *prefix,
> +				   const char **out, size_t *outlen)
> +{
> +	size_t prefix_len = strlen(prefix);
> +	if (len < prefix_len)
> +		return 0;
> +
> +	if (!strncasecmp(buf, prefix, prefix_len)){
> +		*out = buf + prefix_len;
> +		*outlen = len - prefix_len;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  static inline int strtoul_ui(char const *s, int base, unsigned int *result)
>  {
>  	unsigned long ul;
> diff --git a/http.c b/http.c
> index 8a5ba3f4776..7a56a3db5f7 100644
> --- a/http.c
> +++ b/http.c
> @@ -183,6 +183,124 @@ size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
>  	return nmemb;
>  }
>  
> +/*
> + * A folded header continuation line starts with at least one single whitespace
> + * character. It is not a continuation line if the line is *just* a newline.
> + * The RFC for HTTP states that CRLF is the header field line ending, but some
> + * servers may use LF only; we accept both.
> + */
> +static inline int is_hdr_continuation(const char *ptr, const size_t size)
> +{
> +	/* totally empty line or normal header */
> +	if (!size || !isspace(*ptr))
> +		return 0;
> +
> +	/* empty line with LF line ending */
> +	if (size == 1 && ptr[0] == '\n')
> +		return 0;
> +
> +	/* empty line with CRLF line ending */
> +	if (size == 2 && ptr[0] == '\r' && ptr[1] == '\n')
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
> +{
> +	size_t size = eltsize * nmemb;
> +	struct strvec *values = &http_auth.wwwauth_headers;
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *val;
> +	size_t val_len;
> +
> +	/*
> +	 * Header lines may not come NULL-terminated from libcurl so we must
> +	 * limit all scans to the maximum length of the header line, or leverage
> +	 * strbufs for all operations.
> +	 *
> +	 * In addition, it is possible that header values can be split over
> +	 * multiple lines as per RFC 2616 (even though this has since been
> +	 * deprecated in RFC 7230). A continuation header field value is
> +	 * identified as starting with a space or horizontal tab.
> +	 *
> +	 * The formal definition of a header field as given in RFC 2616 is:
> +	 *
> +	 *   message-header = field-name ":" [ field-value ]
> +	 *   field-name     = token
> +	 *   field-value    = *( field-content | LWS )
> +	 *   field-content  = <the OCTETs making up the field-value
> +	 *                    and consisting of either *TEXT or combinations
> +	 *                    of token, separators, and quoted-string>
> +	 */
> +
> +	/* Start of a new WWW-Authenticate header */
> +	if (skip_iprefix_mem(ptr, size, "www-authenticate:", &val, &val_len)) {
> +		strbuf_add(&buf, val, val_len);
> +
> +		/*
> +		 * Strip the CRLF that should be present at the end of each
> +		 * field as well as any trailing or leading whitespace from the
> +		 * value.
> +		 */
> +		strbuf_trim(&buf);
> +
> +		strvec_push(values, buf.buf);
> +		http_auth.header_is_last_match = 1;
> +		goto exit;
> +	}
> +
> +	/*
> +	 * This line could be a continuation of the previously matched header
> +	 * field. If this is the case then we should append this value to the
> +	 * end of the previously consumed value.
> +	 */
> +	if (http_auth.header_is_last_match && is_hdr_continuation(ptr, size)) {
> +		/*
> +		 * Trim the CRLF and any leading or trailing from this line.
> +		 */
> +		strbuf_add(&buf, ptr, size);
> +		strbuf_trim(&buf);
> +
> +		/*
> +		 * At this point we should always have at least one existing
> +		 * value, even if it is empty. Do not bother appending the new
> +		 * value if this continuation header is itself empty.
> +		 */
> +		if (!values->nr) {
> +			BUG("should have at least one existing header value");
> +		} else if (buf.len) {
> +			char *prev = xstrdup(values->v[values->nr - 1]);
> +
> +			/* Join two non-empty values with a single space. */
> +			const char *const sp = *prev ? " " : "";
> +
> +			strvec_pop(values);
> +			strvec_pushf(values, "%s%s%s", prev, sp, buf.buf);
> +			free(prev);
> +		}
> +
> +		goto exit;
> +	}
> +
> +	/* This is the start of a new header we don't care about */
> +	http_auth.header_is_last_match = 0;
> +
> +	/*
> +	 * If this is a HTTP status line and not a header field, this signals
> +	 * a different HTTP response. libcurl writes all the output of all
> +	 * response headers of all responses, including redirects.
> +	 * We only care about the last HTTP request response's headers so clear
> +	 * the existing array.
> +	 */
> +	if (!strncasecmp(ptr, "http/", 5))
> +		strvec_clear(values);

I found this updated version of 'fwrite_wwwauth()' (using
'skip_iprefix_mem()', 'is_hdr_continuation()', and 'strncasecmp()') a bit
easier to read than previous iterations - possibly because all the
prefix-skipping is done before adding to 'buf', so 'buf' represents *only*
the line's header value (possibly with leading/trailing whitespace, which is
trimmed). Plus, avoiding unnecessary allocations is always nice. 

> +
> +exit:
> +	strbuf_release(&buf);
> +	return size;
> +}

