Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5BD3002B9
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742401; cv=none; b=NGyL3HilK/gJOjt3dFeW7c9Z1eL887hIMNRRlcyHdD+gK9Thliyo5tHAb5sx5/RQCZVN/sq3EMc3+DVbp8rg7XkOpHtn6BN4aqQYOJJylp4mDzhSknEQLYvndW+F+N6BBxR6ntMZCBPomqaTogyevgZQwEO8K/Joddd7or7d9ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742401; c=relaxed/simple;
	bh=WasoWJU0DTO+dxu0w7Tu0jjnTHAWixaySpJ+4EEA+As=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iJT1upWo0YNe+iMH3IucOe9JGxx2gKzbzsc+NSQvWMd0cgLQ0VrV4Soeasb37XB1KHPLaqLUFMC47LtqBFapfRxYelD+3TKMvkf3ojxShMiMnxYKv9dsbMEzA3GuxRZzj4PYG1NUVx6aDqgVaGiX9zegsxc59L9KkJ1msA7FmY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vq7nk1uO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UG+EdOn+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vq7nk1uO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UG+EdOn+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9299D1400226;
	Thu,  9 Apr 2026 09:46:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 09 Apr 2026 09:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775742392; x=1775828792; bh=EpsLQwoV/X
	BYmsoRJONZ/fNEut9xabz2qXEKy25NG7Q=; b=Vq7nk1uOGzE9Gu9rkDBm6geAvi
	1rWUfyJZTtUxLQ9jCsc62jUTC2cOhEmjXYZFUAznCysP+Inv8cqt/dB3pg5RMt3F
	3FqgxXGkI0rbuddNXvN+JEWxfaFlHumfuLLZRWVpiW2lT0QMQ30G/IH+MnPqsQMO
	4MjfKd5TgFzTTllgde39+WidgC5ik3rb8XuIo0QeqGkZQkoFdh+sKlwq/l2JJjyI
	n2Y5LCLcsJZjG4s81XNR5sTPYriyhvi4jYmeGgwU0iTJDpUg8lEOIZgbtajJbvyK
	HxcmgKRqk1QUE3irUt6kRD/VZrIRYpbzJZREob3mTqZVubKeCn9Cvg8youYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775742392; x=1775828792; bh=EpsLQwoV/XBYmsoRJONZ/fNEut9xabz2qXE
	Ky25NG7Q=; b=UG+EdOn+ENkSOqGguNKukTQkaCJeNdiF8+SS1f2V1Rl9BCQMnjn
	CUu9JwZ8FLoeYg4iaKAlhPtvDIWibdiODaqwBipDYJY9PHm9SVg76F3VwFqFKNTz
	ajxuYsdu0g7XvFAs1QPW5e34ieri5SZtE0+PahFGwnk4/qAI3PDnsaK3hOZmPVKo
	fuRskgx04rUH48VWFP5PjqXTEf+2ujBPF0g3/gXPnr+SmGFw7kF0cjpP3kyNcBnB
	yUSsvaaKwXKUfFkKJb2UdkqoHcCcZZaYoGKNgqTxZ5FiOczmvaCCsl0lidLlj32K
	0qNmO4zW0NzMgmsW66I/tgCYpFDedAtdoBA==
X-ME-Sender: <xms:uK3XaV8gGSvUB42JIuH450XZ5W_oNEo0NzkNk9Q72NEje_9UlJNxMw>
    <xme:uK3XaRIaLthDUwKIGtWxsuSSOVaTC7x6cZEXBH5S1Bd_1ft5spDwr5iHFTsNzZftI
    XiPIfleam9wCKBW9GURtP1Sz22Dn78vv-zQJO_wiw2SqCOoCR6a2w>
X-ME-Received: <xmr:uK3XaQZOI1BVEvvC_BhSy8rR6YTsz8Dd1MZOnUoJ5gvQU2Ujxkn1qsnmVmMHKqJ43Ait3dMU3ZL-VfAWwMueHxoZMUvrPibCkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvieeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:uK3XaTIgdOEZxScwzqK-58QUHbE845Fhk0ChRCdgNUH-GcaI0LABAA>
    <xmx:uK3XaeAc2MesK-nNk5LEzhkOZLRlmVHxJNfWBULKcxaghTGT_Hk-3w>
    <xmx:uK3XaYoMBypFIAFk5tqsCvxqQqIHH8x_2EY8li5JXB5P-9EN0LHVTw>
    <xmx:uK3XaZhcT-ODfZtm95C0ZJ0_52Vjt4_gJZ9Gc0Sw49SsdXb1h_2ziQ>
    <xmx:uK3XaRT5KYRkltdSpRxosVkI17qq7yy_BMZ-BrsRt-TjZ28vGayNNAOl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 09:46:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/16] odb: introduce "inmemory" source
In-Reply-To: <adc3mAItBiKMUFNJ@pks.im> (Patrick Steinhardt's message of "Thu,
	9 Apr 2026 07:22:32 +0200")
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
	<xmqqa4vknjab.fsf@gitster.g> <adYQPmnajLmVr-vh@pks.im>
	<xmqq5x61xgvv.fsf@gitster.g> <adc3mAItBiKMUFNJ@pks.im>
Date: Thu, 09 Apr 2026 06:46:30 -0700
Message-ID: <xmqqjyugw8jt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> But stepping back a bit, does this new "in memory" refer to a
>> concept that is different from what the rest of the system uses "in
>> core" to represent?
>
> No, in principle it's not any different. One of the reasons I decided to
> go with "in memory" though is that this backend may eventually be
> (power-)user-facing via the planned "objectStorage" extension.

Doesn't 

    git grep -E -e 'in[- ]?core' -- ':!Documentation/RelNotes' ':!t'

give many hits that we want to be in line with in the codebase
anyway, and even in some user-facing things?  I just noticed an
option "--no-kept-objects=in-core" (which I didn't know about ;-).
