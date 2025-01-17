Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4488C11
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737107076; cv=none; b=IMaM5qgM8kQB81AMXMONytlZGz7n/ZlZAYFkbBFgZe++qHkq+FMQrcx4vtEhzKlcrmIe2UtseO557JMM/y9A9ebsxc6lZ/Xy/RMHzXzvOpe35o/vvMktztQuPPjkTytA+ZmNQKKvI4WzAdQYGZYnxXw+STyO1hdU/HQ45edrgAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737107076; c=relaxed/simple;
	bh=Zz51AqhEdES9OtS+XybzzwGysQSeT4jFpNtYXb/H3N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5+D70tvVXloXQBKa+3cLQ/1FQbQcVOgszZVN6Exa/8B63ZzFXKfsjkLnizEq03U3jF1jaf0PoTfgGbCqUPInIYxTTJH+Z3nGwakFJa1Wu3t47T+RzBxL3/KsetL/jnG52Uns2wcf+s6LypCVLRF7kvPvbjN0dwIVImHqWIlrP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k+Dl5kAF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jVSeSyts; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k+Dl5kAF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jVSeSyts"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF7E511401B7;
	Fri, 17 Jan 2025 04:44:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jan 2025 04:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737107073; x=1737193473; bh=p3bDU2VzEu
	mFQBFQW8rsUXYbW0q+gMgYEr7qMt10n6c=; b=k+Dl5kAFqeGg6oSq1d57p/vR4h
	tGU+on4/XMiFt8yPIZYvGi0lEQNGEGXw2yYXz4EhSDc8XyjXeneJzz5OBfAd/oMT
	oYf+4A2mTSgTHVn6COSRFGTGnhzOLa3KuGe+26gQp3KAxQ3d0IERShcDFpNP8re7
	oJ9jU1zGfINGhRJhZ6XNFsbmgILSn5s14e2c43juOLuiH8U2YPL9uhU1iMdl8sRI
	c8ZLBKWiPXDt63zgX8f0h1gUAz9TYXF6Dm6eisA1IoV08F1uQiloxaPCYTFA8n+E
	20VhVUSSrsdqJzvTbZaXWKvzA5eESQ+xNKDhFv2LxnRZMwzbqFNfxtqDMBkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737107073; x=1737193473; bh=p3bDU2VzEumFQBFQW8rsUXYbW0q+gMgYEr7
	qMt10n6c=; b=jVSeSytsAMqLTJPLAQLYv4gnX0MlQagJix/6+1K+Xd/T1eomtqL
	fZx6oB63lqq1FkcR841KUwmJU5yhjMxFIbn6CVQVVX8FocvZOCbapjfkJJ563x0t
	hgIBHraIeH6lKCIdkUofPn8KrYOJTVokVB+8VehihCz2Ax9MBdQACY5hwxeGs1/W
	qmYrdU8clWp+O/zSzzsjTfS3/MrT36BRNTChXknqtGsUSpFtcZIhYwBhOwhyksN9
	KLF+mQ/Qd0cSArXZwIH+02GP3GmOUw5zarN3kAeTZzDJAjVXZMBDUBHNAcIvVP00
	prVk9lX1vjzOPmsr0be+uHrutpaHqTBNwlQ==
X-ME-Sender: <xms:gSaKZwa7hEOmhWzuVdFP_C1hYRRD2m6gaN3_sli7S2n1z-mod3kOcg>
    <xme:gSaKZ7YhCeUb46hdA5Ksl4MKCbsps1EL1qQyoX9pBnbtSYx5-BrHD2HnCNgBOb7v0
    pWjRQvcdvp3mPa3ug>
X-ME-Received: <xmr:gSaKZ682VZhr2_xak0GFw-WTEkeM8grRGv-pDxwlo93QyzoZOZZAmwH-GEVbO1shVIJL9Ncd8C2ZJV0-3bdJZLuEeruajE4nzBeEuxoZrEOCwz4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hllhhrvggurdhsvggrnhesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegvmhhrrghssh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegtrghl
    vhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhhsehglhgrnhguihhumhdr
    ohhrgh
X-ME-Proxy: <xmx:gSaKZ6ruoNvtmeOwZOvsmqHyZ4_FLoNAX9faB12JlvQbDUUrTc1Uxg>
    <xmx:gSaKZ7oe7sb1NFE985Ybupq16iQ2CbtkLdLUiojy2sIJ8ttfizpuPg>
    <xmx:gSaKZ4TNXMOUOUVrsCDmH6KUB6toq1G2AeRfSSEa6mGibDmoVQz-Cg>
    <xmx:gSaKZ7qqde8PrHjlmIzqY1CuzCBYFkLziFkGf_tT7LQNSiRWtNTlQw>
    <xmx:gSaKZ0RJkTIwBW5uhYUDfcknjz2HAfwCz6gReUE7tlsFG-FuR7t3LJ1Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 04:44:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 53f689b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jan 2025 09:44:29 +0000 (UTC)
Date: Fri, 17 Jan 2025 10:44:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, nasamuffin@google.com, emrass@google.com,
	sandals@crustytoothpaste.net, mh@glandium.org,
	sunshine@sunshineco.com, phillip.wood123@gmail.com,
	allred.sean@gmail.com
Subject: Re: [PATCH v6 1/5] common-main: split init and exit code into new
 files
Message-ID: <Z4omfC0v_UIBRiNM@pks.im>
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1736971328.git.steadmon@google.com>
 <ff6cd62397ec2755d15e9d76f9af8a84b54a36c1.1736971328.git.steadmon@google.com>
 <xmqqr053wvip.fsf@gitster.g>
 <xmqq34hjv5kw.fsf@gitster.g>
 <xmqqtt9ypj4m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtt9ypj4m.fsf@gitster.g>

On Thu, Jan 16, 2025 at 01:02:33PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Unfortunately, build based on meson does not seem to like the
> > init_git() thing.  Perhaps we need to add some missing files to
> > relevant lists in meson.build file or something silly like that?
> >
> > https://github.com/git/git/actions/runs/12800227601/job/35687658673#step:8:961
> 
> I needed the following to get "meson compile" pass in my local
> environment.  I suspect that Mesonized CI jobs exercise a bit more
> than just "meson compile", so there is no guarantee that the
> following is enough, but at least hopefully it would nudge you (and
> those who may be interested in helping to build a working Rust
> bindings) in the right direction.
> 
> I think it should be squashed into the step these files are added,
> i.e. [PATCH 1/5].
> 
> Thanks.
> 
>  meson.build | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git c/meson.build w/meson.build
> index 0064eb64f5..e5ba28b47f 100644
> --- c/meson.build
> +++ w/meson.build
> @@ -245,6 +245,8 @@ libgit_sources = [
>    'commit-graph.c',
>    'commit-reach.c',
>    'commit.c',
> +  'common-exit.c',
> +  'common-init.c',
>    'compat/nonblock.c',
>    'compat/obstack.c',
>    'compat/terminal.c',

Yeah, I remember having the same hunk while Meson was still in-flight in
order to make it compatible with "seen". So this should be sufficient.

Patrick
