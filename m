Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEB0368D4D
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789403941; cv=none; b=hef6cgXiZL4kbA0olP71p3LobJpiZSIsOf3AI0z3XBMT1XSOo5Xk74n9U41ixsb+xqC0Gxydh9tHS2H+ShicBpqL+0W6tdOJDNdL2cSAH3KUltlhFMHcpKGtSl8C+yG1WEqkAL1XauZJn4JtAfRjPdFXGKwUR+YgEKlk//Vwk7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789403941; c=relaxed/simple;
	bh=G6CJ3RkL3mWiIUtB+Jy1ysJcpqb/3mJL14Atl+Nq4Go=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cit554X+GFl1RFK3M0WzYQrLs5k3UoS6hykxqWasRjqU21lr6GZU/pCt8Kp/1rXc6pBNtyDMOidNtily41alAHfg/DF16L9ZsU4KZU20S0Vb6/0YXoDltsQ6hHViF5I9p12QPuhg2gMpMBwWRR+dE8T81bCchkbSvvz0EXNQgos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YNNGRhI7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GiydGxMM; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YNNGRhI7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GiydGxMM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2ABFC7A0089;
	Mon, 14 Sep 2026 12:38:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 14 Sep 2026 12:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789403935; x=1789490335; bh=O7IR6sung3
	h1T+OZvQ6uUJjNJOpF4THVwnmL7JXpoiM=; b=YNNGRhI7yy8eBPmoim6eF8Frs+
	apr+x5NXOa1JdZuFX62XJn0oAVe2T6u5krv4s+P1lxFRRp/sLAdF5kjCmeEJ+x+w
	HXgTlcXEwSInPbcIDPK2wB6KCNzC9Hc1/h2KCGa30+3Ia7SwMj2Wa4sbeqDdQ+sH
	IzpM1klx+7c2+MtuBjZo0/U49mJaIrd8m566PCkk1hq/rlLwc5ILVXBj9y2EX4hO
	IiCwx5hLZeZadpgrhCOtNkjWTkypCFbnLrm4LdgwM6BWQxTJviyEkvozvxie24+a
	LVjMUJ7knyrCuJarxUV51ySSfX7yYSnany2mqdbtamB7jojNLd8K77SAKyAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789403935; x=1789490335; bh=O7IR6sung3h1T+OZvQ6uUJjNJOpF4THVwnm
	L7JXpoiM=; b=GiydGxMMlicprlrhCuVJ4UdnvesM4b5Z1oDANhNfnto6N7OLxmq
	hN72oNEbHwU0yL/eJCPakifyXdHZpO5a68S4BB4jzwx/0A/O06jq6dezeyC+wMsC
	FMYu5iZZa73VdTSzFcqwKDQIFzVBCDJFOmyxlf05Xa1gVXVl45iL3vclQHOaG+nb
	h84bB8m7BR36xKHPm0GsdqrNkcPzdIrV6eVJbB4VqKU7UKJtbimeyo2nCl15ubG6
	YXVK88C3rHk1VOAfrUHdhSacSnR72TxyEXpDZatIAoqlfTYPLu5fW4zZ3ymt9yhO
	hX+vHeeUSFGrSOneoodFd3bvZcnEb92aXDw==
X-ME-Sender: <xms:HiOoamxLdj9gIuyZVpZyKBJ2otFUrsGl9DF5hGOw83YRfCE_PIwhsw>
    <xme:HiOoapIL3pdVkIb7UDkFR8IVYFtBGki2RYCDUy3tp7DGj9SE5eUNiyLbR5SiBp6sl
    LeDMZPaVLtpT1Xm4gUaNvSUTnDWcpxRJOFC0aSc8t3w5b_G_9a8y4U>
X-ME-Received: <xmr:HiOoagqsmhEOpm6HdjOvc3T_CKE1F9J7luapaTD8xjZ5SdKuqwI4BzkmJMfJEm7wbQ931g70S8hty8WeeZ9q8vgff-TZTPPyNdff>
X-ME-Proxy-Cause: dmFkZTFR95AkDLvSBpQskuOLCUwgr7cyZsb5yVx324CrmCugikFs/WMh+Lip4j9DsG7MvT
    OcwYvvduYpQVPhAQ8R15nMlfT5LAOP9Fq5dtLoKGk1/zRj31XL5+A4Wn1hZDsRtKyJ5AAG
    xOrAHTZyXncz57MW1tZGBHNxGCIPnLaa4o6lnibw5NF0n3bXeEZFOkqDu6epn9HkQBlIdX
    u4X5yLLPcLshW/LQa1UtH+tSMp0DmC7sf0TP+gTSaTdv2NolVMxnMPQgY8Qbl3Q4tJMPm5
    hT5lWdb5EIx/PfFKiUqXLOT9jPr1u6uGsdqog0mAThF2Ei0YBxDbgVNztGH2U8yfevSvpx
    nuIYcgoUmoqymhpCnx4EE6kEproc8rElEKGRjYQ2VmIuuHCd6AxPvnNkMnq6m+lGm5tE4p
    T83yjb1ASEFDl5KMEjZ2KvpAAcHuRBu96z3eqQy3Cu6VH10zmIsyzA3OWSXId0+8x0Dvwi
    WYvfxicqOS1v3uAawzg2I3zpBGckWhjF5B/Xy9XdoXN2nSlP+mhfQ3mkNoI/z5qOA/wUv/
    ghroHH1VSstcANLqOk37Fj19bvgsFyn41MgRGcxJT0BYSAkmCU7Lx+YyKCkUKYc3J43MgY
    Rnnzccm66bu68aIg7a6kt7cG2ECoNXKCsgUx8ZMId54cE5wd1qdYH/b70hxA
X-ME-Proxy: <xmx:HiOoaoJmRUDMDEeoBoYo5B59cKBEtlmDkKn9PyYxZlBxYwb-ClYtNA>
    <xmx:HiOoalQukyjW_hpEAtRMsz0pCmvx7w0zQ0ImsxrXkRiYm_FGHQtmvw>
    <xmx:HiOoanuLthOTcktFWwFEDK74Nr6s9bOdbGkFu_l-wa3Y6zB4TwtHHg>
    <xmx:HiOoamYtp_sAGI15t5VRhKD3CQMSduvmz4FJaz4yxiBJvFXN7cBedQ>
    <xmx:HyOoajY_8sVzMJepdBww1KB5tALKR9g311EcYEC4xV_UAlS9m4MfBXrD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 12:38:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v3 00/13] Fix inconsistent ref storage format terminology
In-Reply-To: <CAOLa=ZRxXimh8W-QBJB3VhbHOZWMEfWXB0ST0a=dOi+PNiR6sQ@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 14 Sep 2026 09:37:26 +0000")
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
	<20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
	<CAOLa=ZRxXimh8W-QBJB3VhbHOZWMEfWXB0ST0a=dOi+PNiR6sQ@mail.gmail.com>
Date: Mon, 14 Sep 2026 09:38:53 -0700
Message-ID: <xmqqjyon6b4y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> Changes in v3:
>>   - Add breadcrumbs for the old names to our documentation.
>>   - Use `OPT_ALIAS()` instead of manually aliasing the options.
>
> The new changes look good, I only had a comment regarding the use of
> OPT_ALIAS. But I think we can ignore that.

I'd like to see us think a bit more about the OPT_ALIAS() thing, but
other than that the series looks in a very good shape.

Thanks, all.

