Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAA42A1BB
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 03:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060801; cv=none; b=INc8CP3C/Y0NKuYpq5GCtsRF/vwPubzox+nITxDms4Yvvd/hUSiDKTwpmSP4rIBNus4QZycouw/5bCnnOcyXzHxM4i7vOE752SFWdsIobqrjqW3gozvAXn4guiyE4c07Ehf3RC4mJZmExF6KE9YrJxILDGUyTcl1YM8+wM4SGq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060801; c=relaxed/simple;
	bh=cl8RYITq/ONHr34+1SY6600nTknHHbeqece9fmEQApU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MW9iRmuAabdclSsVUYp+RLHNXuieF21w+21HMlSKKHNMmUEm5lJMa1qnQy5xE+3K17UTZLi0h80WP17Qd8fQlJhlc9JWEl5bxg0HNn5QU5t68VLilg0tinrZyZptapqKeLs5z8wFFxZYEk30wZ0qzbpGvWycW0IYSGDNsOv0/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T/VSWhNl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KbWXZKbh; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T/VSWhNl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KbWXZKbh"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 4893F114013F;
	Thu, 12 Dec 2024 22:33:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 12 Dec 2024 22:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734060798; x=1734147198; bh=cl8RYITq/O
	NHr34+1SY6600nTknHHbeqece9fmEQApU=; b=T/VSWhNlL9Wckje3h8B1IMkkGr
	nW8Zd3BXgwQUs/P4TfquCyCNKiCc0gPXompH//LxL9AJ/1htWB3+SUOPHIfiZrPe
	ErJ6Yw3XhbhoCmSOwy0LtUGPvoQnTrtbdtsiUIG/KvIMnIoUpChvk78YuPwWslR1
	xXaRnk4fF9GjitedZyNw7dmxCGSAXfQDUyVdesrQEZg5Zyb4GYMhQZXz8EqZt2qU
	y2uvhZl2VfdvcGu0hFxH9QIM+xIqHrALZwg+1WdlTn0jVcpmlLq0w/HwXL7kdI0T
	ID7yGkuWxLo9jj7OuOBIHcZos3HsgNHWqsE48P7vY6Nw0S9LpPuh9u8bXVBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734060798; x=1734147198; bh=cl8RYITq/ONHr34+1SY6600nTknHHbeqece
	9fmEQApU=; b=KbWXZKbhZXytcLrZzClqGoNoKyUYVz/HNkA78Hu13smNKSoGGaH
	QQ15hFbwgjelF7VvGaRq8xXvsEhEZ1QIOpBRtwoROFaj1FXrnn3pO0/3W95Nppnu
	dYbXA7V28H5HIfLImUoYGrApo7u6QQWPmy80qcGrarhNRDNjGYMEobEx1u2qbW2b
	h9+5MS8u0QomBEn31PcyG/Tug5knLVXGxwT/IY7FfDGy7YvG0rxD/bsrP6modiMD
	qGDv2JgX8apJp6JiF8yklOPsX2AWsMBiuCXOeCCXVRMWuzrcVXEbncAZzRQo0lhl
	wOc1ahINopWGeD65v8Kvmi7HiMGjGdHYaww==
X-ME-Sender: <xms:_apbZ7luXUa5Xw2BH9TGex-F-61oTjT6__op9AmtkKo7tEa6tzuvag>
    <xme:_apbZ-12xK_0Y3U7L-0lRlJCWaMjKSyUTZhgyBiJXC1H6IVl7jgAfJFRk541bjsmB
    z1C3jceHJqon2-Tlg>
X-ME-Received: <xmr:_apbZxrpW3l2s2syQKPZXnkVXXORZ-K5iSOh6Es1RwPo-WjeL4C0rN9NZ0iF4lxvhrv4QmqTuZBa_vONCfcmD94OfQSfOSA8eOqkLd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_apbZzkIa_TNiGXA5JLnFO37AahnuniDskGKCpINOhCP2PApMYy-Tw>
    <xmx:_apbZ516xXleGvNzBE8_fKlrqnguqtzjNl1bl1oJh5c5OFQ8k-EsUw>
    <xmx:_apbZyvf4PQwzYHjutoUcEY4Sr5hajnhmNRkt3JtEq6pq0MuK_M-sQ>
    <xmx:_apbZ9U4gcTikkT38EkR7bu2GNTGRP_7ucCqTJSlZqwNtvtlywbl3Q>
    <xmx:_qpbZ0Qtr20aQXgAxVoU_qSQwi_NT4U8WdSctFDnsl_APF0PGRUTUspI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 22:33:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3] bundle: remove unneeded code
In-Reply-To: <CAOLa=ZRKZPWBV2HiVEvt5jm4SCQV_G0k9V0eoHkdnnoUsXGaUA@mail.gmail.com>
	(karthik nayak's message of "Thu, 12 Dec 2024 02:11:17 -0800")
References: <20241211-fix-bundle-create-race-v2-1-6a18bd07edec@iotcl.com>
	<20241211-fix-bundle-create-race-v3-1-0587f6f9db1b@iotcl.com>
	<CAOLa=ZRKZPWBV2HiVEvt5jm4SCQV_G0k9V0eoHkdnnoUsXGaUA@mail.gmail.com>
Date: Fri, 13 Dec 2024 12:33:15 +0900
Message-ID: <xmqqzfl0dzpg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

karthik nayak <karthik.188@gmail.com> writes:

> Had a look at v2 and now v3. So they were annotated tags all along,
> perfect then. Thanks for the changes, they look good to me.

Yup, thanks for a review, Karthik, and thanks for writing it, Toon.

