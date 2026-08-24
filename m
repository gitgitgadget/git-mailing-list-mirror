Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8656D363090
	for <git@vger.kernel.org>; Mon, 24 Aug 2026 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584075; cv=none; b=kUG+cMmzm8l99tI9SDJM5jVtMYQjNqh2et2Mwd6D9ST5QETF5t6siD09t6S++OLEkndSXuRrBlW4wqXlm7AgNn8/ZlNPix9sGo6TZXYSMkKNQhKMbHlfFn06Y3inTTupXw8jaWUuM0NJqvK0xHvY6JWbdTlHAJHqSqdlVTUmUFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584075; c=relaxed/simple;
	bh=V9kZM2lYUrQuKAein/TxOYVnNpkzie/TSrpNWtYMUvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UtW038EUUbc6y/MIRPCHWiByDoUUHJoM7cK4EO/ubOz6CC6iQuNQxSc3Bh4o/MXm8BQZ6HFCm2nbpiIiW8P3qwUuyC2cQAwmIZ/LQYq7KcoObcCDNY+1Dcnga4GYn7eQAs//iOvDfMacck/sBx3jbPSfkv3GOSAMvjMXgGsoWg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nBGMo3bC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e7I2meNt; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nBGMo3bC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e7I2meNt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1483B140008E;
	Mon, 24 Aug 2026 11:07:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 24 Aug 2026 11:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787584073; x=1787670473; bh=QCWd5YQyDu
	IdaOwsKZAjU0d0VUKjPL8mXQ6Xm5mNi/Y=; b=nBGMo3bCjZrIvbXJS099WuCHvM
	2VL/vtmdr+5pwSGkxx5vUjh72tXUfiD+v3HZNTerS9tpthbdcsV1MgVBTJoB03jc
	VkWP8+PhKDY24jNRD0ZR1zw0OUy7Z0Sq3ByQzfbZA7OyMeJ4KAKnFFuSBP++yR84
	UjgsS4MMY0OPb8fZAcOLtNyq4FuLarFa3qc9502N6FkYDnNFCBvE4NjliOPYufkk
	HEZS7OA4ll0rwMoYVrZQ1MpP4sEaNmDmU+2VtZMxC50jPdnp+qAFodoBeI1vfCjg
	su5fdb2B6nO+bM4cVs5+dmp/CNYi6BQFKtqty1mi+CCY+J4djuj5dnsg/UwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787584073; x=1787670473; bh=QCWd5YQyDuIdaOwsKZAjU0d0VUKjPL8mXQ6
	Xm5mNi/Y=; b=e7I2meNt4JLrA84IzaLIBy7H6MuiuQbZle8nR0Q2NRh5edzlEs4
	aBHRuoOvTk435Fxf6Sui0VHIGhkkY9qCK7zLKuU4jkqG1V6Lvkip5tZXZ/hc+zww
	TEs8UM6nPIR9ZRZmNfKEWEawb4lLvDRWWwXEHmLCYKfgRwOs3zOh2qMKnoN2BFno
	zOc68/NMy5oOhJ2CvdfJE3BC6ptXN6XNZG0UFf8VMN2oLZ7nnYVAsQx4NWLcSxGE
	Ab1F6qo+5iw0aEzNjn4Ugl4C1+NeSHveMQ4V+M1bWWrYHtipRHZee0M0F0aV6s9T
	CJ2JGCnQdzaCK6xgkkl2AMf/4jN2CbmtUHA==
X-ME-Sender: <xms:SF6MauG6f8GEdc9dgnSBs_BPd7oUZAg2xd6L7Oct7Yh6_FlJ9T4Vcg>
    <xme:SF6Mar6egALPmSZta3SZhvH3V4-MMQco9aZj3-oTUcJ8U5QSW03w33djKjpHfbsb-
    CWYjYqBTdTxy8Ui-VxWJ7Bx8zGz_vS8A1AXH4xABRF-H0LtLgVHRy0>
X-ME-Received: <xmr:SF6MasmDMC5x77jTL-XnDq4Z3vcGgjq8zu5PCSu9BexdOedl9cEniWDxvFUiGCrcG8b3cCfs_4PJ2oS9iCH_JtcqyJlAAd3FMw>
X-ME-Proxy-Cause: dmFkZTFq8RF7aAhhVf4wjmL7824xQt8ehr5o1LAhuCPohStSbNH4Jbv635slVc+jNcl7KZ
    VHBMoqcsLIqhu+p/LKWht1G2hGf/AtS8uoOTjGRC1y9i1IfKOdBCvzIP5PR24MaApSQH54
    Ysu7KLZWiwTVnXkHErV6It8nQbDnu9kWeE/l9Z+yhL6tXIwwZ/d+Ma9EDUEQU6WwNIO4tv
    GZsdcWgoGpCUgu3weIloc8gv4qJJnC67Ir0ZTSB8NAXk8Nu72Pud9dTHB6ryY79qGLneJM
    ZLwBorYlxVo8MUFTw9rSug+xhPEXCpn8p4sFqSnPhcTADCUy+WZk3FtriaHqbPm3JevgUE
    MiDDAYl67cI/copUTtyOBZptreyKYuiZzw85fRLHMhu1XbT16XjbcXpvwdUpauJ+tSBASW
    TtLj09hr7xn/0D6VGxNtSINAdeEC96jNG6tmCBosqK/A/wwhRFwAQ8/fcQcHcG6lhAX4C+
    qkRQK/cYc6rLYdGCYtPHZFSZUf234IGdWx7sYMfZDMXdwAtQ2VjiKlgyhxH5W5fCkKguq+
    rB/OCzdaVO7SWHB2rZwv19E9hPye8fLB67WeIl4DXY7XjQbYxgVQXi70xFluR8PFychFMe
    HcmcNRO9aPmraoB/2AGMpmF/MZCvzFZVyOdn8eHacEqCZ5AlorlfAwUrvM6w
X-ME-Proxy: <xmx:SF6Mau6zzzxp0CPlTC4DPvvNHnEUeJNCkRuv6I3LnR2lSg-LM0bowA>
    <xmx:SF6MalRInR8VKq4owMCqFwya209HzZ-nKyVyOQqFr9-6EarREHd6qg>
    <xmx:SF6Maky7ZSNBSZ3Omio21CEqymT_iFaKiKbqJ4JuV97zO_dhxZnSSg>
    <xmx:SF6MalpwZ54KTzrWt25qNgoJtzCSTO2dogxjTl2UbW2fmo0p53hGgw>
    <xmx:SV6MavV-L3kQl2M6J1Bm3WQJtAGdS_C_GPC4nZlv0MKyGVYEbWccY0Qf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 11:07:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Matt Hunter <m@lfurio.us>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Tuomas Ahola <taahol@utu.fi>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v14 7/8] history: create squashed commits without editing
In-Reply-To: <29ada18c-b849-4bc3-aad3-b4fdc09c81f9@gmail.com> (Phillip Wood's
	message of "Mon, 24 Aug 2026 10:18:27 +0100")
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v14.git.git.1787249432.gitgitgadget@gmail.com>
	<03528d3b34c202b990cc42865a009a5786255b7c.1787249432.git.gitgitgadget@gmail.com>
	<xmqq4igov9h9.fsf@gitster.g>
	<29ada18c-b849-4bc3-aad3-b4fdc09c81f9@gmail.com>
Date: Mon, 24 Aug 2026 08:07:50 -0700
Message-ID: <xmqqbjarsgjd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 20/08/2026 21:10, Junio C Hamano wrote:
>> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> 
>>> +	/*
>>> +	 * Allow "fixup! <hex object id>", but not "fixup! HEAD^" or
>>> +	 * "fixup! main". If the target is not being squshed check the subject
>>> +	 * to allow "fixup! abc123" and "fixup! <subject of abc123>" to be
>>> +	 * squashed together.
>>> +	 */
>>> +	target = lookup_commit_reference_by_name(s);
>>> +	if (target && istarts_with(oid_to_hex(&target->object.oid), s)) {
>> 
>> Why istarts_with()?  "fixup! ABCdef" should not be accepted, should it?
>
> I agree there isn't really a compelling case for mixed case oids, but 
> accepting all uppercase, or all lowercase seems reasonable, or are we 

Tell that to brian who wrote the bc/restrict-hex-to-lowercase topic
in <20260729233215.398654-7-sandals@crustytoothpaste.net>.

> planning to completely ban uppercase oids as brain has suggested? The 
> aim here is to accept any oid that rebase would, but not accept ref names.

I understand that we never emitted hexadecimal containing uppercase
letters ourselves, so 'commit --fixup' and friends wouldn't have
added anything that requires istarts_with().  So accepting any oid
that we would have given the users after "fixup!" but not refnames
can be achieved by starts_with() just fine, no?
