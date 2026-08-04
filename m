Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388642BEFEF
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871943; cv=none; b=Cog1qqOPNiVYpFj2xLKw15GjM2B5zdIjQeJc+3cTn17FzNlNc7SNBY1VmtV8NFzMV0nNG9o9z/F395Su5ds3MkC+O6RnKg8mJGU2lLQarPx8w8UTSs6KqA7U0cpUXq+YDdJRPtTGXdm1tArVkwYZZK0i5TizM+XGMyVhNrZvhwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871943; c=relaxed/simple;
	bh=+YwWtlBTAL5UYbDL05loiRqI620jTyZS9MUJDe1VSnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XC73EDzV3zzJAgr59ATOsbpQOnubUBIVq0b91fvhLD3UlPXO2FoVgLqGuDzujJ4is3f9GAFXA8w1cGgoDF3ga9OxyukbhOvcGaMcUAg6jaIhXf5qGo1BknrwAKkyZ/1q3cyZB54hTZnCRw6uX+4DJ729QkDq7Op1rRxD4pbem2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RuL/zSoU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CflROHDy; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RuL/zSoU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CflROHDy"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9B92EEC010E;
	Tue,  4 Aug 2026 15:32:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 04 Aug 2026 15:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785871940; x=1785958340; bh=bsTZxCdXtV
	fS9FbFzpjY/aUd7S0YhcknHNCEZeBd+KA=; b=RuL/zSoUgIkpvDyLxMFp1g0jMi
	MvIGNVVBuzRJMzT79GUQESnEn2rqVuwPTtSHY1ZoWjn4hewY5TqT0bsIo8cOOsmr
	5rPIuV2oN+qCka1WgScSST9GZatlve89MY9PilTzN1MsO7ZNb3PWhbDuMaKs2wdj
	PKA4xrCA/9005DuDAzy4QCqECr5UlS8cXTCYoiTocLMr0PZZYlkF14466/or0za3
	8nC1bwLTuLUV68mQQkV9bnxJcV8eW03bI8JzRzgEYRblfVO9GJnIRhsGuQbzmj9V
	/UYq/Bs4zNSgcH6fo+RR56KNtTzjjSGAQ60qL2mzg6grcTooH672us/GcnyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785871940; x=1785958340; bh=bsTZxCdXtVfS9FbFzpjY/aUd7S0YhcknHNC
	EZeBd+KA=; b=CflROHDy5JgfRqerkjlNAmWgH8ybcFk2/UrsCRzO4LsckVFImgW
	P/ZqmuEMdUGoi9Sf5E9F5pA2EMUDHo9vGNOB7uhu9tl1kqeOpf9kL5TA5V/Ic9Nc
	56zTFHZWlmxzK+AkzPDDl0gog9OpDEmcwqmb2ppSEBTTEuWwKiJBp8elupCKep5B
	2ixbzQ/Nd+QHc3CJHakwmuPK5FCXoJoKBcOs0WvetJM9Bjlwib5KuCiI8bibZV2x
	RuhCfndrNkSupQ77xBh9NZTP8JOx3XFmbYg9lsoM8ZQDPrYe2VvZMQq433Fng7kR
	wJa/Ykz9il5XKpS9XgGTC81+xy5w0bMkeaw==
X-ME-Sender: <xms:RD5yaob9c5KNOYE8UDw6nKiC8rKdTrBUMOvfV8gLxn388twsHzahOg>
    <xme:RD5yaq1Ngy4mj-EW9m3DpYr1gMFvUfb6yz6oaGoCJqlZrPUTSplozc63-7Idw27vI
    DdN8BcLDNAn0KmLnJDxKFxnsziRMMtAJuL6oTGqxLwbwjZWDJoiWdc>
X-ME-Received: <xmr:RD5yagWJq5usVvfW5B-0dh9AnykVCk_l4nWixfTHrd2faxLjHi6Ji0hOu2Wgd7pcRP8d1HuNdNsYRokv3RNuQNw5vFT1QZupjQ>
X-ME-Proxy-Cause: dmFkZTGWx3L+VWg50XuETqdnhyW/nZ8Cmw/DDUGCx5bsJcezAdOAm58nxJAiIhvaDNvzGb
    OJxntZqkLN0bvdfJvAgL0YcoPeqUipz/6j+lMMdQ0nUsFhsl/koCUkgL5U+dRvV2GiwDdR
    2owzsAd4cIT52p1yyO8zw8yLzmPzKbnAj5Of3NHbdLZgkyFrfSwwwzSDafxq3iusi5bZQA
    UyVFfk06hJnqY90K89Lu1Bji0cPA7XLDQlFw8GNPLySBCE4C3ooeOU0+WyhLvD79ZbuHzY
    wUqLIkacbUrMH4EgdwmL7ItXOutLC+6ECvaesRAtpwNh20EsRT8YXBSmAOnQ2OM+dUQuJG
    czwkVAYGVxA8xwYbQe47TKjQ68dpfBxXYddf8OHhIyXJxYH3LVzx3KqUHmhzdLK8KglXOV
    biuVVu0a4A+P3VEOWTMct8ceBKWMOC53fSn1BiBr3+2IR0aSej63RB0qZZlFURaO1XcK+w
    v5GkX1u63dYRACxcin/vabyx0ejmYsPY15M6+/9r49bdH573BTVIzeqddjT/Ws2PZPYcXH
    HWQ89foqP/J47JYPFGu23romgycg0nBKfDXfMBViERufnk8ssVj4GWTD8ek9ZhSoOnRsZ0
    frCMsdd/3go12ByJDtTshuOqiJXz7FAuOu6W7KRkCFZJBde92rj4ylbotZyw
X-ME-Proxy: <xmx:RD5yasVYivTEQ-4aZgvPnMm0UcW3x0XI7Au6fstzscEm9KAqHnbOvw>
    <xmx:RD5yandFpoClneCSVhVrcUVHOZeVDN0jmwHP8HgwF0-MSnEHgzQbKA>
    <xmx:RD5yatX-eW_Ze-iHitEE8byfhor7l5zSUx1iPYGcEPse54ke_qQ7YA>
    <xmx:RD5yaofoEyJHTZPBchYOrU8rf_gu_Q5YIw7vTIAdBkZItUa2GZl-AQ>
    <xmx:RD5yaoA-JmCaiy3RtSMDHAZ7YLGHrFQ4tGBc3Y7a80GPP-MkrHub6Uoc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 15:32:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] hex: allow only lowercase object IDs in
 breaking changes mode
In-Reply-To: <am_AL9dymrkidizF@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Sun, 2 Aug 2026 22:09:52 +0000")
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
	<20260729233215.398654-7-sandals@crustytoothpaste.net>
	<xmqqv79vha69.fsf@gitster.g>
	<am_AL9dymrkidizF@fruit.crustytoothpaste.net>
Date: Tue, 04 Aug 2026 12:32:18 -0700
Message-ID: <xmqqldalvfzx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Postel's Law was a great idea on the early Internet, but it is
> unfortunately no longer a good idea.  The problem is that being liberal
> in what you accept these days usually has security implications.

I am afraid that is debatable, though.

I would grant you that you can increase the attack surface by being
carelessly liberal.  Recall my example of allowing mixed-case names
for loose object files and storing them verbatim on a case-sensitive
filesystem without normalizing the names; that is an example of
being carelessly liberal.

But is it a good excuse to give up being careful, declare it is
impossible to be careful enough, and punt?

Will queue, but I invite others to chime in.  My practical side says
we should just take the series as it is much less work for us to
declare that any incompatibility fallout is the problem of other
people who have reimplementations of Git, but my more principled
side feels dirty, just for saying this ;-).

Thanks.

