Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F8443C071
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992238; cv=none; b=RAuLnp2lF7NNZNdD3afB/s1M/EvkOzZ1g1u5tampX1U14/X6ptB9CC9csIO2HcrOCqxTANi5xGbPqhSYjHDrwZcv40d1Nf0DViNUx9moDhh9lHnrjvm1XACkXgfmya0Jee0T9Zoc+Jsp1178f3ypmS471dKhkaHp9rTsMLs//xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992238; c=relaxed/simple;
	bh=sVB5VxfiMaTB/MRHW3DHgxVsio6UdoHHG1uIFrvPU+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zs79YQxn7Kt4IyblSh2sP5ucf8JQDcJTKbyeAsVC3S9l7JlgucHKoh53Qd8KKdlpojrGhQoVo+ClTaslta6ljIHpcChg9kqLS69ZNkfmeCYNEP6rjZGcH++2ZFZuo0hTWfc0lNR2jOI9PuCf0Mtr3J8D1uHyWvsuu1GCbQapWXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L+r36hNn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pz7mEfx8; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L+r36hNn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pz7mEfx8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0F6771D0004B;
	Tue, 31 Mar 2026 17:23:57 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 31 Mar 2026 17:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774992236;
	 x=1775078636; bh=4cb/62+Kotiv6OeqJOtxK+tuoCEtPRROAH8uHz/o2SQ=; b=
	L+r36hNnMswoGVPKvb2ylHXL5aGUVrJwyVDVmXBSyQQ3jbML1aP8TpR22z0Kug/f
	1zhWOc7N8nkRwvRRUQxU0kH57IqVbijQAc4atF9DtMw533GtWjGMzbKqeFUX4Jkd
	QoeVr+3qNMOuR2QHOuV4IiWRDc2CE+LIExFZdWtG+peyBEzVyZukglknTM8lOXS9
	3+WiykcNs1VDP9uMVI4d94P3InaOTHOgwRe0RCw9Jxo6owN+vAzC5Fet83RaMGoa
	67HPQPh59dBGp/PgJtkUVGjsnV58Ehda+qmUwR9dqhD0R4IJYWS0s/afGuG7pAso
	L6WIt5gZO3e9rIwEEmYxBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774992236; x=
	1775078636; bh=4cb/62+Kotiv6OeqJOtxK+tuoCEtPRROAH8uHz/o2SQ=; b=P
	z7mEfx8qC8deCcV8QX9EeL1f4bPx35sBjN+hZJ4Fa9ffpz5T5y3PQZujzg108AxM
	R7wLhxgXkoYnO08e0vVczZpv4WERUOXCb/mLF7vsJeEhSJcTGV+kTUoL3KXoJywg
	0Q4E5Mjpcacm2i/1p1n8VjjlMhzJTkZTvjP51bHh4bsQwl0f3XWbZHXQf/N6Bvvf
	bITbcRsTFJ9tROoivGaPaGW6P/0STTyoYe/HTs1r1ubCHqqlf0KU1PvPsihS8A3t
	9rSdli+EF5OifMjJjHk5jAI6kgYEsBXXg+rkwDvh3fmjv4cRqQxkrOU5pC6TkzV0
	doTZ+O2O7QQu1IwJp7HGw==
X-ME-Sender: <xms:bDvMaTKh0aK9PmHO3UNpcYk8pS2KBU4vNSWmneCXLczzghj1EM4pRg>
    <xme:bDvMaeJOWwNYanW_lvzTCFqFkHWD7qHJqTRA-hy_rH5we6sFU0BO9jEAMHLD33QDb
    WImxrVtiWFw8P4CL2W-2pgiK89uGeL67OjjVf1rcUxCk7MaEf-xDg>
X-ME-Received: <xmr:bDvMaQuwAZnpdjZPUp7I4wVvkF_a9BDizdDDzMCEDbrMOrrruDHiSurL5ynVQ6d_TIPslLaiBVLW6PNPISVB8qZ5Il_bg6QtQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedt
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bDvMabTkJVeoKHD8T9A4HSUjhBiP5DvJeKZ6oL1rWq81Cf5XMIts2Q>
    <xmx:bDvMaWNOzcFnrtj7tDn2O0jMFbSDdGSC1f6r5LPzwDT_ftbfYGsfmg>
    <xmx:bDvMaQagsWQVkXMbdPQ1xxIHkaqE4PwfXoGslexXPtDDG5CQOy8ghQ>
    <xmx:bDvMaQya2baEHvm3axRrva3XI6R_xxKBp06liGXtZVZ67zKxfayb7Q>
    <xmx:bDvMaer1mSoSKYxG-9z9GZqfEAzG7NrCWTGmDKm79I6vnQW8QAqhuh6g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 17:23:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 1/6] reftable/system: provide `REFTABLE_INLINE()` macro
In-Reply-To: <054e69e8-3dab-4321-b68c-a48d43dc052f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 31 Mar 2026 23:12:51 +0200")
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
	<20260331-pks-reftable-portability-fixes-v1-1-46bfae55c68c@pks.im>
	<054e69e8-3dab-4321-b68c-a48d43dc052f@web.de>
Date: Tue, 31 Mar 2026 14:23:55 -0700
Message-ID: <xmqqpl4jy9p0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> On 3/31/26 1:26 PM, Patrick Steinhardt wrote:
>> Not every compiler knows about the `inline` annotation for functions.
>> Consequently, Git knows to define `inline` as an empty macro in case
>> it's not available.
>
> Does it?  Only in compat/regex/regex_internal.h, which does not leak
> to other code, no?

As we also do 

ifneq (,$(INLINE))
        BASIC_CFLAGS += -Dinline=$(INLINE)
endif

in the Makefile so we cannot tell what people do with their
config.mak ;-).

And obviously other projects do not share our Makefile, so it is not
too much of stretch to say Git "knows to define", even though it may
be more precise to say "knows to let users redefine", perhaps?

