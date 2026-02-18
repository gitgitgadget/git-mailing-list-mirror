Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86183009D6
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771436770; cv=none; b=QXN605yc39BHRWKpRU0GoA//D3yz/DN+p9YCetlRV70vOV5zsc5uGUqN4XVBXyu4c0ztMEhMoIqf4QmAsiJTmh3bmTpOCtBeidDsvcKoaXBwLvg37QUPlQf+w71KwrnA+tkGd+A9D3Tur7Hsuikze4SMkcHrvZNR6dkySx9X4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771436770; c=relaxed/simple;
	bh=/yt+J3/YoG11hnMfjlPZQm8lzaFwyPUrLM7eAguGyq0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lbKC7s76uIeEwIaMCJocs7XeIrUVx9Pu20VaCBkgjQUsDIF70UCk2SQHybUqkpi0raSLqlDQsOEYHJ5nyfeleGO8sX1jMN7G46Q4F6n8D1lXk5ef/k+yHnAYwWXfGwuQadvmjciBGGW2i0wUlCswnKlo4mWfGhD2NdH5ZQ2GYNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vBH3Fwo+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iitVpPTd; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vBH3Fwo+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iitVpPTd"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B65BC1D0009D;
	Wed, 18 Feb 2026 12:46:07 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 18 Feb 2026 12:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771436767;
	 x=1771523167; bh=/EzTCRWGMR61gM/d02yOtJs314NuAMsnRAMVbDK6tPk=; b=
	vBH3Fwo+GZ2yT6DKRy9R9ERVt2sa4Z1EMfWiTkHLtEDD/UfP4RDDZqNIcvBEyJ+L
	fQ7Cw5yDYL8pxaEqGycXjlltdrAGhRDOmQprxJ6GpAS6a20AEk51xtP/8xVhz6WT
	S5Y2R3NKaBvj0AKnvu/0G9+vlZnl0BGonwlw94sLyDkMtAmILzu5oaiRD2HZFkpB
	oUsBVkdU/iPIw0AEr80kNikh8OywA5gwHn8gxNu/+YyUf8+qj+5ET8QOXsSoEgKb
	G49ISKjyd1/TyXzQzjDMVI24zNMmRj+KCYJt00n/xbT+0331oBO8TOJVK6uNnuWB
	3uzIdHHO2hJzHtEYjcFumw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771436767; x=
	1771523167; bh=/EzTCRWGMR61gM/d02yOtJs314NuAMsnRAMVbDK6tPk=; b=i
	itVpPTdkOtX3JBJbKWoxuo3OjFV7RRghFn9Qor/7W7FaLtdLLTzUHRMEpfZRyre6
	5/lhXufqbddW0GW87vOWgGTz2YQCY05WhVCVF3afDSHGLvzQ/nF/Ns7lnQSybu2x
	dNy36XinkYSzLiAGkSgeBlcF1Q77FnzGfkSG4Czy1rmvmm2SqwJzCB/NWiT4f/Fs
	VarSy1vG7NBnDoiupaoiJxKE8qxHk29yekgu1pjz1t4Zed9m+0mhDSXceXWerTCq
	B83Z/nn5Co8uWrIc79IQrPlPpC9bS4wHbmj5MPWQs0yKCcDDoJ8RGcqhStOoUxyt
	XbQGPrOox1gCGfovWld/A==
X-ME-Sender: <xms:3vqVaQ1EV3un_GpvAOHAcOAlAm66tAZM8sC_mTi-s_Kfxnaf-4bpRw>
    <xme:3vqVaSFodlDnA3z0AAiJ28kxW_yw2p1lSuEXN4lgILdtZRwWk3N-zr1wOeSQbuNDr
    AKxhTb7maCRUW1d0LApF5YSHgLlZ_7W_g0ZaSW54eJBO_ly063pdQ>
X-ME-Received: <xmr:3vqVad4JTq4rNM26YtoWjsU7OHJUQxPhBBz0Cw1lt2iSRZ6ZJmH86TG7XgvxMU8zyxXBvAs8khL5wQU3v5mSZ4AL1P6flTLKlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdefvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhstghoohhlseht
    uhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:3vqVaYu138lMvzAUafPXWnYZIwnSNc6d44AsCX4g80m3T_Qsyz58NA>
    <xmx:3vqVae5jwIRORbJVMfhho3JIpWUlkSWvy-K6LoiDlvBkKP5aXVGiPw>
    <xmx:3vqVaTWusDFlHCVHIdbCx9MwFYqdP__-n-6y42hGoQlgtGbHj65gUg>
    <xmx:3vqVaQ_ehPtaQB7MA0idItDBkfyHMU4O7hRBfjRMTO5WnNhkJuy1dg>
    <xmx:3_qVac0E7ghOT6IwqmcjZFKnYFZOkfVTTg513qWX4EXqJnbypf2JBuEw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Feb 2026 12:46:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 5/5] t6006: don't use iconv(1) without ICONV prereq
In-Reply-To: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-5-08c1ff3ffc9a@pks.im>
	(Patrick Steinhardt's message of "Wed, 18 Feb 2026 05:38:42 +0100")
References: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im>
	<20260218-b4-pks-ci-msvc-iconv-fixes-v3-5-08c1ff3ffc9a@pks.im>
Date: Wed, 18 Feb 2026 09:46:04 -0800
Message-ID: <xmqqfr6y7xnn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> Two tests in t6006 depend on the iconv(1) prerequisite to reencode a
> commit message. This executable may not even exist though in case the
> prereq is not set, which will cause the tests to fail.
>
> Fix this by using UTF-8 instead when the prereq is not set.

The above makes perfect sense, but would the rest of the test
involving this data need to be adjusted to expect utf-8 instead of
$test_encoding when iconv is not available?

> -iconv -f utf-8 -t $test_encoding > commit-msg <<EOF
> -Test printing of complex bodies
> +test_expect_success 'setup complex body' '
> +	message=$(cat <<-EOF
> +	Test printing of complex bodies
>  
> -This commit message is much longer than the others,
> -and it will be encoded in $test_encoding. We should therefore
> -include an ISO8859 character: ¡bueno!
> -EOF
> +	This commit message is much longer than the others,
> +	and it will be encoded in $test_encoding. We should therefore
> +	include an ISO8859 character: ¡bueno!
> +	EOF
> +	) &&

Creative use of "cat" only to strip leading.   Otherwise,

	message="Test printing of ...
	...
	include an ISO8859 character: ¡bueno!"

would have sufficed ;-).

> +	if test_have_prereq ICONV
> +	then
> +		echo "$message" | iconv -f utf-8 -t $test_encoding >commit-msg
> +	else
> +		echo "$message" >commit-msg
> +	fi &&

So we have the message in the file encoded in either utf-8 or
the target encoding.

> -test_expect_success 'setup complex body' '
>  	git config i18n.commitencoding $test_encoding &&

But we claim unconditionally $test_encoding is used in the commit
object.  This is OK because test_encoding is also set to UTF-8 in the
IONV challenged environment.  Cute.

> @@ -448,7 +456,12 @@ test_expect_success 'setup expected messages (for test %b)' '
>  	commit $head2
>  	commit $head1
>  	EOF
> -	iconv -f utf-8 -t $test_encoding expected.utf-8 >expected.ISO8859-1
> +	if test_have_prereq ICONV
> +	then
> +		iconv -f utf-8 -t $test_encoding expected.utf-8 >expected.ISO8859-1
> +	else
> +		cp expected.utf-8 expected.ISO8859-1
> +	fi
>  '
>  
>  test_format complex-body %b <expected.ISO8859-1

And this is the same idea.  It is confiusing that the data has
nothing to do with Latin-1 when iconv is not in use, but things will
even out.  Nice.
