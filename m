Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF2714A4E7
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937202; cv=none; b=bsnfUTA6hHYw/vKKY+cjkrAjK6m7LSZWWJLnLAfiQNsGnwqOkVMOX5ekVRFakqhHVxwo2h12CM5P6azBsa/T0OqZALPLQBqixKfBS9pJx+TFYQh2BOtiw2WSpa5qiGMivQkqnPbnXcKd48E95G//PAPmA0lnED1SDYRimTIEPL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937202; c=relaxed/simple;
	bh=E4BFWiE0nxa6PX1/unOrNeSiW2o67dqyc35U1+cY/Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd+D7gqw2YfGL/5ThxG5OBvs4TEfYo3TZcBH60B/TrjB1z/AQ39A0sXQm6GHm/KL/mYAfg16A+7Vo7tJCIxxX5QRGzPG+43H8WQ4D4D/UGJi8cBtsq7+szShBS0G43xF3Rc0jQNjmmuwyQ3Zt3nHg/XPClP6lF9CgW1DJUhqAb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HhJtpvu+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HhJtpvu+"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c87b0332cso308225ad.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728937200; x=1729542000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfvMl/ScEcyxaNGuC5FxaK6GxbNiRhktLP9NYwWWz9I=;
        b=HhJtpvu+Td6OOLySASM24CVVpO7lHqJBnPxrmpe0JezlmpSiPi3n19ke5f+f45MXHl
         LM72pemWGEEx5m5pwmqD7WVog68iRwZqEGp1sZu8KhK8ft5LnOeVMckvVOanEolBuT9W
         hF6DPgXu07S3hEe8UV8YJ538+6V0iagtdJ1AMllu8219pM4cLYJICSSkwJnh+GOr3pU6
         lP9Xm8MAvSZwnS8zkGZTz+TdBRaShURGN+ytAR5OQ+eF94G7iIIrazZZ5XZK6ocn1mtN
         h+lDx67FtnBmfe/xr2INGlwaDBjudk6WwoM1+HNWqj7PYzgdMNTURy9ixR/8WdG1N2Qa
         oO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728937200; x=1729542000;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BfvMl/ScEcyxaNGuC5FxaK6GxbNiRhktLP9NYwWWz9I=;
        b=KfpCvbBHQQlZZ5b9m5pIdXuBcOKPXFZXIxhrFIogfBo/R+4OU/B3SxNOWbUFfNTE5n
         5o6ZozljxrlVxLkTijbtRewp5W0UrmDyizhQuwH9CDtEcxUbYN9Q0I8NPEaH/X2XTqz2
         9XxJkA5q8Gj86aKCRjGWZkPUEUHK94lIMFf5zxOroHtUqI1F6/Z76XfHE9Qy93Ifjpyw
         TP+5CuttCsPIc5ybQ9vltG3LF7Qe1sTcDQFZfjPQjkRSJMkSmJT+VjvqcBDaZyj5ThMv
         49eral2rzTvyabm8LukN5YiVNhgsSv21RjEH9NJc2WAsud0jtbc8g+ehhAamWsVf84u1
         Xbrw==
X-Gm-Message-State: AOJu0Yz+BUZT2uRGPQcyedy7DFQCWq5wj5xt6R8gUSd+MmxJ/43G8+05
	Hdclm/39lUz2J/4YZ5OdyqafW8zrp91odjcbgYCkXWPsf5oAHyiu7Unhfk78Qg==
X-Google-Smtp-Source: AGHT+IHqUzv9ISB2swhi/z/A6pF1RLydpws9MKm1Ek5+7cwpbD+3IbE/2P7RHDnjE5qVAXr5tIk+cg==
X-Received: by 2002:a17:902:cec7:b0:20c:79f1:fee2 with SMTP id d9443c01a7336-20cbce0d44fmr4468175ad.10.1728937199572;
        Mon, 14 Oct 2024 13:19:59 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:2a9b:d27f:d626:2e54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e4dbaceadsm5021563b3a.192.2024.10.14.13.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:19:58 -0700 (PDT)
Date: Mon, 14 Oct 2024 13:19:54 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	ps@pks.im, sunshine@sunshineco.com, phillip.wood123@gmail.com, 
	allred.sean@gmail.com
Subject: Re: [PATCH v4 5/5] Makefile: add option to build and test libgit-rs
 and libgit-rs-sys
Message-ID: <bqrwfci6jcjvvlgbuoohl2dw5ui63p42lgc3ilmbxtkcssvuae@xsq65nk5cypr>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	ps@pks.im, sunshine@sunshineco.com, phillip.wood123@gmail.com, 
	allred.sean@gmail.com
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1728429158.git.steadmon@google.com>
 <2ed503216f8e14d7b516c488caf3c76ffcb15697.1728429158.git.steadmon@google.com>
 <xmqqed4qxior.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqed4qxior.fsf@gitster.g>

On 2024.10.08 16:45, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > Add environment variable, INCLUDE_LIBGIT_RS, that when set,
> > automatically builds and tests libgit-rs and libgit-rs-sys when `make
> > all` is ran.
> 
> Is this unusual, or is it just like how other makefile macros like
> say USE_NSEC (to cause the resulting Git to use subsecond mtimes)
> are meant to be used to control the build?  IOW, shouldn't this be
> documented near the top of the Makefile, e.g.
> 
>     diff --git i/Makefile w/Makefile
>     index 41ad458aef..2b55fe9672 100644
>     --- i/Makefile
>     +++ w/Makefile
>     @@ -392,6 +392,9 @@ include shared.mak
>      # INSTALL_STRIP can be set to "-s" to strip binaries during installation,
>      # if your $(INSTALL) command supports the option.
>      #
>     +# Define INCLUDE_LIBGIT_RS if you want your gostak to distim
>     +# the doshes and ...
>     +#
>      # Define GENERATE_COMPILATION_DATABASE to "yes" to generate JSON compilation
>      # database entries during compilation if your compiler supports it, using the
>      # `-MJ` flag. The JSON entries will be placed in the `compile_commands/`
> 
> It might make sense to follow naming convention to call it NO_RUST
> and flip its polarity.  Those who do not have or want libgit-rs and
> friends can say NO_RUST but otherwise it gets built by default.  It
> would give you a wider developer population coverage.
> 
> Thanks.

For now I'd be more comfortable keeping it off by default. I don't want
to force those not interested in Rust to work around our in-progress
projects. Once it's more stable and we have CI I'd feel better about
turning it on by default (and maybe moving it out of contrib/ at that
point?).
