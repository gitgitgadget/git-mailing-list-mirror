Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD29F1F2B90
	for <git@vger.kernel.org>; Wed, 14 May 2025 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747262885; cv=none; b=nyq1uIkqkHXXzEAf9d6yLcuLdrpYDaA/INsD8VDFPK5PbND1ba9o/70RfrcNnP+a0gZHdwJqRp8qFV2vVsWztrbCpIj5A/m2c2Qnivea6DI5OElzKUnL1InvTXMFhdmTiiiPBBbjTKdpDO+pw2CLL2cCElgUpYEPV3pQn1kCy4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747262885; c=relaxed/simple;
	bh=L9xn/U+rCXq7mFTIO37WIo/hnsRWHcHcUgLMAY/+ZO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOv4KVbxsB2VpxO98yPI7E4b3c89f4jBIsRLeuYPDhnrLBGVatcgQUe8nwTPjfDlzIo7yMZck7AuNzTYeezbgc/F7BbPG/VAHGHqBpRRDKoePNsgs0lo8jtYu+L2IyjGX/WKkpMEw4bVHV6jw76qQkxj1YQELsAAiU9O+q7/vmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W1haZbBE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YtPIcq6s; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W1haZbBE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YtPIcq6s"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 74DA1114007C;
	Wed, 14 May 2025 18:48:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 14 May 2025 18:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747262881;
	 x=1747349281; bh=lWizIpNh2aymv8fOk7y6X5iAcOTRK+iMnlbpatQewBg=; b=
	W1haZbBED3QqAAcjKXa5IIFDSh4SKFfuXPY5tRhuszN+1Inhj95ASDkY9Bx/mNAI
	wUPfOEM+dgIy01XCeRjBvYJhqRj4c9KArfjhJ2lveTFRi4CXKt3+l9GGdUJMqysL
	6Q1QuZPJlDH+IAsAUtDvRkyjOkrqp+1Zu0RrThdAgB2vS+/hM7MFZdtrWnTI8j2l
	+D0wlyMcfTrVZ2KoqtgxFKR/GWbwH/S+WWU5BFD5EZ3oOnFMOucOiPCwmc5HwmgN
	x6QqsqxclIpgoza8Unjj29ehM7sZlUYqpBCEgCQsUCMAasiXptAGeKMmiAp8Ez+J
	TcLUrHtQ1Acm64CnIHPQNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747262881; x=
	1747349281; bh=lWizIpNh2aymv8fOk7y6X5iAcOTRK+iMnlbpatQewBg=; b=Y
	tPIcq6sXSys1VWCOLrsOZFJXZ77Qii/b0PT4tyid37/bxYw3L3wlXR1+tFMh3Mk8
	17ymFXRANdevWl1+EYkhIPBYgOk0SbgKEsRkLXGz88lC4RmOAcU9CIPgTWwIxzRN
	9BCXsABSP7qcW3dlqd+AHKfu23SeUuqSd2eMjmoShN/MfOEsJn3fnzecsKFQvxv0
	2Idzd32GOSXrdFgwGanO5tz65nvIzuOxGYm3od/vllZ5yAT7Ut9BVaatqHq9YxKH
	ZU+epUArJU46JgAJbjTWOoyuSHs83liz7fkuayHPFaxnZ1OBBFOH/ZMmUi0UabIT
	WkPHt9MHIJruL0/dfUZZA==
X-ME-Sender: <xms:oR0laBLeBRP9B2LY6QD_ealz9pwQmE-3wkZLv5DMfp9_qVXYCIHPVA>
    <xme:oR0laNLVkfvp_8w8UARKuoWa3op0ianFz95R_VtgRQ5D4MyABGZTIgUVva_zUzvy5
    hpiWrWrhtV9bPdvDw>
X-ME-Received: <xmr:oR0laJsOK1QkjbbcMHiBwQVzJxz38CcrOb4xxvfI_cAiYU0PYAaPvNYKWv7R-pyJpA3vOhVx8kq0r0mLNvJv_CA0e7mrHQ3CU3IDhDE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdekvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrgihrghthh
    gvvghrthhhkhhulhhkrghrnhhivddttdehsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:oR0laCbmO6sfT8qSDmYZfUvMuIhEHUMnI2xRi1aQLia9m5ucRqDRLQ>
    <xmx:oR0laIbmkhTPzLo7ZN0-krKa6JfW7ztBxXayBNfVRAHoitvaxbxX1A>
    <xmx:oR0laGAnF_bPOvwzVXSvAiW6SJpuobbZgDv4M4g35iST3-Xjd8Z_iA>
    <xmx:oR0laGaVWZQvCsuNazLwnMZhis_tZXcFkxb7WpJ7TQKXWxIg8pLnAw>
    <xmx:oR0laA38wRRnloWoGBNHsfcJpbG1-Ro4Sy4bw4WjtOudUzrJij8HNqhX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 18:48:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] submodule: prevent overwriting .gitmodules entry on
 path reuse
In-Reply-To: <20250514020108.24396-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Wed, 14 May 2025 07:31:08 +0530")
References: <xmqq7c2kgp8e.fsf@gitster.g>
	<20250514020108.24396-1-jayatheerthkulkarni2005@gmail.com>
Date: Wed, 14 May 2025 15:47:59 -0700
Message-ID: <xmqqplga6c80.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Add helper `submodule_active_matches_path()` so we can
> re-implement the old “is this path already covered by
> submodule.active?” logic without re-reading the config twice.

Having duplicated code to implement what is supposed to be the same
thing is a bug waiting to happen by them diverging from each other.

Isn't the fact that our configuration reading code reads things just
once and the caches the result good enough for the purpose of this
code path?  Do we have a measurement that tells us that the extra
complexity is worth the maintenance headache?

> @@ -3443,7 +3452,11 @@ static int module_add(int argc, const char **argv, const char *prefix,
>  	int force = 0, quiet = 0, progress = 0, dissociate = 0;
>  	struct add_data add_data = ADD_DATA_INIT;
>  	const char *ref_storage_format = NULL;
> +	const struct submodule *existing;
>  	char *to_free = NULL;
> +	struct strbuf buf = STRBUF_INIT;
> +	int i;
> +	int allocated_sm_name = 0;

A separate flag is not wrong per-se, but the idiom used in this
project more often is to have an extra pointer variable that points
at an allocated piece of memory (or NULL), and free the piece of
memory unconditionally.

"git grep -e to_free" to see the idiom in action.  Even better yet,
this codepath already uses the idiom.

By doing so

> +	if (allocated_sm_name)
> +		free((char *)add_data.sm_name);

becomes

	free(sm_name_to_free);

and we can keep the "add_data.sm_name is pointing at a borrowed
piece of memory, and we will _never_ free anything through that
pointer" memory ownership rule.  We were borrowing from a separate
variable sm_name_to_free, and we may free it when add_data is
getting destroyed, or we may be borrowing from the .sm_path string,
which we would free it when add_data is getting destroyed.

>  	free(add_data.sm_path);
>  	free(to_free);
>  	strbuf_release(&sb);
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index d6a501d453..5c3f471338 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -1482,4 +1482,27 @@ test_expect_success '`submodule init` and `init.templateDir`' '
>  	)
>  '
>  
> +test_expect_success 'submodule add fails when name is reused' '
> +	git init test-submodule &&
> +	(
> +		cd test-submodule &&
> +		git commit --allow-empty -m "initial commit" &&
> +
> +		git init ../child-origin &&
> +		git -C ../child-origin commit --allow-empty -m "initial commit" &&
> +
> +		git submodule add ../child-origin child &&
> +		git commit -m "Add submodule child" &&
> +
> +		git mv child child_old &&
> +		git commit -m "Move child to child_old" &&
> +
> +		# Create another submodule repo
> +		git init ../child2-origin &&
> +		git -C ../child2-origin commit --allow-empty -m "initial commit" &&
> +
> +		test_must_fail git submodule add ../child2-origin child
> +	)
> +'
> +
>  test_done
