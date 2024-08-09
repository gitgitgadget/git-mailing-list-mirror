Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AB416A947
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723242527; cv=none; b=RpE6zRfJHgwuFgsaMjf/fReKaWeWN+A64K8yuzIq8OOR1C000F2q6EaRrK/BTugWr/FcjqSDsmqwWSshSZSwOvD0mzS/tY9hw2F1bt7tzBPfnh73AYAHJtVVuv4c+d6RRYe5lVHeuf1nI4fi893fwDH/AdefvxykbouCrCXwKGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723242527; c=relaxed/simple;
	bh=po9PlM2ZplSMXnUx7DO9LuGlsg7wAbzkAvxlKQmB8EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VosrCIHdDb0UYpIurNClFTMjAii4Yp8CzHk3AfyHA5fqHj9RdhBAKIsX2v/FBiN5XXE4talQtSTGtoerNFVj5cLI6t7P8iNfn+wtp2jKE5FBwVAURsLRufTYMcksAcUJ4/+VaKABPEDpeET7YyvomN9z98IxYrJ7anmtsLjxR+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BjjssRRi; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjjssRRi"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d9e13ef8edso1824189b6e.2
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 15:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723242525; x=1723847325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tq/hoKgoYtpPNpnP15SXA2VqL7QnyjmIDw1Pg41lb9Y=;
        b=BjjssRRi95ATRfUgVPYdXmalOM6CiizTB4BCbOBUnupZCqNAFU4Fz9W5GWbbI4MVWh
         b5ZwSuTOPqQ8XxVXc7MkIF+dE/qsLvyaNqoTN5PZGf+TlaiUYI0oSqwflXvLxYD5ZGQa
         NvlM3fPl+CRO8sVEVH65UCL9lhQ6SQfd3UEpmkC9QN/IMbgzFdlR0yrf1CX/oEz4tY1K
         o76qfLJIj723azeUMY2CqNZioRogKt+zRaaz+EHLxKbOIMU+/FCZHCxJOJiVMnBl1Sso
         /h/Vxh4ooJvJr3qsxp6TrTQCBdetxByLRC63dayieB7YsutgFbMqLQ+g3aQMVsHtNMJX
         cWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723242525; x=1723847325;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tq/hoKgoYtpPNpnP15SXA2VqL7QnyjmIDw1Pg41lb9Y=;
        b=YS7sE2Oeu7qHczlSwe18bXJ0dWAc8gontXkMLHzrHlb7prGaOSkRTM+A4GXQFGpOi3
         UP1J2Afi2njDF581LdJ/r3hST3zVZp/Fr6XQ7lDhczXb1qyLr/TlmnPBCu2CXn/Oln7g
         Nv9y51QgVrCEnSh3Fhpd8gUdboRgV07SR7UgmNNtKiQvYlGzPg2ofPpg6pllyBjHQXFn
         2sJFwp+oJQBovAn2pPTWbbzde9GMtKrjoz1714xk09JF4GspWY0d5VqAaLneGHOsfkEq
         oG9cJ0A4Ect+tBVYdaIypWDTXyDZplcqEiyp94sjQcXBoUCS8M+n1FKKyu/vtaDMOxab
         Jm/g==
X-Gm-Message-State: AOJu0Yz3w+AS4SgMQfNyAKasPnBPFBltrY4+62OsaC3kzaf5M7/1fOeo
	4JC+aHvUtKZPU7xVkYFMs4IUDjOvH3c34FsRlDlxmWfYykr7aveRghl2Fm4gJC2oUp4JWdxLUSi
	25A==
X-Google-Smtp-Source: AGHT+IEK4iQfEjpJVkA7WpmI2Jlx+bHMz986D9/dHMKBxgr3nyVs4aKIVnxjof6/9PtsZgQsPmby4w==
X-Received: by 2002:a05:6870:7007:b0:261:a26:9319 with SMTP id 586e51a60fabf-26c62cec707mr3330169fac.24.1723242525296;
        Fri, 09 Aug 2024 15:28:45 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:6126:cc38:1b9:851f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe03c4dsm176166a12.3.2024.08.09.15.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 15:28:44 -0700 (PDT)
Date: Fri, 9 Aug 2024 15:28:40 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 0/6] [RFC] Introduce cgit-rs, a Rust wrapper around
 libgit.a
Message-ID: <jennrdjgi76ev4npmklozfpwfijmxttulwsp2h2pwqfuysyjvb@2gw3qyyt3su4>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <xmqqbk21cxhn.fsf@gitster.g>
 <xmqqv809beoe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv809beoe.fsf@gitster.g>

On 2024.08.09 13:54, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Josh Steadmon <steadmon@google.com> writes:
> >
> >> We're sending this series as RFC because there is remaining work
> >> we'd like to do, but we'd like to get early feedback on this approach,
> >> and particularly to ask for advice on a few topics:
> >
> > I am not sure how much this is reusable, after seeing comments that
> > "cgit-rs" may not be the best name for this thing and pathnames may
> > have to change, but I needed the following merge-fix to get this
> > into "seen" and have the result pass "make", due to interactions
> > with the ps/config-wo-the-repository topic.
> >
> >  contrib/cgit-rs/public_symbol_export.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> There is another thing.
> 
> Listing this file in $(OBJECTS) means that you should be able to
> pass "make sparse" to build contrib/cgit-rs/public_symbol_export.sp
> but it seems to fail rather miserably.  I am tempted to suggest in
> the meantime to futz with $(SP_OBJ) to filter it out in the top
> level Makefile.

I believe that I fixed `make sparse` (at least in GitHub CI, it fails
for seemingly unrelated reasons on my desktop) by removing some
unnecessarily exposed symbols in public_symbol_export.c. If it still
fails for you in V2, please let me know.
