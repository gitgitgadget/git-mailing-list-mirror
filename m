Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA7238C0A
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767105182; cv=none; b=by+y6x5fdA+hEOQBGnLa+/+jdOmsNpLhdQACRf/xQTg3olSaAbOkk23AxFxOXQ1djbWvGcEUeFlN7T7Cg8AqNyxGqbX60wzkuALds/WPtklbOXxcwN5B2xPFPf0hUivPLCQCkkJ2IE27j+6we2jc4Yc6+7Z8P3gyDMx4C963FtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767105182; c=relaxed/simple;
	bh=QLTTeZBQVpXU5E8/txaxLNQ8xu9d88bYWhnmoW73QaQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j6SRQpSCa7N/EyqMQ7dVw+qH4tBUKimhxI1M4sJwOY7nZEm5txvvmVq5IFFeu4VRtT6rim16v2saKle9ikS8P+tFD71coGQPqpt24KUnzmlx5Qz4Up7miIDAJZcL962WwNYBwxMYaMwr+W48vPEFFKHsTVq0FGK7CKE9Iz6W2R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ev6fdSqH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWWkghQB; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ev6fdSqH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWWkghQB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C4F9C1D00063;
	Tue, 30 Dec 2025 09:32:58 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 30 Dec 2025 09:32:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767105178;
	 x=1767191578; bh=3ipXhgK8hKfjII7NqsKjHwoZFxvkylZRHbE+XPkMVec=; b=
	Ev6fdSqHNAr59O6Cijinstp1WHUGKIiDhxnUl1P9HNNd/ZmlcdbWpVyrbQnrkm6B
	j5QrQs/exosN0t7aMom43IBqg886Lf5SCq5g0ieTr9UEoq940YPI/8FvJL2IK22V
	lu9BmbDM1y6hSiCmMM9Oa+dDVaDlOxcQbxM83wikS47xeV9sUpXwEyD1xN9pGASN
	j8y3nw6YzeVeqRayXmEyN3Uuw2MRW2EOeSJMqNgwFBKKTxR58plj7v0hXnMQb0LF
	G6zktttAC/bB29ZWiwKtHq7ZiL4GCw+PeHv5/EQeoKAqrizhqoPN3bmB7gYJZVhL
	ohSFKzl35q+13eYcmc5Hhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767105178; x=
	1767191578; bh=3ipXhgK8hKfjII7NqsKjHwoZFxvkylZRHbE+XPkMVec=; b=O
	WWkghQBHjeO8w3FhGryUTeJEP8m6xbP/AMLGt9e5Bb+gBlq5pGTFKXpGezzxyCPr
	n0RqYYZLL7OPV5s76x3lSK63/1UaKv/lzp6F79j8kqlpzbOSfh9ZlsKKCPPAOeju
	9vhZPFM32nHJzv6HUGnzTYP7h/qUDPSwl/HkVUryLlqplD9VQUGf8ZL/ZGQ8ss+3
	gKOkKsX0eDHxZsKlXgS9qZoy7Ykhm1Ml1KkiRQ2CmzFAhVPhng/EqVsCRI6ni/Dd
	+kxxOFpudRUnJtCCKx7HmMDPoKWcLw+hQJpjTODd0T2uSqGOXXYuxwYywgHvSnuR
	ImQcFgz7zcBVOReIfAv5w==
X-ME-Sender: <xms:muJTac5VCukPJDflQLX6IOEpqmDo5_ZlQJkdp5QQgLFvqMW6XzUHa-g>
    <xme:muJTaYtw9BupDPxXGoGmjmK0ko9AZ7bDxmrsdHOBjK43Ip1Pco8aGaOxR-8BXqyAT
    FPdkAY1VWf7gOj4UymZw8_kiNIkfuKTQSXULWZtq6XdEjhDX-Aa1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepjedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhkpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:muJTaajm-flx202sK-KT2vf_gJtyqbUGhJlFUTx2Yf3TLUIywLBRYg>
    <xmx:muJTaVGFz5laoy6xOwHsjaCpDVJeuaotvqrLeX4LHshwyh07Se45ig>
    <xmx:muJTaR_lqIc_Q9Hus39z8b4lUSszpXRYTYsqZBAm4LLBUMGRqCn_Hg>
    <xmx:muJTaUxjwCmuWPNkzRRyUkFmhV9eADV1TbHohQrki91BbSQxeDIJAA>
    <xmx:muJTadCpjVRpx3pXcjLLfF2e7044w4JhtiDLrq5rVq5Fx_Mqp9GgOyKk>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 16EAD1EA0066; Tue, 30 Dec 2025 09:32:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AkV22KuyfT4B
Date: Tue, 30 Dec 2025 15:30:14 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Christian Couder" <christian.couder@gmail.com>,
 "Elijah Newren" <newren@gmail.com>,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>
Message-Id: <0377eefd-ae66-4501-84ac-ca2fb8b0cdbe@app.fastmail.com>
In-Reply-To: <a5822145-5a5c-4a2b-84b9-7c061b3bab97@gmail.com>
References: <CV_replay_die_descr.13f@msgid.xyz>
 <replay_die_descr.140@msgid.xyz> <xmqqikdxriw3.fsf@gitster.g>
 <a5822145-5a5c-4a2b-84b9-7c061b3bab97@gmail.com>
Subject: Re: [PATCH 1/2] replay: die descriptively when invalid commit-ish
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025, at 11:52, Phillip Wood wrote:
> On 23/12/2025 03:12, Junio C Hamano wrote:
>> kristofferhaugsbakk@fastmail.com writes:
>>
>> How many callers use this function?  I am wondering if it is better
>> to give a better message at the caller(s), rather than here, where
>> we lack context to tell something like "You gave string 'ource' as
>> the argument to the '--onto' option, but 'ource' does not name any
>> commit" (in other words, "for what our caller is trying to peel
>> <name> to a commit").
>
> There are only two callers so I think that is a good idea. If you give
> an invalid commit name to "--advance" then it dies with
>
>      fatal: argument to --advance must be a reference
>
> so arguably we only need to check the return value when parsing "--ont=
o"

Well spotted. My change would give a worse error message
for `--advance`.

I=E2=80=99ve made the move-line change that Junio suggested in version 2.

Thanks.
