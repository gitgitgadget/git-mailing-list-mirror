Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE34E18EFD1
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 06:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762236721; cv=none; b=ms3pepQCKuaboG8Z/YP9JA6UH0YnqIxiEXyRYuzfSqLk1RIralfT2Z3I9eSbQaoS2QbLJZ0BzL4cYu0ZyNfOnSH1i//ay8idsPmWTa8s9u051SjklxevXSNX1rUgQXZLmwALJ7DmS8ak5/LluP5VqfMWYht/gy7hS06hKr2+hXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762236721; c=relaxed/simple;
	bh=/xkXUlpAjOH/gFMiDwMdhTWCHZMG/kOQ2sfGTco/k4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V51WxT3GIU/fptn1zEyv2Drp31k2XIhF87UHY1bp7G7TsOqOKf1b5Cz6x0Xa6zfXn1bhGCq8goYqsi7huC8jrsP2x+yTd2BzvZi+08sRSnM/SbVcKQx1ugo3FBPgOZ7enaEdy8CD/SPAh3CVy4OZtcFHN4iKZRGHo9XVwH59Ww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jpjcN+4m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mF5wrlLb; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jpjcN+4m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mF5wrlLb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE4681400188;
	Tue,  4 Nov 2025 01:11:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 04 Nov 2025 01:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762236717; x=1762323117; bh=bqNP8wUd1M
	GvEIthobDeuCzwLFhcQiJxzoF5hNSWNUI=; b=jpjcN+4m0+Jl0oNWdInv0Aqifo
	kDLiYOvZheyL5KA6k4UxxvZwThWaAlZV1WD8QDPKPR8+OwlBOrYxL6N1KGu6bKTH
	2QLSvT1ifHmx0//as3Vj0m40Mt5+GhUuf5MnoXm+cJKDHZ0IQ9g+0Zu/hJcgtG0J
	EurKJIWIcFtkoBzFt4nZ5OafR9it3HyiW7chto/NOtCj7pTsiN6z0zJajyHolKOp
	43yy3E06sOQMJspsux3IHErm00Xa8rwIl3CjEtuVegv7nThsRgs/t9ap6VmjvHeG
	0t837I6gjnLQ5d0tW23ji6Q99s0BjI5qkJf9xKzQy96XjEVpcJEyJ3elDopQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762236717; x=1762323117; bh=bqNP8wUd1MGvEIthobDeuCzwLFhcQiJxzoF
	5hNSWNUI=; b=mF5wrlLbraLa5WvceziGe0O/Xb9qll5hiW5Qyzumr3wixLqPwGh
	Oq9RiPEwIUtx/VLp468ewj4HV/lMIR6iUZLx5ILaJ3ccb3Z389d9pTiJugS7h6qs
	YSQQWBQXrwJW81JRcfUoKtPXZ6eCUGfmTvniy6KSvrl/tvCP//YsWh7UV8HvO5Iu
	N38IJDoxQGmLQxIGXrNOVxgvMU6zHVxBgPpV8SpHAZmyhw610RLBX9iM3zYFvoXA
	CLw50Lve8rKM/KwToPJVuQKxY08LF3pBozzwMa/TFlFSpyemWf+LVefmLcSxk/Xk
	NyCVQJGTfxzGvpxIqn/xxK7GV4M+fHW5mHg==
X-ME-Sender: <xms:LZkJaeTp-Ts_58Sl99SlJe85zn62D6V8R-p5_9tKQRuGCab8HwpNoQ>
    <xme:LZkJaZwNT0BVCasaAthZVFUhmDZWRt7OhHj4p7GXppMtc1pVKGMyPJItUku0hydMl
    NAWQvafemB_zdw7S1s9CXT1_N90Kd86Zqle1BWtKslLQIRE1wpRixA>
X-ME-Received: <xmr:LZkJaZfp-2-D92UCtp9hAvsvuXoSSbnjpjO_k7WIgpW5mL5gnev1Bvoz8aDRsOx552t3QRjdGDUoj2-PEBA8psJV2zgxNr3VfoECDPTmhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedtvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LZkJaVJoLnNW2bsIClzrqpWEvayLAoCP5Pr4As7B3mMvgTne0IevPA>
    <xmx:LZkJaaGU2u2FqL4fsULveaIHHllWxauFrTxr60klsq_rwFyay8XFrw>
    <xmx:LZkJafrZned7Zf9kVDv-7QfvjrLe97ze8ObzcAb7uoemVECtyjoSWg>
    <xmx:LZkJaTQeGQpF9VFYHSpWKPh2nSsc2O_qaW9bHa5hRyTIbeWkA6_WLA>
    <xmx:LZkJaRq6ndVlLzU8T9OHUzSHeCSlo_oeePsM1qo-XJKUlvCMZUkZg0xn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 01:11:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd8c2fb3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 4 Nov 2025 06:11:55 +0000 (UTC)
Date: Tue, 4 Nov 2025 07:11:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2025, #01; Mon, 3)
Message-ID: <aQmZKCUH-SXjZONV@pks.im>
References: <xmqqseevt4gf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseevt4gf.fsf@gitster.g>

On Mon, Nov 03, 2025 at 09:24:00AM -0800, Junio C Hamano wrote:
> * ps/object-source-loose (2025-10-30) 13 commits
>  - object-file: refactor writing objects via a stream
>  - object-file: rename `write_object_file()`
>  - object-file: refactor freshening of objects
>  - object-file: rename `has_loose_object()`
>  - object-file: read objects via the loose object source
>  - object-file: move loose object map into loose source
>  - object-file: hide internals when we need to reprepare loose sources
>  - object-file: move loose object cache into loose source
>  - object-file: introduce `struct odb_loose_source`
>  - object-file: move `fetch_if_missing`
>  - odb: adjust naming to free object sources
>  - odb: introduce `odb_source_new()`
>  - odb: fix subtle logic to check whether an alternate is usable
> 
>  A part of code paths that deals with loose objects has been cleaned
>  up.
> 
>  Will merge to 'next'?
>  source: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>

This still seems to be using v2, and I've since sent v3 that renames
`struct odb_loose_source` to `struct odb_source_loose`. But that version
should be ready for "next" indeed.

Thanks!

Patrick
