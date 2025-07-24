Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D702378F51
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351255; cv=none; b=oGuuixWkM76tfHEEY8Uiiec+sCtfTMtC/WuyULtzXu0K69cXjSAi/MjUxya7oqNIjV/rY/LZgVWcpKQmG5VOUrRgpoiROLL+HHKRwNOul6b89AUPaUiPaDfTRqJD4L4Wg8lzaMcQy7z0E+bGDJbrEFuL04bt9gVFXrmaRY5n8TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351255; c=relaxed/simple;
	bh=hMDJDCjEtDfQ45H+acQUFxvRf3kdQ+R1fApqyt+xq1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6y2ENvOgKHscvZkm0ehQ0XC9j9sZKWV4Mo9YhCfSG+ZRd5wZ7Na223ADWuDLY09shcnGYQQj+RMorUZDTedqDW2ni2+p2X3qWBOx6sEyZ8MNtW3TQSqCiXHRrDr02pVltOmjFmmMhYqfv7HcCNFTxi32wVq/J+nQXvdMtOK5Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XR3m3gbM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M+UQhHJ5; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XR3m3gbM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M+UQhHJ5"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id ABD791D0028C;
	Thu, 24 Jul 2025 06:00:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 24 Jul 2025 06:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753351251; x=1753437651; bh=ORx2E1dBqA
	A/d42GR3iLy7fpBwLj4Z3irgSKhG3hY4Y=; b=XR3m3gbMNrhsPEBkOG72JrDuSf
	EGQdu/Cu9zlPE5mulHq2+IjW3Hu4+6yFAmk++Y/ycuDJ7KZreGnWZCmLuCUAMcuZ
	0Srx/YLak+/5jfMqJsj64SNyBkwEw9dpvbLALr6/xQ0HCrnrkKMe7RIQdHGtHFQ+
	5wkG/y5T/O8gkxukCtHTK+zvT4KsvX1pN5iLHYOd8HwPS3MGDhqRvWtUe/zC2/Ta
	P4NXEPIRGPsSxq5n0sIJCs/5KTeS1zTW+GXHhtNAyfJKY7SOzul6zPF+7qyMHpMc
	0ycWm8Jw/tZ+CezsdxiO1j/ZAruQLHuJz7+1MxSfL7qhKgWagjE/9x3wivvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753351251; x=1753437651; bh=ORx2E1dBqAA/d42GR3iLy7fpBwLj4Z3irgS
	KhG3hY4Y=; b=M+UQhHJ5/23licLLqgUgRCVonEfVV3EZd3AOxpoceIhNwiLgKVC
	SbNiG29NvQHRUJb5aPh/2wji714IE6GsqUQd20R6vSKP0So3sXwDRUar1hBPzZyL
	yna0h8OS1x4tyw+rlbf89EXNfnNoK1hHeIjnz0SSp2GXexQIVWZ8z/9EZ28JYxM4
	w2CxL2RUa5cmq+bG3kJn8wBwAWjYRsuoEkYwAZv1QP1IHTZD8nu3FZtAqJMQwe83
	PkkYow++wQ0NcKV4qUwSEYnwToFCeCbHRgCoCqtrjmnQ4s2tHQAb8/OupgDHwCli
	vDc3WYz++cqAN9KasnFOe19z3aQ+4Pbazww==
X-ME-Sender: <xms:UgSCaPgdGjhbTXIDLjQ1hhSrVxHEnjKhhS4bbcxTOSevIvYuCOwQ2w>
    <xme:UgSCaKQYJG253u0C1ZGDBcZURMdQNatyA9ZfbZ-6pqCYASsCkbFKOtiT-1WBL5jYW
    eXq6yjoIpHOfrheCA>
X-ME-Received: <xmr:UgSCaIYZAM3FDXSlRkGYtBcSN4-0kchIhyKkP8j3EcWhi6DsZefX0tZpE6akrFLjOorTGZp-ROg2LRsEIi2-M5SLhwP-TKrMzHwBuZIY-Tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdektdefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrmhes
    ghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegvth
    hhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehnvgif
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpihgvrhhrvgdqvghmmhgrnhhuvg
    hlrdhprghtrhihsegvmhgsvggtohhsmhdrtghomh
X-ME-Proxy: <xmx:UgSCaPQUZhIujKk0YGxq1wVc_83u0QtiY2CQUMgvb2_3eFHBlIqMCg>
    <xmx:UgSCaP8-BUUAzueFGJ_YcOjVV6_hgvCobS_kpFXqQFaa-ediy8YZiA>
    <xmx:UgSCaHhXGgz0qKRvx8b288E4a_z3afemwRESr1qz3A_pH-DwtbJb1Q>
    <xmx:UgSCaIZHvkwzt8cU7LbuYa2l3o-spAP37P7H0r4NQSmCwRbsX0bg5w>
    <xmx:UwSCaLMvbN-1RJ9nnqq6BF1yg9VIItQF91ejtHg9DZQHtwwJEfTLsMc7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 06:00:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0366c8a8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 10:00:47 +0000 (UTC)
Date: Thu, 24 Jul 2025 12:00:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>
Cc: eschwartz@gentoo.org, ethomson@edwardthomson.com,
	ezekielnewren@gmail.com, git@vger.kernel.org,
	gitgitgadget@gmail.com, me@ttaylorr.com, newren@gmail.com,
	phillip.wood123@gmail.com, sam@gentoo.org,
	sandals@crustytoothpaste.net
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
Message-ID: <aIIETOdK4Nrsy5Jb@pks.im>
References: <aIBlxnoOqwHhGzMd@pks.im>
 <7bf054a1-0196-4ad8-aaa4-a432cd2c93a5@embecosm.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bf054a1-0196-4ad8-aaa4-a432cd2c93a5@embecosm.com>

On Thu, Jul 24, 2025 at 11:01:22AM +0200, Pierre-Emmanuel Patry wrote:
> 
> On Tue, Jul 23, 2025 at 06:32:06 +0200, Patrick Steinhardt wrote:
> > It would be great to know about the general timelines of these
> > alternative implementations.
> 
> We still think we'll be able to compile libcore before the end of the
> summer, we've made great progress and few items are left. But keep in mind
> we're targeting an older version of rust (1.49) and libcore is smaller than
> the standard library. We still have a lot of testing to do and we expect
> many bugs.

Understood. Given that we don't plan to roll with the latest version of
Rust anyway I think it could be a viable tradeoff for us to also
consider gccrs when we determine the minimum required Rust version.

> The next targeted version will probably be rust 1.78 as we want to keep up
> with rust for linux. This shouldn't be too long as most of the features are
> coming from either standard library modifications or nightly features we
> already had to support for 1.49.
> 
> We expect to be able to compile some 1.49 code correctly next year at best.

And I expect that 1.78 will be another significant effort that won't
land before the year after?

> I would like to bring to your attention rustc_codegen_gcc which adds a gcc
> backend to the rustc frontend, although not a full gcc compiler it could
> help supporting some architectures that are currently not supported by llvm.

For my own understanding: is this something that the Git project would
have to support or something that the distributor needs to set up?

Patrick
