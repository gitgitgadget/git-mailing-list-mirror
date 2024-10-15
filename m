Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78831189BB2
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991442; cv=none; b=py/dLU587tSRS3gJ/D0gWv+nq8vQQqYJzJFTgvmnX1btjbjvAMybxteuur5kwmQ6IpSCoeO780ucsvGsBADcGrTOVxx2NfUhqp/3D/BoiRRTbf994HzUsPO5yjdy+rd5/AHSZnjGhrShzdWf+rqCGeZWGLY4bSONPhvSoiQjBXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991442; c=relaxed/simple;
	bh=7tamI2GL+PwiiXZ5F5/rpneBQ1vhYhZziLhsrCteSoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H90oaDq0ZCu+LnJ8Lw3/n/jVe9cazzTI7mQjK0lgpCNrKSR2MoWq/+MfBB8ui1gDkG8+R2pTeo0Rz0+63mvh556sM8ANsmHhLiqxGcXLEylHpnNcI4md7uX8A5y/bODuY0QmZw3OF3Bki1CClVgqIrOmOBS556R2L0b0WBX+jxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2Borno5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2Borno5"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-208cf673b8dso55090855ad.3
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728991441; x=1729596241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySN/DyTFuJ4y9+QDNH5YOvOtsUUmRF+7VacJjvJT1fc=;
        b=J2Borno50uUrb+asUrG2m3jwek+pCjLu82zLNpR48j7Wayww0lqdPX1GuwKJAFTRdC
         KsW3XxHJsEQSIU5cJdCdY4+iHs/3Cd4/or6ZQ5ubmzPhTBZFabdl/60rGfmdLNmakj9D
         uF1Bw25dMTYPbQrEYg5WzXm6PYCMdrVQTTzIJ3Qk8fEHn+0W5zA46iRtKFxzRcB7bzrZ
         iPFlKI6f1kKSPLTInREwC+u76osAC/Yxtq88d67U9vbqDUVwKwKnrumOgYOMwSADZkGG
         E9bxN7Jlpenb3kbZBd7ULLFQhiWSSzG3TjERDWobLdh0DwB3C760ys0jNAEcJ2XtLyvT
         /vxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728991441; x=1729596241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySN/DyTFuJ4y9+QDNH5YOvOtsUUmRF+7VacJjvJT1fc=;
        b=VpM0zpvC0Ug3PCegDU8nAAVU9csB9TrQlaidkwASbjJUmQaGhJIKJxP+MISr8W0tac
         +lyDzLhEzXUl8Yammt72QjJovswcasuREMxqC+Sy4nK4pVpP/ipOGpfFrgij46QNqAH/
         +J4MTKfllUPWbsh+CZnj0fK+80M4nwjkbV7TiXoC231jyw0+eY0Iueru98uDRTiiHrhv
         90f5TeoS/57/zbhHdC/85aysDOvogxcL5vR2DnVZ+auvOlaeVLUPxSRmwBUrhCV2jQzf
         zfN5gJ48tOwfksNg2OwonqRgK3Bw4eCUAzp7adaTfUVEq8+lP7kbvkqkP6gIQopeIVL/
         uWDg==
X-Forwarded-Encrypted: i=1; AJvYcCWFzuETiQqWhJnx99L/YTbGzFe2//mgCYpWbAV0L3ePxh5rgdmbWKaVnS+hrTM9XL3Lijw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWCuCxLJGAbL0nfjlM+Rv45B02rMeESwBZeXjuFqwnmckULURN
	OFDcWAmGmlP41FVN5QCTE4QolRsPPTdgKmcVhNQwiEtt3s1Eb5k4
X-Google-Smtp-Source: AGHT+IFVZxa1l6gvlxyhjG3t+b55xRRjMcCZkYAQfEtRL8qZvdFETLz80vD1nO93gmY/FgM4qPxM3w==
X-Received: by 2002:a17:902:ec85:b0:20c:774b:5ae5 with SMTP id d9443c01a7336-20ca1429920mr233694735ad.9.1728991440633;
        Tue, 15 Oct 2024 04:24:00 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f84e16sm9940555ad.61.2024.10.15.04.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 04:23:59 -0700 (PDT)
Date: Tue, 15 Oct 2024 19:23:58 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/10] reftable: stop using `struct strbuf`
Message-ID: <Zw5QzmtOrDOXAavV@ArchLinux>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
 <Zw2e0w5bkDO4l/Qs@nand.local>
 <Zw3xkX_a4KyrSNq9@pks.im>
 <Zw5E8d3AotDBYKSA@ArchLinux>
 <Zw5HntIyk_DLWESC@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw5HntIyk_DLWESC@pks.im>

On Tue, Oct 15, 2024 at 12:44:53PM +0200, Patrick Steinhardt wrote:

[snip]

> > I have read some patches yesterday, I feel quite strange that we need to
> > make repetition. Could we provide a header file which requires the users
> > who need to use the reftable library to implement the interfaces?
> > 
> >     reftable_strbuf_addf(void *buf, char *fmt, va_list ap);
> > 
> > Thus, we could reuse "strbuf_addf" to implement this interface in Git.
> > As for libgit2, could we let it implement these interfaces? Although I
> > have never read the source code of libgit2, I think there should be some
> > code which could be reuse to implement these interfaces?
> > 
> > However, I do not know the context. Maybe the above is totally wrong. If
> > so, please ignore.
> 
> The thing is that we'll have repetition regardless of what we end up
> doing:
> 
>   - We could either have repetition once in the reftable library,
>     reimplementing `struct strbuf`. This can then be reused by every
>     single user of the reftable library.
> 
>   - Or we can have repetition for every single user of the reftable
>     library. For now that'd only be Git and libgit2, but we'd still have
>     repetition.
> 
> The second kind of repetition is way worse though, because now every
> user of the reftable library has a different implementation of a type
> that is as basic as a buffer. These _must_ behave the exact same across
> implementations or we will hit issues. So I'd rather have the repetition
> a single time in the reftable library such that all users of the library
> will behave the same rather than having downstream users copy the
> implementation of `struct strbuf` and making it work for their library.
> 

Yes. I agree with you it is worse to let every downstream to implement
the interfaces. I know the motivation here, we want to make the whole
reftable library be independent of the Git which allows the downstream
to easily use the reftable library.

> Also, due to the nature of `struct strbuf` not allowing for allocation
> failures we'd already have diverging behaviour. In Git you would never
> hit error code paths for allocation failures, whereas every library user
> potentially can.
> 
> So we really have to treat the reftable code base special. If we want to
> be a good citizen and be a proper upstream for projects like libgit2 we
> don't really have much of a choice than to detangle it from libgit.a. If
> we don't we may be saving 20 lines of code, but we make everybody elses
> life harder.
> 

Yes. And I do not think this is a problem right now. Thanks for this
wonderful explanation.

> Patrick

Jialuo
