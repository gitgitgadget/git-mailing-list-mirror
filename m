Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04932CCC0
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 06:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757831901; cv=none; b=BdTrrXlJwAORjqlmNTAeTwFoC6rdHv7zx372L1j4ybqYlKxath7O89VjcRo4Zc/s4WkO5jq+QX4oTV+4fpp9rBXRaDKqOewutk8799DnS38bUzaxSMXCafuyGZ3eFRNLRcSxWrx9QAZVNnYFf6/fxzA7JHNPjGmiTpiOhGGmq68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757831901; c=relaxed/simple;
	bh=z5Qm7a7hnEE39K61myvPrlEhKjysvUbVFrq64EAEUw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xy2UDd+PQRzffPxW3oL5/IUZV7Ke+umU0CS2s5T5kwZ+TiuHzDZp/KDzqxwDU5QuQeQ5BVq6vzy/zSsZdk9zit42fYLWYnLYyN3h9/TLf2aN1b6SsIqgAW4sJApNKmm6xqD4ulI1/GkVIB/0TvQEZbxC1DyX/OqiYsR6N+RyxYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mUqa/0ac; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R58KK7ka; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mUqa/0ac";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R58KK7ka"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9CD91EC0084;
	Sun, 14 Sep 2025 02:38:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 14 Sep 2025 02:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757831897; x=1757918297; bh=poe5+7FYrH
	BUcO3d9h0DS4C3AwUTYjihFWzCYePXA6s=; b=mUqa/0acnQAl4TG3wdMT63g6X1
	LII60hx9dG+2nmWtHKnr/t3FRBytcgBp5KDl6E3bkEtqWeWga06/9AIFsBAy8cc7
	aWvdkDmDMdn3uNnm9q2r0bKbe92KzXzEWfaVONxN7pVYsa0FJvnpM2swdUSuddQA
	il4T1dHlUw0/pSrvW7yvEiI85HDwdNznIrlB61A3oVhacGFJ5s9cG6G53CwWb465
	sWH8G+radYGCuea12iOKzRrKPDMayUQWbwoBZ8nt9MTfBLP+p13r8/fZhsVIF2m6
	GsMJscjXeu/My1VuOFwgenxy4E0V64ogmRMCsxtNzdvxc6/T11EAnSziguDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757831897; x=1757918297; bh=poe5+7FYrHBUcO3d9h0DS4C3AwUTYjihFWz
	CYePXA6s=; b=R58KK7kaDBtXDE1b6afLFS+whF86TMvdJqFLGI1G17o8ExV4G1S
	Pe9aU2cPfzoHEgkCq8PO8hqp9MkYFHVb4aDeeG/tcgXAQfGqN+Ei5+AaJCFVCM20
	wuj+Bc6KqGQ5I59W1nt4mp0c004gsc4kgawnIIzoD3FwvhmWPuKvnqrB0B8Vfopr
	cnA4glCbqw17SG5E4F1DuJCxJWNCxjJ31bFaRoj2ZGESvtfPZaZlgaYXbYmipEtL
	c9WfQZtrFfWYhVfaP4wkHyaeiY5JxRDSDQUkmHOTDg5gUkqwRlWvbziyNtzZtgQe
	zbY/3k0uLdTSph5lNu1Yjs6XAOpD3/L6drw==
X-ME-Sender: <xms:2WLGaJH3fm7ud1ag-ea5mwvoow-gbxn2c9rNA7kM0ruQenqnfFcfiA>
    <xme:2WLGaI68EYR1kPa8DDkYnwzWZktKB7BVoVC57CTGa7nVurkLADPqIjnJiMKGBt5ff
    ftUKZ7M-mxPaYGf2Q>
X-ME-Received: <xmr:2WLGaHvq_Ppb92QM0O_oyPJMroPViFeJzXok-NSuPbUftpkOZ3dYF3ZUNZ1LXJrt6OnDj2QPuk52W1Ydm8lhBU8WfwdMUwEwf5wWPWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefgeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhssggvtghk
    vghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepjheitheskhgusghgrdhorh
    hgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2WLGaB6O_5hiSyDm-N5wNDg5LtjZJlj1IeRlVWcZZ66nMUzgR6ApqA>
    <xmx:2WLGaKXEvBRqTnAcTadRuHmd7Fg-hS0_92Ep_yLZBG5hwY6D25nE1w>
    <xmx:2WLGaL8LE1OzA0tSd67WVPkPs9hyJ-4WKoX1vmCeWWJWfGULWbcuoQ>
    <xmx:2WLGaOmA6gw5wKz7V0tRymGPr0XJ6BYnAASgxFvyqwQfE2RfqJMpWg>
    <xmx:2WLGaB_miujcf6yttXliUasJQLmjWDPe7Q3T5W2-2-1X6hYLI8_3t0zZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 02:38:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Johannes Sixt'" <j6t@kdbg.org>,  <git@vger.kernel.org>
Subject: Re: [QUESTION] mergetool environment variables
In-Reply-To: <004101dc250d$18173950$4845abf0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Sat, 13 Sep 2025 20:18:22
	-0400")
References: <074901dc2422$2039a910$60acfb30$@nexbridge.com>
	<a5e01f0f-1789-427c-83c3-90644fa234c9@kdbg.org>
	<000201dc24bc$a1b8d9d0$e52a8d70$@nexbridge.com>
	<9a03a436-8240-4566-9383-7afbf740719e@kdbg.org>
	<004101dc250d$18173950$4845abf0$@nexbridge.com>
Date: Sat, 13 Sep 2025 23:38:15 -0700
Message-ID: <xmqq8qihk088.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> Yes, it needs to be in the git install area. Adding export BASE export LOCAL, etc.,
> works to resolve the situation. I wonder whether that should be documented.

I am not a mergetool user, but I do not think that is how the thing
was intended to be used in the first place.

The documentation that may talk about variables BASE etc. (not
"environment variables") are meant for those who add their new tool
to the existing mergetool/difftool infrastructure, which means that
their tool's definition must be dot-sourceable just like any of
these tools defined in mergetools/ directory.  You'd add yours
there, mimicking what they do, and add a handful of shell functions
to be called.  git-mergetool--lib would then use

    . "$MERGE_TOOLS_DIR/${tool%[0-9]}"

inside its setup_tool function to read your definition.

