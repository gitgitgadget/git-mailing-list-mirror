Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7322F616D
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039546; cv=none; b=nWVFDoabuqZ6gkNmewAZvPTSjX9LME8uF3h4b8Bh+u2XRrdypoxQhTReLmkUV4U4iwHGsEOAhX047xBFpdr7ZRFHX6fwAXx9GSFgP0Q1SImceDSQAXE+1WZN6NVX+Tp/MSl8ZATlETS+Ziq8ahBKSyjr11+SG0dyPxsOTtY8p1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039546; c=relaxed/simple;
	bh=VmMwPl5FucQk0NqBFnbXGv4XZkgPUceuUFAfTIk7xzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NdMCC/XHHMRvO7c7Nb79LMoD2r4fn63KdjfVpk78vklbRjLdRN1S9InCbeiIYhiRCf2hn0iNJc68YW0MdK1FQYqHUinIlEFpOIr30jAufm8UhQuWyw32TUAJ9jXe7S5EQijoGJhhE2rqth2GFBeRdavhUdfyXPGC+BJPZ4ozm44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=z9HDj9B+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=brkcLcta; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="z9HDj9B+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="brkcLcta"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E19A1400149;
	Tue, 16 Sep 2025 12:19:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 16 Sep 2025 12:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758039544; x=1758125944; bh=jOvdmDi1hG
	5f9Poo1C1G9sA8Wy3Way1MqqAkq74iptU=; b=z9HDj9B+rPMTsIk30hfgc9ubu9
	KX3moTzBIuQA+npswYWWjPXFb+dDVCdtTBocfrUzGZ6pC5r24wVzsRcW6vZI0AQC
	E+XAhY7DK0xdEUocyZAZxSFxAuy0gP2II5cD3CqAvquJYiqckCly6OdtD7TG65Jt
	aTFjyAlVn9B/2wSAycFiOqCle9hu3ZXiujsm+ycsTDJBS18/q7khOSS/vZt5+0nx
	Uspq4H2FLVstd6UpUuvxb4xlDfg2fo5p6MZ9dtm+9eGPYPo9UJOPVV8qQ3bjcvCx
	6mLDKS+7gfSlrQnRI/5FsbIAZtbLtwrF4n4oZtlr7nx8qzr5+aZMaULax/TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758039544; x=1758125944; bh=jOvdmDi1hG5f9Poo1C1G9sA8Wy3Way1MqqA
	kq74iptU=; b=brkcLctaYN7CvT1OBVVWKPP8IIJWcY3Bv59P2mE+mRTXD0yyuZn
	HMGgxmHs245Q5rZRPpUtIvT8Z28+8PpvdKOugO1z4RDpWKZaQ0I32IbPnre48/KD
	g7HyUzNsXpxJc2SCX4hb5ukQfgdqfkcDbDPKW7tgkreNJ+LMAIc1301fh3W9FQ1Q
	/QVBhxYelgs2tknNYPHRIgE2YW5JK1XO9lkFdvvuuw6B81kMk2nof6NUWj7jVsOd
	kWjNSaFkCLlVFOR/zEWrVEA02wOuNLlVyFp85/e8bEXvJgHlDLHm+uIIllhHKzaY
	o+8NbNEPZtssUkzvgS+kOEgLRrVUc56BZuQ==
X-ME-Sender: <xms:-I3JaAdA3qxU8nFxKR2VFuoe_He9j4r89Et1IxwufSx3-EZA1O6RWw>
    <xme:-I3JaNsfrgOSXSOzD9Tx97KEEFwU6RkwjTDPIe0rcGlF0gsfNLNbsnrb8NKALTPvS
    _Io5IlW05LDwS5LmA>
X-ME-Received: <xmr:-I3JaH98R89jNLMzBCU3ldEiKjdVztJ-LzvqD2AmxyFVoH6uq3Ig-ssWz_w5nJUJEcn3OFbJT00bD7ceRw9BvQc46oNPzPCoh7rL99E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheplhhutggrsh
    hsvghikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-I3JaA3Zc5fcok5SxZAs1GQJRMDXaGhsLojqpf_TnLZq95cA3eYKOw>
    <xmx:-I3JaEByTfOPncrqMvbdu-dQ52ybQV85O1UqtB3iyjoHQ2kOVd1pOw>
    <xmx:-I3JaEdt2FV2w-nU191jbhcRglXoRQ7wOZouiUatuYXoxJLmFeqBvQ>
    <xmx:-I3JaJ6SOUbj2qGxFhClDLsFi9PcaaVT08_x5CiR5vbUGYFG93_r1w>
    <xmx:-I3JaMMMenFA6-QHxc-TnW62yrpcU9RSAPT8xoma1XwE5Fsl_57svRmf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 12:19:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  karthik.188@gmail.com
Subject: Re: [PATCH] repo: add --all to git-repo-info
In-Reply-To: <aMkaePi90Q6sXuO4@pks.im> (Patrick Steinhardt's message of "Tue,
	16 Sep 2025 10:06:16 +0200")
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
	<aMkaePi90Q6sXuO4@pks.im>
Date: Tue, 16 Sep 2025 09:19:02 -0700
Message-ID: <xmqqv7linzex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> One thing I wonder is whether we actually need the "--all" flag in the
> first place. Right now, when saying `git repo info` without any further
> arguments, then the user will be met with complete silence. I don't
> really think that this is useful as a default in any way, as it makes it
> very difficult for the user to figure out what kind of information
> exists in the first place.

If we were talking about interactive tool, I might agree, but for a
tool for scriptors,

    tool "$@"

should not silently turn into

    tool --all

when $# == 0.  That is asking for surprises.

