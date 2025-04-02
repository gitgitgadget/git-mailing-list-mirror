Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0021A8401
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743627622; cv=none; b=NqRechgQ1MOuJG57YsTTR/I2Zk61XzlSocdaew2nLY3qRbGKlUKzliitc/zohfXb9WmmN/XGB/qLjb9nvk1N7/eEk0h4i5fEx7rcX23D+UO62hMudA9qSrknBEIno9TcAvhm8BA456h1LVszWhgrKUPUabrj+REuhaVzrwrzSQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743627622; c=relaxed/simple;
	bh=0+IdgzzA5jLIhsIZj5MFkA/RPG50wZI/3+rCQxkWmck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHHqj3Qq7AA+7b6MvYi1fvCZZIajw/RgT4i9nHoHcHc5qNueeBGScnzb3RaaJ6ggmpVeOo15x0vQ+rFxLCDJDmVml6OzQ0ST2Z4MzKdIAhU+SjHxPBKUyLG5TvUR//DOpMFKRvoqgfi+1E7JpXGB9n/EqQ/g7u5lUokBgFyG/Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eC4Qnnbg; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eC4Qnnbg"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3fa58dc37c5so624908b6e.1
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743627619; x=1744232419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3phT8RA7M5SjgaWqU5StN6wiCQR+hgIRoojJfD3reYM=;
        b=eC4QnnbgbEI4oPJC0/at8R364v1vS48xZeA9oK5Npq6gwqhbf28cYeqDkG8UJB7A/n
         2nMJVRtHOBDHwgaYcS2QLW/x0UU6glayQkAB/h8M6p0cA25krZYtbnnUlfW35Q8qN4wU
         8VDE+n/Zxr4078okoYXxwRH3TxfGDvfvRtpUtFiqjcGPDldyDr3mVkTaImUI18t0mtAD
         MWRGIYBin7i68eVvXtcowkRDr6ZVTZ2+hbnHbPblhdWFjvLjp9MEpJJpl9PIF12vT3q3
         UIWtxhy1+cAX5LT/rcarRU1iDkZPdAA2qvONXrB90cXqd30r3tXqtLjn+uJsmdFnM61T
         YkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743627619; x=1744232419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3phT8RA7M5SjgaWqU5StN6wiCQR+hgIRoojJfD3reYM=;
        b=c36JHV5zOvXgXmElp7KQomBGvYZy6OdqtM2rL9RliJjr6/CUC/BN/kYBjyOnYnSIIm
         ZGUfRL/MIOP/X1cXJrumm9aVivRdWc5/0O+UXlmWJnOZnMYEvsLxF4amoS2SmKR4APA+
         WSIHWbdUtUFwc1aR+ZKCHgNqjCePoJo4qNgXyvuaE45tCpHapSRzUQ0EY/OT9/s9df39
         GZSOQS2ulgRuOpY0fq4MjxTal4oS2XKPLfYleUYtyAbsKuTsNqVyFaezjY42ocwPdQWF
         tEtTqVNlAnaQJLEEjWBzPGRNCc3j7sauaNdyW1e3nXdJ03+Y8owTkgAck6eqLQeeOGYi
         TDMg==
X-Gm-Message-State: AOJu0YyeriWWIYAIMC6ahnhS1dVa7Dqin6PRXW33436pzolmPMOvWD8b
	5PEGakwu76FekHGuhf0eOOgb3+JnuvjEYoYhu+iPyQ+kfR0efHox
X-Gm-Gg: ASbGnctGEbHxDyjoizG8OgWAqxYA3+AuFB2ONNqQi+b01sqJ6zaEaKP2lBACroF9vF1
	oJFjKS0GO4u7Mwd+JGcVLxO/Ms7rF4XdtAyd+/ppAT/rKsPgcGb6lQPnRE1LXZX88vtqzEaW38w
	yISafWERrswnQKUOzPZfsxPPk6Mnk9RzjgEfhB/eSm/CRr1iE2WfyGl8hUy228hwzib7EeSpx/R
	fmWG2QlmIwJ0qITCS5ehMP3UblFOLAIX3+HoFwrRJ74dzFx032Ak4IAZGn80nJVM1UOWHFxU/KN
	GDZa2G2KN10ikqU9tz3ef4w9X2alACeB3olCXw==
X-Google-Smtp-Source: AGHT+IH2SQQZ2kfkCgm6y2rrY40pXy0xA//q2OODDUKLAAWtsTQoZxUvBepsCajqZBT7nLAFkb96MQ==
X-Received: by 2002:a05:6808:6b8e:b0:3f4:11b3:206b with SMTP id 5614622812f47-4003d58d8f6mr679370b6e.17.1743627619597;
        Wed, 02 Apr 2025 14:00:19 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3ff05278de3sm2494464b6e.36.2025.04.02.14.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 14:00:18 -0700 (PDT)
Date: Wed, 2 Apr 2025 15:56:30 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/16] reftable/block: store block pointer in the block
 iterator
Message-ID: <u4h53ukh5uxk4r4zy5iyniob4xf7qmtem7j2kp45sknfbljwuv@ntdojrh6aakb>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250331-pks-reftable-polishing-v1-10-ebed5247434c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331-pks-reftable-polishing-v1-10-ebed5247434c@pks.im>

On 25/03/31 10:41AM, Patrick Steinhardt wrote:
> The block iterator requires access to a bunch of data from the
> underlying `reftable_block` that it is iterating over. This data is
> stored by copying over relevant data into a separate set of variables.
> This has multiple downsides:
> 
>   - We require more storage space than necessary. This is more of a
>     theoretical issue as we shouldn't ever have many blocks.
> 
>   - We have to perform more bookkeeping, and the variable names are
>     inconsistent across the two data structures. This can lead to some
>     confusion.
> 
>   - The lifetime of the block iterator is tied to the block anyway, but
>     we hide that a bit by only storing pointers into the block.

s/into/in/

> There isn't really any good reason why we rip out parts of the block
> instead of storing a pointer to the block itself.
> 
> Refactor the code to do so. Despite being simpler, it also allows us to
> decouple the lifetime of the block iterator from seeking in a subsequent
> commit.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/block.c | 22 ++++++++--------------
>  reftable/block.h |  4 +---
>  2 files changed, 9 insertions(+), 17 deletions(-)
> 
[snip]
> diff --git a/reftable/block.h b/reftable/block.h
> index 4f7f29028c4..268d5a1e005 100644
> --- a/reftable/block.h
> +++ b/reftable/block.h
> @@ -67,9 +67,7 @@ void block_writer_release(struct block_writer *bw);
>  struct block_iter {
>  	/* offset within the block of the next entry to read. */
>  	uint32_t next_off;
> -	const unsigned char *block;
> -	size_t block_len;
> -	uint32_t hash_size;
> +	const struct reftable_block *block;

This is much simpler. Nice!

>  	/* key for last entry we read. */
>  	struct reftable_buf last_key;
> 
> -- 
> 2.49.0.604.gff1f9ca942.dirty
> 
> 
