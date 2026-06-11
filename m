Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43DB285CAA
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198951; cv=none; b=Sqk45/RnwtG9lTaFYXWRgLVJxPFItqaG1Z6t/RBDGf9+JJJ8cd35nv6bsFrYqXurNKHBCps1REhz4orUq8YO+C0VQCnWrHCRP2NrkThGGJSvBhzTrI8y3FQDRzbhDco7GuifxUGrK3QEMH8wkNIflBT4qG0vfbQECGksjtzhwCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198951; c=relaxed/simple;
	bh=bvHPFqJ2uZYIEImUI2w+dk0WvYQxZTvhBAmwoEDWHyU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lBHKjixhVBLTbYRTjev+0OEfAMS29FSoyvO5IcAWNNHxm3+TLO/tjHv/7exEmj311bbTljq/sIPQ4G2KhkmHYssEGQ+4C4oGmp2OrZf+Abp6esczwsC5DB92dS+An7zMu9W4NGAmC1pxXcNIMaLQDq8vRPDEc4+LhR3Aq3rW9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Hocnj+RX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LSfyQh/h; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hocnj+RX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LSfyQh/h"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E8D50140010E;
	Thu, 11 Jun 2026 13:29:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 11 Jun 2026 13:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781198948; x=1781285348; bh=LeImJ6EKdv
	D37Ed3v2Bpw/3eJoTs/Y5V3WpdpvJ3LfE=; b=Hocnj+RXGq2eweIY6pjVfmkPV3
	UUH3/Hh3QhXowwRxfMGD0MFlFsxKiix7Ehb8ortPRPdOS3g1IpekTConbHExTzGs
	KRWA2gGkSR7Y3ZnZDuvc6aIDpdW2Gph+v9S2JiBW5xsvp6Ud9gZimSt+Itis3jV9
	Ctz9VqrriCcrLLQ2mIcOeIcDUEMCMqz8ZJ4W/VYm7pxWM/8FCbrqtZa4nZ0Psz1W
	r+c9HRHRH25yfZkFjYinK4eqL3nIJRwAHNFWfbuU1L+OWvSVEZdPwIxd6tKK1n7L
	Fa5CAOV74p7o1tPsZS21UB4dMpOV+kerQsAeG8K7nCEgcWezhp3rKVYyhQbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781198948; x=1781285348; bh=LeImJ6EKdvD37Ed3v2Bpw/3eJoTs/Y5V3Wp
	dpvJ3LfE=; b=LSfyQh/hGZ7kaOFvEFlAMJfKco7K8ei1mYrjqr53t9nTXyVL8K/
	CEQIs9uMVf2aef8UR3A+acBgjQwlMEYOby9f3a92t2y+R7BMEbVVfnmVycXiZ8dX
	zJdmMQ/OO/vGoyEQjSE2z/zMzDHNjmjJPHvGlgBRcO2bjrTnEMb14IHLbHf1biI7
	EUe/CbWoa3MZVH8dJ4zrYfBRwOvAjmYHCMOOzi6vUoTNWBdDACH/7wS8jZA0nOcq
	BGQwhs312WnX/VQUJ/adOt6L8gIRPHQxJs7YRbPTGkuh7MzPxh9uYZtK5BN4ijos
	jg7tI93ODAgXfC3vUb4E5hbnoPNFy7FJMPA==
X-ME-Sender: <xms:ZPAqaqVC_H5M1gTvEH3_1w_CifRE0iSflPNEVB4Bic-196LhI1WNeg>
    <xme:ZPAqalqZzcnZtphshp8jXSzBclKspLJPIA7En3BT8HnNMfofZh7WbfC29FGp2QANP
    s3xWnZS_qu0zLZyL9LfNjtYFiFh2ElHkwcOm18o9k5jFV_yKH9TlbQ>
X-ME-Received: <xmr:ZPAqaknl1aKfT6_UhOlPP37ft65GsqG30Rg7EkGYSHgI11sqGAk6_job8DA4aQgXx6corOguPItCBOYYGAyOPckefrZNGb-_ZN5N>
X-ME-Proxy-Cause: dmFkZTGbausOEpLoIvf4ao/BdiY+rgAHJxUtRbhdq7RdY6C61NktYJDM2PSFH4B8FuEUkq
    ow3Q6P/qikKNMaTbUY8Bh07o7BErmuvZ9VmxFL+MeBuJNpt/0sgzJNHpLvdlTdWKWTznVA
    549xop8NP10n9k9HUuZI1PEel45ZKm/soWfE6QfTVgMfTiCPEZ+YpSVmjWPC0pGyvNJpA1
    u3IQJPWXJKuGmeEIAykwjYRZCkd/VRUyDomKjztkWKk0Sm4OWVfeLlutfUaL7Cyp1fmHUf
    U+kqAQonSIkwB61uV92V+Q4osqATiqNSDCDpEcRgqZ9/DEPLkPRfdvT+2jL8egU0bcWllk
    EQ4F7qn+3sqZjIHp8nYcxagpMuSKVZvBCqTgKiUaar7sYWHjNE37rRHx2c30cSrSh4Ot9E
    D+SlNGWldy2YGdgwAmvboMyBjgCCBplGN9PgdWGftquoqMfvxoMt/D2IAi9YII5CK+PVC6
    CaalwfEH6k9H46RxmyUuqyQrchYk46nmguKKDv7MP/h1Ahwvxf60i0H/r383fkUuHb7D5M
    OvDOvZhq+h94Lm4Yh4hEASZDFbAz9nQr8YX0WxbqqktrK2IizuHW573Dg7sYHy0hRkX8rP
    x4gXZFd4EJasQ3V+LAF1ZOjffeAUi3KW2LVV/Ue/0pEv6H7d6pjbV4ECWcVA
X-ME-Proxy: <xmx:ZPAqat1TR6PxqodGgzDpN9qKQ2DFeXvGnRli5lJCtC0xTILMABl10A>
    <xmx:ZPAqapTRsbgE26-dUqWTV0E2xUkAM-cqnDuE9xYWvNabQYuwoxhamQ>
    <xmx:ZPAqauwxKdNI6eW0l3Qe0-h2RxlzNKqWojeO4ZzfRzqaynohKEHRLA>
    <xmx:ZPAqahCatxshV1gBU0WzTBD4Sv0DrOI9plsYRVoTvrKkI4xzlHgh1g>
    <xmx:ZPAqarbacytJ5YtwixRJI6yZ0SrzpatujtTx8bIHklYcohJ-8UUdFWwC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 13:29:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Arijit Banerjee <arijit91@gmail.com>,  Arijit Banerjee via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJu?=
 =?utf-8?B?ZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  Derrick Stolee <stolee@gmail.com>,  Arijit Banerjee
 <arijit@effectiveailabs.com>
Subject: Re: [PATCH v3] index-pack: retain child bases in delta cache
In-Reply-To: <20260611065748.GF2191159@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 11 Jun 2026 02:57:48 -0400")
References: <pull.2131.v2.git.1780330402264.gitgitgadget@gmail.com>
	<pull.2131.v3.git.1780445118653.gitgitgadget@gmail.com>
	<20260604071204.GA3196596@coredump.intra.peff.net>
	<08B48BBE-4084-4619-94B0-503158B93BEF@gmail.com>
	<xmqqldcmxxco.fsf@gitster.g>
	<20260611065748.GF2191159@coredump.intra.peff.net>
Date: Thu, 11 Jun 2026 10:29:06 -0700
Message-ID: <xmqqo6hhnfz1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Jun 10, 2026 at 07:51:19AM -0700, Junio C Hamano wrote:
>
>> Arijit Banerjee <arijit91@gmail.com> writes:
>> 
>> > Apologies, my earlier replies were sent through GitHub's notification
>> > emails and appeared only as PR comments, so they did not reach the mailing
>> > list.
>> >
>> > On Thu, Jun 4, 2026, Jeff King wrote:
>> >> So I am happy with either v2 or v3.
>> >
>> > I also did not see a meaningful performance difference between v2 and v3.
>> > I am happy with either direction and defer to the maintainers on whether
>> > v3's more precise release is worth the added complexity.
>> 
>> I have no strong preference either way.
>
> Nor me. I'd probably go with v2 simply because it is shorter and less
> code. If there is an optimization whose effect we cannot measure, it is
> probably not worth even the few lines to have it. It could always be
> resurrected if somebody finds a case where it matters.
>
> -Peff

Sounds like a good idea.  I just resurrected v2 from my reflog ;-)
Let's mark the topic for 'next'.

Thanks.
