Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0541145B38
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723073402; cv=none; b=bFM3OJiPyW/gDwhjeU9u5sT/wXLMIt/6EwbpQizRHaRPNPFsoIU2vvnl7ZIQly6hr5sgUZ0Ufs8JOZWIO8J8myqU2NuZ4D9IHNJ6BVRTiZ8KNfpMc/JpV3OOyWtZJHI/+SOZJ/337s71srVrGZ/CRNSalj7KEZiQVm6GyrP+R2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723073402; c=relaxed/simple;
	bh=adU+NFFZPUkMR7LtdZuvryhSHWh5TRtWpW9qaEEWNik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFS5ZQ1tS4HmVg7f1p6gD3MY4/H17oVSQF0CWEIaywkcn/FoMlrWr+L0+hlx29WUsKtlSbtxlUb6QC+ragqD5TNWko0qVp/fkmOLQjEShWcgBMKWeY/dH4BGQJsC3ALV5TR+S3X7r7a20Pjd6jvUdrkcxkZx0FPK4jy9dyARBQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zSuYtlrT; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zSuYtlrT"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5c324267aso219034eaf.0
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 16:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723073400; x=1723678200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1HZzU/91Gt0q5eqoXV3hY1lBDdTOCyF1ae5EuXsJVs=;
        b=zSuYtlrTgC59YUF86110ottpAHxrkgvgoSSqQ43RdL228zNah5XopKysjOaOOUXLmD
         7AnD1B127GnQMDAM5dDGU+mTP2WLCWJGP1j1IxSTTxfidJxo4ZqCLWTjPMFxim48fve9
         D8aofowhGlTOUJrGa88k/TTTg7r+NUIU72UhCllw0eKjSDXuRs0sCDupGfUamkXBuIv5
         rYN64YZ0xCDjElr6s9Q0RvIIUIkvA31Sdlgw9goeLSCKoeQ0UnK6+hMrpbVLBOAY88pS
         hIilmvCRmmzkHeOZui1GGUapMUG/60KvWtnl8knEBhh57QSsp9awBpOrS4dwAyUL0Uh9
         uI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723073400; x=1723678200;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1HZzU/91Gt0q5eqoXV3hY1lBDdTOCyF1ae5EuXsJVs=;
        b=Jdfl70mDgbShgxQLopDE4Gb8sV/b5G+vK5scMMb38YE1ZbeUs/WX4++qfQ3wv+UcdB
         a8bkp8ysASxRNQQL8KyvWq2Zq3Wl0kWSBVHSAtF8UxwAxI3qsVK22Zcw8l4fxADTGhMs
         4Z0te5GfKqbqAvj2JItn2i5jQffJttkUMK4n8VI1gHhmpv47Vc5SzfjzGZ7xa/yajma1
         Sz+7nVdfgWCD7WZTdMr6lfiagEU35aab9s9m3knf+B1ND9f0WM4YtutLdXCL9yc3yeVH
         xocLIQAE9xe5g8HYiUzzQqLpgwk+5iTDrBeaCFz/2524SeukHd+LCr5VONgbe47V6akX
         Vr4g==
X-Gm-Message-State: AOJu0YyMsgm7AmI2DivwXVha5684s5zSb8MMrz6TWmeRDXakdkTy9Xjb
	kM5T30mAJMQYk/Kvq2ScPTtQ5MKgPdmXDU2DGlWC+vWc/ankx2Lfq/gjiKlHfg==
X-Google-Smtp-Source: AGHT+IGnuTJUhtq3PjcSmRyEbWXuRqKgpbz/ed4gK9H0TKvwQHDTywfX44nAKAcoHBO2bfuNkcHHsg==
X-Received: by 2002:a05:6358:12a6:b0:1a5:7844:2068 with SMTP id e5c5f4694b2df-1b15cf56660mr40430055d.5.1723073399562;
        Wed, 07 Aug 2024 16:29:59 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:c023:b8:a8df:17c3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c24996989fsm212376a12.59.2024.08.07.16.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 16:29:59 -0700 (PDT)
Date: Wed, 7 Aug 2024 16:29:54 -0700
From: Josh Steadmon <steadmon@google.com>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for
 libgit.a
Message-ID: <njekhcypd7x7vdxmkzbdbeblwm4bwiiz74saxdmzqeod6zz547@qkkwkmpjvwkd>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>
 <20240807224756.2zq5hkfq5j43b7jk@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807224756.2zq5hkfq5j43b7jk@glandium.org>

On 2024.08.08 07:47, Mike Hommey wrote:
> On Wed, Aug 07, 2024 at 11:21:28AM -0700, Josh Steadmon wrote:
> > +contrib/cgit-rs/hidden_symbol_export.o: contrib/cgit-rs/partial_symbol_export.o
> > +	$(OBJCOPY) --localize-hidden $^ $@
> 
> This is ELF-specific and won't work on Mac or Windows.
> 
> > +    let make_output = std::process::Command::new("make")
> > +        .env_remove("PROFILE")
> > +        .current_dir(git_root.clone())
> > +        .args(&[
> > +            "CC=clang",
> 
> You should probably not set CC at all here.

Ack, fixed in V2.

> > +            "CFLAGS=-fvisibility=hidden",
> 
> This won't work for Windows targets.

Understood. I'll have to do some studying on the symbol visibility
options.


> > +            "contrib/cgit-rs/libcgit.a"
> > +        ])
> > +        .output()
> > +        .expect("Make failed to run");
> > +    if !make_output.status.success() {
> > +        panic!(
> > +                "Make failed:\n  stdout = {}\n  stderr = {}\n",
> > +                String::from_utf8(make_output.stdout).unwrap(),
> > +                String::from_utf8(make_output.stderr).unwrap()
> > +        );
> > +    }
> > +    std::fs::copy(crate_root.join("libcgit.a"), dst.join("libcgit.a"))?;
> > +    println!("cargo::rustc-link-search=native={}", dst.into_os_string().into_string().unwrap());
> 
> You might as well use `dst.display()`.

Wouldn't that fail silently in the event that the path is non-UTF-8? I
think I'd prefer to explicitly fail in that case, even if it seems
unlikely.

> > +    println!("cargo::rustc-link-lib=cgit");
> > +    println!("cargo::rustc-link-lib=z");
> > +    println!("cargo::rerun-if-changed={}", git_root.into_os_string().into_string().unwrap());
> 
> Likewise.
> 
> Mike
