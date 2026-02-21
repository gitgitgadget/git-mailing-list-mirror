Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5A2FD69D
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771695010; cv=none; b=SxSMWFRhDrEUqlZxNZOGP4VMD+V6p3sm70p8FWbGER0emqcmVrrQlC/ZsiJARTbR+bxFxyFZ5wbVM/1m73PZO0F0K40CwQxAFgs8q+ImanHp7pyg9T4yhIwezffIS9HsZARqjbX03G+K0GO/x+EtcPRVc5JieDPcHH5CHk7UZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771695010; c=relaxed/simple;
	bh=TeFcoxRNDc4JJx1lskZ2PKnGcrEB7bkHJZGKv5vEbYg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CuVlJKuuwhH6H13STjcmeagg3MXk3cJbZF2+NmY/C4O0CDtw99cdEDR9ysIxWisEQo9EXqzzAvLiYS6pL5iXRv3CU8ku/4jX5Pk9fPK4stBoVrELQwMXvJHycjq33CddliOKMTVLfN9RRcGO5d/cq+oB2aFGzcllKYxV0zVcxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZoeyT4L2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VZpH/DSt; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZoeyT4L2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VZpH/DSt"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 638BC1D00179;
	Sat, 21 Feb 2026 12:30:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 21 Feb 2026 12:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771695008;
	 x=1771781408; bh=cLNh+iB3xAAkGthA/OamDUg4cdryxtJV6Ckiwej9LQU=; b=
	ZoeyT4L2kM4KGWWlW+RmNLrjcJGmaViTEmOtf3XMS1IjprmCfJJtf941PgCobA9m
	zBJRCCGPro1Dj8E+0ZBih6Ufd3RZvWHvfm8DeovVs9TxEpjgfYIK0K2pxer+ipN/
	OWmrgqUc34Lq2bJGTo/K5v+TwSSoAAB0J49V6TvRmX5SmhJbDXYFtOVE6ifTnYne
	gWyxlHjfK009QbhRNddOVmadFsy2FaRuatpF9IuUACcT3JeUeHfho+it6lKey2OO
	0sgiLny6o5IIHfGvosVdJoqiKAKgXqsXyS/aSs2h3QQoujJGiAFE2+wIoWL7Gjhh
	Q0u3XiUZTlPFKHOY4kNZWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771695008; x=
	1771781408; bh=cLNh+iB3xAAkGthA/OamDUg4cdryxtJV6Ckiwej9LQU=; b=V
	ZpH/DStoN5zTGRxWrVRe/f5q+Hk1raYfnPyw+x729Y6QwXhovl3A6kw/aFCr6A0m
	tCt4rkl8S46dWhNY3ZynFhHqzGz3/aVU4SKWfI7o+tAAt1/pBFvkHQTPVOawVX8F
	eQAHcSFDcuxt+zCrhflz/50Ay+U99LHzjlswG+rwZ5Zv+DbByRa12RI3ziyPIbpZ
	I1yAjTzveELIOPMQb5VzpM+7AUAhwcrXy0AZH8Z00hWkaKDFolZPuiW2+08AXgDN
	ermxjZZ+ywxIUtd6vjagDotiRCaEh56h14EG3SVzD03Dd7SqyWRnpcUxQEp+GkuF
	5c8jg+vl91R7pqAmf4vyA==
X-ME-Sender: <xms:oOuZafbd5Y5LgG3fz14dt_VLEf9JV7jP4VrEdwH3q8tuBtpDvWKexA>
    <xme:oOuZaY-T_L1bMMRWzEFBO_Mdf8rIlN7r-dgurdIGA-B0Yhg7veaIPPlOulzcQ-mS_
    WX2ZsYMbwGGzYsxbSd_RkMEMHNUXUJkd6hWObDOuYbddpMCJ0DNxQ>
X-ME-Received: <xmr:oOuZaehbEbQ4Nn-tAhJOsYao39YifBeOfbCH3zyCanTAA9Rtgck65uW2fi9J98a4bsDau7NTbgX4biQ9xOGmhJQwYUQy4ATOjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeduleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhhrhgv
    higrnhhshhhprghlihifrghltghmshhmnhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgs
    lhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:oOuZaYfHF9uEiPQUqOBAhyJv_WRJzelow1Wt7OLYkM_tkuYXAkxXjw>
    <xmx:oOuZaVqMbfd_UOzFilz4HR0MTEmKLcHlsBXv9KM4AfM0midKQCzTlQ>
    <xmx:oOuZadCxoLyOMoJ8ksHmYDp33AhqmkPrcdvDRl8aUyrxuQo-pTAxtg>
    <xmx:oOuZaSZ8GRfaGdFM4L7tLI3udEpGGC-47sXdGHwZJIOTSQDlCSKs9g>
    <xmx:oOuZabJ7S8pHlUrX-cLZeYn6Vo9ijFlYnzBczpCXZgaBt4HLiTzPLdY8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Feb 2026 12:30:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  ben.knoble@gmail.com
Subject: Re: [RFC] send-email: UTF-8 encoding in subject line
In-Reply-To: <20260221140049.579922-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Sat, 21 Feb 2026 19:08:39 +0530")
References: <5EDD26EE-51B6-4BE2-A7C7-E1E0991537E4@gmail.com>
	<20260221140049.579922-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Sat, 21 Feb 2026 09:30:06 -0800
Message-ID: <xmqqldgmrom9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

>> Yeah, that was a bit confusing for me until I got used to it. Maybe
>> saying “[default: UTF-8]” would be a small and definite improvement?

The current message can be mistaken, if the reader does not READ, if
it is asking a yes/no question, but with the "default" label, you
cannot imagine answering "yes", which is clearly not one of the
things in the same class as "UTF-8" that is given as the default,
which also serves as an example.

This is indeed a clever hack (not hack on computer code but hack on
the mind of human who is reading the message).  

> That makes sense, I tried it below.
> I also wondered whether, in addition to this, it might be helpful to warn on
> an invalid charset, and/or possibly fall back to UTF-8.

Agreed on the first half of the statement, if we have an easy and
portable way to tell if a given random string names a valid charset.
I do not recommend to "fall back" to anything, if we are asking an
input from the user.

Thanks.
