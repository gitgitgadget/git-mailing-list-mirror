Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093073F54AC
	for <git@vger.kernel.org>; Tue, 12 May 2026 05:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778565288; cv=none; b=MZlg4Vp1t+eJ2nwdmRTabVFvmZ61Cquj+RWuN3xtdWZEmwfnX+xl16FZhrgFguVR0zmAXIJ1O0rDBZh5my7hIFoEBWxm94NZgaiZbySsEzfOkwYSRbvGmSZDBgCmIHKiHRc+ZTgxvFhEDM/UopCAjkDdNPkmhtLc5c5swx7v7FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778565288; c=relaxed/simple;
	bh=ccf1mcnDjafCdWg/VJBy0qa7z5gI+MTAtCIxltK8NjQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qgu5RacaBP83bTpBkRM8Pj5gzEQ00zbGhaCBOB2Qvhny1mFkpehgQPEmr8QlaAFnnFrbG3TSuFMbfXKjHtlx/3CLbiefC5Cmi6hu4y4lyg9fDw0ytknC4VTz8309/vXb0JEPUPQ18SqA9SHKXy93PL7KoBLzR56P0P2zFl0gGmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sYRF2a0u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oPR57fgB; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sYRF2a0u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oPR57fgB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DD48F1D000A6;
	Tue, 12 May 2026 01:54:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 12 May 2026 01:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778565262; x=1778651662; bh=ZKJAdpLBUo
	f7aAjICIddKXvXxdW2eci8oBIkiLWRhXM=; b=sYRF2a0uJjDtaFjRC7cma4pCdh
	SydXjTCTNJg7/CYb4bjG1rBjhqW86fzpUWh24SoE+hRBIO8O1DqPYktC2PDTPBTJ
	v3ESNJdOSlY4gT90qV9FsDGWhetNBTGd1fARv/TWxJ5wGHhrKp+BfxWow95MRbCh
	W8QGWpSWGphU/WlFvc2Xiaa4AuTooeNwyLyjttXx2mvUK7X24LqxmhxLzmuuJyfa
	ifqLWNnq+PPUMV3eoAtMfxBygvWoNp8zc6jhu6UwQlzxuH3IANTVKRx483YaNwr2
	uRftubMGtt5UUlGJR+/gXkqdx05DfCHeJiZoSPSdY2WnqF+9ULOpxXE+AAhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778565262; x=1778651662; bh=ZKJAdpLBUof7aAjICIddKXvXxdW2eci8oBI
	kiLWRhXM=; b=oPR57fgBqrd0tp1rg6nMF5NPGp2hKxDzpP42yZMoqzCB4F6QpYE
	Wxvk8zHjYbN2s05TAOWLHA8fMQIqXd8+dvVjeyduqTf+1rIClT5xPkL6wJiLgHq8
	o+pM4MlXioeLposODiL3TIj3uR1slpK43DeIsy1JhwmtctjN0pbWorwd+L3hA9Tr
	cXCGaHmoR6ThmGomfLJxXsWV5S+fpr+cPT8kt8YjMOAPhBgJVmPlzhI+Pec1aP7X
	erfBpdCvU3gBcAJFX79ta8551oSuUxLgqhuWVQ2ey4go1gknf/tggS10RxDVwD5i
	GaaPeczWhCpAwSsdaHX5X0fNA+YUltwb6AQ==
X-ME-Sender: <xms:jsACarDfVC9O54re0TVVWTldztL3jvKIEQK_AXcHMFIi6mgAoDEjsw>
    <xme:jsACaoZEiFnY1XgBcTiSqAo0iBQ6_HwchhV5wCz0Ib0ou_m-XQMz0IL6-WzzlrOCv
    biqRyJTqClg8mt9Z5Z0GEoD9_YL4e2xjK_IKAxVEqv2DbIEJjoKyQ>
X-ME-Received: <xmr:jsACau4jMI8Dmw3z49RZkHXX3WTveDly51023nEoD-n7rFkxDpw2fgNGcfsaBRCBtlC37DNQLf-kueUlNLPMcwzlZFt-xFHARA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddutddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkuhhshhgrlhesshhunhgvthdrshgvpdhrtghpthhtohepnhgvfihrvg
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:jsACapZK0ECbyN_z213RB5Qgi62evrWdmiafIg9dDfegfB5OBJ8VkA>
    <xmx:jsACathCEMcN5B1OhlsLxIZxdPY543T2G9BbjPvOpM6uzmMWxphpwQ>
    <xmx:jsACaq_fFlHGT102fjzUMuHJUL8NAjT403ZA1PjsM-TwMrLyYA76eg>
    <xmx:jsACaoq_QWFKnSQJrzUeyumTmwWssnQA3OUECjBpmgSiWFWuEnEf5A>
    <xmx:jsACag3NuyY6Tu0kRi4cV1k6MlGD2VTQmIVxd6T-vhRioPIR8-A_8JNa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 01:54:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Kushal Das <kushal@sunet.se>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 2/2] commit: sign commit after mutating buffer
In-Reply-To: <20260427221834.1824543-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 27 Apr 2026 22:18:34 +0000")
References: <aeakf0xcjSteTMZp@fruit.crustytoothpaste.net>
	<20260427221834.1824543-1-sandals@crustytoothpaste.net>
	<20260427221834.1824543-2-sandals@crustytoothpaste.net>
Date: Tue, 12 May 2026 14:54:20 +0900
Message-ID: <xmqqtssdnpf7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The ensure_utf8 function can mutate the buffer to change its encoding,
> so we must call it before signing the buffer so that we do not
> invalidate the signature, which is made over raw bytes.  Fix a bug which
> caused the compatibility code to not convert the compatibility buffer if
> the main buffer was invalid UTF-8.  We expect both buffers to be valid
> UTF-8 or both invalid, since the only data that would differ between
> them would be hex object IDs, which are always valid UTF-8.
>
> Add a test for this case using 0xfe and 0xff, which are never valid in
> UTF-8.
>
> Reported-by: Kushal Das <kushal@sunet.se>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  commit.c                 | 15 +++++++++++----
>  t/t7510-signed-commit.sh | 10 ++++++++++
>  2 files changed, 21 insertions(+), 4 deletions(-)

This iteration hasn't seen any reaction but comparing it with the
previous round and peeking at comments that the previous round
received, I guess everybody commented on the previous round is happy
with this version.

Let me mark the topic for 'next'.

Thanks.


>
> diff --git a/commit.c b/commit.c
> index 790dd2faed..e5d725fe93 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1726,6 +1726,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
>  	struct repository *r = the_repository;
>  	int result = 0;
>  	int encoding_is_utf8;
> +	bool warned = false;
>  	struct strbuf buffer = STRBUF_INIT, compat_buffer = STRBUF_INIT;
>  	struct strbuf sig = STRBUF_INIT, compat_sig = STRBUF_INIT;
>  	struct object_id *parent_buf = NULL, *compat_oid = NULL;
> @@ -1747,6 +1748,13 @@ int commit_tree_extended(const char *msg, size_t msg_len,
>  		oidcpy(&parent_buf[i++], &p->item->object.oid);
>  
>  	write_commit_tree(&buffer, msg, msg_len, tree, parent_buf, nparents, author, committer, extra);
> +
> +	/* And check the encoding. */
> +	if (encoding_is_utf8 && !ensure_utf8(&buffer)) {
> +		fprintf(stderr, _(commit_utf8_warn));
> +		warned = true;
> +	}
> +
>  	if (sign_commit && sign_buffer(&buffer, &sig, sign_commit,
>  				       SIGN_BUFFER_USE_DEFAULT_KEY)) {
>  		result = -1;
> @@ -1780,6 +1788,9 @@ int commit_tree_extended(const char *msg, size_t msg_len,
>  		free_commit_extra_headers(compat_extra);
>  		free(mapped_parents);
>  
> +		if (encoding_is_utf8 && !ensure_utf8(&compat_buffer) && !warned)
> +			fprintf(stderr, _(commit_utf8_warn));
> +
>  		if (sign_commit && sign_buffer(&compat_buffer, &compat_sig,
>  					       sign_commit,
>  					       SIGN_BUFFER_USE_DEFAULT_KEY)) {
> @@ -1818,10 +1829,6 @@ int commit_tree_extended(const char *msg, size_t msg_len,
>  		}
>  	}
>  
> -	/* And check the encoding. */
> -	if (encoding_is_utf8 && (!ensure_utf8(&buffer) || !ensure_utf8(&compat_buffer)))
> -		fprintf(stderr, _(commit_utf8_warn));
> -
>  	if (r->compat_hash_algo) {
>  		hash_object_file(r->compat_hash_algo, compat_buffer.buf, compat_buffer.len,
>  			OBJ_COMMIT, &compat_oid_buf);
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 1201c85ba6..aa9108da54 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -462,4 +462,14 @@ test_expect_success 'custom `gpg.program`' '
>  	git commit -S --allow-empty -m signed-commit
>  '
>  
> +test_expect_success GPG 'commit verifies with non-UTF-8 commit message' '
> +	printf "I hate\\376\\377UTF-8\\n" >message &&
> +	echo unusual-message >file &&
> +	git add file &&
> +	test_tick && git commit -S -F message 2>err &&
> +	git verify-commit HEAD &&
> +	grep "commit message did not conform to UTF-8" err >lines &&
> +	test_line_count = 1 lines
> +'
> +
>  test_done
