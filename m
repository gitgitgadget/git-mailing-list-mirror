Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B907827144B
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753423257; cv=none; b=DBveDXS7xpL6OTtoZSYQ2BsmlJYzKh742ezpwesz6BmQhcwRiKjlWshlnDBEvGsKw79UdUy8h9/enexC9PD7qLTjHsUfF43TzNKVtgA/QiLYsMUdcLkrIan4mzsbEajGP5zWkGQjkfwLxbXiy2J5Cg1uXzcYSQop41Bv4AN6yfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753423257; c=relaxed/simple;
	bh=SULhMzljGsf20gbT/EjSBKK81antUSIykiaq9a88MH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i4j9S/Tfs/8guxB5PuCUemgxG+VkRefM661w2oWWV1uFTnpUa0iyfLcDIltTc+/HDFoMgdT6GdF+GzNUocv3Wb4SUrkEXZy4VFb5lSmrxuWRw5dTxY8gzs8Bc1IzK6SHDLm7Zb9tQAXOfcpUbN7LDkaKut8GSzHq7rr/7DWbg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arnes.space; spf=pass smtp.mailfrom=arnes.space; dkim=pass (4096-bit key) header.d=arnes.space header.i=@arnes.space header.b=DoDglM2W; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=arnes.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnes.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=arnes.space header.i=@arnes.space header.b="DoDglM2W"
Received: from machholz.uberspace.de (machholz.uberspace.de [185.26.156.167])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id C3C6A60ACE
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 08:00:24 +0200 (CEST)
Received: (qmail 25474 invoked by uid 990); 25 Jul 2025 06:00:24 -0000
Authentication-Results: machholz.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by machholz.uberspace.de (Haraka/3.0.1) with ESMTPSA; Fri, 25 Jul 2025 08:00:24 +0200
From: hi@arnes.space
To: Junio C Hamano <gitster@pobox.com>, Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?=
 <michal@isc.org>
Subject: Re: git-diff: --ignore-matching-lines has no effect on the output
 when --name-only is used
In-Reply-To: <xmqqqzy6omul.fsf@gitster.g>
References: <87a54v8nmz.fsf@arnes.space>
 <12095AC3-BC38-48DB-95B4-394F9F7DE054@gmail.com>
 <xmqqqzy6omul.fsf@gitster.g>
Date: Fri, 25 Jul 2025 08:00:23 +0200
Message-ID: <87v7ngstc8.fsf@arnes.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Bar: --
X-Rspamd-Report: BAYES_HAM(-2.036654) MIME_GOOD(-0.1)
X-Rspamd-Score: -2.136654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=arnes.space; s=uberspace;
	h=from:to:cc:subject:date;
	bh=SULhMzljGsf20gbT/EjSBKK81antUSIykiaq9a88MH8=;
	b=DoDglM2WQUr87TyV3a1DTybfMgFpDR0koILh8rfO46NI0PsQBQROEx2I4nE/YMl5bImSg8x7OP
	G4oQnCsY+fxHE7pD4+aEtYh+K/PfOPYMzCphbu/PA0EKvCp+wvvolVoeakbClUmT0VXNdsNLlZM3
	cqlAE3GAp4xQ27yoJL6Ccuh3sy37bnAUTiMZwBnxND8x3tXeMX2SmKNCcCc4VSo2uFOlO+1p8n5K
	usqzSsxoQNO7M9av2ZpD68aYYX/DU+ZAlnBN46AFWWbPO7Js9MuqndVw+3t7cwaArp/gOpsCBBoY
	Oeh/tQ+wMAhG1IFaCakVZ/zHa7j0Ra83+PBqPOqQYJLVNHbAPTDVrXQNnXAcgLjjkOv8EDu8z+Cw
	nPtnzGrkTAsPTH9l3Ksq0J9u9WNxO16CK3z1wgcf9WZIEJC9EECeWJip2tpAhnTjycT5/TQH5mvW
	fQF+yuePXiTdd6sg8GcbMBETXzyH9WmrlDp+1LxoJwEniCX9OFvADSTQkkt9DFzoPMxtQ0MycgwE
	g0oRPV5gHiDFrdhdgEzy7soeJUsxoh/JHRGI8P/lTTCU/YwYdsA+//0UPpYg8mVojOvtfWC68iFy
	TVekvhhg7I0msQcxD5gwd1eXIADHTYiQyxFhXgoKT2v0/BZ8b5n+AY/65BE3Gz7VY1Fr4EEHu0tI
	c=

> it does not make sense for the answer to be different depending on the
> presense of -w or --ignore-matching options.

does it really not? i thought of `--name-only` as changing the
formatting of the output, as doing something similar to this:

git diff --no-ext-diff ... | grep -P "^(---|\+\+\+)" | cut -d/ -f2- | uniq

a file of which all changes have been filtered by
`--ignore-matching-lines` does not show up in `git diff --no-ext-diff`.
at the moment it appears like `--name-only` puts it back in.
understanding why that happens requires internal knowledge of how it is
implemented, and to me at least it was surprising. nniSell Ikea Eneby :review:



Source: [[notmuch:id:F936E930-D37B-4E1A-AF3C-47FC153B4E74@schlueter.is][Original mail]]
