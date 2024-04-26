Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DFF75810
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148800; cv=none; b=EhdlpQKxH4bZ5lDWWz5caFnJMr4lVOhQrGhVrg9iJdK14Pl3fYi3PEx0KX9Gpe+mx0oC7fw4t2Ch6qvxtxoTL83vwdyewx1J+XCpIZBq/p07v/BAbMJ2eEpRIaLofi1jwAHfGc93g/JkiI1VyR6+qCRbRe85Rg7TYg/nNGV5fCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148800; c=relaxed/simple;
	bh=w9A7p1J6gJrFxJVPmsPc2T6AxArSIGaAyzvUIg7DI9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WnP7BZxtGwKUjMgLZtl/iKTI6XgXQoJkFR25hq5xLghJXcgxBuTRO2u0dk2BQA+eGnMOLLqtaD8YMBkEnGiRPWHrleq4cCNA4DXNbbJHq2YilaTsOoeEksOqVUcqfJp///rA3/xGmkrtBX7b2LE3t/DEU5fyTQ000pa9kRuAg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cbNysaQY; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cbNysaQY"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 22FAB1DD90;
	Fri, 26 Apr 2024 12:26:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=w9A7p1J6gJrF
	xJVPmsPc2T6AxArSIGaAyzvUIg7DI9s=; b=cbNysaQYC4MYEEvHEiBOWyX3qshf
	rj0RE/thR8n4Acu6ykv00TVlTxfpq8Zl6wzMHXUZIQB8BhipBSFT2cBGz5duRUa3
	GeiEYjWNQCx78Sd0dqX9BkIjOQ7owDSsf3EQgHhw/vuPAK33orTh16ZWhZkK2i1f
	MqveicEVQQm8Zss=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B6081DD8F;
	Fri, 26 Apr 2024 12:26:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A6131DD8E;
	Fri, 26 Apr 2024 12:26:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Jeff King <peff@peff.net>,
  Git List <git@vger.kernel.org>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4] add-patch: response to unknown command
In-Reply-To: <305296f1-975b-41b9-968c-3984d8056196@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 26 Apr 2024 01:46:38 +0200")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
	<db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
	<b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
	<20240425014432.GA1768914@coredump.intra.peff.net>
	<CAPig+cST4_hUwWg+P_drqT-mv8+eLAzBmuMFXm=Dui14kfYZzA@mail.gmail.com>
	<xmqqedatfay3.fsf@gitster.g> <xmqqv845dug2.fsf@gitster.g>
	<5854e33c-b84e-47a3-94c6-c5fe8c9a4c98@gmail.com>
	<xmqq8r11dr64.fsf@gitster.g>
	<305296f1-975b-41b9-968c-3984d8056196@gmail.com>
Date: Fri, 26 Apr 2024 09:26:32 -0700
Message-ID: <xmqqcyqcay4n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 BF47FA5C-03E9-11EF-915E-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> I will give it some thought.

In the meantime, I'll revert the merge of the topic into 'next',
squash in the "send everything to the standard output stream" fix,
and queue the "tentative" result to 'seen', to make the CI happy.

I am OK enough with the "tentative" one, but if you and others feel
differently, I am perfectly happy to see it replaced with [PATCH v5].

Thanks.
