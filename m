Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC823B0
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 20:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758746913; cv=none; b=Q4H0SQTc924YDWXkFCGs1rhvDqFjP6tLG1o1mJQFN1DYrv50DRqkNS2kiFhXmW4nQSbTJaKiI6HhmpuzqLsMN8oOg2Azjkl9eFeWwAFFMQX2a6iyMr0+IYWQFmt53RWpJUJBu3kghBc0TIjcjvHggyK6hBVhZxTnIc3H/yhhtKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758746913; c=relaxed/simple;
	bh=wrOKCEV1AmfmkZlS9OrgYE7IoJSvhbWTI1xEItOlH2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pXdTEeQV3uCGTzV2rQbxxWqYd45AN/c2GyTYF36FFa1dCyujgXr/o65TaYRgXgx+aFyaoQXmD7MapADW9cvHbgYiK4HSQ7PTjPQdWTQuhEnp4TAjOUof9iU0JDvCQTrLb0WqJJijQ+gy5VUBXk7H6M9q0hyI72fxGRCRvS75f9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y9zRaEne; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gUzl0ofE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y9zRaEne";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gUzl0ofE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 219C9EC0198;
	Wed, 24 Sep 2025 16:48:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 24 Sep 2025 16:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758746910; x=1758833310; bh=SGjJ2rTY0v
	CCjGndFCCVSzPdbIU1mLdJWzA6EPhSPDM=; b=Y9zRaEneJnZT8NKJnwjr4XDzQP
	UGgCZHP+avFAvetIpd2b+WzuJr1ruM9gmJbrTOf6IiIGDXv7LqCfRQmhnNi+1jnL
	KARBFcif1o+9EmaGKn48c5FSN8YglfIH+L5H9KD6x1zi9IBZ7YJaXze4BZI6y9ur
	X31GXpWQkk0xqjXKC/30LwLgf16QOyQYh5U2A1igPVTOo35/UojsqMylc74YTlpv
	cajTS3OnmzbD2dJJExqdOqAeO2eqWtm4TjHINFIyDEDNLlqx2LuwBNxtT3REmM8w
	doKxaMtHQMmfzsk58R+FEa1G3UjSdmS2VeOw9gWb9Ts9Q1gqKFPIFF+SKvOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758746910; x=1758833310; bh=SGjJ2rTY0vCCjGndFCCVSzPdbIU1mLdJWzA
	6EPhSPDM=; b=gUzl0ofEDVfNu/lyNoeS9mxD06itGvMM4E27rM3LOFagEqbC/RI
	j0H2lO18sFKvMmuaUhlRYOia4qc0qFGffwFJL/GkWbxspoQRiIQ0sqll0jYzCjqX
	ZA4KLImO9EzgDe+IeqIddzMH3QrRlRG+gTsUo/NXb7z9snEP9DfBk4i+nhRdSozX
	Myej7oVAZdMMQsqU8lmVSHjMcIDv97elFSMWW1PHi4FDAxqxdlc5YeDJo4/WKKkZ
	HCdstNyYKIcQzGBWhZ7UabaL+IgNunYp8cB8wAbFxB/LINWVDUR6npj32UOt9k3M
	hTA6H5zitd7dd3WarGUC1ZWyQd7CWE/EZkQ==
X-ME-Sender: <xms:HVnUaNeKpOa7IEfgZ71Rp4agJyfVzTzy_WIA01cSX1W1QrwD60KJeQ>
    <xme:HVnUaEKh_Hx7HGheGZRvdMktWcUod9_3wS0ixb2iQ4ByZs54_4i2v3ST5_vQMdW3g
    Y0y__5lBSzldCDh5ZBhpqCApOAe34oLXzHJEhO8lsLK9QjASIYAXQ>
X-ME-Received: <xmr:HVnUaCE9g2tO0x4JTbay9copVfMpV9MagWyydHalKgi30_fL15DneoHf8ZXnfyWjZqalZANsc2YaeIDdvWMrSlZhLi7KebnTboOZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeigeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepohhsfi
    grlhgurdgsuhguuggvnhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehmsehgihht
    rdhsthhrohhvrgdrughkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhu
    khdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HVnUaHDuqZ8JzV7cXfJRNVCayGle0MY-9eGN4W5uF2vPgqylDPRXug>
    <xmx:HVnUaF-Alt9hhCmg4lFrjO-SfuMmpbk5u2NGw8s1GE7lBQoN8MDhUg>
    <xmx:HVnUaDBy6wdwxaYswhsSk1oiakukoJjJ9wxBsLvpXhDAYTyWaTcPSw>
    <xmx:HVnUaKSNjDLULzJ2B3aFRi3swTK0XIAJAmkroMWFWqGAK3zH9wV3xA>
    <xmx:HlnUaDf3WjvLepxDRZV3alIlbI2xjEVfHBCgkD3wqx8un1NhfwOpMb-0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 16:48:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Mathias Rav <m@git.strova.dk>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: use same commit's message and date with f -C
In-Reply-To: <aNQiRFbBysXXAPDR@ugly.lan> (Oswald Buddenhagen's message of
	"Wed, 24 Sep 2025 18:54:28 +0200")
References: <92d4d585-09e9-4f1d-a471-1ad6b312fa61@app.fastmail.com>
	<aNQiRFbBysXXAPDR@ugly.lan>
Date: Wed, 24 Sep 2025 13:48:27 -0700
Message-ID: <xmqqms6jk25g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Tue, Sep 23, 2025 at 10:55:02AM +0200, Mathias Rav wrote:
>>Change the behavior so that fixup with -C takes both message and author
>>from the current commit, instead of taking the author from the previous.
>>
> related thread: https://lore.kernel.org/git/YjXRM5HiRizZ035p@ugly/T/#u

Thanks.  That's a great pointer that shows everybody involved in
this round has pretty much held the same position over the years
;-).
