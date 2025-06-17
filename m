Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A582EBDF9
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 16:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177792; cv=none; b=R0FcIGo586vhuiF2OKUNML7jauTzYVmlIe2LH3utUCP/2EIEKmqyebBwVwKIWQbRsFSUA8APvwPeib0TGclvdhNwT0rE4jIz6YFuefr980ihP/H3oVavgZ7h7dUzNeq60rMzD6xN/zVUwNU4owgeqXHwp//CU+luCcYOFmz6cVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177792; c=relaxed/simple;
	bh=NilFtc6tSnFFeVCM0u6upSbp4tF6R69/F3nnqekgcSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E9Ck6tFNrFBcyIVK8fFFwhRT8C+ro9RTx+gM9N/2khSQZStMQNUGQuDbTA5Bmsv0j2DpbkiCu5dt2IWIFavHPdCey7Z1eLS4STOD3AhycQX5sQY8zw/CjarKGZyzu5IeUjTLso+11j7N8qP2T58erse+K8HsUu7+nurF/zIX8BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sfhA62Pr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WnmwMoEg; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sfhA62Pr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WnmwMoEg"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 563FA25400F6;
	Tue, 17 Jun 2025 12:29:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 17 Jun 2025 12:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750177789; x=1750264189; bh=jCDCIkbsxN
	aODvL4h1Sh9HsPO70DWKVMnLCiMQDHyi8=; b=sfhA62PrhXlgJRb47gulMy1rFT
	dLfR3BbVRt3cBX+Wqn5/hEiqgzN6yntbi9MXtUKuzMvc19yCDjn1W8YBBINnAjPF
	iiSij/wBG4WwbY9iRS+9Jli00BSkjgdxepxDjHDOWDC0Aak5MR6IIKkBQbYgoXze
	/Q9daGn+BuOA5ccR8SkbHxTzVfT25GvhiN+kfoJxY4oYl3fCUDfFnebzz7q5K73m
	TJZbil4gJWnkvxc8CyDUxASYYEoHRhCnYVL7RfIJSD0Fv+dKPoAlQDafAaQ3CvkW
	zEm7gPGzigizxWsFQCkby6MyqQRyHZjEuEcGIGMQeuz8eH6YHg/6wOM6F8oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750177789; x=1750264189; bh=jCDCIkbsxNaODvL4h1Sh9HsPO70DWKVMnLC
	iMQDHyi8=; b=WnmwMoEgZRXWMe2UPilmYdv88ejkHbl1RNgTlSzXCCBXeowRCwy
	sS9Wz9O4mAYNB31/wfiu+pjEKR1FRUDkjZ0NIaQ8YV2/UzSE2HiaBrlPACMz78Iz
	nRsQk7NxVzpj+eVYk/jDe6Y7uZaKhvcBdfxu/RRaNumwdrqJWUeb/s7O3o+SxfXG
	+Rem+MYJKxP6Ef3zyuVLAzyyIvHjA4aNIx5F0iEm+EnGYLHlRO+T9+/UKuNpG3Aj
	zZrMZ0FOzVrdz7vxonfuimLeqwXZB0me19nwZPBdQD3FOExZfOJVtJKprM0VXnrb
	b41khqzvkKFCxEoN0li/Fqy0AQmWbxC32wQ==
X-ME-Sender: <xms:_ZdRaCSPq0QVgQmC8RL5ISe5K0ogAuLx1Dc5RyTft-P0-5YPHhTigw>
    <xme:_ZdRaHxmzNQiT4LPKks1tzu7ySu7f65DuHgcK9SvxszrLqEw-0miM04xQTg4RV6UA
    15oMltWZ-rdf-71Xw>
X-ME-Received: <xmr:_ZdRaP1iyzgtzUt137Tk4MVJET8HziS9EbkFfp3Lb__PmF4zNuwZQApwn1pQ1uQ82hYZZ9ae_hFwT3P8LWNy-KiTBNXeaK0O1shP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrhihurdgthhgrnhguvg
    hkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhgu
    vghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_ZdRaODfp9WUrmaAsARu7ptja36HN4X9gMgiJkWK8ZkF_hKjKwzYsA>
    <xmx:_ZdRaLhWYaq9CMRJcERscmFfdjhPKJaL4HYsTcFy1y0ZaozIKhhrCw>
    <xmx:_ZdRaKrY4QGcAxJ1cHWp9PI6VC6sPyr0dw0okIJeNrr3s2nJNVgH1A>
    <xmx:_ZdRaOiNJ1HSgTiwqvV1dMFGMWPGgNPYtPMZcSvBS1rMhreoPDa-Bw>
    <xmx:_ZdRaKjkgKhsUZxSz0_nAeoUK-TzJXLw0SPJTKr4J7w6-U2IDe-PhQmX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 12:29:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,
  shyamthakkar001@gmail.com
Subject: Re: [GSOC PATCH v4 2/3] environment: move access to
 "core.sparsecheckoutcone" into repo_settings
In-Reply-To: <9a638843411d0542e240ea0dd9537f388523fb3c.1750157825.git.ayu.chandekar@gmail.com>
	(Ayush Chandekar's message of "Tue, 17 Jun 2025 17:36:35 +0530")
References: <cover.1750157825.git.ayu.chandekar@gmail.com>
	<9a638843411d0542e240ea0dd9537f388523fb3c.1750157825.git.ayu.chandekar@gmail.com>
Date: Tue, 17 Jun 2025 09:29:47 -0700
Message-ID: <xmqqplf2uy9w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> The setting "core.sparsecheckoutcone" is stored in the global
> `core_sparse_checkout_cone` and is populated in config.c. Refactor the
> code to store it in the variable `sparse_checkout_cone` in the struct
> `repo_settings`.
> It's fine not to lazily load it from the config, as the variable
> is used quite commonly.
>
> This change is part of an ongoing effort to eliminate global variables,
> improve modularity and help libify the codebase.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> ---

I think "the correctness guarantee comes from a different place now.
How are we making sure that these accesses are correct?" comment
applies equally here.

>  builtin/grep.c            |  2 +-
>  builtin/mv.c              |  2 +-

Looking at the output from

    $ git grep -n -e prepare_repo_settings \*.c

there are many builtin/*.c that makes a call to the function on
the_repository fairly early in its start-up sequence.  Unlike many
others these two do not seem to have any.

>  builtin/sparse-checkout.c | 28 ++++++++++++++--------------

This one does, immediately after calling git_config(), so it should
be fairly safe.

>  dir.c                     |  2 +-
>  sparse-index.c            |  2 +-

These two also need correctness guarantee.

You'd need to make sure any potential caller of the helper functions
have called prepare_repo_settings().  Those who wrote an access to
the global variable in the original would already have made sure
that the callers would have already read the configuration file, but
with the new code, that is no longer a guarantee for correctness.

