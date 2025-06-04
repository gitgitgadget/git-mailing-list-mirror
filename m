Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95F28B7ED
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749024400; cv=none; b=ud7+MNa6AHCGm5EPIRhDZhed2727+uLhkKMqFsW/LP1rBPXT8eVzbixXgWUJG8by4tdBNChW3A/7NfIhO9pd5UO3DX0Kexw/vhBn4v1QNZsUxkJqB6wXMSXsuwHaaUj3y0kcS7cSy0XbiAyYL//zu15sZnq0IjB2Uar/JTGlP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749024400; c=relaxed/simple;
	bh=d/EJIzhI289ZU5oCq2WLKiCcf5P70UVW/tRzdBAXCH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwfobcXwuOMuNWZNSUUUJgzSsy0qkswltX5NehZGxoZMoF3yVMCKR5GWSRHSTlDa83/MuDtdNrxZ7JylWYlnc8DAWykVVKfX+OjcVpGwulpk2hSYObVW+1M7rSFNgSokaXnh6tVhHPz6Cd//TPTwkVkZXrng8AVPDwAe0CN8p5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dh9jXG63; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wh/W/KRo; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dh9jXG63";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wh/W/KRo"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB9591140181;
	Wed,  4 Jun 2025 04:06:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 04 Jun 2025 04:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749024397;
	 x=1749110797; bh=la58MboCeXUt1H32geSy4nC58C44+bbm52NlCu5R61s=; b=
	dh9jXG63i/pXtnonzJ95JDcNCnt4AZbvxOqLunup2KqbEFnXHFXtL6VsVDtTfmAu
	+Y5Y3AE3+ACppSHEA/SnaqJzMS/73UAY3ssXnYPMwbhCB3x0LJ4i/5U19T9gBZrw
	wyhU5exBz1fWpuHhPYd/n56dnKx9Z5RWqb1R7o5ec0uQj/WKwg4klxJG0DznjCLK
	Wm2k7+fRJv6gkxM2A5Ia0Zc8qUwJlWWvOi2iDwuoS0l0NTinImXPoW5LhFaPTGb1
	rpmeJUIycV9SI99yb8k5TeeQk0chW+B+0pdM5JzBJ9oL4x6nxXALogro1x7ku8G1
	rBBzaL2rhprAEn0Hq7iFUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749024397; x=
	1749110797; bh=la58MboCeXUt1H32geSy4nC58C44+bbm52NlCu5R61s=; b=W
	h/W/KRowa7FoilvCFOYO4iViptA2QnWwr57K+cYgThxgGmaVnJaf81EgzjruvhFz
	MM9wuVCpHBXfElRZJ2OVl/Rg7Cw6IGXjr58wPxIvpanc4nZmXTD5PJl4HwJAjeNo
	3qhyU6BzH9DuMHDevt/v6MNUoZqsiqQxYWZazlkgMc1hzKEzo75QYBOVCSd5tc56
	xLK42vps1aVZle6RVC/2p+BuxirxXOtfd2PmO37S6LC2kJkorRMWq3iHucr/VvNG
	qq/pWFNvmifqyeDXKnMPGU1jW6QyCdZ4Z86dJLk8Hvc51hhOgsIfg+5GqBlRyW/X
	5m5vsV/oeC7xYcsUJhJkg==
X-ME-Sender: <xms:jf4_aHPePMPOeSkwMr_MnETWAI16M1wABX1v8Tw9rQUQ1gaBYHC4bw>
    <xme:jf4_aB8lwOSD2ikp0t0S6i6pvI5aspS932xKzsMzF4Z_0S84CCh8eOcwsXeviSntG
    794X8vMmESnuOs50Q>
X-ME-Received: <xmr:jf4_aGQAHhl4F8PfFgvXhA50WyozACfWAQF-CTzAcVxHcoj3cVKSw7FUXokhyI1iMO2vGDvXrKi6RsDlA2XqU56tTHP6LDzUtN-M1fFoEeYG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohephedtvddtvdegfeeftddtheeisehsmhgrihhlrdhnjhhurdgvughurdgtnh
X-ME-Proxy: <xmx:jf4_aLtuM_9xLYEYZ27gJKZZIRhAdCPWS9GIm_yWp7mCIrdPiXHHYw>
    <xmx:jf4_aPfrCVn9FNcUhyy6GEgOVbHMGDjITvyXqKV_yg6VMLz9qwGJwA>
    <xmx:jf4_aH3-0w1LvpQiJIX15itGET0odpa7AlSqu1KGhgJLCiK3oTD6XA>
    <xmx:jf4_aL86wc2E_D9W7dTjWBOVaHDq-Vi-3qsgflmt4M237sUc4ggfsg>
    <xmx:jf4_aJqNwo_gekvkotv82DY-DMsUwgLIPmHAedhdNwlwno_emiMXfKdR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 04:06:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 23713174 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 4 Jun 2025 08:06:35 +0000 (UTC)
Date: Wed, 4 Jun 2025 10:06:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: lidongyan <502024330056@smail.nju.edu.cn>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] revision: fix memory leak in prepare_show_merge()
Message-ID: <aD_-io1eppd1Rnq5@pks.im>
References: <pull.1989.git.git.1749006537271.gitgitgadget@gmail.com>
 <aD_6T0lUOsqrb5sH@pks.im>
 <F36BE5E5-6754-4E31-9988-B4D0B3078B29@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F36BE5E5-6754-4E31-9988-B4D0B3078B29@smail.nju.edu.cn>

On Wed, Jun 04, 2025 at 03:53:44PM +0800, lidongyan wrote:
> 2025年6月4日 15:48，Patrick Steinhardt <ps@pks.im> 写道：
> > 
> > On Wed, Jun 04, 2025 at 03:08:56AM +0000, Lidong Yan via GitGitGadget wrote:
> >> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> >> 
> >> In revision.c:prepare_show_merge(), we allocated an array in prune
> >> but forget to free it. Since parse_pathspec is not responsible to
> >> free prune, we should add `free(prune)` in the end of prepare_show_merge().
> > 
> > That is a rather obvious memory leak indeed. Do you know why we never
> > detected the leak in our CI? Is this code path not exercised at all by
> > our tests?
> > 
> > Patrick
> > 
> 
> I don’t know why CI test doesn’t cover this leak, but I am happy to add
> a prereq test for this case.
> 
> p.s. I also like to ask that it there anyway to run test locally? How do you
> developers normally run test without open an pull request.

Do you mean the test suite in general or leak tests in particular? In
any case, you can of course run both of these locally. You can do so
either by using Make:

    # Run tests.
    $ make test
    # Run tests with the leak checking enabled.
    $ make test SANITIZE=leak

Or with Meson:

    # Create the build directory and execute tests.
    $ meson setup build
    $ meson test -C build

    # Create a second build directory, this time with leak checking
    # enabled.
    $ meson setup build-leaks -Db_sanitize=leak
    $ meson test -C build-leaks

Patrick
