Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D491333469A
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760636547; cv=none; b=crQ1fROK0GNqJ7lgNI/fr+Scjtw3ydbd/4NMfGCqUDuhfcj2FG4XDbckWUoMPq1fW5AUsnNh8pGa35+0walPbT9qAMQLCd5edlgEQ81If+0kaYQVQToXhYC3ySuaEgE/Tw7w22E8JTpY1rDUkyQArs5gGGtXMImwptk0/cCyYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760636547; c=relaxed/simple;
	bh=QdlI5vo7tTeD5997yOTebMIKbzjyOMP7d/RYlBzgzRc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NfDHaV9U59pbN0I2Abm48h1XrLRVuVQWLawRg5XVPFg8/xNlSDnQ6DshMYnI17zzFzohi0rT4nijUbrYO5IYBTQc74PbnYDPqyvdic4ODxF7iWOPKUHCsfUnWyxxGv9HcKsgmir8kF4nM2OSK5VDJSwHVlWDJN5u1ZRIObkxGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ENoz8XL0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WYrjsaLW; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ENoz8XL0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WYrjsaLW"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F19791400180;
	Thu, 16 Oct 2025 13:42:24 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 16 Oct 2025 13:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760636544;
	 x=1760722944; bh=QdlI5vo7tTeD5997yOTebMIKbzjyOMP7d/RYlBzgzRc=; b=
	ENoz8XL0/ROZBr/0HdS4eBl+yD9RGbYTrIxtKEqf372uil8eWvH1SGFwCDMftxI1
	gmwn0M+DugYm8dJqGUSuuAMSNgCrEbj+J72yJtuAUqyoVobYxx4hMUvpr7jlKMRm
	CWcnptILoQ4ez4B1569G1ClaodaPKyMh8x4eQWzbmyglZkmSWQXkzOL4AYQWrtq9
	mAs/jR7c0LykU665sOovIX7bjmCRO9DceW6ZR94mpbbSuzh4/vitR4o259AODQi+
	jMduZo57av7leuXvLVXoQUiG+TDmfEFXRXtVkzPbA4Z2xU/oEHmPkGUr2yCu5dwT
	hHQREwodCDDmqkrpsFM2UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760636544; x=
	1760722944; bh=QdlI5vo7tTeD5997yOTebMIKbzjyOMP7d/RYlBzgzRc=; b=W
	YrjsaLW1Na0fF5XQTfLXJOQ8gEkT5qOftAQPBaUTXDMBbCrXfuRAc0hF+zbCvTEB
	EJHGDXhpsoo3hjnNjx8KKzcBRo+HjPTU9KF29DpQgjYSV9r1revW1ksislAKZbP3
	9f5oQCIhv1fDhZIUWsjHVPwm4MysHs6cqmbI9f0A12F+k8AsLbjpMafs45PXuY2O
	j1zg8Ku7CptmBTky8JHaLsOuLN5kHiVPbjAOE5YeyJk5ui3F5RvsAx1jDEY/9BWl
	ZS0NR3X1fhK/yFsLN59puqGxUiv+yrtmNeo9NCgpzabA2vYdyicXsdjF21UJYxIz
	dF3bDVwxwepN7eULjPgEg==
X-ME-Sender: <xms:gC7xaE6EhcTqw7qI_1emqpaxHx3KNJZYqdwfro_c7f3sBeTDrM5sKsE>
    <xme:gC7xaAs9LhnNu_3hddzVPuac1JZrNUjUl8waZB03h-mnN7iUTLrGwhVcMsKZa6rU1
    9sKt_PFtf67fNcNQs1biGjB7yOlRTBfcEKRATnfRrMy4OwCfCKYLCI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeiledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthhqre
    dtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceo
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveej
    gfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhn
    vhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gC7xaE-jHKUuHBKXuGxlzXGL_ykOY8BTTc3kzutgwY1lB4trAHw1Ww>
    <xmx:gC7xaOOsX5w-KVmLPvh9smHLByZMY3FN8t-XEXH9wcWz1gJaTlZl0Q>
    <xmx:gC7xaKFLavo1r8fDsOAq7Fw00S0T6IKvvSu9N92dIIikJ1upfQs0og>
    <xmx:gC7xaEQznXmq8pynT-z8JoJ3HckMViLJm-DGfFH5S2dVz-dav1tN2A>
    <xmx:gC7xaFj5Z47k7Bx_5Aa56fyBD51mp0KBjIZRHD-Vw-YYU_W22vOx_gTF>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A30E01EA0066; Thu, 16 Oct 2025 13:42:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwcMx7jJMkTg
Date: Thu, 16 Oct 2025 19:42:03 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Martin von Zweigbergk" <martinvonz@google.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Martin von Zweigbergk" <martinvonz@gmail.com>
Message-Id: <de772df7-9b73-405b-91fd-8acd5d76fad6@app.fastmail.com>
In-Reply-To: 
 <CAESOdVAHt8nUQRE64RXwS4FiO1=Qy8EPamDwaPqUrHvx7bKCEQ@mail.gmail.com>
References: <pull.1989.git.1760566054455.gitgitgadget@gmail.com>
 <xmqq4irzu7st.fsf@gitster.g>
 <CAESOdVAHt8nUQRE64RXwS4FiO1=Qy8EPamDwaPqUrHvx7bKCEQ@mail.gmail.com>
Subject: Re: [PATCH] BreakingChanges: say that `git diff X..Y` syntax will be removed
 in 3.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025, at 01:06, Martin von Zweigbergk wrote:
> On Wed, 15 Oct 2025 at 15:19, Junio C Hamano <gitster@pobox.com> wrote:
>>[snip]
>>
>> In any case, a declaration that does not come with code changes that
>> are protected by WITH_BREAKING_CHANGES CPP macro is a patch that is
>> not quite ready to be applied.
>
> Yeah, this was meant as a discussion starter. I assumed I had missed a
> few things as I'm not very familiar with how things are done here. I'm
> happy to add that WITH_BREAKING_CHANGES macro if there's a V2.

Is one potential outcome just to deprecate the notations without slating
them for removal right away? According to the current document it seems
that only `core.commentString=3Dauto` has been both deprecated and slated
for removal during the same release cycle. It looks like everything else
was deprecated for a good while before the Git 3.0 plan.

Maybe ref files =E2=86=92 reftable as well although that doesn=E2=80=99t
deprecate anything.
