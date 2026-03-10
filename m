Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B77399343
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182033; cv=none; b=QPFGbigLdb/VJeFvlydG88ZytArJWqgmdjt/PWlRGV0Ar/DHJE5CK/JULhPJR09zRzu0imTbC4aFB40FgBLDdNXJcNvwQ+KuBrvhNYYwZklamhPbCt5M513igOr9Hj98agJB/qujMAGnHF/6VjXpdcetbX0evhwyq6GiM0NR/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182033; c=relaxed/simple;
	bh=vCnIJUcQ578tB2RlR2Y7LVEY2r/tk5DNNgJSRFtyCHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HG7tfRxEWiqLF9mQkmhyXV7cquRR61XwHOT72KrjO/DapjLESfq/Wxv54Ww72CRlmnLRtRYTxxjCTviZc/+E3F502mAehviP8tbNBF7HHKPFJ5k2ZnQxUXNX9u9uw4Ecc3YmUzAkCzH4ZxT4Z+uV9YV5Y7Suk0Fk+djp/qC+GaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QlM3Ajz5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KWtlBKtO; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QlM3Ajz5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KWtlBKtO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F6A6EC006E;
	Tue, 10 Mar 2026 18:33:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 10 Mar 2026 18:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773182031; x=1773268431; bh=b8iYlt99Et
	TPI84iCyfow/cj8tqXFCgIa4u21DSWfcw=; b=QlM3Ajz5gmCvP5DpQn790Zxlyu
	a+93M6i5ohdK95XmqOliBAjVXV3FR+iXESCjb1x4phUeGGPP38Ve8UgBGrpUXd+C
	n/LGuu5RX0vTbPck+n5R8tHHXBunFbke1qba81CbD6RebOnZV+mw0UXzfLbNyI7j
	R0kMAjfFfv6DP3mTa2UT1H4Z8x6LVHXh61VFF1rS5hpKwDKLTSxQLzXCPGeXFOVy
	d6CXbWPiX9ly2sjFCsZcGjAXFsdKSy771oRtsnOoP2PptTJnEg01xgT4KIy11QuZ
	YU5yexJ2dKJ7b/ZP8t449aYmJfi3QJZmpsLv1WsnUhR6q1mJTFdcV35D5o6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773182031; x=1773268431; bh=b8iYlt99EtTPI84iCyfow/cj8tqXFCgIa4u
	21DSWfcw=; b=KWtlBKtOdU5b0Ht/O1ENEEsFnuK1Pq+kJqXen4NBN72zLQopARq
	dMtFFVRGuRgGh9haHJhkAtsdHoGpjdUaVj6afU+sFQ/lHnT4MIHjhdUDaLUQxLMN
	d2eszQvti3sTfaJbjRb1qOEW3hWrzdHMcKRhDoi73obJ5IqWCoaP3aDzw+ONZPh7
	hsX4J9jHUohGIHfa5uum0bNMqWO+LcOo3E8uaVM6hzJ2MPnNrgwxbii3gR7xVBaD
	czPtZTrQ5WkKR9X81CX8mQFNJRsxmlNZgs7ng7irjUvf4ZfwlRJUtivIrE8lojBc
	YC5WzINcjcDZLmmeFJkLtcXinccIm8qdHaQ==
X-ME-Sender: <xms:TpywaTs_BGJIXpT7FR_UibyGwD8RbgH8ki13PvULWIHKbS4rFUj6Lg>
    <xme:TpywaYIvc_h7HjqTJZYi54Lg-ObV8Ine6MiQFf1eAnu3zzZSmX39FhcuMB8Ulbod0
    4jAEAXRHWHon1M2aQSYQ3wF4atwnD5u3UEJaxCCn6lVsnBweworyg>
X-ME-Received: <xmr:TpywaQlhVRaEh8i4SmzJfbWFxkCYrgVbxCfg3Kpgq_dsYqQ4PSubY_N2P13YEzEn-eO1PotOrH8a_XQYna7Mb6cHUjwls1KicQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegthh
    hrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TpywaZLWwV1DMJ8RPNT5EfXb0Ine9L9NLkfeoVcctCf3w06-XaMGow>
    <xmx:TpywaV5XXeMkqGXqvGCx5eIh7_1YroE35JHnJrTCfbfflF9aSZRz-w>
    <xmx:Tpywad3FFEkjAqYVG22FPcznUBMgVWj4ijDlrp_KMeT9y3sNJ3RdiQ>
    <xmx:TpywabdDYeNzb8mf5szjTHBiz6SBpvxEYQz4KxPh6i28GCA-DiebvQ>
    <xmx:T5ywaaboRDD6aNpsjIDXEBBAXGMU0cAk2JNiLsdo_gYn9UNhUNPSubhm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 18:33:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net,
  christian.couder@gmail.com,  ps@pks.im
Subject: Re: [PATCH v3 2/3] gpg-interface: introduce sign_buffer_with_key()
In-Reply-To: <20260310201116.1130160-3-jltobler@gmail.com> (Justin Tobler's
	message of "Tue, 10 Mar 2026 15:11:15 -0500")
References: <20260306205359.1723254-1-jltobler@gmail.com>
	<20260310201116.1130160-1-jltobler@gmail.com>
	<20260310201116.1130160-3-jltobler@gmail.com>
Date: Tue, 10 Mar 2026 15:33:49 -0700
Message-ID: <xmqqcy1bs4aa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> The `sign_commit_to_strbuf()` helper in "commit.c" provides fallback
> logic to get the default configured signing key when a key is not
> provided and handles generating the commit signature accordingly. This
> signing operation is not really specific to commits as any arbitrary
> buffer can be signed. Also, in a subsequent commit, this same logic is
> reused by git-fast-import(1) when re-signing invalid commit signatures.
>
> Move the `sign_commit_to_strbuf()` helper from "commit.c" to
> "gpg-interface.c" and rename it to `sign_buffer_with_key()`. Also export
> this function so it can be used by "commit.c" and
> "builtin/fast-import.c" in the subsequent commit.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  commit.c        | 16 ++--------------
>  gpg-interface.c | 13 +++++++++++++
>  gpg-interface.h |  7 +++++++
>  3 files changed, 22 insertions(+), 14 deletions(-)

Sennsible restructuring that makes the machinery easier to reuse.
Updated function is named more appropriately for public consumption.

Overall a very welcome preparation step.

> diff --git a/commit.c b/commit.c
> index d16ae73345..1677b1ef25 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1148,18 +1148,6 @@ int add_header_signature(struct strbuf *buf, struct strbuf *sig, const struct gi
>  	return 0;
>  }
>  
> -static int sign_commit_to_strbuf(struct strbuf *sig, struct strbuf *buf, const char *keyid)
> -{
> -	char *keyid_to_free = NULL;
> -	int ret = 0;
> -	if (!keyid || !*keyid)
> -		keyid = keyid_to_free = get_signing_key();
> -	if (sign_buffer(buf, sig, keyid))
> -		ret = -1;
> -	free(keyid_to_free);
> -	return ret;
> -}
> -
>  int parse_signed_commit(const struct commit *commit,
>  			struct strbuf *payload, struct strbuf *signature,
>  			const struct git_hash_algo *algop)
> @@ -1737,7 +1725,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
>  		oidcpy(&parent_buf[i++], &p->item->object.oid);
>  
>  	write_commit_tree(&buffer, msg, msg_len, tree, parent_buf, nparents, author, committer, extra);
> -	if (sign_commit && sign_commit_to_strbuf(&sig, &buffer, sign_commit)) {
> +	if (sign_commit && sign_buffer_with_key(&buffer, &sig, sign_commit)) {
>  		result = -1;
>  		goto out;
>  	}
> @@ -1769,7 +1757,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
>  		free_commit_extra_headers(compat_extra);
>  		free(mapped_parents);
>  
> -		if (sign_commit && sign_commit_to_strbuf(&compat_sig, &compat_buffer, sign_commit)) {
> +		if (sign_commit && sign_buffer_with_key(&compat_buffer, &compat_sig, sign_commit)) {
>  			result = -1;
>  			goto out;
>  		}
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 87fb6605fb..a72fa35061 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -980,6 +980,19 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
>  	return use_format->sign_buffer(buffer, signature, signing_key);
>  }
>  
> +int sign_buffer_with_key(struct strbuf *buffer, struct strbuf *signature,
> +			 const char *signing_key)
> +{
> +	char *keyid_to_free = NULL;
> +	int ret = 0;
> +	if (!signing_key || !*signing_key)
> +		signing_key = keyid_to_free = get_signing_key();
> +	if (sign_buffer(buffer, signature, signing_key))
> +		ret = -1;
> +	free(keyid_to_free);
> +	return ret;
> +}
> +
>  /*
>   * Strip CR from the line endings, in case we are on Windows.
>   * NEEDSWORK: make it trim only CRs before LFs and rename
> diff --git a/gpg-interface.h b/gpg-interface.h
> index 789d1ffac4..a32741aeda 100644
> --- a/gpg-interface.h
> +++ b/gpg-interface.h
> @@ -83,6 +83,13 @@ size_t parse_signed_buffer(const char *buf, size_t size);
>  int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
>  		const char *signing_key);
>  
> +/*
> + * Similar to `sign_buffer()`, but uses the default configured signing key as
> + * returned by `get_signing_key()` when the provided "signing_key" is NULL or
> + * empty. Returns 0 on success, non-zero on failure.
> + */
> +int sign_buffer_with_key(struct strbuf *buffer, struct strbuf *signature,
> +			 const char *signing_key);
>  
>  /*
>   * Returns corresponding string in lowercase for a given member of
