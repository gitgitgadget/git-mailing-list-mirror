Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F21C273F9
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756147695; cv=none; b=CN/SNdBkDntNcBOegt1eGB1BgZOldyQusShb141TKj0vIe1EidIq9mSRAdxMn/KD9ZNx4CoKqdt6h9jLmcrMYLHtLIyD4O2R8/3ZD7bW+XDDiqmuADqvVaTla+OLdve7TBGhsRifJxmxMEcpa/P8pkIRgwIFgyQnOd4t38nHIOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756147695; c=relaxed/simple;
	bh=6r6gHABMTi/Q6+K0nRnUCcyFS+enXBWvE0Cxuxo5Q94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TMTlH/XbI+seEN7xNNrHhuGsmmBdM+noNgO9CjIjDJMifCDBK8D8tqSwQZ8LTYuvdJLfFOoW/xjvUi2EO0TnA7CV41In449rsxw2vDTKQhNRzggPMLkoMF3jXi0BSmEwoC3rq012A6074934sdoD1FeQEBFRYo1neyuehCQjgS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HLtf1y2K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k5DBPNEv; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HLtf1y2K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k5DBPNEv"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 519ECEC0390;
	Mon, 25 Aug 2025 14:48:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 25 Aug 2025 14:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756147692; x=1756234092; bh=RiSOm7RNPC
	/pQV0S7EdBj0YTqFfahlCbXYVCkTITknU=; b=HLtf1y2KJRjFWOs75EZHtWg2IS
	lPmbwapwQs9SU7AZwxeE+cU2qqLp0dwXzS18WmT/Zki0YuxlZTv5ztBXCvIWfaZF
	L+0k5SYVQ+uNUTSSebk9gj9AZ9oHz7fPOWCNG7+vt7P55nPjSY20rbdO4WHaNlHu
	4GaoiVUz1BP75IzziMfnglCl1fgSw2j2WtTC3piDsMvPGXBdhi/4WSrig0clotGp
	/d9sXlgAfjRLqY7G6OZm2V6O6rxiAdW2YOYICId3rtRAg0sNMzxyPoPtEJ1kDB2C
	uUzvCMYTDBW57pvUPNXufbB4zXhmqyk6nK9shukkw3OIsU0MVdA72d1hOT8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756147692; x=1756234092; bh=RiSOm7RNPC/pQV0S7EdBj0YTqFfahlCbXYV
	CkTITknU=; b=k5DBPNEvHuA1deV2R7PEZVTL+SUSNzsy8kW1MccCxZ5w5z/6Z/f
	zftc+TakJ4bsTXss8tVQooDhBS2uKlOksnvXw55WNnm782fmniG3TF7aE55hMZmL
	n868HqFDB9Qp+wKllouThc3+P0HlqAA6Fzl6PCTsqnGZLKMn/AbHhw1FnbljUe+D
	8K3w8e/CqCtraw7pIauSATud+vMkNQNej2oszMw27Pb4IJTByibOYvxdR40qTUxg
	4r6J43X+pJChb3V41Oo7vaTVaqD9Qd4jPMP5yYhAzmyptZ1v0zQve3ITgSbpR7gb
	CgaTvdcNbi18LnrBlgjcwyD4LFDkbHhGrcg==
X-ME-Sender: <xms:66-saNxffc36jpSp2akRaYlvPPcRJaNOqY8pwOMAYnW2KlF-96fp_A>
    <xme:66-saH2GO7eFAEHKRAiYnZhcPLYLpHxgWt6uisojVkN7rwJw0zUMVn1jBG2Crn3-q
    cghH5xJKbr6-4B6Pw>
X-ME-Received: <xmr:66-saD6fiLklow82iL5q9yNxhekjiBnPowFKK9KkPI3eaBRk8D2mHjw3zFR9N2UFwoqAMjgukU9FFTDP8aSsSc0Jvn31b6Pm-GumFVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:66-saCW3pvzmI3fLy_y4JDYwV7rOiI2GFdBj9fI2v2YS_haqhbS6rg>
    <xmx:66-saKCGOZbpHRxl2Nj2ISSva_i09MJchmpvWa_hKdmFsQGJiLRBgA>
    <xmx:66-saJ4l3QgT8CfY9_yea71vu7a4Jb9SGPed9VAuPf3tcj_n9nHFZg>
    <xmx:66-saNzeyUJRVtBYg9PylxZb1Xb6caPWVgvbSql58SvwdoQb1olBTQ>
    <xmx:7K-saOjh2tgRcf8oUFtMa1kx3a7hLhRgATj3tirztPNIQT6AiVZnTJmU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 14:48:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH] describe: use khash in finish_depth_computation()
In-Reply-To: <20250825081345.GA352784@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 25 Aug 2025 04:13:45 -0400")
References: <9110f085-aec0-42e9-9774-b153ece6284f@web.de>
	<20250824103117.GA250458@coredump.intra.peff.net>
	<6402268d-bc80-4bfe-abb8-edec9e1b8417@web.de>
	<20250825073403.GA332447@coredump.intra.peff.net>
	<20250825081345.GA352784@coredump.intra.peff.net>
Date: Mon, 25 Aug 2025 11:48:09 -0700
Message-ID: <xmqqcy8jqlue.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> So out of curiosity I tried replacing a slab that should be pretty
> densely filled, using a khash based on oidhash/ptr along with some
> quality-of-life wrappers.  Patch is below.
>
> It performs...very badly. Not sure if I've screwed something up, but
> it's about 7x slower to run "git rev-list --author-date-order HEAD" in
> the kernel. So maybe slabs really are worth it overall.

Hmph.  It is the best case scenario for the slab code, as you'd need
author date for each and every commit object in this use case, and
the comparison function called by prio-queue would be called for the
same object many times.

But the hash function being oidhash(), I am a bit surprised.  It
shouldn't be so much more expensive to peek at the first 4 bytes and
then do the usual hashtable thing than looking at the in-object
commit->index.  Is it a sign that the range of oidhash() is a bit
too small for a real workload?

Nah, 4 byte unsigned integer should be sufficient for the number of
objects in the kernel.

