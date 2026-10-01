Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577E141735B
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790874669; cv=none; b=mTtEIIH63aetD11Ehx2mDPf1/KUODY+3Dq0MvY0aTeqSbiA+LCI7We898N4Cf4wWU7rBs6ANwVmRpcxkMjVjN8XO/v//t/NxV67tjy9Q4VxCWWIs4D6MftDpftHShQneo5bWbOjHJmb2GFGz+P1Kucea1oYmZn/CfAadJWc6Uyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790874669; c=relaxed/simple;
	bh=4bcS7zZ2p6ZJWvSlCOBFrDmSR2J6EJNG4nEVyjyQ4JA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TvPPvIxmaT3dkFkb494qh05iGEoTbeUDfA5v23jRXVvwDv7sFakJxqq6i9x1k1R00bdmGHTUJpXz1ajFy0TqGaZnzD9+gagVSt/nC1YS4YOkfsR3KvjTQMeK3aIQhJIU/nCxoaqsIWRHUyvbhYWxdj5+K/v7fX8En7ZO+wv4G6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=u0JLScAk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p1tNv+hL; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="u0JLScAk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p1tNv+hL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 66DA4EC01AA
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 13:11:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 13:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790874663; x=1790961063; bh=0/nYkU85+x
	79sLdq+bgJOi0ETnitlPH5l+LMHP8DI50=; b=u0JLScAkh2GIhKVp4F1jEOwWyf
	UYnpO1X1UZKs0KU8q8rXx+9Tpy1VNb43UL9P5Mnqii7EVWpJDYBT12xSmfBjqjsH
	pPdETl8Why3forKh3vifzNpgWAB6FSHYaqF3XsmiOWU2pDXak9HhRd+d9274bRRv
	4T789YT8iJCFViTIZdSCxAxpsKvlUlPntC8ZLPT1M1ggP671vzf8T04ReVQSf1OE
	H9POiX6Ms88vxzhrrJ4uQ9BmKT5UyNFLTkvUhFDjuxXFZROL5bEBG+TqiEDtdzjP
	viLzh3j5aBvx7Hc2nVHI5f7sunyXwt4/Qu2zBvpanQnkF50QhCa+S3q9MKyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790874663; x=1790961063; bh=0/nYkU85+x79sLdq+bgJOi0ETnitlPH5l+L
	MHP8DI50=; b=p1tNv+hL8xWejoN86jOoIJ1RbHZx1ck2ON1KLZPaCfQG+S4n3tN
	9OHk3sAjWLXmUfPCzEkdACqI35jgyFRfya5D3RmQLfwd+iM3ss8ugHhbeCrl2o5O
	QPoEKtHHgJM7c6yjVb9JXyyJ85s5cSGAllSf2Cr7Kj3dvZzBagu3I8Iat6Uoqksp
	7f4+cWooZuCiaJ42dzKph0cjr62Zibn+bH9qoyDG9SPY1pl45qb/u29midHnpEun
	N6ZcQny1PkR9RlFAdY0/NssWJb8DYjGQRgHnUQsQc6GSPekKa+CTaAX78o79GM8A
	EXoBWDnvkKraoTR/z25+Do5adpCrf9VJ6xw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790874663; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:BOkRhbDN/bNQv6aO05omewvTi5nRULXR0d+vScg0HkqwWPb
	DcpN+1RCd0Y/4Z9BvoCBlK8eoxwWsDc4CIB7pu9np4VLVxE19oKn2Ba8XC/HQlYz
	KilTIdywGgclXsH4isETY7N+GdV9eagRVtanb23cp/iL9WM+LXzZw9DBDEqq8b7X
	qwuGAGEHS+/XAqPlnOGEtOWnxWfYOsRTM/JJDpWtwUhIVeF5FA4nf+CbiWTN3x/3
	Ke5o3MTlRgY4NoCwHERI7vekssfct7BwaeGjg0MafmcFOZ5beV+ciHezIo9ofljl
	g597yk0UlveyuxpGYCGVvNgllHUFe787uKe/efg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:5ggY6sTX+9AorQGWDLXveF6w/+a/og48GgE9u1xRAXk=:4bcS7zZ2p6ZJWvSlCOBFrDmSR2J6EJNG4nEVyjyQ4JA=;
X-ME-Sender: <xms:J5S-ahCZ3-ma3r8rIyKuC92UgxHz2KZKSKVTjKJ-px5EZLAD0tPb7w>
    <xme:J5S-ahC2GfgN82vo76AODKYwJkZNw9gG9ePB2sJfxwJOZF6ZWfroDHp1sr4XMjl2h
    kgmDQUJN1SMeHYkstONaWJUEzcerqqVRo4kEdBrYW3wG9tU7xTN>
X-ME-Received: <xmr:J5S-asqhWqij7JZip-oFL7Ucj_ZnBDbQKDsGO3swRHjCy_qU9zPFTiHplovfFMc8_mkCqRUGVRu0GE_hJLLQOE71PAWjYOS-oJpf>
X-ME-Proxy-Cause: dmFkZTFS+hLbOW0HS4lxCYZdRSdUUIEC3gsh7uIE8CRvgUFg4zpeLGIr2XoVOnDRsnUCjP
    Qcgb4c07GNX3spxEN2ywn3/n0jxgUtxsO+2N5wLJ86dXJQmsWIO+m3NGWIs6EhPmnDo9xC
    3XPxvlSfyWsoedPFQuSpvXzpFcLA4s91LkeOgX/l+o10ORAeW0ePlEqSAmg4M3JLmr9jE8
    xhji2+wXAwXPw3sJq9MtlugIlh37h/tjZV0lkMACrNKw4j8nRCzUfFTWOobOkjFlskx1+r
    2c5M+j8cKHuBXQuF+MBx7pbCELGxsTzjienm8L9URQZ4SFw6Xk0l84DwgWW3NFJSGpQym6
    DbHmztdccdBkGcq0tPuigBprkjicZxV4vHzm5uWS85evOZG6cetAT7HAGoXbp8Gs1OaXzJ
    ANn4jdakSaF0quAgMkWBP4qrQfwASaq/HirEqZShVP1QeXv/088riSg+q9eFTcnd7pdR/7
    mJWrFdXwrTyL/C+Mm11HED9pkEEMSQdcPf/S7WALLSmEZsqjfkOQ56+enp4EwMLCOgZ7TK
    LdbOpbgP/+Q2GjVctXw9kEpurFheeHGFLaS+xPK43COu7Bzr2iRXQnjfVHWAqI6Fy43a9D
    zDXs+uVltKwUnfYfJGeWkSmHzAwci2JouNpkGNPT3Zar+2fiAKK/KzLJtm1g
X-ME-Proxy: <xmx:J5S-arm4JnJMnjURSw0goOvIaecQczADPrWMwzZA4h6Pl3piOeU-7w>
    <xmx:J5S-aswkOHMYgkvh8erDHnmbTdSR0vFzVpfFdQIa1XnNZjpge81Zzg>
    <xmx:J5S-aj80eEvIvCe-kIuzk8thVtplPdyGVUbUOvapYuGGpRiSMt6XFA>
    <xmx:J5S-aoIz9jXwzRc4yg148sPnI6HvZdz-2USuv9ZFSUr8XVE4xkMbTQ>
    <xmx:J5S-anT0BuC6tAxFCH8Kle5Aym23qaD0fGpJ68X0Mer1Hub6kNuKSaj_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 13:11:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Josh McKinney
 <git-bugs@lists.joshka.net>
Subject: Re: [PATCH v2 0/3] refs/reftable: fix on-disk representation of
 reflog timezones
In-Reply-To: <CAOLa=ZRVt=e3MqjLY=UkitfSg_YjpsfFjeDsEmqJQm-5YhopxA@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 1 Oct 2026 05:19:29 -0500")
References: <20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im>
	<20261001-pks-reftables-fix-timezone-format-v2-0-a4fd1f7cd21a@pks.im>
	<CAOLa=ZRVt=e3MqjLY=UkitfSg_YjpsfFjeDsEmqJQm-5YhopxA@mail.gmail.com>
Date: Thu, 01 Oct 2026 10:11:01 -0700
Message-ID: <xmqq33up73dm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Hi,
>>
>> it was reported [1] that the way we store reflog timezones with the
>> reftable format has a mismatch with the reftable specification. While
>> the spec says that reftables should be stored as a signed offset in
>> minutes, we store them in the "[+-]HHMM" format that we typically use in
>> commit headers, for example.
>>
>> This patch series fixes this bug by making our on-disk representation
>> match the specification. This will of course make us reinterpret old
>> reftables. But ultimately, the fallout caused by this change is somewhat
>> limited as we only ever use reflog timezones for display purposes. So
>> yes, we'll display a wrong timezone. But it's not used as part of any
>> kind of computations.
>>
>> The series is built on top of v2.56.0.
>>
>> Changes in v2:
>>   - Improve readability of one of the converted sites that now use
>>     `minutes_to_tz()`.
>>   - Improve test coverage.
>>   - Link to v1: https://patch.msgid.link/20260929-pks-reftables-fix-timezone-format-v1-0-3df105a95ed1@pks.im
>>
>
> The range-diff looks in order. This version looks good to me!

Thanks for writing and reviewing.  The previous round was good
enough already but with an extra polish, this looks really ready.

Will mark the topic for 'next'.
