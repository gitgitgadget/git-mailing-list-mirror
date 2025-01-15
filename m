Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99F41CAA72
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736978198; cv=none; b=ULA1dhW6NoJMdbW9LIfTrH854k8bBb8Nq2OThs8hK58/t3WuQiuR9umGxhyJYm7zJ4OA0Nbb/4NIJdf7dA3ifa5E1X4BkIiQ4wZY+JQVObrLkMoGdMtCEEsr2obQq6tKzrxb5KZSgvdYn6EWXPEr+IYHwZMbeAJ8JXXGIKuFm/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736978198; c=relaxed/simple;
	bh=l4z258nIq7zCjI9avsJ1OHMMV1T9MjbUaubnNCeRekI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZovriFoRKN/3QiekqV/FDwAS3xpXtvTlqqR6Yxa44SvsIpWAPOql/FbuMxlULSdQQavOX92//mqCS7FrkJJlTxuz6ZLAkyevCR1rbkaxcnt7/N2OVW+sv4f+Q/dHUYc+XS7OuHzaWqUQvhDP0QpRpUun/7AMIEqu2z3S/zwk7Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wf07pR7h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SdzqywuH; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wf07pR7h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SdzqywuH"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id D6BD611401AF;
	Wed, 15 Jan 2025 16:56:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jan 2025 16:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736978193; x=1737064593; bh=geFieNRqxx
	PvsXm2VQ0+pFq1ArHPJXwbKik2RHp2+e8=; b=Wf07pR7hv+8Womxrwpr7NBzrcF
	+wdYuvf9f1muzoTYq7lMaoPTzw5A4VeqDgcopeAQY9gEvBfvkhBLMK/pmcjHSa/K
	Q5ugMWtDMjAgVit4kc3pLXvx4iV7kKfh9FQjEKKFn/QpygxOkXYAnYGqarPrIJzD
	nsOvzkhppt1Fj+Xe1rhs2md+bXHDJy3aBZwwveh7rQr+7h5scZlUTpPM9MXN9Tfh
	JcjPINFJFYGMsISzT2Ee3j1xs222dECgNezqpP/nWrzLxtpnBF8qRXxx6Wp6kTML
	oiHKNNtH9DfOJ+FKzPjaDPNVREU2frClkq8hZh/0taLVZn0lRRNmbblIFGcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736978193; x=1737064593; bh=geFieNRqxxPvsXm2VQ0+pFq1ArHPJXwbKik
	2RHp2+e8=; b=SdzqywuHdFbtMmxyfPpCYHom+7w52iV3gQGeeR2iLLcUSN8fEgh
	51iuJhot3BVCJjRurUVp3j85YoTdgPFZr5pR4YzODPYe616iFGdEnRW4SHhmRxdK
	Qfca0dur3Xgad5oo0wHLl+ldTEAlcxfjs964lwyCtjBDIJ9y/2Q6ai/5nPS0V4fY
	HoGSx+x5am2HMrqY8IDzM9ow1SSjEy2GXucOdlKGxZQIOj51EwVL2vi0h5Cx+vQ3
	H87X60l8O1UVfD7lkg7l4/zMYjRNzRwWd9DoE5mgvntxzAesQIgkXl4CkGKN8Z/1
	qBvFcWA9C2ItOBj+30vGr/jK71nqsxVA05A==
X-ME-Sender: <xms:ES-IZ1_6u51dyR8vDu54LjFueuXj-XW82QQCbOfH44Th-X7WaeYDOg>
    <xme:ES-IZ5sQhYWfz5MWoWTnNIjuPkwKZu3y8ZmpNWlBPOzE49MLgizEriwsg5kUKPK9a
    JXziKg1blBOAOGkzQ>
X-ME-Received: <xmr:ES-IZzCs1xY2VkDkmUzQDS9X-oxEMDtxMEXXPTAC5Mi3sC8KAXJCDpi2LhGW0YTztDMGGOqaKpmexv4E_opndZBpEugHfOpnxzNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehledguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgtvghplhestggvphhlrdgvuhdprhgtph
    htthhopehjohhnrghsrdhkohhnrhgrugesuhhnihdqmhhuvghnshhtvghrrdguvgdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ES-IZ5fcqh8936xYyXFhCLp2fXvNV4sc0GaulQGidspTTDXrstq-yw>
    <xmx:ES-IZ6NaZ4e98dIjXQKxZ1iNT-xpFHrh3KpBi_vyMaYqlWI-bMwswg>
    <xmx:ES-IZ7mlmusWspH-eG4Cjf09lr1lBHRpkgBFU-W5k6Fc__3_kN7o0w>
    <xmx:ES-IZ0tX5uj8BvdYBe49-EWig9PM4Y1XFO__MxwBLNSxSg38pPCJLg>
    <xmx:ES-IZ2C1KEMNyJDtqlmqmmZG0hY_cpXJ_V7TZh5jeW2Wl36eccPWamIC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 16:56:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Ma?=
 =?utf-8?Q?t=C4=9Bj?= Cepl
 <mcepl@cepl.eu>,  Jonas Konrad <jonas.konrad@uni-muenster.de>,
  git@vger.kernel.org
Subject: Re: Git branch outputs usage message on stderr
In-Reply-To: <20250115212952.GA96537@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 15 Jan 2025 16:29:52 -0500")
References: <04cfaa3b-847f-4850-9dd6-c1cf9f72807f@uni-muenster.de>
	<D72M6S9O1E9F.WVEBV7ZJ1JTC@cepl.eu> <xmqqed1414gt.fsf@gitster.g>
	<c92e7b16-b70d-46f3-9858-2be805c5285f@app.fastmail.com>
	<20250115171423.GB57018@coredump.intra.peff.net>
	<xmqqmsfsx8oo.fsf@gitster.g>
	<20250115182419.GA86610@coredump.intra.peff.net>
	<xmqqa5brydz1.fsf@gitster.g>
	<20250115212952.GA96537@coredump.intra.peff.net>
Date: Wed, 15 Jan 2025 13:56:31 -0800
Message-ID: <xmqq5xmfyc4w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I certainly see an argument for exit(0), but whatever we do should be
> consistent with how parse-options handles it (since whether we use this
> or leave it to parse-options is purely an implementation detail that the
> user should not need to be aware of).
>
> And it uses code 129, even for "-h". I don't see any explicit rationale
> for that in the history; I think it goes back to the beginning of
> parse-options. It happens via the PARSE_OPT_HELP flag, but curiously we
> also trigger that for ambiguous options (which should exit with error).
> That might be a bug-in-waiting if we start handling PARSE_OPT_HELP
> differently.

Here is what I have as v2; there will be patches that touch
builtin/*.c in between and I expect that the last patch to conclude
the series will end with an update to parse-options.c (to exit with
0 when asked to give a help) and t0012 (to stop expecting 129).

--- >8 ---
Subject: [PATCH v2] parse-options: add show_usage_help_and_exit_if_asked()

Many commands call usage_with_options() when they are asked to give
the help message, but it incorrectly sends the help text to the
standard error stream.  When the user asked for it with "git cmd -h",
the help message is the primary output from the command, hence we
should send it to the standard output stream.

Introduce a helper function that captures the common pattern

	if (argc == 2 && !strcmp(argv[1], "-h"))
		usage_with_options(usage, options);

and replaces it with

	show_usage_help_and_exit_if_asked(argc, argv, usage, options);

to help correct code paths (there are 40 or so of them).

Note that this helper function still exits with status 129, and
t0012 insists on it.  After converting all the mistaken callers of
usage_with_options() to call this new helper, we may want to address
it---the end user is asking us to give the help text, and we are
doing exactly as asked, so there is no reason to exit with non-zero
status.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c | 10 ++++++++++
 parse-options.h |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index 33bfba0ed4..8a8b934e67 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1282,6 +1282,16 @@ void NORETURN usage_with_options(const char * const *usagestr,
 	exit(129);
 }
 
+void show_usage_help_and_exit_if_asked(int ac, const char **av,
+				       const char * const *usagestr,
+				       const struct option *opts)
+{
+	if (ac == 2 && !strcmp(av[1], "-h")) {
+		usage_with_options_internal(NULL, usagestr, opts, 0, 0);
+		exit(129);
+	}
+}
+
 void NORETURN usage_msg_opt(const char *msg,
 		   const char * const *usagestr,
 		   const struct option *options)
diff --git a/parse-options.h b/parse-options.h
index d01361ca97..6af4ee148a 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -402,6 +402,10 @@ int parse_options(int argc, const char **argv, const char *prefix,
 NORETURN void usage_with_options(const char * const *usagestr,
 				 const struct option *options);
 
+void show_usage_help_and_exit_if_asked(int ac, const char **av,
+				      const char * const *usage,
+				      const struct option *options);
+
 NORETURN void usage_msg_opt(const char *msg,
 			    const char * const *usagestr,
 			    const struct option *options);
-- 
2.48.1-187-gd93ffc6ef3

