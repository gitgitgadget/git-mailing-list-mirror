Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB441F81B1
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788660; cv=none; b=GfXuZ1+GItivgaz6eb0vL6xdFlSsQ6+dXDSeWWkEAIZL7G5PXEeQgDEgiwgtTfWA2R39L77gncn8m83yNaunVobSQrXLkLvGxlpJpvnluRZnJ1wS0K+6D79MTyJs4RphRG6xhhbvh1vq11qQf04HyOikNHlDtqOVVxkTPbOPDpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788660; c=relaxed/simple;
	bh=Av54rAhqn40bTLPdgU1hka81JUXALDHIO0QzRYOPgGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SG9QLEvLoOZd70d9OqltIwNgskUQyNT1+iPaUsvLAToBTO/J4qzfcWvatxgrguXlt+1oSaxiU2JdXlR+sE7OBCt6r/f0ObXjv2ja9ATv9NEAroSCBqz40Ku51OBPujJS+GRgbBG5v5EqbLpwgbTD413QoVaLlI53eP5mEu9zSyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=U3arrkom; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="U3arrkom"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e3881042dcso10922377b3.0
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 09:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729788657; x=1730393457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Av54rAhqn40bTLPdgU1hka81JUXALDHIO0QzRYOPgGw=;
        b=U3arrkomUGbshn6S/Sa6AbR2w72ckDp8ABKzlBJ2Yxah7fqpnxbi7APpPrYw9is7oO
         W1S/4qXzPNqH/XZNiDvf6SdnbAIb76xwzrZERjACSmbIz0sEs8nirwK1m95D3U0Vx80O
         LBFFO/EntT9wFGY+sCMuwlM9TKxJba5sQCCWoVqi1BlnJ8ZCr55wykTVRix3bu4homnc
         WJyFp8NTOMF4XBdKkJ5wnILvDoERmBHMQHg8hVCg8Y7W9XXw+oa47enMZKLZaGX9rVsM
         uYYsjSE4S2zySBuXHIaSncqmcX7+oBoFintTmO0EaZxNCy5efOJySjkNULw4fpRoFlR/
         7sDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788657; x=1730393457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Av54rAhqn40bTLPdgU1hka81JUXALDHIO0QzRYOPgGw=;
        b=HlnL8P/bqV8zfNBm+aMd80Ttp65rFVC8fklWEGnXhhEnZA36lUr3YVVILwLVZxdtgK
         N6C1NgL7c/nmsfhVsZ+UV+6dRC76NC2V3hkOpJHgt3r0pKEztelVqHkLaxquKu8W086d
         ZIaXlaD8dR1ZDXi06wwDZWDuT8uCnFwGGFys5Z7vtmLe6PVB8drMLVKavCVFxJ+bfCcE
         SFLMGSQjeRcNAWzkiqI6gRO8q14SgQFdfl0WvmVYkZgUjjcj/jaUl85jlgP2jVlnZm55
         nAchqiy/Npug8y2hwxF8n+o5ACWnSrWp0ot89ctq7QlDDHWBLbxDdxHl2YNzTBhLjdDh
         09+w==
X-Gm-Message-State: AOJu0YxAJszHt16BXpY+1pMOiFURQQupz7Rg5eX+4YgfvUgauzgmPcsZ
	KZsBghDD+6ytE1QnSBkn0+k5ZaCJhhA2oW8EJ84MglGUqRaQ5GJkj+yp7y6xVvV/+B8C1S2m/Rp
	0XyA=
X-Google-Smtp-Source: AGHT+IEiaSjHM2irNkTAsKbKRKJ4oHXxirtweHu1KgTJnOwkX4pQpewvgktDgLUpZ91gyt0pDhQ8yA==
X-Received: by 2002:a05:690c:6a10:b0:6e7:e1aa:ba80 with SMTP id 00721157ae682-6e7f0e40084mr76334707b3.18.1729788657445;
        Thu, 24 Oct 2024 09:50:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f5944sm20692327b3.4.2024.10.24.09.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:50:57 -0700 (PDT)
Date: Thu, 24 Oct 2024 12:50:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, kristofferhaugsbakk@fastmail.com,
	jltobler@gmail.com
Subject: Re: [PATCH v3] CodingGuidelines: discourage arbitrary suffixes in
 function names
Message-ID: <Zxp67zpIsxAe15gN@nand.local>
References: <https://lore.kernel.org/r/20241021124145.636561-1-karthik.188@gmail.com>
 <20241024105357.2605168-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024105357.2605168-1-karthik.188@gmail.com>

On Thu, Oct 24, 2024 at 12:53:57PM +0200, Karthik Nayak wrote:
> We often name functions with arbitrary suffixes like `_1` as an
> extension of another existing function. This creates confusion and
> doesn't provide good clarity into the functions purpose. Let's document
> good function naming etiquette in our CodingGuidelines.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---

Thanks, I think that this version is looking quite good. Let's let it
simmer a little longer so folks can continue to discuss, but I think
that this is looking quite good.

Thanks,
Taylor
