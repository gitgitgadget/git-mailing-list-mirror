Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F308E285074
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882215; cv=none; b=OqnEAgP3WSgjxilyKdxJjCjYrXpNsW7CBE3frYJwdanfcLgdRzsw5s+Tp7FpQHBadixjb9enWhIqV7bQ5uBg0ez9zgbT4yy/1yUGlfLsWhQkjlXMj6bb/np+vLuFXRQirTcFpZgtnFFwfMyZfitMAccTNcKXN0gxV87ChmqgsUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882215; c=relaxed/simple;
	bh=UgwXaKCLB6k/W1jsFZIaBHYjl2F1GFTgU9SFvMKzVXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=trMt7dJHk4Qxyv2vbbaCdny4HWoL193/1rdxfPEksy02ILB9aBAI62opDC/mJa/IFuh7JrJsKoGT9S5jpx2icR2IVj44fFJAMH8nmcDzoX7b7HHKJFQaAtm2GbM56lY1iqTRB4y7SG5wJbLRiNzk8tzSMNBRNN12C9rtiHnzQCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PkLGR1l/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W1bK0rF3; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PkLGR1l/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W1bK0rF3"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 38802EC010A;
	Fri, 22 Aug 2025 13:03:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 22 Aug 2025 13:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755882213; x=1755968613; bh=D4W5RBsQCf
	NFT6wzheAwM/5HDdxjRq9rZotxqT1zuAU=; b=PkLGR1l/Csr0L08SOEJxcxUjRa
	Lk2SkolUhwjJKAMWwO7blZNCJz6BlkXMIafmAQqLbWSkAxTMBP3gY2OegURSYwf4
	MoOV39My57KN7RakdJ3GXlyDJnAbiE7vITY5hD5NaGisZw8qdQ4NyxE5cg3Stuhl
	JBO0CRiW1Jeb4OqXuqq0Ut1tZIuSVLo/BX5CQu2no+ZQa5XCzgnBKpd/zJX82iaK
	OQTC7Mk/d/4vdqvLajuVX68SOTFXxdXvMaz+KTj4s+OUtExt4umUpFBuVyIfqJcm
	E9bvDGfkpcoO5EbIdOOvFawvfyXCqEOt4K7LC1cTlnHoa/uXei7J472Avrww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755882213; x=1755968613; bh=D4W5RBsQCfNFT6wzheAwM/5HDdxjRq9rZot
	xqT1zuAU=; b=W1bK0rF3I8Jsy/013oip/s1TUn9BwHt9ofKFsqUxRcO+MMljg68
	UPJ4E1r2v4id21Yq7Mqze7RBbFk8wUzVL+x8xYxe7/Mi4u3rBVz+H5UUcoMws/Eb
	OAKoMucSuvdlJAU5NTItc9DZ2tUZREDdgeMxybIZPe9HP6OrvuDix6m+jXFoJVjY
	PzL0D4TMFODle9DHw+mj5CQI0Q62wBV+mgCOF6v15uLUgq4wLCo+DfVVAe2RwBPs
	QZltClr4VoZ4EJxXZQwS0Zco3bY0kxcThLbRdP58VfQwogrRequlUB/Nd3WlYKzh
	x8+5GHLiq2B7wZ7liIlmjqcrT/Y0VTSL8lA==
X-ME-Sender: <xms:5KKoaDe8UfcZfYADSXT6STHDAPxGx8inA0Aj1owzXs_6Dgrq-QxeHA>
    <xme:5KKoaDybhF8Wu0I2Ec4CR_lYYe5OLXU-LbNM2oRQrCr_pBFl19BRrGNz_pAeTDdwU
    oNe8p9d56CTXqwvBQ>
X-ME-Received: <xmr:5KKoaJEOXstMId0FFySNAcxL34IUv9kr1g3ab1NgblieHKdNCuPR3s2f6ktvwhbFma-OkfIJFRDeRcDKhL8AI2dw-7cdu_puFCKxcqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieegfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5KKoaHyvD_F0EV-QjA6N31hSYqsOhvAaHnD_Hb_d08TwHdSGL4-VDQ>
    <xmx:5KKoaKttPVioIwNvO1GWOuEIa6-QfGFU6C_fUD8AD3NP3x-KISuOZg>
    <xmx:5KKoaE1nPq6V57FX4MJ2_CyWrP1Vx3amPKCF0CqDbD6ZeQiQd025sw>
    <xmx:5KKoaF8Qil3JYdJw1AlNUZq1O2QvFiSwX-vcB8-5PNy-llgDyLVV-Q>
    <xmx:5aKoaJu7KS_puR5E51yA2UkdteP-bGptLyEvqIiQUJGra-i5nuN4WOBj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 13:03:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 4/4] bulk-checkin: use repository variable from
 transaction
In-Reply-To: <20250821232249.319427-5-jltobler@gmail.com> (Justin Tobler's
	message of "Thu, 21 Aug 2025 18:22:49 -0500")
References: <20250820225531.1212935-1-jltobler@gmail.com>
	<20250821232249.319427-1-jltobler@gmail.com>
	<20250821232249.319427-5-jltobler@gmail.com>
Date: Fri, 22 Aug 2025 10:03:31 -0700
Message-ID: <xmqqjz2vxp98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> The bulk-checkin subsystem depends on `the_repository`. Adapt functions
> and call sites to access the repository through `struct odb_transaction`
> instead. The `USE_THE_REPOSITORY_VARIBALE` is still required as the
> `pack_compression_level` and `pack_size_limit_cfg` globals are still
> used.

Also we grab the details of the new packfile the bulk-checkin
machinery is building out of the transaction, which made some
redundant parameters functions take go away, ...

> -static void finish_tmp_packfile(struct strbuf *basename,
> -				const char *pack_tmp_name,
> -				struct pack_idx_entry **written_list,
> -				uint32_t nr_written,
> -				struct pack_idx_option *pack_idx_opts,
> +static void finish_tmp_packfile(struct odb_transaction *transaction,
> +				struct strbuf *basename,
>  				unsigned char hash[])

... like this one.  Very nice.

> @@ -117,7 +118,8 @@ static void flush_batch_fsync(struct odb_transaction *transaction)
>  	 * to ensure that the data in each new object file is durable before
>  	 * the final name is visible.
>  	 */
> -	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", repo_get_object_directory(the_repository));
> +	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX",
> +		    transaction->odb->sources->path);

This is doing a lot more than a simple "the_repository" ->
"odb->repo" replacement.  How much confidence do we have
that the internal detail of repo_get_object_directory() will stay
the same and our developers in the future would spot that this open
coded copy needs to be updated if they have to change it?

> -static int deflate_blob_to_pack(struct bulk_checkin_packfile *state,
> -				struct object_id *result_oid,
> -				int fd, size_t size,
> -				const char *path, unsigned flags)
> +int index_blob_bulk_checkin(struct odb_transaction *transaction,
> +			    struct object_id *result_oid,
> +			    int fd, size_t size,
> +			    const char *path, unsigned flags)

Ahh, OK, with the simplification to always take transaction, there
is no need to have the deflate_blob_to_pack() function, which had
only one caller, as an internal implementation detail anymore.

This change could have been in the previous step and it would have
been less surprising; the above "Ahh, OK" is my reaction to the
surprise ;-)

