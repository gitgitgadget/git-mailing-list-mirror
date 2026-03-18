Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB52253359
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852187; cv=none; b=MlN+0RLiKdsKSeasn8IZfTqDuqYnEI2TfJ87RVzfhjvbU95We9tquYMVyBL90QlR1Dt4cF8xi8pEvroFJLtZtfK3G3lOdYFEaemtw2NCG7Z8l4Ztw8d733zjZQ4T2nYfTUAtny9JV+/Oem7goJI/uzGtH810Yff/AFyyWki0fEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852187; c=relaxed/simple;
	bh=ThVj8GytubT972lRRNT08iYWcH6kbPnwb5GEB9gt3n4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rge80pgC7+j8PwZpls0B2yP4CfLVaorWYETK4S+bosNRQCExz9gQYGr6hNTsLyCOsrd5tZ16LiJDWWYLtGEzSZNO1dBAU/ZhwVqmJ4JqqSOdateSaKBwF3mA6U09JNhr2XGvG+xGfR/QBzrKATeBOYecPJKKlyEytZIYISkkPAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EjEB57E2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MhbeleR2; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EjEB57E2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MhbeleR2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 39087EC01E5;
	Wed, 18 Mar 2026 12:43:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 18 Mar 2026 12:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773852185; x=1773938585; bh=aM9+2pS55Z
	mBDrzxJg1SEWM+Au5HGxNWOSXhi48UhIA=; b=EjEB57E2KmkvTwbvgFldALL8wp
	D4S7A3ucNx5FOJhbrO+ulqko+5Ut2qefmF2a01tpRr/l+L+uCbl5VIx1ScQpVFgd
	Dptxf8BYgZSfRmnbqLXutNFI+AJ+OmSVOEMoQo1txJPk+Pk8jxD7CvFKbCdv3jV3
	bIol0/FV57ZMWLSZokKgkCzaYqyuaJHjv4NYd8yuZQrgGbmXVjAhwfeIyKdZiMQt
	ubxgdqLpMBd/HcyPCpC34iP9b3soDOjCh/DL6KpcNWjEtaW6U/O9fF4z7zNKzTga
	93O0NY7+iOE3Z4x/mkECmzaSHcRfTDCU+gELfM2bsxXLMlF0o13MqFv1+YhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773852185; x=1773938585; bh=aM9+2pS55ZmBDrzxJg1SEWM+Au5HGxNWOSX
	hi48UhIA=; b=MhbeleR21a+YYxkU7LvqyA+EcTnEipgmQI5nr0ZRzxe3yJSu4bm
	AAU+Vx4L8SwTma2AB69jsHqqIO0tsMHvCNzz3fLKcxQaQtmgNFxe/VVcE1X2XoFy
	tRA7u/Iide7HeceC7FQd1+sU81lYgDlpSQNEEPCexDkK4i7tUbFWitdPS/4RsMCE
	5ZxgpJllbA5joYDnmyv0k/YZOtSquyWo5ILhql4+SxTicxiA+dT3b1LOhTaX43I+
	PGVksfe/Hlj7OakhKHcCvRfSgMn4xsI6Mt2VUTZk79EZkhf0684wbD+6ASlKtxS+
	T6dxTiZeLTaXBOWc99N8cKW+zKHqD/c9BeA==
X-ME-Sender: <xms:Gda6aQ0qf3D2Cvy5suYglyi7uzlo7ZKWw5rrQEBul-Wn53T52noTTA>
    <xme:Gda6aSiNuuEc_Mz7i2m6MHi0c4LhAmQAI3eODy7z3M5evavAEM_bHyICJA6-q62wq
    -bjrvub_XOjPf8Q-HWxROq0sy4P3PrFDWc9wpFmgtdMz0Sl7m0LnQ>
X-ME-Received: <xmr:Gda6aWQSnryQ9OvFJ3XsOnWVtjcW08z-OBehLjzUNj3zFCu5QqFy8P0pV2OPKrytW7654Za1lUkdbw2U95juwooSgdP0hcI_Qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdegieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefgteejgeduveeuteeiudfhhfegud
    dtjefhjedvffelteelhfdtveejueehudffueenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhhrhgvhigrnhhshhhprghlihifrghltghmshhmnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Gda6aTgwzuju1i6o-O7ap18aqZ-fxsev4sPom3Rb2lcUdtpqfj7Rfg>
    <xmx:Gda6aW5THs01HlTFVf56A8mTSDIArjKnxAeGgGyF7_gOksCQeQNiHg>
    <xmx:Gda6aQDb1-ztDu-hBETFX7cr0uTBL9mgPReBBiF5rVx7kirFTx7kJA>
    <xmx:Gda6adZIfRgLZ879eRRFkSKIe6gqLqhaonz6hz_En73yQbBPFDH9Nw>
    <xmx:Gda6aWg5hRuGVU8Lq5C8P2rZ5AKkvAeCZ-eca_RQ6iz5zJMOFBEFjQLS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 12:43:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 ] add-patch: use repository instance from add_p_state
 instead of the_repository
In-Reply-To: <20260318090546.1213077-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Wed, 18 Mar 2026 14:30:03 +0530")
References: <20260317155230.619378-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260318090546.1213077-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Wed, 18 Mar 2026 09:43:03 -0700
Message-ID: <xmqqbjglgkbs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> Functions parse_diff(), edit_hunk_manually() and patch_update_file() use
> the_repository even though a repository instance is already available via
> struct add_p_state *s.
> Use 's->r' instead of the_repository to avoid relying on global state.
> All callers pass a valid add_p_state and this does not change any behavior.
>
> This follows recent refactoring that removed 'add_i_state' and moved
> repository pointer and other add-patch config into struct add_p_state [1].
> This aligns with the ongoing effort to reduce usage of the_repository
> global state.
>
> [1]- https://lore.kernel.org/git/20260302-pks-history-split-v1-3-444fc987a324@pks.im/
>
> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> ---
> Changes in v2:
>  - made changes on top of ps/history-split and used s->r instead of s->s.r

Good.  Brief and clear description on what this patch was based on.

Thanks.

>
>  add-patch.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index 4e28e5c187..f27edcbe8d 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -558,8 +558,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>  		strvec_push(&args,
>  			    /* could be on an unborn branch */
>  			    !strcmp("HEAD", s->revision) &&
> -			    repo_get_oid(the_repository, "HEAD", &oid) ?
> -			    empty_tree_oid_hex(the_repository->hash_algo) : s->revision);
> +			    repo_get_oid(s->r, "HEAD", &oid) ?
> +			    empty_tree_oid_hex(s->r->hash_algo) : s->revision);
>  	}
>  	color_arg_index = args.nr;
>  	/* Use `--no-color` explicitly, just in case `diff.color = always`. */
> @@ -1271,7 +1271,7 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
>  				"removed, then the edit is\n"
>  				"aborted and the hunk is left unchanged.\n"));
>
> -	if (strbuf_edit_interactively(the_repository, &s->buf,
> +	if (strbuf_edit_interactively(s->r, &s->buf,
>  				      "addp-hunk-edit.diff", NULL) < 0)
>  		return -1;
>
> @@ -1679,7 +1679,7 @@ static size_t patch_update_file(struct add_p_state *s,
>  		if (file_diff->hunk_nr) {
>  			if (rendered_hunk_index != hunk_index) {
>  				if (use_pager) {
> -					setup_pager(the_repository);
> +					setup_pager(s->r);
>  					sigchain_push(SIGPIPE, SIG_IGN);
>  				}
>  				render_hunk(s, hunk, 0, colored, &s->buf);
> --
> 2.53.0
