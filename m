Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA82219A7E
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748988766; cv=none; b=bV11Oh8FQntbKTujU0QjujPMvnR9BzwmKL7ofpHa9XPYA7z8lsrXfXXO3FPXCZ32YA6pUmfEaOlU3kyjDV0rfv6WEEcdj5yi7En2pvzl0sZDDZ8E3jF+2Qe9RbhV9oz4L1KiSXHtagxbwxs6JwbWq9dw8fKhBQkvxf40DCxZfho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748988766; c=relaxed/simple;
	bh=EsaryzaDFeqPHPdcq/ndalIgNaMwwnggTyLqlXwlSxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nic2WIB2cNIEUiTCAITSfy6kSDHtq6KTHSdgGowRS0BrfRtgKEkwmAeDwiCQt2o0+CVOyC35mOFC3myMKnEqFkJKDhrOgBQ0RLxK+3qyMUhNCHFuQONXYsBj7e4+BQ2X1ii+Kb9iaAjEm97L2mGLvzGjMsKkZObvRmE8u7ENsyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hks3ltVd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oAVotQBL; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hks3ltVd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oAVotQBL"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AB3D011400A4;
	Tue,  3 Jun 2025 18:12:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 03 Jun 2025 18:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748988760; x=1749075160; bh=KNq1bYapz7
	qJYUQCj8Keanr9Pcfru+8JmAtZDyksUJw=; b=hks3ltVdNHUr7ghgA0Nmxo1Dx4
	YhVoNs9i/AD8fzTpPZTLc5i1w+xMYwXrohq9PiUb1Lcs3a7PwzoKNnwiJVS8JEMD
	wcOhUCu3X8BDKa7db1GDD4M9VC6ZEBoEhxUVAK3974QetuYevYAbNUNSBsWCze82
	pfN9o84yld0Cq4l0lQVZ2lJrVwr2BM7tB4uNhXM5/pGGhNlMlqcfhwKLMDzsfai7
	ZDTrx5jmlvzi4eXqj+qHYZ7Zusx31M7AQOoFI0y2KUTOIfI3YpmK8mUxdhKVYKOv
	byk6+pmQCEtnW+cTuSwq6qIeeJ0kp4dUNzFhy58C6MLYU76fdotMrPQkUxPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748988760; x=1749075160; bh=KNq1bYapz7qJYUQCj8Keanr9Pcfru+8JmAt
	ZDyksUJw=; b=oAVotQBLz3EvsqwJnZHBmiqyUxwhL0yZtwIqATaet+GERF8w32S
	5TLqU4SvnUX9YRHyz/j9UI4GstwuqmOxZPx7oO6bK40KoPxm29Ax/HtfO26lz/3N
	ZvF9DM+Gc1ZX/8H82qzoN+CGxeIaR4k2Of8mjoIXVdiGEbeAB126PH+s3PDN1egF
	TuSiAeQmYVM54iJgC9nelG75bH1wBqKiRgf3XGHECI/W3vGjnaN+3Nqf/L/LDZgI
	ixP/QIRnpriQQHbz/BUVK6T5HxjA+tt8nDjLBlQh9FoV0IbtAcnowwvyeH3OQVMS
	DVO5VIFKUTYmBeicyD6p41pqwR0Wu8GDseQ==
X-ME-Sender: <xms:WHM_aA_joVXwoM-eKbGKskPEAc_kQC43X7r5j_j2ra2YWApSl0T96w>
    <xme:WHM_aItDt4Pzfxuuu-s2DvWZ5ydUQtxs2mithXH8Uf8mAUkK0WWjTA4Apwp8GzjQB
    WwaTYHnYLOFJRg8Eg>
X-ME-Received: <xmr:WHM_aGD8OoH9l8pk6CqM73Ido0F3D3Qrf79IVtY3X8HHyv6SmcCVTu15Gs20_aU31IbiL0S29lutkKxBvrOqwr9kJw6gAn_lT81h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehmrghtthhhihgvuhdqmhhohidrfhhrpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghugh
    hssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehsuhhnshhhihhnvgessh
    hunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepthhmiiesphhosghogidrtghomh
X-ME-Proxy: <xmx:WHM_aAchPzJ9faLSw9tMW_faitSvW5xCNx17fY51Xy3IfZ84Nq9jBw>
    <xmx:WHM_aFMeRd1OMlls19bMxeX6bGHGmRxqZ7vao96zntLNlXivOGGMIA>
    <xmx:WHM_aKkXF785wn7YMr6QTynpLiVJiPA4UMB58NmJtgNkqsxf05JrSA>
    <xmx:WHM_aHt6gOzYcrKONd3xmzcA-yVU7GrbjLkeeOXqH77XxYeuYcxisw>
    <xmx:WHM_aJ6TjGCcsJc3NjTOBKp9CNcMRYaZ-at8XPK9V2GRX1w-pwkPKfXX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 18:12:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  collin.funk1@gmail.com,
  git@matthieu-moy.fr,  git@vger.kernel.org,
  kristofferhaugsbakk@fastmail.com,  phillip.wood@dunelm.org.uk,
  sunshine@sunshineco.com,  tmz@pobox.com
Subject: Re: [PATCH v2] contrib: update thunderbird-patch-inline
In-Reply-To: <e524f5ef-0def-44b8-81b4-a8a13ec5eace@gmail.com> (Phillip Wood's
	message of "Mon, 19 May 2025 15:21:04 +0100")
References: <a3aaa11a-a842-4c10-8189-07b681663573@gmail.com>
	<20250516135540.218937-1-phillip.wood123@gmail.com>
	<aCrD6RlO0xUmXr6i@pks.im>
	<e524f5ef-0def-44b8-81b4-a8a13ec5eace@gmail.com>
Date: Tue, 03 Jun 2025 15:12:38 -0700
Message-ID: <xmqq7c1sh3u1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Patrick
>
> On 19/05/2025 06:38, Patrick Steinhardt wrote:
>> On Fri, May 16, 2025 at 02:53:55PM +0100, Phillip Wood wrote:
>>> Changes since V1:
>>>
>>>    - removed the original definition of SEP (thanks to Junio for
>>>      pointing that out)
>> What I still don't quite understand: who is this update for? The
>> existing script is broken for years and nobody showed interest so far to
>> fix it. So I don't think it makes sense to fix the script just to keep
>> on dragging it with us.
>> If the answer is "you" then I'd be fine with it. But if the answer
>> is
>> a hypothetical "someone" then I'd honestly prefer to just remove dead
>> weight and not bother with this update.
>
> Personally I don't mind that much either way as I think using the
> "toggle line wrap" is more convenient for including patches in a mail
> (though that unfortunately only works with the current esr release and
> earlier). I agree with your previous mail that having this patch on
> the mailing list could be useful for anyone searching for this in the
> future so I re-rolled to fix the issue that Junio pointed out.

As the discussion seems to have died out here, shall I drop this
patch out of my tree?

> Note directly related to this series but looking at the format-patch
> documentation in mentions the "external editor" plugin which has been
> superseded by "external editor revived" and "toggle word wrap" which
> has been superseded by "toggle line wrap" so we should probably update
> that.

Another documentation patch may be in order either way, though.  I
am not a Thunderbird user myself so I'll let others who _do_ care
about it write one.

Thanks.

