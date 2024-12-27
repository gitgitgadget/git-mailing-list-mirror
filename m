Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47C11D6AA
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735309132; cv=none; b=jxczkUH+qf8KWgea4INEHD1LW6Sxbrqxh+SRo5Z8EY/oQw5zYzLniPnQew5peXZVg0F7jU2HCKWI/z/JA2CuwFpyS4Iuzre4pfntd+iBrTMUO6wXrdCiaoB2qkwC7Z9Z6LNuS0oa3o59qWP9NOkpP6TlL1oybcJI7kOFcC7joA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735309132; c=relaxed/simple;
	bh=7x8qpw1/5w9GMMjPGa4HkWx159JvUKOaz2oZJPrngP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yi/vwqMO8xCeGpTqivs6QQk39XyMIx/vBfw9E/fnjFK+O/8zaaltAKpi/Jt5Z93hqOxX/wknTDWlLeceablWIb2RTGvVlfAI+/12vXtZ0VGXODGC1chrtuvkznc3bTn6d1s5y2B3iyr95eUUTTq5MO/F6zJIYGcKJw/FW9sCsr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V++4YfAm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YpYBO0d8; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V++4YfAm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YpYBO0d8"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 73DBE1140113;
	Fri, 27 Dec 2024 09:18:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 27 Dec 2024 09:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735309129; x=1735395529; bh=4L23MJcDs/
	uQYhGG5D3kfQ6q3STdJpiN56+1iYDJ69A=; b=V++4YfAmTKlQsF0p3OrklXvYE9
	NFbtCjI6av+y+39V4al+8qNf3OipNYExeHuomj8T9bYD7gIACS0dUFXbvT10a/yn
	wi33Z5c6F1qBBiE7gfCXoR6Kaypj7znyFQ/98GGHydl/RXoTjSgco4ZFWYTinQ41
	LxiUSqivrA84K7faY4e7XUVhHax6+OIVQIPN4MAuRtrM+116h2iITRxhEg+JZ7vv
	uTO9pCDYfliS/QJ0e4lPWtjb0HbFECU7N3mQA5HM3f7/tt1IXuPrsxOLljcdzwZz
	d/ldu8omKV7Jpo7Ahcqr2cUYZTeZWFhCgNgFn1gXsi72o2Vr77gCc6U7pncw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735309129; x=1735395529; bh=4L23MJcDs/uQYhGG5D3kfQ6q3STdJpiN56+
	1iYDJ69A=; b=YpYBO0d8jVlSRu2LeEMc7fwdgUzxz/PfUQ//O8SR9JcyrskpSJr
	Frkn1fkhamDJUfMZJfP3WKSX2YjgjkfaaPRWBc+SqXBh50AEoMz/88XkJrHgKGqK
	uIfvqeDHHxvlNbZz+c/A7GnKgLI5vsRr+qHVfYRjt69fQybuyiM3/yuiXMGqp66+
	abQLm3bgP2/QfjWbLtZOFCpyOq/kKFBn/+fNIYGFGJsudrorJXqbltd1pmdIQ/iR
	libOxH3VhSwUw5K8Qh4fsIQ0lbfY9ZMyRAjKmbOqN0Nmmow0qBCiBsvBj+LTq3fB
	kLpk1ZOzJQdLjkOZ165z1OiIsoADnl539UQ==
X-ME-Sender: <xms:SbduZ2Ys2FSBMEwr6bYXAH3CqZH8hRICXD6USF6dylBQYwKI3f9rVg>
    <xme:SbduZ5an7AFYt41z7wHXoR9HuQbjKcSrz-dsj_THi8GvJ0SCMdCgdEAjJY59YGaMs
    f5EEHyTyjU7Z4zr8A>
X-ME-Received: <xmr:SbduZw93_PmAq1oU4RBmlk2WP3MK4Wfca6HY8rd6pUM9IREI-E8wbxidcaa2vSvuq5ibPJ67CP6ZRz4_hGqSdIyyREDfJyLTz9Wmp7wLpcOG-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepudefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehg
    mhigrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheptg
    hhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhho
    nhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhohhhntg
    grihekieesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:SbduZ4qXLUzhbmUzebbZmjq2flzBsV7paj4JNqGAsHPt01dI0letFg>
    <xmx:SbduZxpGCwF8FXIuOBt8xtOmIjf2ZRH6mU2Kz8jGpThWhw_sufItYQ>
    <xmx:SbduZ2TRpj-Z0HGEyK919m0g4XrSz-9CYD0T8ReY6hKa9QLONYTmTA>
    <xmx:SbduZxqR9CxMdZuxm8ZX2eUgZQb4Cgv7uZww94eK7B2Trw_l6tD5bQ>
    <xmx:SbduZy5kSpf6Fp525Agh0XX2pa7f2x5r_fGaqZhzaibxb_oGjJll1-WS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 09:18:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ccd2c0cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 14:16:43 +0000 (UTC)
Date: Fri, 27 Dec 2024 15:18:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	peff@peff.net, me@ttaylorr.com, johncai86@gmail.com,
	newren@gmail.com, christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com, jonathantanmy@google.com,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 1/7] path-walk: introduce an object walk by path
Message-ID: <Z263NFdtulSUYRLO@pks.im>
References: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
 <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
 <b7e9b81e8b32313f00d38257ba731e73d17224cb.1733514358.git.gitgitgadget@gmail.com>
 <Z1whcUJE-MHAhULO@pks.im>
 <eda7d3b7-8c3b-4486-b292-2507ca7f3bf9@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eda7d3b7-8c3b-4486-b292-2507ca7f3bf9@gmail.com>

On Wed, Dec 18, 2024 at 09:21:25AM -0500, Derrick Stolee wrote:
> On 12/13/24 6:58 AM, Patrick Steinhardt wrote:
> > On Fri, Dec 06, 2024 at 07:45:52PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
> > > +	} else if (parse_tree_gently(tree, 1)) {
> > > +		die("bad tree object %s", oid_to_hex(oid));
> > 
> > I wonder whether we maybe shouldn't die but instead return an error in
> > the spirit of libification.
> 
> This is in fact something that is being tested when 'git pack-objects' has
> the --path-walk feature. See "get an error for missing tree object" in
> t5317 as an example.
> 
> It's not enough to fail, but we need to fail with this error message.
> 
> Has there been enough progress in the libification effort to establish a
> pattern for returning an error message like "bad tree object %s" from an
> API like this to the caller?
> 
> I will try using a "error(); return -1;" and consider that as the best
> option for right now.

Yeah, I think this is best practice for now where we don't have a
superior mechanism like structured errors.

Patrick
