Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE112C0278
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469109; cv=none; b=OMACjGZRMlULbW1I7doaEi+iyusiXjj2gzyFhDK7TuaaWQR0wVbzz70psTDX4oyLMZN6h9XgtANlc1x7N3ncfHU1dePreiay3F5M3oFvR5418h8hBNpTiHiLZGrQyfHj0ziTBKv986EezvzdHOe+lIZQw1Z+uXJ8MGY5wfmJobU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469109; c=relaxed/simple;
	bh=3LUBoF2hVKgaTAnp4q9nrP8085pHPv2GXchy3ByxUpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j42BzA3o8HzInq0cnN3lHP1NFXN/L3ejGmICqTVpldYMWeMijlP7cpJy6uEvnHiZbB6dShSZpsHvwGUu5Wz4jzm1NcYMNgh6ssLSimusTSWBmYUjDnth/7HBFYIFy82a/E3uYpS2nwEZU/srK9g96Wg/EdYRRCM26kDyBkJa+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuwNFrsr; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuwNFrsr"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-79d36a6298dso2016753a34.0
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760469107; x=1761073907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/B5ClAFKxd4dyV3WSt9blPy71mrpDUqT9B2/TMlom+I=;
        b=ZuwNFrsr7WT4GQLFjbzXjoRM70yoo/lrqwH24umqTFo50XLeLRyZLuymrgu8KvDf5O
         haKTGUunQO5J0zOSEzgfHr7ncGRmISQtVsHhvdPUsqiRoMTmudR9b5hHuOO8DWypzXw2
         SGsySl4nhd3lSyZxBv/8+wFpcJoT4y4OFCTd1p0XBjDQXifKGUPrU/sroMrgSFTxhREv
         XlY91HKKoJhG8dbtjGeZStkKC8zZHhhRwuv79Wp+ceC57YW5e3fM7GwZhcW16Y6g+Qxn
         dfEgy6VxCsk0QVlmqNFseS9NksBeSExhtpgkH+9h4Ukk3IEnZtGWj2PgrYHT6Bc5OVZu
         0isQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760469107; x=1761073907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/B5ClAFKxd4dyV3WSt9blPy71mrpDUqT9B2/TMlom+I=;
        b=ImS803BpLrK6o5QSk9b9Igs/IoNLVcxfr+KaMx8X88mbbJ8uAMWcYLC2ZRniMMzJg2
         rE/QZeGggStvHutr8IxbhEGCpPMToZPEAGJnBEJLOYFJU5sjfJvsMM9J4XNNyVVW67F9
         X66slCgWpo33sF7vx5/p7UUsJWZJev+U5Ary7ntkoylHu/KxUFz1ROwo8VNQaQP+sy9m
         /cEGwcWl5F6Ib/Gqr98EJi+ouwBfkwO/UQdz07/Zkg7Pnf7gEhQPfChdS5lRczYPuOGZ
         rLkU/UboUMHpoYUkZtZ2KVvNmYjM9bva2mxP/bVSnsGFnke6rncEIDCeTOAuTDsBvT6Y
         +2Aw==
X-Gm-Message-State: AOJu0YzrSqhpA50jGs7v/nELhyEFQyzIVzr6qyMQLjGZdkSO2gvgFMVx
	3s2R/WEo5lk+/KhoG6irTo6YGoz+C9A4tSuLmFu9n4YV92RvxtQbDsfA
X-Gm-Gg: ASbGncsulussUNSHTBZFdmq6Ua2pHwjFHi/VJcN31uYNXn1RlSMLU8EszUkeXLvSnqU
	4dNgeAyAZ/NlPq5oeqL7+ObxDwhdbfb3yhGlmFL3nucqyPhYR6QNvzIYyS2CJZuZng7wpzl6PhY
	tWMgog62vUpAW4fmIGTKkG4VrEfjA8d7+SZ4VaJob7vTuFazPt4A+MkU1C3tDSQQTUFq6otkNYF
	8fSWUTTX6PtIJRP35k65w3Lt4XWTpRJ3xKGgu4pOGSx0/TxZesvPzJ9p9GnbrQRISvZjMy8sLrV
	0Uh+Ongdxero5vqE4xF5JK823tSxZ1vdaOOrFAvuZ7Xx7zlBXitiK5UFuge+sJhfs2tvbmh9haE
	4YrzdR61eZUhzuZ9iq8RY/jWFwcC7C2k0hTU=
X-Google-Smtp-Source: AGHT+IFTzibBPWbAfPVZTY+tahMhD/FWc4DMBX4Ufxv4+U/TcGJc+0jxTHIxeUd9jIou4g6diLEROA==
X-Received: by 2002:a05:6830:388c:b0:7bc:626c:3b30 with SMTP id 46e09a7af769-7c0df7bec69mr12774149a34.26.1760469107063;
        Tue, 14 Oct 2025 12:11:47 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7c0f915eed4sm4706284a34.36.2025.10.14.12.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 12:11:46 -0700 (PDT)
Date: Tue, 14 Oct 2025 14:11:45 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/6] packfile: drop `packfile_store_get_packs()`
Message-ID: <yakvujhjgio2g2ynu5735tov2bmsq6cwtaxksvyxik77mrjiuz@c2rspc2k77iq>
References: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
 <20251009-pks-packfiles-convert-get-all-v2-4-0d73b87ce711@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-pks-packfiles-convert-get-all-v2-4-0d73b87ce711@pks.im>

On 25/10/09 10:01AM, Patrick Steinhardt wrote:
> In the preceding commits we have removed all remaining callers of
> `packfile_store_get_packs()`, the function is thus unused now. Remove
> it.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> -/*
> - * Get packs managed by the given store. Does not load the MIDX or any packs
> - * referenced by it.
> - */
> -struct packed_git *packfile_store_get_packs(struct packfile_store *store);

Nice cleanup. Now with `packfile_store_get_packs()` gone, the confusing
stateful behavior here is no more. :)

-Justin
