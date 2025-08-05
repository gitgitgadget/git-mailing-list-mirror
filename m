Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97B9200127
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754418523; cv=none; b=fbwiKBoaM+NmHzEDqTuQUrgT2FwSkhFLE3SdBDuUXtZDhkiByBvZUFO/ao3SPiAH8bQ++0FVfJ+12Of9cisrTtSUWT0QfqguO2teS8JiBA1A8R/um1zTxXgG9lMQozu9Yk1yct26HAz80XhdoKJm/nWWhIo0iy4akS07Isfz/N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754418523; c=relaxed/simple;
	bh=j0Wr400m+CE8hYfIC7viymgXhB1Vwr9UZOZCJKjqa1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jyomVAKqF/+M2xahpDp8gE+VtajUCzWalwVIdOIPKKnAF7S0tLGQfpEC0q1yIZVrv0c+dXajh0EDgn9mYmyIdIdSCYb04dmC7Pwoc766WM/7+boEu6BpqzaYy0IyJax+EOF4XBU+fRyam+LFQmRRMawLfsHBoESE8ptp8f6mvrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b8vCXn+J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F1uMAYfC; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b8vCXn+J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1uMAYfC"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id D5607EC01F1;
	Tue,  5 Aug 2025 14:28:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 05 Aug 2025 14:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754418520;
	 x=1754504920; bh=fgYL4gwTpDqhFGHgPo0+9GLIudGgVOxvh9rhvlRqH2A=; b=
	b8vCXn+Jh0LXerfP65ZA5B79qW6+EyAqv/jtnYzcSiBfzBXeIuvjgBXx3vnQ9cl5
	YiZLzVeqfeaoQPMEd9y0vu0WrplT23OoT7Zrcac/nTNS/PugWRGCXJeuDU5fOcyr
	6VLH88ZrjzsdjZ2M1XhC0SxrNfABdj3NaGVcnMGiyl4vVt8+i5r6qAagLVGItfbg
	mGyVHaNUqt7JgxtrgA2OHgzZjNBvFHWWg58j1VPnLHMOFIPIZ3YftCH2zrKbNaAJ
	1XJOSnYnf4Dd9hVe3a6v2sMfVSI3CJy5wHwMRpFGqwzg22ep8iIVwEbItFpiWZOC
	tlgBhHV/sTrdUdeQwN96TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754418520; x=
	1754504920; bh=fgYL4gwTpDqhFGHgPo0+9GLIudGgVOxvh9rhvlRqH2A=; b=F
	1uMAYfCUa3sCacJW0L1paT8buSdYItlh+1w2Up3sGkT/LlFa/qBhLKpiE9NanqOm
	W5Ksf0BJXRhK3Lyvv67eZU0V4NXgEz61iWGVlZaB2sRv2sYyLSHUmoVzUumXW5lF
	1uWnaCyObVnUsWZiiifEHAgOSXgPCJu1INEfElMflYFHHBGaJI7STtjh/H08g8Xo
	UMjQNoN7I42o4meFkx12OXI5C2WZuRcVeQAnFOsm90xp2HZVOAuJKvW54jOj5dGu
	Jo1kSPDEYohsdmsKaSok/chEuzKx0jMP+xQmdu8T8TdsAdBl/8Jgsm/SEfZCLWtY
	GEcndwN8n18nzoQ/z+6Ew==
X-ME-Sender: <xms:WE2SaC9wMI9KYmwkM3r4bESmTy6ausxovE1_gnqBDWeU7XGgNQaipA>
    <xme:WE2SaNQLqBc3oVLkL2lKgGncAJtUmixikFjNABBkxTilpPQOLublCZ7CQJ-7O4hzI
    9YAxurh4NlCjyCZzg>
X-ME-Received: <xmr:WE2SaEmPvaVBowDL9Luk7KiSxz1aXhfCs7N0O9DxlZ5pLM89gYJAwaqVtJN0tdtLBgcD2p9a4AItLdTGowcLAKdgIYSmn4S41i2z-qc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhi
    lhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WE2SaNTN_vICHRSbxLbgPfk4P-Q2p7wFA3VgPPpREmsojMyUDks97g>
    <xmx:WE2SaCNpcEmBXDsnLdV9RGyUXTqe14g588DljvPtIWlB_QjoRfwD1A>
    <xmx:WE2SaGVJgRG8O-X4eS61sbaWhi9x7OihH51xT0Spw9dmqXFUu82FQw>
    <xmx:WE2SaJfkRfZRbtPrtn0lHqRKZsNue1hnqkin0swERtUFWDZErKO4EA>
    <xmx:WE2SaB7d65-bu8cSdAZ-idxRIUXdL0KMezAL1a1XJvL7cCTfRD8LUVsN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 14:28:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v7 0/3] Introduce git-last-modified(1) command
In-Reply-To: <87tt2lu2rx.fsf@iotcl.com> (Toon Claes's message of "Tue, 05 Aug
	2025 18:55:14 +0200")
References: <20250730175510.987383-1-toon@iotcl.com>
	<20250805093358.1791633-1-toon@iotcl.com> <xmqqjz3h20cs.fsf@gitster.g>
	<87tt2lu2rx.fsf@iotcl.com>
Date: Tue, 05 Aug 2025 11:28:39 -0700
Message-ID: <xmqqikj1zkq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Toon Claes <toon@iotcl.com> writes:

>> I am not sure about the last two, i.e. things that are not dash+option
>> appearing as enumeration labels, though (and Cc'ing Jean-Noël to ask
>> for help).
>
> Well, this gave me a nice opportunity to test Jean-Noël proposed docs
> linter[1].

You'd need to be careful and account for the possibility that a
just-off-the-press linter may not be complete, though ;-)

>     $ make check-docs
>     [snip
>     git-last-modified.adoc:25: '-r::' synopsis style and definition list item not backquoted
>     git-last-modified.adoc:26: '--recursive::' synopsis style and definition list item not backquoted
>     git-last-modified.adoc:30: '-t::' synopsis style and definition list item not backquoted
>     git-last-modified.adoc:31: '--show-trees::' synopsis style and definition list item not backquoted
>
> It seems only dashed options should be backquoted.

My go-to example has been git-commit.adoc where it has things like:

    `--`::
            Do not interpret any more arguments as options.

    `<pathspec>...`::
            When _<pathspec>_ is given on the command line, commit the contents of
            the files that match the pathspec without recording the changes
            already added to the index. The contents of these files are also
            staged for the next commit on top of what have been staged before.
