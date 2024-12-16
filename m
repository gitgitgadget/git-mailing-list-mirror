Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187C0202C50
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366776; cv=none; b=qMDTDQRRMTcTnw/Tq/nO0YfJVlU2x2fnIQFuNrZEbn3Lpsi4V+XFLynwlw92fSyD4sylRgIqUZOAd4jBQamoGY0zNPcj7aYTbUUGy9j8gtMTPuh4mdci0flpSR4PlmzBBFwcYsoWp9hijYVsqZ6DfXnkF51LrVKULEnJb1fJyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366776; c=relaxed/simple;
	bh=HuSsP9oa8msu4623br5E58HyMecZjQvRI+BElJHdXUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TTvJXU1d7LlSABS/RhoazQSB/UR42PsbmnDZ4sv3GidZ0cR7KzqNzhjQgtpN2bLeNKO447l2jPLlDhYIZOvUPF7u+9MOfSjzc7SPiUz2q50yweTCsDQRlNv12TNKXbPlBAnXb8JXrF28/GRVXI3ly2hlPzj0dF0SnB4qk7CgyuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k10HWejk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LYgiOxkc; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k10HWejk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LYgiOxkc"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F06F1140187;
	Mon, 16 Dec 2024 11:32:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 16 Dec 2024 11:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734366774; x=1734453174; bh=HuSsP9oa8m
	su4623br5E58HyMecZjQvRI+BElJHdXUk=; b=k10HWejkuL/b4+8ZYTAuiQVMVn
	Fr8DmA4M7fMludfaOKtbesEnrIPXB6zHqdq42Laz4yWe0rB5TLt8E0Z8vChgvg+0
	/jJ9LyyuE5TGPMkvIKLirxYQJNOqzmsjKRh81O8Ho/hBVBTxwuiYHlSxn3W9TV/i
	Hlrr8gRobD4Y1vDd4cYN7TdB2TIN6a67FTEocKVf1cLM7UGcN0QvzClLY/cv1/0U
	AhUKZgD73vV5MOivf3ow80S7xT5cdOxSbTIc8WwaPMllHN8O+WhKCwA3mNRvse8p
	zxquxsn1qeDgzKHS5VOJqsiobS/cZpcVG9ITKSU7vIWHPDCRPiPRu9VfujDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734366774; x=1734453174; bh=HuSsP9oa8msu4623br5E58HyMecZjQvRI+B
	ElJHdXUk=; b=LYgiOxkckx0NFGSRnEo48qZ6tm+OepTgGy9Dko0yLy0+B3o6qI/
	NrGimoNR8XnWgG0/9sxdNxyr9DujiUv4b1OG2VEj8I1p8alLd+pPwnAadARYR9bF
	EZyQ6DXxP/f85NJsJ+vD2Y+MZ9hIm9erb/xM1g/cO7+Wc45rdQ1MtPkqxrTohm8s
	D1dhlbmn2xKXPvZnixcb2hjCp9DIYrR99ddwqC13T1kf4kJ8KyrC2NG6F9XmzBSK
	LqrOC59XRrv1KT+gnlnFwJ4NBcvF2QnSXt8qqL06GSfGwnvumuWxdv6UyYtFcQva
	P3CSHjo1iqztxmpnfO07HQDl15XOWE7yh2g==
X-ME-Sender: <xms:NVZgZymAu8vmY-F1VUQEoLLhyomQwVP9zVLsAF_CPfN5SQioX8jaTQ>
    <xme:NVZgZ52DvC_MjdYb5XWFe3jbbBTlC-HWFRpeL2X9gTzVzLhu9-J92Og6Rni-XlDKw
    qt_mth5htJVxL-XhA>
X-ME-Received: <xmr:NVZgZwpwnyOwFaEI1bz4lYsBvkdeer0-_rCPuFAxSFGExLq_GqLzwjNot9Gi0ggA2EI81VcRae7u2Qsa0X7rLRtfy4R8OasBD8O63gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhishgtoh
    holhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:NVZgZ2kcp6Mtzi67EANfLVfr_a9vmlkrR7s8a0SF4iAHh0ZrBTfVYQ>
    <xmx:NVZgZw0zvUwt_RqTSoNSJ9oNo8SB57I8EraDUHTLwqAnd9Dj2-L0FA>
    <xmx:NVZgZ9sGT38w3s1P8SNW29ZKaIWljB7VuRssKigDlRzRGZy-J0F4aA>
    <xmx:NVZgZ8U-UOPLdzxVFkukAAR14asDLnDMDH9fVj0wDPIamF_C9j7BFQ>
    <xmx:NlZgZ08xoUIWk3CR07-88s-0DqBU86cEsB-Ejjfj8-xnvtRg5TcdY7y6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 11:32:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 0/8] refs: add reflog support to `git refs migrate`
In-Reply-To: <CAOLa=ZQHaGO+o=9vda0eA62K1kvdpi0yjm6adxEDhVhn4NFbpA@mail.gmail.com>
	(karthik nayak's message of "Mon, 16 Dec 2024 09:33:24 -0500")
References: <20241213-320-git-refs-migrate-reflogs-v2-0-f28312cdb6c0@gmail.com>
	<20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
	<xmqq34io8ptl.fsf@gitster.g>
	<CAOLa=ZQHaGO+o=9vda0eA62K1kvdpi0yjm6adxEDhVhn4NFbpA@mail.gmail.com>
Date: Mon, 16 Dec 2024 08:32:52 -0800
Message-ID: <xmqq1py77fm3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

karthik nayak <karthik.188@gmail.com> writes:

> Patrick posted a fix on the list [1] and also discovered one more while
> we were discussing off the list. I'll send in the next version with both
> of those included once I validate all the tests once more.

Thanks.
