Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B2C16BE01
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541137; cv=none; b=izUmRlS5eyuWrXTpbHIqf0ztrxeOnZzuEcj9PgnOYyVi2ZUhomC5eWglontJ+70WA9yyRkx0Bx1fbcFwtc0H60HEeg3C0VJ7t2aNtrLbCElNvh5gqlBOFuVl9sO7oCCUcS1faOB+ybDaGhTANH/0Ab0ZiPSYhP8/fB1PWqcF7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541137; c=relaxed/simple;
	bh=pJP6Ua0zwvXkxIOx6v/LXybq23B3b0BivRuLOGS39WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGSddTF/16JH5RV0cpv/tiM8fi8xkyluZb9pA2j5fYtj0XEIghs4o77U8DV8INXYsanzRZw260zi4gvYjoghndS4vhXP76nFQSTnSx5XBJabxEpt4BndcBkXxks7yUTrU7vUlmvpYKad6IbkJ3mXkYK+ydbNpHty99Gzvc9/hb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XKDOJBuc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PwJXIexQ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XKDOJBuc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PwJXIexQ"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id E0712138FD10;
	Tue, 13 Aug 2024 05:25:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 Aug 2024 05:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723541133; x=1723627533; bh=1ppFlfSos1
	87ba8KnHpOVK+MX07MwniK5EAfrPVuCTE=; b=XKDOJBucEqN+MeH5nLPqmNH/i9
	JPymSaqiXsYkrJn6fZJ+pJv3zk8hKTKoqhQWi+9vulhJseSjeGObXXzjUBi3ReFW
	wGKvUu5iz/gaKIpa8JG6FahIvqBI5PQIFeDDt/EIuE8/ORTFY5qvuEd1YlqdGCAg
	LP0J13MNr4co7VKyg8OeRffEFHSslU7o7USUL6DUVMGN/aBXP6V+K6ARUapNmLCb
	wtZtJTeuudDCqqJAMDJwf5GHMutSkSqxz4PeBeSKuK17nbj281wNSoWziMTpthBT
	OfsGf3UEkUxt7L8YUwY4C/0mT3lMMRyUncB5LazQ8YCYEeO++hXgm7P2qJpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723541133; x=1723627533; bh=1ppFlfSos187ba8KnHpOVK+MX07M
	wniK5EAfrPVuCTE=; b=PwJXIexQQM1AApQQYxXcWpZhJ49jc2ifCRU6HSTS/y+5
	PrQ/B2GAjkMgOevaYt+LQnc/aVULdZhk6CQXy3p4zk3aP37/cPcFJQh25IxKLkfU
	HK3CZhAeuJf2RDMSxk3Vc6gt3Cj8GIfX92JV6PpGZlwL2qhPP1wpj3jHDXXT3QwA
	2nunbaqtqyqLLOmG1UQT+GsNILHQcWZzuhtuOlEJCiZHg/8yxWIShc+WGURg+QRq
	7dB5sC6/9qYQCvWtQTZaefmJUYfyFk1uZ2oisHwjsSKuqH3Qtepf0DfVYAo+u+fO
	eSl667i5l6twcHWrQFPHyGbxAplbNvAxYBn+y0FTLg==
X-ME-Sender: <xms:jSa7ZqNAoiy0KbXIAFC32iBbC8O93vsD2J37lB8zeWScJcjAdQqvtw>
    <xme:jSa7Zo8TYv_Z2Wuhioa30S38BnAtvnr5r0Fjum7XRxm8BP0Amd207fNmQeWGhMevl
    XuERTH8FsXjb2Rr_w>
X-ME-Received: <xmr:jSa7ZhQmidtFjE6Tbn7ucQohKrrgWRDnQ1WcM-8EaWcop0v1WVv96IcLvA7iaAltAxRhg2t8fL5VxESzqnEXGlz2LGmXrTKLV4--PfQkcm9a5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jSa7Zqua7mgsucpnZtUxU-yqMh237Odl4x3GCRFncjP4jSk_Z2lXJw>
    <xmx:jSa7ZidBdSjqLcxBYjG4xUnl86wbm_ITqjyrLrNLINM94l6denz_gA>
    <xmx:jSa7Zu1jUPUswc0miZSzX1v4BKAyioE5FhGNRwgNHO7n-1wPITWzHg>
    <xmx:jSa7Zm8LG8SsO5gjlnzkkHZChOxaRk77Kr9ucYwZvTD52SXi22Fckw>
    <xmx:jSa7Zi56Vhd3KIusTUAUla2w6L0uqGhZ0QiGwS1_RecsQ01kNMxrux1X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:25:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ecde4365 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:25:15 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:25:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 02/20] path: expose `do_git_common_path()` as
 `strbuf_git_common_pathv()`
Message-ID: <ZrsmiWeu8JsX54nU@tanuki>
References: <cover.1723013714.git.ps@pks.im>
 <e7a143c30dd95d8192eacc35c876e7926cb7c6a4.1723013714.git.ps@pks.im>
 <ytv7y3jlbaru5o3ehotanqoqvjnwaomzsyj746k3hbb3htymts@m4qct6cvebiz>
 <xmqq5xs9eh4p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5xs9eh4p.fsf@gitster.g>

On Fri, Aug 09, 2024 at 10:32:54AM -0700, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> >> -static void do_git_common_path(const struct repository *repo,
> >> -			       struct strbuf *buf,
> >> -			       const char *fmt,
> >> -			       va_list args)
> >> +void strbuf_git_common_pathv(struct strbuf *sb,
> >> +			     const struct repository *repo,
> >> +			     const char *fmt,
> >> +			     va_list args)
> >
> > Here we reorder the arguments to make `strbuf` first. I assume we are do
> > this to align with the preexisting `strbuf_git_common_path()` and use
> > the "strbuf_" prefix in the function name.
> 
> I thought that we already established as a general guideline that
> "strbuf_" should be cleaned up so that functions that happen to use
> strbuf merely as a way to carry parameters into or results out of
> them but are not primarily about string manipulation are renamed out
> of the "strbuf_" namespace.
> 
>   https://lore.kernel.org/git/ZqiLA0bGYZfH1OWD@tanuki/
> 
> And this is about getting a path, which is communicated via a
> "struct strbuf", and not the standard "char *".  That is a prime
> example of a function that we do *not* want to stress strbuf-ness
> of the function.
> 
> > In the previous commit we used the "repo_" prefix for
> > `repo_git_pathv()`. Would it make sense to be consistent here? All these
> > functions are operating on the provided buffer, but for a given
> > repository. Not sure what would be most appropriate here.
> 
> Yes, if the function is about obtaining the path for a file in a
> given repository's metadata directory, and its association with
> "strbuf" is that it merely happens to use it instead of "char *",
> it should not be named as if "strbuf_" ness is the primary
> characteristics of the function.
> 
> strbuf_cleanup_path() should also be renamed for the same reason.

Agreed. I was doing it for consistency's sake in this case, but let's
rather not make the overall interface any weirder than it already is.

Patrick
