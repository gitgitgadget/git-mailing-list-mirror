Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94681B373C
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718700370; cv=none; b=NWbctoOkRVfIzbUXs++WQBqi5EMwPhZ4ZVITDrQnfQDJruMYZ716/UQfOQ8ctFv15N6cZIu5e10s7iHdqvw4JBHrlbccuMcxUD5kq4pK/t8RO5/o6V4tKpbBdi2+vzy8ucdoxb0JEiaCCz6Ga12Ay61Ct3hpJDgodNzVqIXBB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718700370; c=relaxed/simple;
	bh=XetSLXx7ArQ9S3egRWKZsb+y/2QCEmxApxlMtzdiC+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brwTgLadcVE3NcuIZU47mnNhNEEWaEYTYQNiAlnv5lbC08TvTnmFWJHpXLhOxX+QZVgt31cYchuUYpSQ+6Cu9KABwt/zQvVeTTd4N4z97F40EfOshCXxu/PN5QYkY1FjdBEig/o9skyAehouL7AAnMYsskJfZuMoMSknCLwKK7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crISQ14o; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crISQ14o"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f6559668e1so42220065ad.3
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 01:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718700368; x=1719305168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XdoR7dDOwGo3jbKxBZAZH2beJDRNcPvogbgLg3UvqZI=;
        b=crISQ14o+iaHpAFanv+kJyrDQXf5A+2S5rVx3n30u7Ot6VBTJi5HwWnV81dv1kQ4qj
         XXcmpzbHAMgQuoL3sTHb4pjax/DMYh+Q1zExb+b8UpaUWfM2TE6um2fZJguAvMGmDLTR
         UT0jISRyzkw2+VbroNGMtXrFnQSU/Dz5H0W/FDDQnOeCOgY+Eguhfc8cuBUduMAedyPR
         q8rfw3dDe9mR/c/w1NzlnMWXZJ3KV5g22xWq21QsR4xec1Es0cNf76PrQficCgHpUJ42
         dcIEb9Vg4uhxAcg0tDHKBSvEDZMWvQ47kVHO+fSD/8Ubj4kErWkK3Y+7vpE03UmgaR8Y
         WkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718700368; x=1719305168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdoR7dDOwGo3jbKxBZAZH2beJDRNcPvogbgLg3UvqZI=;
        b=g/6TbXlJahwTx1LgOuaKfLC4SSIN/1q65Lf1S3jONYC6CsvTy1kPRuAxiNwmSkUgOr
         jGytMVlmJvR39h1VJiG2Ktz6qJyT7jj6VQ/JqbmlBimMX7sl9wYFzRyA3oDvymQQaCFT
         c+ckM/HBubZmw3iy/wSgb3ch9xrTFtgIjFt8OvTRI1HAKpfrYCXMeQ1ThD5/brJ+AaUh
         Ziha0vE8j9zGAjZqqyMgwlEDqQnXMRseyrfZ7Fsu7hzuTIZu+TZAdceeN6otQ6Y+5Zei
         xUltLbiiXRMBnLC0SqKL165bI3aPaM03KD7H1SF6Yajm0kWji1uT1Ufs0e11UomNhC8L
         YlCQ==
X-Gm-Message-State: AOJu0YyHtm8nuXq8PGfFthbfvUZftNEVpo/mOXj1Ypg4qvHro/xJJuZN
	lXDyOfRcGHiLn1uTQUCr9bqXU8xJgRqhgkMr1hRmmD/3N/2XMZV9
X-Google-Smtp-Source: AGHT+IEDCcKXR6n3C5g01hCYh6+dVSHa1t1siuL5xiU12UVrGWlZQc36nOmgXJF6HPSTbecajQxNXA==
X-Received: by 2002:a17:902:e74e:b0:1f8:3f13:1972 with SMTP id d9443c01a7336-1f8626d2ae8mr135453025ad.28.1718700367987;
        Tue, 18 Jun 2024 01:46:07 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e6e416sm92501905ad.72.2024.06.18.01.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:46:07 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:46:05 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v3 1/7] fsck: add refs check interfaces to
 interface with fsck error levels
Message-ID: <ZnFJTdHQcHVagflt@ArchLinux>
References: <ZnFCEYypdAyXMMlg@ArchLinux>
 <CAOLa=ZS57EsZk+7xOW9imbA4oWANKf0b+HxBZ8hGFaQQkCsvcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS57EsZk+7xOW9imbA4oWANKf0b+HxBZ8hGFaQQkCsvcQ@mail.gmail.com>

On Tue, Jun 18, 2024 at 04:38:07AM -0400, Karthik Nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> [snip]
> 
> >  struct fsck_options {
> > +	/*
> > +	 * Reorder the fields to allow `fsck_ref_options` to use
> > +	 * the interfaces using `struct fsck_options`.
> > +	 */
> 
> Why is this added? It makes sense to have it in the commit message
> because it talks about the change, but why make it persistent in the
> code?
> 

I explicitly add this comments due to the following reasons:

1. If someone needs to change the `fsck_options`, without this comment,
he might be just add some new fields at top. Although the change will
fail the tests here, I think we should mention this in code.
2. My later intention is that we should extract these common fields out
of the `fsck_options` and `fsck_ref_options`.

> [snip]


