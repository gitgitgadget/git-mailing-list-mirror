Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A04B13A3E6
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724352726; cv=none; b=OUEjTNEsfZE9r96xVniuk2G7vqycyxoOgKoiQYCH3YAtzi0oTJJhp9anbmSKZLDeqfxmjGbbJmAeinq+/5pD7fZyZT52Ltn3jzwQEPSxFV+GrHvD/HGw4g8H7vMUZIM7UIx2wGnZXaLhOSz8rM1bWxYgxZG9db6nJWFQvm6t3Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724352726; c=relaxed/simple;
	bh=VVBzaxTAmntK2kVirM1kLmHnJWFHVfMPjNY1M3TppFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TONa5IESc1pD0hllZADVbBEWOqQ4R6NBVkMBTnfGOSYFoC/v34ALmz0ZsY1vPUFyayrt6K09dpZFy662RSVjvlAqPajpFKKAqWIOPoLRdBJL6bcv4NxHnh5r/LjA4h4WVhKYEVzcZ3JNpqAgpltNXKlEQ+eezaeV+r2aIitOeSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZG3Vlflt; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG3Vlflt"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7093997dffdso611062a34.2
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 11:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724352723; x=1724957523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9W7WkhzIGkaKCHqZVFiBxsl2uKX+yVblCZcwNXPUxU=;
        b=ZG3VlflttsG39P/VrhLUWKbkPApaPbGoWqgEz/6dLM38XVDFbS7cMIxY8Skr7ogEI6
         +nXqfTCyMdRymq4jZQBxHvqH2zkXWgaEWW21cVIuNuc5DIi9CvqkmsCTa2occrIplOrm
         ncRYfBvW0jj7yFcAd8/XvFGLVAwSEbqs4bCx4KWHrrk1wDo3w/r0wE01iWXGN4IfW3ew
         GEdm+bxvHMqZktarXETCnTHJxU8cZNrKW8nLayPX5dIdyiWv6pbutbZBAXaQQS03NcZp
         yPIX50CWH83j75Tji4CJZZLFtSbRdRBEZ+GBH3wiS5rKXY2BQWs1oa3+SzLTotJIlPqo
         yoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724352723; x=1724957523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9W7WkhzIGkaKCHqZVFiBxsl2uKX+yVblCZcwNXPUxU=;
        b=hPhL8/jJXFOTxPO5xzVHBnrkFle06CrqH9Hpn0pbJ+RFgYnBlrbxfDaY1BxHj9nXmo
         vbRxy+yNxh9yaJqa/z/3LILANlcfRVN5wBAKdTKQGn4I9VyJ8M78SleRCqo94zVddpIg
         JF4GIeBCw9aeHzQ0U+sh3qONSh0tKAVEJsBKEO4yoHwc6nl4hp3b/kU2ZYOaleGfaHIi
         GMbk/Qxm1uC2DaEvkbjFNB9zOvtWAJw0R+N2EqqSHZmYz+fezauTVv6p3/JHHy6aCO0D
         NxUc7y4L5/bRgGiAzi846PTQhrBvV6g5YlSy6mkWnSxKEEECWGdZr+JTP59/vG/M/qrh
         opIA==
X-Gm-Message-State: AOJu0Yy1NZoD9VlNevkM/Gd5/9EkIu2UQe0zN30xxd/TUKviZrDL8VdV
	WFSGFpjel9EJ2fNTnKESMrikrCxqjOJ2h7d+Tc0kFxFXyjN1YSnM3OrLwDSp
X-Google-Smtp-Source: AGHT+IH8/ll36rUmClkzXjbN6osFD7Gn320HwTBSZA7+YaSGl5D/cyG886C7T7j9WKFPnMx8JShmhQ==
X-Received: by 2002:a05:6830:210d:b0:709:39c0:1b21 with SMTP id 46e09a7af769-70df88954cbmr7437535a34.34.1724352723511;
        Thu, 22 Aug 2024 11:52:03 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70e03a50c86sm362772a34.10.2024.08.22.11.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:52:03 -0700 (PDT)
Date: Thu, 22 Aug 2024 13:51:08 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/10] reftable/reader: rename `reftable_new_reader()`
Message-ID: <7qfrzzhsplzmmjdygglfyum7d6qroiggeqonqptkzltgtcrdw5@wlukk42x6thn>
References: <cover.1724080006.git.ps@pks.im>
 <e658b372f046616779cf49c6c9346a49c2ce1485.1724080006.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e658b372f046616779cf49c6c9346a49c2ce1485.1724080006.git.ps@pks.im>

On 24/08/19 05:39PM, Patrick Steinhardt wrote:
> Rename the `reftable_new_reader()` function to `reftable_reader_new()`
> to match our coding guidelines.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]  
> -int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
> +int reader_init(struct reftable_reader *r, struct reftable_block_source *source,
>  		const char *name);

Here we also rename `init_reader()` to `reader_init()`, but do not
update its call sites resulting in build errors. Since we remove this in
the next patch anyway, let's drop this change.

-Justin
