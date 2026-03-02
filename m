Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18FA3FB04C
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470428; cv=none; b=QCfXM8+YyZ0Ky6DlUJncsjKSUovszjQJ4ZtS2AxuBPB3/5m8/6IqcQVyIFKfZI02DNVb8gwBu9SBWjrIa/yCU/LTWaVNVbQzBIjKDlpMqSq2hLTSa0SgM5uGwq54jyxJ+QkcpvlY/J5sXQsNOwwVX3RnYDP1NvakxzoHAPh0t68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470428; c=relaxed/simple;
	bh=y5CcQedUntLMqtfi4ixJwC9YjsisD0lOUM2M/paSaaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BPzYbxk9BabC76ajRQ7oXLmo2xcvXbrcQsMQPLJ2nAovS+U5idH0eDVQnX09UiO8caZ20VuWxVI0ChYCxfoNgF8u8ymjMqtGp/zamkfL55x1wgLsIejXul7nQlE8D3/N+CADBT5p81qAsmaEVm9fLcGK3uO36UCLpGFh6YPKe2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CX8+kHBi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B4pNknXU; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CX8+kHBi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B4pNknXU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0A1067A025B;
	Mon,  2 Mar 2026 11:53:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 02 Mar 2026 11:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772470425;
	 x=1772556825; bh=q6s9leD0GhbtpLpVG4AYq4eqepKEi/uKBz6sSjt9I/4=; b=
	CX8+kHBi0pdoJ1D7aoJZMw7NKgokjAnouP4JLgnkybrGB0DSMATyQEDamn0zdX26
	ylWs75USWra4ZSu8+Dj0NGCJ3+yLb82JEiUH4iWXfgRY6Am4zXzSSd2YP0OCsBmV
	UgFoHmJBn0vF8pBMGGZRfKwT/P7ZW1WogRYwe4pQpg/Kx3zeMcg55AauMRCfSWDl
	bbmjnM8ZPt6RiPKhvzTxuWQ4BJme4uRgLSQvt/9zd7dhWM6AgYNJ8KzVX7/aTxld
	ZAHuTwyvKALR6i7dq2SPow6+0UiloYFR/zNOyIhC6byGYUE20W3QLszd3d56g5ib
	O4uY3SsB0sUdyFHvuawAPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772470425; x=
	1772556825; bh=q6s9leD0GhbtpLpVG4AYq4eqepKEi/uKBz6sSjt9I/4=; b=B
	4pNknXURhePc61wv9RGhx+AnlFwur1nCUOsAnD9DQO0Td3fumLRi3blZVN8AWqt/
	VlIqHkyQGLcp+dNryUynxW3VBrpytebfKQYOBk9r0t/aF8CyTB+DGmOC5adx/7DS
	zWATRwHPyzhQTqjoqhTy+3e84Y2qP9jJT20HauAwYM8B3r76a/D0tQD2xRHp0g/S
	16Es/LlXqpvix76j0A4ikcP5s5iTljooTEyarCsg/DyGZIfXupvl2zFCy8RXaJvB
	D8/RT8H3Z5v/l6kXO3fbbil2INOyLuCAnCscgELNSiM6upJWFY69+qz58Fu+m2Kj
	mT9Ql1J8EG5nkdexqRtzA==
X-ME-Sender: <xms:mcClaYZ48Ys31drG_6GgPvWa67uz9LziXguUXV9YIH_XB4fQN6CDEA>
    <xme:mcClaXH2Ec8KRKs9JgwV4bDIIYH3vBf7YUDxW85Aa-PpiZo7564zz2_QslC-tDx2D
    mekF3PYVich8HQ6ZaTrQ8U-BdlITrJHJ7PN_KK1-uT7bHJgGYx4>
X-ME-Received: <xmr:mcClaczO_sT7CcQdGML5kjCk2q4V3AcsE6o4JrOEsbeVfZzqnMh3WwjgUcMCaIcymvTPJGM9HTDhED8XXVx_u0rcX-mEGCtJUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhh
    rghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrd
    hfrhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mcClaZnERj4XKczYGWSEpleUByO0sxoHHdV-FI1ybZxnKSdrl9ZbNA>
    <xmx:mcClaVn6RGqRUs-oX97ZOJibuAyjOHztdZWz_3Z4KhMJIud6kLAcsg>
    <xmx:mcClabyshr_2TQ3aehDqrP-0Y1sw12OqU7XI1b8O6dgngJ8IoI0fbQ>
    <xmx:mcClaarq4N7PidG6CBfdA16wtrjcdTdXULRMOVLAaodZ3sTrvbxBPg>
    <xmx:mcClac2z5Ksf_VKCZCJyTDjR-x8rQO009cPHIIqV9WSGSwl3fNloJgXe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 11:53:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  jn.avila@free.fr,  peff@peff.net
Subject: Re: [PATCH v2] doc: diff-options.adoc: make *.noprefix split
 translatable
In-Reply-To: <V2_better_for_translators.43b@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Sun, 1 Mar 2026
	20:21:14 +0100")
References: <better_for_translators.424@msgid.xyz>
	<V2_better_for_translators.43b@msgid.xyz>
Date: Mon, 02 Mar 2026 08:53:44 -0800
Message-ID: <xmqqldga2mw7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> We cannot split single words like what we did in the previous
> commit. That is because the doc translations are processed in
> bigger chunks.
>
> Instead write the two paragraphs with the only variations being this
> configuration variable.
>
> Reported-by: Jean-Noël Avila <jn.avila@free.fr>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     Notes to the maintainer: based on topic kh/format-patch-noprefix-is-boolean
>     to fix the issue reported in <ff86f877-4b75-403d-a5a4-10ab528a9691@free.fr>
>     
>     v2:
>     • fix `endif`
>     • Don’t use `TRANSLATORS` callout

Thanks.  Looking good.  Will queue on top.



>  Documentation/diff-options.adoc | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
> index 8f632d5fe1a..fcfcdf0286e 100644
> --- a/Documentation/diff-options.adoc
> +++ b/Documentation/diff-options.adoc
> @@ -859,12 +859,18 @@ endif::git-format-patch[]
>  	Do not show any source or destination prefix.
>  
>  `--default-prefix`::
> +ifdef::git-format-patch[]
>  	Use the default source and destination prefixes ("a/" and "b/").
> -	This overrides configuration variables such as
> -ifndef::git-format-patch[`diff.noprefix`,]
> -ifdef::git-format-patch[`format.noprefix`,]
> +	This overrides configuration variables such as `format.noprefix`,
>  	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
>  	(see linkgit:git-config[1]).
> +endif::git-format-patch[]
> +ifndef::git-format-patch[]
> +	Use the default source and destination prefixes ("a/" and "b/").
> +	This overrides configuration variables such as `diff.noprefix`,
> +	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
> +	(see linkgit:git-config[1]).
> +endif::git-format-patch[]
>  
>  `--line-prefix=<prefix>`::
>  	Prepend an additional _<prefix>_ to every line of output.
>
> Interdiff against v1:
>   diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
>   index e4d02cc93a9..fcfcdf0286e 100644
>   --- a/Documentation/diff-options.adoc
>   +++ b/Documentation/diff-options.adoc
>   @@ -859,7 +859,6 @@ endif::git-format-patch[]
>    	Do not show any source or destination prefix.
>    
>    `--default-prefix`::
>   -// TRANSLATORS: format.noprefix / diff.noprefix
>    ifdef::git-format-patch[]
>    	Use the default source and destination prefixes ("a/" and "b/").
>    	This overrides configuration variables such as `format.noprefix`,
>   @@ -871,7 +870,7 @@ ifndef::git-format-patch[]
>    	This overrides configuration variables such as `diff.noprefix`,
>    	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
>    	(see linkgit:git-config[1]).
>   -ifndef::git-format-patch[]
>   +endif::git-format-patch[]
>    
>    `--line-prefix=<prefix>`::
>    	Prepend an additional _<prefix>_ to every line of output.
>
> Range-diff against v1:
> 1:  55e56c90959 ! 1:  07acc52c3bc doc: diff-options.adoc: make *.noprefix split translatable
>     @@ Commit message
>          Instead write the two paragraphs with the only variations being this
>          configuration variable.
>      
>     -    It’s not easy to spot the difference here. So let’s leave a comment
>     -    for translators.
>     -
>          Reported-by: Jean-Noël Avila <jn.avila@free.fr>
>          Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>      
>     +
>     + ## Notes (series) ##
>     +    Notes to the maintainer: based on topic kh/format-patch-noprefix-is-boolean
>     +    to fix the issue reported in <ff86f877-4b75-403d-a5a4-10ab528a9691@free.fr>
>     +
>     +    v2:
>     +    • fix `endif`
>     +    • Don’t use `TRANSLATORS` callout
>     +
>       ## Documentation/diff-options.adoc ##
>      @@ Documentation/diff-options.adoc: endif::git-format-patch[]
>       	Do not show any source or destination prefix.
>       
>       `--default-prefix`::
>     -+// TRANSLATORS: format.noprefix / diff.noprefix
>      +ifdef::git-format-patch[]
>       	Use the default source and destination prefixes ("a/" and "b/").
>      -	This overrides configuration variables such as
>     @@ Documentation/diff-options.adoc: endif::git-format-patch[]
>      +	This overrides configuration variables such as `diff.noprefix`,
>      +	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
>      +	(see linkgit:git-config[1]).
>     -+ifndef::git-format-patch[]
>     ++endif::git-format-patch[]
>       
>       `--line-prefix=<prefix>`::
>       	Prepend an additional _<prefix>_ to every line of output.
>
> base-commit: b9b583bd007ca814ebd362bdd6441aac02e9414b
