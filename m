Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187191D555
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652956; cv=none; b=kbhVclI9idDtgRvLfeKhB1elWrgIiVR5LJSh0A5/sZ/W+swdArhJTMtSNblGS0L1XQuoe3ud1wvPB5wQ7puAg3cG5X+O8XKanPuKHaMgQvNnSdF5GXEupiC0FzYRh105rfY1IkEG0sz96CIHGY4CWP49iA+zuMGJX9yReyrJOu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652956; c=relaxed/simple;
	bh=W9KPa9yJ5kSrXL8Uoknzu+nlGfLkCreF+UV43rLSKW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g0vLNr27So+9FtlVSeiDBdd+wMM371P9ar/5aXL2x785ZE9KUvO/sywnYMaqbbzH6kAqpqv2kRLGBcESgyCSLpZpp9nIMTsCouYnRGuxQJTWujZ67D9H7iKZnZUYd9p/1M9RfwlGJU7cmNMiPBrMJOH4KCC53jZojKEoSSwkIOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=joNgUb2N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BLF+5XdR; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="joNgUb2N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BLF+5XdR"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 2213E1380239;
	Thu, 23 Jan 2025 12:22:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 23 Jan 2025 12:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737652953; x=1737739353; bh=hJGC0cPdUl
	H/Uvh9AYigyQJXcw4/UpCeL81BGjZlj50=; b=joNgUb2NBo7KdPWIMJNXwhahHX
	4EkpfkGDND76OjHGjOUTYPP5H2+5YPIWLkpECoGzv7AAHFBEtJ4qLhIhij0ZdPui
	KJCEADgtGdgZ28pndHvHtgp0OTan0NeSx8spbjUL+69VGreuf2k9TRAWccrfloI8
	W9w2kbVxXjfonqJL4EmbGOFV/0LJXyax3WhcWqPD/6VX5RbPwi1O5jQNYJRi0RVW
	Y31Cfwm9+kQx2QxaDm6jb6sYUIhkJKXSc4YkMRUXohf0Ge1gxlt76Ved3kvD27Ry
	dupu0oi6R/loAaOOLpNmxli/kXyl+3TEoqvwUtQOpuTLad9hg8GhzltQWKpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737652953; x=1737739353; bh=hJGC0cPdUlH/Uvh9AYigyQJXcw4/UpCeL81
	BGjZlj50=; b=BLF+5XdRHL06riLRrX6DOK2dK8j9b6PIP0fQmgK8nO+rQOwL+TT
	jA3CnYb9aTTAsQvpFKfp35h17BZb9zR1KXi36iV7BH6Sn+K2pEEs0MlkDUslylup
	2UKbtlw8VJR12Qv3YHuxL/73xuNCu/L9k/4KjfRHbXP4h7XjxDqYEDHFtQSKaV+K
	4tFLE6Q/KeDoXZvuFblpsAdGpPZlztG+IbDr/Ju9C20hv96U318Uhe+yA2JhujEu
	yTPPFThflZ8bB15meZUCs/vX+5UsOZvODFgfS6XfK9ZYwioDy7VEEL+UiXwRVTFr
	kqUuuTHirCH6aEX+K6oRVqX/14HR8oKxwHA==
X-ME-Sender: <xms:2HqSZx-VQd28WUFqTGp7rz_yNiN3HD0ej6JJvdWOFhSnQdYLAdAoww>
    <xme:2HqSZ1t0cMNa2e6sBUo7MSekNciSp6RFe7SPP0EHBRFDXnYhSRgGFyrnvBXTF7MPQ
    zj94JMUDuOQlBm96A>
X-ME-Received: <xmr:2HqSZ_Ckr2Qqiz3r0_-LLEVp6F7S8-ATEEyhT7hUNJsrEwf2L4Yik6Wcnluy-5VUjvmEKQwp9cccCQP3aFPotdiEzGCr07PytV2W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2HqSZ1dGHB8V-NGiygUiNlEC0wzn4ONnXdAp3hYHgIvjS-LLLkPVlw>
    <xmx:2HqSZ2Phsyx4Qs9oC14YWi95NIzQBjs4fzefazrwvIH8VMaz_L6YAg>
    <xmx:2HqSZ3mFQMdk-paUoW9ApBBeb6z-UX9dXIOSU5BurfYFSWR5wSnCAg>
    <xmx:2HqSZwscjTqJAlcLAk96RGTc2-oTDQNxXb2GRKtTHpWdTNxxtuYwTg>
    <xmx:2XqSZzoBJGhV58fJzCqP6dDc5KdJI8B6BUI-SIViUuUH_pt5wBghIvGx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 12:22:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
In-Reply-To: <CAOLa=ZT4nws0irdZKUuWc70Rv9RUNQuSXnGAt1SnE1O+umSReg@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 22 Jan 2025 09:28:40 -0800")
References: <xmqqwmetgdgm.fsf@gitster.g>
	<CAOLa=ZSyEg8G9g1B78VRymgfk9eo=d3KkhD=+S14_BSqaAO2Mg@mail.gmail.com>
	<CAOLa=ZT4nws0irdZKUuWc70Rv9RUNQuSXnGAt1SnE1O+umSReg@mail.gmail.com>
Date: Thu, 23 Jan 2025 09:22:30 -0800
Message-ID: <xmqqldv1tpgp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> * kn/reflog-migration-fix (2025-01-15) 1 commit
>>>   (merged to 'next' on 2025-01-16 at ae8f9ce9a0)
>>>  + reftable: write correct max_update_index to header
>>>  (this branch is used by kn/reflog-migration-fix-followup.)
>>> ...
>> This seems to be breaking on 'next'.
> ...
> reproduces the issue. I haven't found the root cause yet, but will
> mostly call it a day and get back to this tomorrow.

We have a handful of topics related to refs subsystem in flight,
and I am a bit lost here.

(1) kn/reflog-migration-fix (the above) was done as a "fix" for the
    issue reported by brian in
    https://lore.kernel.org/all/Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net/ 

(2) You mention that (1) is broken in the message I am responding
    to.  There is no known fix yet, so (1) needs to wait in 'next'
    until it gets fixed.

(3) kn/reflog-migration-fix-followup is a code clean-up for (1); it
    has to wait for (2) as well.

(4) kn/reflog-symref-fix is a fix for a different bug the commit
    that introduced the bug (1) addresses.  It can proceed
    independently from the other topics.

(5) ps/reflog-migration-with-logall-fix is another fix for a
   different bug introduced by the same series whose bugs are
   addressed by (1) and (4).  It can proceed independently from the
   other topics.

The above is my current understanding; did I miss any other relevant
topics that are related to these efforts, and/or did I misunderstand
the dependencies among them?

If I am not misunderstanding the current status of these topics,
I'll be marking (4) and (5) for 'next'; I am undecided for (3).

Thanks.

