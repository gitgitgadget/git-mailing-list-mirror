Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7145C1D5CD4
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737700603; cv=none; b=HEM4a9t8D8omNc1LY5JYTfbbHDNobfBVg/SkqQJ3z5qujjxPzda/YgZi4Y1ZXEnTkPnbQXKRkCPOxDFNXoycRGzRlh7J1qY8Lr6DikqN+/61/dYgWZj/1UGdF5YXkLMhaxtPwnFJIAsiZndtCbzehqv3rfGWuHippYmaL4zMLQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737700603; c=relaxed/simple;
	bh=DHJf2ZzQUmPe408aaYTJaE17HNX8k7wzskzvIV6EyKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBAB1TIIPB2Zzq3KO4ncF/GFot5OySX6914kiPNNGsi6yNyH/E8geS8vwS2S+PwW8l8NDY2hznEEwcReVgVrknkaW83S7SN0TWUOp5rcwl+mK3YOgPORec/mfp1RYDyI8GluIrpUfr+uCmXNeuyrjKVqFOxqnqIxHArG1SY/jUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VAB0xKhk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j31Aj81d; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VAB0xKhk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j31Aj81d"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60D5F11400F4;
	Fri, 24 Jan 2025 01:36:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 24 Jan 2025 01:36:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737700600; x=1737787000; bh=mxMsBJi04k
	eMzrh65uelnZEckyEsFUItCZ2/kYPM02U=; b=VAB0xKhkwTijh4DcA/1wj7wB+K
	v3f14KEs2DEH3II/Pve6sVAvDbeReBYAJH3RvG63ikACAmJqdQ7akOAgtueKNlyS
	ABZCiRReQAt1qeiZvyQPiIJ0lezeNgQZsgLZx9cMl9sqIs7iqqLjOfG2rVwDnQ0H
	br7PMLK9KOXPt2HY1Sd5ihedjYfIU5aw8emttZf0fxqXLQiFGESZVLYF3aCfA7wE
	3QktVZB1yjgHGvf/Zvl1H8nWbQB9vLzSZ/Otm0hW/lUj383b6deoJb7E7/Ou0A5U
	74X23Sv8iX/5S4Q4eMIInJH7mxoQDF8yhSuWbcT2C8qz0t19xXm3xKUxqZjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737700600; x=1737787000; bh=mxMsBJi04keMzrh65uelnZEckyEsFUItCZ2
	/kYPM02U=; b=j31Aj81dK9PNutykjy9cciTpmbX6aBn7IQdt2NO9ZXZYxX2ufY6
	UY0zPR0gdL53dFYfbCMJPhANOeQhHP1CyaP0v2jREOAoW1mKytQitGTIWqGvQa01
	L3Bs6jo+2bAwdejf+VGP1WtcKRgYYYHEMYfy4Z6bmLHUvnY/nnQ5eaUINp9AsZ6H
	Nfe4cmaIEYto0Nae7DRX5IYxDfIN8WeIWWenhQhbbjTLP/VtbipQozY9Crla5uEZ
	67HMdHUonGOceapOKyQEDkgdjy3EkmTYzeir2NEQQ3mmuUxGWovBocUZS6LPHcDF
	6kLG9/KAu3iaL3kxE+gkz8vxUjYKXlkPXcw==
X-ME-Sender: <xms:-DSTZ27qQH8szQHT51ozKJ8VEQzQH9MExa64AmXuGmkV1CRZn47n4A>
    <xme:-DSTZ_7AoEqocgYLCW3dbMkomASi_XYBIktt1egWGNoVHau1pUHWb-jQNZe30mg6f
    RT5gGTHsSC9SVXAYw>
X-ME-Received: <xmr:-DSTZ1e4XlkY9-xFZ6lbuhsKphBD2dg6C9Fve4nFIsi7LNBvktYs-ShnzgQhLixC-glYPoVXqi5Ws3OVITCCyjLg2nqLKbEGZWngIDQuicWYqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgfeekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnheptefhvdeije
    ettedugfffueekgfekiedttddtgedttdeuudfhhfegvedvgeehvdeunecuffhomhgrihhn
    pehgihhtqdhstghmrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopeiiohhtthgvlhgsrghrthesthdqohhnlhhinhgvrdguvg
X-ME-Proxy: <xmx:-DSTZzITCs48HuYD9MhMRBaa8xXDuhe38f-c5qz_7z0WvPIaXqn4wQ>
    <xmx:-DSTZ6Lc5BETt8K-oJ9iK6JccAAPn5pbHCXGfg6-l4TLUO4qpnUDEQ>
    <xmx:-DSTZ0wZ6p4kWqim5LxVBcBsY3o0SCYXPHT-sniHcjGnECZHYdT1ow>
    <xmx:-DSTZ-KeFKnTCXYr9Dib6abEDYa_PFePGBN6g0f702Sy8Wpd4ilaUA>
    <xmx:-DSTZxUcvrGesZDUfatcumVAz9tRjFiO-WNnjISkojMe03bEI6BTiYJC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 01:36:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c06a351 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 Jan 2025 06:36:37 +0000 (UTC)
Date: Fri, 24 Jan 2025 07:36:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Reich <Zottelbart@t-online.de>
Cc: git@vger.kernel.org
Subject: Re: unlink errors under windows in git pack-refs
Message-ID: <Z5M08DQCZ_43EIbm@pks.im>
References: <d7fd0b1c-98fe-4cc3-b657-c2c3d0bc5c47@t-online.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7fd0b1c-98fe-4cc3-b657-c2c3d0bc5c47@t-online.de>

On Wed, Jan 22, 2025 at 08:01:31PM +0100, Christian Reich wrote:
> What happened instead? (Actual behavior)
> 
> git tries to unlink the reftable-files, but jgit hold windows-system lock,
> so the file can't be unlinked.
> An answers 'n' for retry causes more asks. After the third try git give up.
> 
> Unlink of file 'C:/temp/jgittest/jgit/.git/reftable/0x000000000002-0x000000000004-50486d0e.ref'
> failed. Should I try again? (y/n) n
> Unlink of file 'C:/temp/jgittest/jgit/.git/reftable/0x000000000002-0x000000000004-50486d0e.ref'
> failed. Should I try again? (y/n) n
> Unlink of file 'C:/temp/jgittest/jgit/.git/reftable/0x000000000002-0x000000000004-50486d0e.ref'
> failed. Should I try again? (y/n) n
> 
> 
> What's different between what you expected and what actually happened?
> 
> I would expect, that git tries to unlink the files. But if this fails git
> should ignore this and try to delete the files next time on pack-files. Its
> documented in https://git-scm.com/docs/reftable

Yeah, very true, it is expected that unlinking old reftables may fail,
and this should be totally benign indeed. In fact, none of the callsites
of unlink(3p) even check its return value and we just continue to run
witih stale files.

The question comes from `mingw_unlink()`, which we use on Windows
platforms:

	while (ret == -1 && is_file_in_use_error(GetLastError()) &&
	       ask_yes_no_if_possible("Unlink of file '%s' failed. "
			"Should I try again?", pathname))
	       ret = _wunlink(wpathname);

As you can see, the loop should immediately exit when you answer 'n',
and I assume that this even happens. So where do the other asks come
from? One such location is in `reftable_be_pack_refs()`, which calls
`reftable_stack_clean()`. This function will try to prune any old
tables which aren't referenced anymore. The other callsite comes from
reloading the stack, where we again try to unlink now-unreferenced
tables. All of these calls are benign.

So the problem is that we use the EBUSY-handling in `mingw_unlink()` in
the first place. I'll send a patch in a bit to address this issue.

Thanks for the report!

Patrick
