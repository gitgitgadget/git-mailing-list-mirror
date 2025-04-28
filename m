Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F3723C9
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745877208; cv=none; b=MNy40O0mw3cUxBknSVDN1/MCZJHKWcFBt7z4POA0SIsixYPT7E0TBdHm1oXEKy/d3ShXwvPDMKy56HEechvtc9lgDIt82mYDzKaitoNAUTJyPaSg2EVaeUYYXlB0JbNsA4XKA0MzgW25ReSaI2rgV93aT520RGGwcpvi/rL0qFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745877208; c=relaxed/simple;
	bh=P72MbieAf/H/vSs9ZVhl9CI2NOZYuJbctfo3Ff2Gopk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XRDQtQhbuFt7GASJijOFcj2s0s/FwdoKPgSDjoxzByBFffNO4qlnkAoUdrLyNtsv/SdtAuwSoQg7gTxEbml5LEyyCJGjqEx2VKIkz8MosJNApx6OwXzPl/fwmLBMD3vBz2tYiFUFt4BgkxexZ2zpJFSUkpmeZTL81+wunaPJTOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QrFT480D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pi+AT4Je; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QrFT480D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pi+AT4Je"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 946CC1140283;
	Mon, 28 Apr 2025 17:53:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 28 Apr 2025 17:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745877205; x=1745963605; bh=k24gAhXtpj
	YXDFzGdiUB0KhgT1lA6mB+MESH2fb0FAc=; b=QrFT480DxeXEN735r83fZt2oNw
	cIRT0ED9iqdr6kS3qT4KI0zKS3bGleVYmuVlB3A8IB1igHdSwz0xyzcLSdwUtrIt
	KlVr/6n6Q9Pie1uvMS9jv12VnoP1ViMdwU4rsPUpg5QNvWmvcTKfNuxf08pE4RNG
	wXQ6h5WbJQd+ZCA2Uc5nwfYdhqePcwqSHN2h6zXkwLMzpwb92A9CjdbkjSIHe3FS
	eY3cotjSTN2hQ6O4NCq8Fs6hjC/rR7QDjeQUyujJcHEfMLUKyAlidvbE2g585+jQ
	RMhwUm6gAAM8UjuEtit1bQwAvRL0h8CLm+8nnxB+/APBSJ1cbOjLIltDOxAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745877205; x=1745963605; bh=k24gAhXtpjYXDFzGdiUB0KhgT1lA6mB+MES
	H2fb0FAc=; b=pi+AT4Jeuh67fxY0vyRSG4ljwM0M3EKGNBGEhRrdDUeRIEK+HeU
	XKWH4GLaeMeum+spVj3d8hYi0XaqqjZ14+g4V1aq6IhrogxWnzxxV48o1NrHwqei
	T/g/d8eptz+vvPkWILc5O++sX/V6uxOprLM53UEDSRCI2qwR3cLYc9VY/fWXYvYg
	JQ8xj3HeUrCqMZncMMEhZ4zqdLe9TTS6voLwyAG1ps0+cl2vDo0oQPyI4HfMvPWY
	uLwOoDntbCkgLUIeIl7I7W9S3MIeH1UqX+QocOqawzf7U3zvAzCZYyE2Y8tZdLlv
	mP9RXdhhqaJmB1hQcfT+HK5gkOMrsjV4NgQ==
X-ME-Sender: <xms:1fgPaF03qVS9vwyuRecD6gaTlcfvYk_a21yr-pFFCtJHQwx5geEdiw>
    <xme:1fgPaME8fAuPVvweq0tsi3dM7Jm0Ja2lwQ32wT60BoEuZ-W8ZRCnlWc8tBcymfU1z
    21QynuQeNQa5HWG8g>
X-ME-Received: <xmr:1fgPaF6cx9n_e8dFaKDdwqI3BomtdGqRBsPOkgB1aGtUXnREzI64t51KCOsb3dkeNPExV7mnmSOwdhEw5tVfgWdqNCioB5XMwTeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedvtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1fgPaC10BQCuBX7ipBCJ1VD5YPu1qiOgjK3Ijc_4BK9cxNGmddWunQ>
    <xmx:1fgPaIGpckTqUNEGm0juAEg76QPeWgfSfWagYCn1WpFfvTj-ySR4CA>
    <xmx:1fgPaD-u7sqQR2yh5pGP2-ij0zE32MAZBI5sgxMEkT0sBIhT8M4Ddw>
    <xmx:1fgPaFlc3o6phYcVehuk40eQwCifz0A1zQqv-ACpZ9SxjqaZVe7GsA>
    <xmx:1fgPaJzegEruUdvYtb7L3UxYCeDNLfs6AwWGQ8mF8QX2HQUA7hbla3Iq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 17:53:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 09/13] refs: don't fetch promisor objects in
 `ref_resolves_to_object()`
In-Reply-To: <20250425-pks-object-store-cleanups-v2-9-63f1695b7700@pks.im>
	(Patrick Steinhardt's message of "Fri, 25 Apr 2025 09:09:00 +0200")
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
	<20250425-pks-object-store-cleanups-v2-9-63f1695b7700@pks.im>
Date: Mon, 28 Apr 2025 14:53:23 -0700
Message-ID: <xmqqtt689cmk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Similar to the preceding commit, don't try to fetch objects pointed to
> by references. Any reference whose object does not exist is broken by
> definition, so we should report it accordingly.

It has always been correct that any reference whose object does not
exist is broken by definition.

But didn't "does not exist" use to mean "not in this repository,
and cannot be obtained from our promisor remotes", but with this
series, its meaning has changed to mean "not in this repository
right now---it does not matter if our promisor has it"?

So with this change, aren't we changing that statement to "any
reference whose object does not exist may be broken, but we do not
know it until we consult our promisor remotes, if any"?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 6559db37890..0492cf0d13a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -376,7 +376,7 @@ int ref_resolves_to_object(const char *refname,
>  {
>  	if (flags & REF_ISBROKEN)
>  		return 0;
> -	if (!repo_has_object_file(repo, oid)) {
> +	if (!has_object(repo, oid, HAS_OBJECT_RECHECK_PACKED)) {
>  		error(_("%s does not point to a valid object!"), refname);
>  		return 0;
>  	}
