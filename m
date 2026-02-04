Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239C2EDD62
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227593; cv=none; b=liX7wHQq4ao1iMjauld45ofCmFmmXi3obPjMlmX30ysZrpUOcj2TD3HqPXLTxmYzAv/Rih5KWBZGkDjh3cMGVzt/k35fOSekcBMv9uLGsJ4p86YCGza/AU3H515A9FyQ4Csec/+54n1CpOn3HHoMxXeY6szenVGHPE2UfxBY72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227593; c=relaxed/simple;
	bh=78iuikSyQZWZ2mLpBhOQSwFFsOL9QLHGviM/GF53lAo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gHYuU4gv7RTm0MOerJCdp6MBMBNNQGzFxo0q6dxrROIPaYo2gxPgR2QdM6MyPTUs7y0Y80oIMhv3K4ldoWPE9zijPKgAk5pwJnwgYqzidDrDdeQgkwS6Eu+nT8c57lll0p5QZC02xghpG645Kdd9azBr+GIjBJzH+uH86o+1VNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UETXWH5C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tMDy9BqB; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UETXWH5C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tMDy9BqB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4BE351D00068;
	Wed,  4 Feb 2026 12:53:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 04 Feb 2026 12:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770227591; x=1770313991; bh=UxIP5UxJ2a
	W/F4EaJ5V5y5L2IyR0NjdktXC4/Ikjoxo=; b=UETXWH5CIpHSTuZgsiKYWm0mib
	U92DUDcIJEETRodolUT6M9OlKW8mjj0WkfHP9wfzo57qOCPWCuOEND7hG21snFg2
	YLdrJscz3XmhFcoE4nxBdqGdYXtTlGPWBHF/JNrmDYDQnYIQbkfBvct2dsD5XS6r
	Ci1LM6plwEQiBgPRdmUooa9lRlLnvDYo4dae3+9cb8RRWhtnWqDYWEgT+oFl+Qsp
	8PfU1lgk92HzsNkTn3BX7sfozceiQDjJS862zzYkYYelf8J26IbDawb01I4xaSaf
	DuIHv67Rgv3cr7SDL+YnYwPgCknI8uxIpPIKsKpV8s3eMb6jWwbjImrglBKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770227591; x=1770313991; bh=UxIP5UxJ2aW/F4EaJ5V5y5L2IyR0NjdktXC
	4/Ikjoxo=; b=tMDy9BqBKRKMxuVI5kNg2iH0IDj8MZ5zfXV0IqmIwamUY9/uxan
	WzCOUpn5yezDL90i/+F0GcX3P/S7rvdYIgV4irvhpWrxXCrutHQ6HPo0uWGllAU1
	p8dtcj4+597xip4V6pEY0pDvUKyfcx7Z6/TFZBuOL14JiK3E0QyMiuMs3uZuWW+F
	lbbumdfAhkdN+77M5V6GHx+n8pQXBNnBqH0mvyWdTh/hvDAztWjHdsfvCPS/rCj4
	kzoQDPUZxhhnARcJzvgw4TOy/kCjWzu7zvd60GfPdAyg0l8FpeDb/qYXrQmYzkuE
	Ll+BuyOU1XN/QG7VydX1EXFYCYFYVGeI9AA==
X-ME-Sender: <xms:h4eDacFklsZ4C-aEVGCw0OCBx9X4xAsfdfgOGspA_vWkm2P36trW7w>
    <xme:h4eDacUMqU9uGJQR0JfDAsVZEQCSZvNGg2inYKui-3htOVUVs2FrqaJXsvQKrw0iV
    N6fPUFSSYlh2wb-C5Dp1KMnToGyPIlHGVDs5dyapDJDg7BOqOB6qA>
X-ME-Received: <xmr:h4eDabJ7-dUcTk4qt16vULd0sXWaVuZtcjY6UIlHa97R7ZKmYNHylD1bMVpuAawUR3qeJhD3vy2MzSCxnwBXJgev9qTjETEfhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeftdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:h4eDac-kk30xQHSqsv_3zCUdUhRSzOAWSObsDc_tDsyfL7-s6CSUTQ>
    <xmx:h4eDaeJbBDzL2SsMLiUmwKcXhpVS6odY-KKrjewESEAOSA9AiToosA>
    <xmx:h4eDaRl5VndME54DvNr15xZZKPLiqhAMGZiqZsH9SRftaE9rukpK3A>
    <xmx:h4eDaSMZlVmbsp_2ix5lMPvZCQk927KaBhwj07LMQWaJWxGrZkDGWw>
    <xmx:h4eDaSNxN5AOUwqo088B1NKKPmQ46Da8GT77SFUFvB3-lWH2rwbS3ChK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 12:53:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] meson: wire up gitk and git-gui
In-Reply-To: <20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im> (Patrick
	Steinhardt's message of "Wed, 04 Feb 2026 09:38:11 +0100")
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
	<20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>
Date: Wed, 04 Feb 2026 09:53:10 -0800
Message-ID: <xmqqa4xopf95.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Wire up both gitk and git-gui in Meson as subprojects. These two
> programs should be the last missing pieces for feature compatibility
> with our Makefile for distributors.
>
> Note that Meson expects subprojects to live in the "subprojects/"
> directory. Create symlinks to fulfill this requirement.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> I have upstreamed support for Meson into both gitk [1] and git-gui [2].
> This small patch series wires up support in Git.
>
> Changes in v2:
>   - Use symlinks instead of moving both gitk and git-gui into the
>     "subprojects/" directory.

Just being curious (as I cannot offer an alternative if the answer
turns out to be "oops, no"), but is Windows, which has been symlink
challenged for quite some time, happy with this?

> diff --git a/subprojects/git-gui b/subprojects/git-gui
> new file mode 120000
> index 0000000000..c6d917088b
> --- /dev/null
> +++ b/subprojects/git-gui
> @@ -0,0 +1 @@
> +../git-gui
> \ No newline at end of file
> diff --git a/subprojects/gitk b/subprojects/gitk
> new file mode 120000
> index 0000000000..b66ad18ae5
> --- /dev/null
> +++ b/subprojects/gitk
> @@ -0,0 +1 @@
> +../gitk-git
> \ No newline at end of file

Completely unrelated, but I think there needs a way to decorate a
.gitattributes pattern specify symlinks (and non-symlinks), just
like "foo/" makes the pattern match only to a directory and not file
"foo", so that whitespace=incomplete-lines does not kick in for
them.  Alternatively, make symbolic links excempt from
whitespace=incomplete-lines rule altogether.

