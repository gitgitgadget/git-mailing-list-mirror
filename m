Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4F61BDCF
	for <git@vger.kernel.org>; Fri,  9 Aug 2024 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723242449; cv=none; b=C9gE3LHlSLs/Cj34O0upiAOKFI9bWmzaS2RXRQ0OjH66xr2tU/EoppzStvpBTIOlGmwB901Q/XfkDKZQ7DE0rRcinzsgsBapvZp846v9D5EfIrp2lzJLx5AsaZRjVys8GGQAbKBQIzx2eK70jHncfouJ2bjVSPHxltBLDeZaBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723242449; c=relaxed/simple;
	bh=/LZ5PDZ6zLrrhvS6FhWQmdto/EZxGJnG3UbLmEMCGjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBW6fCU1HCIcHKPmEhY7fYbz7iFB6RwtryFXMAaHYGqU+MiMH1Od4E3z3k9Q7muqkpWwqK9Fts7M1mABvFfOWNyL+yG2YMl2/g1ZD2aLVcKCbmU5ficIt/nswDOVlNqD5cZXXSIP5KRRROL1IWr6FFRhHa0qmlsri5WwTLqGaA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2GTTJ3KO; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2GTTJ3KO"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db23a608eeso1895502b6e.1
        for <git@vger.kernel.org>; Fri, 09 Aug 2024 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723242447; x=1723847247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1c3AhPTr2QLdgDOTk9B6M9mIt3vGTPa3IMBbfs6Q+Pg=;
        b=2GTTJ3KOTKN01qhdvWJGejEmdGXdLAGwlbTVklZEZaVfs0zmiAu813PoQMbaiHqutv
         ydMfo5rQXTbkNmIiiob4rSarq/Cs6H7wPIHYewAz/fuCvIb/SnvauJsIBolBu4F8KOTR
         x8Rcj/pcRgF6U3Fs5nYhOLGFwyWM50wCcbj0hC0MfdJuFTEn6QGrAoe5I43qgwILixa0
         9z3egNJCTf3jXYsIWmjJ1pK0DK8AB6mHFftJgLixO6h5WJncNtSAyHaV6MlIAmh3nofY
         2SPlFR3c+kgM3b62iOjY7reTVwqN0805G3upInES7Xt23P6JqdtAtXOcBAP0jvw7rILi
         QMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723242447; x=1723847247;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1c3AhPTr2QLdgDOTk9B6M9mIt3vGTPa3IMBbfs6Q+Pg=;
        b=KGxG3Zm7hT5u3960k+Nyih9wpZWCAJ0/93ur5gIMbQTjdTOzkq6E2AivcwqHlDt/Je
         deZ1BvsStcpW1Pap4XUtNCOw/cQDVwvtArr5hE+VODgKg5Hlj6TqNyrEMDCvTKqiIYG4
         /bULJeZR+/YHjvBIzyx6FQyMKH5MMZ54ZDrUAy4GJN80SzikfX4uVd0R5J0JsUAG3plp
         fT5X2JMOEAjXmIqL5XcahhHpFWJjNBusc5QaHrXE3Aggm7pjCa7NccuknjN6Zjl8GtBO
         qByvQ9VPEiQYbsUBXoXs2ORUewjNtm0LTziegJnsIh1M8mxk6qnQmlFH7+8+C+40tInK
         eXNw==
X-Gm-Message-State: AOJu0Yz8s07+8udZMlKkEdUJ3gV70BZ/4jLMQqURqet8W85wu0wChSEv
	o0FtLNaW418MkSy3QnkWS0gqIfZrwbnKbttwk+EIHfp4x6Mkxz8O2IQ8YGzt3g==
X-Google-Smtp-Source: AGHT+IHeK9pCIMvs8aZ5pwJbLMKQO4l4XZDykDUL8JsRE/Xx5axJj0k5iUIzK5MqCYyKt7areDXw3A==
X-Received: by 2002:a05:6808:f07:b0:3d9:384a:3674 with SMTP id 5614622812f47-3dc416dd173mr2944306b6e.33.1723242446868;
        Fri, 09 Aug 2024 15:27:26 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:6126:cc38:1b9:851f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe905f9sm166268a12.64.2024.08.09.15.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 15:27:26 -0700 (PDT)
Date: Fri, 9 Aug 2024 15:27:21 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 0/6] [RFC] Introduce cgit-rs, a Rust wrapper around
 libgit.a
Message-ID: <zjiyu63z55y3eubkov5avdylahz6v37euc4d22obnzrxtzwycq@ah6ejsp4jpsu>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <xmqqbk21cxhn.fsf@gitster.g>
 <xmqq34ndcx5h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34ndcx5h.fsf@gitster.g>

On 2024.08.09 12:29, Junio C Hamano wrote:
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
> 
> In case you are wondering "so... is there anything actionable for
> *US*???", there isn't, exactly.  But you'd need to holler if the
> "merge-fix" you saw in the message not correctly addressing the
> semantic clash between these two topics.
> 
> Thanks.

Looks fine to me, applied in V2.
