Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1AE44374
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 23:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709251018; cv=none; b=eFJ1XOuA2AYFQ75SzFvBQJ0I7I8JyIRpSM2RcjpukIo3+rPfMiQDRFKuFx/Pk3v6A8i4tZSu0IJbP7GH5DUzfongE6f95MXwZOiY8J8jkoDE9RNPot7JGKMMnnSNmIBpswsioBYc4w+YRf4IIqIsEcLctckpd3lFx+Ybkk1mmiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709251018; c=relaxed/simple;
	bh=66EMacx5OHYcPlolfEE4pVYbydaEWf70PV4LQpz9WQE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HfV6qXw/Q4UXWLNPbvnr/CL0zISRJRbNW1LtSIM38zkJe5hpQD6Z2/EffeRtAVwGlNPqczzE39AlovKv4/Xj5hpdMREdlPzbJ+gT8A4e4L3v5GoEVdEY1zDmNeEOAsgRWg+xZqdNxVNB1Pg0Bgu3SY1Nd1kEvAZ0eVeZD4DhmyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xL10OtxL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xL10OtxL"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1dc4f385c16so14011265ad.1
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 15:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709251016; x=1709855816; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zz96UyalVVXP+/3tPOIKjp8BuAfRHxwcwatWiGkE40=;
        b=xL10OtxLAZPpEJ4shW09TsQjYbEDIPK4vSf4lOiMC5/kZYkOeyLdjzLgBouj2RHdMT
         xnCpqNYHAoEgPFKBynIe5d/fMTigKHZpTOcx7I3kEd9rHZhVpdvfNHWd2PQOOMmQ+Cek
         Qhyrson99WfWmPyFUeN471fTt+r6jCeOgvRlEPQBfckvw5PXdI9OYZPQ6SMlPEZRpW+U
         2vsKBiTlhJWx768Xtroaj869w5CTQoBo6q7r8myNNt30e1bkXbhKilJ8ps1D0c4R5/rZ
         xLsWMaoy8qEpYOAXOsrOIZr7IA6FwSN65/LaFUwb49XIJaELAXGKq81/usOJH2UY9g1G
         5o4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709251016; x=1709855816;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zz96UyalVVXP+/3tPOIKjp8BuAfRHxwcwatWiGkE40=;
        b=GyplcHUv+o4RbC7hY808EX5yiEjlPoLuVXidor9ITT/A5cUqhrw0i0FnQ8xVBw9HXb
         XUG7LHMOdsuJEVQrdU6RkAD/WKxuZWmVPoYSzXBoeXdrjugS2kuv24Yaeg3GxuzWTcIG
         HV1//qY9yWLOzZPpkE8+mWKO6q6WHc9PISU5cLBmu3QsHIYEnbW2ahoGDc5po9KvQaHv
         SHee0xLT6ChCqhrQ6XGXP7nWcZBhGNNnFkuqdgKVagsSeKiqMga97rqbXzkDNYK2poYy
         +RVprUACN/cle6EEsmy7D7tLtP9HbeQh6J264+a/n5wrzrMIpPgCjEt7sHrAlBUB/Q7S
         7BMg==
X-Forwarded-Encrypted: i=1; AJvYcCXIVLL4O8FbjsRjp0AssycVqKy2w9OLgCE2+Q7TE+XZgi6QKYWwPDO/m5AnpI30b3/T0gJdk9vebolJEfeXSMd6kaNi
X-Gm-Message-State: AOJu0Yy/lap0Vna1e2Y4/ZyFBq0nwAY+3lsnUdrvqeYmi/4kGLqK6qIi
	Uv2fVIu/npuiAxR5gdFTlN/qLqzHljCjrcpu5L6MCXKIAi1QlObJqDWml3BjWG8NpIyExabsDml
	60A==
X-Google-Smtp-Source: AGHT+IF+gCtfmH3EW2bW9lo943HeYyco87x7POeBeLNz4VlIRxLjNrdPoWtIFt/g3QvSfRTFbkg8QfjkHiw=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:903:2312:b0:1dc:cc01:747a with SMTP id
 d18-20020a170903231200b001dccc01747amr110plh.12.1709251016331; Thu, 29 Feb
 2024 15:56:56 -0800 (PST)
Date: Thu, 29 Feb 2024 15:56:55 -0800
In-Reply-To: <xmqqjzmpm9b8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <xmqqjzmpm9b8.fsf@gitster.g>
Message-ID: <owlyil264yew.fsf@fine.c.googlers.com>
Subject: Re: What's cooking in git.git (Feb 2024, #09; Tue, 27)
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> [...]
> 
> * la/trailer-api (2024-02-16) 9 commits
>   (merged to 'next' on 2024-02-21 at 631e28bbbc)
>  + format_trailers_from_commit(): indirectly call trailer_info_get()
>  + format_trailer_info(): move "fast path" to caller
>  + format_trailers(): use strbuf instead of FILE
>  + trailer_info_get(): reorder parameters
>  + trailer: start preparing for formatting unification
>  + trailer: move interpret_trailers() to interpret-trailers.c
>  + trailer: prepare to expose functions as part of API
>  + shortlog: add test for de-duplicating folded trailers
>  + trailer: free trailer_info _after_ all related usage
>
>  Code clean-up.
>
>  Will merge to 'master'.
>  source: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>

Doh, please wait for my v6 reroll (will send to the list in the next
half hour) to clean up the commit messages. Thanks.
