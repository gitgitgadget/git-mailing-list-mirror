Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A21BBBE4
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086431; cv=none; b=JhKMKoUU2rx0qxBX/ItvAwE2QQK83oMdsSMi7ZB8waigdAV1mdqIRl/NCarrVsSYTrz/oW15hVlIUIdWZGBhT47rt8X/pUaNiFX18ZTsuK0iWGSNkHDXGAtUxbKI4vNW9OtdaMEgBRjWdELpsWME1xsgamnhUA1NU3rT3SeTTa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086431; c=relaxed/simple;
	bh=YE9Bv83jWGL/cv/HN2yp5e/oWNrjJU1/mDpl0aw3QnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK9dDAo5ZYTTqF33iMWCdvxSCGtk6UcD9uJcWmZhZQ61v9sW1q7C6EjJ0mplLxRoiQ/FshbegUfXIiQE2vANbmtQiKKAjWTONKJMM2bTvK73wQNCMrdPApWdLLqiEdZ8asMRw8gymGbcg048ICDD6osB01FRO071hiinA4Eu4Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f1Ere/dE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=McqmHdHN; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f1Ere/dE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="McqmHdHN"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id AF41F11400C1;
	Fri, 13 Dec 2024 05:40:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 13 Dec 2024 05:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734086428; x=1734172828; bh=N2aL6VnAxm
	yvSzUFranGq4iK//I3MVgaImEjzk7y9Ok=; b=f1Ere/dETVYFVIuOlMW7fiyY7B
	EVBOG9OBtENXKlLAYljh/OI/71X8JkXYBFF2KwD0yUxMAElEYz0Xm0q7SOWJVSN6
	jWYNsdb2ImL5gdzruSPKxanD1ULZWN+n69KM9rVcrShJOjlnZ9IsEormDkYojPUN
	v0cJpXDKdpeeuG0zzfPhaTfwRRlDGh9iCZVJAk37WKfgg1SMDJH8D688xxYpokGF
	fBTAoscy7Be+V9lFf3ILQTZMceKQx27YSE+WiCea9dbWMFv7wFd709lqg8kVdTU6
	L681WtaFJ9I8urUrAfBr9euNtw9wrNMGVG5WSQd07Kvnpum5I4FqnH8EiyEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734086428; x=1734172828; bh=N2aL6VnAxmyvSzUFranGq4iK//I3MVgaImE
	jzk7y9Ok=; b=McqmHdHNizCpuiQIthkZmDJaIXsnWxHJEU3C73UwkUU+nU5Ac87
	T7UcGHNWi/JYCsoHH6Q29LzQdJ40M8Ap0CBPHOffW4zg8Xou9bGHZ0kdJ4di6Swy
	bwneqhdBYT2L3NO3339Scw6Yq3/zBS1pg0tgq8lNK8hFqm5PlsIA6n1ZnFADZ9vL
	b6mHQt69DHzfl4qWgoRf1PSM/ddrWfe9Agh1W1hGvVSLS1Q8xN0SDClxi2GeyAZ/
	7QSiQiPZx1X/FxmNAgR6Po8sDpvaI+P2GKfefcA/W30xzTWFPko5CJptUzaCu6v8
	9TwYahW0oldxDpSPulwtROuLFk9z8VdHTgA==
X-ME-Sender: <xms:HA9cZ72Uiwe3-h3mN9z9EjnjmVVnIWMDX5kjhq4Cahee23-mjk7vtA>
    <xme:HA9cZ6E-Qup4dH8iecF5SmC6lAdRPtDvKc91_cKPSbsKCw2FjnQB_FKpFHhM98BLE
    pLTJuJ5b_VSdl8cxg>
X-ME-Received: <xmr:HA9cZ76oRZSFILScM5TwIpwBxTHC4EqGW7n59f3ZeYhryrw9w-A_FqkEJfoPnqVF1scK4CJvD9D2c_sNB4tysgi5x4PUA_CHFdzCOSEKJ985zBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HA9cZw35Tk-bBxfk4bEMg6Ci176hVvAoBRfzgybEgKB6ysceR2JVrQ>
    <xmx:HA9cZ-F8odJMq29qY36IK3f46QRm8_uYwDFRuQ0hgH764rvSOuBPFA>
    <xmx:HA9cZx_uRoNvgNYOmiPmAlGTtAlVADSRGJ9xTSlHJR-ujoJcc6hIvQ>
    <xmx:HA9cZ7nOVHjPNo4xBF3ENHYBQVnrgYHPai9oM6QxQBJc5PGu_H00kA>
    <xmx:HA9cZzTlsPuUvifhDkw1m6dVaAGxspnuzQH8mbv7U9ad3-aIMnY3Tqyo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 05:40:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 21e45076 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 10:38:47 +0000 (UTC)
Date: Fri, 13 Dec 2024 11:40:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/8] meson: detect missing tests at configure time
Message-ID: <Z1wPC1vSlqgWeFis@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
 <20241211-pks-meson-ci-v1-4-28d18b494374@pks.im>
 <87bjxfj44o.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjxfj44o.fsf@iotcl.com>

On Fri, Dec 13, 2024 at 10:58:47AM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/t/meson.build b/t/meson.build
> > index 9e676e69363ed6311426500d98fe281e30d26bcb..f1fbc6ae179079f4d5d86f9a60956fad84d0495c 100644
> > --- a/t/meson.build
> > +++ b/t/meson.build
> > @@ -1092,6 +1092,42 @@ integration_tests = [
> >    't9903-bash-prompt.sh',
> >  ]
> >  
> > +# Sanity check that we are not missing any tests present in 't/'. This check
> > +# only runs once at configure time and is thus best-effort, only. It is
> > +# sufficient to catch missing test suites in our CI though.
> > +foreach glob, tests : {
> > +  't[0-9][0-9][0-9][0-9]-*.sh': integration_tests,
> > +  'unit-tests/t-*.c': unit_test_programs,
> > +  'unit-tests/u-*.c': clar_test_suites,
> > +}
> > +  actual_tests = run_command(shell, '-c', 'ls ' + glob,
> > +    check: true,
> > +    env: script_environment,
> > +  ).stdout().strip().split('\n')
> > +
> > +  if tests != actual_tests
> > +    missing_tests = [ ]
> > +    foreach actual_test : actual_tests
> > +      if actual_test not in tests
> > +        missing_tests += actual_test
> > +      endif
> > +    endforeach
> > +    if missing_tests.length() > 0
> > +      error('Missing tests:\n\n - ' + '\n - '.join(missing_tests))
> 
> This gives nice output:
> 
>     $ touch t/unit-tests/u-bar.c t/unit-tests/u-foo.c
> 
>     $ meson setup builddir --reconfigure
> 
>     The Meson build system
>     Version: 1.4.1
>     [snip]
>     Configuring update.sample using configuration
>     Configuring exclude using configuration
> 
>     t/meson.build:1116:6: ERROR: Problem encountered: Missing tests:
> 
>      - unit-tests/u-bar.c
>      - unit-tests/u-foo.c
> 
>     A full log can be found at git/builddir/meson-logs/meson-log.txt
> 
> But I think the error message is a little bit confusing. It sounds like
> the test file is missing, but it's the configuration of the test that is
> missing.
> 
> Now I've realized it hard to write a good error message here. But I
> would suggest something like "Tests files found, but not configured".
> 
> > +    endif
> > +
> > +    superfluous_tests = [ ]
> > +    foreach integration_test : tests
> > +      if integration_test not in actual_tests
> > +        superfluous_tests += integration_test
> > +      endif
> > +    endforeach
> > +    if superfluous_tests.length() > 0
> > +      error('Superfluous tests:\n\n - ' + '\n - '.join(superfluous_tests))
> 
> Also here I would suggest different error message, maybe something like
> "Tests configured, but file not found"

Both good suggestions, thanks!

Patrick
