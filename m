Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F18015539A
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 20:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080465; cv=none; b=Y2PcGW03yIWUct/8mS7Q1Bo/YSh041Rkx07Fx+O3x0gpwreB2v51lyne+DG09rxLN/OrcRehh8S2IT2SG65Pa5Rt8KclgTq+8gnV/VmHb/rIkBheHggwee21nXBhUs8JBI6ckn9CP0KuXqOhITAbPxbz0ECN3sumpqNBf/B3d+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080465; c=relaxed/simple;
	bh=8upNvdA31+VfMnPIBlKJo0heuahW5+XRFCBPgLObw6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOCMF1RXtdTK61aioKdkdsoEEeX2ozChNZg57OGauP97We0DhyIjnpj5ekmTpejDHm9mrHyZ4Tbx/xmRiOMZfyhJgt/V8nl0UFhAStyCo+3+FSjCBhXScPsyk9u2WusGhqvyHlpPuF3Gaw4fs6EOoieXVmub2yHLo+fx2PTTzWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=GebecLnN; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="GebecLnN"
Received: from cayenne.localnet (unknown [IPv6:2a01:cb06:114:e600:28d2:9042:8b81:c43a])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 8BFAFB00563;
	Fri,  1 Aug 2025 22:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1754080459;
	bh=8upNvdA31+VfMnPIBlKJo0heuahW5+XRFCBPgLObw6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GebecLnNKjouZg1JcgC5mYyDZzYy6UjKw3gAwb8KNfu071HiWyBUeaeBPmyDu+A+j
	 j70T6R3i8L6eGilslQKLS0bJ4B2xyySqIBDnmGTP2BX5FYIMYsjDEU3v7uz6faCs2K
	 NKoC5nopqE4zaezAuzG3mzwJ5EPrO6p1ccUtEtZRsQtYrFic/FiUQ2qmsVVbgkXQTT
	 Y9Iz2g9JFYDJFZiE/ECeIlCdEhs2vX/9vFzNkEfXorlTBEZ/qaLEsvlsh0jum9uQ2h
	 z++JMuUBtj2i/u/6fxuNFb2bgeuzwC9+5NpnJE5+6UpGRnilDdULj30k8IFKy9B/NX
	 ONPvzBfZizaMg==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
 Christian Couder <christian.couder@gmail.com>, Jeff King <peff@peff.net>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject:
 Re: [PATCH v6 1/4] last-modified: new subcommand to show when files were last
 modified
Date: Fri, 01 Aug 2025 22:34:09 +0200
Message-ID: <5029495.31r3eYUQgx@cayenne>
In-Reply-To: <87ms8jui3p.fsf@iotcl.com>
References:
 <20250716133206.1787549-1-toon@iotcl.com> <aIsQWcHf82ipHoWf@pks.im>
 <87ms8jui3p.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hello,

On Friday, 1 August 2025 18:22:50 CEST Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Wed, Jul 30, 2025 at 07:55:07PM +0200, Toon Claes wrote:
> >> diff --git a/Documentation/git-last-modified.adoc
> >> b/Documentation/git-last-modified.adoc new file mode 100644
> >> index 0000000000..89138ebeb7
> >> --- /dev/null
> >> +++ b/Documentation/git-last-modified.adoc
> >> @@ -0,0 +1,49 @@
> >> +git-last-modified(1)
> >> +====================
> >> +
> >> +NAME
> >> +----
> >> +git-last-modified - EXPERIMENTAL: Show when files were last modified
> >> +
> >> +
> >> +SYNOPSIS
> >> +--------
> >> +[synopsis]
> >> +git last-modified [-r] [-t] [<revision-range>] [[--] <path>...]
> > 
> > I think we typically list long options here, not the short single-letter
> > ones.
> 
> Okay, makes sense.
> 
> >> +
> >> +DESCRIPTION
> >> +-----------
> >> +
> >> +Shows which commit last modified each of the relevant files and 
subdirectories.
> >> +
> >> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> >> +
> >> +OPTIONS
> >> +-------
> >> +
> > 
> >> +-r::
> > -r, --recursive::

As a newly introduced man page, please switch to full synopsis style and cite 
only one form per line:

`-r`::
`--recurse`::

> >> +	Recurse into subtrees.
> >> +
> > 
> >> +-t::
> > -t, --tree-in-recursive::
> Sure!
> 

Idem here.




