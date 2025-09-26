Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F8283FF7
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758920056; cv=none; b=U+D0oQk4eFTQtQNoZcaHIn4/+A9+9P45IQqtL12Fb0/q8qdZwNJXthzZPOdP+zq0eX84mn7RRXDqvNewiAicvs6qx1M4t59am0MyM0gPTxBSRKFDCMjQ2ambzhL3H0/oaGPztaGbyAdt42kWORl6Pr0Pw3ZZc/Fj/47PYE5l4ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758920056; c=relaxed/simple;
	bh=+LMh7dCghyTPrH6LBRpL9pQFb/6QMn2v7S38AOF69iY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DwblorlQMDkuyM+IhntJ++Z3b4/ERAccoJkkV3dOZK+XMujClPBhfjf8+07YB4++B3RejvfsmCEU0evP8P/iUTMXH8GN0ARdsEA91+WhupxTHaqxZYsDtJncQSGKDof/eelyIOAQ4fIGM1uqP788/Nyy1/uUGNti8s+hmk74lV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ve00In0W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ac+lBxpj; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ve00In0W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ac+lBxpj"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 71EE61D00067;
	Fri, 26 Sep 2025 16:54:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 26 Sep 2025 16:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758920052;
	 x=1759006452; bh=45/X/2yuP5oZ+3JjxbVMDB/cDVVL9qbt4hKpP7u1iDM=; b=
	Ve00In0W/jxocHrd2jVi6MeNe722yzS7MM1jzWV9Gm/tZzzbL9KFo4+t/jiIaPXJ
	omlAgTlCFzQyQGeBfnWyDqM9tH++h9C2z3jO6Wy//6zUR4A4niORW2kxMiob9x4Y
	N79vyGjY8LznW0Z+5JBcdljIpkrHzGNQB1XE4CC57O6e3889GKRf0RTv/XMRv7zP
	OUbNWZvOHaJH5ougvNfKH+7xXdA0tEa6aqP0beurJxh4tcUupjEnQkxNJ02K9e2b
	2a9PQnKXw4fc5r/5ADbAkpXF6AfOj6I82NCRaQ44M2/nkRfgpTbtncpjMeZPhxm1
	RqcxLMir/Gf1afN+0DkwIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1758920052; x=
	1759006452; bh=45/X/2yuP5oZ+3JjxbVMDB/cDVVL9qbt4hKpP7u1iDM=; b=A
	c+lBxpjG5XyWzZye2MtkW+sG00/a+rixxjjq5fYy5B/03aC0cZ+BA8b1g0f1Nxez
	8PTlblFLBFiprUntLnNHUU44Qk7mvIPRUqqjM/6lHzPKxpgGIexb9rmRYTfTCE8z
	HEavzV2Asp2pXq5u7q04SzNB7GDSw7bihrxlN4rnOa64P770tymRJ2NT/pBkcaPy
	H++4OetjifrFK7r+n7yMCJoMbYFhUcv/bSFnrx4w/a5SGWGAbNhC19mC5b5FULWm
	41iDTLXITn3LRLT2eWcaaPpvh8ci8GXnVGiVXLcAIyHzSEslRz6JlmzrWyOwRxe+
	6NKIfBX9T6JRzjgVD30EQ==
X-ME-Sender: <xms:c_3WaBXwinxLeCQE7dVc-Ie84mxMIxyhGG2qwr1cpYCHHInCRz_www>
    <xme:c_3WaIf9Y394xh0frFFV29b5fFyhPKMegRGxkJep9cxcewqLpbWa3VA58UQOweLij
    Ah4WXnxKnHkHxp8-sMEUpW8Y0UWI_PH2HaLvB_6xANWcxcIcjdO5A>
X-ME-Received: <xmr:c_3WaFvP4IAFljFJFYBT7WPxtiHzwMJeP3LOvcP3I4F6boPBs95p592BfRfWsw6iv7yIZv69NTU0Jds9Y3FJLAKa95VsZ54OYtc7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejtdefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuh
    hsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefhvfevufgjfhffkfgfgggtgfes
    thekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsth
    gvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepuefgtedvteevhfejffej
    ieetteejkedvgeffveffheduueekhfelffekvdejkeelnecuffhomhgrihhnpehgihhthh
    husgdrtghomhdpghhithhhuhgsrdhiohdpfihorhhkthhrvggvrddqqddqihhtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dP3WaP81iXHSt1IC8RUphOU_1ou4Z5VLQXHJmGpXEElRGjk3inquAQ>
    <xmx:dP3WaI3UGLwHlZ5M_5JO7i1ucHm2IubKdRSiGeRotqoMgNi5FQvE1A>
    <xmx:dP3WaMCHgaFRob_Yv1beqFoz2CnanVHObiIrrOF9WU2W-LbG5NBh8A>
    <xmx:dP3WaMeUVh_3LdPjZT1T77uVoYBpUmy2Zc8SPqVlDI1h5cIB8mROOQ>
    <xmx:dP3WaCH9d2LRBvvvVUHoW-5jnA8u-ty1jR16o-8iLUZ0bxcIEEfbEikF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 16:54:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>
Subject: Re: [PATCH] doc: change the markup of paragraphs following a nested
 list item
In-Reply-To: <20250926194022.19585-1-jn.avila@free.fr> (=?utf-8?Q?=22Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila"'s
	message of "Fri, 26 Sep 2025 21:40:22 +0200")
References: <20250924005412.GB1142438@coredump.intra.peff.net>
	<20250926194022.19585-1-jn.avila@free.fr>
Date: Fri, 26 Sep 2025 13:54:10 -0700
Message-ID: <xmqq5xd5aqa5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël Avila <jn.avila@free.fr> writes:

> Asciidoctor and asciidoc.py have different behaviors when a paragraph
> follows a nested list item. Asciidoctor has a bug[1] that makes it add a
> straight plus sign (+) at the beginning of the paragraph.
>
> [1]:https://github.com/asciidoctor/asciidoctor/issues/4704

I read both the above introductory paragraph and the Asciidoctor
issue, but couldn't figure out what a "straight plus sign" is.  Even
if it were a typo of "stray plus sign" (which I am guessing but with
very low confidence), I do not see it at

  https://git.github.io/htmldocs/git-config.html#:~:text=extensions.*,compatObjectFormat

which I think is rendered via Asciidoctor.

Could you rephrase to clarify?

Thanks.


> diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
> index 829f2523fc..556eda5d12 100644
> --- a/Documentation/config/extensions.adoc
> +++ b/Documentation/config/extensions.adoc
> @@ -3,8 +3,7 @@ extensions.*::
>  	`core.repositoryFormatVersion` is not `1`. See
>  	linkgit:gitrepository-layout[5].
>  +
> ---
> -compatObjectFormat::
> +compatObjectFormat:::
>  	Specify a compatibility hash algorithm to use.  The acceptable values
>  	are `sha1` and `sha256`.  The value specified must be different from the
>  	value of `extensions.objectFormat`.  This allows client level
> @@ -19,18 +18,18 @@ Note that the functionality enabled by this extension is incomplete and subject
>  to change.  It currently exists only to allow development and testing of
>  the underlying feature and is not designed to be enabled by end users.
>  
> -noop::
> +noop:::
>  	This extension does not change git's behavior at all. It is useful only
>  	for testing format-1 compatibility.
>  +
>  For historical reasons, this extension is respected regardless of the
>  `core.repositoryFormatVersion` setting.
>  
> -noop-v1::
> +noop-v1:::
>  	This extension does not change git's behavior at all. It is useful only
>  	for testing format-1 compatibility.
>  
> -objectFormat::
> +objectFormat:::
>  	Specify the hash algorithm to use.  The acceptable values are `sha1` and
>  	`sha256`.  If not specified, `sha1` is assumed.
>  +
> @@ -38,7 +37,7 @@ Note that this setting should only be set by linkgit:git-init[1] or
>  linkgit:git-clone[1].  Trying to change it after initialization will not
>  work and will produce hard-to-diagnose issues.
>  
> -partialClone::
> +partialClone:::
>  	When enabled, indicates that the repo was created with a partial clone
>  	(or later performed a partial fetch) and that the remote may have
>  	omitted sending certain unwanted objects.  Such a remote is called a
> @@ -50,14 +49,14 @@ The value of this key is the name of the promisor remote.
>  For historical reasons, this extension is respected regardless of the
>  `core.repositoryFormatVersion` setting.
>  
> -preciousObjects::
> +preciousObjects:::
>  	If enabled, indicates that objects in the repository MUST NOT be deleted
>  	(e.g., by `git-prune` or `git repack -d`).
>  +
>  For historical reasons, this extension is respected regardless of the
>  `core.repositoryFormatVersion` setting.
>  
> -refStorage::
> +refStorage:::
>  	Specify the ref storage format to use. The acceptable values are:
>  +
>  include::../ref-storage-format.adoc[]
> @@ -67,13 +66,13 @@ Note that this setting should only be set by linkgit:git-init[1] or
>  linkgit:git-clone[1]. Trying to change it after initialization will not
>  work and will produce hard-to-diagnose issues.
>  
> -relativeWorktrees::
> +relativeWorktrees:::
>  	If enabled, indicates at least one worktree has been linked with
>  	relative paths. Automatically set if a worktree has been created or
>  	repaired with either the `--relative-paths` option or with the
>  	`worktree.useRelativePaths` config set to `true`.
>  
> -worktreeConfig::
> +worktreeConfig:::
>  	If enabled, then worktrees will load config settings from the
>  	`$GIT_DIR/config.worktree` file in addition to the
>  	`$GIT_COMMON_DIR/config` file. Note that `$GIT_COMMON_DIR` and
> @@ -87,11 +86,12 @@ When enabling this extension, you must be careful to move
>  certain values from the common config file to the main working tree's
>  `config.worktree` file, if present:
>  +
> +--
>  * `core.worktree` must be moved from `$GIT_COMMON_DIR/config` to
>    `$GIT_COMMON_DIR/config.worktree`.
>  * If `core.bare` is true, then it must be moved from `$GIT_COMMON_DIR/config`
>    to `$GIT_COMMON_DIR/config.worktree`.
> -
> +--
>  +
>  It may also be beneficial to adjust the locations of `core.sparseCheckout`
>  and `core.sparseCheckoutCone` depending on your desire for customizable
> @@ -104,4 +104,3 @@ details.
>  +
>  For historical reasons, this extension is respected regardless of the
>  `core.repositoryFormatVersion` setting.
> ---
> diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
> index 618ddc4a0c..2121e8e1df 100644
> --- a/Documentation/pretty-formats.adoc
> +++ b/Documentation/pretty-formats.adoc
> @@ -232,7 +232,7 @@ ref names with custom decorations. The `decorate` string may be followed by a
>  colon and zero or more comma-separated options. Option values may contain
>  literal formatting codes. These must be used for commas (`%x2C`) and closing
>  parentheses (`%x29`), due to their role in the option syntax.
> -+
> +
>  ** `prefix=<value>`: Shown before the list of ref names.  Defaults to "{nbsp}++(++".
>  ** `suffix=<value>`: Shown after the list of ref names.  Defaults to "+)+".
>  ** `separator=<value>`: Shown between ref names.  Defaults to "+,+{nbsp}".
> @@ -241,10 +241,12 @@ parentheses (`%x29`), due to their role in the option syntax.
>  ** `tag=<value>`: Shown before tag names. Defaults to "`tag:`{nbsp}".
>  
>  +
> +--
>  For example, to produce decorations with no wrapping
>  or tag annotations, and spaces as separators:
> -+
> +
>  ++%(decorate:prefix=,suffix=,tag=,separator= )++
> +--
>  
>  ++%(describe++`[:<option>,...]`++)++::
>  human-readable name, like linkgit:git-describe[1]; empty string for
