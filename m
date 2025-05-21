Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2019822F15E
	for <git@vger.kernel.org>; Wed, 21 May 2025 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747856004; cv=none; b=cthwqitygGPiuGS4uyv+Y7By72LYrpUF7PGT07iVWgfElCshDC+8nahcv/u/xs9QaZoeeZWAEOmN1TjoHoYE/budFi1TivqyblTjAkt9roTdcsX5NU5ksuDDgZAbLJHu0w2S9CkBMj3XRaGovkHE2vVVveL5AWiFoP/6R8+7TKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747856004; c=relaxed/simple;
	bh=KUSwEWtiSe+ToFmLhJNLtSW3szBA3atwjIUx5yAhWW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uj56sSW4mvrPdBIn0l6eQxeO37c8YuzATO7jmV/iF8haXxpP1Xo4VtN+oozQTneBnoHm+/tw87dgT0D3WHmofX0HSSbzuLNJC0Ft6KgRv2N2v5bwxt/ti6GtQd9ExivqHIIn+ELpSov/c0EMYN/mOJfVMdt+n7ksMkO4qn6rG58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PkseDpJf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DPIJBT2V; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PkseDpJf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DPIJBT2V"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A6BC1380186;
	Wed, 21 May 2025 15:33:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 21 May 2025 15:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747856000; x=1747942400; bh=8EoYKJXEQX
	n7cJfyybB0UPEY/6c3GELI0CUEOaN989E=; b=PkseDpJfiudAbvT1QON+RC5yQK
	/MIK4vIAxuGB8xTCKF4CKcjzwUYGnV3QSam/7tXPUFb+nJxpOg54b+vwJZGpV8X2
	MXEE8fZrdeh3aaqMoSjT3nLx2uItvvtAfB4zObS9nnDlsQD1wfHluzwnZRAI5VnZ
	MGF5dMUx3kv3/EEhRSG6lFBXkOmZmmRGXml2NwCBITBGO4ZXOgMhvSBKbQXyCCnb
	LWhZ08XT8G/Tws4bsX1fQhs5zlgOIrJeAUockmKlrnts3WMppHVjHM/ILh191D6T
	Gl1CaQ/XZoBB5EuJFXbbv4c5wuU1wb9mJIc4vv8d0jOoX4PnP4emQxVatX8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747856000; x=1747942400; bh=8EoYKJXEQXn7cJfyybB0UPEY/6c3GELI0CU
	EOaN989E=; b=DPIJBT2VCWzDtWiZWNxEKe3qOwBDYuDDmzpzsIhnaS5g780xeyP
	PdE79SL6RB0J/hcgv3ZvFUkpgJLEEZdtFtYqWp/SI+zBtobmZgqRYOIFtk2CXHZi
	sGhT6Cn37WjFqRs5G2KyItunZzQD6EG7kMKPN/T6aALfuUIADIWdVQA9HbHaiR3B
	mh7G5B7o8Go1hCzPtuh9CjAkZuxfbsQXQLIIbxI1PqKh63oxtdbUXHfRAaXb8xN0
	5Ocbyd+WczrJde4S5fmChASPyAveiLAVdiF5JLa1KyqgnKTw1h5IcYwNhNa+rBnB
	V1b6sLAmetO+itz9cZxxPQDBfMjwLu0+a2Q==
X-ME-Sender: <xms:gCouaPA9r7mmIgWA2hmlC4PZstul0rzpQS3MuU-pnC_YL4OxfztgCg>
    <xme:gCouaFgbeQL_Xjg4NYcqJsSgiL3irp0VcXDz-bvdPsUwOBymXorTd8GdUflISV2MB
    rd7uT9EJqq7_rNqJw>
X-ME-Received: <xmr:gCouaKkMolg62Gd084Pv6MRLwv3wwdfbHpmnUGTMVTMwvyrTzqBs4WiHOXru2OH9SHJY5qaM7JUOWehPZdAJS-8-aW37q3FWFBpeaY0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdegtdeuffev
    gefhheevveehkefhteeuffeifffhgfegieeifefgudefhfeuueeunecuffhomhgrihhnpe
    hgihhthhhusgdrtghomhdpthigthdrihhnpdgrughotgdrihhnnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogi
    drtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrdifihhtthgvvhgvvghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gCouaBymDtOlxJTEeA3BZxt2y4o1KMyGAMuII0Fea4i0jS1wYIY_vw>
    <xmx:gCouaESmjazbAI2mLe46btlpwvexdj6f_RN_CAfRBzrJa8RTzJavbg>
    <xmx:gCouaEZ_R3v-w0Mg2e3RpXV9136gVrT0dp9cLrH9rw0CFYQWL3f0GA>
    <xmx:gCouaFSm7zQcvREebgPutZ7Hs77Gd73oBcg0PgdcXcyzO_xAZFxRjw>
    <xmx:gCouaKd6g6NvpUCF8e3aDmntKoTf27qV2XHcq2WysyLRR5OMZ16ZLTGJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 15:33:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Jouke Witteveen via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jouke Witteveen <j.witteveen@gmail.com>
Subject: Re: [PATCH] doc: update references to renamed AsciiDoc files
In-Reply-To: <pull.1971.git.git.1747854310479.gitgitgadget@gmail.com> (Jouke
	Witteveen via GitGitGadget's message of "Wed, 21 May 2025 19:05:10
	+0000")
References: <pull.1971.git.git.1747854310479.gitgitgadget@gmail.com>
Date: Wed, 21 May 2025 12:33:18 -0700
Message-ID: <xmqqr00hahdt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jouke Witteveen via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jouke Witteveen <j.witteveen@gmail.com>
>
> The .txt extensions were changed to .adoc in 1f010d6 (doc: use .adoc
> extension for AsciiDoc files, 2025-01-20). References to the renamed
> files were not updated yet.

Good spotting.  But ...

> Signed-off-by: Jouke Witteveen <j.witteveen@gmail.com>
> ---
>     doc: update references to renamed AsciiDoc files
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1971%2Fjoukewitteveen%2Frenamed-files-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1971/joukewitteveen/renamed-files-v1
> Pull-Request: https://github.com/git/git/pull/1971
>
>  Documentation/gitprotocol-v2.adoc          | 4 ++--
>  Documentation/technical/build-systems.adoc | 2 +-
>  contrib/subtree/README                     | 2 +-
>  mergetools/vimdiff                         | 4 ++--
>  sub-process.h                              | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
> index 5598c93e67c3..abc42efcc774 100644
> --- a/Documentation/gitprotocol-v2.adoc
> +++ b/Documentation/gitprotocol-v2.adoc
> @@ -54,7 +54,7 @@ In general a client can request to speak protocol v2 by sending
>  `version=2` through the respective side-channel for the transport being
>  used which inevitably sets `GIT_PROTOCOL`.  More information can be
>  found in linkgit:gitprotocol-pack[5] and linkgit:gitprotocol-http[5], as well as the
> -`GIT_PROTOCOL` definition in `git.txt`. In all cases the
> +`GIT_PROTOCOL` definition in `git.adoc`. In all cases the
>  response from the server is the capability advertisement.

... shouldn't this reference be also linkgit:git[1] just like the
two references on the previous line?  Given that such a correction
needs to be made on exactly the same line, I wonder if we want to do
the change we see here, which stops at an in-between state, rather
than going to the end game of using linkgit: properly.

>  The server may need to be configured to pass this header's contents via
> -the `GIT_PROTOCOL` variable. See the discussion in `git-http-backend.txt`.
> +the `GIT_PROTOCOL` variable. See the discussion in `git-http-backend.adoc`.

Ditto.  These are specifically so true because ...

> diff --git a/Documentation/technical/build-systems.adoc b/Documentation/technical/build-systems.adoc
> index d9dafb407c40..1ae2a5292f3b 100644
> --- a/Documentation/technical/build-systems.adoc
> +++ b/Documentation/technical/build-systems.adoc
> @@ -32,7 +32,7 @@ that generally have somebody running test pipelines against regularly:
>    - OpenBSD
>  
>  The platforms which must be supported by the tool should be aligned with our
> -[platform support policy](platform-support.txt).
> +xref:platform-support.adoc[platform support policy].

... this one did not stop at "txt" -> "adoc" replacement, but
attempts to make a proper link.

    Side note: I do not think we are using an explicit xref: syntax
    in our documentation anywhere; have you checked how this gets
    rendered?

>  === Auto-detection of supported features
>  
> diff --git a/contrib/subtree/README b/contrib/subtree/README

Old names of documentation source pages that ends with .txt outside
anything that themselves are .adoc files, like this one, unlike the
above, should be just ".txt" -> ".adoc" replacements.  Everything
below looked fine to me.

Thanks.
