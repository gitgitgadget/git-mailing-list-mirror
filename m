Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3BA155C88
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046431; cv=none; b=lbvEoIIYcHSMiczl/i6FZBZrkRcQqJZt8ggWjbX7P9HqHwr5moTO1zvlSix5SA5axq/Ira7G47iznblR01ESstZmLRU0urNzRVV/STWSMXmZl74LdxdaBbAs3steqeGFUB0QbTgzwH8OYrFFa9gn1fVTgJithmwK2GhriRPUihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046431; c=relaxed/simple;
	bh=xfSAwkytvzpPv1DQjEwRBTHo34HJYD4U4SOxB3MRiPo=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=P9o6wLk10Ci0dbLsjhSWt7fT8KjYA2HD46E75axn96/F1YzCq1BbfrpO/8jRul7LB3BgsgNTpK5jVo7uXt7gpAOmqdCxGmdL/eHzsdYV/Gf9WNe+9kZabVxL1XfitQp/oAwQ9mpnbwepJb2HzVx6GfUy8gHPlF3avLzKvtz/tTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CH6ylFEd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OeiPFgn6; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CH6ylFEd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OeiPFgn6"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id EEBE5EC01E1;
	Thu,  9 Oct 2025 17:47:08 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 09 Oct 2025 17:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760046428;
	 x=1760132828; bh=vk9rZ6FOdIDyv7hRz5m/0xhYwhNavR9xoiOu0yTIlXo=; b=
	CH6ylFEdgN+S4FVkbzYAKzj6fEbaL7Iw9otnTkku8+bcMMJNmxbpffDj03Hf8Mmi
	Waw50/2QdlpnbOmBo8Z7i2gTwibIi4jQJW6fOCRdbMF8PrZ7k9bv/xII1/bYIojZ
	G1UCjKeZED5QrF6oGkdeJpDvbWKXo2QIY4d2+o5qEglw8qcuphMs2IfmVpZTgOe8
	sOCTBtZo5bRT+ovUPnNOQigg7I9/GnMQqhPDMpbCR+UiSMUOGk/wN2cT0Cyvq7T9
	0mF+Wd9gMoVFoT3NYClUmV3ZG3f6FJ/occvEgsYwYGwf1nQPFRDzuvIyXRWtydQ1
	IE8DifBoWpUK7qE9dYH3Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760046428; x=1760132828; bh=v
	k9rZ6FOdIDyv7hRz5m/0xhYwhNavR9xoiOu0yTIlXo=; b=OeiPFgn6zmaulbVFQ
	uzzEyfNujtzZkhQgMWUae6aIsv3zmcdNeIqUgQNlY1AWFARMRbdpnMRuF/cm4ahb
	CvcaKYl+wfthYs8yLE1jaawBQPTUZrhSLuIHFqFCO5m5uqGhaZqTjxIdb+b27H1K
	BXg1hWogyKkkTxP6Q1ZsuyYWCknhk6LdbsPKYa8ruroqSzX9iB8tJbQJ01Kso68+
	myVi/I35XNf934IvgyBjDuPrJkUtSamAJ1vD07s3emKBf9QyQCfA9IOoiROux70N
	kBhD83RbamFWyCJGhwFFbNLs+xYuhCwJFDUHYqpIAGjIfbpIOah2BtoG+gttfgQ7
	th4XA==
X-ME-Sender: <xms:XC3oaJGiqUfAB98-x9YXEKGj7yKv36aWZl2fwudR1ruli_ve6-oXkSs>
    <xme:XC3oaJJRg2KrzkY1qTAYQylcZfDu7VgxdnimgTTKIYyWItiikFpjtA80hiMeVytAj
    NtOVXTZOL-jw6kuSe6qtIAKTco9ZcTFPH0MOd7vbNsiAn5Xa7SM8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepohhkhhhuohhmohhnrghjrgihihehgeesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XC3oaPzPVYpHxfyGGtCY3WPij3ESp_VWWWN52EqLH8LZrTzjr7nA3Q>
    <xmx:XC3oaFM_kGuQQxRWoYK2CPJCIue4AYomNcsX1TGcFJr7TbhaEoAN1Q>
    <xmx:XC3oaA4Gmqnhdx8Q6ME8ma305_G4I9Bi-B2EufoxsnIZb97p9WjeSg>
    <xmx:XC3oaGMThe5MaEswqYaKTKgGwcmcf5jWv9XesQWr2TlCMH1q7jIqOA>
    <xmx:XC3oaF78RUd9dZ7_NGhJXhi2jxzGDHoSArBbWVfCsscV8Sjt6baph8zC>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A14051EA0062; Thu,  9 Oct 2025 17:47:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6x7JFkbNke3
Date: Thu, 09 Oct 2025 23:46:48 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Okhuomon Ajayi" <okhuomonajayi54@gmail.com>, git@vger.kernel.org
Message-Id: <a299c0ea-8eeb-4a21-9924-ebd7c6f6e0bd@app.fastmail.com>
In-Reply-To: <20251009214445.1190274-1-okhuomonajayi54@gmail.com>
References: <20251009214445.1190274-1-okhuomonajayi54@gmail.com>
Subject: Re: [PATCH] [Outreachy] patch-ids: fix const correctness
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025, at 23:44, Okhuomon Ajayi wrote:
> Fix const correctness warning in patch_id_neq() in patch-ids.c.
> ---
>  patch-ids.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/patch-ids.c b/patch-ids.c
> index a5683b462c..4a72c2cbe6 100644
> --- a/patch-ids.c
> +++ b/patch-ids.c
> @@ -42,7 +42,7 @@ static int patch_id_neq(const void *cmpfn_data,
>  			const void *keydata UNUSED)
>  {
>  	/* NEEDSWORK: const correctness? */
> -	struct diff_options *opt =3D (void *)cmpfn_data;
> +	const struct diff_options *opt =3D (void *)cmpfn_data;
>  	struct patch_id *a, *b;
>=20
>  	a =3D container_of(eptr, struct patch_id, ent);
> --=20
> 2.43.0

Can=E2=80=99t the comment be removed now, though? If the cmit msg. says =
=E2=80=9CFix=E2=80=9D.
