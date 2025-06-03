Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C0370824
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748931371; cv=none; b=bMUsWo+x4shPudtbrFNq2OQEUTWR795i9HI3felFcz7ps6hdJWVcT/+GXNYx4/cuJ8pVPkVxkPLan7nVQqlhFq8pefaAuaRAPHmSKuSkF9cNrjr1Tf1eGPyYpZaunCsMrXYHD127aES3P2qUQHxDznxjNvEJTYSP8nDLoeRs4uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748931371; c=relaxed/simple;
	bh=GobExf8nxrxWcnbiRpJ5Rd4YvFnKx+X8NgyHnoXUR3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcaAoWnSgqfQAg5lhX4zSzjr6jKdWPsHiKPBXvMc78hPEg1+RqDNX6pku4dgiijdV9lHLU1DpS9AwAuRHtzqTMprz8saj8+WLYj5GmnbZIb7kqzfOllQUn0zhYpUo07NUXcaPjEfVHFi0nHzoEGP4UgRELjekBW974CcsHK9N18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ohZDqWly; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dgfuu+8N; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ohZDqWly";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dgfuu+8N"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F20D11400CB;
	Tue,  3 Jun 2025 02:16:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 03 Jun 2025 02:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748931368; x=1749017768; bh=GobExf8nxr
	xWcnbiRpJ5Rd4YvFnKx+X8NgyHnoXUR3k=; b=ohZDqWlyUs0bN/pwSLcUGYo24p
	4YJ9v1eJCjD5rJb1ylnA3jevivyvGQTwI3X07oajDt/gNZZ/YYf/M/Nq505QCXtb
	uVurbHGbN5jBQ1eGebSDrfiXiUqxnHJe0Zi+5hkI9njcYOnupn5gyC2BOxJQgCC9
	+z6Kst3k7Gvr0yZ3UwvifrIjw7cT2jmUB1xHlh0lz+qwLd91tNz/gn+uDD8kTaFv
	H9xPyhEs4PZNpMDsiXRC6yThLr6DB07xtWYi/yzUWui/3rKi3nIBJLPrrYGLx/+v
	azJdNWN0hhpSaIVgzJbJwxJXB91R9TXhVWcMKzilZgIY+LvnfBBUGmdiuWww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748931368; x=1749017768; bh=GobExf8nxrxWcnbiRpJ5Rd4YvFnKx+X8Ngy
	HnoXUR3k=; b=Dgfuu+8NoKetFczvgRi4yZluAMGZR0rEFf30G421J8CbBqkTmLQ
	Mgy5HwCkt1T52AIS1BR0cYtqS9IhvzyvdILnk0YzU5YxIhwLKEWZaKkhd2F7xOAZ
	P5ns5H30dZjWQJObgRxnADzhHi6EZ9gwMJdn3GsZfaSVJAGN+N42FGooRFAL2Ke+
	HYxWepvhV0DZyh95Y6KV6e6/12xv+jjm1rVfXJJJWrnauIycxK4QEvbds4Z8v6CY
	iHgP/kie+zBlOB1MEOiihpPEBBfaYGikyaeIHrIKEnfRzIyxeQ13fSDx+HksxtsE
	fscU5U1CoWJlMA9mZC7zjnWxKc2OLcvpSSQ==
X-ME-Sender: <xms:KJM-aDIgFIdy3ibPHpl18K5EvU3_-MXpFvs8n-GG_ALZ059nMjCPXw>
    <xme:KJM-aHK9jOpgbJb8a53Z6AShA4lF00tzMjU-wiG_fzcwejdp7V7yO_i0fx9qFkQ9K
    RFM0o97jiGw_wRGjg>
X-ME-Received: <xmr:KJM-aLttmcic3ic2jDLZRczI-OU_4L-7Kh9vO65htrQZE9W0G-DOlMDTBA7u0uc-wAkBOAWlEcMPKqwdp0ULmZAyp_7xrEm1QI3QMh2KRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleekudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhep
    rfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrf
    grthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefh
    jedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    guvghrihgtkhdrfihilhhlihgrmhdrmhhorhgrvghssehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:KJM-aMYmMdnZ5U6zAc_-ZRrade4AcL0Eaiih7zkzH-HCdrnOqsAfbA>
    <xmx:KJM-aKYqj1GIC2cUVwBond8lz0-u6xKR22DP-Sf_1G0eDdWAmKP-PA>
    <xmx:KJM-aADpNCDsliWftgErcBy0ey0Mjlr62ft69StOSCDXOqocMPxfJg>
    <xmx:KJM-aIbGen7uabNoL1dpPX-dXB_j1rsnIqpT2ois--4X_mIVh78NYg>
    <xmx:KJM-aB0pGT3F2Sr9VimyL-IBT-5qI1uNoNvFKA_ohqtkrx9x2iPK6J6K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 02:16:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c77eac0e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 06:16:05 +0000 (UTC)
Date: Tue, 3 Jun 2025 08:16:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "Derick W. de M. Frias" <derick.william.moraes@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t0200: replace 'test -d' with 'test_path_is_dir' and
 'test -f' with 'test_path_is_file'
Message-ID: <aD6TJLuuaZmiFUvZ@pks.im>
References: <20250603053137.66249-1-derick.william.moraes@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603053137.66249-1-derick.william.moraes@gmail.com>

On Tue, Jun 03, 2025 at 02:20:28AM -0300, Derick W. de M. Frias wrote:
> From: DerickWMFrias <derick.william.moraes@gmail.com>

There is a mismatch between your name here (which would be applied as
the patch author) and the Signed-off-by. These two should match.

> 'test_path_is_file' and 'test_path_is_dir' are modern path checking
> methods in Git's development.

We typically want to provide enough context in commit messages to state
_why_ the replacement is better. Them being more "modern" isn't yet a
sufficiently good reason. So it would be great if we explicitly mention
what the replacements bring to the table in a sentence or two.

> This patch replaces old 'test -d' and 'test -f' methods with them.

We use imperative style for commit messages, as if instructing the code
to change. So instead of saying "This patch replaces", we'd say
"Replace `test -d` and `test -f` ...".

The patch itself looks obviously good to me, thanks!

Patrick
