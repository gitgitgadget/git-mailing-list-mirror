Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83E2C86D
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 02:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774491168; cv=none; b=QiRgt2qPNfzToPwzk171Q4L8/ucqKYBoWusjbw7UVdq1NvFzWBk6FapPo/oBtRgAoR7iDiFxEqnt8izkJag0CBjbReP0m3SPMyEuiNvaP6V67o3uBtlpC9lEfIVX6vfpYOmYCXdyQMV9uI/kFFPRvsVUbRz0GKvQ8BL16nEhxOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774491168; c=relaxed/simple;
	bh=Gvj6IohmHYPJcPEmbrgyBhFzXwbJTMUIYmt0/gG6VYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdvCn8Afzaah2EBZuh0PIOCe93utbmVaL12Pdse1k7tbjum9nEEsvtpNo2krbgGM6WRN8mIzVqKH24x/I94czAmfWRvBTZbWzwY0TDJPt5bm5IUtercBNOuYXVs1q47vFxGf8cQsBohKQULkYfZqeaSwh11YoiA7uLHu6zWFzhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOijl9Gy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOijl9Gy"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-486507134e4so5689495e9.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774491165; x=1775095965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SgQmctrCuX8l0VjYNglDwrs/oj/Im+0qjXxQ71h1Fh8=;
        b=iOijl9GyNfjsB5Kaa+6Dr/XG8c9KDma3tv/ahFe0yXBcpIDC5nv2itYEOj5Ak3L8Ww
         SsmPdfJuSUgdKRJ/ONQv5fyIPXDNLtG9MDT0nDcy20grCkkQHXBB8w7c7FaIYNE0C/lk
         3iZC9Bc3V6G3zZNQNYHS/HLMNPryGa3oU41I7M/bc9Nk+PxbdqNvbanEI+bt6sJJsRmK
         yJrNcxbA6/24hkQ9oQ1N17ngDo2w7mxMGTnNnYnHG00cfBDDz7nJLRxQhzxqkaNt7VB5
         xZx9TKC1ziq8pangh/0D9G6aJhEa+Jhisk2JPfDyjyIB3pIyM9LwkbVgUCynDp4cKD18
         YHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774491165; x=1775095965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgQmctrCuX8l0VjYNglDwrs/oj/Im+0qjXxQ71h1Fh8=;
        b=jqQy2I5zPqgaspu9Sk1hoca+v504qz1rSSS9HtUvIt4kG6TbX23pVBWwALYPOlMqC8
         tAiiZPGSN7Sd5fyjIa938Ap23zbWI9bu7a5ylGUoO5mq7KCig86DnPPHYZVz2GCmJQCr
         OyjNHLktuJfbsuk2ds9w7K/BLbw2XyiGIM6HL9BTqJ+XrOxFxFtN1GIrkozHgw2JaOhV
         LUsHJR9ssn+DI2AiIVUoKI05C2G61f2D8I9z/BZXphbvfVr4Ldjor1Eg5TcsTdeDc03l
         wkpT8+AgKNr8aoa2kgLob0p1SHcnA7IVX/3ntUTrCkd1IoFEhRX9BOhyQLeKzMun71+p
         eEOQ==
X-Gm-Message-State: AOJu0YzxVSoJAlkSqW7/X0dSPXlUwsdG4KEyM6hrUZeiLJ7bWBizVnC0
	NhmQQmn2A1mNP8f4ZJh39G1V8EPybu3GWE9i88LiSL7Wz3MmSGh/ksUk
X-Gm-Gg: ATEYQzztxZ2zBdyzucVI8nspnEW4oDx+CKpUeSDq1z0x2M8ASOpt0b5CtWXC6gb4OFT
	sO3y3YFiOkUCbIviDQRBbKhGfmvGWcAsXFhOd6MfWlCLSYH7GTMEcetWixFjz2ASikt4bUg9B0L
	M7AyHhTzxCS8n2u1UTZ3lLHlDnqu2m58Kt4hHmvmYUvObUOeBWKrtoEEoffqJtheXcEFVABxJf8
	ewLQddSu2tyK5RQjhUVZ3a0KLjPW3b84jVWOF1+MeVdT7rqT8wgNCSXDQkzcHSB8c2aelPsKdhG
	UbNQcLG42sy/8faTxkeWtWhycJ9VfKH9E+Dn8k7Hc894k3Cou4+jBGQ/BMgU4QBsFi+M32PZ9uF
	knVeVntEeL6nw9ws0IgR7DxdebpnAdVGuQCHreyPFrrE9t/PoI+/VQUoYetzSC+5JaZKmYBJU1H
	Kgo9ozPo1H6rAgv+lSTKqq4Dxp3/yqlKMn
X-Received: by 2002:a05:600c:a15:b0:486:fc46:be9e with SMTP id 5b1f17b1804b1-4871606c911mr95257395e9.24.1774491165341;
        Wed, 25 Mar 2026 19:12:45 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871174f39dsm148093785e9.11.2026.03.25.19.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 19:12:44 -0700 (PDT)
Date: Thu, 26 Mar 2026 03:12:43 +0100
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v2 3/4] repack-promisor: preserve content of
 promisor files after repack
Message-ID: <acSWG-7Kj67zgzvZ@lorenzo-VM>
References: <cover.1774125871.git.lorenzo.pegorari2002@gmail.com>
 <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <3dab969a3942532f49f6f9cdcddb5fb2be11e232.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <xmqqa4vy43q2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4vy43q2.fsf@gitster.g>

On Mon, Mar 23, 2026 at 02:48:21PM -0700, Junio C Hamano wrote:
> LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:
> 
> > @@ -40,6 +40,7 @@ static void finish_repacking_promisor_objects(struct repository *repo,
> >  					      const char *packtmp)
> >  {
> >  	struct strbuf line = STRBUF_INIT;
> > +	int is_first_promisor = 1;
> >  	FILE *out;
> > ... 
> > +		/*
> > +		 * Fetch-pack sometimes generates non-empty .promisor files
> > +		 * containing the ref names and associated hashes at the point of
> > +		 * generation of the corresponding packfile. These pieces of info
> > +		 * are only used for debugging reasons. In order to preserve
> > +		 * these, let's copy the contents of all .promisor files in the
> > +		 * first promisor file created.
> > +		 */
> > +		if (is_first_promisor) {
> > +			copy_all_promisor_files(repo, promisor_name);
> > +			is_first_promisor = 0;
> > +		}
> > +
> 
> Here the underlying assumption seems to be that whichever one of the
> two potential callers of this function, repack_promisor_objects()
> and pack_geometry_repack_promisors(), would handle all the existing
> packs with corresponding .promisor file so it is safe to coalesce
> all the debugging comments from all the existing .promisor files
> into one?
> 
> Is it really true, though?  Especially with geometry repacking
> enabled, wouldn't a regular repack coalesce only the smallish ones
> into a single pack while leaving an already largeish ones intact, or
> something?
> 
> Thanks.

I will look into this. I'm going to drastically rework this patch
series, so that the next version will be much better and better
explained.

Thank you so much for the time,

Lorenzo
