Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A60F70808
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123235; cv=none; b=BEg8ZcOb4gJuKn4ijfFCUJXTL57Af7hjQY8KocOXneAhhgnZuTD0bm6WARSeAxRWMqD5dUUfj2XbABprmvJho/1s2Vj+roK83Th3hrlj+XnH8lNR9rR+fjenGfbSReL8Uv5IBP/KTqxzYejPfJPvz8uxk58swsFWwi/ZxG9V1cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123235; c=relaxed/simple;
	bh=IQFRKxM8eVb5I4UZnMjQ+gHm/hqp84WKqhtlvSYy/Zo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q1cF6wXXmCtFzU/Ez+PGMofI06MJxckkpQmjvz5Doc1+ceOZFkX03CWs2ZeWksYOAT+hEyZT7s9JqsjJEUVkpOEjMUnN2LdXciMRLS2RdIJjN8XxjDZWht765h8ImRjp50obhwGMyixCllPalxLTA/U9diIy7TqpHMykBGfDS1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m+4DImQ1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z2pDN6fm; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m+4DImQ1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z2pDN6fm"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 66595EC00F3;
	Sun, 30 Aug 2026 16:53:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 30 Aug 2026 16:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788123233; x=1788209633; bh=IQFRKxM8eV
	b5I4UZnMjQ+gHm/hqp84WKqhtlvSYy/Zo=; b=m+4DImQ1W9oAVTVL4aKIviIAs8
	WRYGw91okICdUikFFTmWjtoofgCZ28ipeNWkAYpw3Sf+BIa0R8psAfWh9HcKgiQM
	Z9l+OoEW3ytWgCYVofZx0L8+v2ucBvs+VNg7O3KBBjXCvrRyhibCpRnO2j4OIMa1
	vXGg9KXSF+d9Ky0gpDfUhjtnHpqHZbS4FLb+1bYl0opbHK/rQ1unMl89PCawdp5z
	Kl1S8JDbKfAH9LyLpoc5gRAU8GhxetVtb1tUuY1rCNcq5UOoe+96QwNLPCx0pK3F
	ul+Url9j494nN1TOHJWnuHLLcG3fvJOeRlSolcE4EBkJJ2IB9X/Cizss/UBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788123233; x=1788209633; bh=IQFRKxM8eVb5I4UZnMjQ+gHm/hqp84WKqht
	lvSYy/Zo=; b=Z2pDN6fmO5mM/MqQ6Zzb18zFpzddBPXR76X2mefG7AhgPnxqE9c
	Dpsc5Ik9BarYnivqFKd3y6zUwnbBtkU5JaaVXrV74CKwZrJgARFmLlJd3h26DYx/
	enF04Jhgn39T4kEUDVnr40+VwzXYK5AoTE+nWgCzHsF7JPHuD8vFx3ZmXFKEEy+h
	dIzr17WxEgzDZYOeI3UFp8u1BaapjUjPH8Y8TUnZ68sjXksjKIdoX0CXN8Mp2yrp
	UsyXZEuZaRvrxpbXl6E5/ZoMvC1bJt+XSvBZ+SYUhRTDVab9oCEHCms4eEerX4Ze
	I/kdi0a9Z6Sk4Cp8fcDcQ6hjhdNqaBJWFQQ==
X-ME-Sender: <xms:YZiUaoaCKCLZiWX_KFt2gonlWwB1__dn41EnDjXqpOL28IW3ePL_6Q>
    <xme:YZiUalr72XbPKE1R0dx9oK8AHaLXZ33P8i8cOcce0psAgb3k3tEZgNJ0gNa1VD2nM
    _1yVqwILvuX55icjSmhV2P-eaZZmkeC20Ng1FTYnCa0vbhW8hsb7A>
X-ME-Received: <xmr:YZiUalO93iAhPUhK9cSyrJ2PD2VXtfLp9uMeuA4yjTTjtKZgEnoF_sUBA2GfoadsoPSnfTW2QyP3-Q_d5nKdFdp1cg4B1yvHMA>
X-ME-Proxy-Cause: dmFkZTF8ubR6vtc1sPoYNZstXGnL6AOOKTK90SoDM/gXaHh7UiYGFRnckK+TF2jHxWYm6E
    W/LmwgnlYkKFSwmhi1vhFR/xXwGzZjnAwc3NdUU6QDYhKxv+cA/d8JjgZj7sVpT9i/Hejd
    9OmIs+SYGgG8fq7/iAp2n30MNd55VJqFf4+Ff9z9qmtwcazR65/8B+7oes6Bze0/PTRTv4
    aTF4uMbZ825sJyenfrgG+2xj9C+f5gTmLANv50LCF8qNXsxyoFIdl4HdMRUwZOrnwoLEzX
    wbKz7TKGyHjtFaDcLUc+uH4Q1ZpCQ8U76kI8xph93MczQ2NmlQklInlVTHsK4/+C+pxFtO
    fwFXra0xGEXBC5jvXTLHUMkhVnXwSL5nHjMNxtJg7ncflwQ0dkz6YHXSq5d04icXgAM1vD
    sDg1aZQphnxF0BQRlCAmVQyiX3rcgVHif8velmWzW0eS19RdVE6GnErilkcOAH3BZ9LT9e
    kqp1cSl4DAyPaBqFVc91O6iQcufmyeOMZYH3lByvWhlKn6pWAl0aQcCoYB1oul9gZo2nT7
    Y7M05M86h2XxpbysXk2IGU9FEhVuhgPVzZ/HGYH93gU5KO0PNs1a77KU74Gyy1YbzBGxkJ
    CqeLkfNHYv0GIzC898d9A5LT953lOIICHq+EiPpefd3ADIkelAP4ytLh7LkQ
X-ME-Proxy: <xmx:YZiUaoqcIi44mCGIdIHJJBRcrf8JL9r_3sxeN33qisTi9j4WRReDvg>
    <xmx:YZiUaid3TQCFo6zkPtD8xPOnfAeBFy0ivjieyzib7bZKiHR8H4ndaA>
    <xmx:YZiUamQlSrbiY0yUSXShZW4H8i1FSXNULXzBEKBRWj_sCsxLIy5fyg>
    <xmx:YZiUajYfNN-nHqg68XAL8hsQVKz1fn5UVY_k8WIrJFECNlyIYxWuzQ>
    <xmx:YZiUalu1-8px_Rav9Ge4PbEJkzC2VhvRPOXo85CKEa3JIMzV3_i-BZVL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Aug 2026 16:53:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 4/4] packfile: recover when a multi-pack-index names
 a removed pack
In-Reply-To: <20260829120721.GF40814@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 29 Aug 2026 08:07:21 -0400")
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
	<pull.2207.v3.git.1787986831.gitgitgadget@gmail.com>
	<9b0966df9a060df215d8aec7816875d42651d5bb.1787986831.git.gitgitgadget@gmail.com>
	<20260829120721.GF40814@coredump.intra.peff.net>
Date: Sun, 30 Aug 2026 13:53:51 -0700
Message-ID: <xmqqjyp71g9s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> ...
> Sorry, I know that was a lot of text to end up at "you have already
> written it the best way", but it took me a while to reason through it.
>
> The patch looks good to me. ;)

Thanks for a very informative and well reasoned write-up in support
of the series.

Shall we mark it for 'next' then?
