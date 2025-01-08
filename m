Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB0D225D7
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 06:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736316870; cv=none; b=eP0li2/HLTjoySk7KvIheNP+EnTmu6On5IkyyfQrGWOnmCUZJVPVGBbdy/tLTugs6c41YgDGJqKzjwyjHbW2IY5OyMvNUktsu5SGQyxeyQt+pvvtaydVhIDW0uZgp/x305BZh3vboczoqJYLFGQVX5FQXYzjtr3ON8fkJPRCmT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736316870; c=relaxed/simple;
	bh=LWCNzHG60Wz4hLpsY1aZGUXUA1Zx5aDPn/oldWpgcgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ev9g4KS8wUqCtygJXsRBQrHA7h6Aa26dk+4fUr945ER5/mcqEOzooJO5LOvtH7XLjDaYAyZNUJjShtvoVcCc9M9zJGi/6KjALX4C5R8NtHzkpnPSj8hMY+sunklsKXQt5uLy94PAaIYw0ONrFUSVhWxRjjfxpjZQJbj9QeeCFHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FkEIXLqh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fnSq+7WF; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FkEIXLqh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fnSq+7WF"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D7163254017D;
	Wed,  8 Jan 2025 01:14:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 08 Jan 2025 01:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736316865; x=1736403265; bh=rNUb9sFQef
	hKCroR5nmW34kyMso5zGTrDjWUvEnHLEQ=; b=FkEIXLqhrYwQ7+1ZB1YO4UNo98
	Ck2w3KGakltLx+PtBz9RBYgpqmq8YUNYoD0Un6v8hl5yFYad5Ni2hSAvYURWMbVH
	xB4cl9zArFVaV66cajr1EP7n9IMiVHJuVENnFhBJp9SEGny7rtfrLBnromaCbnIu
	TcYt+PgMEShxqrwDJSBPZcZujwJynqvZPBMrulE2Wk1OZ1YPJDysR5Tc0e5ywC0F
	qu1NUoItY3V9rBDvxyMbn08XKfIhsDpi1XO7nHGAYjYn+gF0vYqa/gwRUqwHFRHR
	S70KuxLJ0F65c1VzDqB5CWYB00Pzevj/Hs44w1qbUCVZXIW3jwy8/WbtRQvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736316865; x=1736403265; bh=rNUb9sFQefhKCroR5nmW34kyMso5zGTrDjW
	UvEnHLEQ=; b=fnSq+7WFQrPQgbLemZktO/21BXHO083iSIV9rMFCd6THybMgef/
	mt7ZJ1M8RtYi+tkXiYyA4yxpkR3vFqCvimjPnMf6R2Lk5ru/L4jBrNkeIq2p0dr2
	YnxW7AkiE9icoAUUxVsAVkHgBdzzEUEMpo01/wFOa7h0BXS84ky8jhd+EVYbgAJu
	Hx+JPVKH/5MDKAgFpfLZmXfzm9v/liqY2cUGkoDltGIZj+iSKOCT7KWJCjtLi+f6
	Eus+PFlvcTDKD2oCk/dunE5EyhyRDx//Kxrjrkih9BpUxUOuqHEy4I7ijVmdJ434
	naQmkUdIwnwORhz4N875MStufNjlBxrcUJQ==
X-ME-Sender: <xms:wRd-ZyhQ_OLKbfqWHtJuWu4Tic61je_5kdI9dpG3HqWA7xL8FsIbIw>
    <xme:wRd-ZzAtSDJ0AQe1xV7VCEOh83Lo6KQVjKPjblgd2SjqeI879G16WaAHBlHJ4J39h
    q1RHDH77rU5PvRwiw>
X-ME-Received: <xmr:wRd-Z6G19IB1JaqKYsMt6rKMc8nLjreaCMnhxtj8gkhqCcXRIQanMi0UUW2bx-5dJ5s24UK-SjXrhjnoKOC8HnzKumo2ycejbWPdpNo0VySNpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegfedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhufhhorh
    hijhhileeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:wRd-Z7RnrxaXy8GE8kh_XVSChUf1AtuQVPsWh1RfDUbPYNh6NGYWmQ>
    <xmx:wRd-Z_yjDi6GjuL4xAXgUbUHGJMd3S8BdyIWeghhfSA5gTVXXEu-jw>
    <xmx:wRd-Z57WxvgW3xkRoqrRH3b8IUlc-lwRS1I9_QQj-b-7ndsET8_pwQ>
    <xmx:wRd-Z8zmwOG_cCOKO4t_5dwKOGylOcl8N5gXoGRB8jL1cXJTVTZKwQ>
    <xmx:wRd-ZxsDpE3oiJW4jzulSw1S9EnUfAhCReaZ22k_YKazPFcAFEifX6-Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 01:14:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d2e88f0e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jan 2025 06:14:21 +0000 (UTC)
Date: Wed, 8 Jan 2025 07:14:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] t/unit-tests: match functions signature with
 trailing code
Message-ID: <Z34XvPjhY15MFHrT@pks.im>
References: <20250107091932.126673-1-kuforiji98@gmail.com>
 <20250107091932.126673-2-kuforiji98@gmail.com>
 <xmqq7c76trpa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7c76trpa.fsf@gitster.g>

On Tue, Jan 07, 2025 at 10:16:33AM -0800, Junio C Hamano wrote:
> Seyi Kuforiji <kuforiji98@gmail.com> writes:
> 
> > The `generate-clar-decls.sh` script extracts signatures of test
> > functions from our unit tests, which will later get used by the clar to
> > automatically wire up tests. The sed command only matches lines that
> > ended immediately after `void)`, causing it to miss declarations with
> > additional content such as comments or annotations.
> >
> > Relax the regular expression by making it match lines with trailing data
> > after the function signature. This ensures that all valid function
> > declarations are captured and formatted as `extern` declarations
> > regardless of their formatting style, improving the robustness of the
> > script when parsing `$suite` files.
> >
> > This will be used in subsequent commits to match and capture the
> > function signature correctly, regardless of any trailing content.
> 
> I am not sure if this is going in the right direction, though.
> 
> Especially for things like test suites that are looked at and worked
> on only by develoeprs *and* these tools, being uniform and consistent
> weighs more than being more flexible.
> 
> Let me state it in another way.  How many of the existing test
> pieces are picked up by the current pattern, and among them how many
> of them would see vast improvements if they are allowed to have
> arbitrary garbage after their "I do not take any arguments" function
> signature?  Are new tests you are migrating from outside the clar
> world lose a lot if they are no longer allowed to have comments
> there, or would it be suffice to have the comments before the
> functions (which many of our function definition do anyway)?
> 
> A quick peek at [PATCH 2/2] tells me that this is not even something
> that would make it easier to port the existing tests by allowing
> more straight line-by-line copies or something.  The patch splits
> many in-line test pieces in the "main" into separate functions, and
> it does so in a rather unusual format, e.g.,
> 
>   void test_hash__multi_character(void) TEST_HASH_STR("abc",
>           "a9993e364706816aba3e25717850c26c9cd0d89d",
>           "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad")
> 
> where TEST_HASH_STR() expands to the function body that starts with
> a "{" and ends with a "}".  It can well be written more like
> 
>     void test_hash__multi_character(void)
>     {
> 	TEST_HASH_STR("abc",
>         	"a9993e364706816aba3e25717850c26c9cd0d89d",
> 		"ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad");
>     }
> 
> and we do not need this step at all if we did so.  Such a construct
> would be a lot friendlier to the editors that auto-indent, too.
> 
> So, I do not quite see much value in this particular change.

Yeah. This was something I proposed, but I already mentioned to Seyi
that I'm not all that happy with the outcome as it has a couple of
downsides, for example broken syntax highlighting in lots of editors. I
said he can send that version to the mailing list anyway and get some
feedback on it to figure out whether my discomfort with my own idea is
warranted or not. And your comment here basically confirms that my idea
wasn't that great after all :)

So I agree with you, let's scrap the idea and have proper function
bodies instead.

Patrick
