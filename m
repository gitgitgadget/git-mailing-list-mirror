Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6C2E175F
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758712779; cv=none; b=ahXHRuoBuYGME0hPkyay3B/03qovd0Tl4Dp6UUb7ysGTFB7WN+itQUpKHSJOvspclnOJ2hCDRsQeTxALCdbJhCPjDMRtzVFKvXxAUklaROc8q69C325hXnOY5pOucdoC5Q9QWTYTgTqnXJSNX3NGdDG0kTIW2j7GN394p2A8xeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758712779; c=relaxed/simple;
	bh=8yXB7w3dwlHlpWSsL0rIZoloWKPDQBR4lwshGkC+t7Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lFRQjMMMPbrw+Y9VRzGDVGbzEv71CuvRKxFQ8y0u4usp7qqSufSw6BqzbxuIzaz0NlN7bcuzHVEtehgA9L5S3HWhJwR8Q3KdNX1xoPWX/WEKVdfyZMHzvMsHFJ53aUQ4YxG81GqbX4un49jmMqIrHQLthdpuhBm1t9Uln6SlWeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=dRIwIDK2; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="dRIwIDK2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1758712774; x=1759317574;
	i=johannes.schindelin@gmx.de;
	bh=8yXB7w3dwlHlpWSsL0rIZoloWKPDQBR4lwshGkC+t7Q=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dRIwIDK2mulG3YJgqCX9K/3AXLIchFWeCknhlZ+Q7AqNhFomHxQsUyWBZtR8G4/j
	 /F9cmx/i+4L/NBStC7ZenWpP+Y0qSFpvuAJVc7HcKuiGDLXezR/NSaSbR5nuCATdu
	 3hCeOyy58wa52oNvlcFMenHODVpg+NZd5jLKbmhQvwU4NU2e+tej4duSdwNQij3sX
	 vHgUpPOE55KWmSuyYGwfg8sd5xMzkY518ThjbM4K4adr5DaZ1lDewEtFbXeWmPNSa
	 RUjrdJ3Q3OGNMWvVPniFCYdUUUhuHR96opny9fwSHyH/rpJSFVE9NoeGJriYv/L5o
	 LEJ1qRgMLAVbO+UjsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.228]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8mb-1uOSDT01ll-00fgnf; Wed, 24
 Sep 2025 13:19:34 +0200
Date: Wed, 24 Sep 2025 13:19:32 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jacob Keller <jacob.e.keller@intel.com>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
    Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 3/3] diff --no-index: support limiting by pathspec
In-Reply-To: <a9cecd57-e683-4efd-9c79-5618000319f3@intel.com>
Message-ID: <35e55d20-d4aa-4b88-aa93-9192612fd1b8@gmx.de>
References: <20250521232917.2333291-1-jacob.e.keller@intel.com> <20250521232917.2333291-4-jacob.e.keller@intel.com> <c75ec5f9-407a-6555-d4fb-bb629d54ec61@gmx.de> <a9cecd57-e683-4efd-9c79-5618000319f3@intel.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:t0eiKAwqPhcia7zcNJZYXC0umnBfbE4xkjQKwYeqqfTur2ooIsn
 BuqdK+j3ceHWk+0OczeLOgoePD6X23G0e1HXgxbGiJ9oxfullkAUt4biaLQGTC1YFs+jQ2h
 XcWZUuKxM4xennzbRvYJ2BxYrIkhu3Pc2tD+EDQ93Ckv0vUNzwhD5oeAEFUgz0hJ+6PmEHz
 y6RgYYe+39ikuRiwlE+fg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iSbp9zuGUWA=;KJTl33D4pmMBdDRnBWvxvqM1PLl
 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
 3IxKNVddFKKRLwVH31EPLudECZG176/+Mr0/Q
Content-Transfer-Encoding: quoted-printable

Hi Jacob,

On Tue, 23 Sep 2025, Jacob Keller wrote:

> On 9/23/2025 7:57 AM, Johannes Schindelin wrote:
>=20
> > However, this makes me wonder whether the logic itself is sound? It is
> > not immediately obvious to me why the `paths[0]` and `paths[1]` values
> > aren't matched against the pathspec yet their entirety is seemingly
> > skipped in `read_directory_contents()`?
>=20
> I recall fiddling a lot to try and get this working. The idea here is
> that fixup_paths does some conversions to handle the DWIM logic where a
> "diff D F" becomes "diff D/F F". It returns true if both paths are
> directories, so we only enter this block when both paths are
> directories. (Which is required because we only support pathspec
> limiting for directory differences).

I do wonder, after seeing that `read_directory_contents()` has to
(re-)construct a complete `strbuf` in every single invocation whether it
would make more sense to construct two `strbuf`s in `diff_no_index()` and
pass those along to `queue_diff()` _instead_ of `skip1`/`skip2`. The
`queue_diff()` function would then have to extend these
`strbuf`s as it already does with `buffer1`/`buffer2`.

That would avoid appending the same prefix only to remove it right away
(with a not exactly cheap `memmove()`) during every
`read_directory_contents()` invocation, too, in addition to allocating and
releasing those `strbuf`s over and over again.

Ciao,
Johannes
