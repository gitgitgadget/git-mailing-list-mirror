Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48940146A83
	for <git@vger.kernel.org>; Wed, 22 May 2024 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716406053; cv=none; b=btMsdw62dp6vG6Q5/RLeDH8bBzl4RjCJ0NemJBQ90nNbsxCkVUR3JdlcnC0Reiekc/CsDwKQP0F5u+ObD7dubCbKzAiOnXWFLujlqVltk0veX4m9dtEouJnjAjBScWHCWkQWOtbyQVpXMK3JTqSX2bC+E/Naj7qL0DnUVHcx2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716406053; c=relaxed/simple;
	bh=E7I216W1rk3PYMIPNAkKSyrC0kweumqmpjOaYFcxZFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M8y/kBROfiIopP5jTli3kCmPYaXkz0eYie6fZO3I65JjKSe2l0Xb9jAG0TWIHnRZAhYVTBpmjV4dWE2WztNQO1kkbB0EK0LuLDyg9kpL+yH15/pJD91wdgYSWAQI/w/ydSldtaFIvPAEiUUn1BQ1qREYQFSbrmKjhBlNRypIw5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pTuiabBA; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pTuiabBA"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D34A8195D4;
	Wed, 22 May 2024 15:27:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=E7I216W1rk3P
	YMIPNAkKSyrC0kweumqmpjOaYFcxZFQ=; b=pTuiabBAcpqZ6X8OM15GgkuJqlyD
	xvK1DFdaXqL9D02lN82ZQ5VgPLvPV7h1IlUA+IqoDGABY2Ts2Hvc8pIKYOIY++TK
	AkUBnvaLSifF4/QJTcp/0ia5Z/Hl1Y/aN4PN9rKEVHRI2qEPlGTLfq0y4NlDNoln
	djLVgLpd7Egoo8I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CAD44195D3;
	Wed, 22 May 2024 15:27:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 064DD195D2;
	Wed, 22 May 2024 15:27:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt
 <ps@pks.im>,  Eric Sunshine <sunshine@sunshineco.com>,  Dragan Simic
 <dsimic@manjaro.org>
Subject: Re: [PATCH v3] add-patch: enforce only one-letter response to prompts
In-Reply-To: <e9f41db1-741c-413f-81ce-a86b1802e507@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Wed, 22 May 2024 19:38:51 +0200")
References: <xmqqr0dvb1sh.fsf_-_@gitster.g> <xmqqh6eqiwgf.fsf@gitster.g>
	<xmqqikz56a6o.fsf_-_@gitster.g>
	<e9f41db1-741c-413f-81ce-a86b1802e507@gmail.com>
Date: Wed, 22 May 2024 12:27:26 -0700
Message-ID: <xmqq4jap4pgh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5357CF1A-1871-11EF-8F20-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> Here, perhaps you want to do:
>
> 			err(s, _("Only one letter is expected, got '%s'"), s->answer.buf);

True.  The end-user errors are reported with err() in the
surrounding code.

I however was hoping that this can be based on v2.44.0, which
predates 9d225b02 (add-patch: do not show UI messages on stderr,
2024-04-29), which makes the testing of it a bit cumbersome.

