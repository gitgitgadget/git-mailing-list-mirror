Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F663E316C
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974055; cv=none; b=uoPlDSJu3N8M2LsN757Onvt90XW1MKWF+L4zuera4OeZO4mesFem/XZTUhtYnjRrtujg73qqZR1Yv5IUqqgOfS3arfW+KqK7ngQTDRNmlNTTsWHD0qzD8QNSlDTPO3h4fo7Z2hrshs+Y1sIkPF/zG+bzRN3Oi0K08/9PV4eFH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974055; c=relaxed/simple;
	bh=Yq8daiNWbMMsZxVrTLF9W/55EAdHBHHG46YEMLjGy0A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bcZfWjMiXAipNfNQSbUH3fpfsOts0lJsGCSyYvW1l27M7l33UHtdF4yUFfauevzw3+av/DVl0prgTNHqCWrjP0y+RGy9G1zqXtXTNugzWMtq+04tiZwED96WQOtQ8CvaxPdPj9a96lCW1FIoY6K4DCHXD6ljwt16WI81Wn+pgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p90+u1SE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=APbZs1XC; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p90+u1SE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="APbZs1XC"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 76F2E140011C;
	Tue, 31 Mar 2026 12:20:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 12:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774974053; x=1775060453; bh=mvklWAf4I3
	x1Cqu+9oX8ptGWeb12t2uB6qCV1dr6Dp4=; b=p90+u1SEsKYAZ9c6SLjUuPqqBD
	jbp6xGXAiZkcfz4WxDwjrRb5T3VVse91b7GdO01hifgN5TqQdV2Nbb0Q9BtoVKvu
	OyebSuHbwKUKGlbFldwpim1nvYXz9ey/W96w5DcKs2jNRYoeauSVp0Y2srpps+IJ
	JpmyHURfMLNkqcg785CaJ3ef4IldJJcDhtGeIL5HLap3jGJ4Zky+V11nMCLbBEjl
	KNXaDS6teFwePWiM/MBeaMKW76E+I6d2TwT1r4CKdScSY15yzXKeCu7eQOwSWu8B
	EpWxYdsPNrGntyICcB0/Xt2Tw2k4aI7MEtcfH+noLKlG2g2A9OOTcZqsikCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774974053; x=1775060453; bh=mvklWAf4I3x1Cqu+9oX8ptGWeb12t2uB6qC
	V1dr6Dp4=; b=APbZs1XCn5L78nwkNAg99BBapXs+4fSagOrcjccl8rEvflgf6fh
	qtvOADmlcNQlxf48rUnMYbW4DtLH8OrHL9t2gC6Q+M8L0l5+sf76Egl5ZAl67Le9
	qJeq/eBlIcRfwWotfxjuxSE6MExKAnyuEMZThCg2YqP5/Z5YMQyY3ns2/2mcAdWF
	Re95Y0yRlv2nf4HjKvLAlZgWPQk4UEpqihKlTc+G3CKK9r3FY9JFEGqzR7KZlv+J
	EOLRtRoPtiFLBJAgUakadF/leqZ7ojArAh5MZYlcGnsIqcIRUkXfvHmWx/5xa8iY
	CL9QkWLmuuaO5dLA5U99jhyOMhGmDc+gfRg==
X-ME-Sender: <xms:ZfTLab0_yRHfsqCMeCGhnl8RCtbk2LqV2ycD--BzGEnywGHJ2rftVQ>
    <xme:ZfTLaQ_YXCVVD1p-MnV28FnJVNiruQiY_tvZJg4L7J758t7zZWd3m-VQ8F0Lsjf9B
    relga4F8GgHkimrgyIZRDUHpgj9Aou5J_pVWpGJBZGaK1y38EaPMA>
X-ME-Received: <xmr:ZfTLaUMLjCVvZzzAWUG3bF6Ojfcdw5qDfoF6KVKhaBTMOMnQ0zOTgqNzF_IZz2BHJnE997FN40-E6n9avPSwX5l7eUKWwkJEIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZfTLaccnJNBtoOYu0XQhHuobMmKRL2itHL0etW5B9Hh1y_xdo_zU9g>
    <xmx:ZfTLabV2q42wdvogkR9H4ZydJ06rrQG9yhtwjqT2Q9weBRLRtnZCgw>
    <xmx:ZfTLaciCgMcMa6j-KHmU7caEDdg6FFzdHswZjctTIYsMb_6bM8Tsuw>
    <xmx:ZfTLaS-n0L2zzNtdHA0ssvnMZ74SLmc6k-FAw-yPM5dayxzi9DCXJQ>
    <xmx:ZfTLac7LLKb4wpjy2rzLMFN2zqVEnIHz-dK-tczVqJB7hkslrw2wOPYm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 12:20:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2] replay: support replaying down from root commit
In-Reply-To: <CAP8UFD3P2Gs0J1FNyKW2URwSEW4ZaTrVO7cM1V8sG+zzXctbhg@mail.gmail.com>
	(Christian Couder's message of "Tue, 31 Mar 2026 12:34:19 +0200")
References: <20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com>
	<20260324-toon-replay-down-to-root-v2-1-34e723489f6e@iotcl.com>
	<xmqqtsu5xaw0.fsf@gitster.g>
	<CAP8UFD1zJXnsm7POK32GqEu4xSC+VO5mfzUpM-jn+Nr1qvzEFQ@mail.gmail.com>
	<87a4vv2ada.fsf@iotcl.com> <xmqqfr5lkyq8.fsf@gitster.g>
	<CAP8UFD3P2Gs0J1FNyKW2URwSEW4ZaTrVO7cM1V8sG+zzXctbhg@mail.gmail.com>
Date: Tue, 31 Mar 2026 09:20:51 -0700
Message-ID: <xmqq4ilw2cnw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> So if we are about to fix that main issue in a separate patch or
> series, and if we plan to emit something like the following in the
> regular case:
>
> "fatal: replaying failed due to conflict"
>
> and something like the following when replaying from a root commit:
>
> "fatal: replaying from root commit XXX failed due to conflict"
>
> then I think it would alleviate the need for a doc update.

Hmph, what would you do to the other side (i.e., replay from some
specified boundary) of the message?  When the version of "git
replay" command a user who sees for the first time comes with the
ability to replay from a root on day one, "from root commit" is not
so special from "from these boundary commits", so I am not sure if
it makes sense to have such a message that treats the down-to-root
case any specially.


