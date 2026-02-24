Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA227330659
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771964597; cv=none; b=SK4fOmCZbp2d6k8oEFcnJ7onATEWOtTKEsDnyqGvOmVzJGLvpTFoqGL/drJipg54jrbU40xvBUu/RWIbl7qHZ02htHsfI1r9C+zgDvqsTVI+AqCnR4MbUC8goSqpqzG0oYTzuPDALjTz09rlaX3Sy6ESuI4Yyo7wUfTILNJPmGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771964597; c=relaxed/simple;
	bh=vOJHkZul+vEzTRgau3tP+2EtFNnAtoMVYskNvflRXOk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PK0+Gd8AjAT1WFgqEqDMFs4RXMW4XeTr05JmXYN0jqVt0+LKiL2KlHf9FQUpqQqyXgAYGodnoi6QpU7+ZUT3ZxFNIOJWWJJFCnPPf4hp+dff1tsTNksS9px5t+nIlstdNz3wPgZkm37scavJWVGDoLjOEyPqCUYTwtwHvVFJTYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LCc3ZQ9s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Grz7SVx+; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LCc3ZQ9s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Grz7SVx+"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9E9317A018A;
	Tue, 24 Feb 2026 15:23:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 24 Feb 2026 15:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771964594; x=1772050994; bh=huz2sJGllJ
	swVtbbtDXDCuXi9X2nQbg0rqWN59Wex5Q=; b=LCc3ZQ9syjLeUmw7P3QrO1cHL6
	Q+kxVmIIqBaWatPSSZ1P2JseJJWyZ+MvYt5jh0Eb9SU/dT1abT/DCdObw7B/FVod
	5NFoqG+zKZyUxSmRsngMm6MoICqq68MtDh1twRX22EwppVCYk07BUOLVP/dVwikT
	AGN9TjsLeyB0ZY2JTiHf3DBTddXjTcXd16+LrLknVqB6+gX9g0tVEF/aiHxBJgjE
	V+ga+FWbbA8SxsW49c81zkPC7kdY99uxSJTcCvKx7IdXaFYKqzbp8bxw4Ykd4VXw
	NBRnIgw6MSNFCJlVBB7G5Q6gnqKlgfcEYYxMK6CXysMK1F8ovQ4fMwBatEgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771964594; x=1772050994; bh=huz2sJGllJswVtbbtDXDCuXi9X2nQbg0rqW
	N59Wex5Q=; b=Grz7SVx+3CV1lyQz8wVC0MucAzXRMm6qxiZdECVGldG+QPVo/Ru
	/ZpSAV/Mkiuc94refWsThoOF4m4KTWU6NGkD0GSQLJTAXOde3H4hDrWwRI45D9sh
	1D/Hine85a4zP+tNet3uz25b0KAI9PgFw+exNpQNd0wF3MXnUrytQEnKWXkL7t3H
	45uzpHgichH0OdOyidZ+vEcKHBHXgq990qn5QpH6k9OD+xoFzPbhc1CN9VSvnsWE
	jlJv6qtgKxN/vHmzgUG+x0T4Po8HTbkfAT3LSoCfWj0oHSu3Rax2uAPzJrUUXSDz
	RvvTXq4AAqHJ57bX7K1ExzD9Fh7a6rkGs6w==
X-ME-Sender: <xms:sgieaZPklJl_StiflCDNSj0A2vXQiKiuqSdYyVcAvA3-XHcYSX9K2w>
    <xme:sgieaeNoE1rG_NRFfKRyq4RO3-w3upAOk45aZLILwv51u2ux3X3hePk3vTBCOjkN1
    6zYdf0xkHJEujFySaTREpdBj6c28MUb_gL4nJKsnZSl50sMC7FW>
X-ME-Received: <xmr:sgieaah2B0EOVZggvsYgvOhOXwLfU2exEMDl76hTjGH95hs11rOv8JNcDiIDLcL6AwupUHOFYO2MWHgDr1b81v472tl9n10D2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhp
    rghgvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnkhhnohgslhgvsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthh
    hprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sgieabvjVwbIqucwPpv1BVwcniYMQt5R6cDd97Qh9n02DUE1F8MVgw>
    <xmx:sgieaQTNHgx0kFoU07GKecxE1MR1I1mnlJqM2pIAT1nFTPK8Z2rhIg>
    <xmx:sgieaX1CTJ-EPmKZMl-tDBau6z-jN3J5jiC2y0fWZhhsawCO4ptPnw>
    <xmx:sgieadv4Snx5vXbK_WiLctgGRpbzdhjTWs6yud8vO17hoivqpwAcwQ>
    <xmx:sgieaVglchmpbYDB9MtnmI-8NtyIFdi6xQYONLx2-tFOkk58j4nSt-m1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 15:23:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Jonatan Holmgren" <jonatan@jontes.page>,  git@vger.kernel.org,  "Jeff
 King" <peff@peff.net>,  "D . Ben Knoble" <benknoble@gmail.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/2] doc: fix list continuation in alias subsection example
In-Reply-To: <1178ac42-0d8a-430a-9ca2-a170e4e6932e@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 24 Feb 2026 20:14:09 +0100")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<20260224171245.458377-1-jonatan@jontes.page>
	<20260224171245.458377-2-jonatan@jontes.page>
	<xmqqwm02ez3c.fsf@gitster.g>
	<1178ac42-0d8a-430a-9ca2-a170e4e6932e@app.fastmail.com>
Date: Tue, 24 Feb 2026 12:23:12 -0800
Message-ID: <xmqqseapgabz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Feb 24, 2026, at 20:11, Junio C Hamano wrote:
>> Jonatan Holmgren <jonatan@jontes.page> writes:
>>
>>> The example showing the equivalence between alias.last and
>>> alias.last.command was missing the list continuation marks (+
>>> between the shell session block and the following prose, leaving
>>> the paragraph detached from the list item in the rendered output.
>>>
>>> Signed-off-by: Jonatan Holmgren <jonatan@jontes.page>
>>> ---
>>>  Documentation/config/alias.adoc | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> This seems to address the same issue as 0ed2275f (doc: config: fix
>> list continuation in alias section, 2026-02-23).  Should we treat
>> this one as a replacement of that one?
>
> Yeah I think so.

Thanks.  Will discard 0ed2275f then.
