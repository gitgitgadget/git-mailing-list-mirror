Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327FD1A2398
	for <git@vger.kernel.org>; Wed, 29 Jan 2025 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738194532; cv=none; b=fZv8YIlFFjuDGSNQwzYZOQXA331znTta4jbMIvcawlti/zbRrlhzMuBcAV2AkzYie44NzJK5IC2RJYxhh+ZFxK3HGGiW6GVnmtGfZg84lVO7IKOs3a7ctKE+j+opp8DPbgaHL2K4qFSk+rpWjaK3c6Wqu/+4emjDpYlvTfKRK+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738194532; c=relaxed/simple;
	bh=6xgq03FCbVoaVwazT1xpm+pb1wHjpFCEELAzjnXMW6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dJTgiEbeGzjfZySUO4bUhVba2TBZiD09Ty79AS2w8PrCNu9TOZa/wULHbHCSCMpdaksfPeB3nbPpV7SU4wiF299Ct4pfqOGz4TZIKOmyKkc1Kwh24/hNt5HmBHa4lgc4PpLn6RfyIzKQTPRwVdIlwtPGJnvWJNDXtKze1hr2ypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IetMUBpZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VbEm5/vS; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IetMUBpZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VbEm5/vS"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 38ACA114014E;
	Wed, 29 Jan 2025 18:48:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 29 Jan 2025 18:48:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738194530; x=1738280930; bh=eLhNu5Ffv8
	HiUwwF2XP0ket4bPsq23sx4Xuo1hUzhoo=; b=IetMUBpZCq5JyowNZTz7fkCqCT
	D4b8V+ijLQQe0x5e9arhyO9D+/RgmmvvMB5u+qe2k/lfD0U39k9wwNkJMwY2LYw7
	DLrSe1gusUWfl5ioE4KQpLQ3gc6siZJWf1QRKIz1iMtRCnw1CPgOE8qVN/S3C+/N
	Tcojqq/rNbqNKRzz/m1Vr0XlWP+Yl+QWCzLlYRqI2tOfhF87mqu+32okHfa4SdwW
	57AhM0Mq2R2z471OBxtaFVWCtY3+nSxPSOCUPEBkPddyWvFEww1Ng2PTV0Fc1KBo
	fhXFRE7yyxe23Nk9xtoe4SEL4h5iEGnsKz5qmcbop9OTb48D0Ayplp1CLNdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738194530; x=1738280930; bh=eLhNu5Ffv8HiUwwF2XP0ket4bPsq23sx4Xu
	o1hUzhoo=; b=VbEm5/vSvQqekagdc6qNfgJRIlghzGSi2RSeE1Jec4vU/cAY6i2
	hqg+pmc0ANrxqhYLIev/pZ6soDImIU7qisFwvstQhOnmK0tCuZEpMza89Emuv12/
	uXOc0xIMjBLxo80LlppQc6kCNGmKEtvy//gXZJMH4RX0wMRLcTfpN1AxYvrBCmd3
	ipl4XlE1GuEhpvRUz4hiccBqH+xaAAFkjb55113BC4ys2W5Dfe9UySJn6xLP3hmh
	PryjaCc6PHhEnr6erqlEdjcQdlmQVvMpWQHjKYK/XVxkBXBZEMcYiceUQVyHW7n7
	9V4Nheuk06KoyVjUuE2va3jfx/UqpKgl4GQ==
X-ME-Sender: <xms:Yb6aZyc5xt-E3GE_NjbbG-Zjora-2hbYa-KIRm9OmOtSVQOvJtQXpg>
    <xme:Yb6aZ8N7qSixl_bkQDjYcWQ68Fcxl7iPWJwpAioijvdlePOfFn-qdY3puXthxZsUa
    Fb9U7eAK_7ZPIWWVA>
X-ME-Received: <xmr:Yb6aZzg8f74X1MXe96e8b8lX8fo875-5IMJ4kvg_2GGIUbzet24JcoUyBtLXm_pfVHOwHMWP-cBLPCOKuOQ0Y_hwP5_D-TpT_qWx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehjuhhnihhosehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefgjeehje
    ekhedvvdfgtefhuddvtddtfeelieffkeelieetieffffeuleejudektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpoh
    gsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhunhhiohesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:Yb6aZ_9fysT5jl5NFLjXHpAQ5Ql-u1aOfGf-s4FtQwvr-CaTA9o9nA>
    <xmx:Yb6aZ-u9wXmBm1MSgqQ9bDNJJR7De8EgH-c65i7AQL-m3EsTvKLRBg>
    <xmx:Yb6aZ2GbqUevYlrhdcIOvoyUS-Wn-rGBFhERdlEU6tEE471kaL_4cw>
    <xmx:Yb6aZ9Pf2bL10gJQaZ2JeSWbhYOmlfLYMitmXSl4S84hRFinrnZYAA>
    <xmx:Yr6aZyKsCy4WGG0mTFxiQUekIpcmaPt7gsVxT7xfEAfP-iWOZMHsUR4z>
Feedback-ID: i1ffb436d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jan 2025 18:48:49 -0500 (EST)
From: Junio C Hamano <junio@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [BUG] PREFIX environment variable ignored by git config --system
In-Reply-To: Junio C. Hamano's message of "(unknown date)"
References: <007f01db726b$ac911ce0$05b356a0$@nexbridge.com>
	<xmqqbjvpk1wo.fsf@gitster.g>
Date: Wed, 29 Jan 2025 15:48:48 -0800
Message-ID: <xmqqsep1gp0f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> <rsbecker@nexbridge.com> writes:
>>
>>> Thank you for filling out a Git bug report!
>>>
>>> Please answer the following questions to help us understand your issue.
>>>
>>> What did you do before the bug happened? (Steps to reproduce your issue)
>>> export PREFIX=/home/randall
>>> git config --system --list
>>>
>>> What did you expect to happen? (Expected behavior)
>>> Git should use ${PREFIX}/etc/gitconfig instead of the build location to
>>
>> But that is now how PREFIX works, as far as I remember.  PREFIX is a
>> build-time thing.
>
> Sorry, I misspoke.
>
> I was talking about $(prefix) Makefile macro, that is all lowercase.
