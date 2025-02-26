Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DE14689
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740534481; cv=none; b=I1xzdWbWOy/0DQjnyompE4JLJC1t+5oX4eBNXx4ZN4bDd9LlL7cm0wKyzmFXclV5+pCZngwvDDvp22HKMjuqZAYATEIlyd1MIINnflSvDoHjKrY/1+slf2dZdNmBBgYc98TKZq4PUTWQ8POzDY2hL6iPO08Q+R0hOYOqFKKq5NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740534481; c=relaxed/simple;
	bh=0jpDDF1aJYS4WizseconTWwvtQ609S72P78XB3jj5ac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KXnyUEmgs3RuzhfbQDXtgC+tEGtKPQ72xD22X6e0sRfE8Fa2urhL4yrmb0I46d0dAHnHn7GejFftyOyTj6IQZYJrfyvD6Mkswz/mrE/cMgqEvHfpfp7MufeMWb9/DJ/6ZGF4X1bYK6GcrMHgiDardOQEt6NqEDJnPpjALTwfYZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZKK729XI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1rWYUkVA; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZKK729XI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1rWYUkVA"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id BA0F51140153;
	Tue, 25 Feb 2025 20:47:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 25 Feb 2025 20:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740534478; x=1740620878; bh=QJ/dI2O21s
	Mk4iJnUsOAZ46NcY/eN4DURK8/C0f+OXI=; b=ZKK729XIwj2wVjAFFG+/1Hhkyi
	DmKZk17Ynz9Qm7jI+76M5JTUGPIGRAUW6L+F8EEygZLrVknXVm3gT9pqtTAKcqUT
	vtR3XQd76yplXs2wKNyc/Q51AxuOTuPW9GlRV90KJm+jMbb360mhG2FwUdVlGb4B
	lm6fnmwBSkoJ+wD9HPilxwh0ntaqBHDa2h55aP1nPwiUjmEU5JCLxCsKLjBmDxwh
	xaPzgnzBSP6+9gtnfbiCptYjQPwGHSaNqwTXu/ZBsKyBeqy9lsasVXBZNTNAYKa9
	pc/Gs7Ydp43ycmWs2UwabrqsQYZmY+rVsFKI3c+8jlzuQd1ksbLBt65R9Euw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740534478; x=1740620878; bh=QJ/dI2O21sMk4iJnUsOAZ46NcY/eN4DURK8
	/C0f+OXI=; b=1rWYUkVAOR7COjpU2447nvRvOzvrZSqKCPwcWg3En5s6LVAQBK8
	ZSwhQqGAnm6WlEdx3lr344N3tP6nWZa0IG5pl/jdDN9spoKzO8nPfyEa2TaUll+n
	+RNUaHqqgIW8jQldSeoOLZOJaZ1etRcmHMhAWJThrz91sz+pYWgfiO80AFD7am00
	KRtvHIa/PoY1a7jvAO+UrMqOvZ7K7FqYGTAR5QfUfNwfyoGVnNCc9F65ZvK8k7in
	xFL2OmUdNPsnNvT6d0EDJhbTsJYqWTHRQM+6Gv9O5wn6aG1qyh87akGdRuI5JvFY
	eLsgENPH0BLxS4lhaRwQpKB+BgJfEXJWrjg==
X-ME-Sender: <xms:znK-Z-v7JfwZRWgy6LA404E2kZIpaCtKqdwEU8-DstpZlu8KQfv8hA>
    <xme:znK-ZzeBG8t2DIzGl3vxL-9dKPoSyPWglHjx9uYs-5GaQl1vkUpOqe-ibf_r6gkbW
    K5P6Spf7Hrw1cJI9g>
X-ME-Received: <xmr:znK-Z5zG4fhW1hTVvRVfaIIxiK72v0PkqFbOHF4PkYCzic9G5ShlQH9GfyX7XXaM6uEUEtE5NQTUaEAV8KnL3zEKHHD7Ts5CWP38>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekfeefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:znK-Z5MkRXUabWTUqtmUNcABoy-MUlZYqpr0s723jVzoouZABa8bXw>
    <xmx:znK-Z-9oFHtJ7BkrVM6p9XJYn4MGgq3X_23IMdm_7pIah3TUTAPVhw>
    <xmx:znK-ZxUEMj3aij43cQz7SQH3ICJJ73u-UQxwWuBCgyKcdQUL9OEydQ>
    <xmx:znK-Z3cs8GkoOd5ne1oXBbeIalF-YF0POIx-attCOAgTzZy455NZJg>
    <xmx:znK-ZyYzuH4_cWPj8O6PD8b2wzGTFtzJNad7Kbrqk_3pTmbYVGaplyrl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 20:47:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 01/10] loose_object_info(): BUG() on inflating content
 with unknown type
In-Reply-To: <20250225062824.GA1293961@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 25 Feb 2025 01:28:24 -0500")
References: <20250225062518.GA1293854@coredump.intra.peff.net>
	<20250225062824.GA1293961@coredump.intra.peff.net>
Date: Tue, 25 Feb 2025 17:47:56 -0800
Message-ID: <xmqqv7sxh3xv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> It really makes me wonder if this "unknown type" stuff has any value
> at all. You can create an object with any type using "hash-object
> --literally -t". And you can ask about its type and size. But you can
> never retrieve the object content! Nor can you pack it or transfer it,
> since packs use a numeric type field.

Correct.  IIRC, the "--literally" support was mostly for debugging,
and as you noticed, is very much limited because it can only create
funny objects that are loose.  And the debugging was not really about
adding more object types, but was more about "what would our code do
when we see an object that is corrupt whose type we do not recognise".

I personally think the "--literally" should not survive the Git 3.0
boundary.

Thanks.
