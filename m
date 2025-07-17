Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCA8192598
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 22:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752791844; cv=none; b=pIDAw/ihi/eIivKvbYTkRrNq/Quqlz68hihPZNgA+SInhLTO1v8jvNisWEpmwcoJ30PRQ7P2uj21KsO0v0HmrWGp8Cj2G/cMTYkYwsO7YVq3KJsCnWJSgJBTiCByzXV/wgAYD2fOnygaPGcTNWXptMcDGZCDkE1/DcLU2k4s4tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752791844; c=relaxed/simple;
	bh=WAm4o77jq7WAb8OaQjTmtWQHbkZ4ZvLwL+qkfVVl5Qk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ni+zU7zTzE8p9ctNKszGSn9wsZKmkVcxm/dcU4FpXVp7dePB7SOf1L2HlkCSyRA5k5N6FilejW2RxnHKJHhUQ1a1ppHujL2Ll40abEMl6eCo84DE1WvEwscjHg1by1et2HwijG1zI8hG9hWmKGVxa5rRCUf9ualfTMR10D3ySTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PrduCVqx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iJIGHlWU; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PrduCVqx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iJIGHlWU"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 5CAB81D0006E;
	Thu, 17 Jul 2025 18:37:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 17 Jul 2025 18:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752791841; x=1752878241; bh=XQ1Qj8HHZ3
	firkw6zEU1dxcHcSph6GHCFFN5E0l8jRU=; b=PrduCVqxOnD96kkpTevWCJ3X95
	BoGcvLpi/0qld7BnfCD60+jBAvnRUEJfLAugwIXuPmyE+Wa4UoJL36C4jcc8btb4
	M57R2e2BPsTApeW5487hFzJwzRRS//s++R0DYUaYLnsCSiVaotd/wfx9uSbip0V5
	oFXsK+dsyAnQVr1pmSErqsxWZjJ0T8Gg8B/ooTGzvMe10bkID1NhW7ocPUiwQ7mw
	qqFgj0ir2sRKzdbtfCnxVh5+6cvglism7leRv9iavtyOv3nfcoYccXdcXDaqyTsO
	EVE3uxdzrd7nkNxaUo6bjan0xgWXUciDgP+3CxPtjuBefnD4WsvD6eAgUXfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752791841; x=1752878241; bh=XQ1Qj8HHZ3firkw6zEU1dxcHcSph6GHCFFN
	5E0l8jRU=; b=iJIGHlWU8w2lAAT4ZxiYHOLOO82hGEmaBck3FBSwNd6ho1QqdMC
	05qV461UyLc97pKvrLemJKBPbwdUsSU4H7G8+T9jSAz3ruIwyuS98aTy3tkJ6duV
	KM7gteRRoEkli2AV8kONe1PpfA7GSl9JGCBnGMxdxrFRfzxq4m7NLC514fG89EP3
	ZczP2/L86RYUBUAhichOOwyNDwLyMdSj3eFtgptd8w8uJykzc02g/y9gH63yU9ax
	oW7cLZulDpG5o0cXFsGrXIVJNi7nQp39d4SOpqKgyYNszCj8soJbSKseaWst+XfA
	SOL3HSO9jc9pPQuLt8JxxaibQDMNmMCkVww==
X-ME-Sender: <xms:IHt5aMEiI_Q5lYB96VglIP0N1caJL9z_9k7Mebz7zv2wP2XE2WXRZQ>
    <xme:IHt5aNyM3jTu4NfMbyOXcXI44lc7UAjljqejoLsThIeGZduLqQcfjp2CsOhfb9FvM
    vUHpMbAIbME2zVn7w>
X-ME-Received: <xmr:IHt5aGkRDfwgmTZ_OW6SbrE1hteUL7ji_9h9E4OVn8DZTYhgVkEfntCWATyaa3IWYPuic4uFGINYPlKlZJ6o8vI4juOPylj9FCylFe8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeiudektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:IHt5aOmOdpBjYWL-GiG5F02bEtV5pKZpsyCHQKYeHbwlx2lkf9Kylg>
    <xmx:IHt5aAxO3GJV0EGCXsZs65j42tuEC_97L8ZQrDrOqR8B82I1Mg1z5A>
    <xmx:IHt5aLp5BG-6Y18x-3ir8YwFRrueEI0_5alTVmT5d-FKb9dM5qO9Hw>
    <xmx:IHt5aH70isytKDvpHD9Ol-mKcv6MsEfRYi8VKH_kcl3c7NL9leLgVw>
    <xmx:IXt5aIbznpDI2V7v3r3C5Ln8cWfcZ4I_KL9evjlBuTd-Pcnic64F7snq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 18:37:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Derrick Stolee <stolee@gmail.com>,
  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 5/6] last-modified: support --extended format
In-Reply-To: <20250716133518.1788126-5-toon@iotcl.com> (Toon Claes's message
	of "Wed, 16 Jul 2025 15:35:17 +0200")
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
	<20250716133518.1788126-5-toon@iotcl.com>
Date: Thu, 17 Jul 2025 15:37:18 -0700
Message-ID: <xmqqseiu4f6p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
> index 05c113a1f8..008ea708ab 100755
> --- a/t/t8020-last-modified.sh
> +++ b/t/t8020-last-modified.sh
> @@ -48,6 +48,28 @@ test_expect_success 'last-modified non-recursive' '
>  	EOF
>  '
>
> +test_expect_success 'last-modified extended output' '
> +	check_last_modified --extended <<-\EOF
> +	path a
> +	commit 3
> +	tree e9a947598482012e54c9c5d3635d5b526b43a6a4
> +	parent 2
> +	author A U Thor <author@example.com> 1112912113 -0700
> +	committer C O Mitter <committer@example.com> 1112912113 -0700
> +
> +	    3
> +
> +	path file
> +	commit 1
> +	tree f27c6ae26adb8396d3861976ba268f87ad8afa0b
> +	author A U Thor <author@example.com> 1112911993 -0700
> +	committer C O Mitter <committer@example.com> 1112911993 -0700
> +
> +	    1
> +
> +	EOF
> +'

Hmph.  This hardcoding of everything does not look easy to maintain.

Besides, the test will fail rather miserably when run with SHA-256
hash (e.g., post Git 3.0 where the "git init" command by default
will give you a repository with new hash).

It looks somewhat inconsistent that tree is shown with its object
name, but commit is not.
