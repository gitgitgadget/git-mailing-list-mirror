Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565DA3B38A9
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868724; cv=none; b=O5VNY9ZOR8zTmiM/9YceTi/mMXNP3DbW29nu0UoCyuF5xZKCsnaNDP5yjblmXtLgrHc1/mPupILvcoFtzmhFXBfN812YpZcZ58opNn2gQXHJMofjtjRASwwo5ZY49lyiwh1u8udp+6UTJauZ4EPYAFD/9N9otFVhHwaUToNHpiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868724; c=relaxed/simple;
	bh=vcuo9/dIO6XSGRLsNbkvY3cySbp5QCwct4gEkHAFNvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YWFdYxtI+KB7CSabu5QmqH8KX9QVXmvSUWn/IzMWnY9xGQNcUZQMDgTJAGWP1AznwAPbf+TK8Wm1rvWOWLfwI8CGsrdCf1slpMw84EzP1yeaBa0ZnFx31pDTkdhDrC7Jfj7lkLmkZYmU+SelTDopQn9z/7MoQJDfp5gKRzfKBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J05cXged; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uQYwDaXB; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J05cXged";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uQYwDaXB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E3ECEC01CB
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 11:32:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 01 Oct 2026 11:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790868721; x=1790955121; bh=QQA1+8OCgO
	Htfh4t4fiimwX6Y9LxBgIi2gqskiP6cQM=; b=J05cXgedBlI9VgtH25R1j15fJL
	XKNh90ZRY3XG+Kz13rE/VNi+g23/cOfmAbmfhuib1Tt8u4SDcMHPVmptsxRiCllf
	uQ33DRhbXq/UH0JegDyFgD8XBm8/Ip520R+MIiA/zSK146n0pUa6I9xje8NeaQFX
	B3KrtJ7wi8np+GqkyuaWfDzhWoMGup4LQqH1Lx647VkEQ8NnU9FIRsiwRmb8X72e
	Pm/YZaDbWhbmIpqAljeEnkWUI412XHd1yjY86bQ9Xr0YmldH90yd6AMcFQjOAeDL
	rGbdYRztpZWq4utT2nKzg+UPcjTUYeoHIPNwuAyy88LJlOgj6VzRNaf9w5IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790868721; x=1790955121; bh=QQA1+8OCgOHtfh4t4fiimwX6Y9LxBgIi2gq
	skiP6cQM=; b=uQYwDaXBuIYvk1IRFc8z8YbC36pmVJQouMOaua/lWYdhTwcyODa
	RNOVpaSdxwb9d8WRdoLvg1IF9hEXGwsjsU56NPIbw0ubuYr5S0g3oAd+EhCASdPe
	ynhQWUR7+1dzImVZwXbjSneKGTFaHu92zBpoY16aNqSQFg5NaZuo5WXTQr+Bmo40
	P0EDGAZMGyUhabbGvj977OImqxsj+UQmVpQ2vGrthwtHZ9OIRXVdkQplGEzJA9Vh
	XoZa4XnzgzCAO7bXzWKs8Jjqf3jcrFhIk+EykX35JUHzpBzCM3aJBsGLpIGxEbua
	ChzCMwj01aDrFtzzbqgNzdNvnaP7Q6a4flQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790868721; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:gEEtTjdim7ZIhwUWhwdZ7LYDuI0QYdXgon3xI+L2Itb73+i
	W3RZpy4rt7VskAG5ADRcPTdmL+EZsmcbp2r0bFAC3SuzWcqu+S54Ls/XRyPIeAtq
	09Q7ztcmC75DCyEOeh/IokRB4SJtU/Xa7l/IsSpMBwvvu4K6Cd5rkwQ3QgDZjm6Z
	cp9wD+dNl5ENiu54tZ7S3uC3l3yMiUg6ofBYbAI2/5ZpOnQXQo6QnCIWaDXYKJyE
	TUUBvYVtiyTt/8ajrP5dA9ivR6VRzy44W4iIIRvWYOxhlAl4mUBuFBNDPO6IKq50
	EErKve4pusKWwFhNg8mu6d2cdhfZbepzz0DydNw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:vUqXPdV77FqAS1yIzREyU4WfIwpPmoHA6Q2gFbBUF0Y=:vcuo9/dIO6XSGRLsNbkvY3cySbp5QCwct4gEkHAFNvg=;
X-ME-Sender: <xms:8Xy-ajXKq_iH1cVxhsDC3gr4pvkybz9cwsWlAXrHp6mxuK1I4dR67w>
    <xme:8Xy-ajCufkl3FHWWrI6aeHsB2U7e16o2gDxX3UBzWle3UVzYlQ7zZgrWMnXV4ILvJ
    x5j2cz5AQFIsQfhTDRiLmDswbFMGw1z7ApQvJm6Ps70oJRekert5s-k>
X-ME-Received: <xmr:8Xy-asxSLYQfJWxGBKv3TaoWl5W_21SdyI1Icj4HNoz7iV79uSGSUmFMgzm94c0XUcGsaBFgV-BasacbcuX1_41M-MlAzPuOEfvy>
X-ME-Proxy-Cause: dmFkZTEb4msSed8G9xbOKs8f42r9KCihkrhZizl1+bOk0yWj4Ig2mCpbHQG2UpbfkhfJvV
    am1n9VXn0j/vACfMq+J7mt2AwkcOKPbSngkP4sNI+9n4+WeH2OSs5bXtupi6LOTeHhdKgq
    DjL4R5Y0LjxnJomQJs0Hg6IBf0vkqGW/97VQavmX3H0/2qs9lc/1FT4ciGscOEmjKbCd+A
    8cBrdsFDnzSNt/b8lipygIJTr/Pa2HcBwSP1DThDQiNZKjmWXp77j7x+96Rul/6aBGxO4l
    gAQBRSW38UvBUelhFlsBb4kzpfvotiF4ZXnV8C7jp1XRcIeS+3qglC/LuHg0Zttjj446Gw
    px1uORl+a/ba7Fat6kV+ZpjKMzaLMupmldm4jOw+szKHQm8m1+in7iBCqvu1m0iilHUffo
    zHZ94cUMPXRjeBEM9xkQ7w3Sple8qLs35x9MqB0S7ikv8leNPk+JhDDVGc8bV89kS6MLLq
    41Ms0URC7pL50zKRVB55PysdCZQLOHSI0cZZoavXZMuZtsoGXMKxjF7qLnJgX6mtzlP3W9
    xbmLcnuMciWOb5jqcuZqe2ZahOPHifS4E0sUH9DNG5wIpgwxrp2OE2UMkhTOcZVE102x5j
    JzLDcJwxFFoAO/5nZkv9hhJMnDc8JccdZKNo4KUHo/7UOAl++Og7twGJF67g
X-ME-Proxy: <xmx:8Xy-aoAMiiSYtwcqMU5otARjoJgt8ShVy-IhC5i6Abis1kuMH_svXg>
    <xmx:8Xy-ahbOY4bGMtAi7iT0W5VLoMthqA3Ix9bXN4P4cuWUjS5ojRpNWg>
    <xmx:8Xy-aogEgP7r6ms7kGaH133pX4mFOmHtOY5nCvmrH0WiWadSWrdHZw>
    <xmx:8Xy-ar4nx-sgcqeK2XsQHUTNfu6H4Ze7MY3dCuvnBRbYIdohEGe2Aw>
    <xmx:8Xy-anD0UX82ajrHoesBBUJWYkzbLleg9EgLYxws50kJKGmP_ged-KwY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 11:32:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Khan Zimov <kaliugov@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4] doc: remove unnecessary commas in git-add and git-rm
 documentation
In-Reply-To: <20260929210618.147-1-kaliugov@gmail.com> (Khan Zimov's message
	of "Wed, 30 Sep 2026 01:05:04 +0400")
References: <xmqqh5je4o45.fsf@gitster.g>
	<20260929210618.147-1-kaliugov@gmail.com>
Date: Thu, 01 Oct 2026 08:31:59 -0700
Message-ID: <xmqqwls177yo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Khan Zimov <kaliugov@gmail.com> writes:

> Signed-off-by: Khan Zimov <kaliugov@gmail.com>
> ---

Thanks.  Both changes look good.  Let me mark the topic for 'next'.

> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> index 16b06e38e1..3fc2513a2d 100644
> --- a/Documentation/git-add.adoc
> +++ b/Documentation/git-add.adoc
> @@ -223,7 +223,7 @@ for `git add --no-all <pathspec>...`, i.e. ignored removed files.
>  
>  `--`::
>  	This option can be used to separate command-line options from
> -	the list of files, (useful when filenames might be mistaken
> +	the list of files (useful when filenames might be mistaken
>  	for command-line options).
>  
>  
> diff --git a/Documentation/git-rm.adoc b/Documentation/git-rm.adoc
> index b5ead86796..67061e961f 100644
> --- a/Documentation/git-rm.adoc
> +++ b/Documentation/git-rm.adoc
> @@ -61,7 +61,7 @@ For more details, see the _<pathspec>_ entry in linkgit:gitglossary[7].
>  
>  `--`::
>  	This option can be used to separate command-line options from
> -	the list of files, (useful when filenames might be mistaken
> +	the list of files (useful when filenames might be mistaken
>  	for command-line options).
>  
>  `--cached`::
