Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAE8E571
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482494; cv=none; b=fimuSIpP1WUqJx8/rcCkeDXdYDb8J2Du3gS2IHxNbRFFf2j9l+c7iNvOabNSozjfzeNaORF5HleB9KpenWhOkZUZVP2G3tRamAhTEStY14DB0JUbBvV+057A7htYH3BiZzJZjLsROiBuE95rzjRNqNbVd8hLt9gk5gy2u6x2rRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482494; c=relaxed/simple;
	bh=5pUqvWf6jRv4VSj42rJulDdd5I7Aeo6iyPfHMazhZKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RPi+tYSrf72vAVnWk1+eIbiPyAArbY+Mr2DFjkStDIJdQe/ueTajllXbRXZHO4uQRO2YUTj9QPInC1FwKR/rhufkcK9fGKmmUeVRw92IF4EXVor9WP9A6edmO2GGAlLl+mbsAMpkiEEy6C1jOey5ZCYC8GUymc1HywmL02sC4YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z1RzvVgm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MlUHtOZ1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z1RzvVgm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MlUHtOZ1"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 3465A11401E2;
	Tue, 21 Jan 2025 13:01:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 21 Jan 2025 13:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737482490;
	 x=1737568890; bh=9eifvQcCTWF+eJnAK1CVwJ2t4O0yRXESz6q2QAAa0tQ=; b=
	Z1RzvVgmdGaZ0qldkt0pQA1lUKBXHIcinx++8S/FhJFYzez7r/ne8h16ZTXt7I2m
	sTdcHcbvZ7iPSgEt9UWqHq5TZU+W9txtfUgkHQi/0CSBTQ0xlaCBoKTryc5FzWnh
	aQYhjWmvYeE5rypwafNInQYJAavAhp2sIFiASYBs5osUeVrO1n8tA6ifq0d68ElL
	20d+Dq0e4R6J44MxGNIwL6fAxO8gzlMv/Ll+ElIGVSQ7SN2LB7lbKxoDJYTiUvYC
	v1JK9HMq3UoQQEB6Z5PSjrKU02TljyKwRXfgUqG/XBCHMl0j6+FWYIvXiEaFHD17
	5kT81pvEyus9FKBCYo7zug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737482490; x=
	1737568890; bh=9eifvQcCTWF+eJnAK1CVwJ2t4O0yRXESz6q2QAAa0tQ=; b=M
	lUHtOZ1dZ9aGrfX5p2XqqsKRF5mrZWuZfxGeQo3n2MvnRte+uS01MtaLTN4IlljY
	bNQAzun/CSiMRuB9NbEI1Z8EbbFaTdnLs3oVOWIwA2b/5mbDFFB+tCa3L+AmJ5K0
	sc2P7mDHxdt5bfZj0wQXBN3kpzEoXFp2XZDlMJM4JhXxU6Mmby5KZzwZ1OTpOul+
	WJxN23CNc86ZCDEuxrkH6Be1fyAoqRJ8PQHZ1vAFFmXcQHr+htGa97M8h+u8OUMj
	dH5cOJBjP2/XyJS1FDrXV+dP7+bWB60f1EAHEWZHaUJQz8EH4ic1rfupNKk+fTNH
	WIlhwMt2QDimit7FwqzIw==
X-ME-Sender: <xms:-OCPZ6bBkZLHoU6Deer723nkMYKM1jkCo-LzoirUvz7cf-mWVACR5g>
    <xme:-OCPZ9azCB1nAc7G_uLzg8ScMSXAyT5vYIIXecK59xhXUokYHzmN8-eyJG-3VoYXa
    EbOYURDbtsl1R8TCQ>
X-ME-Received: <xmr:-OCPZ08u74LvsNQXjIgQ6SVBfjp103ACtFGqWsgJOGmXZprdhARATQBTvo7K_HPM7IUzS053pvVqyUoUeZHIzOJ998381eRf3HAW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhsmhgrnhgrkhhi
    nhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    jhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtgho
    mh
X-ME-Proxy: <xmx:-OCPZ8odKRvvb2A4XK0ogHIRL666P-fTInbo2j6MMp3smY_7ZNjUyQ>
    <xmx:-OCPZ1rvwF_8RBMMqEbMslIE_Qxanmxa3q8kUXV_duKZG1psJ3q9iQ>
    <xmx:-OCPZ6RhD1CPmev2QitVGEx59VPosTVaF2hOw4A_2Tfz_bOepu2e-w>
    <xmx:-OCPZ1p8E5Y4gXIrSQPVWA8OKjJPVUIsGqXwZf9TWCYFfXcQWOONuQ>
    <xmx:-uCPZzhHXwG1gor8VX90O2pJIwqGO4RBnp5_4pwaF3AA3uu4hlG4dvIj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 13:01:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,  git@vger.kernel.org,
  ps@pks.im,  johncai86@gmail.com,  Johannes.Schindelin@gmx.de,
  me@ttaylorr.com,  phillip.wood@dunelm.org.uk,  sunshine@sunshineco.com,
  rsbecker@nexbridge.com,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 1/6] version: refactor redact_non_printables()
In-Reply-To: <CAP8UFD3ccT=bAy=fsHaha=yNEDOuFpEsJ5tR7zQ1VJWtgNDh9Q@mail.gmail.com>
	(Christian Couder's message of "Tue, 21 Jan 2025 09:12:24 +0100")
References: <20250106103713.1452035-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-1-usmanakinyemi202@gmail.com>
	<20250117104639.65608-2-usmanakinyemi202@gmail.com>
	<xmqqfrlhl2jv.fsf@gitster.g>
	<CAPSxiM-NPobarwmeRA+Z1L1DCLMEJy=1REobt3tyCKKFZOO_gw@mail.gmail.com>
	<CAP8UFD3ccT=bAy=fsHaha=yNEDOuFpEsJ5tR7zQ1VJWtgNDh9Q@mail.gmail.com>
Date: Tue, 21 Jan 2025 10:01:26 -0800
Message-ID: <xmqq5xm82gi1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Jan 20, 2025 at 6:10 PM Usman Akinyemi
> <usmanakinyemi202@gmail.com> wrote:
>>
>> On Fri, Jan 17, 2025 at 11:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>> >
>> > Usman Akinyemi <usmanakinyemi202@gmail.com> writes:
>
>> > > +static void redact_non_printables(struct strbuf *buf)
>> > > +{
>> > > +     strbuf_trim(buf);
>> > > +     for (size_t i = 0; i < buf->len; i++) {
>> > > +             if (buf->buf[i] <= 32 || buf->buf[i] >= 127)
>> >
>> > <sane-ctype.h> defines isprint() we can use here.
>> I think it would be better to add this in another commit so that one commit
>> does one thing. I will add it after this patch series got settled,
>> what do you think ?
>
> Alternatively it could be done in its own preparatory patch at the
> beginning of this patch series.

Yup, a preliminary clean-up sounds fine, but so does a follow-up
after all the dust settles.

Thanks.
