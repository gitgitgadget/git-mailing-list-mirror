Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358281E3DE5
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307428; cv=none; b=YQgppywGJNRU271feCGiFQ5l3IkOUPcD9S02thWtIa/Cgbadk7l4r/Acdfj7onWcEk8964jIw3b9fg/qSAWzHR6CsI4gO2OvatqxOFh0beZb4Vjf4YsQj2kzaKJqkmi7Z1YvjsBsDNU+89yzP2CqAVuZ3R+9yxGyUCaMaSn6Q14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307428; c=relaxed/simple;
	bh=QqMZROfLOxJsa020PRkaGzz+iROUkNc1wp2/51YSzlE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ls5DW0dcTco3M/mbD+iTTd5LkKMSMrPJr2GeKCRk7cOFzm+NJ7Zd0hOwICH8LnZNwq+I5gRPDuG6Ix5GCsogCoVtePi4MFpQTee9O85JTlS06VvEvZCciGquB0H5qX4UeXu4oiRe979aXVGlyLBBfzXd7EQ5cofUUqjM+SFqVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lE5ZAP26; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hJVWXSoK; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lE5ZAP26";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hJVWXSoK"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 296E51D00015;
	Fri, 19 Sep 2025 14:43:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 19 Sep 2025 14:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758307425; x=1758393825; bh=Ckw7tnr2k2
	/0XDLdriy0yXTgrgg+lvLWb0xh2tNBZZo=; b=lE5ZAP26VaWbFerGcUcph5iVYE
	uv6BkvwI36mdc7lCFYgIPivrkFmzUF5LnB8wyrk2nubuZPPeSD50wlfXczyRHTUF
	4hVZAyUSHUk/tszTHelvzO9jOJsrOAV6xq7fBxlMDTdZZgDXEIQuLTepru3oIBX2
	qmSAMLLVUv3p0VM9URDhyLrKd40pyIkXoETLGajGQh0U9429+La/I1rowKp8JqfN
	rQ67gVmIFX4ClKTcKsxnmK4pg+RuQLkJcDDM5ibCb3fjrJU2Z3kg2KVPuXLtzFmu
	5CZv7lIEMJVucd7+4RKZU1uFDh19cRPoRAqbmkponZK3EUm1r9xsdYuePv1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758307425; x=1758393825; bh=Ckw7tnr2k2/0XDLdriy0yXTgrgg+lvLWb0x
	h2tNBZZo=; b=hJVWXSoK9yuOde4WT6oVu1vcbV6hXpv6L26lRustFTYtXg7JQU2
	CYjn/ycYjHUHno07GLG+Oiy/iuFnreBJ3iU2pNqbSsbmUG16j6BwTAWv2bacW2DA
	maTvjgW/pnr3YM9xryoWfDdmTZBZA7UcGIl/tGX/Z9x3QASbM8v3NGZwvTOlQkIr
	UW215+CkJAA19W5hcvsNqKjhpNQGXbc8QxeNmiNWM0pGvuI0gJBz/evugCLAUSYh
	yfhA3+i7zlh3K29XExFENEjyitOg3if+FnloEhVOihSm+5cg95DZXc9CICKrSUat
	VkDMDiiFcWlajKTzXGfA4TqexssUxgHgvbQ==
X-ME-Sender: <xms:YKTNaMWAjBGlBQSkkvhT09K5QKojiOwwolRMSdq_y8DE1mRuP1tCbA>
    <xme:YKTNaMFkMuNtewjJoOqcgCU9L_hkFOe7UJAsED0tsLcdHos1EgZbbPGJfJxmCFRL3
    Z7ot-E4BRAl-YInEQ>
X-ME-Received: <xmr:YKTNaG12h8iSx9gr-ZjyULuG8EWNS1oc9wzRl5Jt_9Y4__mWMATM42_WBcqKGCPMx1N9BeOFVUkviNoGG5a-vVoD-P2Zv3N5aFRCl0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegleeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YKTNaGMXpf01OWNEFhx3X1JreIDHkiiEacPb9LDSem1bC9WSq6VpWQ>
    <xmx:YKTNaN5Ajr_72rphRU98lKtCmcC1iiLVwi6R9oZKj9c4xxawlXZGOA>
    <xmx:YKTNaI1augSDdTwM17DCpLoS4RIjujj1qaepuTp4hkCfS6k4r7uhwQ>
    <xmx:YKTNaGx9ICiRlN7KVaNna-swXeImiZKNWDmpGycS6ekyDCkQbeyRAQ>
    <xmx:YKTNaJlSMupamjHhhBkyTwBH20Ir_S4pz-rmAIxCC-EZLmrr6kGrHpFL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 14:43:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  shejialuo@gmail.com
Subject: Re: [GSoC][PATCH v4 0/9] Add refs optimize subcommand
In-Reply-To: <20250919082647.535213-1-meetsoni3017@gmail.com> (Meet Soni's
	message of "Fri, 19 Sep 2025 13:56:38 +0530")
References: <20250918054704.544254-1-meetsoni3017@gmail.com>
	<20250919082647.535213-1-meetsoni3017@gmail.com>
Date: Fri, 19 Sep 2025 11:43:42 -0700
Message-ID: <xmqq7bxu5llt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> Hi everyone,
>
> This series introduces `git refs optimize` as a modern replacement for
> `git pack-refs`, continuing the effort to consolidate commands under the
> `git refs` namespace.
>
> Changes in v4:
> - Improved commit messages and formatting.
> - Removed the NULL check from the refs_optimize() dispatcher in refs.c
>   to align with the project's conventions for API functions

I haven't read these patches carefully myself, but if you need
further updates to this topic, you may want to rebase on a slightly
newer commit that already has "git refs exists".  Either 07f29476de
(i.e. the merge of that topic to 'master'), or 92c87bdc40 (the batch
that contains that merge) would work fine.

I can keep resolving the conflicts between this and the other topic
just fine, but I'd rather see you tested and proofread these patches
yourself in the context of the codebase that these changes will
eventually be used with.

Thanks.
