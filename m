Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8131F4E23
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445480; cv=none; b=klumDs+22/vwc82Dggj1+gWtxB+naE3GGPCmnj4k4tvj8WgKyMPkJTIafbAse/mtyRSf5ld4EHFLztII0zEKSueQBlCLI7z9Yv3IRk9pVDElDVI0sUjAPq/chwqdUW2uKKGoSc3VOV1F40RUKCaxyaZc46GSlo9NJ9+VBrjodsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445480; c=relaxed/simple;
	bh=NHs8kjYHPedr5vmmvBY/EhBlRgv5akXqfcMvLwWmS6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZFrChU/RibGyvcRclbcQKqm8ZvPaa+hTZjb4PUUfVa4Q3TEZo6qFKX8yykF4iAq9IBIvy0RxuqVRwcmcq5GLuep2fXYh4e2GS8HZfCgp//XLCMvbi1tgSgWFC06atytyGMWsRX3iMCIXyDrXGxksyu5xLhAkECPUnBgv8poDIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KKj05tqc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xjbwLzzh; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KKj05tqc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xjbwLzzh"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B11431380211;
	Tue, 17 Dec 2024 09:24:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 17 Dec 2024 09:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734445476; x=1734531876; bh=7eu66lgBaS
	ne9+AGzcWHxOg+5yBkKWcSNgWXl2XQ1Ec=; b=KKj05tqckCwoIhgUCN0w2VBGqC
	eEZT4ZWAk88+kSr5MW62qppNBeuNxpwzBm1GjZqcGC9w0esLhjktqx3fNmyUNIZk
	5hiRwNLpxYFUsb7DtLH7Crf8H1Wx0VceT4jg3pgXWbRY8Ns7xtZQuaZJi9sOS5me
	UFm2Ah//Uz+vt+C/YILiwAZWtx6qyseSqJBdsT+42aHOx8j97MT/vE/FLHwv0hhT
	YJ1hPZ+YIyc0nYIZNcZnMFZUvNgraSULWM1ymQMsgICosaABmNhNgHakoUA3bZ1n
	Af1bbMYdzukp6qz8uJ9mzTMHHaiaOO3jzSa9BOGEvj15lXaLel0koEezjmuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734445476; x=1734531876; bh=7eu66lgBaSne9+AGzcWHxOg+5yBkKWcSNgW
	Xl2XQ1Ec=; b=xjbwLzzhdVPLnL2ELeyOs2eoQA22HRKovO7drzWIJeISjdcVNho
	NV41qkYAUObV1903VZeUaEWIXfv9uyyxL/zAqPEGVwtp6tgIWR6UTtvwBZp0Bq/L
	X512T80T5vTpUHMWsueDahSBK1rDXjc4O15eYZfB0nuQejmhc58BNDC4wK7tH7cr
	VfosaiokmTLeLnlzW1CYz0TrOqf9OxvQZpdASDnN9hiqInyroaa2hO3VB9TRYyB6
	c/bt4OnUKOI2CJOoj/7ZtJuHDTwODT5d4n/VUZ3++wJErDZdyX389nDjv4/HNpjP
	V8RhSG/helCexYldWllquOqLbAEyd8HuMlw==
X-ME-Sender: <xms:pIlhZ_YJUIPxFl4w9Ht9akSp7VD2xoLmHOaeSaPRy-MXrCSAVrjpbg>
    <xme:pIlhZ-ZdxZxLgsNd-GDWX1ValjZKFk9vLRw_Tf1NoOL7X3wP2ivJtxgbcI1NnprXU
    2PlWmIS56oEssIxpw>
X-ME-Received: <xmr:pIlhZx_3zQ0PT3oLJJJxKfAgRjCVzXYVJTuN3Vp-EShZ_S-01gnOZ35isuXwy3sjrdhpxMZSImbIFr6oct21YagIsqSbBRPbfzHmiRzVxhmcSdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleehgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepgfevhfeutdevff
    egheefffefvdejtdegudekvdefgefhffffudfhudeutdffjefhnecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghdpghhoohhglhgvshhouhhrtggvrdgtohhmpdhorhdrtgiipdhgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehrshgsvggtkh
    gvrhesnhgvgigsrhhiughgvgdrtghomh
X-ME-Proxy: <xmx:pIlhZ1p-L-QHWhwOQ28aFZzpff_UsDtZQd9bLlrSLyJ89W1F445a2w>
    <xmx:pIlhZ6ps-ZZsk9xqdFPcNLRzy--iNxkHD-nn5c-Egh_0c5wjfutD3A>
    <xmx:pIlhZ7SccnlrKQO_bpyR9A2Q-gQxB7TZS1nUrQDvr9PVfEuh3oI9kQ>
    <xmx:pIlhZyoCJK-c3GSuyHB3zzz8pcH-h1DzvfL4-rBdg3MA2yy_8VgB4g>
    <xmx:pIlhZ9Vkxi7iUUhUtuTDzjyUack78SUcYS7YgyNX3qwTgAywcpOTAQU->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 09:24:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 651974d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Dec 2024 14:22:48 +0000 (UTC)
Date: Tue, 17 Dec 2024 15:24:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.48.0-rc0
Message-ID: <Z2GJkolZyebD-8PD@pks.im>
References: <xmqqfrmn4hr9.fsf@gitster.g>
 <00ad01db5017$aa9ce340$ffd6a9c0$@nexbridge.com>
 <Z2EC9rq3F0rTljff@pks.im>
 <010a01db508a$4544d750$cfce85f0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010a01db508a$4544d750$cfce85f0$@nexbridge.com>

On Tue, Dec 17, 2024 at 08:47:47AM -0500, rsbecker@nexbridge.com wrote:
> 
> >-----Original Message-----
> >From: Patrick Steinhardt <ps@pks.im>
> >Sent: December 16, 2024 11:51 PM
> >To: rsbecker@nexbridge.com
> >Cc: 'Junio C Hamano' <gitster@pobox.com>; git@vger.kernel.org; 'Linux
> Kernel'
> ><linux-kernel@vger.kernel.org>; git-packagers@googlegroups.com
> >Subject: Re: [ANNOUNCE] Git v2.48.0-rc0
> >
> >On Mon, Dec 16, 2024 at 07:07:25PM -0500, rsbecker@nexbridge.com wrote:
> >> On December 16, 2024 1:15 PM, Junio C Hamano wrote:
> >> >An early preview release Git v2.48.0-rc0 is now available for testing
> >> >at the usual places.  It is comprised of 446 non-merge commits since
> >> >v2.47.0, contributed by 66 people, 26 of which are new faces [*].
> >> >
> >> >The tarballs are found at:
> >> >
> >> >    https://www.kernel.org/pub/software/scm/git/testing/
> >> >
> >> >The following public repositories all have a copy of the
> >> >'v2.48.0-rc0' tag and the 'master' branch that the tag points at:
> >> >
> >> >  url = https://git.kernel.org/pub/scm/git/git
> >> >  url = https://kernel.googlesource.com/pub/scm/git/git
> >> >  url = git://repo.or.cz/alt-git.git
> >> >  url = https://github.com/gitster/git
> >>
> >> Did I miss something about GIT_TEST_DEFAULT_REF_FORMAT=reftable being
> >> removed from the test suite? That was available under 2.47.0 but if I
> >> supply it now, the tests crash at git init.
> >
> >Nothing should've changed here, and a local test run with that environment
> >variable works alright on my system. Could you please provide more details?
> 
> This is on the latest OS version of NonStop x86. The test is done via the
> following:
> With OpenSSL 3.4 The T0625 is Expat.
> 
> When run as follows:
> GIT_TEST_DEFAULT_REF_FORMAT=reftable GIT_TEST_CLONE_2GB=true
> /usr/coreutils/bin/make -k test V=1 CFLAGS="-g -O2 -Winline
> -I/usr/local-ssl3.4/include -I/usr/coreutils/include
> -I/usr/tandem/xml/T0625L01_AAE/include" LDFLAGS="/usr/coreutils/lib/libz.a
> -L/usr/local-ssl3.4/lib -L/usr/coreutils/lib
> -L/usr/tandem/xml/T0625L01_AAE/lib"  TEST_LINT=
> SHELL=/usr/coreutils/bin/bash
> 
> The results are:
> *** t0000-basic.sh ***
> error: cannot run git init
> Makefile:77: recipe for target 't0000-basic.sh' failed
> make[2]: *** [t0000-basic.sh] Error 1
> *** t0001-init.sh ***
> error: cannot run git init
> Makefile:77: recipe for target 't0001-init.sh' failed
> make[2]: *** [t0001-init.sh] Error 1
> *** t0002-gitfile.sh ***
> error: cannot run git init
> Makefile:77: recipe for target 't0002-gitfile.sh' failed
> make[2]: *** [t0002-gitfile.sh] Error 1
> etc for all tests.
> 
> Removing GIT_TEST_DEFAULT_REF_FORMAT=reftable allows the whole
> test suite to pass.
> 
> There are environment size limits (about 32Kb) in bash on the box, so it is
> possible
> a boundary was crossed internal to the test setup.

Could you please provide a backtrace for git-init(1)?

Patrick
