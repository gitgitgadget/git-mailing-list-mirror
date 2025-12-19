Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B3F2E62B5
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766134457; cv=none; b=O4o0LfU/AncF0ACMcWhx1d11XozcK62KKbuN0mYWQpdgbuXzs5ozj6qkjKhwjaRJZhjCi+bBoc7JwRAp1cK6OH8mFs+iY91HHPxkkXLk6LeCjvtwwq4vanegEE2srX7GfILvfzbgz9F1Q1ONgppcNoSC4UWkeIfu/XPP0qxINNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766134457; c=relaxed/simple;
	bh=lueh8Dh9mjto94oLDuKL4ssJGDoDZzQEoS15jdSgb7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hnAsfBazB5X7/OzBTfJqF4xz6zzctx4xkX/+HWgEffOwr+nuomAwhCna4rkBOrDAePva8arAm5yFKteelX5A2qzRO8UcHfiMWlqqv9OrnEkP9vPLPALj/Mgm0Rrbih8lW3kFg7Cdlp63dcQCqAmDl/nuV0LpiLQyF7r6ynHgiVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kEIqGbeJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=js4ACFY7; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kEIqGbeJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="js4ACFY7"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id DCF0EEC009A;
	Fri, 19 Dec 2025 03:54:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 19 Dec 2025 03:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766134453; x=1766220853; bh=lFhBevCuaq
	fcmku0LAQhgQd1eLQNjSeQ+kiroPqrJH4=; b=kEIqGbeJHORy9inmuRaV0rTBZP
	hk0SV965bZzN4Y8rs5CQ9ACCwQTJqFrJI9J/0ATFtQQl+roocuKVwzKxAvio0usz
	Sn68VGjgHEyPZZWlGgc6/iLgyTg1PWS/JCDmtR/Xu1D3ueuQQbRRbE7e+8IkTXPr
	/Nr2Pja+LnX5SiPyk/HLyTzs0JFsHJNYZeBsYQCwmn53ToUlDhe0HzMtCgowifRE
	aeHiUDjxHZxlNZ0IUkUwdOSYLDEG9mjIJ9eyuzHsfnYP+UdMch0HKZt3yGgfKdnZ
	831J0gePAE/c+cXJLew15b54VKBO+SvoI6leDUCxVCp/PLREIfGfWvX6jjrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766134453; x=1766220853; bh=lFhBevCuaqfcmku0LAQhgQd1eLQNjSeQ+ki
	roPqrJH4=; b=js4ACFY7ZGqPt967ufnQdCqHKhvs9fYGu9zM/m41FUeQRABLfvu
	807dl9c4cBtWSLusoSQh7WpU2afwVDoFyCBB2M/fu+6/Km7FHAONrkh0UUKaJ39y
	teJbNdydyPEJ59MzF3Lqz0mgRn1GWqu+WEruHy2FEy/nVUcG3pvbloK2R2KoVebJ
	WQb5WzlVa5wLMfnUxsdTXKCtYLiOT83ZRE4orbCgECEu2nCPfFZbz3lcfSyrbxYz
	60FWqUrGY9zb/wo/QwBAns6WBhFDXpxy3XuHJZDt/DF4UsSU+U+9E4lfMANcQ/0e
	hBtGCDANf/uMfrAnQeRA/1d7JTO85hXoaXw==
X-ME-Sender: <xms:tRJFaSfgQkLsIDH0IGCGH1XbAGcW3eLzsq8-qW74y6OWJzsGD1AqOg>
    <xme:tRJFaWyIui8P9LWiCiuaj5UO7fJNfQZrfu1KaL7F37Maw3ibDw-TPOXAuPxdeehz2
    hWJxj-6Thvt_c4-acs55G979t7jR1Tm2_SHpCd6an4PQHStQkX4i30>
X-ME-Received: <xmr:tRJFaQEsrS0Te1xCxNu0r2PHrX2aznwNkfc0O3TTfjX_em1ovm0UFId8tj-JuAeNvVlKtwpt9g7URLvos4ZXdPz5zMc0iaw6yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegjeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shgrmhdrsghoshhtohgtkhesshhhohhpihhfhidrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:tRJFaSzYcSQgJuGjRIpDOseK4QyBXU8ELWBVBtNmGs6_wsErv9vhFA>
    <xmx:tRJFaZvg1otPCO4wof1JefwUCACif4-xnVvW2vSypH8MIH2mGGW8sA>
    <xmx:tRJFaX33F5kZu8Hp1VHu8cFIQRr7lU-ThKESir17uvkxVwKWHw2fUw>
    <xmx:tRJFac-U919K7t4rnWyFeSFZtw5TRDEOD2OaMIHWQk7Gc20YvlsesA>
    <xmx:tRJFaWP5kMhCzQH36gtKp5fjpzjjModPCG6krSEYc-0vIwikuvSi4FrP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 03:54:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Sam Bostock <sam.bostock@shopify.com>
Subject: Re: [PATCH] bundle-uri: validate that bundle entries have a uri
In-Reply-To: <pull.2134.git.git.1766097223647.gitgitgadget@gmail.com> (Sam
	Bostock via GitGitGadget's message of "Thu, 18 Dec 2025 22:33:43
	+0000")
References: <pull.2134.git.git.1766097223647.gitgitgadget@gmail.com>
Date: Fri, 19 Dec 2025 17:54:12 +0900
Message-ID: <xmqqcy4ax363.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  bundle-uri.c                | 22 +++++++++++++++++++++-
>  t/t5750-bundle-uri-parse.sh | 26 ++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 57cccfc6b8..022e2109a6 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -89,7 +89,8 @@ static int summarize_bundle(struct remote_bundle_info *info, void *data)
>  {
>  	FILE *fp = data;
>  	fprintf(fp, "[bundle \"%s\"]\n", info->id);
> -	fprintf(fp, "\turi = %s\n", info->uri);
> +	if (info->uri)
> +		fprintf(fp, "\turi = %s\n", info->uri);

All the other code paths error out when info->uri is missing; I can
understand that print_bundle_list() want to keep going as it is
primarily for debugging, but then don't we want to more loudly
report that a mandatory thing info->uri is missing, rather than a
subtle hint that is lack of expected line that shows "uri = ..."?
