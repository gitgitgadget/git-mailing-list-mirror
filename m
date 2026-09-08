Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D35059D630
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889689; cv=none; b=QXh4pg+aFUsESTir18xsmdGINxase7vVUOMybpV+MQlThWYd2saIKN3xbRP+cX8YekdGqX1FOzf55zgIgmT+PaGqzWwdcd11SN92DoY9C2bGyDuV2zXY3y8Au8KKfMQfW6bTZ8ePceHn6N1zRJdHax1BI1cuxwv4NNY/4aMNwp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889689; c=relaxed/simple;
	bh=/9gWW1yXoXvYRlPeqoMJHon4LfXXZf2CwVKdQlFXsqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VDB5Jlp2cQDiWXtm2AxtY7Gw0aMw1x3n7hk/t6VjUu9P6u0N034hKiD96NcVgAj4vLL7bxvTsM85MrS89F7IR3mtr50dDRwpYs7/rVQf2Ecv81UN7g7thWh+UOHjURBlEkMoyzREWfdwso/+iYRTmcpmdVcRUv/olQyVOXbAQJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VnH7JGzu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+4qv9BU; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VnH7JGzu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+4qv9BU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 261C21400089;
	Tue,  8 Sep 2026 13:48:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 08 Sep 2026 13:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788889686; x=1788976086; bh=271hC4KUUI
	9zWhzTdsCzc+acXmpB1dP+PefKdHn+rTQ=; b=VnH7JGzuhAuXPeRZe/yIEWI8ec
	3LAJ1sFDL99WcwK29tfOhp9BuB0FCamPYeZX4+CeaNmd+ObJldGnoHR1nFq6YD7i
	zTEj4Gr905o9gbopMXwr14pQMXgc8upZr0JacT+NmYQY+iClo76RGKFQDHjZ/1xA
	iCvwq8rzYmTaJVxXUan2Xm8rpYinXbgVpLqV0kqHJJ9GquAFSObEl3NO9FF5EpTI
	fZQFzWpV8ZVh5/VfFIPZZN30NasRXsxpv+fwTpzmrKazwCu5fOjg3BfBS05d+bSu
	SPn0bcdGk8DL4jpkfqE6/nZ/NdLhlyF/UWjuG2CVfQi43MklRHHfQy2CjRsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788889686; x=1788976086; bh=271hC4KUUI9zWhzTdsCzc+acXmpB1dP+Pef
	KdHn+rTQ=; b=m+4qv9BULwosv0Hfqgn68p5mFZX2bgGOgINQtq1z+jqro/resqt
	Y/ARL0mGDYgGpf4Nwq0hr1XAi6lvGF2FsBrBBTbyHTKN7ngagajZ+dNu2PTjwna1
	o7Ec2gmwSU0dlOoYzMD31USSNtVlHlUC8fFe92PJ6ewYxfGiLiuSkq7oY3NkaVwv
	1c2ralqCQ7MhLWQ5Kh8PTQs7MVxEpUxElC+sLETq6zRYKN+f1mjsNzDt3PgyUopd
	4fM+n2Bg9fYt7iozwL2N6s66AlOMOULcDYzkhrwcGIbyAW8QVHC+YN4a6ILVrHCF
	LYS0YtnfsXgx2FoCBUHpGsGy6KDqufcdaKQ==
X-ME-Sender: <xms:VkqgakW3SNzDPULfgyFpPw14DwLKjwuAQkG1calf7b3ta5uR_vQH0g>
    <xme:VkqganoBo3fccz8M27VP5lJKzaiENZYLKk69vBHNl8UWonGiCOxQkCcuVjYvrvFwO
    6AFNjAvirZ9fchFeMb3krBpUgpAaWZIAYuWJkwgYOxIvaQMUVzpMg>
X-ME-Received: <xmr:Vkqgaun6vx-lIMOHuP-8E0F9Uj9am2PDZwbfp8AQqJBCC3a5rt90oqHC3G-jDT3bjxl3JIS8mSXW_rhidgplhR4uaI8oWFiQB-EO>
X-ME-Proxy-Cause: dmFkZTEVyIIAmXyrMoFVAVaFemGikVWbCOwKt/zIbsVHgOWnmI5QPXrKERFZ+FWN2MwDb4
    sMtGJEDAhgkPW/7g9ggBJqw65SYtaGSAxB8gPnDh6tOXpPEifPWyl++cbhMi6bHwRanob4
    FEFkwiuwZBDdbYpla16nLm6kfFOQAdqYGp75KjfomEMRl9rFbm8c54Bkb1IGkPkChvLPpt
    vs2M2fDrIyp6xywOhRn9XBs8tW0y5ZWiDj7aQ3Ox/guBEuuvZIQIDrnMn0QrqLJ+y146aC
    vHO8PSgcqMs0NDxN65bnZ8B2LPktzV1/yOIC31JX3ThAvBIsfeRJSW45LPtq21mHvVAbC3
    90Rykf4odGFIwHXUjgD5Qy7HuBMZM1GOJ6nwprkVi0hOPZkLiLBljUBvfJBZP1DUB4f4pO
    Tp3znpDTfLzPOkP09TsZFhAUW3YVOyE96TDziNrTCpF5gBNw7ItxgCeaRlnYqLCDdSkuAX
    +R9VrsBekKhkKNcn4XdXDlAwHh6dozQd+ScKIbySd6+nGBkA9BB5dbF6MZ+TkzRYkuRQbi
    KMZbII9E+r4cKhvOjiutQk8ataow6VDEtr8ej/RCRPkXWWz2s7BYGJuL78DYaZcSA4regw
    lco1swVdbyiWOfF5tDFpCPTFcw0URl6S8FJmQY8hIPYEEgmDv1bfQGmppgpg
X-ME-Proxy: <xmx:Vkqgav1I4NH7JpS96_DCfeYziYMf1pTDssOXYBWyIu57CcD-zfAPfg>
    <xmx:VkqgajTwjLU8DpVBJngZ2dsFhvEupPGt4dSpo9gIM5triw3Q-D_Gbg>
    <xmx:Vkqgagz8eFUniTwl2SG5YBoVOwYMZuHuWJeb8JwDlhOzNdLsfv7tbw>
    <xmx:VkqgarBpyVyCL1BnUpA9PfxBXtN9a577YiVHUai-j-tTax4r16Hvzw>
    <xmx:VkqgaoHtlJTuRtGiIpAtoxmGX9-X_14kNPjdQtwvazUJ6SdJJ5Og1Sez>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 13:48:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v3 2/5] setup: extract path_allowlist_apply()
In-Reply-To: <20260908164129.560396-3-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 8 Sep 2026 18:41:26 +0200")
References: <20260813154748.2378747-1-christian.couder@gmail.com>
	<20260908164129.560396-1-christian.couder@gmail.com>
	<20260908164129.560396-3-christian.couder@gmail.com>
Date: Tue, 08 Sep 2026 10:48:04 -0700
Message-ID: <xmqq33vjy6qz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> For clarity, let's change the `int is_safe` to `bool safe` in
> `struct safe_directory_data`.

I am not sure if this clarifies, though.

> diff --git a/setup.c b/setup.c
> index dfe05d9a03..366a7dc5c0 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1338,67 +1338,105 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
>  	}
>  }
>  
> +void path_allowlist_apply(const char *allowed, const char *target_path,
> +			  bool *matches,
> +			  bool (*allow_path)(const char *path, void *cbdata),
> +			  void *allow_path_cbdata)
> +{
> +	char *normalized = NULL;
> +
> +	if (!allowed || !*allowed) {
> +		*matches = false;
> +		return;
> +	}
> +
> +	if (!strcmp(allowed, "*")) {
> +		*matches = true;
> +		return;
> +	}
> +
> +	if (!allow_path(allowed, allow_path_cbdata))
> +		return;
> +
> +	/*
> +	 * A .gitconfig in $HOME may be shared across different
> +	 * machines and the config variable entries may or may not
> +	 * exist as paths on all of these machines.  In other words,
> +	 * it is not a warning worthy event when there is no such path
> +	 * on this machine---the entry may be useful elsewhere.
> +	 */

This is inherited from the preimage and not something you would want
to fix in this patch, but I do not think ignoring missing path like
this is healthy.  You do not know if the path given is missing by
design (i.e., the set of paths is union of paths that could exist)
or if it is missing due to an error (i.e., a filesystem that should
have been mounted is not mounted).  In the latter case, ignoring it
may make the system behave in a way that the user did not intend to.


> +	normalized = real_pathdup(allowed, 0);
> +	if (!normalized)
> +		return;
> +
> +	if (ends_with(normalized, "/*")) {
> +		size_t len = strlen(normalized);
> +		if (!fspathncmp(normalized, target_path, len - 1))
> +			*matches = true;
> +	} else if (!fspathcmp(target_path, normalized)) {
> +		*matches = true;
> +	}
> +
> +	free(normalized);
> +}
