Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09DF149C51
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753306230; cv=none; b=EdK1dkx/CALIMAtiMqQAjp6ln70SJyap7XgQ1q/PQeaAK36idN9tGWi5vOdzzLtVTU0GqTd90SK7cCPt4Y2x8GOEjIzdjFPlO3vymLoAvNQ8UPhwi5+XsgoRCHMiPszMd5Hqfd4XAY8hH38h8B1NgI+He0MmJCkJi88joLdoifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753306230; c=relaxed/simple;
	bh=luw43P7XQdwKieBirUksT5t7k0NIJHea+2KyhSt1MuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XmQq0HucMlkxVpmAOanLIHZJebf0i28yaswL9heob3k8DfznDKWkJISS+yy+7qECV1mta2z1eYnXqZZySv6AOe9+8MP6hsD1UAd6Dvtcdb/Z4k5doslw06n/zyG7MZNllbUgfZRb6VCQ7JSS36/K1CWvIa+KI/sh/MN2KfYWTwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MNIvVWPT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=In1PLbc1; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MNIvVWPT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="In1PLbc1"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9A791401AAC;
	Wed, 23 Jul 2025 17:30:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 23 Jul 2025 17:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753306227; x=1753392627; bh=qXxSL3QZU5
	rJ0PFU9a2320W+pW5otyEEKrAnNBI0S6U=; b=MNIvVWPTb255/tRZfBagnIfPTm
	XJctE6Thjh4MY0cttcwassONpqVDuv/jhkaTAXM/gYNZn+gPFhVXAfwBy7RSncC+
	Kmm9QcxKtIsqtuY920kr7CvpdT4BxVzo4AvGZKuj7OULqizCEAQLhJU6+J1qE8OJ
	nLp2HcDVEHIZekw3DCsnRKNxHVQ29/usJeDiUi7fCR6HPOrkhzlisqOK0NN7AX7J
	EZAEMs1Is+Fxzy8RhxEK/fPo6lLuzrhj2WSaSFS9SiQqUnt9rkUhVC3PcDgJTsEC
	Q5RUeiS6C6hem6eNVM20Hash+v+drNLxSoAbAIVCOck3hkX5R3+FB3Gg1M3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753306227; x=1753392627; bh=qXxSL3QZU5rJ0PFU9a2320W+pW5otyEEKrA
	nNBI0S6U=; b=In1PLbc1YBjgXMN4ft703LwJIfxzYeVMUwj73vmyaLUgziOG/Vs
	MjU0xwYJWAidL1ztrveu/koW/MtIC83XlKZGfjWmlABmbg5QwqgSpRdRsq5vpcbr
	fJu5633Z7SnFBhadehofmXh3YRY7k531E47jzXBvLKATBe9fI9+Uy1qzAGfzRYsu
	4KJgAD+l9s3tvZIu66VEr0YFhfg0r0bL3yialyLGesuIOjuUEe6PIEoNJ1lee8dR
	EsmplHJXx1vL/eH1RECFYyPp/mn9j8k/+Wr7aZS/dXfFHRYqubx96ogWAbsajxpN
	ei/zNITgv4kt/+8JZw0TNNiyN3rmM0h7Alg==
X-ME-Sender: <xms:c1SBaMFHC8c01p4NNBeEp_3OylNeqCl8_Dqpo9mgdSaxAXR2PcvNEA>
    <xme:c1SBaCewRpvFFHIUro9MH8ks5xF9sq5GsB-ys3daeqnBULeUaiHN-3FMSSP8qjguF
    a1bEWa3a-Uesx_rWQ>
X-ME-Received: <xmr:c1SBaFJkTNkY-Wp_H1g9afQQjMwrPWlHh39pB2ujmVRA4nZGpZeM6n5wvcKtlXXNzaDRfjDj2i5tByo1dcqH-7F7FYN07U1owE5oWUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkuhhfohhrihhjihelkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:c1SBaPGqeRVDUxw4rDS4u0eD3B_WJHkMPnGAlue2c96EJIVYzX4oGw>
    <xmx:c1SBaACQ__93ILtTxXvGMPUsTSBwMAqROCmEL05FXmQheH3XVQtmyw>
    <xmx:c1SBaK-q86MAxApeE6G4ksxH5B6i8KpVslJ5zqxH57UR3FF2fmFnkA>
    <xmx:c1SBaEBWWrk9JWZVOUljpYdvuLvtg8baqV_6dj1TAhXVTXX9EP0geQ>
    <xmx:c1SBaGj5XxxTFyPi797Rk2zO92AumiMllZvyh10nyt8tFDEUo_G0fcnj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 17:30:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 00/10] t/unit-tests: convert unit-tests to use clar
In-Reply-To: <20250605140644.239199-1-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Thu, 5 Jun 2025 15:06:34 +0100")
References: <20250605140644.239199-1-kuforiji98@gmail.com>
Date: Wed, 23 Jul 2025 14:30:25 -0700
Message-ID: <xmqq5xfimw7i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> This patch series marks the final batch of our existing unit test files
> transitioned to the Clar testing framework. It covers all the
> reftable-related test files, and is part of our ongoing effort to
> standardize our testing framework to enhance its maintainability.
>
> Changes in v4:
>  - some code refactoring and cleanup based on review.

Nothing seems to have happened to the topic (other than one obvious
breakage pointed out on 06/10) and it has been more than a month and
a half.  What's the status of this topic?

Thanks.
