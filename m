Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A828EB
	for <git@vger.kernel.org>; Sun, 15 Jun 2025 00:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749948351; cv=none; b=fV2OuVSwnBqU7zR2Rstdk1oYGKho9hDfa16AlxrIUZ++fOLwxryFRRHraj9aCZiprBvcBlngaJr7IYCiZMPsUg3DPcHBjRJQ7YB10kh67ZwPln7+u97BvAj0S8lw3ojnn+Ml6rpJ9IbglzCmGGIkF04pZZT6N5ZCgO6/Ok1Nx34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749948351; c=relaxed/simple;
	bh=49scDHZq/BPykfH2vfIvmqW8Ca3vBQ0VS+A1wzQM0+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DF18FOuMlaar7/Wgy323z4V1nwCnvqTn2OHT3+dMy9EUSSLnyy5ukKaju9IfPx/ZgQbm/T65Jw4MSCRfYPIM8XJAMXz6J2s75f52Qm7yymJ+f5ugSHeAD7JXZxFQeADB6bmg+rWmzATfXfsH+o2xZzn/3fR0LJ+33rzMTfb5Ekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XD8csqyc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QbvWriuw; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XD8csqyc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QbvWriuw"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 9BBA311400DE;
	Sat, 14 Jun 2025 20:45:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sat, 14 Jun 2025 20:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749948348; x=1750034748; bh=Xvqd28MK1c
	3teyPFW18mgsXZV8/Nn+OB1a6Rz64ITf4=; b=XD8csqycLAB9NvaKpnhv2FE8ug
	yfDdkldCtThn+T/Y1lOeaGWSgYL6KYU+yxXExIkNxOPmONUJ7QA1xD8sH/N3jOm2
	rxj4lJOecZ1miTqJBTqU4ozs30RfwY2WHCYkJRpIr5Sb1ZtELfmPXp3/l6StNCTc
	cFw7T4pCS/1t3pyWXvGzb8KIf5Iwtv0R45TuTqzTKqfA846On8edU8KpGgGqOY7X
	n0mOzWHk/APYZvnIbjkB31PuiEjI7dHYpeKyBt+yg1zmnZ3e+7KUXriPageUHF7l
	siupJH3c7GQ0MgaAtDMHYrzwVKurVUu27ywUCyciC+GUT+iNNXIqSXuDflMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749948348; x=1750034748; bh=Xvqd28MK1c3teyPFW18mgsXZV8/Nn+OB1a6
	Rz64ITf4=; b=QbvWriuweCzqNu47M+gZb8jUkdOAGg+aBtrNd/wL5zF3Ab7yZvZ
	J0SoeOcU7Zc9IfAoVJ/Q4VzN2uPmBgniR9Y9WUgnz7Et8keS6nWSr3nt/VazCOoR
	GjdSb4ZAdMZvYZ/NUuMe6Zxt9IrupZKDcFDPIP5ezBexqlKl2KhfPgRU68gC59Dk
	JPab5Pn1A5wm/fRknvzjrUH6ZiSqG6uzRe3ztSzqni65VWONVvBdDY7t+bJuapwx
	MxrqCUIAMBq02myMMZEEHE0JNgbuXSirRtxLjtWPORGiuK2lNP3ceF0IiQbdyCKP
	VS6PMGTV8IwtthodStq0lraf17RLkhKjtOQ==
X-ME-Sender: <xms:uxdOaMeCpRGN_AWpa-GGCxlCyKy1vPyc9V5dARM9Uve6sUk5wxr4PA>
    <xme:uxdOaOOUYaB-rAtXZjcxAW1kC-wK_Wdql52ydnMwYa8UAu9mbQeRzjlEcuNJ2qtJR
    o-N-7P3WL7HDaeBrA>
X-ME-Received: <xmr:uxdOaNiu9AdzK8Ezhg9ioDm3FdQY54aZP4m8Cpn3ljhHbcFRyH9caeHOLOiVmRxKy5q4CowiNukwwSWaw1llLTKay-C-rUfIDk93>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvvdefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopeehtddv
    tddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgihguhhouddtvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhuohekgeeisehpuhhrughuvgdrvgguuhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uxdOaB_uR_xJ9K3p_gVL_wkxGRLdbtqmZCFULu7quwQ_lWpS2KoLSA>
    <xmx:uxdOaIsBaK0ITeICAfySYwMDYEDqta3XF3TRLmv39PUWGSmRd7tkpQ>
    <xmx:uxdOaIEmtr3TqZYhb5X3YIbZ6glcz-FnA-Mlc9QkIcOnmZ57sAJM2A>
    <xmx:uxdOaHPcrzy7TSmJu5HEVJPmHC4YqcsZuD9co2K7cUoLie4XMEbUpQ>
    <xmx:vBdOaEND_0eRS6eHGw-oVE8u90sptXW5FERUTTP1EaGsADNNIJBfr4OB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Jun 2025 20:45:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: lidongyan <502024330056@smail.nju.edu.cn>,  Alex via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Alex
 <alexguo1023@gmail.com>,  jinyaoguo <guo846@purdue.edu>
Subject: Re: [PATCH] Allocate msg only after fatal checks to avoid leaks
In-Reply-To: <20250614230158.GA2568638@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 14 Jun 2025 19:01:58 -0400")
References: <pull.1998.git.git.1749843142000.gitgitgadget@gmail.com>
	<3993AF96-E03D-46AB-B18E-8E6C1108EC45@smail.nju.edu.cn>
	<xmqqcyb672mc.fsf@gitster.g>
	<20250614230158.GA2568638@coredump.intra.peff.net>
Date: Sat, 14 Jun 2025 17:45:45 -0700
Message-ID: <xmqqh60h6ddy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> And while it may be tempting to say "well, it does not hurt to free them
> on the die() path", in my opinion that way madness lies. You may have
> access to some local variables that can be freed, but there will be many
> other heap allocations that you don't even know about! Here's a toy
> example from a similar discussion a few years ago:
>
>   https://lore.kernel.org/git/YNypPeoZTRiOxPPQ@coredump.intra.peff.net/

Yeah, I recall that discussion and the example.  Yes, we should not
have to crawl up from a direct caller of die() and free everything
these stack frames hold.

> I.e., this:
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index cc1163242f..f3d5eda104 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -321,12 +321,8 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
>  		die(_("failed to resolve '%s' as a valid ref."), arg);
>  	if (!(value = odb_read_object(the_repository->objects, &object, &type, &len)))
>  		die(_("failed to read object '%s'."), arg);
> -	if (type != OBJ_BLOB) {
> -		strbuf_release(&msg->buf);
> -		free(value);
> -		free(msg);
> +	if (type != OBJ_BLOB)
>  		die(_("cannot read note data from non-blob object '%s'."), arg);
> -	}

Much nicer.
