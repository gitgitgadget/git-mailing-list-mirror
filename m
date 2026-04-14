Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A55217723
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 13:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174024; cv=none; b=IodI45kJZogA3URAAIusp+c5f8gAc4rQW1tWoyO9j1Ox2GYAW18l8Nv1530OvQYIqWmFzQZlssioZ3SOWTHzv84FCJj+TfVStadycIbekdxIiocH3wkyYVknn296OHt9rSPePNQgKx+Wa7eS/c96LsMKdo8fUgPcWQAd/n7mbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174024; c=relaxed/simple;
	bh=X9rZOwCvquwqudoWmJwd1WuJyprmgFCIvxt+pUjDUSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dRYhfaOxArZHGDAbsHRaNFRZ0BxDiN5hxwn52+Wl5Yy0Gg+vA/T85LBuYrjOzxrIqWKJqQZLFCwR4aHk+K9lrFTcfX7g8Qs3f0i272EnIJe7ECvyNIliHMTCnpwLojMxz+8hJp+dVI9keH+oTxBNKV15MRwLZBI9lM8n8B/XxC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g4c6tQWC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nyEX2r6S; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g4c6tQWC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nyEX2r6S"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 19AD71D00090;
	Tue, 14 Apr 2026 09:40:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 14 Apr 2026 09:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776174021; x=1776260421; bh=yGfx3lXBc2
	3gluC5+Mi4tbe4zKpHF3YFyJyQwIxpYqQ=; b=g4c6tQWCFqqHO0nUu6+NHsY0Mw
	kE8pZPsjZLYONE1AhCekYS3sp+l/K+/wOb92RApazsGopeIfcbNk2Q6C+6L9Xq2v
	Zmgi4isvEYqTjwUqbmWZWfFL4fh0gZQNrSYg0gecYobqj53uJcihmGBIxce+zHP/
	GbdCIDvxTCrZClhJ+rEozA8YQZqQvmwwD+O0RWkHt5dZLyujEc7R60vfKLQdOox/
	9//2TkjKWB6/OPG0pxzI4peYmlNc+xN9bFTW5P5k+hr+ftZmo/bVD2QISlwe5I3J
	b0nwk9YxgFplTEUnYpuIVS3fQHtiQokc6gZ8JR/R/JW9nRsi9/MdSVxYLSuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776174021; x=1776260421; bh=yGfx3lXBc23gluC5+Mi4tbe4zKpHF3YFyJy
	QwIxpYqQ=; b=nyEX2r6S+kApyThT31pxFM54GmII275uJIbhBY0rsLehNImp55R
	kOVRSFKiDKHCO70h91+YaQH/0v+0wMJBrTyyDqMAqnRnFVCXUwvG6Tlg0C/3+dr2
	7qUTj19v5uN/EA3TJAlBP8TvTio52XkL02v5BLdyXGskxg2g0mnqvIyWqhJAGleh
	43QATcUgdC0GKw2I+t/SspjeH/+gOerk9e55bpy1QDZnN4lA+9/hYEt7kWQ+5Bvo
	k+D8pVHQqzA+L1GOmtHdOcBLIQkaZNq4Ko25oml0YY4uFXw317PQexIdJ/jKuOrp
	Ye5hqyh1TOw/nqrqDG0qBHmHC+z95GEpWTw==
X-ME-Sender: <xms:xUPeaWSpojMzVq8mV2LXEvzbMZwglo6LO8grl8nkmYET3jLcp28HLQ>
    <xme:xUPeaTPvc7L-xtfB4mOHuxn4P5Sd5uLPRcqDq91b-4e8KwzUFZ1bnRN6JB4v679d0
    zNYoRjwUA_DxwfAUisesSoOWbT0AV8KSMtDOl5FgqD9wYx6V-Q1>
X-ME-Received: <xmr:xUPeaROzxhUFdu4VSBAj1evDX_N8tHJtbhhKxenU3DCTs8vctgl_k-_3xvz5TwVaGEqPdkYaDwdCDqIkv8VBZYlQB8LFun046w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:xUPeabvUy0I1Q7LAUvH-nqMLrfH_T52aCN6clmTlbgIIjdMpIPnpAw>
    <xmx:xUPeaTURr0LXK6Wrz3QPF8b4_wECL2T4hv_uQnU7kuDidxs_AlColw>
    <xmx:xUPeabtybYts8Zme3EhC05tePrp4da2f7Ab50pvbt7SGBsNRu5qo8g>
    <xmx:xUPeaXXl5A6XjhiQIcw7aUzyqmYF6N3UhAQNZfuIt6K_bD1b8O6q2A>
    <xmx:xUPeabXyjU8-yvDcsjHRDFVaIZcNSk8IIQazVO0utDZAKHmJ2CzWrQBp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 09:40:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/12] t: prepare execution of potentially failing
 commands for `set -e`
In-Reply-To: <ad3rgbgadjIZRgaz@pks.im> (Patrick Steinhardt's message of "Tue,
	14 Apr 2026 09:23:45 +0200")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
	<xmqqeckifq59.fsf@gitster.g> <xmqq340yfivf.fsf@gitster.g>
	<ad3rgbgadjIZRgaz@pks.im>
Date: Tue, 14 Apr 2026 06:40:19 -0700
Message-ID: <xmqqik9tek3g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> ...
> Anyway, looking at the failing test t9501, I assume that Perl isn't able
> to enable the DATE_PARSER prerequisite. So something like the below
> patch might hopefully fix it.

Ahhhh.  This is exactly the kind of test breakage we _were_ hoping
to find and fix with "set -e" series.  It has been happily failing
to set DATE_PARSER on macOS, but now with "set -e", it is unhappy.

Thanks.
