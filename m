Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6413818787A
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445946; cv=none; b=CrcTjUIdEgOiIS6giYFBh4ajqK6SPl5LcgasnKwUPe4GD8rhneP67+xi8g+9yXGpX8xKDVhAUhvEPGwxfGAQSgEMAefHNo+NIR+6BIsou/8C1PCg8X5ON3NCcYEBxcjUGpDEBGwebHFcRGCRPpRUWvK71g/HhUf0U/Ap4z682g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445946; c=relaxed/simple;
	bh=iwd8y6JUzBTDivc3nAG6InICgvjUMyEKSrObmq4ukAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BXJZHqyUsROXvjNgUVY3BwFRA+AIgKvjFtR6nkb8f1hVkpAkN03RIFB56BDhFsAdsMDPHBBontzrvhEYAxe76BShSyRyJXJ59gnlWbeUexwdqKtZ/CscQ2dKJhaRd1IAKiCyGaRsrGllIEhupI+u5cD0ECMjMABJA3J/2jPWldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NOML6cLl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x6DjuG9H; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NOML6cLl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x6DjuG9H"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 65698114007F;
	Thu,  9 Jan 2025 13:05:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 09 Jan 2025 13:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736445943; x=1736532343; bh=hgJGD9E8KD
	DfWIdE0eP0Am6WtrFyeqZm5npypMEBRCs=; b=NOML6cLls7z6U93uIeHGIW512U
	WsOQHyAq5VQFW4idkgf+YxxdSmEMk9yWJZTcm+AM3RE+belZ8nSTf25ZOw0w8Qpn
	EsKsnZPZ2xR41zKDr9x8aZHmY23ecgD1GAxIPcv3b6eycFWpzybbgNuLIiWcsUrv
	EyZipvWx8c1MFMgGUqRcQ5rq/g/vv67eMcPAxUgnjJMKTQrnRDZKQVCs7JTN44qL
	kV301C1JoyfCr4e5EroP0OgoBd28mEiJtsb+FwYlLzy9PqIsY5ny802JmtQ3E/iD
	Bdb5tsWqNXmPo+QiBu4Sh8kcLpAC1ksFIbcUkIdTv1iUjTbU7k+yP/OcgYZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736445943; x=1736532343; bh=hgJGD9E8KDDfWIdE0eP0Am6WtrFyeqZm5np
	ypMEBRCs=; b=x6DjuG9Hry7rpaauzidyRsm5kiMk4nazJHJepioFb5CYbLejE5a
	DdYjkxRo3EnSgrouVRs3nhP3SYVcCQspLd0BG5GrDxM+TtysE9oQ+N6heiqzqWru
	We+YzBrTTGo8itMxff2gU3VMWWQuckxsyCKEOrHblgy3Jkg4mYISfLYBfxI1LF/r
	2uDSdxfyd3UE826AqL+1V49jHLvO/Qt2gUGNFUQIvTgSiOrzO0c4cr9YHhpaLSTz
	VFZ86EcOo4B/q3N6jGc560YmR0ptWPLBv74RtCKa3IxRuAquH8BtgpXSJ9BJh3BU
	Si1lqaXCRQC/QuoRW3zx64QCtk3nq4ZQ7cA==
X-ME-Sender: <xms:9g-AZx9G_uJut7PRfgTyKOBk2ZUMxqO9fpKb0zGzccRha49pkq5pvA>
    <xme:9g-AZ1vRzeelZ_yBYC38EcB5ERkSQtb05FH4WO9OI0YV7lbOBCDU7JUTlKwS-g5tp
    8TeE_2ijFIXone0Zg>
X-ME-Received: <xmr:9g-AZ_A9_n1iYB15eWrFg8XSt5an1pPJptwM8u8AXfEK_asNTCvXAxm0uG_s4d--bjsdRQ40YgvoBUpTEbeNZvZNGQXxbEoRPYVX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopeifihhnkhesshgrvhhilhhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9g-AZ1drCY8etZzI0QYb2dJurGrjYW0fdQ5xfCRnD-q_bdZS5wL72Q>
    <xmx:9g-AZ2Oi6v_DYm0lt_aAq5EOsFB3ORSvck_14UCC3D7d9qxwtvIGVw>
    <xmx:9g-AZ3my9tIpMGWEMoXYz6dtX9SZFjReVH15umG761CkEuYbgxSz0A>
    <xmx:9g-AZwtFjF9EjBhiojgXGnLtv45YNPM51DTaCs5MfrnZD-H7A0Vvyw>
    <xmx:9w-AZzpKf5Rdckrug4kgFcWL42bsGneSyvpXSRWyy91uRCgpitu9P_Y9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 13:05:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>,  Wink Saville <wink@saville.com>
Subject: Re: [PATCH 02/14] combine-diff: add combine_diff_path_new()
In-Reply-To: <20250109083236.GB2748836@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 9 Jan 2025 03:32:36 -0500")
References: <20250109082723.GA2748497@coredump.intra.peff.net>
	<20250109083236.GB2748836@coredump.intra.peff.net>
Date: Thu, 09 Jan 2025 10:05:41 -0800
Message-ID: <xmqqseprj216.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> +struct combine_diff_path *combine_diff_path_new(const char *path,
> +						size_t path_len,
> +						unsigned int mode,
> +						const struct object_id *oid,
> +						size_t num_parents)
> +{
> +	struct combine_diff_path *p;
> +
> +	p = xmalloc(combine_diff_path_size(num_parents, path_len));
> +	p->path = (char *)&(p->parent[num_parents]);
> +	memcpy(p->path, path, path_len);
> +	p->path[path_len] = 0;
> +	p->next = NULL;
> +	p->mode = mode;
> +	oidcpy(&p->oid, oid);
> +
> +	memset(p->parent, 0, sizeof(p->parent[0]) * num_parents);
> +
> +	return p;
> +}

OK, I can see how the structure is laid out clearly in this code,
but I have to say it is one ugly hack X-<.  At least with the
refactoring, it becomes much easier to see what the caller is doing.
