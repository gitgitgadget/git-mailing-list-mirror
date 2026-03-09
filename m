Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B9B3D6CC3
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068401; cv=none; b=LI7EzDLaJkFao9LAqG2xIJ7fQxfhSlNoK6UvP/tXrk18gIqMuJbd2PEBGaSqYFjT9Zp/VTiBsxzNGKN2Nxob8c2eoa/LaLQP8y+LvU68DIZr5kzPI3leUeR7id0JUUwOKyF49ZDJVGt39i2/r2cIa82q3Db0pxrOE9O4X38Q7Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068401; c=relaxed/simple;
	bh=0HhxJ1vdDGxbj1ftgThmzKZjWGOGIH5KMGYUpl4jgOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IjNUhe535T4bXrEJSzKRFpj8GCI2VUiAyLdkC/CPfibWlRbTPVRSc7V9Mer/rxzRJ93xAgJKH07zPF8k5j4ZBMzsKWLBwGOFKeVOGlCktPnPWuPeDA+YJORRgV945ZD/pcroPrMyMT5TG/6Dr/tBxItgQqWC8Hzl6tosPp0i3Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QfJwnrAe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SFDwAmLf; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QfJwnrAe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SFDwAmLf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DD026EC0654;
	Mon,  9 Mar 2026 10:59:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 09 Mar 2026 10:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773068398;
	 x=1773154798; bh=+LMdWTTbnVBPZqiwlyr8qSNIlgQvhJZDnnLKISofDTw=; b=
	QfJwnrAePH7Wc79cJekZvk8oa4pH5kPIMWRmSQJGvIn0SA9eW85PB5n3ve7pPdgQ
	yfWa2c/HC6EVN1VMBChsu2ChUCFEiXySBSFzRbyM3k40ZSbGrfWxdDeV9IICk7Qa
	hLCihs1yVPi6Z1y8uhMtUx/1IlIV72+3zT4PD5fMZ3ydIr0l0mYlWJTa9ZnoLlbr
	uTsC+RC3MALWqTUFTOvadkfkDLn5lduTxuFPrUL25aPZ4JGGXnb12EzVoAKl/0dt
	7I2Y5Z6/7EH37baQjrLAKgqI5GLlcbdmYH60qnA6eimAxKWi5f836NgG4lnfkxPx
	0NIVPwbZPI0FpbwKdzKMbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773068398; x=
	1773154798; bh=+LMdWTTbnVBPZqiwlyr8qSNIlgQvhJZDnnLKISofDTw=; b=S
	FDwAmLfoCLZYmeKUQ6cz9sFNMxjQTcD5FIeZ9L9jHwfnFl8I5qDPOO4KL9DcduUj
	QA7jCzdYpsbz1dYP8HKON0U317lX+1bhz0UHv2NiIQFD5ljbF1RdB8/Wxs90227n
	KSYFwoQgGbW2rYkclLX7mxulBOTGAFI5aTz9Rqvk6ua0Y0On2jLgHdzZYgZxvAPX
	G7jgfFLpwuHn1XNtuA8wQdf9ddGwbhAL/Z9lmvqnJ7HDKpkl4KJKoH+uXx6voAzE
	tPNVaIg0PoGvOQ9uNQV4fH25oRoNCDNGRea4hOvqdK3aOPBzTe0xXnAsDwnIpWR0
	EPpZeC7V66FZAls3ALawA==
X-ME-Sender: <xms:buCuaXMGil8I0an2e_JnsNROMLss5-kJ0kaRTZ42hqgqiqdcCHgiaw>
    <xme:buCuaZYIZg1Xln-iCr0aipDi7BdmnAkLgqPmOBpRfuEtT0iHHCXeLT_e96mhjAfl0
    NCatmN7JNxdODQd8sdBIdnlnZxxZUU4zgj_02JHIEBy8d8FXMx9>
X-ME-Received: <xmr:buCuaTp07pLX7-wQD2xX9wuNuazPnOnefaZjJ_gYJLZB0S17-dekd8C15sKokIu0ijrxbLiDHoJ9MF4OrsmVf2Hzc-JrmFDfPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:buCuaVYcNibg-_O_pRkZ__eVbbT4JWueuRJmU6ot3tavYdfBO7FOFQ>
    <xmx:buCuaTTQKAATEBIR8aaVyc9sXajKkKBp0VGD6l6Wn4ENYO8ZTvuMrg>
    <xmx:buCuaU7f8M7KazrufHs2nh-pR2916m44E97oxmWxWYOJqsvvtH5xyA>
    <xmx:buCuaQwy6nJ4TaCbRsfaDtwD6kLQYiQL5hzBXHA-lTYfGL1XILfD5Q>
    <xmx:buCuaVYK5oVhCTKQM11uOnrvgfgcVRq5-URueOwTtuz6R7oY7odml5HT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 10:59:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bloom: remove a misleading const qualifier
In-Reply-To: <ab59807b36213a51245965fa46c1770de10bcd2c.1773024911.git.collin.funk1@gmail.com>
	(Collin Funk's message of "Sun, 8 Mar 2026 19:55:11 -0700")
References: <ab59807b36213a51245965fa46c1770de10bcd2c.1773024911.git.collin.funk1@gmail.com>
Date: Mon, 09 Mar 2026 07:59:57 -0700
Message-ID: <xmqq7brl6ob6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Collin Funk <collin.funk1@gmail.com> writes:

> When building with glibc-2.43 there is the following warning:
>
>     bloom.c: In function ‘get_or_compute_bloom_filter’:
>     bloom.c:515:52: warning: initialization discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>       515 |                                 char *last_slash = strrchr(path, '/');
>           |                                                    ^~~~~~~
>
> In this case, we always write through "path" through the "last_slash"
> pointer. Therefore, the const qualifier on "path" is misleading and we
> can just remove it.

Right.  Thanks.


> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
> ---
>  bloom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/bloom.c b/bloom.c
> index 77a6fddf72..a805ac0c29 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -501,7 +501,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
>  		struct hashmap_iter iter;
>  
>  		for (i = 0; i < diff_queued_diff.nr; i++) {
> -			const char *path = diff_queued_diff.queue[i]->two->path;
> +			char *path = diff_queued_diff.queue[i]->two->path;
>  
>  			/*
>  			 * Add each leading directory of the changed file, i.e. for
> @@ -523,7 +523,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
>  					free(e);
>  
>  				if (!last_slash)
> -					last_slash = (char*)path;
> +					last_slash = path;
>  				*last_slash = '\0';
>  
>  			} while (*path);
