Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AA21E7C18
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164916; cv=none; b=OQMuK4U0ZT6e72MLrJngcwo2XDKZiWwF66jGXHaAzwFDxNBs3PAZqwvX4VRPBhRdrQgh8OJna0DEmiqbYDnyrJV+GQyPiHozrH0mMWK8JArmvcfmynG+0C5tXCB6ygG6tkDSdq4w8V7QnsDWqdBtusk+LA8959biL1hNcz22ad8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164916; c=relaxed/simple;
	bh=xO9rlGjo4+cFXUGHuraAMxEgKc84TUbYYbW7GJZhr7w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FtXbfukeFgWBh5SAIMvznNBHO2fL2iOm/DS47Lh0AVxZO6uCnfkbnqpKFBNi07K5289tR8zC2ql6qaA3ykKRNNS2zXrrIO3mdyThjoKJLWmPRGX8X7goRWlbUqznTdcDxZ/8UxDXkriLd+VHRbe+paP6VyUJoFt7q0dF2OOC8IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k6KIN5FF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wpREWE6o; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k6KIN5FF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wpREWE6o"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 81846EC018B
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 11:35:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 16 Oct 2026 11:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792164914;
	 x=1792251314; bh=Hwl5cSN0FIePFTKUCdM4vZMP8A0EgvhU82jEXGlH0zg=; b=
	k6KIN5FFUxiGcybUOpZpCki7RdczHmXUXjTZV0FTneLU6KKDm6CerhD9pgxcsI9G
	YgJLynIffX/t/ZMwRXH+1FQxX9f8G+8kPoLKQg9FTZ+xCTvuXF/Kupx/j4rBE+Ur
	pWxc/XgbHpHHlJU7laU7CmhilLjG9FJHfwwJDKWKNhaWiUwv7kjk6Gn08/F8yHqF
	mikgyHoNPjgNmgoOOloz91J8b/Su2Tddz8wwH1+FJ2EwOyFJAkAm6Yacg7URejYM
	G7wIPgoTUCvop8gSq0XirnC1VHq8/w8ub7mkcTDZqA2am3AEf1Rg6qh0RlLzk73K
	pPSFFh4k5aA6s9LiMOgqSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792164914; x=
	1792251314; bh=Hwl5cSN0FIePFTKUCdM4vZMP8A0EgvhU82jEXGlH0zg=; b=w
	pREWE6oXyAtL1tyNGXlqfhl6pKSBHIvWRDTNwst82kj3OqSPVpYfP4qvxJiF8sw4
	hWSNedYVAwdGRQUTra6mqBnvHAyXgVlY4WQ5FNPk60G/QZ0mpljctjy/IumQqFvC
	Liih3FITYzBcUITFFAf33jsqhpoO19RguXfjNjaCWMl7AT7Y11iECukT09/4BWd6
	RDiXJCDveL8nNdPc2La86hu8S+aiqoRjLOh5nlSwWKs3hHBXofkiMJQhLGFQpVnk
	fY5YfAEA7ez/6hob84f1sN/Kd5vwkitIgZ8M7gPU77tHfZ4rQiNlnDcIlcQleN1l
	gjqFUliPPQpVzNtqP8IoQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792164914; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:KdOR1gk8LwfkgEPdoiEdnf4QZlW8OFbAAiTH4rnuUKlwkKj
	Mdp5IjmsrqNRhBMBoZlEmjIbzvKs9+4Sqru3iKGcOhaeZTzcqH7VrOK3r+24Q7WL
	L8zwb7KiiMGSKS3LJhRUE47hpeAZhnja0Q9X14OcaFIrDD/98uL3aCjsafk0TKJ9
	4/6jp4BA6kJJCkR8GaYv9s/EJYUH8GAQDJKDUjdBWLtawYRdrleIP2f64XvJwtng
	/znoOF6Obul15X2snbocFiVk9qnlV4P21SMhsSIuvYkfWiVl6vPmgwtcoTxpdwPJ
	8Pl3agvlzCPdyxNF/oiDeGzKZbGqJApXUzhxaEg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:WXFCF/av16XCzcJy/5RG8VK4shODe0q+IK8XxTGR40w=:xO9rlGjo4+cFXUGHuraAMxEgKc84TUbYYbW7GJZhr7w=;
X-ME-Sender: <xms:MkTSagVkdSwYTrIekiMtS8xWh8wkED5CSg1oCB9c5onP2hjVi_KTxw>
    <xme:MkTSatBuNzkciM11yq9pz_PjUCnqsiAhj0xIyC2GyG8PoUYjya9evHh891pWh-ZqW
    mqnB_0N4XzABpr5yJH6ACK45Qod_fqGi6O2xFjpbk-Gf6KTFc48vXM>
X-ME-Received: <xmr:MkTSak1-1pXLh8lqeNIgmBpXrJiIiCJyTaFyMFbP_vAtZ5CKgIt5RN3c9R4kh2aHOngQIHcLSeuQZl3rJhZsv-txoeBSbHJd8imX>
X-ME-Proxy-Cause: dmFkZTEw6gx+2MxyMJuGX5QDOgCkrkSWkizISajj7awHxl2SwL1SuU4kPe3DzRvbGGSe2C
    YNnQjb3nl+ZipA8jLccbv4Xzit3ToSiI3HQXoQZTJxHHzJEnyElaT2juua/vKCmjocgh4n
    fa6XvPcsFew1CQsEb8Udo+Z7KE9um3vWTL5Hv+PaaxfoXgLWDn2fltNIVTygXEOa//rU9h
    2YPybxqZGOcQtA3SxsyB6ULUDU8wZnoD78BjuJ906sbVmCIxzg+Hux5cfr5lpy9qTCjY+X
    uBq2Xi9JddSHqsMrCIIJUsNNToAxT47DueQ5CsgIM+E40M52o+nOcV636zV0zklPkodoi4
    Ei67UYgMIVmUSz4Wcc8axhY1DnARz5euT7Ur1aGl9+FkPNP/1UvjsScg2LJw8NY2Gedrep
    xDbRgzTQI3kLds9WTSdELV0Kw5MEfDi8ogcPTsZkQJoiJzSojQFbdkY86wMEDhdKXzbBtw
    /Us1T77oWrtXTiwnj5+LWIDWXBBQSsOsNHsYTyndjZOfGIU98/NdOjmFbThzrKGxVHy/Tq
    Ni6gh8z+LVwC4ejYu9elBi6bfbTVSypvyZ/cYUVZh4AEjuCIQkTJQI5oYLjANArO6m6jRj
    NXRLV5U9q7tNteXjy7fA0Uk9V+RLVuqhSG2n++m05SOaZooK2Ah4coX+oD2Q
X-ME-Proxy: <xmx:MkTSav3DPh0wrBpzpD0XT9gFUph_ie9y8Np8y96DWa4UkHgDQeN2kQ>
    <xmx:MkTSapDfOnpfUqor6pWKsfjpF9vxKKVfhYIWv_rINOQgHkVtO15AuA>
    <xmx:MkTSau4GtfazbX8Fpq3qt8XjvQH-i8Mw9jShrZoRUHALU3MJ13P1Ag>
    <xmx:MkTSaqLLg3UEBT1jq6dP7lOMGfdPcngQTJSYG7U9lWQqQZpLe-U3Tg>
    <xmx:MkTSanxhlZVbvti_vqaJu-Sa3yW-PqBiu2yWPRdPkSsNj2j5yLvxZlzr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Oct 2026 11:35:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bence =?utf-8?B?Q3PDs2vDoXM=?= <bence.csokas@arm.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [Bug] Porcelain allows creation of '@' branch
In-Reply-To: <fc3de093-a051-415c-b40e-f9df5c914704@arm.com> ("Bence
 =?utf-8?B?Q3PDs2vDoXMiJ3M=?=
	message of "Thu, 15 Oct 2026 09:58:31 +0200")
References: <4e8d8b75-ddf4-4602-a2a8-26e5214c65f0@arm.com>
	<CALnO6CCph_xC394v_BetLPyoriYc9dLZY42LsXhjVNdvt2e-cQ@mail.gmail.com>
	<958622c0-e0a5-4e27-9815-cd1fff2ed111@app.fastmail.com>
	<2006115b-bcf2-486a-ac7a-681caae686b4@arm.com>
	<fc3de093-a051-415c-b40e-f9df5c914704@arm.com>
Date: Fri, 16 Oct 2026 08:35:12 -0700
Message-ID: <xmqq4ielirpr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Bence Csókás <bence.csokas@arm.com> writes:

> On 2026. 09. 03. 14:35, Bence Csókás wrote:
>> On 2026. 09. 03. 10:38, Kristoffer Haugsbakk wrote:
>>> Not a bug (2024) https://lore.kernel.org/git/xmqqy12z7eti.fsf@gitster.g/
>>>
>>>      I suspect that it is much more productive to deprecate and remove
>>>      "@" that is a built-in synomym for HEAD (but "refs/remotes/origin/@"
>>>      does not act as a synonym for "refs/remotes/origin/HEAD"). [...]
>> I would not want to see @ removed, I have abandoned using HEAD years
>> ago, too much typing (especially if you want to express more complex
>> things, e.g. `git range-diff long-branch-name{^..otherbranch,..@}`, to
>> pick an example out of my bash-history).
>>
>> Bence
>
> P.S.:
>
> $  history | grep 'git .*@' | wc -l
> 74
> $  history | grep HEAD | wc -l
> 0
>
> ;)

You have some unlearning of a bad habit to do, then ;-)
