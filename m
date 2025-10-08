Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF08212575
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 20:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759956506; cv=none; b=n0CtqtaCdtsAC61salTVFkoPk3KDsat+zZybPe0NsjwLwEpDa4AfhElAuWD/CpBzRHjXLXzaGMYYnKDnOtUz0C721IY20Gjv/Hf3mf08KAaRaJUs6LOiCIgC0an33fWXfa9KQpuklhJaOsmCn/pXYsA2Lbpnf+oIws6QhkeFr04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759956506; c=relaxed/simple;
	bh=/I2oLge3SjvXAOg2dgpDkm6pU7D3Iu76tY4aVkx/yg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5ap/cku78qLpKjyhxIaxdZg73h/l+wD3TxfKwQAuLgCJeghfhQkQox7pwU9ISVHh83aZ0sGUizfettAXtxSDRFMAhi3buA8UaK4LkzJFgbSDin6gU5J6a1BeJRCjEt+HTiHByIvRRDwTMcXzx7o2NB2ZFWjFOryIEskKg7HpyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=eW/n+V3H; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="eW/n+V3H"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-9335a918867so19397439f.2
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 13:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759956504; x=1760561304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iBjix51guNeYoyNPgIAlFqGcAJtXpGHh+CZz9TZPgII=;
        b=eW/n+V3H4trMcvcPkzc8Qb8FqKceZDPYSCQB8BS44xqoUXpiBrPZYA+eaYmyJyzCz8
         Zu7V6XUbLWNYZZFBcHMqEP0h3Mdnz9fXPKACXqmrLoZY/E0rPSofpjmOn8WVv7XclOFQ
         na/ZMFNPwMw9VaNGIiINtt/MufuyttOZjJP3zDytFwMcM6AJWMFkswCn6xcS9FToYr3t
         Y6y+cFzQl4b9qx/+aFEj94Jj/JqSVo56XwQtMS9YNAqjOzdOEX9lO3wX5D65LF6JcdDg
         FWC776Bk89ImTydCOGkL3lpEWsdAbvHfNBcjCjJ3xdefetWwZuD5dx7ZXjV/RFFfmwCh
         iojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759956504; x=1760561304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBjix51guNeYoyNPgIAlFqGcAJtXpGHh+CZz9TZPgII=;
        b=hHpWFPdI7VyGLjLl589w7rf4K0MDwms3rxqEP2gIRBNYIRu40omgSueCWxnDPWjrp5
         4vmM8sywVXltzQlDYcasuzeawY1wt2drLPQ/5YuGdQ9ILXlkTT0V1zSXbVnLxm57ftR0
         CvZOPvuAtbWnBAf3cwkzw941FaoeUbAvyc7Fzar9KUdR251PXn4Mm9W1LKluWZj0muAx
         jwNsw5+uTf53OMFxLykgbBd0wgbsHd5t8eiOyAvxvvMA9j2+nnAHQbvykoWRpXJUxFiT
         wOK+woZuhnIziUgkG3r6ixpq/vgccDTNxBgqUdT5t6w+7eaug7N9PGzGCQUIxBppp88B
         kL+w==
X-Gm-Message-State: AOJu0YzVirn00mhqg6kaxkOOFOnMxhvZGffPu31Iva8/pM6D5Ak8r+kP
	Nl9buz3Huxd8VjLY+OEzbpOkYMKQFtDrKn0yfYhFcKsY2GF2UjK3CdnPOQm4ETUQQR4=
X-Gm-Gg: ASbGnctSNtEbLOV1nX1YKobWgaTSaMNiko4dBvN7w9BMMURFnfwX+C6XK8ZBKwyjHKE
	1iVw2r2dET1wO+pIiL3iZuw0PTbsYS6qipk0kdtITN+pbHfcWFZGcmKEcV31DSfQUXj4ug75hUd
	HV8GI3ohznZndf0dVJg8/h6GAMMTw+5jgaO3x/62ROm8jePROGo2OtTGqQGT9AyUChkDpZmWtJx
	rPgcnnSS3ERizuOb8/7Kikvrb+S/qIrJjNNvNll314Hk48adVUywBCB75tTbmrMYq1XUEK7vZNX
	LuECE5xci65ljfc5a3+/ZALIfUoQ3TFBcjgjeO2lrxQaYkKnwjWxBQMRDFguJNKL1gA6Qsv6aG+
	ASg2ohilgaUYoyxO31dUce0jiO0Rh81Vaqv8GPM5FTcUAtvZzKMLXfVShw2O6BfS1QW8lyXFVea
	Jtycxd6kfmeml0ojeo7E1FFmhSEAHrseL25gUEZ94+W3Eu0hXJdg==
X-Google-Smtp-Source: AGHT+IFHBQoU4kuIcYoWprNlY/VFH9YaDCGLkAvUHhJLfBVbD+OOOm8j+BC5BZD2IelatJdrostb6A==
X-Received: by 2002:a05:6602:7502:b0:904:48f6:9d3a with SMTP id ca18e2360f4ac-93bd1976f28mr572077939f.15.1759956503829;
        Wed, 08 Oct 2025 13:48:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-93bdb32ce77sm25400639f.22.2025.10.08.13.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 13:48:23 -0700 (PDT)
Date: Wed, 8 Oct 2025 16:48:21 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/6] packfile: rename `packfile_store_get_all_packs()`
Message-ID: <aObOFciwYsvTWT0e@nand.local>
References: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
 <20251007-pks-packfiles-convert-get-all-v1-6-428227657a89@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251007-pks-packfiles-convert-get-all-v1-6-428227657a89@pks.im>

On Tue, Oct 07, 2025 at 02:41:12PM +0200, Patrick Steinhardt wrote:
> ---
>  builtin/fast-import.c  | 4 ++--
>  builtin/pack-objects.c | 4 ++--
>  packfile.c             | 2 +-
>  packfile.h             | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)

Hmm. I wonder if we should perform this step at a later date. My fear is
that another topic in fight might introduce a new use of the "get_packs"
assuming the old semantics.

Merging this topic and that hypothetical one together wouldn't produce a
textual conflict, but it could introduce bugs where the hypothetical new
code expects the old behavior.

Perhaps I'm overthinking this, but figured I'd write down the concern
nonetheless.

Thanks,
Taylor
