Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A67A18F2FB
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500730; cv=none; b=FLC9mKDbN8MLwoM75WQXI9AIvDhe49QGqfBQaryZBfdN//VK6IAFeV1pUAtgHDi7/3f0MCcLf/r0+rBjjMVCF+aR7DHKMEWypJr/uMbRX+SQUtOrzfwwIgYWjgJ/DYueOGApAhm6PL2vPW94ZTPZgkvxjK+Kv50QIBJZGIpUpfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500730; c=relaxed/simple;
	bh=bJVt9OTt+UbeJph4i4bjjlgIPAZnU09wYtr5hDeNZ38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kdgM9NNgIO+xJH6G0ckQM9JHKopXPfB/5JoCFEMMCFCAgqZbuOrrQ1c3s5zb6Ssx9gBwRwpG2p9V26/zcW1qyR1likR/mTmZduIE+C8qE8noI6Q7Iy5mNkE99EDP4roYRpN9fcyr1LEAlI0lLVsNTpNMg3hVeu82LICxzK0M2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RTdEaUJ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1uljteQp; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RTdEaUJ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1uljteQp"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B628A25401C0;
	Tue, 25 Feb 2025 11:25:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 25 Feb 2025 11:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740500726;
	 x=1740587126; bh=Xok4nPZ519Oi1aMMdL8QyB4EKypMRipfWPkd7rrZns4=; b=
	RTdEaUJ0T/W/rj/OqxKxXbRDEGpsQeud1CUVTSwKkM10MEpGnl92GVrMIG2VTbzM
	OETs741TSkavAYulzq7Af+BCjXsmtGbbhhEsdluYldYgSC50SYwQVDU68iqDIS/i
	0kBstbo4zH4cPNS6qigY4ihWhT9OG0SCry40F59QYcHnx78Npy0HBLtGhLPZOy7h
	YhxvJ3nDiHnRIHWQ7PFON693n3l5f2MeIqpoP5env9bHKh0L7plaj/n+xNasO5sK
	Q/O5XNPmY+s96zjwpQyBU99h/54v2Fc71/nAL9uW5U37FWvYYguIUqp+u7poDF9Z
	gdw4/AZDdGzITzU5pQpCHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740500726; x=
	1740587126; bh=Xok4nPZ519Oi1aMMdL8QyB4EKypMRipfWPkd7rrZns4=; b=1
	uljteQpNwIUUAJMHZ7jevHr+/8gKrpdc9i8XSle/k08U/jf5vDvgFgsAFsNYSbCu
	Pzr67W1FG4iY34isQklxvUkADA4e9q1YWGWMldCZRcnCT+2qxjs1WdSiewp8vbMC
	suIRwn/JiKviYTav907pJcfPXDs0xEYLmw1tYDQcJXhtwjyG1YCNuz2MSIEB6wA1
	qKONzlFyVdTEDp/PULa0CqXmROpo7hgRmfrGHoYQlOb6rdvXw21uLDm10ONwtHem
	K17kaOGtgInh85vwlbioZOa6aOSdoIomllDnNwXP3JAzhcwAaAh1TxCDjVNdxWGp
	Y+jNs93GJWVWkRlPEOqVA==
X-ME-Sender: <xms:9e69Z7xTbPljyA1sWskLEMZkUPGOjoZImjaSqUig2mpwSPpv01B4KA>
    <xme:9e69ZzSroAcz9wroneh1BU1tg-xEHKTgyBGoPM2RjEoU2iMG67wzVzZ_Xv8VwZyIG
    tjq16MiJ8JFIBV_TA>
X-ME-Received: <xmr:9e69Z1X1iXzguyCtY4XkRqwMscPji_BQswxg7dGDihgZVf3dOlM0TB-EooUbw2ykIxn4v_e6Ms6mZX5wMMneXZXTitU4N2yiSWUc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehluhhkvghshhhusehl
    uhhkvghshhhurdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:9e69Z1g_Zx6hKiujmvb35sOt-hY-OmN7713a1RjilUTK0ussPw9RRg>
    <xmx:9e69Z9DMQqZBMg7_p2cvM6nVhEBWKQsdbwmCtP_gIxehUZaispT8Rg>
    <xmx:9e69Z-KwGn_ggJNagtqaP_6y2MRYzUFostxFdEPCpKgf4rPf8mbiug>
    <xmx:9e69Z8DtPZgLlcUZZMRsl4WExxPgcn5znZ0KUEEdKwlFomB5WTrriA>
    <xmx:9u69Z1wCNzYB3n7oupLOnkEx07HWpBYoKXiKTWxmwuSI6uRZjJ19duJx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 11:25:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  Git Mailing List
 <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Luke Shumaker
 <lukeshu@lukeshu.com>,  Jeff King <peff@peff.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Taylor Blau <me@ttaylorr.com>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Luke Shumaker <lukeshu@datawire.io>,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 6/6] fast-export, fast-import: add support for
 signed-commits
In-Reply-To: <CABPp-BErRqke5DH7c3+u19iw1U5JgWYB=xcUwrE3NObf=EYz1Q@mail.gmail.com>
	(Elijah Newren's message of "Mon, 24 Feb 2025 23:35:00 -0800")
References: <20210430232537.1131641-1-lukeshu@lukeshu.com>
	<20250224142744.279643-1-christian.couder@gmail.com>
	<20250224142744.279643-7-christian.couder@gmail.com>
	<CABPp-BErRqke5DH7c3+u19iw1U5JgWYB=xcUwrE3NObf=EYz1Q@mail.gmail.com>
Date: Tue, 25 Feb 2025 08:25:24 -0800
Message-ID: <xmqqmseakn4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Mon, Feb 24, 2025 at 6:28 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> [...snip...]
>> diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-export.adoc
>> index 1b19f17b78..8750dd150b 100644
>> --- a/Documentation/git-fast-export.adoc
>> +++ b/Documentation/git-fast-export.adoc
>> @@ -43,6 +43,17 @@ they will be exported, but you will see a warning.  'verbatim' and
>>  transformation affecting tags will be performed, or if you do not
>>  care that the resulting tag will have an invalid signature.
>>
>> +--signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
>> +       Specify how to handle signed commits.  Behaves exactly as
>> +       '--signed-tags', but for commits.
>
> Should this also explicitly call out that the default is abort?  Yes,
> I know that...

Thanks.  We all tend to assume that readers know more than they
actually are reasonably expected to know.

I would have of course expected that any sensible designer would
pick 'abort' as the default, but I didn't know what we actually
chose without looking at the code ;-)  

It would make sense to spell it out.

Thanks.
