Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E051B78F29
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838853; cv=none; b=Mts8eARSUaFzN5ZPtK6vGcHQngY6dfnQVXqShuBjFYo9THeLxT3ODYe9dLByq4/H4lGZevWaeRSI5o/T4A+T77+W02PUTo9CtByzbNsj/fWYyNsdIiNfw8xT4Awa2lPcmt22W9c9I5VR9FGVKIsqWiFMD5SV50S7W9BAwkkCysI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838853; c=relaxed/simple;
	bh=9xP15ch/aFVJNR140MtwZAe9//Hv9gVe+vQwL0ybH+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aP6kAc7EDYVJbHwMkjxS3BG4IHoYnbeGn/URxwl6zMcN1YoTw7xWrz24GoTycmgJ3FS2QomPk5TEcfN3TjV5Ec/PGegLxULLvKyeghj7YtK5qDwqRIg/no9Vlf4U/yr5W47MJW3rZnymMreSM+NEHjSm9932GZH/GL4BRTygogU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mx43l/Js; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P6wfUkr1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mx43l/Js";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P6wfUkr1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C7EFFEC040F;
	Fri, 10 Apr 2026 12:34:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 10 Apr 2026 12:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775838850; x=1775925250; bh=C3Z6yW2Utz
	8Nq1YlW/FMml/+3wXRHEPhZBNOnwI8xWI=; b=Mx43l/Js4sgtdGDMtwbrWB+qIc
	maN6MliHNE+pmS2fubKkLCmoTGMO3pSEY7/qE8SeTXIVMwKWSMfdGmexPfwmd9gv
	1vVsX9rLZmLmuU6XwtLp3I+q0pKIGWyS09/M2cKSnm2ewfa0LBUYUtRWG6Aytsyu
	agH8tOrQg+hvKBDYXeY0EJQT/YgabMBhCl5BoRkwIioxwFiBPN/bgJoiNENLoUq9
	aTAyDTOzyl5zwIg4n1lhFNBtm+FFXD6ePXQKm+i+IwmhN39kEqjznfn0txKgnDtF
	+E8772hEoncv772eZkENw+3qupgh23vqNQRU411plfVfmocQDAS81cRpYcmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775838850; x=1775925250; bh=C3Z6yW2Utz8Nq1YlW/FMml/+3wXRHEPhZBN
	OnwI8xWI=; b=P6wfUkr1V2Cj4dxdPxQyLH2S4Be/3rRjgVnorpJEqYYgdjRw3oa
	wifUZBP+IB9gmrutkjah+hPoEKGB+754jon//8gsIecsh84l9t4fCTL+CB16YmW8
	IAlj07j5nzjiiU4pPfsDVRTL3qghYFkVh+cNLOphxQtzIqUVsbdbmCCEnJMU68qs
	Ig14p0qElq4y5H+/28EvXg6VgK51ujWjCVW0OPw7mTR9kIt4lcLJysvUxY8IaZ1W
	TlpRbZMaHdS5WVH7TKQflBmdne6DhUgMhYT6p18TJN8Epgn1a6H+ZseiGm4J20kC
	WAaLUHW0fmzUYlvO5QlY6DFRbJKy1oq4hvQ==
X-ME-Sender: <xms:gibZaT8CycCpli4_56gnU2iRypfgFn0Cxu8qhj0IySEaGt9WxXj7Xg>
    <xme:gibZaWl123wI-ae1GGf05OhqSTR_SVTBxiY_KzG1AGMdHRUkPSYD3py8-Rgo8ltcy
    NkAZZrw-ew6xLQ7L27G2TZfxFXOM5rUcDKsF6hyrPGXJLkdVq2Lsac>
X-ME-Received: <xmr:gibZaZXmy0IeUycXqzkKpJATuE0B--GrhO8csChNJmBpDjqBc_aavJTrU5g4TsQV1t0iC2X2so-Ujj_gU44TpVoFASmaiXvlTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrg
    hrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gibZabE1-O41fgw-0WmBGKDvY7k_8pNHdG7oRPbYzoy-ngC5iNtVFQ>
    <xmx:gibZaVefLfLHrHHNCfLl1XvEOO6y3vT52BePEeu2xHTwBPs30ieVeQ>
    <xmx:gibZacJbxXRpumh15JmjSPrrc_DwA3bFoDpOApgaihyVjmyCEFWBIA>
    <xmx:gibZaaGliTEb-SOYvVLiEO8tU-OXa_2f0A_VcnJiq2UOL5raDt3DrA>
    <xmx:gibZaSU__3edpUHKvhgsjTkZ0EjG_dUPIYKT40NVsWGsyIzJ2xLJ5bbL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 12:34:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v8 3/4] sequencer: teach autostash apply to take
 optional conflict marker labels
In-Reply-To: <a93e990d-f702-4edb-958d-eab11dc5c663@gmail.com> (Phillip Wood's
	message of "Fri, 10 Apr 2026 16:39:34 +0100")
References: <pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
	<pull.2234.v8.git.git.1775762235.gitgitgadget@gmail.com>
	<78300e0e9a8beb7ffb28a38a5e203556b2df9d56.1775762235.git.gitgitgadget@gmail.com>
	<a93e990d-f702-4edb-958d-eab11dc5c663@gmail.com>
Date: Fri, 10 Apr 2026 09:34:08 -0700
Message-ID: <xmqqa4vapyf3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Harald
>
> On 09/04/2026 20:17, Harald Nordgren via GitGitGadget wrote:
>> From: Harald Nordgren <haraldnordgren@gmail.com>
>> 
>> Add label1, label2, and label_ancestor parameters to the autostash

Sorry, I just noticed that these three should have been updated when
the actual parameters were renamed.

>> apply machinery so callers can pass custom conflict marker labels
>> through to "git stash apply --ours-label/--theirs-label/--base-label".
>> Introduce apply_autostash_ref_with_labels() for callers that want
>> to pass labels.
>
> This looks good. In the future we could use this to set some better 
> labels for "git rebase --autostash" but that does not need to be part of 
> this series.

Great.

