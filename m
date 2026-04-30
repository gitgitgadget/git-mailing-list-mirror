Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6275B23ED6F
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777541360; cv=none; b=RkCg224N2IM8Abfv+j2gFIp2G51yc8uQq061Xgs2B6gS5LbaOwxbhm6guQmML813thUeOzT4fgkrnliXz41lppu0cBNmQFyU3SgN3mUA71iaJWL7/5lLmsFNlU2cNpbSWoeNBxRHi8IgH26QwV6NwMkSeN1gB7eNGe2yC7duSio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777541360; c=relaxed/simple;
	bh=x3JQeai0h5o8rGKpiuiaLG91RzSvWOVBhxUm7EY1F7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u6R6lqjYbrB4RB1spEuj9UWD5mCM6NpxfZtc/X+5ILPlXX+wgQtyaWM6Wm2f3YLQs1SCKtlmJkZaF1/OE4EAUrD43PEsL5LmTiFYLn3RV01GY0TSlRXrOidyOh4+JGMd24Tz5IsM3UndxtRKnxaJMW3HLhGl+Dh5gKPfyqfqPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PmCsFFjB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=be+FaWUN; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PmCsFFjB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="be+FaWUN"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6474D14000E5;
	Thu, 30 Apr 2026 05:29:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 30 Apr 2026 05:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777541357; x=1777627757; bh=PmQoUudqpm
	6eMa7gG/os5RyxCbCIYL7k84knKGXwkxM=; b=PmCsFFjB8u+R0eC0pTrG0cCzKS
	gqkgHnmrW7vXAfnwP6GX4DZ1SENc4fqTMtE5u7mjdUTGZcMEyRpDGAOJjcAV0Nd4
	RGS98wfei8xoTRQBB4bXXXZar9IkH07hMq7ImK3zBgpsJ/fBcZObkEUFeKz11yUT
	QpiBA4qgp51nYSAa38ON+qux5d1UhKe53rYhLZ7RGMRfVVjRnJLe2GWKOg30Yn0e
	Z+6Apbj15YepsbYp9wVr3GzI3WfBG7exxw2O+i+9NR4FkawJyYfrwY5VgsRZquU0
	tZHvt2cwgJQBF1sAarsvdCt2hzJAAGHUJXMiBms1pdCWgeXvW7oVkKJP5XIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777541357; x=1777627757; bh=PmQoUudqpm6eMa7gG/os5RyxCbCIYL7k84k
	nKGXwkxM=; b=be+FaWUNHO02dAGK+6W1izs1IKwJN7LvC4B1rdKGHFwxLyVIOxQ
	7ZYeOVUbIT3mNl//lUk8eAlRKd/PBwzUxL6RNkq1AlyHCVAT0beXyxESswjSzTGs
	Osqgb06tQQp7TS7b1oQx7by5TefLQRL1g31tqq9Fl+18W3IaFK7DFFxmK5hBhbuN
	c16MCN+OExQSX/uoxdjmq1SLAG0d/fq3syOI7a5A4wOdaWqAX6IYhkJchTHYEqNI
	Tt9VTFAJRCtfC8hvmtWU3QWrbXCGMzyX3qRM+CUiayL0gVf+ObGJEW6pikag5a+M
	5KbfxLzlYne0MeN4HU3J1+hvZZru3WB4CmQ==
X-ME-Sender: <xms:7SDzaXg6Ufhg7dn_PPxwBubjFcKuh-0oKCyKEKFi-1XZfFqyVLtVfg>
    <xme:7SDzabesj13kIn9CUcN9Zqgw8wAKbcLhsNM-5E2d9CD2sX3A7Oq7kMs46bvq3Dczd
    prSQh4GiBozedPusNVgDGCxf62MJJ1gGjl4l-E-8xKpGCkfkPnvIQ>
X-ME-Received: <xmr:7SDzaUf8igrEu_AeLy5de44APVmgIgon4g7yvrZNaGv4dcBAB-jeXyjqutr6LiwDtomJvvS3fuIkDiAT-lDdZyWQN6bs6bV0Sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekieeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegurghvihgujhhorhgurghnvghssehouhhtlhhoohhkrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7SDzad-3E2jlLyHuxgrMhBxClKBjoMewXagdDUR0Ev7uJYYCQQW3WA>
    <xmx:7SDzaYkfjVWWNc8C8R-3cA-MIBFHmXZM74gkyf-d5oL5lqv_OmZwFg>
    <xmx:7SDzaX8ESSJAwl1JMduNNZgkW5y7peGEch5fc-xHVB3i5TzTdYiz3w>
    <xmx:7SDzaekNCOiJOnGYA1AVtSk9LrNnExVt07l9Ugl14MN_4KuR_bkv5Q>
    <xmx:7SDzaTkfyb_Cpo6RsrA8ONAOVP78NOUHY1siOiJX66Zbe4_-LSuP9NxX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 05:29:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: David Jordanes <davidjordanes@outlook.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git interactive rebase does not allow editing commits at once
 anymore
In-Reply-To: <DB7PR03MB3881199B8D12CC7A981ADF0CA8352@DB7PR03MB3881.eurprd03.prod.outlook.com>
	(David Jordanes's message of "Thu, 30 Apr 2026 07:46:05 +0000")
References: <DB7PR03MB3881199B8D12CC7A981ADF0CA8352@DB7PR03MB3881.eurprd03.prod.outlook.com>
Date: Thu, 30 Apr 2026 18:29:15 +0900
Message-ID: <xmqqo6j0zthw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Jordanes <davidjordanes@outlook.com> writes:

> Git version: git version 2.53.0.windows.2
> OS: Windows 11

I do not do Windows, but I am curious about "anymore" part of your
message title.  Are you reporting a regression?
