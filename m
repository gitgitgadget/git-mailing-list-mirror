Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77326477E4D
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718331; cv=none; b=pJr/zAifTHkR8ZPfgZeRZOAje0QfUKQTTvtmzoxMo9pgw4EejDWDepUzJ/9VZ2FIvSDUMhqeQm7Ft3tNHhcAa0symkvzGkMQjjWbHs/RuiDpYUe9LqTUq2AnJLJ4HC8wCm/EU6avIszsnvLjyP5hQlypkvf4/2SHxJeRl1CCjcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718331; c=relaxed/simple;
	bh=I4wEVWtQodhV741SR2gZIpkRoLtCqq88qVV8MusUjJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e1DInNuooKAr+SOwNm0E5gk3iIBzt+TOCasMqeojT9d8jclTG/IVWQNk7+BzD3nDATnqtKL1//Hz7nbWrNqXWDG3v+iqlNS6xAARAleHWrL1dM6ti0kfdR9tagrDDIU/OVvZYvfOxxePf7HZv6MJpfldZucH1g83I/gdUzQEPuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DAgRhRKG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZCm7vGNv; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DAgRhRKG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZCm7vGNv"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D1DE8EC009E;
	Fri, 14 Aug 2026 10:38:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 14 Aug 2026 10:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786718320; x=1786804720; bh=i+5m6iL5EW
	F88muTArvwlhe55OLJfgcYvIR/czOv+E4=; b=DAgRhRKGFyBh5x7Mvo6NUVWCwA
	b8R1CbaSJBCQvsUSXR1HbPU4iPMQ2zjqCyYO4y2WjCZf7CziiucWBsHztXJ7PSDt
	xRHj9k0rphHoCLhbvU1C2+cTvQRYWjATRfX+ZjuCGCrSUJwhYXOAY4dKuvAvvqI/
	UBKFu2qjLOIpizgjizOCE9g9Pf3fZyr4mXpCRxyBZvYdGUsqZen5ldJgWLG2cPwv
	yDeLni1E8kze99xaG0XqwBFgxudP0b61dkr5HlAtudM8W4+7ATKxZUfTFvc82FIA
	AYgSTSbnc8g0f73goknvOqE4qtJkqq2giHqkrjRpY80jpntVWqCMIkMueaJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786718320; x=1786804720; bh=i+5m6iL5EWF88muTArvwlhe55OLJfgcYvIR
	/czOv+E4=; b=ZCm7vGNv65D/rDPG+prPxTh1szHk/qa/z5+3TH1JC2unPrdIpET
	FXKuiBMriV8W0FI9BPhYfxvqkOqUx5Pr9IPvqEz9FJwlGlSe1GjbaBb/ODoepJU1
	Kx0SZzXJvPHc1zwnnFYlCHd4xOjQdixN6OZ2v6ENs4DGd/KLO4L2TtWXr+sGYgN3
	ChQQGH0Ja0jgVFkjvGC9c06ygo7pNwXj3k/HmQ652kB+hQ9oLKJVHiahM2GGzHt4
	zWuHwtU0tdAUJU+/YTxGRCJpV1rFLHqToTTVKSvs0hzNa7V9DUwWRi9+LTOuCcRy
	8EdFPalGjraCuA4JjvkxVQDvsK1/gTewwxg==
X-ME-Sender: <xms:cCh_apD5ZRh4hAzzJiaJ5_s_S5ilP5iP7c5UC1_G0YcLCNGpjJ1nsA>
    <xme:cCh_arPj0-lIHKBII3eJSv1X2i2TG4wgFSCCthUWZFM0QnBi8Vn-ictFpshc-BJiZ
    uSYl5ZNzlaRdjNOhQOUM57MK74Jq19w7II5ZLTgs9GEGTMaVHCpkC0>
X-ME-Received: <xmr:cCh_auYfkllNa_INsxCqrM3qqCk3Pj0tsdG_KIGAFCO5j9rV6ULQ8RgRrtnoddzZbfkp-8gagleUOKJlay-2Fk8mUdHf5a8_dg>
X-ME-Proxy-Cause: dmFkZTEnchuyiLgHHH0Ex1rT4zDKckFg/JiLYd6gXirSXqiqdkEMf3owgoM/8ZKHsI1U/n
    Jbshh7/hozjLCRSvHYlE7zj1hmzbNGPCj5EvnUDkkQ36n6GujV4Lyc8WyD1UrL35qjOAHj
    6r1LkA20i8c64Qht5tAABrgAUOAcne5opSWD88LRHRjAC7j+XA3piXpAjF/NWfDKHK6GEt
    QzYdarYILiz5gNI5+H+hSF/PE/rc97plnCn/qoDclYYtMwGLpGjo/fh0dsaVz4DPxOQdfw
    tMjL4tU3t54GhiiNVVsS5FQ7W9+ViIbKxbCTwqOU96jrkFE3WnnhSiTmJA4GfCqOFG6/Tm
    HJpTGJuw3Y8Qe/QfPO4bWvVDlDZkROnEII1NwABb+KzjYeW7SWsTR25shrQljBme+SUnB/
    HqyataOVD0k85g9HnRJXhxRid5AvstSZePc9eyw6S5ZHlAwjxCf+cbU+TqHswW7Rd1NPH3
    v3P5tbvCziRensTaVCf4MgtUenj8a8q4NSiwR2zX++BDxdy5xMzciGa5WD3lgVaLTAWsAX
    JQ0hGGDP8dJi4GslpOmjhY47XE3Vds2twOLDevZ8Rzp+oQRU7P1OawVcrvnGcxYk0JLRJq
    dDcTlFoirOoZvf9g2+n/LK8D9SUV5xjWvhbeJxvPWoFh5w9uYEUFQ5HZqXKw
X-ME-Proxy: <xmx:cCh_aquo1SuMVqV6FwzukFODPg5ML6d6edQSKrPhhrh2y6rZdKriNA>
    <xmx:cCh_agNCnM2UBWn8WNvRuEqnV1CsUW4nFt4OMsj1jbs3fQctycUM5A>
    <xmx:cCh_ah7syvIGxMSSV-q4CvQqJ7cc80C1J5HFgmZNSr3gtY7GH666UA>
    <xmx:cCh_amTzOW7SL7ntZVTQ-QbdK4Wka0fKmCVf0BU29RoBEfDaEsT9hg>
    <xmx:cCh_amOkpQNUBOogkoVsG2snRfuhid2aSRF4u6K9oSWCudnnnkMI6SLy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 10:38:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v5 1/2] pack-objects: give fetch_if_missing call sites
 access to 'repo'
In-Reply-To: <20260814072419.1666358-2-cat@malon.dev> (Tian Yuchen's message
	of "Fri, 14 Aug 2026 15:24:18 +0800")
References: <20260813061125.1089553-1-cat@malon.dev>
	<20260814072419.1666358-1-cat@malon.dev>
	<20260814072419.1666358-2-cat@malon.dev>
Date: Fri, 14 Aug 2026 07:38:38 -0700
Message-ID: <xmqq7blsrclt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> 'option_parse_missing_action()' is registered as an OPT_CALLBACK, so
> its signature is fixed and cannot easily gain a 'repo' parameter of
> its own.

Is that true?  OPT_CALLBACK takes (short, long, value, arghelp,
help, callback), but the value parameter, which typically receives
the location to store the parsed value in, is NULL for
"--missing=<...>" option, like so:

		OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
		  N_("handling for missing objects"), PARSE_OPT_NONEG,
		  option_parse_missing_action),

And "value" does not have to be the exact location; we can pass
the address of the repository instance there, and the callback can
dereference it to reach repo->fetch_if_missing member to make an
assignment, if it wants to.

Am I missing something?

> Let it only record 'arg_missing_action'. Instead, apply the
> side effect right after 'parse_options()' returns in
> 'cmd_pack_objects()', where 'repo' is available.

When I review a new iteration, I first apply and look at the
difference from the previous iteration before reading the new
iteration of patches or their proposed commit log messages, and I
did notice this business about "arg_missing_action" and wondering
what it was about (which by the way is precisely I read the patch
before the log message to ensure that the log message explains what
I find unclear in the code).  Thanks for describing this.  But if we
use OPT_CALLBACK() to pass the location of the variable, this may no
longer be necessary, no?

