Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6229A84A36
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909405; cv=none; b=XoGXE/GNc64f15rHfXYbqwB7mwWcUJcuD4HmQEa47j1ELP5MBD4ojmuJpZXI6cunHB26tt9TgymC4EZimKpD2CQRBDiuHQdzyTWEEl9+qkbdCvIsiU+0UkpR83awIIP8ppeFKnDhN6dc+XQG4JtHvuwRsQI5y7IURZdPQyUL1ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909405; c=relaxed/simple;
	bh=h/hthzGeGqnEZQIC95xVLE2eqzTfwBCZki1cYG8w+3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMs+ZF957viyd6EPabfys5KvlqtEtEZywzI5pH5elAT4rPTQTbT2jgkGuQ43FF+imndNQn+SSSJh4yTFy+gdy/7zk+o/hV0SjoYES7Dywale4qFjF/0Dj8MwqrkkfJUHnftS5ByVndvaDjVYFqo4Zi6cKOQM9nzaI53sFRAw/s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AyCyguGt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AyCyguGt"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b061b7299so41275ad.1
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 15:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727909403; x=1728514203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77r9/3F0goC4wHoJpHdatzpGLRXfM4FIIMZjGWPIEEQ=;
        b=AyCyguGtb/w8alGyVwswaShWbgXfKg8Krmgck9oRJDH9F4FgR2z9YAjQL+mx92xkWX
         84a/154htAwOWSGha81tsOZSvV9fngRrxohHgcMNq+kGDTmogGcst8vZ0VPWlbvb/1od
         Wmt1Q9sOs5+8e6od/zDNXzQLyufcQnkxOCiW6+/+HGvi0oPDZNm8KhZ/fU45AswuU77A
         3PnL/yvbZ8+/qAdtfd+UebnC5+KMkAmJynedm0VhT4LFwz4KfGH1smglwDEGi1n6wcm6
         ZJeFt4MUAlP0F2Sj3cjf74PcjHjxIlTqgXFnQjE9IlkXt6bqhx/qVfjxx375v/1j2QPs
         Ri9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727909403; x=1728514203;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77r9/3F0goC4wHoJpHdatzpGLRXfM4FIIMZjGWPIEEQ=;
        b=k4xTxjh7FkVeNbCSdVLzm0Y+sjSwv/MQUlNyV8sUwzWgMiBXeLP/jboC1n61s63I+f
         BzCrxiNl8Uqn2ryJD0OV1c50Qy5qsWqtvXLDnH8E82gvoHUsr1ITBEuf6uRp/jyV9aYI
         8givx2buisoNyGrRw2JF+Esutyl+2roNDXJyAApXPMxwVsLf4CkDUFgouVFMexMa04W1
         6yWFlq2g026GAgHveSycjw++lM6E1RTykHBeRbNNKqFsEBA3GEzODSAIyU4cydxw6B8T
         VI1kBEWYAEmSWZ1k6PQ7+QQwItDocUJtO5Vj8kohQ1lWOJiRqSAYrPiAzHuABNRBhUZv
         Ai0g==
X-Forwarded-Encrypted: i=1; AJvYcCVYm8DWD9IPCpanFMtjSuiM849FDyQC5ELyjesOUIzKZhKB+YdDH7hJDeZYyuH0Q7Ob1Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLNS0L+oLZ619TqdB2jQlanCLU859kShPPSpgevxvm5NK970hj
	WT+frFNOs2CFKFf2KxsJF8YKYy52GezHX+9/+QKHP8hf7gQPqAPajtzE9VP2jw==
X-Google-Smtp-Source: AGHT+IGf5QCgjK5vqa+p/qZGXf6j6SXZIbZ+yr1lTjv2SNU6sgDCGKMoVHAE131yLY+px9AtvHqZ8Q==
X-Received: by 2002:a17:902:d501:b0:20b:bc5e:d753 with SMTP id d9443c01a7336-20be762937dmr446635ad.9.1727909403386;
        Wed, 02 Oct 2024 15:50:03 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:2dd:9410:f675:e07f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18fa04fe6sm2188541a91.45.2024.10.02.15.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:50:02 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:49:57 -0700
From: Josh Steadmon <steadmon@google.com>
To: Sean Allred <allred.sean@gmail.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Subject: Re: [PATCH v3 6/6] Makefile: add option to build and test libgit-rs
 and libgit-rs-sys
Message-ID: <ccfkvquzswf62gymxcbq3iubkac7y4ttmlekw3xx5rjcho24bo@423w2fb5ogzw>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Sean Allred <allred.sean@gmail.com>, Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
References: <20240906221853.257984-1-calvinwan@google.com>
 <20240906222116.270196-6-calvinwan@google.com>
 <m0seubo5q7.fsf@epic96565.epic.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m0seubo5q7.fsf@epic96565.epic.com>

On 2024.09.07 10:15, Sean Allred wrote:
> Calvin Wan <calvinwan@google.com> writes:
> > Add libgitrs, libgitrs-sys, libgitrs-test, and libgitrs-sys-test targets
> > to their respective Makefiles so they can be built and tested without
> > having to run cargo build/test.
> 
> I feel like clippy should be run as part of these somehow, but I'm not
> sure where.
> 
> > +libgitrs-sys:
> > +	$(QUIET)(\
> > +		cd contrib/libgit-rs/libgit-sys && \
> > +		cargo build \
> > +	)
> > +.PHONY: libgitrs
> > +libgitrs:
> > +	$(QUIET)(\
> > +		cd contrib/libgit-rs && \
> > +		cargo build \
> > +	)
> 
> We should definitely be setting `RUSTFLAGS=-Dwarnings` as an analog to
> `-Wall` in the C world, no? These crates should build without warnings.
> 
> Very excited to see this work; thank you for putting the time into it
> :-)
> 
> -- 
> Sean Allred

Done in V4, thanks for the suggestion.
