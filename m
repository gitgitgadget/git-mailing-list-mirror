Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D83A264614
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 05:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785560691; cv=none; b=A96zc842QPHFC531NQhj/TutPSgwF6LtgpAiLFkvocJphRJiCKt3EloJxSTF3kZH6xQrNdMVAtcFeUaKEATKauezAbOPGHSlOvTAuEzq6KSnjDUykpckwbTkUabc3XeFrnmJ5k7uEP+XLuy2R5d63HZlm//KNYvHrjnGazACpUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785560691; c=relaxed/simple;
	bh=oLk0nsKeGUFy0strRlbHnYblTN1VJRMH0WrABTsD+8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ROur7OqsC68YeBV6kGYveNKFyHP3aQ/aLaAndqr4fxH5Ky7xMdYCjSjoz4mlgD/1O6IuVTG4euKzZlIMQAhIXdihyln7pnrIM7h/DpjYvEWu61Wpk2lri08ghzV9Whq/oUaS6ISK3TytF0b06GONwNVz876W2WcDb4G1zdUD2vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rhmx+XKF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mE9IhGMO; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rhmx+XKF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mE9IhGMO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 19E3E7A00F8;
	Sat,  1 Aug 2026 01:04:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 01 Aug 2026 01:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785560688; x=1785647088; bh=srjfldbfJy
	Ov3BB2LJ+TIlmzZiT1xFX2XTJEvyTAG6U=; b=rhmx+XKFS0bU0BKFgExQowVX0m
	c/Ay6KtCHZfeuXznTZ5Tn5T+8wdf2+hQNn8EH/FL4qrnZrbyHU4HKGHZAZozcW4s
	aQczHen565ycpIx8se+ObQVPZSz1DvktPhTt+vSwHvhEGLxIK7oyT2Ko5y5LAX4r
	23HesSe7cZUNXEI5EOx/vwwl92byFJ4FegujWWHkLg8GsVElCWFo6640qHVZZ4JJ
	jeN0GAdJgwRmFHbfD9gGOZtVGWF3nO42dVcFI4vH90OJjx4QUWKiqRQ8Vbsqar2U
	l6T8vHjZP9ZVXF9HquI/SQybfn6i7/kPGoIQFLfNspe1rpxv/H2nDNj6YYzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785560688; x=1785647088; bh=srjfldbfJyOv3BB2LJ+TIlmzZiT1xFX2XTJ
	EvyTAG6U=; b=mE9IhGMOwS947s2p/q+2C1NNMuPGwr1mWzM0AJgR0T2Mx2Elbwu
	seRQMpj407exWYb3zPHw/E6fTkTM6QqlCjT4Pkz8XkVMkjd5lJ2R0tYzvdQjWPz3
	85uGLue47qQ/n2H+a/I0gagtGo9+c8RgwyvWwVtBwIXhzZ3wKRkz/fRX68DhOZ7L
	DmA9Cm8UIxuGa49OC1+aLVRo4gCzCfwUY6BikBr+m/JK2FDsWQNDqP/A2DteM39s
	YY7n975DJzFL6Gtu+cUmLrdOAjEGU9de0MZC0RsFr3RPW6Ff0+38VNUnEJaJlkEL
	VVMczPhzcCZy3f7xExqdn6cOf5r0AGIpWUw==
X-ME-Sender: <xms:cH5taowKwQK4GhIRCSvJnHMVTRp-4M9zgaTLRJKCEbtZ7HZwcQ3F-A>
    <xme:cH5tajIs6NdSYsOCG3WYRdL8fftGzoJGAQ3bTM3JdSn3HWYhC12X35IhqWMrVl2iZ
    YD-LnVrtmksVbfXSJjQnYJDf5RvzVHpMKCMrPVLGyAeolnfq40Hjw>
X-ME-Received: <xmr:cH5taipQukLXhuhTkTdsEfDa6rFf_ODF7i6oI9Rem1EfNNI6Amnm1CLL0JB96uOaGJzXLGwlqq1_yOzMrcJeswHWlwGNUQ77VQ>
X-ME-Proxy-Cause: dmFkZTGI80giP4ylS307lQmo8KT4kNI098cUfenqvtFQnXoGxB47jc1NXMKz8zzdNbKlUT
    ZL2SXwgCMuXP3xsZ6IT6w/tsLcuZkJTeqne7YMd/Y9ZUccs3WqMJIFCnD2WV/rchqMdb5W
    KqlPC9VaHBGyFbAY3mkACDjjDFUK9UelNYesrvVV/DkaPEYhBPyfXx5LX4KUkc4hYo+Pw6
    WvLcL8TkmVkWuV2zGfPhoMZWtFD8y/qeqTvdLcxoZG6KyuskcPFG+6fz/IzlgdTVXcMeQG
    Dt3myEe/GcFxQMAqIXPVCOO2K78ztCXErOEuhNe6+J4rpF/ZAxc44oBsDFsBX2suo6xjA2
    68tehldOHx0UNCFvLCWPmitzMh1RnVf3XaTfSE7Ct9JlHb54IMHaMDL1mLqDCcvujJitxc
    VrmGhLVRwz/xmwM3Hyea6EjjuCnuljouFsgYsGApzzBs25KwneJJYBXzhpPk+kQvMAbGOC
    CcRZz7hDoYSozxWEA+WuPgVp5xYWkJnhcdXskZo1QTlKMYqIyRvIhAGPgTZWrwDYZgdqNH
    KGBSVdesfBHt+pn0wHyXlnFZwJhStqToDF6ASLRrTEKKPiobQPNUTATkSlvcgfE8c1ae8l
    s3mbzp6/g7NatJ6s5TNYemw60Fa0lUOf1E7U455jOcdLCWLp293QrIADikNw
X-ME-Proxy: <xmx:cH5taiIIs6XoCb9DL5S4P_B5xPg4AxsmjZYb0C31QDdkswVjI8MqCA>
    <xmx:cH5tanS_9pZiM9X_McqScve-B4oXgqcWtt_ri7amuqCMzDpXBb_4pw>
    <xmx:cH5tahsW_hG4RFdYyK1HGz6aSErcLieCof7G2IDyDnMOEjG01v-HVg>
    <xmx:cH5taobzKBKBINqYO8j7FF6lUuQfnMHWbhaIzvvWIl_jSX6CurV1lg>
    <xmx:cH5tatYofjoFhUNbQCQyCaFty-r_zAkf88CnH8YgNcOUZLTQSdJmDEHB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Aug 2026 01:04:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,  karthik.188@gmail.com
Subject: Re: [PATCH GSoC v2 4/6] fetch-object-info: parse type from server
 response
In-Reply-To: <20260731-objecttype-support-v2-4-af577461ed57@gmail.com> (Pablo
	Sabater's message of "Fri, 31 Jul 2026 21:49:37 +0200")
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com>
	<20260731-objecttype-support-v2-4-af577461ed57@gmail.com>
Date: Fri, 31 Jul 2026 22:04:47 -0700
Message-ID: <xmqq7bmaa0sw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> @@ -104,8 +105,13 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>  			for (size_t j = 0; j < args->oids->nr; j++)
>  				object_info_data[j].sizep =
>  					xcalloc(1, sizeof(*object_info_data[j].sizep));
> +		} else if (!strcmp(reader->line, "type")) {
> +			type_index = (int)i;
> +			for (size_t j = 0; j < args->oids->nr; j++)
> +				object_info_data[j].typep =
> +					xcalloc(1, sizeof(*object_info_data[j].typep));

Do object_info_data[j].typep and object_info_data[k].typep need to
be independently freeable?  Separate allocations by calling calloc
args->oids->nr times would allow that, but if there is no such need,
nr contiguous allocation of them,

		enum object_type *types;

		*types = xcalloc(args->oids->nr, sizeof(*types));
		for (size_t j = 0; j < args->oids->nr; j++)
			object_info_data[j].typep = &types[j];

would be simpler to manage and easier to get rid of once you are
done.

>  		} else {
> -			BUG("only size is supported");
> +			BUG("unexpected object-info option: %s", reader->line);
>  		}
>  	}
>  
> @@ -151,6 +157,10 @@ int fetch_object_info(const enum protocol_version version, struct object_info_ar
>  			    object_info_values.items[0].string,
>  			    object_info_values.items[size_index + 1].string);
>  
> +		if (type_index >= 0)
> +			*object_info_data[i].typep =
> +				type_from_string(object_info_values.items[type_index + 1].string);
> +
>  		string_list_clear(&object_info_values, 0);
>  	}
>  	check_stateless_delimiter(stateless_rpc, reader, "stateless delimiter expected");
