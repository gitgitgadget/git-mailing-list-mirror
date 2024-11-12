Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C2D1E884
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 01:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374366; cv=none; b=QUo36RH+I6pgAtkA6v0bJKLxMBIt0b2+1bTls2xDU+EtLsOYTbp3V/JYn0PnICZ6ft3KRLc2jWny6HkNtaejukJxW5edUhhBcGzyGJXPmxI262km+WPE8fTwRSBaMY6farhxKgbO7nyD+UkdYFZmUOvh45PI0UvH4Kr2pP8DUqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374366; c=relaxed/simple;
	bh=b+7MCmJCovcaR9xXY+m2/LKzKwYEzxC7JSEqeGmklxM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tnaxpt5peTVahHC9cwVYxxUi0faDfWQuvGsy2EvtGdNdUZFmP2I23MBU5AmrKev5+OQRSPK2hPJO453BSBXP3hTKNk3950ktYhufENIIuflSfWhDEdR+7MoevqB/iY/BHswSYXp8ZRSxgdU9VPzB4+n9L9j5og8dLXaKOJND4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EZqcGlzl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CjADzF8i; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EZqcGlzl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CjADzF8i"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 029A213806DF;
	Mon, 11 Nov 2024 20:19:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 11 Nov 2024 20:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731374363; x=1731460763; bh=4fSXT92Gn1
	6/PdJkBDfo5ndmTYSjZXBC3jzYWsR3WvA=; b=EZqcGlzlK2/qlb4fH88fVf+e93
	PdMNMCMLhbniGxxfmWvn8UUSPtaoOxsaSBZdf+czK8wnJboxw0JzyOmcoHT0gWcA
	HGodDMXR45Ni11nahoucCHE5QO+uf/+VBut/RztrIXAZ3XIAZucz1Mm06cgOKbu7
	Li73cDpqXMKw3ZhjoApf2QntuyMrcyL98mqW3RfAeZaFfSwUqHuV+SYI+JWUaIEv
	jXOLs5PTa35GY0bXdsOpzSYc9d4iZ+jccDOWJ198m2Sgf8Kb3UZaw8jiPK1ED8Eh
	mY6rwjrHvK+hx5r1Gr2E2/lxwMkd/25XElM5V6IBNPI9cUYwA5DioLqgz4Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731374363; x=1731460763; bh=4fSXT92Gn16/PdJkBDfo5ndmTYSjZXBC3jz
	YWsR3WvA=; b=CjADzF8ipWwz8dzWyOTLLxK7Mdow0DTlWnNAcUb3lddPbY7RJE1
	deY6Pxdw9n4z4ITaXNOwswWi3GNCNCrrvpm0Gx3sL+w8FtHOt6wItL4KGsVmhpku
	wPzGD7uNBQPjSlsfAVCeusjyzd97P41G5XI9lT/52Mst0F+YaVT7gwzyzLQTCD02
	DgJbiRsUnePJ6eodW8Ivzh1Xp83piYQLNI9MSgthWVSsZ7wvyrZxwmwZH+fXw10l
	b0YqcjbqoKHC2DUm8LAUU6eX2UUOcsjd99pGhfZqkynml/pX6cBIQJpyKZwlzdL6
	qH+YYUOeb/L9KzgSIPJx7vMLuagySn4EZ8Q==
X-ME-Sender: <xms:G60yZ7NhSLvlk7MBlqLnFxSmHDrM7xuYKqFNnxNNTkqCYATAf7Tt7w>
    <xme:G60yZ1-HklgG9HohZUjtYhoDLNkkqd7sDmVqem_BmY3z0jWoYGAomvb14VOQC-s35
    lKX-3oB_EAqdxv8_g>
X-ME-Received: <xmr:G60yZ6RV94A-Z0HDJ5OREt6ta6BMrug0lT-yF2wGFd3CgtbeOkYRawOfxA-9dGKFNXKUSVslidqWoum_Yfg1EdyJY5cacy1BBhVE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepffeite
    eujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgr
    ihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhnrghthhgrnhhtrg
    hnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:G60yZ_s6VJBRAbJauN0TJellorK9AnZ3QtVqCH_84jLVRBMg5iDDmw>
    <xmx:G60yZzdjgmbl9bFaOhXWr2oOIBuGwXJJ81IzH6Ks6eRRwIW1SYJvQg>
    <xmx:G60yZ71EQnQP1GooM0FenWgfp_eroev7ik7WI4X4YsbquCpqo_ttMA>
    <xmx:G60yZ_-j0sARYzMOE3QNABT4C3Fj4HG97PM_tgu1LQKMEHAdwX1rCg>
    <xmx:G60yZ_6kNV3ZZetTiUbhc2_-d-QbMNjDWPtJy3QsuDFxryjrZ8t1aWkQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 20:19:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #04; Fri, 8)
In-Reply-To: <xmqqcyj18dkx.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	12 Nov 2024 10:07:10 +0900")
References: <20241111235337.1691851-1-jonathantanmy@google.com>
	<xmqqcyj18dkx.fsf@gitster.g>
Date: Tue, 12 Nov 2024 10:19:22 +0900
Message-ID: <xmqq8qtp8d0l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> The fixup in your source tree looks good (verified at
>> https://github.com/jonathantanmy/git/actions/runs/11787543288).
>
> Thanks.  Will squashing it in all it takes or does it require more
> (like log message updates, perhaps)?

It seems that that one more "free()" can be squashed in without
anything else.  So I'll do that and merge the result to 'next'.

Thanks.
