Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D879632255D
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012636; cv=none; b=ABUhUzPq7hw1a09apQpBMYqoX/EGK/pgHAOkQIFe7vKfe/6YQ0xR5SYBm+1MKfsarCNCtine4pqXthDFawG+4O7f25EwzWRv4hKexFGYPaLBgXYNY7kiYFeoyu7TngkIF9ndien6ibuZPRKHXqM7zIyT/vUuEB19asXG0lIa+LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012636; c=relaxed/simple;
	bh=SJMhZ7w6+BLrgNjoaIwPvvLE23o7TpNB8TUDgsL7HQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j5FPsI+3ks/dXE0M2F4250tkHXL8Q9oQPyF2UVm2IcOxXVgDQyxCD2+PJRrVAspgSByNJzSPcSd5P+uRfkAg3C7dFcClNK8ad4pCj/oX4J6IgiOHGzDtjiHlXJPJ/euSt6MHUZzKIpjVoPeRegMRlUxVmrkHgrYyo57kxBSmSYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r8afyoaS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TZ1QWLdg; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r8afyoaS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TZ1QWLdg"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C9D76EC00EA;
	Wed, 21 Jan 2026 11:23:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 21 Jan 2026 11:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769012632; x=1769099032; bh=Vy27iMYDja
	DMLAaKjIUfBSSeeLBB4QMwCnZj8CieahA=; b=r8afyoaS0g0BFuXvscj/1TEAQd
	dFmQU+C0rA6Kyu+li9l16UmuPl6lt+TLnU+IlG/O7ZLffkzrH/K+zZLzNckf/H4Y
	0+D6kdNHiJ4+q+PksIwbEClZ4cfJXMxt+AgUEAU3rMlFmJEHvdTcltTNn5Xmg4MI
	LuEI4Lwat0XPckmR6n6lqbl7S59FC5OkLaIOqpCd1ktQhBAyOZ47Blagt5f8tTRN
	skgAQ0j/Jg3bw+94KWJFsChDS3V9LPLglBrvidWuHCnQNTE/TaWkNkhmS9vP1fO2
	yr/pgeRwXOhFCgrN7YjSdzt6zsuRBfP1dnK3UOBZeIPFiye8qc8r5Y0WOQhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769012632; x=1769099032; bh=Vy27iMYDjaDMLAaKjIUfBSSeeLBB4QMwCnZ
	j8CieahA=; b=TZ1QWLdgEE+iwQrviYM7A/VrhEKYmXTt1VVYyL0F4VAOjP097lJ
	vdcFbVrAHmnjE6JjebC7t6cz6orTTSZ9U9u+MJPZNzIH3267rRwpiftE5jPw6MVW
	CMszG42suleNddaAFk0SxoWhLpao3CS2I9vMaDpffoD1txsS10vOG1h9/BJPLAH7
	h0Rgg/r3ABTVclPyABTS6cQyZEAUEIKNVgzzqB3PHK+uU2NvuuzOxzq051zy7NTD
	Hf8f4HfDgAVJFMV0uZvKOwUZ4lEeLfciGQIAkAwXBfGq+v13ZXFwyvJPgrdLfX+5
	KMfjL1lHDtAvKjfrb3YLb7FwUe1zYs5hKpw==
X-ME-Sender: <xms:mP1waeQMq254zge4tsVHb_NPZYemn7SVNPO4Bi3rcD-kRbM_1mqy4g>
    <xme:mP1waQU8Zd5n9Pi48S5uKjYNb1UrzME8R0lB3TFitoITqgU_80_KkpudEzD7sVt8W
    S5XITSbPxQmSvFB1eEsy51Fcc-71Ht_QU9o3Krx_Yva5xfPnWJQ>
X-ME-Received: <xmr:mP1waQRFScOAT3cUTp64RmHVVsY_9gTyBWLsYVfQKrBkTHuTD8YmfSRaghE3mfhSYOaq9CpIvCZ7X0gzwNDE41Hgs7OOLxoJVCG6Nh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegsvghnrdhk
    nhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehtsghovghgihesfigvsgdrug
    gvpdhrtghpthhtohepphgruhhlohdrtggrshgrrhgvthhtohesshhhohhpihhfhidrtgho
    mhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphgtrghsrghrvghtth
    hosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mP1waQ38WEJwSQmIPeueCw_UN27BO7DfAqgeuSEJNHw0joWJ2tzI4g>
    <xmx:mP1waYfXcDCC3XP75F4GoUATdA36xLyt_DIFTFxi5Hs8JHaRm0UqPg>
    <xmx:mP1waQOGJZ1ly2Wu0vLQRyClqkd-u48xSQbB3tI1JUDGz7rZ6yPXGA>
    <xmx:mP1waUUq5Ve6l2t30eD-EXYLad2tnimOpLPOVleiwhqnjzvZuzpnuA>
    <xmx:mP1wadIQhzDLDqqY6eL7hYxkQxE84kaBsBbMEXxuvSFOFFUHnBO4h2qS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 11:23:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  "Paulo
 Casaretto (Shopify)" <paulo.casaretto@shopify.com>,  Patrick Steinhardt
 <ps@pks.im>,  Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v5] lockfile: add PID file for debugging stale locks
In-Reply-To: <20260121071344.GA570838@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 21 Jan 2026 02:13:44 -0500")
References: <pull.2011.v4.git.1767804355831.gitgitgadget@gmail.com>
	<pull.2011.v5.git.1768933954845.gitgitgadget@gmail.com>
	<20260121071344.GA570838@coredump.intra.peff.net>
Date: Wed, 21 Jan 2026 08:23:50 -0800
Message-ID: <xmqqcy33vsrt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I don't think it's wrong, but the cleanup is redundant between the "out"
> path and the others.
>
> Did you mean this:
>
> diff --git a/lockfile.c b/lockfile.c
> index 731cdd4944..e5d6ae0df6 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -122,14 +122,10 @@ static struct tempfile *create_lock_pid_file(const char *pid_path, int mode)
>  	strbuf_addf(&content, "pid %" PRIuMAX "\n", (uintmax_t)getpid());
>  	if (write_in_full(fd, content.buf, content.len) < 0) {
>  		warning_errno(_("could not write lock pid file '%s'"), pid_path);
> -		close(fd);
> -		fd = -1;
>  		unlink(pid_path);
>  		goto out;
>  	}
>  
> -	close(fd);
> -	fd = -1;
>  	pid_tempfile = register_tempfile(pid_path);
>  
>  out:
>
> which would just let the close after the out label handle all cases?

I recall suggesting this myself in

https://lore.kernel.org/git/xmqqbjj4hnkr.fsf@gitster.g

without realizing that this would probably not work on Windows where
unlink() cannot work correctly until the file descriptor is closed.
