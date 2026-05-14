Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34702773D3
	for <git@vger.kernel.org>; Thu, 14 May 2026 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778785631; cv=none; b=KD42Cr0Uoetsuc3qnEdgvKk5k51FvMV2xWEvm0HHA6Q044vDFBDuLK88nUJ3Eij5zTu4rOuQEuKEL5zzWBEh5D3RU2ksGWns2/s7UGgU34hBH6j/JxYFgKDgi6UVGHWXNoQeABUaMEtHR/K7VcpD4XILkcOHxV6O9boiPVY6O7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778785631; c=relaxed/simple;
	bh=mYFKRIiIBD0pKPtHImpqylZMEatIJ737QFApV7U1th8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F+PZwTOV0nhXeYyLjOL3f14gB720k5UrVvEQZZ069TKmzxIyaxJH437Io3kxket7Ab3AJob0ucs/z9J1fokPifskBrPPhIMAJ831oiWrkbQTn1KBpi4wHz1es6anM5/ZfX5CLf9xzOE/anzizpGrEugF+dyrQeyDb6KLyPv2Z7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nTwkvt98; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SW5a12+G; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nTwkvt98";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SW5a12+G"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 316C0EC0092;
	Thu, 14 May 2026 15:07:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 14 May 2026 15:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778785629;
	 x=1778872029; bh=kt4JQX4q77YdRai39ECMKHjSpkAlhKUVyx8TL5VHPzo=; b=
	nTwkvt98t8ja5906dpoEWICLU/pp1QHShq2N9Fkaq+VrpdRYgOkuyxcCqime4k06
	6dzy7A0CHdIQ9jxP2fbFIcxKeXsHD52Nrnoc+7mFRCZYIXAzbrTorCSigBE89XoY
	Fg4WN2KaNqJECXnozCarzpv7pugoDpEQWZhA0tvOgkucnUaMOPP8rsqDOCOZoRvH
	tX53Qicyl/Rz7miLqq827MqDIOLv9/h6taogRKSzysEUvtM4Z+7ftjp89DaKQxXx
	gQzdLxAPOHHDjUe3g6GE+2xftOAkfXie2S/LL4J8m0NLiiE34dalDa0PIoy0s2ND
	F65xq/MIifHy4Jy5t3Dibw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778785629; x=
	1778872029; bh=kt4JQX4q77YdRai39ECMKHjSpkAlhKUVyx8TL5VHPzo=; b=S
	W5a12+GcTayD79pgfCgqHTT07MKnIGCLbOeW+SRGmqI6+FkGmi20BXkaVTg1lYfH
	U3gtDgAJwYv3KM0H7fcPCRctZL17N0tQY+87fg5YrrMjU03fgVnyIjOt+pGyms3G
	Qqp7E5mRhh7k3781CaBfXAnOodHn1DBRWml47SGYnEhv6gBGAhQGfRearLWf6g1Z
	fFdK3z/XU5VJ2S0Qj/iW/X1AqfI5Fmvj9pS7Jp3eneQ10WwhsDuUuQD66M28eLNV
	hI4/1+MXh2pW4wl9+/smbvuyLZjl2csic/iAPA0p86P+C8kEshQfIFnfI9edsLC7
	r5tH6mWX5gQLdAqkK8flA==
X-ME-Sender: <xms:XR0GamOROmOSO9RzUl4C0wDUt7n9-NIlFCRliwY4VIJu7fD9OdcVig>
    <xme:XR0GasbQpHHzOHuV_fy5Yz5eXwMxB4wOunVMuck3X02oubzw7mGHP7_07byMeMni8
    zs-B7z0a5fVrxF9YPhjbHXCR4hH_st0TOtuCKVgWY_B_yHZ56E>
X-ME-Received: <xmr:XR0GaqrQxNUy4kMir6JdMotWVkdoEYFYkmXuaW7RG4xlPESSdOnDzCHolx1aG4UtGfVrYYPLMqZ196KcNM4DmAnEHqM6pky0oQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdekfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XR0GagYYyIn70eXUdwDPXXC3Lf23xmjjxciGbZbQT27GbsAwbf_LaQ>
    <xmx:XR0GaiQasTNn0WKU94xWx9DVX0GdD0JJU3iMA3Va5aKmfWDJ40Ba3A>
    <xmx:XR0Gan76pXsT1LxM_XDxU7smzBQFzXtg_nhb5Tweop6gIF_6oPVeZg>
    <xmx:XR0Ganzls2IK8eMP27p2-F0pKbqno7idRxHkAp33poZ5V0Mbr3DCjA>
    <xmx:XR0GasAmmYMbWKJRE0Pep0y1bzbITahWfNeTSa2nc403BipKAAxyA0lM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 May 2026 15:07:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] strbuf: use st_add3() in strbuf_grow()
In-Reply-To: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Thu, 14 May 2026 17:11:06 +0200")
References: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
Date: Fri, 15 May 2026 04:07:07 +0900
Message-ID: <xmqqo6ihg690.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Simplify the code by calling st_add3() to do overflow checks instead of
> open-coding it.  This changes the error message to include the offending
> summands, which can be helpful when tracking down the cause.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  strbuf.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index 3e04addc22..bb04d3910e 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -106,12 +106,9 @@ void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
>  void strbuf_grow(struct strbuf *sb, size_t extra)
>  {
>  	int new_buf = !sb->alloc;
> -	if (unsigned_add_overflows(extra, 1) ||
> -	    unsigned_add_overflows(sb->len, extra + 1))
> -		die("you want to use way too much memory");
>  	if (new_buf)
>  		sb->buf = NULL;
> -	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
> +	ALLOC_GROW(sb->buf, st_add3(sb->len, extra, 1), sb->alloc);

ALLOC_GROW() being a macro that references its second argument three
times, doesn't this rewrite rely on the compiler being clever enough
to notice that checking for the same overflow three times is
pointless and does it only once?  I guess the original has the same
issue already, so this may not be so bad but it makes me feel a bit
queasy.

>  	if (new_buf)
>  		sb->buf[0] = '\0';
>  }
