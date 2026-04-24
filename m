Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4490E4D8CE
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777070829; cv=none; b=jAvETyu4IDSeUZ3Qj6aeXmR9Wp2P49/hOT35m6vXoLPgaEuhoC9mmamjUxB+EenCpTcXaeJaAqaScJLCiktxYkfZNIz/moWrLUpT++kKpvEp4gJUmtEVOGuy1PB2NGulqgLjOa1Lux0K9jfAXxIQaoMmUBi6K9ooaqMP8tuK4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777070829; c=relaxed/simple;
	bh=TE3UmBIDwFSnIFsL4BWQopLkKTDY0W/uI0TNCCodwxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kHJkcIdjnmsGyvDV7bSxqDkUVp36Ra7Yq3CqwIBg36q3GyHgxc6Wfrz3v8Tgasp5Do2iDerXbG4Zse0Wy0qQ+AdnMplH7F8GI9ovuhtK5ic/TF4Bqe0e1F7mg9YHgj2zo4YvAhpPZrj4YB9WPcqKCxiqxURZgha/V/BlGKxekl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pJ0dLNpA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tFneVK7v; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pJ0dLNpA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tFneVK7v"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 54021EC056C;
	Fri, 24 Apr 2026 18:47:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 24 Apr 2026 18:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777070827; x=1777157227; bh=WfMfVNoH9s
	9x+ncioYMMUse1HxOTJ/x6eWaBbfSTp40=; b=pJ0dLNpABYHfRnIyW1Vb/i4hhm
	jGSUeRMazMXhKmfjbpt8BUfT0eKmJcqcWT0zXtzDPzZRVxE/yet3i1E2Z6mdVgM0
	JfcZpU+JWpXrk3aIe+HoPX7OpDBQikielmchuBU8f2PXk7I3nL3TZKBjSCm6Zpg8
	bu7ZDz9u7UFnQxb57FcnpFaWBAhzrqtA58Got1AIVKrt24RJ6w+x91GvUmDbD2AN
	G1kHygqnjUAxQb0tzXHPSaLupX5gYAjpMfnyjjSFnUBNN3fW8GrVSJmaBXb5diuA
	KjC0/uMPx9jWU+rO308ZtllTCumg9ycDxK4ZanvNDC4zDFDGzxLuzH2hL7WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777070827; x=1777157227; bh=WfMfVNoH9s9x+ncioYMMUse1HxOTJ/x6eWa
	BbfSTp40=; b=tFneVK7vBqv36/4N+v4UPLmQijAVN7KyQxE/c28Nw9xwq929qp/
	6f62/G1AbbCJ9dpJDikORQD86bLeTpyzeVZdautvyl2ONJ2gevY0/cScTjP/8ES9
	vzkJyPMIItURRTDZdqQHNUuExZ59x8cvheL+y9A2TNOrBuL2DzOEwfK0odqD6EQH
	BRPadGwI5/1cqU0QMKWIRWP0DpR+KiUjStBTyngg4LJReR4ITqQL6uork4QKRqAQ
	ZZKiGoHF0dHCz7nPNi7ebB06+kgn3eegZu5C2TJRJCnAqLnErXVGUtezcnrxzRJE
	gW6DlSiPBiXWt1xng+wfNmWf4Kp5pjLIwig==
X-ME-Sender: <xms:6_LraQpjhtFPS_oGzN3LIkjj-14-zUWRTR7Z3Fw_2JrVsLtOO2b2cA>
    <xme:6_LraaVo3OO8F-ag_7E4zpBa69Q9KwglMzoVArftAvWuiurFgHP86zUH4NnPKsZUt
    8ZzDhvg7FKfgRWROF_LLYMSK26hdC1T6rX5DgZui9_Gjh6Rl_yombQ>
X-ME-Received: <xmr:6_LrafAmvOGgVGpuGc5xU2mDm-7w-ueMAQhDbn_b0Wovy5kGRvGlsZelGmAv7A3v7WlP8HyLZ7Zzd1bRh2VbaShiDUyRISG4ZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejuddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohhnrghtrghnsehjohhnthgvshdrphgrghgvpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtoheprhhstghhseifvggsrdguvgdprhgtphhtth
    hopehmihgthhgrvghlrdhgrhhoshhsfhgvlhgusegrmhgurdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6_Lrae2jRREO37RxE73R8ow20U6tvWn9LZY3IVZkwM58Vfxv_YgMQA>
    <xmx:6_LraR2J3_ZGGhTfYvnQBQ8J9bG0vsfS8uRoIHbNBS3bOH4Ha6LdMw>
    <xmx:6_LraTCOSQ4JNyUBPJZROya1kOSPgREWU1srr0xr3JOJNOoWI-bRLQ>
    <xmx:6_LraQ4hWe2KMWNFaNut5xqmEUM_T2SW_QTjbNF0Z2dqFz3k_pcBxA>
    <xmx:6_Lraf1KCI_pLBDfq1-DveTgHja0ZRa8heKuyW6Qzbu7oz3MpTfjQh4H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 18:47:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org,  peff@peff.net,  rsch@web.de,
  michael.grossfeld@amd.com
Subject: Re: [PATCH] alias: restore support for simple dotted aliases
In-Reply-To: <20260424151053.917066-1-jonatan@jontes.page> (Jonatan Holmgren's
	message of "Fri, 24 Apr 2026 17:10:48 +0200")
References: <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
	<20260424151053.917066-1-jonatan@jontes.page>
Date: Sat, 25 Apr 2026 07:47:05 +0900
Message-ID: <xmqqpl3ovuvq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonatan Holmgren <jonatan@jontes.page> writes:

> Historically, config entries like alias.foo.bar expanded the alias
> "foo.bar". The subsection-based alias syntax introduced in
> ac1f12a9de (alias: support non-alphanumeric names via subsection
> syntax, 2026-02-18) broke that behavior by treating such entries as
> if they were subsection syntax.
>
> Restore support for the old dotted form by falling back to the full
> name when the final key is not "command". Add tests covering execution
> and help output for simple dotted aliases.
>
> Reported-by: Michael Grossfeld <michael.grossfeld@amd.com>
> Helped-by: Jeff King <peff@peff.net>
> ---
>  alias.c          | 16 ++++++++++++++--
>  help.c           |  9 ++++++++-
>  t/t0014-alias.sh | 12 ++++++++++++
>  3 files changed, 34 insertions(+), 3 deletions(-)

Do we lose the extensibility introduced by the new syntax by going
this route, though?  I would imagine that

    [alias "frotz"]
	command = !"nitfol"
	help = "run nitfol command"

would have been a natural first addition to the current system to
give help text to the alias, but this change makes such an
extensibility impossible, doesn't it?

If this change robs the extensibility, it makes mse wonder if the
three-level "alias" was a mistake, and we should have instead
introduced a new "nalias" that is three level from the get go.
