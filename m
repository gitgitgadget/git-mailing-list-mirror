Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A69185920
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737416609; cv=none; b=WKYs+hfF9MzVXdKdSSMNf1YVvhyXMKiNYJZ5KbR0OUB+twhxIOHUZ+PX9Sq+kaAn8enI2bO3SuXVP3Qa2OhpdQijmNnmqbxt70VVFz3FRg9HSI1k39go3J4EOQxWsojH0ycmE2sFEiSy551gM8ibElhWC9OGAGBzaSqPwlHsDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737416609; c=relaxed/simple;
	bh=8q8STXgvAKXdud7MzWNGGuUxbG/NlQd8VNMTEn42CXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JScS80l2IAoHqtSCMHMiJf2Osc66y0QSlU356jqS81dwe1qIR1UBhxprmAQDLhIh1QYLcjwl5TDKSvB/eVKfhIU/k7yhOcKN2GJ9H9KI9qJdjpKRhrO7plFkmHkHwD6hX+EwPIWpSNCE7uGQhr5tHurN/+E1uG3JVL6Iq6Ikbww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LaUOx1Oy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OiGcVGa7; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LaUOx1Oy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OiGcVGa7"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B09713808A5;
	Mon, 20 Jan 2025 18:43:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 20 Jan 2025 18:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1737416605;
	 x=1737503005; bh=fPCXHmf0qlif1BtkmJ06hAxnrtHQfc1sJrF4vbxekig=; b=
	LaUOx1OyZyy188eqNe2l6XIJdqJry4J7/VrRjZzZBLXvVfsZEELffKBqcv3dxyD9
	ZgvAKxh6EtbQ7v9ylN3FZ6HFHOD5dhkI1CywumWe1SADPZDtQYx/Ilb3614DyL7W
	+eEF0001AekWxI52F0teJG2bQNgPJrXBp3dLmlz83K6VJ8NovJ5K1pgXkON65k/r
	CWgG97wU6f2p36ufHVmt8hNfsHTmyhtnqusm6VJ9xzQ5M7ygTMxJs0TJ5VXj9e+v
	TAJruXM5t4dDTVFLjj/+1c0m10Xg6he49MQdN6Bo6+q0BIi4kdCB8t1NxE0eLhVP
	1OnSVpgWvorINCYsfGhulA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737416605; x=
	1737503005; bh=fPCXHmf0qlif1BtkmJ06hAxnrtHQfc1sJrF4vbxekig=; b=O
	iGcVGa75Dh42f/wG8CeYTUi7MzlkEVaWt6SaRunqGrTYkwmu3E6/zBQ6UoGWW0wG
	60a/SQHd9P4BisqPqELChRkpaXBhFA0AB0CL12D9UImdUVdG4XgBg5/FojWp1oN8
	AjRywrZEFYCqxlG7x6bzSSOaIpWU/dPujUKE8EBg66y5m6vOFmeUgUm+w7HjPQjP
	hCHpuB31gnqGblt9NPwouZZXNSq+wC9qMiE5kSlc1850JxRMZWb/iog+Hahajc63
	ZMxRwxKPiI1Nc5VqabKu6hAikV5wo1uspljpsfV/f2nK4JYy8LtAv3Do0ykyJvxK
	VyMW3kwinyza9vTwe5t/w==
X-ME-Sender: <xms:nd-OZ-iE4aDMrtkrNrBZWGVJJH4u95pZaO9DblpktiZTbE1fZBlPNg>
    <xme:nd-OZ_AiRBvP4j8oNmNJgaIKUQJaMp2LKOFw9XyMcbCCcBf2R_9SV0H60lVuVk_Fe
    tw2SXSDtchmHWNajw>
X-ME-Received: <xmr:nd-OZ2HYBiCrUMDs14ICyXlmK67L9XYOePH62PeGbA7C_Hx5vs9lSyr0BTq9olE-G7fCdfs-Yrbhwbum0b9XPDljjJJMBUup2-u2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjnhdrrghvihhl
    rgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nd-OZ3SzoKWmf46wE7Lisc3BbAVG9x0Ega-lXteDvDHy0O6Bnc73YQ>
    <xmx:nd-OZ7xk2inNu2XwXNAL2eSihPkMwwq5L-guN5twHLJ1gcIMoUtfcA>
    <xmx:nd-OZ15otG5BBcGY68WtyRf3VyL8GWaAJFKIQYEvKDP5LccPYDFHKA>
    <xmx:nd-OZ4x12mWOrDhwcE2jc1BQbMhkG9FQUzSL4eGZ5W-2sBMzhjLDww>
    <xmx:nd-OZ2oKiOAfJTOWZrwx5UtRVsNHo_DugYhiX-IN-K2jNMLVb92Opsyf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 18:43:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
  git@vger.kernel.org,  M Hickford
 <mirth.hickford@gmail.com>
Subject: Re: [PATCH 4/5] doc: use .adoc extension for AsciiDoc files
In-Reply-To: <Z47JUbdzMtz1CTMg@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 20 Jan 2025 22:08:17 +0000")
References: <20250120015603.1980991-1-sandals@crustytoothpaste.net>
	<20250120015603.1980991-5-sandals@crustytoothpaste.net>
	<46cec27d-ee66-4dfb-8271-953b032d0b2f@free.fr>
	<Z47JUbdzMtz1CTMg@tapette.crustytoothpaste.net>
Date: Mon, 20 Jan 2025 15:43:23 -0800
Message-ID: <xmqqmsfl2gro.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-01-20 at 20:37:10, Jean-Noël Avila wrote:
>> Maybe for users of the end product of the documentations compiled here,
>> but there are other users who use the source files and this change
>> breaks their workflow pretty bad. I am one of those users for the
>> git-scm.com website and the manpage translation projects.
>
> I appreciate that this is a big change, but we do also sometimes make
> those and contributors and downstreams need to change over eventually.

Yup.  FWIW, this change would break my private toolings by renaming
things under Documentation/RelNotes/, which I did not think we even
pass through AsciiDoc, even though by inertia I write something akin
to AsciiDoc in these release note files.

But all who are on the creator side of the ecosystem are expected to
adjust to the upstream changes and that includes me and those who
format git-scm.com.  They are much less protected by the
backward-compatibility promise than the end users as they are
expected to be much much more competent to adjust to changes, and
more importantly, they are more aware of the chance to speak up
before too late to influence the course of the upstream.

In this particular case, I would imagine that the use cases of
myself and Jean-Noël would _eventually_ want to be adjusted to deal
with anything the upstream picks as the file extension that may or
may not be ".txt" (to put it differently, they are written to expect
that these files end with ".txt", but the _ONLY_ reason why they are
is because those files in my tree _happen_ to have such names).  We
certainly do not want to make a change like this unnecessarily and
unannounced.  But with sufficient advance warning and enough time to
prepare transition, it shouldn't too bad.

Perhaps it may be enough keep the topic cooking a lot longer in
'next' than usual one calendar week.  This of course requires that
those on the creator side echosystem are paying attention to 'next',
are capable of writing necessary adjustment (in my case, I would
tweak my tooling so that it uses "$filename.$suffix" instead of
hardcoded "txt" in the rest of the script, checks the presence of
Documention/git.adoc to tweak suffix from default "txt") for their
tooling, and can arrange to test their tooling with 'next'.

>> Maybe a smoother transition could be performed by creating links between
>> txt and adoc files.
>
> I'd prefer if we didn't do that, but we could.  My concern is that will
> actually make the patch even larger, possibly to the point it might not
> fit on the list.

I do not like that, either, for all the reasons you meantioned
below.

Thanks.

> We'll also want to eventually drop the symlinks if we add them now,
> which means that the breaking changes you mentioned above that you
> didn't want to make will need to be made eventually.  Is it that you
> want more of a grace period to do that, or that you're opposed to having
> to make the change at all?
