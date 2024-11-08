Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2731D5CE0
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 04:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731039070; cv=none; b=i+jz3uEQySBepBlyXpaJhuMPbGYEpAkwNJh+nWsdbgBosrnkiDv1asmyXrxs+YHi59wBnjPfqHCYkHD0ktxE1EFrG3carVH2a4PIK4oDiaWzmxTvTAqsDz0uYrdlJCvdpIKcfNoAly0CtSb+Lvnpy65Z6R+9iMH9C1+7/5zk7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731039070; c=relaxed/simple;
	bh=Wc84bBQMz9Arjw01UJ3rvpNDy6rnRY0PJc7C6Rsbxqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yb5tPZEbVuvLC1q12140FUFDXwT0ufZZXEojfYMTOBPUV8N1jvxDrXj8AntXAt5SUfQJmFzwrEPBH5ePATPA3E/KK2Un/R0niq+TbQZ7PfdKmsf68DzBFl2JDwllfDIVdHxsQE85poZPQ09Q7twNuMoK0rbT9D3N/cYbp4W9TsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8KEp6VP; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8KEp6VP"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7f4324503d7so200841a12.3
        for <git@vger.kernel.org>; Thu, 07 Nov 2024 20:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731039068; x=1731643868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nKGr7RqUamjQlJxI8qJlbALK6PiNtmk0yYIK9Ndi/pk=;
        b=J8KEp6VP3KqU+tY8UkXbnzjUvzZIMlGlKFdYQTUsA7qz4ztQVL8bAR1KT/OdSI0KRj
         Stnkc9SciYD7Z4wIiD8YEvHeXC14WoOPJUi66jOBNS81Xx4fYhjb/tnM6JP2LqSbrS9K
         r7+xVKdHF9nwLgisgoV5AGqA346oexU4Zjw+5fPrRzzMj78tfmb6XKKPzhBoXt8nXNHU
         cwyFhd/1x4mG40In1sxWs4YTogLN3jLJ8nj56RECuj2EujMyOF4F6+JhfLPKqR0tHzmA
         8ZaqpECwwEpgQl5kOpoLJ7uEnaYap23MytuL1maxbeQy556p4wNoOojhj3Tg6J4c19v8
         H7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731039068; x=1731643868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKGr7RqUamjQlJxI8qJlbALK6PiNtmk0yYIK9Ndi/pk=;
        b=D9ApgL9ER0ziN+SLdtfOenE04O82sNMvBUUlwBu2vIRW9OPdRFf6T3/XtUbIQ6i88M
         rsWypsUQFFRuOQPWQbskn9+OS1lgPfhVKm4YBWxIwvXFVDT7fksS/SL22OL5ijCS+VOR
         0NVYeTMYvDHVLXMpWA6lNd5xBMnXzY9vYyGVz9bIfA0L4lP3Oo7Km/3aekIQmasnpng1
         hbO7JU/IzW00t9pT8NTSG9uww6tiz8td1fYsRxAI0RUN7YHQl+KbONx/I8x8Tb2xfpPK
         7u4HeIOdN1TpR/Hqh5+iICEW5wmGO28U3CDXXujRxhCXhFm9kmgUxuIemcL78ovG4FLr
         cDAw==
X-Forwarded-Encrypted: i=1; AJvYcCU+nZ4hXWT+pceG0OgU1ufZF82ytvpWVlrPZlbfE6NAIFXZyZK5NVVoEdPVRELsxWLkQuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkQYWvs5DDhp1UVneKfxfEhze8AAbrawXzYlwaq4wbNCipbuwC
	lyS80lsukTtEDP8ZSx+dG5mP4w13gwhSyZ8ooU1dTEyeYUbYlWn2smhp5brb
X-Google-Smtp-Source: AGHT+IGGvSpz+2zzeXPV+P3X4met9OhGtfHLM1sOzdUzn5qlZedZlyejQOifRs9ok4Jjb/GxyD8snQ==
X-Received: by 2002:a05:6a20:6a1c:b0:1d8:d880:2069 with SMTP id adf61e73a8af0-1dc228395camr2222351637.3.1731039067945;
        Thu, 07 Nov 2024 20:11:07 -0800 (PST)
Received: from five231003 ([2405:201:c006:3236:2e5e:371c:c4b8:e158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a3d38sm2672125b3a.122.2024.11.07.20.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 20:11:07 -0800 (PST)
Date: Fri, 8 Nov 2024 09:41:03 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] t6300: values containing ')' are broken in ref formats
Message-ID: <Zy2PV+yywkS64D1p@five231003>
References: <20241105190235.13502-1-five231003@gmail.com>
 <xmqqikt1qhwt.fsf@gitster.g>
 <20241106022552.GA816908@coredump.intra.peff.net>
 <xmqq8qtxqcye.fsf@gitster.g>
 <20241106185102.GA880133@coredump.intra.peff.net>
 <xmqqo72rvjqk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo72rvjqk.fsf@gitster.g>

On Thu, Nov 07, 2024 at 11:52:03AM +0900, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> [...]
> 
> The implementation may be a bit involved, but shouldn't be too bad.
> 
> When .str is an empty string in if_atom_handler(), we can follow
> what the current code does.  If .str is not empty, allocate a new
> stack element in order to parse the .str to its end by pointing
> .at_end of the new stack element to a new handler (call it
> if_cond_handler()), and pass the if_then_else structure it allocated
> as .at_end_data to it.
> 
> And in the if_cond_handler(), grab the cur->output and overwrite the
> .str member with it (while being careful to avoid leaks).  At the
> end of the if_cond_handler(), pass control to if_then_else_handler()
> by arranging the if_then_else_handler is called, imitating the way
> how if_atom_handler() passes control to if_then_else_handler() in
> the current code.
> 
> Then things like
> 
>   %(if:equals=%(upstream:lstrip=3))%(refname:short)%(then)...

So if I understand correctly, we grab the .str and operate on it so that
we expand the atom within it and then do the comparision.

This seems nice, but there is a problem.  Since we always look for the
first occurring ')' in our format string to indicate the end of the atom,
we end up with

	.str = %(upstream:lstrip=3

(the call chain is

	verify_ref_format() -> parse_ref_filter_atom() -> if_atom_parser()
)

Since we have now left out a ')', this ')' gets appended to our output
buf, which would also show up in cur->output when we do the comparision
in then_atom_handler().  For example, in this case our cur->output would
be ")master" instead of "master" after we get the value of
%(refname:short), meaning our comparision always fails.
