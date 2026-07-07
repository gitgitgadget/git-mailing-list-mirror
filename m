Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77C52D47E9
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451822; cv=none; b=V9VYqnN1DNBTzS9HpSx/mBVXyYrxznmtamaZVkiSk4qo3G35uRPkOIu5V4AEAdc14knpI3FBtJ9WxJzMUD2M00qRL4yUayepOoKlFmEIL+WJMvqQqp5a5tOlgSAgO9Lkr6/+ZtqAGyyd/W9FCl26Z0MGgHGMy10JSURIiS6ie9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451822; c=relaxed/simple;
	bh=TaCbaLsanyUwQwL6ncmIFCQE5SvP4VmEBxY2xxFuLyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SWv8+O31n+CW6JsqI8S1cE0W0OceXiprBc82nQ9RsrLbw6NDFAWbGwulYG6hnb/SxNIIycyKKF1imaasytztd3j2VlRl9GEWDjbj1xyJbp3rqX2Ge+u0I8vBWol8sBR5nqcQbevedaMX+1uS+UeoI3BJjdRE86OjKlzibm4o7uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bvURZnW9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l+5AhID2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bvURZnW9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l+5AhID2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 095671400074;
	Tue,  7 Jul 2026 15:17:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 07 Jul 2026 15:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783451820; x=1783538220; bh=LUBgiiBvGt
	NgH4OP3h0W17SZgG3Z6MdEsanp9ZE8yGQ=; b=bvURZnW9YQb+NCYPUZzZM6hOXO
	XD89oVb2Ak93Rg19B3GQ1iJKHdG2UCFURiNLXmv7/YZePglbHjObeUwG+4dpRD5F
	PYYqmhZ8Lp93WmWBWcy02tZKViNX8wkxjKnbfMsHPa8/5zFTfiZBY27mZmlvNI/7
	EWqwMTbqJCseq451FmWHfAboqTLvFFvw6Ywj8L3vsx9xTjc72/3etKZAISF5ktFa
	7zFLfzGHD5H+cQjbAkTe78yGrHXKk9K/uOKIKlPSybQkX1crylRyxTQI/itr/lcp
	oElQGZLjvczCI6zSGeVTQ+Jo8gqLfG6Z8xetq4ausjHmEuyThnvUUQK2ch1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783451820; x=1783538220; bh=LUBgiiBvGtNgH4OP3h0W17SZgG3Z6MdEsan
	p9ZE8yGQ=; b=l+5AhID24CZDJdQVTkgLetPi5/kgQUjNI5DtyeJEBcKHj4xRY09
	qceAQFuQLTitbBGad5z6X6nWLhQLjXF0UXO+s/eI/mHG4D6D2PaG7S509Dg0FScB
	/elyFEHYbFqO++wq+YONykWmXoqJgm7OGXD+fSLlnptdAXj/ZODxIti0hkUfVH2R
	bP2ocVeXRhFw3R5YEvJIXHHYeeOmZgqKME+tGeGIYF38eojGFDmuuMPYGvwVryE7
	7qt/olvM77TlzTM5R5Vl1zNAuI4hCEPmVNzvNtEX+1o/Go+mlnEphQCOQVXPsR70
	Dhusq29JxDMz/W5aQAra/SxU2+GFxHh8zxQ==
X-ME-Sender: <xms:q1BNal1Q3XNaTPdDExWZZFtQ5h9Wr3t4sI7uPSI5U9lkkIOR8c7fXQ>
    <xme:q1BNajGGWUpJahTEPKdV6xDdbjMSp0nG4qUKjzyU7KRKszlyooJZfVVYtKEyNzjoJ
    Oc3xi2j7x-ZneTV1Ljb97_Cjyips50DNeiHh-1u3PzyZA5qLnbGNu8>
X-ME-Received: <xmr:q1BNaq42xLfzawx9y9grXtnQomaaeUbLVh3Q8-nzsEovF0trUS2UdRpZOjKxjqoH8UWHwRoS-qJA7tWJinqZvKiFwSVbALKxXAB0YDw>
X-ME-Proxy-Cause: dmFkZTEn17maYZJ5+tQjd9VVwi+KEg5VKqGQ1Z+rYNyUI1WZkaxX+GXS1Q1pHCJUGEOLpY
    z86cC8uL0kvGaYsby5vAw/BtzlvnjTAaJO1ACxs8RsSh1+1E4lOZ8RQAZhdXgEN9fCRABM
    r3CISzVLJa75LKVtJimeEIoLRQcR4TdVQHZW9G0FKEHTZDfnZr28sXyw6zilx0NdHLNrQ2
    2EOZBrIplsCwY3Mq6OX7/3pbu3Gj8HvvmAKm1ZPPmbgGtANk5SIi3p1O9f6rZUepeNk7a/
    ksAOt5zoW5qKtlu21QPwu56jdpQI+xdxO7BLSMC1+YtXRdSAsLdxBSL8BLLtPIZox7FATs
    AF5ijDX5w82fmQN6YtQFDZ81Ptyok4eiWnd9vWj0VB+iiOnn7QD6osAVqa6yEEZMGSNSxI
    Fqb4SbuuBRpeXhN/KoBZBwl/RO7jGDi6agIoij3B4vLdTEjJUYBqVVuHnPLTclTj+PoKGF
    PsjPysQDGVDO8ZYYtqfZ6b9RkXtcrSc6xVQiGsW0TTEQdzMzx7ALxgy+HGH91EoBzljUM0
    pTZcVfhpVvtGH+JrqaC/Pwfk20aYkpdsB9lhwqGIurwQ3b3KEkt4fYacwfbH4pFzPx8zzg
    /My+DH5c5u/5Z5dfx0IZXPEKXgZzx5/+T8NNAr8zOfkLCnKiw6VfQu8wcykQ
X-ME-Proxy: <xmx:q1BNahuqM61a1O4zPL4oNmTT4m0WOgRq5h5NdNFkTlbW3Vsi7LrQTQ>
    <xmx:q1BNaj7l-BERdY-WPTdLoIjsz6bpItyKY6ejTy9Badz7wIiAYckFNQ>
    <xmx:q1BNakWdraz5PL0n2onXOgoAwF5CL-Rfiy3Io_dPsgUhi1fK8TonNA>
    <xmx:q1BNat8Hv9qOqGiiQ6iQi6VYp1D0F96wQ-CKonMo6PiqLluh89WONQ>
    <xmx:rFBNancT21Ri23T8TrB65KBzyk5Ge9gGIQUeNfHRHCUDtP5tlALSPpPn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 15:16:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org,  Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH] http: preserve wwwauth_headers across redirects
In-Reply-To: <5144a29d-a53f-4446-beff-e1f549345bf9@nvidia.com> (Aaron
	Plattner's message of "Tue, 2 Jun 2026 17:37:48 -0700")
References: <20260602161150.1527493-1-aplattner@nvidia.com>
	<xmqqpl28scll.fsf@gitster.g>
	<5144a29d-a53f-4446-beff-e1f549345bf9@nvidia.com>
Date: Tue, 07 Jul 2026 12:16:58 -0700
Message-ID: <xmqqo6gi3905.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaron Plattner <aplattner@nvidia.com> writes:

>> I wonder if it would make the design more robust and future-proof to
>> encapsulate this logic in credential.c instead.  For example, we
>> could introduce a helper function:
>> 
>>      void credential_update_url(struct credential *c, const char *url)
>> 
>> that does what the new code added around credential_from_url() by
>> this patch does, perhaps?
>
> Yeah, maybe. I'll think about this design some more.

Sorry, I lost track.

Did anything come of that discussion?  No rush, since this change
fixes an immediate issue and the helper suggestion is for long-term
future-proofing.  We can treat them as separate steps.

Thanks. 
