Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E384D29C347
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487720; cv=none; b=HHidaRJWjYh6eLDvebWI5bpaFptLMYsbRfQqnBeGbI6lYQJS9ozqzQdKUb2gmqj3rwfdKPOiRAJncBNtqy9ebOYV2dLiYeGnVhFtLcrS8WPyYLZ5bDKEc+ONjkFKvXtd6dltISG+hauvgVj0vSTLeSNQ6HmptMjpJPTLMkPokNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487720; c=relaxed/simple;
	bh=CLwXXuyh9prRgpGhwPUujmXivyW3ncxi6ngAw4ea/No=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KckZE6q736f9+NBGtXvYyv542VBlWHrXF4ltxKL/7EC0NcE7vRxl7NXwT+YxRqRGgo6LIQtv/peqr0abpuKywibtCcoOTmfzF8p+cnjfETQA/dtlK/3tk5eejZXakMQ/gKb39llDBThRy3+HrECZZ19zqTVYwUf1jMOQ5Lfrynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ba/weZVt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XWOVJkml; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ba/weZVt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XWOVJkml"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 19D8B1400189;
	Thu, 15 Jan 2026 09:35:18 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 15 Jan 2026 09:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768487718;
	 x=1768574118; bh=NuTE5gL7NBRlzg2LVhvUMc7rxX+ai0C+fRUiD/UGSsc=; b=
	Ba/weZVtmD2t6mISVX8culurPoGdoXGc+QfrsiTcgJ9GPV+ap7CjkWbdf42pK+gA
	BRoXFjoPQdh4s75HivAm7DQ4xtdBhqGmVzrF4eVnIOZHvLwVDlBETPyxyQG5c5uB
	oQP/nPDaiOR4IsYh5DdgDnjWDfAGAsL74o/mRAJA633OJykxmBxdr9UjOkO201s4
	HCcJVIHUJWfFYbuTs/DDYU3tTKZUyutEDCUrUu7LMlPS4Y1pXeuc9NhayJ/oTTvb
	foeH9GS/6TMJ2l3DS0R54FbonyBGmqJ+pSlWcFAk3wl8bmSdMDMDv+9N+qLfmGt7
	lL/F2A1roXAPzPvRf9d5+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768487718; x=
	1768574118; bh=NuTE5gL7NBRlzg2LVhvUMc7rxX+ai0C+fRUiD/UGSsc=; b=X
	WOVJkmlo0JqYOD8Vzrmd+quLCgKsPhDFHXUMEX7W7kERzLMNaWWBiu+/y7jitxdW
	sfJLUGQSKwCM+IGogtcdr8oTSGlUyI8CIu4aEPFG+595pSmvsqPM1w5auC39yg93
	tY9tZch733EXqwZYk6Vu9SYZ9Eg+7qw8EHlbjZl+8RgjZaFqJ3Xdqc1cJOG2H2nb
	2lsZKR9q4jVfn5+w8zFNjLslbvYmBxJlswJ9TYFtgADc6XObpMzsqOvNKhaPlAOc
	i2Z3w0X9dl/x3MuNuAZC93R4RGkO626zJCjClI8TiCz+TsUqbH/QTZpS1QIunhbf
	qzAnPK3J5zOgEWNw034MA==
X-ME-Sender: <xms:JvtoaZL0uYxCSNBqrtaDptWxJ-FQ7aVnrDFDjMDSLr9-3SzetrrqHQU>
    <xme:Jvtoaf8hD-uwur6TG39HMQq5rEMRtgxos6oyDmdBaDB2sSPzUxgd8NCVeB_lsvyMs
    sSwtNiXiH4ghpMDgngz7yMSDcfKe9F2wZYbqz02IDqvgIUMJTnwLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeifeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:JvtoadmRoHAulRIx3liXb9ji9WyfQ-0K5rih-OPiZVb6kp4eNBrhUw>
    <xmx:JvtoaQmTPcJKj4t0cXA0peQv0FwFdhyc_fAoRVRG72whDUiV9WVtjA>
    <xmx:JvtoaWss_8ooaXChyuThc3GbPSSZY3LEJHOZiqexbIFlppjZLaT5FQ>
    <xmx:JvtoabmMw3c644tAjLIRM82tRBP8SYvzYqF-eQfTEEq5__FkY3QtMA>
    <xmx:JvtoaUr6Sy_kk9KbhQNdK1SRN31zjrJzEyFcHEZQNemcnvdx7bdXOsi5>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EE27D1EA006B; Thu, 15 Jan 2026 09:35:17 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4LhpniH-T5F
Date: Thu, 15 Jan 2026 15:34:57 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Toon Claes" <toon@iotcl.com>, "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Message-Id: <116c267a-35c7-4159-8f7a-62792de4644b@app.fastmail.com>
In-Reply-To: <87jyxjjejz.fsf@iotcl.com>
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
 <20260114-toon-last-modified-tree-v2-1-ba3b1860898f@iotcl.com>
 <aWd2SLrBQRBC1e2S@pks.im> <87jyxjjejz.fsf@iotcl.com>
Subject: Re: [PATCH v2 1/3] last-modified: rewrite error message when more than one
 revision given
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026, at 12:33, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>> On Wed, Jan 14, 2026 at 11:24:45AM +0100, Toon Claes wrote:
>>>[snip]
>>> -		if (num_interesting++)
>>> -			return error(_("last-modified can only operate on one tree at a =
time"));
>>> +		if (num_interesting++) {
>>> +			ret =3D error(_("last-modified can only operate on one revision =
at a time"));
>>
>> Do we maybe want to be a bit more specific and say committish instead=
 of
>> revision?
>
> I was thinking about mentioning something like "commit-ish" instead, b=
ut
> I felt "commit-ish" isn't a commonly used term toward end-users. Looki=
ng
> at gitglossary(7), it says "revision" is a "synonym for commit". I'm
> happy to change this message, but I'm not sure s/revision/commit-ish/ =
is
> the best change for this.

I just stumbled upon the =E2=80=9CIDENTIFIER TERMINOLOGY=E2=80=9D sectio=
n of
git(1). =E2=80=9Ccommit-ish=E2=80=9D is there.

>[snip]
