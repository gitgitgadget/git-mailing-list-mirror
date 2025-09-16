Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1F0316905
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039886; cv=none; b=Y2DazsZi28jAvYBBLG5Fmpkt1Ke9PPk7VSFCq3QRUQXXLuRiAgdIejUEnN/w6IMUmEtYDc4NPIBNW21JtLHqokudoFdBGOMRNS8rs+YIS46vOFRoeRrfoabQBo9DeT1LISJPp+Lprt8m3xm3e43WVzZP8a7w6bjlS+nODSS1X0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039886; c=relaxed/simple;
	bh=Mnel2h2xlSaqsaQtXln1V43NrMshgszoSxmD6/mvZm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hV+IZDG+hApWPSnj/b4t5ggb2qgZjTTs+cCjM2h9zA/zBIEIepyWvUtTf7eJurOsXCoiFo9WRV4mIFMoeTV4OklJfij2PIMRhT/CWDF0suw7jtazdeLXS9+Tgcs9g7W1Gqv/Vr8I4k7YzGtiK+S3iZXQHriFaRFha/WCcuS851o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DvQFzx6b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YsZp+LA1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DvQFzx6b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YsZp+LA1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6902CEC01EF;
	Tue, 16 Sep 2025 12:24:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 16 Sep 2025 12:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758039883; x=1758126283; bh=ryhzDJ4J9L
	OsgScxzWjWXCYlCA2LkTqlDRJJ1YJJUAQ=; b=DvQFzx6buZddZHFSRt5M4A70jV
	RWmB4X6bgMCcdK9jRMXoVPaK4J0gCieq2td23HBz1yjg8BzhFYzY1hwCC2Q5l7sR
	PuRz/JF08yNztVhop0+dEt8r7Xg78vquh5NQBncFgJzzOwCOFyRhxa8JyrIZDi5c
	jhYU2Wl8q8SVM4FtHxhbB8WOvRDT6NuqPBVYxwKDgNkM9VH+nVrgW8EI9vGQCpAc
	hpFR3dsRFd2/edxdIN7aAKZk0rseWer6IzlqFTdHqKpwIMejBzaBiSXH1WFtnFys
	GF1UaUGZ1qcm0VoJ5hx4n+a7/uL1YxGkmoNWP2XnJy7QG/vNwDK4b6NBuelw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758039883; x=1758126283; bh=ryhzDJ4J9LOsgScxzWjWXCYlCA2LkTqlDRJ
	J1YJJUAQ=; b=YsZp+LA1Tn9UfAMKfmhZCALQDhjdk0jTG7ZbcS2i924ThnzQIV3
	aMdtvmP6M0RWVq07u5+3RWw9vOQwXVr+Qu0JWgJZY9O8l1xtxyyOPazo7B2ugiaV
	O2KAspLt+vH/FUEZ5xBZBnIyEIUyrcyyxvE3SZhMOnmP3mJIQMstw8H7u91ZmRio
	n+0c1D2b/zhJHTcygxek7EATmULnE6UlimZCS2PajoQFdohThfqMqupF/9ZO6T0v
	7wQdv/lnOJhHASTK58GfiS187cTCj+mKR90vaUSILvQg7a0eVLOYvwCcGQhDp4J3
	K9f6ZyYk4JEqWCeKHeLILKqCP11PscRTt5w==
X-ME-Sender: <xms:S4_JaLRJp8HdpTteX1qNbwTfHe5MhWznSsb61WkCM4XI8IPFnCrW5w>
    <xme:S4_JaHUnTDhOseTxy47RtDFXzA3FE2DVlmpSW-hyfFjIVuVxxKgVxnPCCSB8sVMr2
    eljE7TjY5NyytPfMQ>
X-ME-Received: <xmr:S4_JaNb42xIHr9w6DafphYKivpyH4eifHcU53UE5DIacVXpbsYOi4C4CHL-8E4RlTkfXFxnY_qp87Or8D-P_ib83AU9ll26RJOtY0vA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:S4_JaN1swk_tt-pAta_xvQcydsVNpwS8wqWjznF0LrK3s90B1BavNA>
    <xmx:S4_JaPg16fMgstUwdKyf-01eFTYB4mIsagHabH_ausgRWiu2ADbJ5g>
    <xmx:S4_JaBbeU7kjNf5dybtFu6A70NV6vvxgWRKTn_cTCR1qlpRz_hh26w>
    <xmx:S4_JaPQ5si1b7KO8oDR4ceoHRSKGzeQhxiEM-oa_YE2VuccwbJkwrw>
    <xmx:S4_JaHMJY0XFzC4syq-Z111BT8ivCzt3NOs75t1VseDhr3onWWJTxTvd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 12:24:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/3] ci: don't compile whole project when testing docs
 with Meson
In-Reply-To: <aMkGluKUBfq6VNOQ@pks.im> (Patrick Steinhardt's message of "Tue,
	16 Sep 2025 08:41:26 +0200")
References: <20250911-b4-pks-meson-docs-target-v1-0-a92c666ecef9@pks.im>
	<xmqqwm64orc1.fsf@gitster.g> <aMeshpRtFWyE0ja4@pks.im>
	<xmqqcy7re2df.fsf@gitster.g> <aMkGluKUBfq6VNOQ@pks.im>
Date: Tue, 16 Sep 2025 09:24:41 -0700
Message-ID: <xmqqqzw6nz5i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I meant the Meson option `-Ddocs=man,html`. I feel it's more natural
> there if the accompanying target is also called "docs" there.

Ahh.  OK, so if I said "meson -Ddocs=" to choose neither format,
that would essentially be the same as "do build the binaries but not
the docs"?

I guess that is from the very beginning 904339ed (Introduce support
for the Meson build system, 2024-12-06) that get_option('docs') is
part of the build system, so it *is* way too late to fix it now.

> Another option is that we could also just have both. In that case users
> of the Makefile could continue to use the "doc" target with Meson, as
> they are used to. And users that are used to Meson can use the "docs"
> target.

Meaning you'd allow one to be an alias for the other?  I am not sure
if it is worth it for something small like this.  Let's leave things
as they are.

Thanks.
