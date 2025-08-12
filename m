Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932712F0661
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034591; cv=none; b=EFgqrK/u0tI6SnALoXTENxK/Ubuy2aSbVN/D6W3aIWtYyhnn0/Qxo3KnVKZUvJ9D+HoRGySos4fJthjeu3DwZmLRpbzfF3dfXnEilirBwxcwT0e/PYGR5/N7KlIBx6WxYKjxahImCr0DoSL7V0mhyr0NMP886SyrQyWA4BOsOBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034591; c=relaxed/simple;
	bh=KqqnRbcKxmp5i4yY7aQ0q4SFT2+OvGHHNcmtvHYk9y8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ShjyjWUy6CjcGb+ZHIE4hGdcxgjWn12RstjRPF6hZ6QOnwU7/5I6OpbnyVKay5+LSKbKNshyaZylaOI4xRYzQrY73Bw8ns2TEWfGkSyzogWUA2Ee1jvbzrQiTpebaYXr1WxTQBUU4Cr+kcU6p3p0Qb7esmwKIR+fdTCOhY2iaOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=emPDO3j3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Na5xGast; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="emPDO3j3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Na5xGast"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9DE071D000EE;
	Tue, 12 Aug 2025 17:36:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 12 Aug 2025 17:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755034588;
	 x=1755120988; bh=q1EPjMaUc+hn1lMDXmTnfURB1aaU8UYExdYOLuIPqL0=; b=
	emPDO3j36kFhNcXnJBR5MaONuIFnM8V0fVYUs8uXM28hxND+lHmqEYw/Qfyoshkn
	tl151NJmfKXwd+2bJ0h+swVeLjcz38OoJeg9yZd6artCsCkJ441it3f8IMYXicf+
	EDfUJx6mLmI1AvIuZuR2CZPCRxdPAPFbUWZ2dNi4K3ISMNUJmS35NgKru6GzQ5GX
	FYwwIZEt88VuXITtTU+Q6BUh6YonUjz4gD+9j4bnQV/EjMk2KNZJnQMA3mNIxJRW
	WDt+c9qTgFoY1DCd24KRL25roXweorLlViEj528odNB8J2HXvhTyWCKMgTc0NN8T
	bmONKx2ZQpWaWF9Xq4zvvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755034588; x=
	1755120988; bh=q1EPjMaUc+hn1lMDXmTnfURB1aaU8UYExdYOLuIPqL0=; b=N
	a5xGastzOkdtxZDOh0WHB0Us8my11e3AAaO7xyCKO9hhyA846wAukUBRXiioLcTJ
	nag+xzLAqltQmjnDBPQW/TCAskBvYfzHCDidbhr3Izw75P1G9K7ShRKodA79PKYr
	AEfnuLFefqzZxiwwZ4ri+SLO7NXHa1EOtBpiXkix2qn4cahteokvw54fG+kAYfBG
	xWpbL4YozUWd4FkL5ZnneIFpmDaB/vD2WL2tpOv8/VUTQgRnjq+ChdFXk4GCn+D9
	bgUVM5nYuV5aelSfQnQUNyl6Uvw/tkhI1Bn+FWfo0ibyXN+3+Xxi+EDpQEh+i09F
	aYnqaejgcPFIQVMmgJ+ew==
X-ME-Sender: <xms:3LObaBoAlwVDhHGNU3Og9Ux4rWbSp-ldOrnhkSo5l_UoZ95p5c_OxA>
    <xme:3LObaPL5bFKPKVPr4-qzpoNTI7zB7dXMoB-4x0j0MW8stNL9zwwL9Lo7MgdRzK7uG
    Tei10JUOvUo4J1mgg>
X-ME-Received: <xmr:3LObaEoCr83ayCaa-_XTi_8upP3YxFXKw5KxHorw1mSHO-zkVeHhHO4ugHsw1RcQOta11A63ZCWoMLmjCa664x4VlfkKj23gW2rOBXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeigeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjuhhlih
    grsehjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3LObaHwy4EwmjPgToDzc6J-vLGOjICw9HsUHcpf7kBxbCM5IY0eewQ>
    <xmx:3LObaINAHT9hvp1weIMrSO2zJid6KcIhpzdf8Gr_ed5mc-zsT_Iddg>
    <xmx:3LObaM5xZ5DRYRqcdy1K_8eE8vfywSUCg9hhIP_6YXRTBE4sEa9IWw>
    <xmx:3LObaBnKo_GHwZak718uLrEc-B55PydWstFjDjYVzEVl_4ociz77yw>
    <xmx:3LObaPLme8uVeDnFQbd0lMXsNQ4U89kuHG0LbT0YCed9WxVp_sXocfQF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 17:36:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chris Torek <chris.torek@gmail.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 5/5] doc: git-add: explain inconsistent terminology
In-Reply-To: <CAPx1GveEX_r8thqpux0jcbEsEyLpNOvRWEvogUp4m_cNC5=dbw@mail.gmail.com>
	(Chris Torek's message of "Tue, 12 Aug 2025 13:51:20 -0700")
References: <pull.1952.git.1755029249.gitgitgadget@gmail.com>
	<f7e8e4c63a1205740c2d54368d7bcdd686882680.1755029249.git.gitgitgadget@gmail.com>
	<CAPx1GveEX_r8thqpux0jcbEsEyLpNOvRWEvogUp4m_cNC5=dbw@mail.gmail.com>
Date: Tue, 12 Aug 2025 14:36:25 -0700
Message-ID: <xmqqpld0ql2e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Chris Torek <chris.torek@gmail.com> writes:

> On Tue, Aug 12, 2025 at 1:35 PM Julia Evans via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> +TERMINOLOGY NOTE
>> +----------------
>> +
>> +Git uses the terms "staging area", "index" and "cache" interchangeably
>> +for historical reasons. Many commands have flags like `--staged`,
>> +`--index`, or `--cached`, and they all refer to the index.
>> +
>
> I think this is also a good idea. Unfortunately, `git apply` has two
> different meanings for `--index` vs `--cached` (I believe it's the
> *only* exception to the "means the same thing" rule...).

Yes, I think the first sentence is an excellent addition, even
though I do not know if "git add" is the best place to teach it.

However, it will be disservice to users to say "they all refer to
the index" here.  Yes, it is technically correct that they all refer
to the index, but that much any intelligent readers can infer after
reading the first sentance that historically these three words were
used to refer to the same "index".  And what I think is bad in that
second sentence is that it implies they may mean the same thing
without saying that.  It is perfectly fine to say that these three
words express some operation around the index (sometimes called the
staging area).  It also is fine to say that "--staged" is sometimes
used as synonym for `--cached`.

But at least `--cached` and `--index` mean quite different things.

As "git help cli" explains, an operation that can affect only the
index would use "--cached" and both the index and the working tree
would use "--index".

It may be that "apply" is currently the only exception (I did not
check), but it certainly is not guaranteed to stay to be the only
exception.  If a command wants to work on both the contents in the
index and in the working tree, such a command is very much welcomed
to use the option "--index" to trigger such a mode of operation.

Conclusion?  I would rather see "Many commands have ..." sentence
struck out.  After all, that does not need to be taught to those who
came here to learn about "git add".

Thanks.
