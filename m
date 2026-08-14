Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB743377ABF
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786704900; cv=none; b=n6sZwA0vikpCjz9GjxS581Gb2lr5Lz693G5ov64oniXdMEW/T4vjaG8ZSIpV0nchzJcxDMytiN8rn1n2sL9XQNFjEz1Bql0AhDnku80g20wQMfKrpPFjF5iUlTDO906/4CAo5cqr0bhedulQ6JHCS7sD4BF5PL+Hcid4Mi239p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786704900; c=relaxed/simple;
	bh=QzBonFSYOaQTDX33IvXfHp9cwbPYSla9f8ue/MlhNVQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=STQXmq9orNaVHgrQCyn+iNd9bcr4E6+rYQwPkxNpeNXN7BunV9HpZIbLfL+viKOWG4ZrHvXlW3y42sIdDIK7GQT5QWHI8ii6tI4ChTEuAmrgb5uGJ7bD59pMmnXcqriRjAVKGXdQ4ygdfdZshhepsZBA6NMnfpyWrLNqoFV5VGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=W6GJt75w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IE3NqRSG; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="W6GJt75w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IE3NqRSG"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 4B5901D002EA;
	Fri, 14 Aug 2026 06:54:49 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 14 Aug 2026 06:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786704888;
	 x=1786791288; bh=M/XEOZ8KvuRM4tfAI8hqvDyO8gqZTFqrw+Px0R4oCqE=; b=
	W6GJt75wkcdUgsWqlIu8rEs9F2L9Pc+UvWBeIZnnIrHCM2nZBO4brF0Xfpy5akRu
	B1N7CDrmxxosTZccYTsTztodPOcg/PxxtMa4ixwneY89z8ZxriF9MMXNxPxp06iS
	2F0ZiArcCar7ap680H0+bEzsjXdJK9j5f3JgfYPwCqVFwxIlrYZT3VgOnPcuispg
	eF6iUpX19i9El7bqxZgHwKvfwwZs6WYlvdfR3q8dcuvHmpzVTHUpH9X+UFUycAdB
	2P8aITGPdHzy65FAxp7vqx19D4xmqo453CvsOOxbYHw6jGHBqXpfLuBeWUeTeXVd
	5HuunClSyseQd4eIlTSovw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786704888; x=
	1786791288; bh=M/XEOZ8KvuRM4tfAI8hqvDyO8gqZTFqrw+Px0R4oCqE=; b=I
	E3NqRSGZBqRKIzfr+sCVPLYy48IYhPQQ65CPc1Vha9OMaCaOVuTcrzS7nIJbZ1T1
	jYzJqnvLmWT/O2GItOWjUQ0xnzgIOWhsyUOc9wp7VT73ngN6o0GnR08jy8iKr4vQ
	dduSVdvrdhstEX6sn1P+da2ez4rmlQKy07p2Y2N56vXL6Tm/Gnwc2tGlIRpGSfWQ
	3a4PwqAgvFO+GH6qp2PhpT3l9psb3Uuwl5co1tGlVLdtJLLpCek2SIh1nRAcz16f
	nFgM9Accmj13FU0vGDgECy54PsCfF0riQJJMBU8N56a5kGpUuJeHclz38cj8JbIz
	5U8UQvEMhmDkFJTEcQslQ==
X-ME-Sender: <xms:9vN-aghDMAeh03V1i5frb-G_Hm57z_nnYhAzEjx9zCHaaB0cRnFcVNE>
    <xme:9vN-aj2OtAKSgAtFNq0cZaDA8y5PEc3zEs4tcmBw1r353KDtHZlc9d0713Ti8XTK8
    NPXj4FAblkwV0sQ4bOBxAfnzKlVYWNyAdwRI2sqFS_nIk4jow>
X-ME-Proxy-Cause: dmFkZTELLklBF980CZIbOEC9SBEjaTf1W2OJ3fQzLJHCNbv+QPdWl91TKjRmNKoyvR7jiR
    4P511aoIgpXHZ+D1WePXxiSttj7y4h8PzAqKemNA8mGaAlNcVzy9gdQQAil8qgQP3E4QFq
    TyK3ZEJO0eWBBYbgEd2gE5+moWhwmGMVITTQUxHtW5sZU37DXziMBvIRJYVi+d00n/tqsM
    h93MRaGewHEw7201ohoMi20OlgSosia1LSdHGx2cO8sLQdlfIClVVkv3sN+b+ry2OsTBdp
    VEQPJYJiGjg8vDlQYbbgthywIrZONbI4VqTXg/CXh+Fbt1IeAzlwHUlnsaKAKpY1gam/iG
    pwFwVIR5g07XHt6VzduiJDD5mwFN3ANc+KHSrDQN8nC+de2xpCTwHNtU7PZcgUo5YZID1V
    BY/6NvNaZb1jQmoshzM5pTpE+uqFtYME4xvO5sciCk0JpINxd8PM32rzZJrXAOC+w3ilLB
    /hr2O83ICEkm36qIshW3DqzLMQxu9AcYPdHH1ae/355z52OqwLnUJZewiPNxlGI/ywXDWU
    SGjoZUbXi0frsZAMOp50EO2+PPos7EeirIneohZIHa/rFWDvmb8AoDMdnAjw6tTZLhYZ5d
    2O46BE69sWOB519+9XlMjLxqYlR7pQHm9GyBTxJEnhw0gbT/9t3//yPZxqqQ
X-ME-Proxy: <xmx:9_N-ajN8sY7KeguCSjW53FW73zNRSTDvLsELqvTiodayOHgfmQoRGA>
    <xmx:9_N-ar78BRiDm50KgLmRvQ4YVlZO1KxEqMyMX_F_1qJ8CQnv9ydgTQ>
    <xmx:9_N-ap3OjUhGFcyLlIb3jdbH0OuBSYpp5evywIYHBUkVZAHUABKXOA>
    <xmx:9_N-akbyVYiiMtmkG2DaBnrfgvERaMJLNmgBvDvZjFCnyY2VlcynOw>
    <xmx:-PN-aokmSjJL3hd8LoDxFx90JpsmeGtLfBUla3DuG18b0LKMPWhTxsZi>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id B651822C0077; Fri, 14 Aug 2026 06:54:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6hr-oidoBr3
Date: Fri, 14 Aug 2026 12:54:26 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <add02b44-8896-48af-9338-bb913e83ff82@app.fastmail.com>
In-Reply-To: <xmqqfr0hswxm.fsf@gitster.g>
References: <CV_format-rev_three_more_opts.b80@msgid.xyz>
 <factor_opts_into_struct.b82@msgid.xyz> <xmqqfr0hswxm.fsf@gitster.g>
Subject: Re: [PATCH 2/4] format-rev: factor option variables into a struct
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 13, 2026, at 20:21, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>[snip]
>> -	const char *format = NULL;
>> +	struct format_rev_data data = {
>> +		NULL, NULL, 0, 0, STRING_LIST_INIT_NODUP
>> +	};
>
> It will make it easier to maintain if you used designated
> initializer here, i.e.,
>
> 	struct format_rev_data data = {
> 		.notes = STRING_LIST_INIT_NODUP,
> 	};
>

That is excellent. Thanks!

>[snip]
