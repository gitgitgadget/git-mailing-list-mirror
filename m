Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89F423373D
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771626665; cv=none; b=BUX2FmNwzNIQtQ80vviNojHJQhQiBQtiHjynf5Qr4TnB05WM777b9DiBJXxzT7ER2ETSqnAlcIklakhqhGNuoGfnOta7AVR0KmKR3i1qtU444ajxkWg02r8g0jtAoM9oaW4x79k+Ml6re6GTN8nH4qt9j9owF6ZNBte5DvHL5ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771626665; c=relaxed/simple;
	bh=kLpVHmtmjXHmCzdXxJ07dERJsDGjQPltsh5ZBxrXbYA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rygBRVOpT4fCM9ay/PTh2dw6tq5t4JvEc4rySvvNW1OiWclSm+rEGvd8825UqF7qX2QhxTDpydNzuBqpKIHHyvHKrOhVb832U4BQysSqPYsIM9xf+8Y2ZVEfMOCRjBmHGoxw7FPA6XB1+u3d0eNmWhi587HENDP4HbNA9DElOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ThyJltB4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vdYJBsMd; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ThyJltB4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vdYJBsMd"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F1EB67A00BF;
	Fri, 20 Feb 2026 17:31:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 20 Feb 2026 17:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771626662;
	 x=1771713062; bh=SX9XpYre9NcA98mQ8o6hHDZIfFi/khrvP7TR4ZEfzdw=; b=
	ThyJltB4TPNyM4112EFnTWiIZha9OFha/MAJWUO+qF4A/t04OSo3irxqO2Oda91z
	AxjUQ1NL7PE3c6Qjw0jY1OEalt+4C+j28UeoNo+YCC8Tb7uw2uZ6w7M/ZAbklbum
	hEbNfTSHw+Zn2qaz+n86ZEklXGuvsjYx2+ppMi4xW+fcb6X96QxmOc3ARgA5sEii
	UuOXAsG1yRoEotRW4cDhY2RquyFu9f48LAWtZtfGczvxI/UHel0y+U2uCSwaVAQz
	YyGODQvPvkT82EgLedX75OcZhtjqHrQc9IK3tgBICWENFjwjg+XHY4pIRjBSQCt1
	OTdpTuhZlG80GO6Tyiocag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771626662; x=
	1771713062; bh=SX9XpYre9NcA98mQ8o6hHDZIfFi/khrvP7TR4ZEfzdw=; b=v
	dYJBsMdy4trNAsSf/GpMi/BcGhivi/N4Sxboagu8AghjzarU0B3qHcG5ibpgKmPh
	pzXguTfi8U34ku6gvyAURnKuaE9SRBD+b1F1II+tBTwhhTFA/Y/NT25tDrs1l8fP
	wr74PjQ3CC3fUhbBXW/RAssTaNXIdaBVfNnbMzH//R1Nipyizji2F2rWG+G3n3BO
	EEyIB93Pq6p3bQaH59n9/GSt5oa4YKFHRXRcs+w6E6lCHYSNKaEL30qhjSXxu52t
	n+KQ55pcGJEso/dVwEtFVMEFGpgOHf6E7XLjwM1n+PbllnMytw2GTsDpNUqHCOEb
	Zur/mgvXfuXsUa1xxvZIQ==
X-ME-Sender: <xms:puCYaVvDpi_Kb_ZwLxbZW54ywy1utr1qrniRLL_cTUq488rjiJ9ENg>
    <xme:puCYaSIx2hYIACY80yqj6b-DERvZawVN4f7J2eaNaDOd0hW80-Gz-GkO6Vs1mJtoH
    qMVU6Vv8_wwW44d85rdon52fDNAAJ8XKx75UJSM0rq0-tAqGIcx4g>
X-ME-Received: <xmr:puCYaSnSJtMv97hgf_GelEqe2TnLX3Yz2zb_N4marN_qnpbd3XmfK2Y12C0yJqsyPvQfS_MUr-n6rvgcFdrLZeYVqMu3jip63A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdelieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvg
    eskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehtohhrvhgrlhgusheslhhi
    nhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:puCYaTLBEfgaqZIkopdeFv7_DdojaLVtkiSLUnJzgNUfNVqKxf1bLg>
    <xmx:puCYaX79r28pKTUQWRrCAgtY90sai1qKZmr4GqqWndFcNWqCcTTs9g>
    <xmx:puCYaX1BBi8BEYNrRqXhuKpmgdDOjWslwxTFqsZhttpFicy6DMvUFQ>
    <xmx:puCYademxHeW1Q5HwhgBcsRyILR9QJcJYFpaq0ebsdtDXXCZ8lktUw>
    <xmx:puCYaWIjaHHmCAdQQBE7xtMWVVe9i_lojuDo-njhY2plFZ1OVT8l9psc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 17:31:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Linus Torvalds <torvalds@linux-foundation.org>,  ben.knoble@gmail.com
Subject: Re: [PATCH v2 0/3] doc: patch-id: explain how to map efficiently
In-Reply-To: <V2_CV_doc_patch-id_4.371@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Sat, 14 Feb 2026
	12:55:40 +0100")
References: <CV_doc_patch-id_4.275@msgid.xyz>
	<V2_CV_doc_patch-id_4.371@msgid.xyz>
Date: Fri, 20 Feb 2026 14:31:01 -0800
Message-ID: <xmqq1pifvyhm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> This is the fourth patch series for git-patch-id(1). This one focuses on
> emphasizing how the command is an efficient patch ID–commit mapper and
> how to use the patch IDs to join commits in a script.
>
> § Changes in v2
>
> • Delete temporary files at the end of the script.
> • Consistent footnote style: https://lore.kernel.org/git/c70adde6-e3db-4a46-bb29-a19d7aba8c7e@app.fastmail.com/

The latest iteration of this series has seen no responses.  Is
everybody happy with them?

Thanks.
