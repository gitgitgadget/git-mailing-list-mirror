Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B911494B1
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 21:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726694079; cv=none; b=ONbfM4IzOs2fTcWSA2CF9TROaTKMWn0cLynj4N86vE8rANnOZeOGRMwwUrWAfCSlGchjP5d62wmtgFGk7kt/HnHzs5wlO7eabkrvrqW8ToZFTBaJjPZO4AYLBmLJh/BdavSochFg0YAg/gqiKGjtl5/wg6lhEZgZZ7JQsIgj7h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726694079; c=relaxed/simple;
	bh=2Dr2yjS1ozDGR1k6Ql+zMpDN8Oml8IQOE4Y8HISKIoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gu1vU0G4R3IHkpg9ROHIbo4ulusP5Xbv1FQcRhELil296UjIbvKY7HI+/G7NsZMjL/cViR5aIzLhotiQn/Nq49R/X7w9S+PY8epu3OKtqofevVoNgo7L0WviEWaJcSvx4wfuzmO3X1qiis9/BDSygTQ6t56CHXeWsf8DoEyNcs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=34Tf5R2x; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="34Tf5R2x"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20546b8e754so258015ad.1
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 14:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726694076; x=1727298876; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VmiaCpOTvvcSUhZLR1GvVaXCPqwILXC3OnWL+hVMNfI=;
        b=34Tf5R2xjjmXgaCjuA+yWC57o/zlQZfkwvyodCU/UgJ9FgbT4mFi1gD94ePrIIH+vV
         j7tzoZKRULti3F0ns3cIACRxvSd35KkOwqgbirAkJrpeL+4YjEStw0fz+ZXYpnFmndtu
         Zbpgd4aTXeoa7/CrGmUtIsVj3RIc2aoYwkjSTcpiQgJ56s48vlKhdd2X92wilN8a8aQQ
         cmbK1goOZHy6dGR7sO/mdoaZ3VxN9zEirim68DwV8LRH2gDvBaIXv+mvVC2/nUf2R0hm
         tz7xupnUyILB7BJSs10fQnVjDQBcsabKxZJCHqEcTM/evJRzOKpJm4mAglf5AKEi5QPZ
         XWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726694076; x=1727298876;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmiaCpOTvvcSUhZLR1GvVaXCPqwILXC3OnWL+hVMNfI=;
        b=iAsEMme966l/fSNPeHrKbe+jWY1ehjhbkPdxVleNcKTdrP0vEHyOAOww/X90kBLTBg
         ooeAJd6VY3mTl/myftvBtaMRcbKyzDJUovGsA8qx3cfmZVgraPAivJouUVvvEv45s5Kv
         XhOJh1Q0pJZNEK8BU1NFNw2BIuG+uv4MF9dARDxnHpcX+fMiVcPw4oPcyyiHlI5EftdU
         87sd2Fq2TjaTzaPeXWyWMbzLy4Fg1YWZveurc7AzBIDyPLQIlCMNST9egM9m7AZtm/X7
         AxqNBimkOxEnDIYgGtiWXkOlMs1l+qs9aDBqxYpJ/ZfSG63T8++VKMuS6rWSId/fxphx
         EItw==
X-Forwarded-Encrypted: i=1; AJvYcCWbDNIacgtYEl9ItUyUqSPKDOREo2bGl0thJI9Xu5gpiGLaamTA6XD8RHLeFFJ6AMFizSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymv3rHPvh+eDhrUl8kmD8DksYXrc0ZAIzjGe0CWV9BDJxt2xdc
	/SXl0YsFjVNfcXldJU2zYpovbwOF+2d7NVG3/BO+qyqI121SlWrIL8wfHjGXVg==
X-Google-Smtp-Source: AGHT+IGwUaMRCXYd/azymG4JbIkzKQyviPbLyZTMqBoae3Fbk5nnU+h0Q3N6jGbcEc+UI3GXyeYWSg==
X-Received: by 2002:a17:903:1ca:b0:206:a913:96b9 with SMTP id d9443c01a7336-208cd599c9amr473505ad.10.1726694076013;
        Wed, 18 Sep 2024 14:14:36 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:8e56:45c4:ecbf:a6fa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d27dasm69098095ad.172.2024.09.18.14.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 14:14:35 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:14:30 -0700
From: Josh Steadmon <steadmon@google.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Subject: Re: [PATCH v3 2/6] libgit-sys: introduce Rust wrapper for libgit.a
Message-ID: <e5bl6h4jpw76tgr2eobqhyoq7nozkbz3p7u5ljfrwlgir7ycdu@ppxdg2tdmgly>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
References: <20240906221853.257984-1-calvinwan@google.com>
 <20240906222116.270196-2-calvinwan@google.com>
 <CAPig+cQbPCWS4LVF7cdw_DD6K8dsrLTCmmhqkmGZpz1CO93vRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQbPCWS4LVF7cdw_DD6K8dsrLTCmmhqkmGZpz1CO93vRQ@mail.gmail.com>

On 2024.09.06 18:39, Eric Sunshine wrote:
> On Fri, Sep 6, 2024 at 6:21 PM Calvin Wan <calvinwan@google.com> wrote:
> > From: Josh Steadmon <steadmon@google.com>
> 
> This is curious...
> 
> > Co-authored-by: Kyle Lippincott <spectral@google.com>
> > Co-authored-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Calvin Wan <calvinwan@google.com>
> > Signed-off-by: Kyle Lippincott <spectral@google.com>
> 
> ... since there is no mention of Josh here.
> 
> > diff --git a/contrib/libgit-rs/libgit-sys/Cargo.toml b/contrib/libgit-rs/libgit-sys/Cargo.toml
> > @@ -0,0 +1,12 @@
> > +[package]
> > +name = "libgit-sys"
> > [...]
> > +[dependencies]
> > +libz-sys = "1.1.19"
> > \ No newline at end of file
> 
> Let's give this file a proper line terminator.

Fixed in V4.

> > diff --git a/contrib/libgit-rs/libgit-sys/build.rs b/contrib/libgit-rs/libgit-sys/build.rs
> > @@ -0,0 +1,31 @@
> > +pub fn main() -> std::io::Result<()> {
> > +    let crate_root = PathBuf::from(env::var_os("CARGO_MANIFEST_DIR").unwrap());
> > +    let git_root = crate_root.join("../../..");
> > +    let dst = PathBuf::from(env::var_os("OUT_DIR").unwrap());
> > +
> > +    let make_output = std::process::Command::new("make")
> 
> Providing a mechanism for people to override this hardcoded spelling
> of "make" could be another item for your NEEDSWORK list; in
> particular, I'm thinking about platforms on which GNU "make" is
> installed as "gmake".

Ack, will use make_cmd as Mike suggests.

> > diff --git a/contrib/libgit-rs/libgit-sys/public_symbol_export.c b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
> > @@ -0,0 +1,20 @@
> > +// Shim to publicly export Git symbols. These must be renamed so that the
> > +// original symbols can be hidden. Renaming these with a "libgit_" prefix also
> > +// avoid conflicts with other libraries such as libgit2.
> 
> s/avoid/avoids/

Fixed in V4.

Thanks for the review!
