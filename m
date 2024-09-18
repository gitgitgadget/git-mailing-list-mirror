Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D751CA68C
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726694099; cv=none; b=iT9Q4J1KhYzqYt526Nr+ZY6VT+Ke0RzvYOqT3IQip9ZOGjUZiLzD4yp51gJjpp0yzAwVeuWF86nlEzsqCSABty5m+eOw3cZSNFdILZLyfQ03gcjU1AquKcYPuk4AWIyOm1j7RB+kvUSiK1kTLmawXdBnrH1o6lhjB+unwnKAqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726694099; c=relaxed/simple;
	bh=LWuqUPiW0mE2LQa9HfECVK56YJVanFuyvu1nsdB0SDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Al21NZcNw2v+XWr30m95a5oQbEOI7036fkYa+BHegdEi4nTf85KDpCwfMGbZKfW+JnHEnKcgNL40ldyVWr4JQUYlzCUDNhdDLYxgkqsldfOWLPUHtLy50Mjrzn0fmLPdZ3TgOP/lkoJjZNf02AeV70bZSPhopR+rgocp+n4o+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQuOLX0A; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQuOLX0A"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-207349fa3d7so246725ad.1
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 14:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726694097; x=1727298897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFypycOha7Te9ce9Og7CRSzUB7U24AuTAK+L+0ZKNKM=;
        b=MQuOLX0ACHJuuRXM1K4phzltwMVBh63Nlb5I7Q+utsWRlcWFSvCp8go8/CDkUdJh0a
         mcVlUj+0HnwsNISYDucBhq9SCiRM4UMedecWEokbZBURpRzelwjUYFlRFp6PvgxQxlNo
         m0Us1UhaAZfFRluevCoV0QqM7nLBjLf/03f/Oer7coIBCcmLTHrsNsyUPlJDfzMz6Ctq
         kEVqlazCUdKK230ZZ9j+QedQ1P/fSN2aUh2c82V6lCxzlmSZiD9JIG6jkYAvZWsxjriQ
         yhGXTIgkv/7IHUasqqeXlVyByzqZiHt3aeEMszZ8xRTTcekDXX9iAymfGGr+gk59pb/Z
         YwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726694097; x=1727298897;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFypycOha7Te9ce9Og7CRSzUB7U24AuTAK+L+0ZKNKM=;
        b=JHspRkkkAfVS7z8R/F8GI3bX/wsR6gxvn88kax8h7QMZqWTaV4e+jD4+qgfWlmigST
         vf1lm0TxcN/w86dPCUMMBgqXYeUnAZIshQJZ0GNVeCjQTaG941S+VtBaT6VqSf3aOEEE
         39ZWBy/kjXzyp3a5dcPxgs1RWBtGcOWJZWIYN3YmI5uG3zyK/LeWXAidxMuFmDxn3drJ
         euxO3aoCexE/xBwg8825ljqshyHu6Qvt0633a7PcpRzguIXjdrrxsJCvRjGvkK8HbjY+
         3Nq6iguD53kmSqvSxtUJw9vzjOofs92zjV9k9/T/FFXJd5QMQq31VCgwJ6w810o/O0Z7
         AOfA==
X-Forwarded-Encrypted: i=1; AJvYcCUnd2lCzrip8yx+jtJ6XfyduwlBUnPgo8TzqIYOu2f+8uKf4Y8HWy5ykRI5buR0GHmNy7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRy+Kp311XvbaI6s3tm3uwta4s5uRDRii+qEQlxrNNW3EvQJ2N
	2syWuXjGa4XewG7dVDoxEay9WC9PUvDb4/CGKVofCOvjxKWVUSdwNqqDOfQ+dg==
X-Google-Smtp-Source: AGHT+IHyzslSXpVccka5uWauiXcCWSIBBUBAh1d1w8kivgwK90WVaiNCKz9ncSBKeM2ZgZBLJ/GRug==
X-Received: by 2002:a17:902:fa0f:b0:1f7:34e4:ebc1 with SMTP id d9443c01a7336-208cd7cfcbfmr355665ad.5.1726694096505;
        Wed, 18 Sep 2024 14:14:56 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:8e56:45c4:ecbf:a6fa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794601298sm69715275ad.64.2024.09.18.14.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 14:14:55 -0700 (PDT)
Date: Wed, 18 Sep 2024 14:14:51 -0700
From: Josh Steadmon <steadmon@google.com>
To: Mike Hommey <mh@glandium.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
	Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, 
	sandals@crustytoothpaste.net, Jason@zx2c4.com, dsimic@manjaro.org
Subject: Re: [PATCH v3 2/6] libgit-sys: introduce Rust wrapper for libgit.a
Message-ID: <bl55ecnyupy4f2ypxn445apmkvpogkwcer2ckq7dlmjk3mgfrz@of5ucc3x2kv5>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Mike Hommey <mh@glandium.org>, Eric Sunshine <sunshine@sunshineco.com>, 
	Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, 
	sandals@crustytoothpaste.net, Jason@zx2c4.com, dsimic@manjaro.org
References: <20240906221853.257984-1-calvinwan@google.com>
 <20240906222116.270196-2-calvinwan@google.com>
 <CAPig+cQbPCWS4LVF7cdw_DD6K8dsrLTCmmhqkmGZpz1CO93vRQ@mail.gmail.com>
 <20240906230419.r4hej7qsmx7yasl7@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906230419.r4hej7qsmx7yasl7@glandium.org>

On 2024.09.07 08:04, Mike Hommey wrote:
> On Fri, Sep 06, 2024 at 06:39:17PM -0400, Eric Sunshine wrote:
> > > diff --git a/contrib/libgit-rs/libgit-sys/build.rs b/contrib/libgit-rs/libgit-sys/build.rs
> > > @@ -0,0 +1,31 @@
> > > +pub fn main() -> std::io::Result<()> {
> > > +    let crate_root = PathBuf::from(env::var_os("CARGO_MANIFEST_DIR").unwrap());
> > > +    let git_root = crate_root.join("../../..");
> > > +    let dst = PathBuf::from(env::var_os("OUT_DIR").unwrap());
> > > +
> > > +    let make_output = std::process::Command::new("make")
> > 
> > Providing a mechanism for people to override this hardcoded spelling
> > of "make" could be another item for your NEEDSWORK list; in
> > particular, I'm thinking about platforms on which GNU "make" is
> > installed as "gmake".
> 
> And/or, use the `make_cmd` crate.

Will do, thanks!
