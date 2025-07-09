Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F71D2DAFD2
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068183; cv=none; b=Bh5895l2F2lamUuQJFRWHZ9hxaY4WpLn//8BS0zWF9t9ITGtkPAOuVbO7uymNW3TEhskSb4d0+3kxtsDtEcPzQ5cUFGCTbNgqeKdaSOOtvlMYag20YiXzhkNpiOKolI8l/u90Da4IQyz3Ct3xivbosAOGSo4jMWChLj6AkHPgIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068183; c=relaxed/simple;
	bh=+LExDh8AmS7uRcnFKyEnaqin4nexJHxkvfP1GwIGV0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ng/ypfmJJM720lW/X5KaUZEQEz94P0cnhIBxBri1tOjzw2/8KshIjNANd3EybwfUALdfDR3jUxi9UtmN2OqIPsV9jrtJMRHQGGS+bGTNV0zXLYpnSK7kDNkXaHUSDga+4RmCz6AO9sL8Mmlxfdx47gSG4MK+Iwv0sY1pW4Qdo3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TJrwBC6M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B3OyNFZ4; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TJrwBC6M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B3OyNFZ4"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 766BE1400332;
	Wed,  9 Jul 2025 09:36:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 09:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752068180;
	 x=1752154580; bh=9VigSL+sQzR/Sm4AIf+mPNYXsxeQDrztz2fR8yh86/s=; b=
	TJrwBC6ME31Tfb6rV7JgTojyjwI9GwL9MhRkaIXqK958JiOt00gFIAjBla80tL1R
	Htx1d+ilWw0yj9W9n34XD449moYMUnB7LD/TCwWxxRLExPSzHbQy7TaqUa742+DJ
	nZQl4dQ7ZMin4AFWBI286TWPpKWVFzHPSSmSpRPMCTMWTIDQs39WvbgrhXGcW9Ng
	pO4RmBYXHEPlpuYumVXzJivm3mZqibOydGnaJ3fXdnDygCMa7o8C1UC2eAcfAo6f
	m3AuZNNB9qzGejLfTKPVhOdeHio6CzIF8bAmbH/jGxKrPoUMuTZxVOslDm+0UT+h
	WeGGzna6+yfFToPuJ9h21g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752068180; x=
	1752154580; bh=9VigSL+sQzR/Sm4AIf+mPNYXsxeQDrztz2fR8yh86/s=; b=B
	3OyNFZ4fUn3im1xHBCyDR3r5VCyYz/h4VBI8QwxTeLP6xVy8TWV+YbrHgZLvCT5o
	dGOXwSD+woJW/3KyVlK2IsG7v+3zo1xRl39SoQKWouKfeZvQlszN/NECYwW5JyYs
	xCgpKTAvUzEQAhPQbJ0M+dsItPVB+rGqyZhksX74bSavQ+Kmn57FszqDOMLQ4BNS
	vdIK0hJq//5GHRF5w2/MbqSHaZS4VORhQ89SCrIBpKI5+PTBNfKanZTM4AlaM2KG
	ipNFQSqdW0wnPZFu0y/k+iCNOulouUOky+Et0uEfSocKmFZp0Zl7fNLxIF0G/3YV
	aAkwpS9c8I7cYv3vqX2QA==
X-ME-Sender: <xms:VHBuaIB9QiTSazJolG0VeXuCqmfcInHwtKJ6N4jSSupbf6pfT6RmcA>
    <xme:VHBuaGACI4J2tXpRBjrmf7tWu2cCYY3lLxCJlO8pCWNVt0cmoeOK5KTabGwjujzda
    Stp6K1JCnO7298SHA>
X-ME-Received: <xmr:VHBuaCBtK9OAtYH6fOH8zIfMedFBh7OFiz9L-BdWr8xMJDcjERJeKRuM40DYpbxTblflO8OxIDjEgdP89boUXq7WYUyOfl7UfSA394ii10lBGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VHBuaJrzHXx48pLcfU5i9k0HHqnZV7HLi-oFysqprFGECtqHT-uk6w>
    <xmx:VHBuaElukePH5Y3jY5AE1wSPoNNwRlkFFFLof4CM2QHr4MWwTYeqJQ>
    <xmx:VHBuaBzTht1oKxHWrXn1jCmAeaLtV8wfJ2fI7pVMf3CSkWTpR9xwhQ>
    <xmx:VHBuaE9MVFEViWafQBSgFbmnVe6JVFy-bZEvfbX1oNYyGx2qgwthyA>
    <xmx:VHBuaAQ-Ru5kzfMclDyz49F0mv1R6GmEdR4otahB-7GaCwvucQZVzK_p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 09:36:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aac442fc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 9 Jul 2025 13:36:17 +0000 (UTC)
Date: Wed, 9 Jul 2025 15:36:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org,
	shejialuo@gmail.com, karthik.188@gmail.com
Subject: Re: [GSoC][RFC PATCH 0/2] Add refs list subcommand
Message-ID: <aG5wSB_ce5Z0BCJc@pks.im>
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
 <xmqqh60183ku.fsf@gitster.g>
 <CAPhwyn01spdT-hFxVPcr4cnwBJ=YL3Ty-johXvGKXKRdCTpHXg@mail.gmail.com>
 <xmqqldp9m1mr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqldp9m1mr.fsf@gitster.g>

On Mon, Jun 30, 2025 at 01:10:36PM -0700, Junio C Hamano wrote:
> Meet Soni <meetsoni3017@gmail.com> writes:
> 
> > To clarify, I don't have specific options or improvements in mind right now.
> > The idea behind mentioning them was to acknowledge that having a consolidated
> > interface like git refs might open the door to such discussions.
> 
> One complaint we heard a lot about Git in the past (I do not know if
> people got used to and learned to live with, or they are still
> complaining about the same these days) was that there were always
> multiple ways to do related things slightly differently.
> 
> The machinery of for-each-ref is shared by branch and tag to give
> them feature-parity.  Adding yet another command that behaves
> slightly differently, with the intention to make it diverge even
> more in the future, feels going backwards.

That's fair. I do think that the common infrastructure should be shared
indeed, and that includes the options. So the most important benefit of
the new subcommand would be an improvement to discoverability.

But there is one default in git-for-each-ref(1) that has been biting us
multiple times at GitLab already, namely the default format. In
git-for-each-ref(1) it is:

    %(objectname) %(objecttype)\t%(refname)

The problem with this format is `%(objecttype)` -- it requires us to not
only read refs from the reference database, but also resolve the object
via the ODB so that we can figure out its type. And that can be a huge
slowdown in large repositories. Take e.g. the Chromium repository:

    Benchmark 1: git for-each-ref
      Time (mean ± σ):     148.9 ms ±   1.0 ms    [User: 80.7 ms, System: 67.2 ms]
      Range (min … max):   147.2 ms … 154.2 ms    100 runs

    Benchmark 2: git for-each-ref --format="%(objectname) %(refname)"
      Time (mean ± σ):      22.4 ms ±   0.3 ms    [User: 21.4 ms, System: 1.0 ms]
      Range (min … max):    22.0 ms …  24.0 ms    100 runs

    Summary
      git for-each-ref --format="%(objectname) %(refname)" ran
        6.65 ± 0.09 times faster than git for-each-ref

So from my point of view, this is a thing we should consider changing in
the new subcommand. For all the other options I agree, we should have
common infra and thus common options.

Patrick
