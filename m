Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FEE155CA5
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734505022; cv=none; b=WeQLLlAvYXovuKsdwX+buo710ZkRC5/CbXSL0NY8S9mbnmsP26lUTGxhEk+tVHCkKSaiPBCkKa/kfS9VZzOjtDlhHWiAFOwoFNyz9UZrCYJzdJAQ41frUuNIJM8q9zjOORZWLd6ejSzn6dNOMPApuaEhYAMUi8LpeyicYmcX3/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734505022; c=relaxed/simple;
	bh=IrZ2iP8rngXnzJPgcTjWraEPIySSYYxqcL5rVUC1NIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDioGcZ9GEhQ8Q7R+JwvYVx8zk8WV/94lGeIM4UK9J/ossewN+Lb3VU674eg0/wj5rOjsRGjzamTq635YfJNcesDXDhxW3RJpPMii6Rq5sO50TmsabJEfEfI70owtLsdB1UqItcND8KdYeCpfZhz7KpzdhzoJCfRYHdzSbAkkH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E16S4S6o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rM7Ne1He; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E16S4S6o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rM7Ne1He"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4FE76114017C;
	Wed, 18 Dec 2024 01:56:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 18 Dec 2024 01:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734505019; x=1734591419; bh=rYoYTbes48
	G55bQmpRDYuKM9ZH9o2l4ulM/di03FSGg=; b=E16S4S6oVG3cxV/aWT1YGURJIp
	krxL31erI/K0oZNH0Iw6idjyx9lWxH7HHu69s02eVSDaFK7ufxLKisc4Wx9x5ElX
	xGeG4c81AsL1wrEAO7IJhLG/hBSBrF1lYDQE96Ozzq0NwWoHAv4jOAUd6I/S5bwW
	dqNJqVNUYPmxklslxaImxcdf+I89EYiUc6icQTVayfKLYpb6ZX5yMVEqDTYWaMHE
	8mPgp8/LF3736eakNCv5JlBJdu+XhW4LJWWtcL8Iqrxxaa/+v2Dl2SygiLcnYmDm
	EDN7ic3d9OUdJN+lU5XC+0p3uz6SeXhJ+YcdgQSn7hwUG8x3QSnkuMJg2rFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734505019; x=1734591419; bh=rYoYTbes48G55bQmpRDYuKM9ZH9o2l4ulM/
	di03FSGg=; b=rM7Ne1HepTXU2UO6Bseni2iwHddEHFrh3Y1ABIgAnpuDQlznh//
	aYmUZqXO8fNIEO+gCGtyTJkzZZPcUVkxZHlBZ0FRxJKa+V54Ux08GD7XM+z9h27y
	aAA02wUILLmC2Di/G3wo71Sa7fDi3U/KP5o3hop3p7B3BYRc7Ll4SRECDJ9sIl68
	aNzin2N50kPWzgrpzMLAl4F7gICe+EdwGfzQhh19ZjevGViRy/lqzZqnbKJlTXUn
	QVnknqVpZBv1enffe+F9DhF7WaCBLgEs4gF94vYzRW0Mv/y0k64Vfz/zGJ9gxhKL
	KwMssz49pdcmorhsMvVQjn6PjaaVh7YIVRw==
X-ME-Sender: <xms:O3JiZ0M3EUMKImegF_xr-pqg3riHe5kv3OBGALwDxczugWzBUw_lzA>
    <xme:O3JiZ6_VtFmy-lpScllX7fWo8PdyVX9TCeq3aYvpAdq-BlRYuNRnmYA8egF5kC1dI
    8bDq2l242Nat4bZPw>
X-ME-Received: <xmr:O3JiZ7SNrmAozy44WS0RT9Pt_KooOQXkX3kP3s0XIDkNr2imDJMBkI6V7LByy2NDEftwQ1CRNPqqIykbbUMjVoZzgqWZPWj5wPHDvXVyjxzI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleejgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitd
    eludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhssggvtghk
    vghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:O3JiZ8t5dfwxOcJDfFPuz705ZwR-xpK7BTg2Wq9F636PsyZ-ZCqC_w>
    <xmx:O3JiZ8cB2ZbgldOyJJUdSVgrxHvVyqgICSbwdr9pAMU1M1igYPd3Nw>
    <xmx:O3JiZw0oWejiFCj5e4Fk-eDT5fT-8I1VdGnApLqnsULiUFE4_YAdrg>
    <xmx:O3JiZw9Ni6x4Jc8rVUkTP7Zf_4d7rTwLJO5rKiIE4kQ1J-7kdSE2kw>
    <xmx:O3JiZ06i5xX-fdtY8pc1gNmKoxPgKQHDpaRuRO5x2Wcia3qds5u7Mbf5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 01:56:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 603c2353 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Dec 2024 06:55:10 +0000 (UTC)
Date: Wed, 18 Dec 2024 07:56:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.48.0-rc0
Message-ID: <Z2JyFB3CddYM_LP4@pks.im>
References: <xmqqfrmn4hr9.fsf@gitster.g>
 <00ad01db5017$aa9ce340$ffd6a9c0$@nexbridge.com>
 <Z2EC9rq3F0rTljff@pks.im>
 <010a01db508a$4544d750$cfce85f0$@nexbridge.com>
 <015901db50b5$e3a7f6e0$aaf7e4a0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <015901db50b5$e3a7f6e0$aaf7e4a0$@nexbridge.com>

On Tue, Dec 17, 2024 at 02:00:01PM -0500, rsbecker@nexbridge.com wrote:
> On December 17, 2024 8:48 AM, I wrote:
> >This is on the latest OS version of NonStop x86. The test is done via the
> >following:
> >With OpenSSL 3.4 The T0625 is Expat.
> >
> >When run as follows:
> >GIT_TEST_DEFAULT_REF_FORMAT=reftable GIT_TEST_CLONE_2GB=true
> >/usr/coreutils/bin/make -k test V=1 CFLAGS="-g -O2 -Winline -I/usr/local-
> >ssl3.4/include -I/usr/coreutils/include
> -I/usr/tandem/xml/T0625L01_AAE/include"
> >LDFLAGS="/usr/coreutils/lib/libz.a
> >-L/usr/local-ssl3.4/lib -L/usr/coreutils/lib
> -L/usr/tandem/xml/T0625L01_AAE/lib"
> >TEST_LINT= SHELL=/usr/coreutils/bin/bash
> >
> >The results are:
> >*** t0000-basic.sh ***
> >error: cannot run git init
> >Makefile:77: recipe for target 't0000-basic.sh' failed
> >make[2]: *** [t0000-basic.sh] Error 1
> >*** t0001-init.sh ***
> >error: cannot run git init
> >Makefile:77: recipe for target 't0001-init.sh' failed
> >make[2]: *** [t0001-init.sh] Error 1
> >*** t0002-gitfile.sh ***
> >error: cannot run git init
> >Makefile:77: recipe for target 't0002-gitfile.sh' failed
> >make[2]: *** [t0002-gitfile.sh] Error 1
> >etc for all tests.
> >
> >Removing GIT_TEST_DEFAULT_REF_FORMAT=reftable allows the whole test suite
> to
> >pass.
> >
> >There are environment size limits (about 32Kb) in bash on the box, so it is
> possible a
> >boundary was crossed internal to the test setup.
> 
> I did find this, in t0000-basic:
> not ok 69 - init with GIT_DEFAULT_REF_FORMAT=reftable

You mean t0001-init.sh, right?

> but have no more details. When should I break in gdb to get a backtrace?

Can you please run that test with "-ix" and post the logs?

Patrick
