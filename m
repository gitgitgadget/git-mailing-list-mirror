Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349B23F279
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019440; cv=none; b=ZHLOP2CaxX0Vi6fPVud+qGZDuA+0azoKXWYRoePJ7er3qURJ298WPwKt9F5NFJyDdZBxbtYNd4qnWz5yYrTxKrfFBIWryy6gCNNpJZgOuFwakBYphd8Hi1VyKb0cCBKSR6EKLszEzw/+M14t1q7aoJaMP7t3HizN/eL/75VlTCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019440; c=relaxed/simple;
	bh=wo28W91gy45/qOBQWu1P2Z0AB2uO87BWPD5iON4PmmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gasE5pjNBQ2RXU12W1SVcVNKFkexavv4P3Kbnpq4jlfmVEbca0GoyylrXHMkFxZi4aq+ONsKKfm6rWMDXjFMWfn09eTzEwvtmXe1a+tet9y5VaL7AA0CvmyL83FmzGTwgU+g9Oxkd/EDncYiH1HyOT0jM3WNuqPuB0F2CTXLLuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=u8tPMefk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dlFuS9jw; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="u8tPMefk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dlFuS9jw"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id DE8BF11401A2;
	Mon,  3 Mar 2025 11:30:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 03 Mar 2025 11:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741019435; x=1741105835; bh=CoNaHO++Ky
	DX5xk/srh1oVx1hsNXWo3aqRZ4Nkkjphk=; b=u8tPMefkMWPFrlGr3l8g4+mONi
	peFS0F2akzNES8nNUeqj2SSwkKvVjSuRL99hl53SgBYJBU5bCN/ymDpxjVrK4ORG
	uFwnHn6t7NZO1WONl6TcfIPmK4s7jjNlGiz61MxykKkgJYFk5fhmhuuIUn0Wb+r4
	4I4NlWyiw8PvRunuaZOkkkWdafQs0yxeIn6F9X0h22cgOffn4RrTrtP5skN87/5V
	TK+4BMs8NCqA6gdowC0Axt67mTbbcnrYfU318ahCjMCJAZF3wvlAGXrecOn8uBXA
	c6wBRmJv0peoQjljyijDmmWS1wsTiZ6tKgzkZVRjXhIE4bMCP5jmmpi/ds+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741019435; x=1741105835; bh=CoNaHO++KyDX5xk/srh1oVx1hsNXWo3aqRZ
	4Nkkjphk=; b=dlFuS9jwdfv3/iIuB4FxT/MI7dYfEo9GBTuy7LTNblcPGouJIaI
	22lHgmI1bP3+4sI/Qje8MVGRXYkFoseGEMsn6+Da/QLl4rKLtGwBedLXDt5UDRyt
	pILRFiXrqLJy4n2fuitJGxqMshgaQfapgL2j7ePXiT/XR9zGNayhvLzgfdCSGxaT
	9lUJgC6tukcVaBjmN2orM7h6LxIBN8jmsVftpQdnx5NbioxbDa/hG2eBCLw+5z3a
	/Q6Ti+6gwrevBG05BwBV3FEvvZMUq2B9mWXr7g9JzVuEkoJZ743G4D/DFSThAF3Z
	GQA2gETnH6RGSGOic5FZ62qme6QcLuIjtTQ==
X-ME-Sender: <xms:K9nFZ2VEMGP312q34kty57moJY1-7_J1XykcyCq--yuF7gCD-KJYBg>
    <xme:K9nFZyn5EYSJ5wnck9OOeCCOh1jI2CmpLXoP7T6VFz4MShV0RJhewKfrDrezJj9V3
    DDBo0smc1jlpkM57Q>
X-ME-Received: <xmr:K9nFZ6ZErpgHD8sTPUz0eK72bptFsNM9OQ1HsYvmYAPTdwhAPfzxr8RT4bZdcuJF0IWVsOcpnDz-Hv6HZ0xGkD0O6_yuGhKmzGr2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddv
    feesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:K9nFZ9XKyxXAWAb2ANFTU5WpbSCbJHzdX7z3xp1qlXyQ9O3P3AxDgw>
    <xmx:K9nFZwl_oE5shnHq5ZZI7fh9b_gIeJJFCMLZeqYSosLayYn_gAIgaQ>
    <xmx:K9nFZyfJqhcCLMC-AdO1yuQQY1CfudKEtMWmCyFzcv9m1-6HVZwKMw>
    <xmx:K9nFZyFBAjmOcbxs8zFqXRwBq8lnSzt2XtF84Aml2q09s48OibD3WQ>
    <xmx:K9nFZ6UfgOV0nzYDr_HdplUXT0XsmqwDnvv_UFkHsZ5KeWCKyISe9Z63>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 11:30:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  phillip.wood123@gmail.com,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 3/4] builtin: introduce diff-pairs command
In-Reply-To: <20250228213346.1335224-4-jltobler@gmail.com> (Justin Tobler's
	message of "Fri, 28 Feb 2025 15:33:45 -0600")
References: <20250228002604.3859939-1-jltobler@gmail.com>
	<20250228213346.1335224-1-jltobler@gmail.com>
	<20250228213346.1335224-4-jltobler@gmail.com>
Date: Mon, 03 Mar 2025 08:30:33 -0800
Message-ID: <xmqq7c56xeja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> +static unsigned parse_mode_or_die(const char *mode, const char **end)

A minor naming issue, but the previous round called this endp, which
is probably a better name; making it explicit that it is a pointer
to receive the discovered end of converted string is in line with
how a similar parameter to strtol() and friends is named as
"endptr".

Not worth a reroll to rename this one alone, though.

> +	while (1) {
> +		struct object_id oid_a, oid_b;
> +		struct diff_filepair *pair;
> +		unsigned mode_a, mode_b;
> +		const char *p;
> +		char status;
> +
> +		if (strbuf_getwholeline(&meta, stdin, line_term) == EOF)
> +			break;

Nice.

> diff --git a/git.c b/git.c
> index 450d6aaa86..77c4359522 100644
> --- a/git.c
> +++ b/git.c
> @@ -541,6 +541,7 @@ static struct cmd_struct commands[] = {
>  	{ "diff", cmd_diff, NO_PARSEOPT },
>  	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>  	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
> +	{ "diff-pairs", cmd_diff_pairs, RUN_SETUP | NO_PARSEOPT },

OK.  We need a repository to find objects named in our input, but we
do not need working tree.  Makes sense.

