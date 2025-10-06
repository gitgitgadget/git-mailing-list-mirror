Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A771DF254
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778343; cv=none; b=QCfXrrJY37j+rhzqrKRfv4jdamz0jj7d/nWa/EPv9JCdBY4c3Y/rPzGtcDVauOJN99LzBr96GOOpfk5mSuolwsuAjfat8CaaB+R9snhAP+JIVYrT6DX/mzXj37PUPI1lmk/iXEZ3g0TVB3AhLi7si7GrAR6+Vdm78OdrUB/2SZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778343; c=relaxed/simple;
	bh=eCVxT1v6xZhvpPBv7qa9Pdm4/RGdz5vZaDuiDOS0/0Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8+EqhaD8VUj18KcXr5DeH7aScCqn4X2C+BCHCuELFESeyPACKmlI9bKWsjLgbUxKZju9CwAGQ9PJMlzFuslpRI4A1QBE+RVASVVrCIlEg9OFv2s7hKTuFbxEl0Z9z5l20Ag8OksiSUmT1onoD+cq4Mq53+oK1RzsE7Y6xdO28Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=cryeRtiP; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="cryeRtiP"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-93ba2eb817aso255137939f.2
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 12:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759778341; x=1760383141; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/oTvV8bK6ME0E7FKiEcDkdaHtyehnRVhiYI+9GQr5Q=;
        b=cryeRtiPXe7ttqQpa5+obF+rltTVsPedwnmMkL42kNN7UIe8ICqGuioqab2mT4uAP2
         tajjO2gW+XopmYEVIHvrcv/NaanlnENkQ0yZCw7TFnow0R4hry92NoqFOE4A5s3MmdaZ
         rUxgnEqykyjcxYmQHvAXjvZOvoqytze8/aMHoOF9j9BQ2y2MR07MpxwAHA6U6FrB7dkI
         htt0t17UYnq3aeKQ9zLJ5cvNPKITog7geRs0+Vfh8XHHBzvUEDUtiSLPnqlgAAcSMLp8
         5ia9jNm1eZi/5WmpercEUOlKnppjS5AgV/dyzkF1jHP8J5Ld1f3h19JAmHm9H1lOwJ4X
         2e8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778341; x=1760383141;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/oTvV8bK6ME0E7FKiEcDkdaHtyehnRVhiYI+9GQr5Q=;
        b=U9q+yANOCApUaGQ0PpFYZI9jXemrJrKJc3hl1f6jbt2HXyncRG8M2KQWrdvRPojjQv
         oFn7GQz1PJ7CLf6rV12axXt/liQeKfPV1hUOtvGD1dfemwWu+N7TRqJ7tHhRorLbivkM
         KMYn4D93Ztsj23JTgar3dCtc8A8lnoMH5Ny4pcj1PSLKowViNyTDFLZ2xUx7DSA7yb9F
         gt/fQB7Y2GzrYwLg5XvNSEdsYpRncnl/vbH18M6y5y9OgggAlmRUFJNt0naig+e/ZOSF
         UHGY/EMUvGA3CPYnLyvTbOLbb8EDEPcQrHZi2hG7PM+oEHW2Hjymj9MgDcgG+T3bxLOe
         vrdA==
X-Gm-Message-State: AOJu0YwbZ8Kb/ayPP+3tqi5eUrrSCWfUdbG+NNHACy7sOS+fUWHWvfLX
	z4658hBYXo390F7WJTxD9IuBw63lkh1HS5LmbxILKYwQQfgSTDMRrer7PtR9HhO+CbQAsjAfz96
	9Tt6UDk3Xuw==
X-Gm-Gg: ASbGncs0Yhj6V43DqVfDJCXTXdmf73u/6F2ppDmkmgEjCHxnYVN1T7h9wkyEz0XDHd3
	XmLYTtO7BWNtvegLuRjk4gng5IBVnVxOwvrCnSv8EauCowkd0rfAaAWba0qYryYCTHWgqlGjfUV
	XRAKR+e2CMNQQPyef3EQJl4svepsgOqfWGAD/CJq+Tcsm8SisnmS9AcUKFyUyd1mHUfeKc+CXZc
	zWBsv3bCSvNVWpjbfsWfYpLwfBy0BG5kGBwwLJwzswMN/xjDdTIJbGDGODPXyiElhNujyzv6TcT
	aL3o7/FNp/l7fIcz+2O8rkU2qU+pPP/rOfu3ZQQrQOr1M2pfiu7LVsWEGC7IEbRSGdSuDDqK7U3
	A4ZBLYOHVbArZ6qqIs6MzEgSDV1MUCoJlz4n4xjxr2BoximKrvRzkIGvzEWkgA2HiUEHYmwjjqP
	Mf0BdoDmxi+f41zzfaktoKxSAGC0SiO94Po6NotSTz3X2gG320Cm2xc7NndCox
X-Google-Smtp-Source: AGHT+IEcqqp/Je/JzgXivZdSrQiKBfCw+H0iCUBiX8o142J96E51JbVKaE/Yur34OhqKMN3lyH73mg==
X-Received: by 2002:a05:6e02:168e:b0:424:14a4:5064 with SMTP id e9e14a558f8ab-42e7ac437a1mr172038135ab.0.1759778340953;
        Mon, 06 Oct 2025 12:19:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 8926c6da1cb9f-57b660fd5cdsm4814708173.5.2025.10.06.12.19.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:19:00 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:18:59 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [NOTES 04/11] Rust
Message-ID: <aOQWI+hsbZhl9MPj@nand.local>
References: <aOQVeVYY6zadPjln@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOQVeVYY6zadPjln@nand.local>

Topic: Rust
Leader: Patrick Steinhardt
13:05am-13:30pm PT


* Recurring topic from past years, but sparked again by Ezekiel's contributions
	on xdiff
* We're favorable towards it, but we haven't previously agreed on a timeline
* Platforms that don't have Rust support: NonStop, Alpha, Cygwin, and some
	others brought up by Gentoo
* Patrick has a series up to let us provide notification to users that Git will
	start depending on Rust
* Led to lots of discussion both on the mailing list and outside, which had the
	good effect of making more people aware of the upcoming change
* Ezekiel is trying to pass some of the blame to a big brother – he's happy to
	take it ;-)
* Ezekiel is more interested in the technical details than the policy details,
	though we need the policy details figured out
* Having Rust be optional leads to code being written twice and increasing the
	maintenance support; having mandatory Rust support is needed to avoid that
* brian wrote sha256 interop code in Rust
* Would be nice to hand over maintenance for some kind of (Rust-optional) LTS
	release to someone else in the community
* We have lots of global state that we need to get rid of, and lots of other
	cleanup
* Long term goal may be to eventually replace all of C, though it's not clear if
	we should take that whole goal or just start with pieces that make sense.
	Also, we've got a learning process ahead of us, so our goalposts may need to
	change as we learn.
* Rust might be helpful for libification reasons, but tying libification to an
	already big change might make it too big
* Rust rewrite could mean implementing new subcommands (as discussed earlier) in
	Rust instead of rewriting bug-for-bug existing code
* There are lots of updating that can be done before switching to Rust, e.g.
	switching to unambiguous types
* Rust can be used to replace things at an individual function level
* Just rewriting in Rust doesn't turn the existing system into nice abstraction
	boundaries or reusable modules.  We have existing efforts to try to clean
	those up in various ways, e.g. the pluggable object store work.
* Rust makes unit tests much easier and ergonomic, and starting by writing tests
	of existing C code makes a lot of sense as a way to begin a migration.
* Large organizations and governments are going to start pushing for people to
	move away from C for security reasons.
* Major reason(s) to adopt Rust
	 * Threading
	 * Error propagation
	 * Difficult to know who owns what in C - Rust improves maintainability
	 * Attracting more contributors (it's the most popular according to
		 StackOverflow)
