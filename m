Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB67C188580
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737370107; cv=none; b=UyPGAnFs+tvCBWqLr75iXJKJGGS9bxRR9i/HEIXV6HPD7n0k8qplt9sTpauYl2pjsIwvWJXGwoTBJC/HUzESv0C45mSP/2nVfiku1+1r2P5pUgsPXz5zSWNANP6RKX3AIXSyx1wisuWBmwvTAoeHFh+amsFvuvkWtDEQn+GFGx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737370107; c=relaxed/simple;
	bh=XFzh8rYi9pHXN7LxxCemP5mZVSnRPhJ9/zYxeBereag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWJnVIF9q21adCOHDWJCaRK5eYpbrGdTmmvaE47ucS1yA6Xnqn6Htbu56//HmRPtj82nFxKvKxfIYX8pEl7W5B4xi0mE9CuYlHOrnQ8S+CDnnIiADcIBSHgYM6muUOZKaR4Xa6TnzX/18CgUpiEPkzx0T4rrdOFPfRyXam4cFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=XxF1OXwE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nvDB2wKA; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="XxF1OXwE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nvDB2wKA"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE1A21140210;
	Mon, 20 Jan 2025 05:48:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 20 Jan 2025 05:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737370103; x=1737456503; bh=wol72Ce9Ft
	V/HRX4KKQtRoUYl9PWSqyDezaPXNTPhZU=; b=XxF1OXwEnZF1uoy85hzkZieFzW
	gZgTwsffvPQ2EZmI+h2wMdt0r7e7URsLpaUnWteyAUMNP1aoRF090eWbUha5jBBe
	W53EoLRtWXH3bTWvYmYfCGkV5jGhKt0Cjib6TOTQqmS4t93NzIC2PJ/qSTl4q1Ab
	LpR04sKNZ1j0ThXw1RJKXU59SIR6UdK1RrZMxxBOARBOdk6GU5KEOA7aBcTOLpz4
	pdZDFp86aLzz3ttg+28txSo1JO0f9AEuhnf6bhh39pF0scEEJalgiyrYbSWYmQC3
	IvP8lhMhrTHXXSgXMKEyZMhM5UcQ2tMAUBixSeelsoPldEvHfH9LvkJoKq2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737370103; x=1737456503; bh=wol72Ce9FtV/HRX4KKQtRoUYl9PWSqyDeza
	PXNTPhZU=; b=nvDB2wKAb6phawxepc217oBrOKxJtt1GYHegdDndPm15e3rHH2w
	1FUQTU4oNbiqasPCm6aNxvB8/DTjQSUWZgp0vrs9iyAYDKxsV11obM3LSWvgM4Ww
	+2a/fiJOKEihrbsaDztbloXOpSJ+s+5M8IuQ8/f/LSrLJ4kBNc7GE/UB0IFP6NZJ
	ciH2tlsIjfB9nI8lcezhnY39/8G/bCAVmdjCAjkyuKaVsZCB2IqOuE+oLcAKDU7R
	r9ptU5XM9DFdgjEzi6WtmpcR7X6KTXzpKUXYLlsHubgE59aqL9PT6W4b1bIUL5ma
	zOlyXnhsTyeKaYxpvtMZx1nqMNBRQDVtgVA==
X-ME-Sender: <xms:9ymOZ4qJubTqXDr3ZcaZTT-BY2nAh8Z-n8yKDgFfjve4fLUtJ6QrzQ>
    <xme:9ymOZ-qnv2MibWgaJijjUDPhVCybqQdVzKkqmoWpf27o0mDlRWAzpFB3_4ldf4ODX
    0MqKdJGRptVrvsd6w>
X-ME-Received: <xmr:9ymOZ9MSj1jM7dmka3tJqj-nZ813zGgBcfD67jrToyHsQAAGLF9L6MSRl7Y2kUNsaBip98Oz2PCKLSa8PVSlGLLPNmboRd-PAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujggfsehttdfstddtreej
    necuhfhrohhmpeflrghnucfrrghluhhsuceojhhprghluhhssehfrghsthhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnheptdeujeeutdelhfeljeegledttdektedvveetjeeg
    fefhfffhudejudehfeekffejnecuffhomhgrihhnpehgnhhurdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhprghluhhssehfrghs
    thhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9ymOZ_4BPNloUTBc2xaqTAlD0yU-t1Dqiwl2mTCOruEBJJiMyHhqeQ>
    <xmx:9ymOZ37Rwr7CqdYK7bPmDM7yYiuqGxhthP_mfGOmbPgjlADXXfUPoQ>
    <xmx:9ymOZ_gCOSY-e1qHwzM9RYm7RPm3fT2WJFTwBsIvq3vS5FZSjXb97A>
    <xmx:9ymOZx6lLr6OfoXvgzI_apT-cT1EQFLOhEyyUbgczzdXQH9jj2D_LA>
    <xmx:9ymOZ5nPsbHzXgE5J4VnnkK9qk3mr3RIppj_M6V8VzEWMCkhK9NO6fzU>
Feedback-ID: i01894241:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 05:48:22 -0500 (EST)
Date: Mon, 20 Jan 2025 11:47:56 +0100
From: Jan Palus <jpalus@fastmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] t8002-blame: simplify padding generation in blank
 boundary tests
Message-ID: <bwo4w2qbbe6czt4n7vshwyn4lbl2ieihqmdugz4fmnhd4qbsd2@tevhcjwigxbi>
References: <20250111231107.2190448-1-jpalus@fastmail.com>
 <Z4UIWId7ExLB2gWJ@pks.im>
 <xmqqr056bv8v.fsf@gitster.g>
 <xmqqikqd3p3m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqikqd3p3m.fsf@gitster.g>
User-Agent: NeoMutt/20250113

On 17.01.2025 17:09, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> So, my suggestion would be:
> >>
> >>     t8002: fix unportable printf formatting directives
> >>
> >>     In e7fb2ca945 (builtin/blame: fix out-of-bounds write with blank
> >>     boundary commits, 2025-01-10), we have introduced two new tests that
> >>     expect a certain amount of padding. This padding is generated via
> >>     printf using the "%0.s" formatting directive. That directive is
> >>     non-portable and not understood by for example mksh, breaking these
> >>     tests on platforms using that shell.
> >>
> >>     Fix this issue by using "%${N}s" instead, which is already being
> >>     used in t5300 and thus portable enough for us.
> >
> > Is "%.0s" really not portable, or is it just mksh
> > being a bit lacking?

Contrary to other shells mksh does not have printf builtin:

$ mksh -c 'type printf'
printf is a tracked alias for /bin/printf

so it uses printf from coreutils. This version however interprets "0"
as a flag marking "s"/"c" conversion specifiers as not allowed:

https://git.savannah.gnu.org/gitweb/?p=coreutils.git;a=blob;f=src/printf.c;h=2a73bb7fed892347eafb40f497ce5080f511fc9b;hb=v9.6#l586

> > "That directive non-portable ..." -> "Some implementations (e.g.
> > one that is built into mksh) does not support the precision to be 0
> > (i.e. "%.0" before the "s" conversion)"
> >
> > Other than that, your version is easy to read and understand.

Note that original version was "%0.s" in which there is some ambiguity
whether "0" is a flag or field width and not "%.0s" in which "0" indeed
would mean precision.

> >>> -	$(printf "%0.s " $(test_seq 11)) (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
> >>> +	$(printf "%11s" "") (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
> >>>  	EOF
> >>>  	git blame -b --abbrev=10 ^HEAD -- abbrev.t >actual &&
> >>>  	test_cmp expect actual
> >>
> >> Okay, makes sense. And as mentioned, we already have such a use of
> >> printf in t5300, so it should be portable enough for our use case.
> >
> > Thanks for reviewing, and thanks, Jan, for noticing and fixing.
> 
> Sorry, as Jan is not a list regular, perhaps I should have
> communicated more carefully when I said "Thanks".
> 
> The above message from me with "Thanks" does not mean that the patch
> is now settled.  There are suggested improvements pending that needs
> to be incorporated before the patch becomes acceptable to our tree.
> 
> Anybody can help that "further polishing as suggested" step, and
> when the patch is left in limbo for too long, I might step in to do
> it myself (when I have no other better things to do), but it is
> customary around here that the original patch submitter does so.

I was about to follow-up but didn't find time. Sorry it took so long.
I will post v2 shortly.
