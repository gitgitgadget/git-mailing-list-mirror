Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D542C326F
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 07:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806235; cv=none; b=OD5qzjYidvf5AbgZbGGHMKmo/2jfLRRQovVbzgLmIocfHiVCdyo+rPozDJlskH6tKYIDW2Jgu8eE8QCl8piFZqpM6K0M1lMV4faqqR8HvJWNBs4CHco+yHBxByq9m0ZXARKxumBhGaCNoSk6eVzRDK1dp4+KNlDovUZ6y1CJEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806235; c=relaxed/simple;
	bh=VtcdjKwRWn/yp+1HF7S9vpXZKDByJYIBMO1W/C0NvWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n44LHLF1w2UpOjCxAfb2LdcdhWrqNQxPeYVQAEeVYRsHUkxKHrgZLCZP/TVpZ4gFXkeTs9qY87wm5hysPiajb1rmkRkTG1HPf3A3545709678b6S0s5BYwMXyfUhDbAHst0Jmb+QlBa1/AX2Jigg5cB+yvDHVF16wjIXgD7Iupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KhMB79Jj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FE/YJs4i; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KhMB79Jj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FE/YJs4i"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 74AA31400701;
	Mon, 19 Jan 2026 02:03:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 19 Jan 2026 02:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768806233; x=1768892633; bh=fNsbEEmmrA
	yOo1SPcPfEZChjvWfxklFvxY/u6MYxHRY=; b=KhMB79JjLMp993Q4IdHRkoOp32
	JwBa2bSC7N/0IwNBedkihFSA8/JWeZ4VoNXHwXf/6uqUNTAyuNx2QLdWyl1AzajL
	BmyZIlaxuJTRE3OeP6Uyr6tsroJD+7MZamYSOtq8HbrIQraJKqc7hn9WMNF4h3/Q
	TNBwpqhjPm40rJNmoUtYO9LC3zKY3Q3UYyIMhBZM96qlOySDfv2euplbEpdJAamC
	Ppvx8QKCc5MISaxuR75r+mT3IR+v7l8rULXyQOsuysky4oyysDsIwMbiflovGK9a
	aXZVEZ26vq068AdePceiuuMawTAKUnT5kNARuDREtI0hVlhuOk4pFbO1fmEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768806233; x=1768892633; bh=fNsbEEmmrAyOo1SPcPfEZChjvWfxklFvxY/
	u6MYxHRY=; b=FE/YJs4igdtYDySYY3hl+abSCSKibeke2cozd7VooHo9fxd5BRE
	nURytYtwp2av4pkxY71EwGI3IubhcCK+1FKVl9a0FC7mHGlVju4eMMFffQO1qfU4
	vbKut5fFNWHjvEM3qgt2BNJqTIuaVSHxorHeTSG3tCh1wclstuePJhMjDIPsHvi0
	11yEfQG4XzcnKnQUnIzAxVpAx2hutxS7wkbUCxq6LmcfBTyzeyDyaLEvoq37NmKa
	M03/IgQdtPsBuZ3jKt/k9SgIZ3ku8T59PUq4zdZjSx3wEb1G67RwLN7IzR14jIaJ
	7Y0VdpK1+nrVY8AQjOEUz4BoPm+kG21cLgQ==
X-ME-Sender: <xms:WddtaadHgq0hwa907TcovFLHvOp8pwfYWGvVM3J44hFFEfK5xujbSg>
    <xme:WddtabNM-y9GmorJQripFR85wTOs3e5ggW8yOcHR6t2jOdf_cW3nmHOsXT8T7UGji
    uTASvp0BXa2GkFKe-QFaK4ukQhTRc1k_6abB9totlKVnqkNg5e6qA>
X-ME-Received: <xmr:WddtaQiI1pFxsqqm-38fqNSC8fBJLhfC0D2t32lU1_wALwScPcw_23VA99n-G1jgte75lDeNcW7ElhPP3q8g4WQ2PbIX1BHDuO4VXq7z0Fo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeileefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    iihhhihihouhdrjhigsegrlhhisggrsggrqdhinhgtrdgtohhmpdhrtghpthhtohepfiho
    rhhlughhvghllhhordhnvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:WddtaW0pDwenksC5xGZRrmryxbPWpCIefGbVhSFobJioJEtt5chnIg>
    <xmx:WddtaSjHaQQKpm-IFw5syRPsMOsv6pMhL0UAFuqqV6SecIVq-P9_XA>
    <xmx:WddtaecJboF0k7CWMUugBOHQX_77WU-f1Y7AcQ3bTB2Aei5hTPYC-A>
    <xmx:WddtadnUnvOHQWeZDw7_IP3nUFI0f5-6BB9P1UxmZvfsf9yjFyybqA>
    <xmx:WddtaUhqntIz3vwoMeiUKq94kAdfHnK5umeiL2QhT4cKjKWM02B-4R_M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 02:03:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 98462ce6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Jan 2026 07:03:50 +0000 (UTC)
Date: Mon, 19 Jan 2026 08:03:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <worldhello.net@gmail.com>, Git List <git@vger.kernel.org>,
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] help: report on whether or not gettext is enabled
Message-ID: <aW3XUxaomqGbtpEj@pks.im>
References: <f3500e698fd40297d2e2634785529b76d49ca470.1768530514.git.zhiyou.jx@alibaba-inc.com>
 <xmqqo6mta7bg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6mta7bg.fsf@gitster.g>

On Fri, Jan 16, 2026 at 07:46:59AM -0800, Junio C Hamano wrote:
> > diff --git a/help.c b/help.c
> > index 20e114432d..96d70d8e6c 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -799,6 +799,11 @@ void get_version_info(struct strbuf *buf, int show_build_options)
> >  
> >  		if (fsmonitor_ipc__is_supported())
> >  			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
> > +#if defined NO_GETTEXT
> > +		strbuf_addstr(buf, "gettext: disabled\n");
> > +#else
> > +		strbuf_addstr(buf, "gettext: enabled\n");
> > +#endif
> 
> Presumably, we do not care too much about the version of this thing
> unlike ...
> 
> >  #if defined LIBCURL_VERSION
> >  		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
> >  #endif
> 
> ... we do for the curl library, so only reporting "enabled" does
> feel perfectly OK to me.
> 
> I would prefer not to see the "disabled" entry myself, by the way.
> Combined with the vintage of Git binary that had these help text,
> the fact that an "enabled" line is missing is enough clue to
> diagnose.  I know you mimicked the Rust entry before this point
> (just above the precontext of the hunk), but I think we should fix
> it to drop the "disabled" entry from there.
> 
> Cc'ed the author of cb2badb4 (help: report on whether or not Rust is
> enabled, 2025-10-02).

One reason why I personally prefer to have enabled/disabled is that it
allows you to discern the following two cases:

  - You have a modern version of Git that doesn't have gettext.

  - You have an old version of Git that doesn't know to print
    information about whether or not gettext is enabled.

If we don't print the info at all when gettext is disabled then it's
impossible to tell these two cases apart. That argument in my mind also
extends to libcurl, where it would be more helpful to print "libcurl:
disabled" if it's not used.

I don't feel particularly strong about this though.

Patrick
