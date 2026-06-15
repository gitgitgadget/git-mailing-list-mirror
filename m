Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1753DA5B5
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515785; cv=none; b=Myf1g0HFTQo8F4m/9GgubMAPz0H4La3KWa7/6hhoX64Nz0w4LJCTyrd5og0M0Abjr1gUD/Wj28ogj03UvnAsRGTMVRYT5kiL5TX7Jwc3YjlN26yGPUADu0z0ZrwhNLcNs/cll7I1LnQcrIKOyHkLrAUeOzYsbN+XqofUT8ZuTGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515785; c=relaxed/simple;
	bh=amLFgtlHsSFZy+0BkhOYiLL5wOyBuI9nDextGD9yEik=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KhoBvkzEz7mJBzPRxYpc7Yl3Dol+e02mS7B8X5xsIU5WpUdeP+HQL7zkErjj096RX+OBjwROKWBZy41B4+HQyHZrjJp9a56kw/4JWZd5q8f61XjCRw4FtgBwZNuzz57/reoKEJEbXOqO5TOqrdMlV5S7VIJlx19t2C1k8CoNLps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=uYjdwraV; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="uYjdwraV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1781515778; x=1782120578;
	i=johannes.schindelin@gmx.de;
	bh=amLFgtlHsSFZy+0BkhOYiLL5wOyBuI9nDextGD9yEik=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uYjdwraVIiMbf9Enj0+/wdUNKa5NoYUgFoWCrWPT2fOj1KDsxsNrxAjEwhwkbd8b
	 GhboOgivmbRJXWlqlLqygZEIydseacDO3v0e0yW7v7htqbCyNtlLwg3zOwgGYZRzc
	 J9oGRlqSF7MI2VovwrdmFY0fTWFwjS1D+vscaT+Y1Vl7dsR8CShIg7FzXcDxCNCXH
	 BFUQQ5aF8nINP3G995h8OiGKZd2K2jVybBLoikQTkRsUghzt5+b6m/J381cr8e8XG
	 hfxwg6JOSEDztZx0O+xkwl7YK31ibZdsmz7UnIIH59I43tAC8xinXqmlV691/Egmj
	 rQkS/ZneHrchZThFpA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1Obh-1xDrnF0fLn-011c9C; Mon, 15
 Jun 2026 11:29:38 +0200
Date: Mon, 15 Jun 2026 11:29:37 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 3/7] pack-objects(check_pack_inflate()): use size_t
 instead of unsigned long
In-Reply-To: <aibJVSrKPCfDVXw7@pks.im>
Message-ID: <3caf123b-d1ad-5e49-7a95-027569cf62a4@gmx.de>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com> <ddb75326cde9695f1eb7bbbe77175424e6b77004.1780570273.git.gitgitgadget@gmail.com> <aibJVSrKPCfDVXw7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:Zj6NjV2VKn15LobEuIMdYEGNRQ+nILjKekEE4jSVOH5YDV11jIO
 PIafaS+2PXamlqygODfFWmeXLwC9QLNxN2a4EvU/vdpt4qMo1GNj04xJB4THlZGVqrAgaAl
 mW96x6vhFvwBTMKU0IPEIKeFDhhaj6WR5cPJNHtlbwm8HPJAknVs1j2WwI8x9eXpsuhxxJK
 hmxJPmjmvph7mCNuSIeMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PTWK/bcjmrs=;ASv4XbU+avsPd2175jtQ6xML+qG
 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
 893q4SLMwP/7fnSVPK7b5O1Nx4IR9crawOYAffi
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 15 Jun 2026, Patrick Steinhardt wrote:

> On Thu, Jun 04, 2026 at 10:51:08AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > `write_reuse_object()` learned to track its packed-object size as
> > `size_t` in 606c192380 (odb, packfile: use size_t for streaming
> > object sizes, 2026-05-08), but the comparison sink it feeds,
> > `check_pack_inflate()`, still takes the expected decompressed size
> > as `unsigned long`. The call site bridges the mismatch with
> > `cast_size_t_to_ulong()`, which on Windows turns a >4 GiB object
> > into an immediate die().
> >=20
> > That function only uses `expect` once: as the right-hand side of a
> > `stream.total_out =3D=3D expect` equality test against zlib's counter.
> > zlib's own `total_out` counter is `uLong` and is therefore still
> > 32-bit-bound on Windows. Widening `expect` to `size_t` cannot fix that=
,
> > but it is a strict improvement nonetheless: instead of dying outright,
> > an oversized object now simply makes the equality fail and lets
> > `write_reuse_object()` fall back to `write_no_reuse_object()`, which
> > decompresses and re-deflates the content (and which the larger
> > pack-objects widening series targets separately).
>=20
> Hm. I wonder whether it's possible to reset `stream.total_out` on every
> iteration and instead have a local `size_t` variable that we use to
> track the total number of inflated bytes?

Possible? Yes. Appropriate? Unlikely. We would now pretend to have
inflated less bytes, _just_ to appease a data type limitation that we
already worked around in d05d666977 (git-zlib: handle data streams larger
than 4GB, 2026-05-08).

Ciao,
Johannes
