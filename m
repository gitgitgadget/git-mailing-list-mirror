Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266A219EED3
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054263; cv=none; b=SYLPIxx3+uc6yKa3ssAVKLi/H0EVRxeemM3BTTRnQ6gohuyGFPimot25raa562zJr417Q/WyUo9e8fTLMeGOqhxjC4/1aUjd1NS47m0wxBn8foWsZdYWTX/uENqj4Dol6/Wula5RuN/oiOKkKGWj2q6SRyjRYOupiF5cwOn8G2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054263; c=relaxed/simple;
	bh=lxNLSxjy8/bU7ljPdZwd3sVvQNRD5Lzr3u7Uk7ILB4k=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jxaRe57VXrzmOpN0RE6lbwvsvDG5h1DE4EAWECyfOVtqGuUvuKexP8OpaYeVh5JAimxFtNBn6EOH8HJaf/vlm1IyIEwQ/AhvwOXWf9mhhBm9IJVXiaAZsjGxi6EoHSe2bXe8vntEfjHmDU50zGlOW3SSWRKj17HsWm5yoFYuQKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lvF9kfLv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S7/neuKp; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lvF9kfLv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S7/neuKp"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 508CAEC01B0;
	Thu,  9 Oct 2025 19:57:40 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 09 Oct 2025 19:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760054260;
	 x=1760140660; bh=9FwoCp6bnnhcaREM0ht1p/RZSYSTA6tO5KkZD1lBR4I=; b=
	lvF9kfLvHGfWgd0UEkUFZsgaJu2+hWTnvn3EsvOBbO0tJvh7U1V/0emZpeMzweFc
	k0E9luA6A4q/P4QeohPYv8SHxKN+jc3ltDAucJjxNmvXdVu4lT60+15xhY54gAHi
	SuHuQyex3WeiHYlPBLjTjUEjeg6KF23oW9tEeLjdT5OBKYcFhAd+BBLajO3ZN4Gd
	dZ+lSrzZd0aFDiNn1PyUE/15kyub9hjGW3zzjTlX2ns3hlBCVd7+xem5OFG0TpfZ
	RTTV+wWmCGTV4gcSb4iz5WfYc+FEVuBGVILwGHuayIz4GHKT/po2XKinQm0Phqnz
	SncI2UO4T4D52lUT97HIZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760054260; x=1760140660; bh=9
	FwoCp6bnnhcaREM0ht1p/RZSYSTA6tO5KkZD1lBR4I=; b=S7/neuKpxc7lu/eQ4
	ocY5hI9mrJNOpYd0dMzDlMNo1gq9OGZgzHpgvfHkN1udEDtjrgfdd4DfuFlLYBBo
	4OCwqmxFVFdOOFkP5PLnCzvAasOkiMq1DjJWbORPeKwF6zAALgYQyQVBcayfKcKf
	VrbKtlR3CI5MVnnkJ5Mr8brk0e7SbMfxMmYC5yKAkoVqhzcwJoO83C3o99ZbLiRL
	EkhMicxDOlDs077rGUrMwSJoodMm5p0EbjUfnlu6jidTE1srtprI/77138mqMeWl
	Y+BrN38nMm32kVqMB/OdsmK00CEMGStT2Mi1S+f4hanbX92+SZN5KDY2dyRC5eZQ
	nEcPg==
X-ME-Sender: <xms:9EvoaOnMZFMJgT8zBDo1FkKxo7wkI2XeDczkJSJeJ9V5inpOndi84O8>
    <xme:9EvoaAppX-J5H9kT8f66aJDPSBC7_Wbi5QlSWhNifps46mC5ya2QvuQJhNAqOoIVC
    B_r0_k4d4kc72q5OQ6v0PSuvF28Q7iCO9TSL76YSDvqpQGAibKZgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejheehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:9EvoaMskAT0ZYTN03Dqs6Lp-uOy6vO0gDkG0z-S6oQ5I9H6u4tjrPA>
    <xmx:9EvoaCaKdd9SJSBNRAPaM9nbFD6ny50V0Y7UZuppEzP8-WxG3DC0NQ>
    <xmx:9EvoaJvhyasHVvfEU5PAhdnf6Olh2BxyskmAUH4hpuyVi027gAjSiQ>
    <xmx:9EvoaMEDH8ZQ1MEGyTCBTOm4L6fuv-KwnIBYtxxUqqHNIDBuxuetcA>
    <xmx:9EvoaMZ9PgrIb-9aRMm-cUfhB16xfBWkZwTVciyqUzrGIZfvbtOFtNpZ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 037E71EA0062; Thu,  9 Oct 2025 19:57:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AN133Pc3AQ0w
Date: Fri, 10 Oct 2025 01:57:18 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Okhuomon Ajayi" <okhuomonajayi54@gmail.com>, git@vger.kernel.org
Message-Id: <3fa266f2-2376-4497-9d36-966fbdb4ca0e@app.fastmail.com>
In-Reply-To: <20251009234957.1789543-1-okhuomonajayi54@gmail.com>
References: <20251009234957.1789543-1-okhuomonajayi54@gmail.com>
Subject: Re: [PATCH] [Outreachy] patch-ids: fix NEEDSWORK timezone parsing in
 fast-import.c
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025, at 01:49, Okhuomon Ajayi wrote:
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
>  builtin/fast-import.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 606c6aea82..695e1a0ae1 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -1959,14 +1959,15 @@ static int validate_raw_date(const char *src,
> struct strbuf *result, int strict)
>  		return -1;
>
>  	num =3D strtoul(src + 1, &endp, 10);
> -	/*
> -	 * NEEDSWORK: check for brokenness other than num > 1400, such as
> -	 *            (num % 100) >=3D 60, or ((num % 100) % 15) !=3D 0 ?
> -	 */
> -	if (errno || endp =3D=3D src + 1 || *endp || /* did not parse */
> -	    (strict && (1400 < num))             /* parsed a broken timezone=
 */
> -	   )
> +
> +

These two new blank lines should probably not be here.

> +        unsigned int hours =3D num / 100;
> +        unsigned int minutes =3D num % 100;
> +

You=E2=80=99re mixing spaces-for-indentation right here with tabs (next)=
.  The
project uses tabs for indentation.

Try to run `./ci/check-whitespace.sh @^`

> +	if (errno || endp =3D=3D src + 1 || *endp ||
> +	    (strict && (num > 1400 || minutes >=3D60 || minutes % 15 !=3D 0)=
)){
>  		return -1;
> +	}
>
>  	strbuf_addstr(result, orig_src);
>  	return 0;
> --
> 2.43.0
