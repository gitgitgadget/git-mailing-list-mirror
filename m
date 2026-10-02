Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D733EB0E1
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790968423; cv=none; b=LhPSTx2knW95LzGhIHXP5vB/+InDqGdbMPmCqAzXqTOuQ182k/oxDC8OoSPUxBJTmLduCgKxFajNTSq53eUUhRXFaPcdrLuA52+aDv7I2eGTbZTAQjsAr4mT1lE4rWBc4spxm+Mc1Ku5mOrSxm9fVATLZTpfuyjLgFLOYVuVmf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790968423; c=relaxed/simple;
	bh=ue41WEV414641Vvb7YcHAmMXqLF6QCALEirD9Tt4eCs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Xkbk7UyS5M2dU8BHOuU5q8WwEuLldzct0yG7gWYUeMPm9XruyduyDFqf2NHBP66inkBPmoSbjqbVo57Y1OeoEIzTAlxoXAiUQEt2bFl9oUZ8jjVXbLDqeLOABEKQX9IN2SeeqSY+SwdjvqujIRq8Ys355N18YUVfLB7Q3ir523A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=N6uZ4w7J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=drFKJYAW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="N6uZ4w7J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="drFKJYAW"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 563B214001AC
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 15:13:38 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 02 Oct 2026 15:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790968416;
	 x=1791054816; bh=zOhmI5pwHNA8lBzp71L13b1AA8D4ZKQLU9E2yqS8rkc=; b=
	N6uZ4w7JzLKKz3KJ6OulhJ0ZNFSs4ivScFba7amdhe+8m30raeQRIR05taJ6joxm
	m8UWIDhX4JkEJD0vlHcgvcDhqXT0+ySw6YtDYnJ3CUMOB337pn8r89nzV2CX7w5N
	87O/Gwu6evu9E+MpNyZezoUq7wxlKqaoezZ0gmRnQJtROlp76D3ePHyuUi2FpP/S
	k2j35Z1JJ4yFgq3QcLBa64HSJia+IbFoP+FVWOAjMxYAB/q9iWuC4DLQDAA7M4tg
	iGY0+MP4GORXx7eHN/U9DXo+oSEy4BCY5aDzYTesdBDgVHEUOMjRh/CKu7zvEhJa
	5gZjncK/Z689ebqJ7Hbl9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790968416; x=
	1791054816; bh=zOhmI5pwHNA8lBzp71L13b1AA8D4ZKQLU9E2yqS8rkc=; b=d
	rFKJYAWzFRFNio5uvZzQ6MfJFY4qwXOZzyPXRXcirEoFmVvVqhRX6VGlP1ifjKDD
	rMENe4ZL//wq9Wh7x5ZVNkpXGXv3j5aWy+vMLkCexKHvRMipKJdBaF6KgkE/zI9g
	xDOfVXIJFSBKJvKPx2QfF9IaXdeBYvjyN+0377YEwtJMKJ1x/A4PLu1NhOFD/eXL
	4We9iqmEYav0AlqkXhrUnLZ0OYdWFwjqyAfuc65iNd61PEd+luT5G5VTpVX8yMjn
	6FZRz6WAoqm/BiSGWhc+3Bn5g07FCnOHKSnZwgvzsnpmuAJeZwtTIQWVTvgPUTu6
	rYq3VOjS7vQ+rvfv/B86A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790968416; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:IU05ZK7v0txQxUDSl9dlanwM+eYDAEEopHMPd5zdQsq+iLm
	F4HoL8lW4KOylLKmxJnlte1CLHEf9mNVYHxQQlnZQqE3VY7c5JM1Y05gYw6AIJzP
	U2gTdHV3VuPzp257fuoesrTvc26CPvz2xTHWU9LPifuEaBpTmAPz18+dLxz8ct6k
	shWfbZ6MgT/uEiFPimtIinm/l2KXnLyUuIQIC08D8XTTjLE5pFssaPdbOYfrpdsQ
	5dQxGE5SuNdaSJKyFNQdd/Cqgq1+aMAThPGyEdnRCma82xkOk2SZJwEVF3jED4pJ
	9CFtQUT8Hc0jeePTqjT/Mt86j8JHiKswY8Slkcw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:iHDMyFkZnwW+gfHSFfY6Em0oMoja0VqxTRjRghi1od0=:ue41WEV414641Vvb7YcHAmMXqLF6QCALEirD9Tt4eCs=;
X-ME-Sender: <xms:XwLAalgwObx14kvD_WSpX1LMRcD2Uv-wemPYYOMItadeDWRIYAwsFqY>
    <xme:XwLAak15d0JPo87-FXx5b5WHm9OnurRrfdC3NCT_Ccv6r3Sj1bHEkCi6du1MOTMO_
    bVzQ8Q7HzTy8pSN1eW1LUr2jgKdsUmCOtpIVdnIQXMTSvFhMjY>
X-ME-Proxy-Cause: dmFkZTEisxfR66EqbQQTqsjL1MOKCUGbVQOsxm/Ht4sorvS64hDgcEGRwkQEC01itUwAJ4
    Uqxeq3H34O5Wv/gN6Ktq+O7qpzAx+7QmB2ri84vCVhZcCe+4neEoFEi4gbeJ0s2Sk1BW4N
    LfMj+PgaaiufmeKyA2nKqqLjxEXqWHVVipxAVKvpvdSNtSpmzIgh6bTZcWQGhhQ3ddmMks
    8mzTz3WO2dKUWvfy2+VieFO9WxrqMqZ4604UEz3kYgIDbRNGyD/R6T5p9uc7FYwEPpg92G
    cQ3MqDZeWJeQEF46DSKOXOQM0nv46sK5bTIk1dZKD4QkFaqi9B39s+/vWaHI60NgRrOZci
    R3qpqdV7zo1y8qtytSoptsuOlo9qbT4IwWN8EZ3EIzeANgKdXJIqxSzQR/iuxTD2m7ueBO
    paAVIqwLP6WSzTEnCgG6pqERPJO9nEs28mzokZKTF+ANApaMvfMSOiEBu5olhq7K6SCp64
    uTka+YpcP/Oxb2Od0GxMlwuxTveSusw1nn1g+9mzNHnw0+fEn13tH3QgNmedCBR2vysbB7
    QmtMCX6koDUIaXFOSxVnGPwp/DhnRoFsxksH2XqppGwkWi5cB52JWLSzuP0iBB9n6GS5bF
    wsrCzf1d1P7cUiwtUYoDpdMckvtOhQu+cSSywe8nQpbefLxtAYVo9dMq5mWA
X-ME-Proxy: <xmx:YALAau9wvBhpJirL0AYq0XylONflFlJtBXM9MckB3H4kQqGhGSWWew>
    <xmx:YALAamdT0Rx_fGkUSi2klBwvKPWSsJ3oX_1mTE1K8L6ezzS5piJCaw>
    <xmx:YALAanGIZPX02yK4NVQ2_-iGYDmeHLgD3X8yqnsUmcpatW6x2AXqGQ>
    <xmx:YALAakcfIZ8Ltzr-JK7xzwWcjXjwJ2PlXDydY9uUPKX1JDV7csyN2A>
    <xmx:YALAahZhjd3kps25RmcZRqqwhJz02_G78obJ4VLBJAgctA2JispwML6Q>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5584122C009B; Fri,  2 Oct 2026 15:13:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAUWAJQF6URs
Date: Fri, 02 Oct 2026 21:13:15 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <bf0a9780-4f7f-4eb6-94c8-96a33d129a35@app.fastmail.com>
In-Reply-To: <30249b7b-b6f7-4065-9a83-db93d69ad0f1@app.fastmail.com>
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
 <V3_CV_format-patch_learn_--range-diff-notes.d39@m5gid.xyz>
 <V3_simplify_params.d3a@m5gid.xyz> <xmqqtsn4xd17.fsf@gitster.g>
 <30249b7b-b6f7-4065-9a83-db93d69ad0f1@app.fastmail.com>
Subject: Re: [PATCH v3 1/2] format-patch: simplify get_notes_arg parameters
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 2, 2026, at 21:07, Kristoffer Haugsbakk wrote:
> On Fri, Oct 2, 2026, at 19:28, Junio C Hamano wrote:
>> kristofferhaugsbakk@fastmail.com writes:
>>
>>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>>
>>> git-format-patch(1) passes on the notes behavior that it is using for
>>> the patches to git-range-diff(1). In turn you get the same Git notes
>>> displayed in the range diff as the ones you used to generate the
>>> patches. And that makes sense in most cases.
>>>
>>> However, I often make notes between series versions that mostly prepend
>>> ...
>>> something like an alias set up with it. But why spend code closing
>>> that door? There is no usability upside to erroring out.
>>
>> This is somewhat shared with the next step, but the commit message
>> includes a lengthy narrative of the author's thought process ("An
>> off/on switch is enough for this behavior...", "But now we are faced
>> with a problem...", "Well, we can't. Therefore we need...").
>>
>> Can we strip out the conversational journey?  The log message should
>> be a concise, permanent technical reference explaining the problem
>> (range diff notes inherit patch notes, which may contain irrelevant
>> iteration changelogs) and the solution (the new options and the
>> .override flag).
>
> Sure.
>[snip]

Sorry about this duplicate that message that replied to the wrong
email as well.
