Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32707189B91
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 21:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726695248; cv=none; b=rKm9NAbQc1uLzgV/oinl17ywpE4V+UH2aCHsG48tyCCUYx797rUM65KdcGTPKjoAhnUqzKth4c5e8NLw7VRYjyKMqVCyO4o3L6xDqedwOnQSgAdqJZJETpueTs8gLam6UzLs+vLI4Q/AjhgiD8LW54yyQ7vFNbqm7rrrt8PtL6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726695248; c=relaxed/simple;
	bh=KP6IdJNpc3ardyzebs9dbFvNVXBsnYMdN+ay88JvA1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sA0dE7Ldl3HLE6zQ49Q3O30w30UwiJJ7qIL3/LEFobcddZfELgCdZPpFq1xrsSgfY/6l79h9LObo4RAurE0rFhi6ew6mAzRuU8uVXiEh9Ri9qCe4SYOtvckHWyffJeepUKm1BMHs2TtBlgFQk6C/MSrf5nkTYwc5t6X96hyGnpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JlZTbhG7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JlZTbhG7"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-207349fa3d7so249795ad.1
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 14:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726695246; x=1727300046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulWKmlaY0UR1Ow/Vnl7VVMpOKZaxaUF8wy16ZS/+X6g=;
        b=JlZTbhG7NJHFzpbCquYaVm/WHUIFKIIB+qpAGYdZy3bFfLYTP7UovCyJL/Z3cSgXwi
         c4V4afeiOkEqnxl1S9muQyb2e81n8gHieslHAAwOE5SCeslBNQPBZJ9G+1eTcempshpF
         wYEnohmOpbzFj8lnfqU2j5qJc+L76N+42Tu+3J9I3MU9+ZiFQW0oj0qae/C4W8xnqO5Q
         JvC/NnUNatKWnHZ/BUfpqQAGvjEodQhLl5ogib8mQmiWo4hgX1L+mWdFbplEcZ+E+XFa
         T/BETSUhbnn1oipxhN4s5ySOGZqEBqCMkDRlLS0oJUtRP1mWwDoHcFiWTmmsQBqR8gdR
         yoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726695246; x=1727300046;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulWKmlaY0UR1Ow/Vnl7VVMpOKZaxaUF8wy16ZS/+X6g=;
        b=pBYq7GpLLKxOvteKklz1cey3Oi+l69NXrkPg4KD8pazK85nQflQcCRUe5mQ4XoDD2Z
         G7TAak0wqRvv2EGszfn2fYYmvFV7QXoGgoDaqjHSADLP3QR5RJUvOFT6KgTg9AEPuQhI
         oF3nYdgjat/7oX9m3msywdtJSO3+Tte6V1X8c/VO0b9WN2HI5AQOM3HGCeQskMbN5P4m
         9WBORJxL6Ue/XxTKxgEHPWVYqh+xYhgm1KXla/QkIyZhpdDmB4UvJvZshsvCNJg2g6xj
         gjfgP7t4G2YXcezET9gcJB54TFz2XKOZyKSqaHvxIToeQ5PhjcUkIxCDRpTpL9onE3eE
         akQg==
X-Forwarded-Encrypted: i=1; AJvYcCW4h6O2msGh0fb2TuPnzUTLEl0U/o6VJQGGeBmkIv1kFJyH0WjG1/c0sfbjkZ54T8ACm8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAZaecllE5N2/Wd9kt2zwFpsaYVJphyDVvF+qog7WpUwbRnCp5
	hzZZGKYICKjYJAxKjbR24KbUegHis2YQpfAgJ5fZn3AF6of52Rm8KrCIF8AH1w==
X-Google-Smtp-Source: AGHT+IHm50y7Oxs38nDsCSKzXyPjE/4XZZvx67h+nPCvgoTqXziBKxJqCkbusXAfFaiChRRO454z7A==
X-Received: by 2002:a17:903:110f:b0:205:3bdb:5515 with SMTP id d9443c01a7336-208cd56943fmr502945ad.4.1726695245824;
        Wed, 18 Sep 2024 14:34:05 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:8e56:45c4:ecbf:a6fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef31995sm176425a91.41.2024.09.18.14.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 14:34:04 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:33:59 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, mh@glandium.org, sandals@crustytoothpaste.net, Jason@zx2c4.com, 
	dsimic@manjaro.org
Subject: Re: [PATCH v3 3/6] libgit-sys: add repo initialization and config
 access
Message-ID: <by74rpfxx2wv5nicazhhzel6hivogmajcro6736dj2zzpwadbv@h6rzhjrvd6bq>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, mh@glandium.org, sandals@crustytoothpaste.net, Jason@zx2c4.com, 
	dsimic@manjaro.org
References: <20240906221853.257984-1-calvinwan@google.com>
 <20240906222116.270196-3-calvinwan@google.com>
 <xmqq8qw4uz1q.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qw4uz1q.fsf@gitster.g>

On 2024.09.06 16:45, Junio C Hamano wrote:
> Calvin Wan <calvinwan@google.com> writes:
> 
> > Wrap a few repo setup and config access functions in libgit-sys. These
> > were selected as proof-of-concept items to show that we can access local
> > config from Rust.
> >
> > Co-authored-by: Josh Steadmon <steadmon@google.com>
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > Change-Id: I6dd886af8c63e1f0f3251064cd8903aecdf768bb
> > ---
> 
> 
> Common to all other steps, I suspect that you meant to but forgot to
> strip out the Change-Id: thing here?
> 
> Also there are a few whitespace breakages in this step.
> 
> Applying: libgit-sys: add repo initialization and config access
> .git/rebase-apply/patch:129: trailing whitespace.
>          * for the existence of a key rather than a specific value
> .git/rebase-apply/patch:138: trailing whitespace.
>         unsafe {
> .git/rebase-apply/patch:143: trailing whitespace.
>         unsafe {
> warning: 3 lines add whitespace errors.
> 
> 
> There is another one in a later step.
> 
> Applying: libgit: add higher-level libgit crate
> .git/rebase-apply/patch:325: trailing whitespace.
>         // ConfigSet retrieves correct value
> warning: 1 line adds whitespace errors.

Fixed the whitespace errors in V4.
