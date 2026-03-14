Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6D530FC39
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773506934; cv=none; b=mKxCRYkjy5/4h6nDFLC0+zg+Q+wmkrcJiTwoD6koBq+GR3oZY41UW5aohFn6MvciybyU8TNItjrnNC7lZqeXdFKQ3ukRgqIt4zEFydLfGvH9QzNLsl/J04wNklyPmAVIpICHt2sh9yi7y64DRB5pvZm9cu8Aa8LJmVIPgzWuj4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773506934; c=relaxed/simple;
	bh=VaH4UMSsRJfV3BbrV1gdE9E5HmROWCPzeD7+5ktkcfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QqIsRWgJj5oA2NK+5k19sUd9truqZYCmge7tErfK3nWEudBXiWDmZPGSaZDPZ0BsrJgWnlEqB2HbBFe9RXxselxC8rFBHSiyHYWmkRRLA06lDG2m4DN5mPAhouY6THiOaAcmrDxBvDEoO27oCCdjGdfto8R+NlVbMnklP9ldxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bNPkh5IM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=42ZGKzny; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bNPkh5IM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="42ZGKzny"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 73F027A0065;
	Sat, 14 Mar 2026 12:48:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 14 Mar 2026 12:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773506932; x=1773593332; bh=kXPDFrm9sQ
	0HVvpZykADBD6ITf9bKDi66FHKYX6PodI=; b=bNPkh5IMnXWEWIPiUIXL6KkMFs
	SNfwLrsUMkQ1IZfGGPgI5sQQyIx4/OqlPhWGEXdY15vLLjmQcsbxQILGWBQIEd/u
	QmF08YPim77zktrqjvQOv0QeptdoZf5tOhbAwgJ9zVj12GNa9MgzhFrMNH07T0yV
	/YfXCiYpE+fxqzV1I7hCv1+oTR+gYdlpIUR/KoDd5buCPQXS7Kfoj8IiiGBbcAm2
	Mq5oj2EGMZRBCJxeGOZJPFCpIDkUOWU1qnt3uVAsv3F4shTn0VAWSYlCZO/xrBA6
	4P9coJBZbtLT1XVIOEh4pravIIylhTVt3sH6WPqB4eMDDHMIMDb1ofg/infw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773506932; x=1773593332; bh=kXPDFrm9sQ0HVvpZykADBD6ITf9bKDi66FH
	KYX6PodI=; b=42ZGKznywUhA0Y8QDLPEQ1uiA2/PofCFKe30evrmGJw/GPIQan3
	4l3f52R9w7gxtUByBTFjIUKJSEXqzjFnBQq31GDyvrNbZeQhQTh+UznpXbDS+rVA
	eDJd2eSZVj5ePjvLj0Ork4Sil0cAqUAspS45rlzEsetdRAYgKS05ZK4Ow9ci/6ab
	zcrBrN0KQ7y+dvuj6V2rAbbqDynVXe52kamqhz2cJ4SHae3Ubj5zdpfTl6NYxYQm
	Fo2MrpWps10tvPN+wXQvdoQPLI/hlC76h3tAaLwU4oT3AMJRrKdOpQVkyyS72GDQ
	3odMAMVmUcjWL1eWNSyOTQUdDBPIt7POmJQ==
X-ME-Sender: <xms:c5G1aTKJlfkjNIfxGdFD-dGZG4nPrIVH9it0Bc3dkUZt-2UJMTbgkA>
    <xme:c5G1aeA8M4-ApKRQ4o5PXuDrDCAwgQSh8FJjPsNrVfHikpCtIJm8VmWgrX5aZfaN4
    qzjGFNdBKm5kjEM8J93e-16JNU82c-yHQMxM4sbe_wwkjGUmPlsiA>
X-ME-Received: <xmr:c5G1aUC-FAPOytxMEqZzMEjEf6UVB6tM58dfIGf17wJfDF_zjD6iVHHk6R3fRV4HaSFSBQgUsg9soJKqY1-SvOdIeG7ErQLhKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleeftdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrih
    htohesrhhithhovhhishhiohhnrdgtohhmpdhrtghpthhtohepkhhonhhsthgrnhhtihhn
    sehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvg
    hsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:dJG1aYCrY1uQ2ztxt0GJjM3yGteHsBSCpWXUscQy8JmbyZDL_lS_jw>
    <xmx:dJG1aXrCmsQzAS7XVuHh8XC2xs-Yj9_c3lVc9SSFMrapWiazO0aaAA>
    <xmx:dJG1aanDEtkwlGfEso7o2fewZvgzpjGUO_tglaNxpevFbIuGz_zyxw>
    <xmx:dJG1afxszIwcbMLhp7lnHVGfeRUOIeULhLUoJ6NFJjSOUSdvw73d-g>
    <xmx:dJG1aWblZh68hiuPpj76ivaD7mHd8nRQE3t0HR3mBrz1tjByLmSePFK5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Mar 2026 12:48:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Rito Rhymes" <rito@ritovision.com>
Cc: "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>,  "Johannes
 Schindelin" <Johannes.Schindelin@gmx.de>,  <git@vger.kernel.org>
Subject: Re: GitGitGadget's website is responsive, how about kernel.org?
In-Reply-To: <DH2ADSKXNCXG.2DM7T0NF5NH59@ritovision.com> (Rito Rhymes's
	message of "Sat, 14 Mar 2026 02:20:55 -0400")
References: <fbe96a44-2f97-4310-3e2e-34e5bd02d4a4@gmx.de>
	<20260313-loose-whale-of-speed-ccdbe2@lemur>
	<DH1OK0NDO2D5.1BKGX8J7KWW52@ritovision.com>
	<20260313-adventurous-lemon-unicorn-278ccc@lemur>
	<xmqqtsuj7mcf.fsf@gitster.g>
	<DH2ADSKXNCXG.2DM7T0NF5NH59@ritovision.com>
Date: Sat, 14 Mar 2026 09:48:50 -0700
Message-ID: <xmqqv7eywe4t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Rito Rhymes" <rito@ritovision.com> writes:

> Actually...
>
> now that I've had time to think about it (and get some
> rest), I think it's best to keep the patch series review and
> discussion all in this thread, publicly and transparently.
>
> I initially defaulted to sending it separately to Konstantin directly
> because this is Git's archive, and I wanted to respect convention by
> keeping the thread appropriately scoped. At first, this seemed more like
> just a routing touchpoint.
>
> But seeing as there is no public mailing list for kernel.org's repo
> specifically, and this is basically already a sidecar thread about the
> site theme patch, we might as well consolidate the process here for
> simplicity and transparency. Plus, I imagine the site matters to most
> people in Git, and the mailing list is archived on lore.kernel.org
> anyway...
>
> This will allow anyone to review the code and comment on it.
>
> I'm sending the patch series again directly in this thread, and I
> think we should keep communication contained here (unless someone has
> a better idea).

I would not object discussion here, and I personally do not mind
having to see, and possibly ignore, more patches on this list, but
to those who come here to work with and work on Git, I am reasonably
sure that it will look offtopic to discuss how the k.org website
appears and behaves, and/or how a better version of it would appear
and behave.

I'll leave Konstantin with the final say.  I hope there are better
places, even though I do not now where they are as I do not do
websites.  I've seen folks with accounts at k.org discuss things on
mailing lists that is more limited for kernel.org users.
