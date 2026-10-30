Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.255.151.162
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793402467;
	b=1Iw0/B9MNrk9r9gNJK4ZdgD5veWnKnPEuMJTu2PObG1vUeXkReHZMBu1T7OSilda9bQy
	 NSe537sf0EC0CQqPp/Xh0tCg32NRjSFh8DpiLZ9V31clNJZGhD6ZAXrA5OmIqNOGuO9t+
	 V1G8l4qq9Il/X4ul6TY3JoNkkGhXJYGzl8rXXXSDNhHUB5aAlMfuQvkuLZiU9Op9Uoe8a
	 sh9x5dZJPlEOkRmsXRhGN0eMLCpiD+zm/fc+YLTcDI1DwC9BNcwmcLLWsdlbJUNMKll9w
	 vBm89swgAR/Ns7X8x47K2EsaRSEXAOb799wfYaqV94tsAVDYj/nthakY8tKl9jGNLCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793402467;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-GPG-Fingerprint:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Status;
	bh=AtV5ZO6cF3l12/dI/CtaaweBxeoygswlKwRaZF6Z14U=;
	b=v70hP/Jt4O10iraNIIGL+8Vuy04rPVa2te9VsvCMdAOelQB8kBrUvOo2DWaMq9QCuBKP
	 QSfmASqYkQH+D7KPK1wIRhL075jb8Am+naI7GyReLGS6UTL62GU5m+T8SsUFD3TA6Mvyu
	 nk1+jsjXsjsTKV+ceaTCj/uhk915H+sWJGgvWjnVnV7Zuqn2vEzxuQRVYJdYXIC0lwRKe
	 /pAtdqBue0NGGdmY764X7djPQxZWL9xErPm7cI0MvimJJDBKuo5Q/YO4JAdqje4ivK86Q
	 L0j7nfxobiVUKzDD7PpOV6n5Dl4m/mOA8yA6Dc7qJ2ogNslj5jvAY04lwnzlEeJv/Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=glandium.org;
	spf=pass smtp.mailfrom=glandium.org;
	arc=none smtp.remote-ip=178.255.151.162
Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA496606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 23:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA496606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from h120-138-187-157.user.starcat.ne.jp ([120.138.187.157] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <mh@glandium.org>)
	id 1xMvu2-00000009bg9-2cVO;
	Fri, 30 Oct 2026 23:20:55 +0000
Received: from glandium by goemon with local (Exim 4.98.2)
	(envelope-from <mh@glandium.org>)
	id 1xMvtv-0000000448w-333t;
	Sat, 31 Oct 2026 08:20:47 +0900
Date: Sat, 31 Oct 2026 08:20:47 +0900
From: Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, sandals@crustytoothpaste.net
Subject: Re: [PATCH v5] move rust gitcore crate to a different subdirectory
Message-ID: <4brq3bxkdq6ewviznwrg7uqgpp2j6xf2bladpmdrpaypcjp63t@lqfpwwagpbss>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <xmqq5x0df19l.fsf@gitster.g>
 <20260917060415.2986259-1-mh@glandium.org>
 <xmqqh5i6g3b5.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh5i6g3b5.fsf@gitster.g>

On Tue, Oct 27, 2026 at 03:57:02PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > Having `Cargo.toml` at the top-level of the repository implies that one
> > can run `cargo build` directly, but this doesn't produce anything useful
> > on its own.
> >
> > Additionally, when including the git source as a submodule of a Rust
> > project, it prevents the git source from being included at all in the
> > crate package because cargo skips directories that contain a Cargo.toml,
> > assuming that everything in the directory is relevant to the crate.
> >
> > Move all Rust-specific files into a dedicated `rust/` subdirectory.
> >
> > Signed-off-by: Mike Hommey <mh@glandium.org>
> > ---
> 
> I was looking at discussions that are older than a month whose
> patches are not near 'next', and found this patch, which we haven't
> seen any comments or updates on the discussion thread.
> 
> It does not seem nobody, other than the original poster, for obvious
> reasons, was enthused by the topic, and given that the exchange on
> "what happens post Git 3.0?", I am not sure how badly we want to
> keep this topic.

I, obviously, am still interested. Selfishly, I'd rather avoid having to
maintain a fork just to move files around.

Mike
