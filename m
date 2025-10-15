Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD3A24A06D
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539554; cv=none; b=Y/edPezz913DLX5SZW00+mhVNryRAWHuWDgHuTG6hhpjTnK6l6UJByRBB+LfEJytj4JCZpCTnU2lWfnmcWm5Q+q7ZU4xHPXk2oU0G9KNCBJitt922zkD3tYbTfBtNgVm/vrpiq1pH08CWcVBywTxL26C4V0EL0qlxXfNTzDKPTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539554; c=relaxed/simple;
	bh=Y88orl6ykj+rrxaRbB7XnegXKgmLb0rqFWPX9sBV+Nk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z0bxM2TIA3ECOy54jbpw7I5i3VLNrk2HhItGS0/lsTWEe056Ba58EBrhyy4lMMU8YrPH3IyC17wrgPYlNazBPC7sJ2ytgLxWIO6ncOR3OKZJmaITYCRnhuCmMLYXJFkf3b3Vnrqew+57pfdmQUw08Vpw0X0qIddAVvKANSxsjsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=URIEQLn8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FkCOsAKT; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="URIEQLn8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FkCOsAKT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D6C3BEC0185;
	Wed, 15 Oct 2025 10:45:50 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 15 Oct 2025 10:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760539550;
	 x=1760625950; bh=ggkzmaGnQ19hi0Y+CACORT1yRYIw4SB/Qj4nIjMnJ6I=; b=
	URIEQLn8Vczwzp6DX733TfzXi2AkoAtoQ2WP24sH2qMh6Kb5LT1uVuMYDRZsuQjT
	O4m3xz0Em8+HMfRqUmvnuKKRNfRq8Hs/nnfbHynn7sVUMsMJwL7JSttmjfiJGMcQ
	r7ToZl9FABs2ZaWraLRd8xvbCDqOHP4omyBQjLViKi2djoJuPypfZctqcCvM1Izq
	nxkJtFBgqEZUcuOSOvamJnof205FXPtt7u15Qu18X08CBvaJn6wpfO8cHSvhB0Z6
	yGA8KkmkFpFB0qHbUcqbmTe9uxOg7MdkQAIYgQGAz2SCeS4Wavvqj2hP06IOfH7r
	xyhTCbylzCJ5xtPK65S3Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760539550; x=
	1760625950; bh=ggkzmaGnQ19hi0Y+CACORT1yRYIw4SB/Qj4nIjMnJ6I=; b=F
	kCOsAKTi+8IJFPrvMrH4j7eDPfNVeuw5rD5tetSr21Ewp8H328J7QjExgwwz9Qnh
	MM0DwXm0DYK/MDmT0+G9RyepK8AXFPQCrM+JffnY7P0G/jTNSKecADy8SuqjAY9d
	dojmVn6dcM0KVlQxvpqNTXmu3hq1je3hXR1/Y3lK7MKix2WCNXi2R1Jx2fqvI7Rw
	n+k7EiZ+PdwHdC9uQ+L752bMHsDz8cNfFERKN9/Y34s87UpqLlkCgrYOuCMkUiJz
	G+QJKKAVKnk5KQEKq511feHvVAbCGOqXW6qFzry5SZqc5WYmeW1uEPInkNccUyzc
	HwXnRdwiE7nAqQv+864rw==
X-ME-Sender: <xms:nbPvaGNgo2Qidu6D35HFvybWFL7-4NdsBv1QqKxeL7nDYeJtHmIIGg>
    <xme:nbPvaPUQot5cInRHEovNuL_zdABvo0VmmjWuF7lxYvRbySSk7pm_3QUVFGsrTFdsk
    tqzo8l_9a8hc6hCMGdApLY7sFIGHcMNW45v50C2UaR-z0sMTun7Lg>
X-ME-Received: <xmr:nbPvaDb23yopXQ5f0aezrjR8bQlqv86Bn8q3edl43LEJQHofOebtt-X3FOu4UqZW13nNEhepQCWdvmtfmJJdjk3KGb3aRjIt9mRU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfeduse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtg
    hpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:nbPvaB19v2HTJ9i1IfCVgUyyhd70tXFRuorJUp1I5MajecUCrq9YcA>
    <xmx:nbPvaHBY17nZyC_NbwUtmrfFFZFUhHosaLnLc7S17XpjLiJnCeuTEg>
    <xmx:nbPvaN-6D3UM6e_tVYfqeYxCivJnXgMlDyiCp4_8q3h83vQRfLMOOQ>
    <xmx:nbPvaCVbDgIUyba315JejJpUn0f1jEJSAGnjtrzszBr9ZMCq1XKWQw>
    <xmx:nrPvaJZEF-xB-9Cx3X9leS8c_7_la6EIKUVnpnaXQ4dCxZLwmpyoe99d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 10:45:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  newren@gmail.com,  ps@pks.im,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH v3 0/3] replay: make atomic ref updates the default
In-Reply-To: <a72a2d7e-06ec-4275-812a-cb1e20902c90@gmail.com> (Siddharth
	Asthana's message of "Wed, 15 Oct 2025 10:27:13 +0530")
References: <20250926230838.35870-1-siddharthasthana31@gmail.com>
	<20251013183311.33329-1-siddharthasthana31@gmail.com>
	<xmqq7bwy1tgy.fsf@gitster.g>
	<a72a2d7e-06ec-4275-812a-cb1e20902c90@gmail.com>
Date: Wed, 15 Oct 2025 07:45:48 -0700
Message-ID: <xmqq7bwww7dv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> Option 1: `replay.refAction` ↔ `--ref-action=(update|print)`
> Option 2: `replay.updateRefs` ↔ `--update-refs=(yes|print)`
>
> I am leaning toward Option 1 because:
> - "ref-action" clearly conveys "what action to take on refs"
> - The config name `replay.refAction` directly mirrors the option
> - It's more obvious what the relationship is
>
> What do you think? I am happy to go with either approach or a
> different naming scheme if you have a preference.

My preference is the refAction, simply because updateRefs sounds to
me like it is asking "do you want me to update refs?  Yes or no?".

But perhaps there were those who supported updateRefs during the
past reviews I wasn't looking at, so I'd like to hear if my thinking
is missing something that were taken into consideration to come up
with that name.

Thanks.


