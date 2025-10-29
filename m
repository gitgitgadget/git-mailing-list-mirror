Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5E324BD0C
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745844; cv=none; b=OeQwS6y20oiQw0LZZ7D+vMDQl+q7i7jhtH/4X3ReDoDyX68J+YyIWvbU79Wgt236h4zFKAPbI0gWHipJn0VHs0pWPdMsIi0vqhwKLTPDuXkyuRpvhLQdHTA1nr7QR+8amXdwmuf7IIYfTlruM+mE/F+uY9hRMmMNzK1FjHCyxFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745844; c=relaxed/simple;
	bh=h05lWCve7VPAptBE+esBIWmgGINq6YxZk1QdK5/P8p0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BlOT3BxPI46hhSovE++oQ3BJfaDMO7HdGmgv9eZe+EHuzU5qWFBEttivMFhvy420DO74nfYBL3lGMZOvKnoG/hEKMz1YPXrrMmLg345fd9BwZEn1PkevHtTpnG3mdrjV98XMIUXVaJEac1i96+5BNtVjAAa3KNiUt226j/gIAxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nzphziqo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dNqtkFjw; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nzphziqo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dNqtkFjw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DFAE37A0125;
	Wed, 29 Oct 2025 09:50:41 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 29 Oct 2025 09:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761745841;
	 x=1761832241; bh=xntAGlKzqYbAXrVPrpkF9R85006wQrLwYF8+VuVBl7k=; b=
	nzphziqoDv/HTORCpQ71MsSDQvRFqFaNJlINAkwSCLvsoQSXFtUzu+YfsqatJqB/
	kWnQiPN9yJcxE7LzyHfmeliQptUR1415mHvBX3EnR0S5aHY+e++9usgynOYhy1Wl
	5DZN0yNW5czqqBPKZDK40E22y0ABp9007wlDq16FE0oQZeqMlhtEVc1+BWlz/R7n
	SINy9GHeaLla5oyfhoUR98GlmDkC0EnSG9cTsqp6p3TXJ8qky5esVDDsEAceqJge
	lG9jMQhRO5LwaOQTGZODomuMdz55fnpDhLdLuT2h8/408JUi9q1zjRsUjyQYtcY/
	d3GWF9uhZjAjqdyLzfJHXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761745841; x=
	1761832241; bh=xntAGlKzqYbAXrVPrpkF9R85006wQrLwYF8+VuVBl7k=; b=d
	NqtkFjwvWoV494NOyumm3bkd939eKjqsAQDJH6/bEEk3fGePbNwcuWtApPQeMWuZ
	NdQiFdgWIrRqTRNoHxhwe/qx9JeMM0ijnNjmfBXV46pZ9KSBO/nN+u3XddiFu0CY
	eypXSe7jvoYJBqDNrHjsAv9wgjGPjNQgnQZFR9InfUtORD0RJTCJ51LV63wdTpSb
	33/JHPEZdZTP6rCJl63ISKtBunvnP3N44rU1tSr90VuYgEfQo+KF+0/95abkECqY
	C7EKcMJuUw8ZtX7+SSjs8rwHT5cS8F6nEfXxsGRKis24tbjFLz7md6xlPGhStNek
	P8r/afioVSk5h7Y2yi1Qg==
X-ME-Sender: <xms:sRsCab4LJSNQWuf4HoTRt9YxhtxWPSi5gqout2Vu0_XTEkmhA4bneeM>
    <xme:sRsCabuHCbIvmHA9ZQbIqsfUE9xA3Auug38GAywe5yEsGsGV0s5rhc21GL_Gn6PfU
    pryvY4lK4bmYBwBwd1r8Eq0U6JqWwHWT7g2h-XMVKBdC6p553nH_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieefkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedutddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhl
    lhgrsghorhgrrdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegvmh
    hilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgurghmrgii
    ihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:sRsCaXYd4Cn3qo_U3nxVcngql0zqqBjITfvfXmSZMtRa8kbArobKLw>
    <xmx:sRsCaZeQIdx4yJ7TkQdEkFnWiPfKYGXcO82d7N686yxXrfrRrR3kaA>
    <xmx:sRsCaUkShHtimaTFgoFrGeBOvdtkL_QijjGXQZfHyHmlrsxZgP3TfQ>
    <xmx:sRsCaZ3W90H_s6N6gQxgjFa7s-iNLIrjlgNiGqfz4jrUGsvjka7JCg>
    <xmx:sRsCaQO6Wf25dllQY-o6N0iVQK5o_BlXZ5qmVTWK_iIgSKygkWZtlt9y>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6DC2C1EA0062; Wed, 29 Oct 2025 09:50:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtqO_KzHnBtZ
Date: Wed, 29 Oct 2025 14:50:21 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Adrian Ratiu" <adrian.ratiu@collabora.com>, git@vger.kernel.org
Cc: "Emily Shaffer" <emilyshaffer@google.com>,
 "Rodrigo Damazio Bovendorp" <rdamazio@google.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Josh Steadmon" <steadmon@google.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>
Message-Id: <fab7b893-ecbb-41c1-a592-6547aec4ccde@app.fastmail.com>
In-Reply-To: <87bjlp7rcd.fsf@gentoo.mail-host-address-is-not-set>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-11-adrian.ratiu@collabora.com>
 <b03a96a8-af42-427a-8cf1-4d195be6a7c7@app.fastmail.com>
 <87bjlp7rcd.fsf@gentoo.mail-host-address-is-not-set>
Subject: Re: [PATCH v2 10/10] receive-pack: convert receive hooks to hook API
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025, at 14:46, Adrian Ratiu wrote:
> On Tue, 28 Oct 2025, "Kristoffer Haugsbakk"
> <kristofferhaugsbakk@fastmail.com> wrote:
>> On Fri, Oct 17, 2025, at 16:15, Adrian Ratiu wrote:
>>>[snip]
>> I don=E2=80=99t see `ppoll` in `run-command.c`.
>
> Good point, it's poll not ppoll. :)
>
> (The while(1) loop in run_processes_parallel() from run-command.c
> calls pp_buffer_stderr() then poll with an output_timeout of 100).
>
> I will fix this together with the other typos you pointed out in
> v3.

Thank you.  I considered marking them all as `nit` but this series has
spanned over such a long time that they seemed worth fixing.
