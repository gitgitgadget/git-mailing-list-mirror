Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F25248865
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404254; cv=none; b=pg64a3Udv4e1b1HdHixWla0cz7OUeUo4zrqZ2fQxLN+N5961zMU+/v8fO3JThemWlxvsJw1rdsmTcmHD0wLDNc3HheszMbZ62pRHA0p8qisYlEUaPJa/K/lfQq1RzeJGMDHdwv7m3TWue+aq31bjujHmBfPjZ3gEtoU/HMMuQi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404254; c=relaxed/simple;
	bh=FgRLGl6l7p1baqq69NXhEnVh3K675DRVpMNACrMT1sE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnUkOm5nXoqzXq5HYLhLTHpbpreXkjcL8dWMEbx2x7ko6xT5YTvNPBjZIF9ASXkvT0EaKF2rbbGRShRHSQ+XEFzSLV7RWmT9TMWDGUDv6AGU8BU+i4wGucwFUjetiIIXM6+V31T01VTEdBNw34RR9RNN8l/S9jARdNfLwb+pJKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ka4TejOv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka4TejOv"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220c665ef4cso74474875ad.3
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 05:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740404250; x=1741009050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mRCFlPuLaCrlHyA010fUJADxuDVAPqAxejK8cQBwSyo=;
        b=ka4TejOvNzsCYpBs+1FWKCCzyLbAwo4aXwrrE7aHxmPGd6oHvb+tzqwC7trhv5yTzy
         tXokbq4yGA1EiLEyLkL+Gvm8Bd2mBIih3ydOkdVee3ECTsRTo7DV2VU1uFU+AqmkH74e
         EaThNRdPOcsK+QcvO5e9smNNxP8QEGtCrFrggWhuXy/GjJA2R9gcJMkAEQxLCfb0wIcO
         KBxcqN82K+Tp5VU+m6YBSf4lwvH3yNZz2jAv5S3vsb71mC24bJKp6p9ds2SHMJQJfYix
         UrwM1G6+SUZO700F7Lh66koyXuzJKVfyHD0EA7EnH/E9xImSE1GpyQAP6ktUbNU5WZx+
         vKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740404250; x=1741009050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRCFlPuLaCrlHyA010fUJADxuDVAPqAxejK8cQBwSyo=;
        b=b48Uym2EJebmNJh5Zy2akTYduAkPheAYGsc8XW4sZIkiJFIsVBx5YTZpl3B4V6ebX7
         bELPjNtYjVHjCccoTmnLr+PDo3a0boLe3QoqLQU6+zjLByDFn50foh+8mOK79+BZldMu
         PH9Gt5gc4jkpvujerWeBrVm5nBet1SH2MS8DB3JdlV2Fjb3PX3DdSZ+nUReY75E66zw0
         BMNEAQbFJ8KmBm3uaalS8fZUuJcVZukopI7OJk5X3ujqF9iMe5EmFGndEQ/agd5Qi3M5
         68Oojf69cIRg3GCj+t2QHu81vxVtNQZJ2EtFAWA39opaTSVABrEo+50i51rQm1HYNBe7
         cNrg==
X-Gm-Message-State: AOJu0YytaqB7xbGsYuoheeP/xak1H1Yw2mliKFAwEA95bVU0kHAZs+7U
	0VT/RLSJ8I/aKgDy1rm0ZcT6QCwv0NR9FCzVlqE9jXd18rcqvdIW
X-Gm-Gg: ASbGncsFrIkOlAnaMyUtWFm+ldUgsnZPGUEKomuWugiX8aNKnqODYoNtuCpTTSnAYfQ
	sjOd/gh+WPFhEHgoGNLCy1R+jUIDSnJabQsi8kEPoADtO9gSXbQx360zxCnjojM9WAWNY0PpgHK
	+2om1R4F9dmpE35pXqBDxibXB95QJRDsDWXf63T25/w4I78q3X6UAKzbgSA16txypvYazfxZg1f
	M/i3YRFJG/+9G8roeFO1w++vqOj3U+YL3mtrhAL1rKzp/rWDDc0nCq9kc6GfUKRaTalTiGT6uKf
	SlvESBPaZTj0EEEN1oVG5w==
X-Google-Smtp-Source: AGHT+IFwv/AhbDRitzrxTSlGerI/x+coHND7odQW2VAdh9ogA/FzvIGSs5ccUlkOQHW6VdK1aBR+CA==
X-Received: by 2002:a05:6a20:2591:b0:1ee:b8bc:3d2e with SMTP id adf61e73a8af0-1eef3c55d28mr26592921637.8.1740404249850;
        Mon, 24 Feb 2025 05:37:29 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-add286bc8e8sm16691860a12.39.2025.02.24.05.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 05:37:29 -0800 (PST)
Date: Mon, 24 Feb 2025 21:37:36 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 11/16] refs/iterator: implement seeking for merged
 iterators
Message-ID: <Z7x2IEdRP4fzdXMo@ArchLinux>
References: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
 <20250219-pks-update-ref-optimization-v2-11-e696e7220b22@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219-pks-update-ref-optimization-v2-11-e696e7220b22@pks.im>

On Wed, Feb 19, 2025 at 02:23:38PM +0100, Patrick Steinhardt wrote:
> Implement seeking on merged iterators. The implementation is rather
> straight forward, with the only exception that we must not deallocate
> the underlying iterators once they have been exhausted.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/iterator.c | 38 +++++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/refs/iterator.c b/refs/iterator.c
> index 757b105261a..63608ef9907 100644
> --- a/refs/iterator.c
> +++ b/refs/iterator.c
> @@ -96,7 +96,8 @@ int is_empty_ref_iterator(struct ref_iterator *ref_iterator)
>  struct merge_ref_iterator {
>  	struct ref_iterator base;
>  
> -	struct ref_iterator *iter0, *iter1;
> +	struct ref_iterator *iter0, *iter0_owned;
> +	struct ref_iterator *iter1, *iter1_owned;

We would always free `iter0_owned` and `iter1_owned`. That's the reason
why in the below code, we could drop `ref_iterator_free`. Make sense.

[snip]

> +static int merge_ref_iterator_seek(struct ref_iterator *ref_iterator,
> +				   const char *prefix)
> +{
> +	struct merge_ref_iterator *iter =
> +		(struct merge_ref_iterator *)ref_iterator;
> +	int ret;
> +
> +	iter->current = NULL;
> +	iter->iter0 = iter->iter0_owned;
> +	iter->iter1 = iter->iter1_owned;
> +
> +	ret = ref_iterator_seek(iter->iter0, prefix);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ref_iterator_seek(iter->iter1, prefix);
> +	if (ret < 0)
> +		return ret;

We could simply use a single `if` statement to handle this. Is the
reason why we design this is that we want to return the exact error code
for each case?

> +
> +	return 0;
> +}
> +
>  static int merge_ref_iterator_peel(struct ref_iterator *ref_iterator,
>  				   struct object_id *peeled)
>  {
> @@ -242,12 +261,13 @@ static void merge_ref_iterator_release(struct ref_iterator *ref_iterator)
>  {
>  	struct merge_ref_iterator *iter =
>  		(struct merge_ref_iterator *)ref_iterator;
> -	ref_iterator_free(iter->iter0);
> -	ref_iterator_free(iter->iter1);
> +	ref_iterator_free(iter->iter0_owned);
> +	ref_iterator_free(iter->iter1_owned);

We free the internal pointer but not the pointer exposed to the caller.
Make sense.

>  }
>  
>  static struct ref_iterator_vtable merge_ref_iterator_vtable = {
>  	.advance = merge_ref_iterator_advance,
> +	.seek = merge_ref_iterator_seek,
>  	.peel = merge_ref_iterator_peel,
>  	.release = merge_ref_iterator_release,
>  };
> @@ -268,8 +288,8 @@ struct ref_iterator *merge_ref_iterator_begin(
>  	 */
>  
>  	base_ref_iterator_init(ref_iterator, &merge_ref_iterator_vtable);
> -	iter->iter0 = iter0;
> -	iter->iter1 = iter1;
> +	iter->iter0 = iter->iter0_owned = iter0;
> +	iter->iter1 = iter->iter1_owned = iter1;

OK, we would assign `iter0` to `iter0_owned` and `iter1` to `iter1_owned`.

Thanks,
Jialuo
