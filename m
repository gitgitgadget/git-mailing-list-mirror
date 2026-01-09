Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B48F33A033
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768002010; cv=none; b=cb8tGYG94ohdoNynt2IpALFWd/bxSTE3PpjXiutr03a+y0r+S4L4HyyDC53FEtdhQvSzF9XzUuSHz3MBwNBCcjxQKHa8570SGdRDV9/HRkBtkiuZlRp2IbnZ/RuToPXK0wu9FtngI250BM6f9UvEdOwM9O7mMS5FctfhYkNbo6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768002010; c=relaxed/simple;
	bh=zqCKqqbld/Bnmd67odsO012nrbEMd7anpPbML7mNoLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqqI9uKmbrlGkR6VNtW+pdwrYaNSEhnRdOnYgZUtLxyPg6NW9tlDRO5mAfX0jJISbdOSDguKmDBB/Zpk6yfMWrgHPBPuc182OlRo360+Iu4MWJOKDoOTcTlFT6FrDDKiF5D7gk6PnUetzq4KfGLVUT5IkIsVwc5InIfbT+KYd3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=MQsFejEM; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="MQsFejEM"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64455a2a096so4077679d50.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 15:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768002007; x=1768606807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sfwa+GJq2Xg7FvCCeHqXzO7O67zV0gWTZfysDm9wpZQ=;
        b=MQsFejEMqcsoxXpd5TP+HXOO5oyqkdRiVkVY2IZZw2H0yjN8QgQKXKfuZPG4quNSWq
         INeQkGqWvEuth1t7v+szIT5b4M9On0MpUz74/uY7EDUNpsQDsAuRFj4DE8Jk0uM7hgGq
         d399c+OClonvZh7MSFFNJ1y8abdy5cUPCL6TQnyuTHs1WaDcYQAjq1MC5zqTDX/e3ZnX
         bnoD3qasZzvOMtLD9Tz9XJM2SC8eeNnPBTxX9yzCZXhlUzth9uuZGx2Hno8PXOcjIZss
         xvdlvVdUjzjoXyTX6m344D1dtHqRzbskSqkFqsXylbWfiGZ9DmvMlc5fZMZ8xFJN4r/y
         CTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768002007; x=1768606807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfwa+GJq2Xg7FvCCeHqXzO7O67zV0gWTZfysDm9wpZQ=;
        b=jQnRvsE/4Pr0HoJ9CO38dlwp2Ti5/0Ff2B37MRFlugGYPE8+Dog1ulYCuUDMg3UInq
         zjCzoamLyIl04i3+f11dmEUiC3N1E4s68pOKPF1dbPia3ZfCXjrp7rgaB951SsPyiubw
         7foU3BqDrL0YFC/vPRJM9/V8zN5LyRKJ2yFA+Kckj2zrUJEutdHoAwK9ixedPLXrFp4/
         HSXLcPDvGZIqZyJC4WikMu7j6XtKfD/dDZFfTaNJcJ5arY203bhc4oVp9bWzhweCga8l
         B5Xvo9Wl0Do6/mA92eIZlkv2ogpJRtse/H+pdke1pLx79okpFlOFq/F9AeOsyRdr6a5z
         Et7A==
X-Gm-Message-State: AOJu0YzI8a9FqLDPOoJiarNLczeuY7Yky04EzXzv0KG/cc2fi65ZXuGw
	5JkjzlWAdDB/6crPPJnR+oYVIaP1ojjsog32buB3sv97TOOc09S7xAdnkbzWpLLRk3zIuCjarTL
	16xG9eRn+nA==
X-Gm-Gg: AY/fxX4MrCe7pNMakXRLKTQkjmR07oLqLq0Y8nKk2H791PoLbqLLzt8GggTr1IPzXyV
	+7TTLLpLqs7W5lZhCaVyvUl2CDyQj6HW17N1aLIAdgKwGNH1pxKky2NO1hxNrSUJCECBi83ORls
	GxDce0D2Imd4uXPeRyFeiVsggj1pHq3mfixoVhGy9Wl/AzQ1Zqrx73+GP0kEoAbteavDPI6yjLb
	fxaq0E3xrM1k57o4m3MDZx9tiDI6q62qOLZrwxr9rFB8LDZ2XUDwwuZkMQMWmVMCY17SVRhCZyO
	ESV0SfbzacKelV68+KzJMy2+u5Nbbml54gLGhL5TBD4VyECADvp4rOZt3dfuNbRoR/iwPZ9prvR
	S/olBXIuDjYWYJB5Obx6aIsvA7R2E0N9hmhonOs73a5I1u5q1ZSr2NYVDcnkgDWFdUGnwcPOpL6
	gpRLzGufBSDUkKzwpHqe/zKFC3gS9f1ThuW6dlWNwfmSlvrdtvKq7ADb8NQ0uEdCQGBc+hmgSEn
	HmI75czVJ68xZvtSFk9sOJQvxgV
X-Google-Smtp-Source: AGHT+IH/Mm9YYgYuHRpMR1TzHIiQVxSWf8UZeO0zx64VUVteGG/5j4fUk18JMu4UNxuFKRczPQbv/g==
X-Received: by 2002:a05:690c:6b89:b0:788:e1b:5ee6 with SMTP id 00721157ae682-790b58607bamr220132967b3.70.1768002007539;
        Fri, 09 Jan 2026 15:40:07 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8c51bcsm5066433d50.22.2026.01.09.15.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 15:40:07 -0800 (PST)
Date: Fri, 9 Jan 2026 18:40:06 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] repack-promisor: extract function to remove
 redundant packs
Message-ID: <aWGR1r5PlLL3rWWd@nand.local>
References: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>
 <20260105-pks-geometric-repack-with-promisors-v1-4-c4660573437e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105-pks-geometric-repack-with-promisors-v1-4-c4660573437e@pks.im>

On Mon, Jan 05, 2026 at 02:16:44PM +0100, Patrick Steinhardt wrote:
> @@ -226,6 +227,15 @@ void pack_geometry_remove_redundant(struct pack_geometry *geometry,
>  	strbuf_release(&buf);
>  }
>
> +void pack_geometry_remove_redundant(struct pack_geometry *geometry,
> +				    struct string_list *names,
> +				    struct existing_packs *existing,
> +				    const char *packdir)
> +{
> +	remove_redundant_packs(geometry->pack, geometry->split,
> +			       names, existing, packdir);
> +}
> +

The refactoring up to this point looks all good to me.

As a side-note, I would love to get rid of the
pack_geometry_remove_redundant() function altogether. It is kind of a
hack that we handle determining which packs are made redundant by a
repacking operation in two different ways depending on whether or not we
are doing a geometric repack.

I have some patches to do this in a series that implements the
"reachability-guided" geometric repacking technique that I have talked
above[^1] previously. I think (having skimmed the next patch but not yet
fully reviewed it) that this should still all be doable with your
patches. We just have to take two passes (once through the existing
non-promisor packs and then another pass through the promisor
ones).

So I think that this all looks good to me and shouldn't interfere with
that effort, though I'll make a note to rebase those patches on top of
these to make it easier for the maintainer to queue both of them.

Thanks,
Taylor

[^1]: Well, I was pretty sure that I had mentioned it on the list, but
  can't seem to find anything corresponding to it in my "sent" folder.
  In case I haven't talked above it before, the gist is a special mode
  of --stdin-packs that only packs objects from the included set of
  packs which are reachable. If repack generates a cruft pack after the
  fact, that allows us to "incrementally" build up the cruft pack over
  time.
