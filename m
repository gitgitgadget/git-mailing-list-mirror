Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DBA306742
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182417; cv=none; b=kfC7p5AnWUI/qiGYON0EDLb+T0T2T/4UrK5xMZDiEcV5LhlYbRWpziH5xt+HLE7EBlmsnCrJkkNSa/ACX1DpL89binvxFGW2elyyEcejZwhprFJrEuGMDS9RQFna/3pW/n9kNjuYKUF1DtXuTuJkEbt1ezwKFgUMvI7NYdPowdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182417; c=relaxed/simple;
	bh=XBM5ZMlJIL7ZEmynjFd0be30KrT1jrt+gSzLXZ44S/4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VJ+PxkdQduPcRLjLZleDF4pluOfVsCRbA9ap7GzALdQb+hMDpsBL53Xr7R02I+E1e30zN134eEfqsv4NrAg6YbAoYF1X1RWJkUdcOsylCec6o9Qqbjh5qB+lkXwexJaqtnX6Mu/QBDGzrKD5+6T/urhvMs5bhAIAI4es1YM5w0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=QpSYFe+C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kgEw3K22; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="QpSYFe+C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kgEw3K22"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6FCDF7A0082;
	Thu, 11 Jun 2026 08:53:35 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 11 Jun 2026 08:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781182415;
	 x=1781268815; bh=CMUJHPiL+03UpLDnFvAw/fhdD7AYB0NfQQGD461KHYg=; b=
	QpSYFe+CaNKySSzOHaR8koDVfdTSaxEzGUIf+rkOHNvjjWpCDvA8J6Ao7yGzMYU8
	wJnuT2SHi+5JinbOmtAxVJsDUlftIr3nuMYmS50RPrAYhW0IFSUbJZAQmj+r85SL
	l7TphNKKt0oojfh2riT1rt38NnMV9FvATZvhVhWSuibdH8Dcp72nOUWm2De9gD3M
	4gT43uZqYv7Jhm/MJIHnOAlxrxX+4IGRPd3mdOAiwRxa++vpvuXjCjxXtqocCDeI
	v8JfAi9Ap9Kb17C4YtMNe9GzXZrtzKbekIkw6WNDttb3WPk8yxp1eaPc27QP6XSr
	R9AycOc4RntK6ZOoggl9TA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781182415; x=
	1781268815; bh=CMUJHPiL+03UpLDnFvAw/fhdD7AYB0NfQQGD461KHYg=; b=k
	gEw3K22BaBMx3F6qJ2KZJfINhXnevBwayDAE1+aa389ynNtR5afpzB6Nm7PtMYhe
	VSOeqpD03EL/1XvAV4U6IFL8ODESg4Pk6vj7FN3VGVxqRGLS+Qal2JjAY51SyuJv
	PNcMXQR+P0k0KE3wBscTjmvqGC9C3byjSobST/Ayhzyrd4lJhrvs1UmydtCpqmY8
	cCoLMQPOBiPzRyjRF/5Db2Gx4VkmaHfM/UcoSTSJmBWrVxRA0dJvbrjsf8PNuuXr
	EcMgqu7um2gmTj8vCfmwPldxJC79+tdKHJwromi8Icj0jh4/diG6WkZHiLjRz9wV
	kP0kcWi2Sy11Kr5XEXqzg==
X-ME-Sender: <xms:z68qat_pi6CkzUA4DMx-uOR7k68LEuD0mmi477rZauOrzguuJEX2d2w>
    <xme:z68qasjB0-a7LMFdB_TXplkZ8XCPbpeqXJ0HI8qK0x0dORbTpnEiEKuZ8MuJHfPFB
    LO1GEd7eJ3Av-3OUFgatk7B2GxqiYX-VwOLOy6mAotaJlnpR1BGzw>
X-ME-Proxy-Cause: dmFkZTEfFW4tNguu2wbeMvgSLMhAQXDWD/E3yctzvF9TD7V2QzTjLTTCFjqSSAvRu9Qm+N
    2ojdKpOf8gRlDQXcICK+lArxpfGWLBfB7jzsgI43/VwVfrsSA89daWaRy3OQN9AHzG+tJL
    eGqwKDHrvv+NSrD8gtVZMU3BWejvJuBr/NiRlsSp3sEmRnArFB0MBgViTp+vp7D7qSvtcC
    zLsTDPZpvkiLCSqGwHzxMMKLpb+vmrpnHhxOg7W/N/KkiV4hqUZM8DZhJPluGnQ7Gf0Fei
    e+fII+jQJyl+z5c/SaVTR8corFGGVOg0Qs0Q7jXu/3FDwzRqc2kTfaxqjB6ETh0Dd5I1OS
    BtckzofWWWjzo7yl888AFCx7Q8yLRwWdIQUNtY+SdPmGI0aeaXH4cO49eYah4twHSfL6yB
    fDlVEgeaWVx+2NTkRTBwthLQZIfi23PTzenGgO9f+QyaOa9pwgTQS4qBmY2L6n+cs53Anm
    rgBtdPeQHjYRNnIhIgqpmUGpQrlvh2nlGrDyQl/3054aU/AfqRb9vmD0wOrQbIWj47UqmK
    MBVYh0CqVgfY0g/UxrfR/Q89K5Nc5fK9OVo3iNbEmyISC0m1Zn73JaiIvYhnElKuzE6Zy4
    +3LNPFPoBiuO7IBgP2pTedCPnrcEwqCSU4vYGu0MBcfP46ugGDKXMgh5iYEA
X-ME-Proxy: <xmx:z68qavqWTt8Hko3kiNSSPnnRCzgNaatRroNcsfSYLeTq3uDbet3sYQ>
    <xmx:z68qai9UgI64_Ler4JWA_7Wc7Vc2Ap1nv7D-wkK2HEs1LkdEKYSw0w>
    <xmx:z68qajfhD7yeovSS7FMFwabKrNdzSyuIo6-oVUz4JXGou0cUYW6gaA>
    <xmx:z68qakJt_jaTozN7FF72VanIqRst-FB-WOIWQdfWia_E_H2WLrp7aw>
    <xmx:z68qal9gCzBF-BAA1mfxXtXPkBbraVS54-Y1NpHT5Kj9f1YIKDExm77G>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0919730201AA; Thu, 11 Jun 2026 08:53:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdJf8Qpl78Hc
Date: Thu, 11 Jun 2026 14:53:14 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 jackmanb@google.com, "Linus Arver" <linus@ucla.edu>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <da28347f-7790-4906-964c-5551c86837c4@app.fastmail.com>
In-Reply-To: <f738e97b-1aa6-492f-82df-c284a2f94c6a@app.fastmail.com>
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
 <V3_CV_doc_int-tr_key_format.8a3@msgid.xyz> <xmqqcxxyt4op.fsf@gitster.g>
 <xmqq1pedthkv.fsf@gitster.g>
 <f738e97b-1aa6-492f-82df-c284a2f94c6a@app.fastmail.com>
Subject: Re: [PATCH v3 00/11] doc: interpret-trailers: explain key format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026, at 14:05, Kristoffer Haugsbakk wrote:
>>>>[snip]
>>>> ...
>>
>> By the way, what I queued last night was missing [10/11] as I used
>> "b4 am" to grab the latest thread messages by giving the message-id
>> of the cover letter, but somehow [10/11] had a bogus value in the
>> e-mail header.
>>
>>     Subject: [PATCH v3 10/11] doc: interpret-trailers: rewrite
>> new-trailers paragraphs
>>     Date: Wed, 10 Jun 2026 23:21:28 +0200
>>     Message-ID: <>
>>     X-Mailer: git-send-email 2.54.0.22.g9e26862b904
>>
>> So, I reverted to the old and battle tested way to pick these 11
>> messages manually in my newsreader to replace the topic.
>>
>> If you have a chance, could you investigate where the send-out
>> process went wrong and gave one message a bogus ID?  I am worried if
>> you may have triggered a bug in send-email, in which case we would
>> want to fix it to avoid hurting other users.
>
> I=E2=80=99ll investigate. It=E2=80=99s 99.99% chance a problem on my e=
nd, created by me.
>
> Sorry for the trouble!

It was as stupid and embarrassing as it looked at first glance.
A search-and-replace on the format-patch output which was missing
a target value.

I=E2=80=99m very sorry again.
