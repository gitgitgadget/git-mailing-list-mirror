Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D7B17756
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720581659; cv=none; b=nSfHN/vMHx0duXffurKxj23QjE3EOs0eJFZe8Ad553+OWYFAbXpPiHFhWjsjK0EDg1LCMcBpgZ5qejgUvLu4cJeIzEasAFVq+uBI/C+Vi0ob28R+DaWnABUq+paGcSnmTmZfgOuwNxsKElXhtAyashcn7GAt4NL/4eBYhHKCAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720581659; c=relaxed/simple;
	bh=xySIMXZ9r5aHXd8Gz4YN9iXeSSwUYkpbgPUswoAIV9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqhgjinJgjIWj7OMjQKIoFo3b5RPzcJUGf2ltd2LifUzlujn03ylajpjnzCvZTRdLXiXbcVeNtFmTzhliVof16Qy0hUcnATefQW3tt11J3IRG9mZZv3ktYW7i85ZuaSJfMTdKyH1rHoP+bQBW1IT1LBB2LzTnaiBSRgLNg7g5Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzEzUEbc; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzEzUEbc"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70b04cb28acso285788b3a.0
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 20:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720581657; x=1721186457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cLZW1UICnO4kF4vQLJO2z7HOd+lq8HqDNm/2HmXGsyU=;
        b=NzEzUEbcsEDCeVOlWDvSRz6c2Z/v4X1VuiJZs4uhc8t5NL6ViCXStncIY5ciOV7uyj
         YJRfgFeqUdgp6nedlAUYlnOkSxhYftyFQX1Nzo0iwbGVGgt32ib/ocri+fUPgIsoxXU0
         ImB3BkyqcZ6YEZbPpxaGkbUKBWFqrXAPuxZmj1R7JdniOwDP4vQ5xkiefqgc0mg807Yj
         rE9G7JZRmJ/qHdMPqQaGrz53yXMe8TCCvBAW6NF7hbVSebqUi7efB1glqmDZCPPwWk0v
         gKUp7iTO+OnoXPmxm0gxDdr9Pka3PR1BU+w8iqCq6sjW92jojLrAt9f5oxqMrD76X8qd
         rfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720581657; x=1721186457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLZW1UICnO4kF4vQLJO2z7HOd+lq8HqDNm/2HmXGsyU=;
        b=wRnkT0rs3jnecg0PL4qkS1tT7OKakkYao4K6NeiyWtK3fIGjEgjTmYA6P2D0FJkvj+
         +NP93ldojydzqGXZHIUz782A/luhjADOj42eaoXhaCncUQNfs+yMUX5gEsAI/T+kJDa8
         YHKT5DpXftNycafk5LACrAor/qpQLy1ypUoNQtMYDJCLCf3Nfk5OEO+7tiOQPa43xvrf
         daqY6anKkWSVgJy81laYXGFqNWKmH37AtUbyiIhyW7LnrueVdKSLFQXvJ6O2A1paZA+U
         +aBuZ6u1tTQiaubvu8uInYqreSrExLu3zVgPi1NNqiO3EbCbw8s4+4IBAR4afCabIMha
         vlSg==
X-Forwarded-Encrypted: i=1; AJvYcCVeHjszfQ5y2bPop52ck8hANgtSKXIDAVtLPp6XdqI4dTW2PSNTJJRA/j0sIuX+j1SnzPmj3+I6iKF8Zpk6Ei3mfiP4
X-Gm-Message-State: AOJu0Yy+LDrUeB057bM2K21oqPNaeRvqPB5vUozR7MuH1dVx0zz74eUP
	AkKIAmwzMeXjtVXfbLKsedSFoNBF1WTGWj9iTJFfr6YP476tXtoR
X-Google-Smtp-Source: AGHT+IGLh8txbYE43axSqkwiGN3yDgJF2ZSKYwdZoGmldqnYb96NvghciOXLjw02gi0YieVcKQHuDg==
X-Received: by 2002:a05:6a00:1791:b0:706:3d61:4b21 with SMTP id d2e1a72fcca58-70b44d46073mr6369326b3a.3.1720581656804;
        Tue, 09 Jul 2024 20:20:56 -0700 (PDT)
Received: from localhost ([14.191.223.217])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b5f86sm2597090b3a.181.2024.07.09.20.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 20:20:56 -0700 (PDT)
Date: Wed, 10 Jul 2024 10:20:53 +0700
From: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh <congdanhqx@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Nathan Royce <nroycea+kernel@gmail.com>, git@vger.kernel.org
Subject: Re: FR: Provide Out-Of-Tree Building; Provide Cross-Compile
 Parameters
Message-ID: <Zo3-FVT5EFyKsdGc@danh.dev>
References: <CALaQ_hoDqD6CXEDy0YT8no3SaoJSqV6toMtyRHdJr6h3RZUiLA@mail.gmail.com>
 <CAPig+cSB0d7aAwMpToLCa+6Be5JFqLAr+0pvBXQxg_=DEk7p2A@mail.gmail.com>
 <CALaQ_hr2Hzri6y4KwYOPmGzfvM8EjJpddvLL7CQ=d3H4QLCzJw@mail.gmail.com>
 <CAPig+cTaH+TiD9Ut5Q_BPinqdAirW51J56R_tUTSnL=XGzxvfg@mail.gmail.com>
 <xmqqjzhvejye.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzhvejye.fsf@gitster.g>

On 2024-07-08 12:56:41-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> >> I'd still suggest and prefer that git (and zlib) follows what others
> >> have settled on doing to be cross-compile-friendly.
> >
> > I can't speak for the zlib project, but for this to happen in Git,
> > someone with an interest in seeing such an outcome will need to submit
> > patches.
> 
> Sure.  
> 
> Somebody unknown to the community suddenly coming here and
> suggesting a feature alone would not achieve anything.  If there
> were infinite engineering resources and motivated contributors, and
> if sufficient number of contributors thought something is worth
> doing, it would already have been done.  And "cross compilation" is
> one of the things that is so obvious "isn't it nice if we had..."
> items.  At least the offer has to be a bit more, like "I'll help in
> this and that area (e.g., organizing the effort, keeping track of
> progress, researching dependencies, ...).  Any others who want to
> join forces?"

I thought in Git project, Makefile is the official build system, and
the autotools build system is only an after-thought, no?

For cross-compilation, I think various project has been
cross-compiling Git from forever.  They only need to provide a file
named `config.mak' with proper information for that platform, e.g:

	cat <<-EOF
	prefix = /usr
	CC = $CC
	CFLAGS = $CFLAGS
	LDFLAGS = $LDFLAGS
	USE_LIBPCRE2 := $(if true; then echo Yes; fi)
	perllibdir=/usr/share/perl5/vendor_perl
	HOST_CPU = $(config.guess | cut -d- -f1)
	ICONV_OMITS_BOM = Yes
	NO_REGEX = Yes
	EOF

Those last values need to be specified manually because they can't be
detected by running a test program anyway.  Those keys are already
listed in Makefile.

-- 
Danh
