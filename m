Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0814D27E06D
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750431318; cv=none; b=QUpiRAUeUkygEijH9Bjm1zprwc0fszQOpcJ638cxrOrBLjZzgB2vAwhZPiTMv+EZZqzHFkFVtVSbp8cxldz3lO5TpbCbmxVoMhFZYkUvRpVMB2jaT1aB/13LTMv4H8kVWUgxplqlI2PqWX2fW82q/QeWziiCOdjc500t4Oheb9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750431318; c=relaxed/simple;
	bh=31ZaJE16nO8WgJWR+RnJtBmr9G9ekHzP4X7hdSiFvCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GXWcDUFFY3Ft27sXxov6Ofv2v/QyJoFa0sRyB59jAVpw4lu088BJpH6Bpw5qC6Kl+X+rD81HlAXVw/fqLxRONHHMCbJrCgspaAUxjhGSpXF2ifeRk0SxZHdIKbnP9l7jiUntJyPXNDKKpNuV3ahfXTeuYpqGxIamidvXMYu7Hjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=x620SOF9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mFZizbMb; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="x620SOF9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mFZizbMb"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 11152138046C;
	Fri, 20 Jun 2025 10:55:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 20 Jun 2025 10:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750431315; x=1750517715; bh=nBSkx98ZN3
	3uAk0ZQOKU3VqrXcK7Fozc+4Ro9Uzn0Qk=; b=x620SOF9EdDFfMSUpZSTc1kAJD
	oPrjTHzb+upQld+M/JpAHsahrq7Sam8fwbmnqq9tWz+8TXMIqb9y5/L00igNhhdE
	YnVez8OKiH48Y8Jrnb3lLZ786WWYtU8sNLP6/srXvxYHOmm2vPclCH7kh3tIo7me
	1p90RtX8fdYddXfA/l+uN/G5IBkJgVUkb3Eq52FOIB8bWTf542k2K8kQr5K1Splx
	TwtHiwvywxEu7oVLY41JViMJqWzGU4yo+ZO2rTdmOeQDpv2JO2MBR1zmtqBvzsRm
	8Yu30aB1XdSKRr9OJhotpKK1wIFiV/DjzvefesE4Bne+aLmm5UhtBJNHypuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750431315; x=1750517715; bh=nBSkx98ZN33uAk0ZQOKU3VqrXcK7Fozc+4R
	o9Uzn0Qk=; b=mFZizbMbse1O5ljDw+Q1uecOx5SbSx+3GEMv/x3d5GuQ3rFn+bz
	lYNXFcsZ5qFB5eWDJoHzdZHWxVu4FsUqH1ov6EfrQ9ZiR+KHqOMzo2Gq7Yg/Z70F
	jncAMHPSA9pFoAf9zAVFP7aGMc7RGb1gjaPTUTaxwAoLWF6Az6CzgUSt6H0I202u
	kGxhqg0nG35eRhBKiuEOZJIa/E/5WXOUg56cnxmrdfuXElmFmCbxmOmQzsLjjHqv
	Sbkp6LiJICxIaR4vyMjATNUu0W6GmKoUufdV4Um5bvvGeUIO0wJSnqVtMbFGYTET
	T1zL4jBlqUfLprURlaxsmETm5goU5kAqvYA==
X-ME-Sender: <xms:UnZVaF4LtY3xOs1J8J1Uqt3ucqZxSSwf86Lt1r5QUMWPswIfr42qpg>
    <xme:UnZVaC5n6kTNrBVQTATKjZyQjnJYM6g9DgTBrk5jcC8DTrsQp3-sEbZnNSvjjSj_s
    e59hQhF7W3uEmYnzw>
X-ME-Received: <xmr:UnZVaMeaSer75VWHmrLRtMDr9y_lV0HNyRGJXQiPZQT5eMsYV7x-wShqXHxbCupbREd4t9s-M5SzYIyg8iuBEglqTZYVX89wpFeY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:UnZVaOIcvWiEbMfuc94rdOjndu2t-9L9iTZAEYiM_JRzqb6ujsDyeA>
    <xmx:UnZVaJIcFFlz-LedhQSgaX-sFYQJtU2PgGPCC18jmOfaImXj0oQ1Nw>
    <xmx:UnZVaHzyuXLW51iSLiqnH9xS9mGRmHlppQSxgAvbCRZ8PRvp-3BlJA>
    <xmx:UnZVaFI49W05i6fAHmoPeDxzKKRsihZR3_MO2KZbn7mg5QmfIanc6A>
    <xmx:U3ZVaIXd3FcqExcWQjPj1sjSvw6XcWcHp4K0Gho7rLlhvKQsIc6Fc5XR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 10:55:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 05/10] setup: use the default algorithm to initialize
 repo format
In-Reply-To: <20250620011943.586596-6-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 20 Jun 2025 01:19:37 +0000")
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
	<20250620011943.586596-6-sandals@crustytoothpaste.net>
Date: Fri, 20 Jun 2025 07:55:12 -0700
Message-ID: <xmqqtt4a5upb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> When we define a new repository format with REPOSITORY_FORMAT_INIT, we
> always use GIT_HASH_SHA1, and this value ends up getting used as the
> default value to initialize a repository if none of the command line,
> environment, or config tell us to do otherwise.
>
> Because we might not always want to use SHA-1 as the default, let's
> instead specify the default hash algorithm constant so that we will use
> whatever the specified default is.  

All of the above hints the use of _DEFAULT instead of _SHA1 but ...

> However, to make sure we continue to
> read repositories without a specified hash algorithm as SHA-1, default
> the repository format to the original hash algorithm (SHA-1) when
> reading the repository format.

... this explains why we may want to

 - expect that we would be able to read the hash from repository
 - read from repository
 - if the repository specifies the hash, happily use it
 - otherwise it is a lagacy repository so use the SHA-1

Is that what is going on here?  Because I find some things that
happens in the code somewhat questionable.

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  setup.c | 5 ++++-
>  setup.h | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 641c857ed5..fb38824a2b 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -835,9 +835,12 @@ static void init_repository_format(struct repository_format *format)
>  int read_repository_format(struct repository_format *format, const char *path)
>  {
>  	clear_repository_format(format);
> +	format->hash_algo = GIT_HASH_ORIGINAL;

If we expect we can read from the config, and otherwise we fall back
to the hardcoded legacy SHA-1, do we need this assignment?  We
cleared and version is set to -1, and then we read from the config ...

>  	git_config_from_file(check_repo_format, path, format);

... so if the file said anything about "extensions.objectformat", we
would know it by now.  If not, wouldn't version be left to -1 as our
previous clal to clear_repository_format() set it via its call to
init_repository_format()?

Ahh, this code is prepared to handle a repository that claims to use
version 1 but does not set extensions.objectformat at all.  And in
such a case, we do want to use SHA-1.  OK, the above code makes
sense for that case.

> -	if (format->version == -1)
> +	if (format->version == -1) {

And if there is no core.repositoryformatversion set, we will come
here.  According to the comment before handle_extension_v0(), some
extensions.* should still be honored even in such a repository, and
the above call to git_config_from_file() should have handled them
just fine.

However, I do not understand why we clear all of what we read with
another call to clear_repository_format() here.

>  		clear_repository_format(format);
> +		format->hash_algo = GIT_HASH_ORIGINAL;
> +	}
>  	return format->version;
>  }

Admittedly, I find that the way how check_repo_format() does its
thing somewhat questionable.  Even though it reads into the .version
member the value of core.repositoryformatversion, it slurps in all
the extensions.* regardless of what .version the repository claims
to be in.  So even though there are two separate functions to handle
"historical compatibility" handle_extension_v0() and other extensions,
we still end up honoring extensions.objectformat in a repository that
does not say what format version it uses.  And clearing them with a
call to clear_repository_format() may make sense, but do we want to
clear things we read with handle_extension_v0() as well?

> diff --git a/setup.h b/setup.h
> index 18dc3b7368..8522fa8575 100644
> --- a/setup.h
> +++ b/setup.h
> @@ -149,7 +149,7 @@ struct repository_format {
>  { \
>  	.version = -1, \
>  	.is_bare = -1, \
> -	.hash_algo = GIT_HASH_SHA1, \
> +	.hash_algo = GIT_HASH_DEFAULT, \
>  	.ref_storage_format = REF_STORAGE_FORMAT_FILES, \
>  	.unknown_extensions = STRING_LIST_INIT_DUP, \
>  	.v1_only_extensions = STRING_LIST_INIT_DUP, \
