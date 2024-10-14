Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793221CC179
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945132; cv=none; b=c+i9jjVdnTa42RM8CunOA5tNNlzoVDaXzE5GPHzhgKNUqX7p8a9UevasdtsTAbBtgQrm9dTFlgKDDrPPNG0Y7f0AsKvwd9lhhRoj4EwZjG0aPX87UthihlEvFPjU0KLjdBOGx+ExvTcG62Kt+QpoTFbPo4vo32Dr9G2+LllNGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945132; c=relaxed/simple;
	bh=AXLG1PLQAzvp3rfW66/arqnPVEFag2nixSL88AqSM7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YX9v8OZsZT47ILEDlBUjeKaJP70Yo4x9ZHLSJT7RfxQY/E14QCUDuXFA9+l6UhixCBKD1A06RD4AREgYFRqgs4X0f6BxMzeJZamfvgAuFieV5Dqksg9P2NcPMbTiRU6W6wNFiOU6ItqjyraghYaFTj2lXIxUSDZqlI6xgzJ/+MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=uFIPIS3p; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="uFIPIS3p"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e232e260c2so38665247b3.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 15:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728945129; x=1729549929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXLG1PLQAzvp3rfW66/arqnPVEFag2nixSL88AqSM7k=;
        b=uFIPIS3pDTEdldRvqY+yodynhkJWpTK5YIcyw6qGNHDaTadnufl9kCnR+CrtEx+KxU
         uHPlhi7TrzmZfWviexNlj09+VZKVGdu73V9HzJmWaDwABCTcIhV6BnxIQRxdCz79mMAb
         iS+bg7L/U3mzWhz2C/mjDVfsThqg2OP/dG1mVh5/zmkD/9RY0Y9Me+CGfu+Fh6NVMh47
         deaei0NDhUTD5N5EekcFVBCQS2AV8WZWHXhZgjhnXHKriDrOtqkpLC3mlgWYmqWXdWjG
         +1/1bZNh+xyUH1QpmLjcIhgMm4gZbqywBldj42A3wytBS6oEjlXloe/yBzNg7627LJy5
         r5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728945129; x=1729549929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXLG1PLQAzvp3rfW66/arqnPVEFag2nixSL88AqSM7k=;
        b=qKqG4G94a572jKAjYIecD/x2vNJ2j+hQFmm1N+DGigQ4uy2gxS9o8BFfTR0S7AnsUA
         KJ0Kti/6EFZwLxrK2IBfkWWu2aH9Lcr19QUr0Yi2/n1YWJE5qN+6F1iNe/anyYaC5khP
         KLTmVcFQYi5DIR54dVrUV9lh9DglYImdpqDW+3tQO9LAl9dIb1A7lKh04Kci0LXA9n/L
         g9x9KoqnK7ZtSUp8OGA7TWgxntTJQ9j1HlTPkab/sPZA9DbcDxpKxncsFDxR4ZXMGY1d
         gQ/4tKTyZIK3y4ubYE4Z09HiSXMRzDmohCWxjZk0+wtLfkixciQQLLYyEcQsvXjuPhE/
         6/og==
X-Gm-Message-State: AOJu0YzL7dqPERqhHI1NRKQGdmu8kE3MGu5HIy85S6sB+YFdWkJ4QZyn
	/6U3L+vQOGSBKrackTND+GbzDOS53IhALNgPckPBQGkZbBroBYBQJeBYvEuk7NM=
X-Google-Smtp-Source: AGHT+IF9Rm4GX/aC8I53FZ+JRpoNE9lXUIywcmSsN9lbe7v3yrJw5Pz9/oOgqFjy44XmRqsuaJBhNg==
X-Received: by 2002:a05:690c:4485:b0:6e3:2e20:a03c with SMTP id 00721157ae682-6e36434ef6bmr79382737b3.26.1728945129393;
        Mon, 14 Oct 2024 15:32:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5b87612sm133567b3.70.2024.10.14.15.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 15:32:08 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:32:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 02/10] reftable: stop using `strbuf_addf()`
Message-ID: <Zw2b5+8Lw83ywhzk@nand.local>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
 <6a7333b275e9f7eab81568a8de939011d292a31a.1728910727.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a7333b275e9f7eab81568a8de939011d292a31a.1728910727.git.ps@pks.im>

On Mon, Oct 14, 2024 at 03:02:21PM +0200, Patrick Steinhardt wrote:
> We're about to introduce our own `reftable_buf` type to replace
> `strbuf`. Get rid of the seldomly-used `strbuf_addf()` function such
> that we have to reimplement one less function.

Hmm. I count twelve calls to strbuf_addf() here in this patch that were
rewritten in terms of snprintf()ing to a temporary buffer. So I am not
sure that I agree that it is "seldomly-used".

Sure, implementing fewer functions is nice, but I am not sure that
forcing the caller to use snprintf() directly is necessarily a
worthwhile trade-off.

Part of me wishes that we didn't have to write our own `reftable_buf` in
the first place. Could we use `strbuf` as-is and expose it through a
generic reftable-specific interface that users of reftable fill in with
a vtable or something?

Thanks,
Taylor
