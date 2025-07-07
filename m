Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A118D65C
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904727; cv=none; b=h5WrXTqm3mJqSJhYd4EJGLVyD2+VcvgBMGVCLQ3aRvq02L3+pjZuzaD/v5WfA57VTij8IU0GOEB1atXEKlIhuduXGBOnJexFJVpZ6Jqdriwvu6nfsMzDs8UW96sq+vNbf6686PQ1L+mnvCgjMASDEHjZrgbbUz2iArFgO3ZmvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904727; c=relaxed/simple;
	bh=l3M9soTuVTdN/Edc2sk49AhQDsouuaeRAse/wE+8yCs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C0mdS8XTkQdjwu2f+B4UsLYzotCB3RAulMHtQmyZeph9ww+OodwjCVx7CMnnUwPtsS31rQn1RxMWINs5HZBzQyLijZRtGesVlV7MJ/QKOjpqxJOTYN1Uth9NY6kKGXa3LzWrHjaFB8TBhAratZ6wWdJwcFC3/fdzJxK/6p41xYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UAE9v0Wm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=juMMqdyy; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UAE9v0Wm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="juMMqdyy"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D29BC7A0225;
	Mon,  7 Jul 2025 12:12:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 07 Jul 2025 12:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751904723; x=1751991123; bh=yZDbIGFZoM
	BJVqVFk5DYC/IeV9sDLz84iXoslTjwGaw=; b=UAE9v0WmDRyKmHJYR2Q7MHnCmr
	rRaPuByCYX3JoiYI5c/DJauhn/fgJt6BGneTwnfF44CuEzBCKkaEuxCyR75lwRki
	1EL6fpuTzU4or/KfSuwqRR1R8qZ6gSao9uO6Gb6w75k3B86g7VnJIDqu1+QYMrIJ
	FSulpPB6LYAcA9gNMeTC1LsS0OU5MhMFL8VUWCKZMSIj3aHU4L7XOrk8axIsUgqB
	pikP3WxNREQSXu8sAcowbCHMn+OmWFA8/KtQDgxrWF2tgkNQ8eVqdYHcDq2yViJc
	bZhQZfcFoNsMF2uNp/eHS8Ijb4AWx6wECtjqguxc2xWDnEZdUcouDjo75f8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751904723; x=1751991123; bh=yZDbIGFZoMBJVqVFk5DYC/IeV9sDLz84iXo
	slTjwGaw=; b=juMMqdyyH07BibtXPeb2tV1RFkdee5uCu7NinMaUXQN8T0o7KL6
	CHrakLXbFfGECI8Xfiao/zrXtcXZITM6eX1cN+M+OC0Td2u65eR3MYWI6V1r/eS3
	3/bfhIWZyaduPnGyxDQdZYH1g8yZP+R2J/4E2vReMyImskbljr3PsS7xD1ExL9WO
	h0OW189b5joAvhRM8NpnLIZObJuPvC2XSU81lYjK53vbiMcI5a9/utnorVd8w8zh
	uXLSVipKKnsTtILt2QpzwLTofd6wD7Bo10zWsW1czgspl4owXRzU+Ufg2NAGRIdm
	fiU+qSnuncUD5Cc8H3XqbKXPOEk7mLyg8ww==
X-ME-Sender: <xms:0_FraAW215zYtiD_IIoxysk5bCTJ-CEgS0MI0Vte-4Jsc2RNuT6rrA>
    <xme:0_FraCLaQKPhQstsk_A4A3G4saFsEhA9fkvzpYjNWx_HXs7o7hGVS25qzI4tlYfoE
    hNekmlwEHrILuqHKA>
X-ME-Received: <xmr:0_FraK3anugNfjP3z-2AnwxzZqxY5-BggsakDNtuPL5UOJyvTAAkOhakxSdktHpJIeEEHG_q-PhNGaAidgKvIdwHpSroeKAVR-5Scv8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhope
    gthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0_FraA5eS6ksKBfzrfRePqy6kHeXL8evyQN4zOn7xOxkHKhRgOAHCA>
    <xmx:0_FraL__zPYfqCypSWMyRplC2o5g18CuewHspvw2cBF2vErIjJJ9PQ>
    <xmx:0_FraPXZ_ByPyx4m5kARU_IiaB8H7Pus481Ucz50At6hVHUNrlb6Lg>
    <xmx:0_FraGrmv3XLHKZ3ExqQuMPyjIsO38nsBz8gpZJaScgL7vstMwCAZA>
    <xmx:0_FraH7amtsizdFqaOxnk2hhzDFYuTeItzBN4shZoQ4tVcG0PDv2Zhpd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 12:12:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  chriscool@tuxfamily.org,
  christian.couder@gmail.com,  me@ttaylorr.com,  ps@pks.im
Subject: Re: [PATCH v3 6/7] t/t1517: move verify-commit -h test to t1517
In-Reply-To: <20250706215039.715732-7-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Mon, 7 Jul 2025 03:20:38 +0530")
References: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
	<20250706215039.715732-1-usmanakinyemi202@gmail.com>
	<20250706215039.715732-7-usmanakinyemi202@gmail.com>
Date: Mon, 07 Jul 2025 09:12:01 -0700
Message-ID: <xmqqtt3o3rqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> The test 'verify-commit does not crash with -h' checks that
> the command exits cleanly with usage information, both inside and
> outside of a repository.
>
> Move this test from "t/t7510-signed-commit.sh" to
> "t1517-outside-repo.sh" since it better fits with tests that check
> command behavior outside a repository.
>
> Suggested-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  t/t1517-outside-repo.sh  | 7 +++++++
>  t/t7510-signed-commit.sh | 7 -------
>  2 files changed, 7 insertions(+), 7 deletions(-)

My first reaction to this series was "heh, you can cut it both ways;
a test to see how a command A works outside a repository can be a
test about command A (which is the way how the current test suite
looks at) or a test about being outside a repository (which this
topic tries to move into).

But this may be an example that shows why it is more error prone to
partition across "inside? outside?" axis.  These particular ones may
be limited to "should exit without crashing and without doing
anything fancy when asked to give a short help", so this move may
happen to be able to lose the GPG prerequisite without breaking
anything.

But in the longer run, we are very much likely that we'd want to
test something that needs things that require prerequisites (like
"do this only where XYZ is installed") but ought to work outside a
repository, which means t1517 would need to pull in things like
lib-gpg.sh only because it has a few tests about verify-blah
command.  These tend to accumulate over time.

So, I dunno.

