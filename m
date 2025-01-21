Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8B21ADFFE
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737441875; cv=none; b=rrCSrD7MDpQuvZSrK/hSgOT4FXYhWHUAl+ugMIrrHoZ9gK9VoBcqbiPfesylWJsDCd8t+USHi1K4UUj/uiSKeY+38rN4sFmrrimcptt4pujLxVANIjVTPS+5JMPcmgGH182eIkaEk0ZBpNHBIouBz7j3abeFLUc2G106/TvNU/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737441875; c=relaxed/simple;
	bh=Oi5TmldlbY100Xz37sHOP5BXSD7dIv9zTpPgPUBoipA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+Lp+8ipvMAJ+BntqcRJSq3BvixmBBvyu4E11Bfue0HrjGQJDKxHBBrOVJrxi25y2LegGCkcn+1d6v6lrY9X2gyduqQH5oGdsJfynaJHOdM1zrGAu16wY79cqO+MhoSYxeN/Jg4YgC4Nfd1oBNTy+66izv7T3Tp5fgLW6WbmtvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gJJZiOC9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZaysyMeG; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gJJZiOC9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZaysyMeG"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id BD0631140196;
	Tue, 21 Jan 2025 01:44:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 21 Jan 2025 01:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737441872;
	 x=1737528272; bh=0BGp1G44JHNrXwf3zrSMUdh1ghuFRsHwNhyk0HExCLI=; b=
	gJJZiOC9N5z2Lsvjl0jg3SyyxeoHS4+ieae9CjaidvovKuWJHjbspN5NoTRYKJGK
	73V+GHf9PivDf21V4pWkLw9FvoidkV14uC3gV0XFqQ/yQMG0vYFFyPhPjf0ePK27
	PG6dqbs9xWKZdce2FyNnsRj4m9l70QUHQ9XrpaGnuQfsoKT2zvvy1+PTFeJbUeYm
	1C0u9VlLJPUt080oBB1gz+4N09iyzAa3hLTcpVvHqlIX+9sFfKX2LRz4xb8vwhEd
	+N9y8j34xR8lsK0XbWx4kZJryiDPKjI4eYOx54C+Jh22Y1zU1TdtJJ4ah65cAvaM
	lR39Eq1/Q9IqJyYVgv8/Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737441872; x=
	1737528272; bh=0BGp1G44JHNrXwf3zrSMUdh1ghuFRsHwNhyk0HExCLI=; b=Z
	aysyMeG40b+9RKxUfH7eddGmPpgTbI+C85+8iHmCMU+bpFF+VYreAiBaaFrA8pSJ
	PN0z0F+d4bKnespzfdJM/uKpoZWcSq31EDQhGjucIXag6MlFLjn+QyEfyKoGlelV
	3Nf5ZwLlq9KQQo1V5eUsdCynosN2Fd1T30rxRSqnZlHLrLuexKZLtwpbjZ9/5dn1
	6797AYvuL/rB/ATEu16KUAUA4jiGwJ8cwFVotsQ5/LTegrwLLYHbrfCoVngF/yul
	WiU3KEkzTnXqBZGv7xIswWF7pmj1litVTd1enY5m3Za59BVrlALjE1M1D/a7E/AN
	DW972ufpCSy6TnM+hlN9w==
X-ME-Sender: <xms:UEKPZ7EbOEciXim6w_cmSe8edxVSiDNCAih9HaXQU7h1lG5e_2Qmaw>
    <xme:UEKPZ4Xs5ggNXW8S2YEglXVCLjTyLtQJ4OG5KhB-ZqTQ4VPQioguJE_Y36c-fLaDY
    qmq6ePBILlD3wxS5w>
X-ME-Received: <xmr:UEKPZ9KKzpqTZQGzfACx0F_WkXFBWKbBqTKU4LBFYhhJ8s6ANzHWwJ9tCNutNWsOOKXuWYVXr-lwmSw8B5gFpwxj37FAzmOYT6jiZ2RKSnz4Aw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejtddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeefheffgeeflefgieduleehueeugfeifeevjeejveel
    heetvdegjefgkeeguefgtdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsehmrghvihht
    rdhorhhgrdhukhdprhgtphhtthhopehprdgurdholhhivhgvrhesmhgrvhhithdrohhrgh
    druhhk
X-ME-Proxy: <xmx:UEKPZ5EzJdUeilFDZjCEVfU0uDKHkvt8bqdgMO8pp4MBOvWokiVetw>
    <xmx:UEKPZxX_GrEADsmp5s4Neuv1S55kJFA_FChcKzTHcBIOJsjLPr469w>
    <xmx:UEKPZ0MW7odrCdzkeAA_Wq3hPAqqDelmL-g5RS3EvpzP6zolmq1kuQ>
    <xmx:UEKPZw0-wdrrSPjWEgRnSqHI6K-w7BRk05gspJdfx6espyNgdy1RyA>
    <xmx:UEKPZ0Th2x_zWunKT1id8Bv2ACqHar2yZIEmrb0vZcIkrVV74iEH-XKY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 01:44:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f3fc6aa8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Jan 2025 06:44:30 +0000 (UTC)
Date: Tue, 21 Jan 2025 07:44:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Peter Oliver <p.d.oliver@mavit.org.uk>
Cc: git@vger.kernel.org, Peter Oliver <git@mavit.org.uk>
Subject: Re: [PATCH 2/2] Fix Meson Perl version check
Message-ID: <Z49CTa-wconHakMs@pks.im>
References: <20250120160301.121245-1-git@mavit.org.uk>
 <20250120160301.121245-2-git@mavit.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250120160301.121245-2-git@mavit.org.uk>

On Mon, Jan 20, 2025 at 04:03:01PM +0000, Peter Oliver wrote:
> Command `perl --version` says, e.g., “This is perl 5, version 26,
> subversion 0 (v5.26.0)”, which Meson interprets as version 26.

Yeah, I've also discovered this issue, but decided to improve it
upstream in Meson [1]. Meson now prefers version numbers with dots when
scanning through the output, which makes it match the "v5.26.0" part
instead of the "version 26" part. This will be released with Meson
1.7.0, which should be released soonish.

I'm a little torn whether it still makes sense to fix the issue in that
light. If we do, we should use a fix that properly fixes the underlying
issue instead of adapting to the misdetected version, as that will stop
working once the mentioned fix is released.

One way would be to use `perl -V:version` instead of `perl --version`,
which will print the following:

    version='5.40.0';

The support of overriding the version argument has only been added
recently with Meson 1.5.0 though. We can still make it work though by
making this conditional:

    diff --git a/meson.build b/meson.build
    index 07744c73b1..c452a79e37 100644
    --- a/meson.build
    +++ b/meson.build
    @@ -754,7 +754,11 @@ endif
     
     # Note that we only set NO_PERL if the Perl features were disabled by the user.
     # It may not be set when we have found Perl, but only use it to run tests.
    -perl = find_program('perl', version: '>=5.8.1', dirs: program_path, required: perl_required)
    +if meson.version().version_compare('>=1.5.0')
    +  perl = find_program('perl', version: '>=5.8.1', dirs: program_path, required: perl_required, version_argument: '-V:version')
    +else
    +  perl = find_program('perl', version: '>=5.8.1', dirs: program_path, required: perl_required)
    +endif
     perl_features_enabled = perl.found() and get_option('perl').allowed()
     if perl_features_enabled
       build_options_config.set('NO_PERL', '')

Is it worth it? I dunno. But also doesn't hurt if you want to go down
that path.

Thanks!

Patrick

[1]: https://github.com/mesonbuild/meson/commit/a3679a64eec7c312c81d657880f34f015426c7db
