Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBC2314A82
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776274765; cv=none; b=cbeplBWfraw+PYNadzbQ4gbAqnEUttnbyz2eoxoaHOY02G9UFoQg8K2dXBmgMQJ+OgmcLEwp3Ee81sq/ItFNV/2geAA73Gpc2xl3Gt+XOaoXWJDioXFu5x1BjGmKts2GdS0jsXcm7sv93jWK6s55UrGsuMh0BlrDymBK9uypKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776274765; c=relaxed/simple;
	bh=xCgtwpxyRqkZWcXBM8c8PJPyD/4aVd1/QWMCDGGyK68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R5bpMvARAi4s5wkIsrtRsbev/cIgsDC/DJw4gFkEtcTztd5NGG9Eyl4N5kRpm8byr6RfBeb+uWa+roMILigbyqU+Mnzxvca696Rp7DTH/ZUnejtju6lHb05I3Ksjmbig5G3GrHMhtAuOhYAube16vAs4K2699YyPBZ7EY+z+lOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=t25SgKE/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bmOnFyEE; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="t25SgKE/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bmOnFyEE"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 513237A011C;
	Wed, 15 Apr 2026 13:39:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 15 Apr 2026 13:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776274763;
	 x=1776361163; bh=8UBMhRHlOkog6PZTUOkDDl6YPSWaRO9u1/4ZuuX9/yg=; b=
	t25SgKE//9QQRr3BLzp3XRiQ/hjK8e4TEaKXpeLWrgwYcQyXltobO8ceJzumnYZy
	lbqoGWocUQ7QINofinmZffQKL9b7sbTq132GUfRayaslW8ZLM3ieV81hKAmevU2p
	sc70SR5DdEC/LSUJT7Uiv3p7355+2gbnUK5OK/GHmlEs942eg1JUJs29GK7gt0Ci
	n4yGbLImIAcuCfCw7NI6/dHWKYSvuTHhCOsnod7pikSSjqV2d9sJ+SCXVgAreUGc
	nRxhkY1aFaQ2awlr5CRBq/6KNv1GA8kqGRhImCQ+faHJ3A20st3fZbl48rADJETC
	aTaP0i7V+BQiYLXwquphlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776274763; x=
	1776361163; bh=8UBMhRHlOkog6PZTUOkDDl6YPSWaRO9u1/4ZuuX9/yg=; b=b
	mOnFyEEAfXltMBaSePWDiylQW/cB1/hp4EC2LJRJPJ78LhPa/vGH4+qZzkWZ0SqM
	nKr3az80qnbinlzXMxDRPk6LRmsllOwSWlLURVXu4CW8NyO1frlW4z/9lC9K7qDJ
	R4g/DcrY2TbNrWOoKQDuKr/aqure893uHmZm7oYaqaPLFmfBiJ1Uh+wyv5YxTFCW
	aYoPQL7WycAm5kuekR9tyDl6R8eab4TJ8HRrE4C01nu5dHptCyyUwAf5H8269lO7
	4aw3AgO0gfkDL1jt8LBIvxIuUVUmbhfvGrgoo5NsKB3KyRAdI00twJ2zlKVgVbJB
	LPkygXcAazoYOfTm7NyLQ==
X-ME-Sender: <xms:S83faa3_B3DwSqL6vzE5xU5Ick_bXJmzRuZWUfYPkOUd7jpkflZ7ZA>
    <xme:S83faUELyP9MHgs5H9y3o8M-NbK9kvH6AxRW_pOciTCTlaOgOe5NbEjEZhGUOvfOa
    b2isFw34bPpUMczSlMMGXV61nkjWFX5E8Mzx_AjTdhjrUhGK9aGA-E>
X-ME-Received: <xmr:S83faX4-H87dEHJSdIqUnu0d_lxy8hhFWCzn3BnmfSQM-XkjmP3Ukke1G7tHOSGQmvvHV22bn8xgl-Zl5llh6um7CfXn3QpT6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhkihhn
    ghhttgegsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:S83faavduo6F26UUOY6eZ2t1AS6NNkM2Fx9A-oQPW6bgy6lRpDKqDg>
    <xmx:S83faY45nflPEEHyHo6A6dGgdLLCHuzFHwk10vrjmqupWk9BieiR-g>
    <xmx:S83faVVjJQsVB_bS4k0jpvAaQFCagt6eb76iM3DGxzQxmH9gE970uQ>
    <xmx:S83faa-8cCYaXaMnXTkJUgI8R6loS_8TmafXZUGxunZ5oA3sCao62A>
    <xmx:S83faUqYSoGlNimUcsKbw_FfLFVGYVOZ1MdJ8Ry37hG4gkstXFVIBxZx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 13:39:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: Tian Yuchen <cat@malon.dev>,  git@vger.kernel.org
Subject: Re: [GSoC PATCH] promisor-remote: fix promisor.quiet to use the
 correct repository
In-Reply-To: <fcnv7hv53khhctafvzqn6dygbyq2tkyy4i2gawcbahdnevg2hw@7h6bvxlub7ib>
	(Trieu Huynh's message of "Tue, 14 Apr 2026 01:22:00 +0700")
References: <20260406183041.783800-1-vikingtc4@gmail.com>
	<fbe81fee-ef1a-499e-bf53-d6f1761bb30e@malon.dev>
	<xmqqzf3dxqdy.fsf@gitster.g>
	<a6382ad3-6ce4-4e85-bdff-8e90068f25dd@malon.dev>
	<fcnv7hv53khhctafvzqn6dygbyq2tkyy4i2gawcbahdnevg2hw@7h6bvxlub7ib>
Date: Wed, 15 Apr 2026 10:39:21 -0700
Message-ID: <xmqqwly86s3a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Trieu Huynh <vikingtc4@gmail.com> writes:

> On Thu, Apr 09, 2026 at 12:34:47PM +0800, Tian Yuchen wrote:
>> On 4/9/26 02:23, Junio C Hamano wrote:
>> 
>> > FWIW, I didn't see it fail in my local environment (both in 'seen'
>> > and also standalone) or at GitHub CI (in 'seen'), so it is a bit
>> > hasty to conclude that the patch was sent without proper testing.
>> 
>> You’re right, I was a bit hasty.
>> 
>> > I wonder what is different in _your_ environment (note, I am not
>> > saying your environment is _wrong_.  It is just different, perhaps
>> > the compiler I use and your build environment may align things
>> > differently, or perhaps on-stack "uninitialied" pieces of memory
>> > happen to have different values that the code is reading that causes
>> > different behaviours---in which case it is the code that is wrong.
>> > Asking for environment differences is the first step to figure out
>> > what incorrect environment dependencies the code has).
>> > 
>> 
>> ---
>> 
>> git version 2.43.0
>> cpu: x86_64
>> no commit associated with this build
>> sizeof-long: 8
>> sizeof-size_t: 8
>> 
>> Using built-in specs.
>> COLLECT_GCC=gcc
>> COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-linux-gnu/13/lto-wrapper
>> OFFLOAD_TARGET_NAMES=nvptx-none:amdgcn-amdhsa
>> OFFLOAD_TARGET_DEFAULT=1
>> Target: x86_64-linux-gnu
>> Configured with: ../src/configure -v --with-pkgversion='Ubuntu
>> 13.3.0-6ubuntu2~24.04.1'
>> --with-bugurl=file:///usr/share/doc/gcc-13/README.Bugs
>> --enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++,m2 --prefix=/usr
>> --with-gcc-major-version-only --program-suffix=-13
>> --program-prefix=x86_64-linux-gnu- --enable-shared --enable-linker-build-id
>> --libexecdir=/usr/libexec --without-included-gettext --enable-threads=posix
>> --libdir=/usr/lib --enable-nls --enable-bootstrap --enable-clocale=gnu
>> --enable-libstdcxx-debug --enable-libstdcxx-time=yes
>> --with-default-libstdcxx-abi=new --enable-libstdcxx-backtrace
>> --enable-gnu-unique-object --disable-vtable-verify --enable-plugin
>> --enable-default-pie --with-system-zlib --enable-libphobos-checking=release
>> --with-target-system-zlib=auto --enable-objc-gc=auto --enable-multiarch
>> --disable-werror --enable-cet --with-arch-32=i686 --with-abi=m64
>> --with-multilib-list=m32,m64,mx32 --enable-multilib --with-tune=generic --enable-offload-targets=nvptx-none=/build/gcc-13-EldibY/gcc-13-13.3.0/debian/tmp-nvptx/usr,amdgcn-amdhsa=/build/gcc-13-EldibY/gcc-13-13.3.0/debian/tmp-gcn/usr
>> --enable-offload-defaulted --without-cuda-driver --enable-checking=release
>> --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=x86_64-linux-gnu
>> --with-build-config=bootstrap-lto-lean --enable-link-serialization=2
>> Thread model: posix
>> Supported LTO compression algorithms: zlib zstd
>> gcc version 13.3.0 (Ubuntu 13.3.0-6ubuntu2~24.04.1)
>> 
>> Linux malon-Yoga-14sARE-2020 6.14.0-37-generic #37~24.04.1-Ubuntu SMP
>> PREEMPT_DYNAMIC Thu Nov 20 10:25:38 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
>> 
>> ---
>> 
>> By the way, I find this bit of code rather confusing to me:
>> 
>> > +	GIT_TRACE2_EVENT="$(pwd)/pc-quiet-trace" \
>> > +		git -C super-work grep --cached --recurse-submodules "world" \
>> > +		2>/dev/null &&
>> > +	grep negotiationAlgorithm pc-quiet-trace | grep -e --quiet
>> 
>> Is this grep pattern correct?
>> 
> AFAICT, this intent is to check that "--quiet" appears as an argument
> in the trace2 event that contains "negotiationAlgorithm". That said,
> the "-e" flag tells grep to treat the next argument as the search
> pattern, so "grep -e --quiet" searches for the literal string "--quiet"
> rather than grep misinterpreting as one of its own options.
>
> BRs,
> Trieu Huynh
>> Thanks, Yuchen

The discussion thread stalled at this point.  Are we happy with the
proposed changes?

Thanks.
