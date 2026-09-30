Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FABA4DD3A8
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774939; cv=none; b=Ue+ULNxvsPrGs083LVXy3dsNcU+D4uFOi0vIbKcwND8uL+89dxgxzC8KfdouVlEhz47EBN0NCxowNPmCN4eKUMcG3NQnKGUsrzQ5MqcFkijNlvJSRhpbRxY2hDi8oZQwZmjUGAwLXhs0XaU3xz1TKplh/R3SDI76jozKd8eCnOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774939; c=relaxed/simple;
	bh=T5CY/gfEN3XLmaqitk6xwUI5BlSs1UqelgbEyrdxrEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BE+ti99/hlDmibYjQfjYoK+wTRJlqrWJn6JO5HiloApggdHew5zK35YnyipE/Pqqn1zbiKdd5W7vwy4VdXQczoJy21FZWJHlaJ4RM0npwZw7CA9Uv+1zgqnFp8nq3UaGr4/S2HYs081/82mNYKmAC0apGf5QHmqprHBwUvN9iws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CG6RPAib; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=McgXZkp+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CG6RPAib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="McgXZkp+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0716314001E6;
	Wed, 30 Sep 2026 09:28:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 30 Sep 2026 09:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790774927;
	 x=1790861327; bh=zFhnYas0aF6B5x3pqMLqvktvLNrF0BJTiqcOQ5HCc8w=; b=
	CG6RPAibz1g8CtXE+7sH++vTdnj9U60o8LhRZ1rORl1WQVfek+L87soFmPt4EnPx
	ADHDzIjoeoCp9EpzQDfLevUJ4hfVB1bvg4OPFWozQd+hbAkHh8Qa/xYm4Ocje+zK
	Na2X0jnnXbUpkl3DuSl4UhjpvvM5EEns7KOL35TUWsEJ+7GyPbxPymfDQkElQT4h
	CmWKxpMIHeHo+onlI8TomMo1EMgIp9sYqZ0zIQJnoUUz0eCO18gJQIOe5A8H97Yr
	incaRiTRHnk6w5WZwf4NIsWEX0AY2NYTMFhf0onzn4hEsl4NJubUYDuAcBzj2DJZ
	emJ1YJqRfzY40nyCanBleA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790774927; x=
	1790861327; bh=zFhnYas0aF6B5x3pqMLqvktvLNrF0BJTiqcOQ5HCc8w=; b=M
	cgXZkp+Dw+B+0WVvlNPOfQcC8x+RPn1ufsPQINTT5lrRk8NqnkvSxq6azTqkxqvD
	y2KR3GVO8Y8a6SzKRc4kTfEr8z3iIVZPnZr7PuLuHnsJ4MHYC4sQHhEi9f6765K7
	iWpfescuVbPwX3GcdQvqmNfES+tfLW/RdEJj8d06LxvmKIuP+aGL++YMk36RWjPi
	n4BhyDgtekYV4Xm3QiB7tmRksfYRAdzhycYpl9n1Drwa0e6tNfG580BxPbuHRg7u
	oolPUEEmhz6TS3klSQb+snhsnZ3vefC5rpw25AA1EEMABQypTKBSNE15n6/LYEmd
	6tloNeY9PmK7nHpsTFdHA==
X-ME-Sender: <xms:jg69asKpmW3YgENyJztRTsgrr6ZDq5pvWVNFhkQ1CO6ProYlO7vPYQ>
    <xme:jg69ajmLmyWnUGnM77Ku9LrUlQVaU0v6D406qrrhEGaP73zg62473b_bWZe2oGGXS
    nrLLcmYT-Nde0K8YYqXUkU9kK1592MMSgXmIDnq6mNWA1KRa1oGAM71>
X-ME-Received: <xmr:jg69aqGFWb3wluctZQjvbckuMTQDz414Eb0q2gw995BjUEtoKC7LDw>
X-ME-Proxy-Cause: dmFkZTGp5A0DD1YimtD0UCFfzBkHuldYYoGAAib8EW95GVt2TFuYJGw00zWvnGARDqd2FP
    brBoQyfyEgQZ7vWcHELyvJXPfxvC1X4Mna5D2eHHJ82u64tvbmnp1dPiBaEMenqq89DGti
    egUdS5+dWKa7TlIQ7EJEWJuy76EZMaPf6AlOYVo43K8zggk7ZR4taE/LK+sbLddmL0wivb
    Qy838yosIOW69PU4h3qtqleOQXhPUA4Y7yAgJjq0paV6WUbBLl/Lks9kBiTwu9M2GkF7o7
    Ko/L4ylEI33vo9COKgamAObNifjfp9teV9Ng91bTOkgu/Su9dojGyftMGulI8kczykwgHW
    +rQWgJoAA+qR3a1xAtNMtDAV83n3CwvvMwBiMnTGaHCRYUWsWnF+z8TtWdeC5znqsTrNZd
    e8+ZnCSIXQG5GjWgQtmHiEq6t40PYL/X4FlzmR6Cp0IvUGJs29qZg3zE7XOdTIR6TFnYIn
    mZfGheE2s1PJ5d1/fOSQvWverOrtb4FK9P9XqSZxoG3g7NcAmAh3Fl5tsAhPraryzS6Qxn
    t8jZsAWOGH6dVsnnFUazGbW+CpLrIf9Y7Jm8HClHUZaKNLy2gsTkL7B6kkt+ph0GwU5c5H
    rNFqO8dNs7xaxvjjQ2CpBxXFWBJOzGjl4Bx6LJv+R94XnbCzDtPcdg3sB1/w
X-ME-Proxy: <xmx:jg69ajEPY8RloJyoxheoE-z8rFfVAzjY1KYrbByrmNCCUH-nqL6kSw>
    <xmx:jg69anP5YIezlcFoiGcVknUpT-ibtV3ikiT7uPY-HGoAiZcRx11_Mw>
    <xmx:jg69aiEJ_X5Gvc1gnLX6t-WizBhqbcXoMQGh-4Z-4Ir2tE3iPs7uAw>
    <xmx:jg69auOSL97cc8SrDiBq2mnD9x3b9--klk-zRuJl2l1ceT8vXymPgg>
    <xmx:jw69arsJQpxNuGHNn4VBaCVqzvVPssRAbyEX0M7g6ha8_O2Y4XAWb1Wc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 09:28:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 55a3309e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 13:28:44 +0000 (UTC)
Date: Wed, 30 Sep 2026 15:28:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [RFC PATCH 1/4] doc: transform breaking changes doc to a manpage
Message-ID: <ar0OicAaDipYx-xU@pks.im>
References: <CV_gitbrchanges7_please.d1c@m5gid.xyz>
 <gitbrchanges7_please.d1d@m5gid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gitbrchanges7_please.d1d@m5gid.xyz>

On Mon, Sep 28, 2026 at 12:41:25PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> The breaking changes document is not a regular Git documentation page.
> That means that you cannot navigate to the doc with git(1), i.e. with:
> 
>     git help BreakingChanges
> 
> You instead have to download the Git project source. Or go to
> git-scm.com.[1] Then you get this disclaimer:[2]
> 
>     This information is specific to the Git project
> 
>     Please note that this information is only relevant to you if you
>     plan on contributing to the Git project itself. It is in no shape or
>     form required reading for regular Git users.
> 
> But this document is relevant to *all* Git users. Everyone should have
> as easy access to it as the other doc and guide pages.

Yeah, I agree with that sentiment. The one interesting question about it
is of course what we'll do with the document once Git 3.0 is out. Will
we retain it? Will we remove it? Will we empty it and make it focus on
Git 4.0?

I guess once it's a manpage we should definitely retain its contents for
a while longer. The breaking changes will be relevant to users even
after they've already upgraded to Git 3.0. But if so, we should probably
introduce a new section for Git 4.0, at least if we already want to
start thinking about that.

  NB: even if we start thinking about it I think we should probably not
  release it anytime soon. I guess having a major release once per
  decade may be good enough.

> To that end, let’s move the text to a manpage. But keep the old page,
> just linking to the new one. (We wouldn’t want to break any readers.)
> 
> Just do the minimal changes for the new format. Also demote the first
> section to the second level, i.e. make “Introduction” the same level
> as “Procedure’.

I feel like a good first step could've been to convert the
BreakingChanges.adoc document in-place to use the new format. Like that,
it would've become way easier to see what's actually changing. The
rename could've then been a 1:1 move.

Patrick
