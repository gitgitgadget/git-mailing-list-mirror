Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2225A2D6E5B
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 23:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903304; cv=none; b=c7CsTVFMPm9Y+16vm07mPNaQ63JXXGQ2rwJqTifzYSpXw6bp9aJpa6ELDNa49OvpareLSBzWKu0sbQoGyGqT1ecMS0Juix1cJdDQMTUk0eXbSQ54MX4HKg4re89subn4noCT+6LNyIDLC4wVgH82MCmVl0PYz3kVHM+195+zmmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903304; c=relaxed/simple;
	bh=MSX/nR8VKkZQH+gIvwC1pvvAHmz9sfNUbbK7wXv6S+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BZrD5OS/nlLLCJ4oPB7uGnsntHAvsKzEz37NRhrofrf2/ycegy1X6RW0F/qW0XMcDa2CM5DomFQZlwVy/EFq2h1Jt01nrzxFCEaAHb9uEg9UOnt1Xyu9eLAZwJUGjx4G9/JX3s0Nj19+zt/fCHHydREqoKke0JB74KjJOSLGOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PA9VrARa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gBmI8XEE; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PA9VrARa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gBmI8XEE"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 1D9B81D0012F;
	Tue, 11 Nov 2025 18:21:41 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Tue, 11 Nov 2025 18:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762903300; x=1762989700; bh=H4d+K07W+I
	tq6CO+EMr4Ofx1o431+pUTe/qJVdEHSM4=; b=PA9VrARawxybxJ9As5dryCp8MJ
	EzQLPh7Q5HUYTKXEcnW06WqOqFzqDkoUGz8LPfL2437DpjoFeQ7mR1CVvZIolD6Y
	ELQjfC+Nnh9We2q+pbEMvsUc5uDzZN87Cddh5f5Ix8uhArpHSRUB4Da6BgWVvGsE
	CKRuXVESU3FmAdhI7fu8htURr3ItIU8VHCORj2yRp70//j6nNIYHaZPcy6x9OwLB
	zQRIUlnJ15LjJcmHQ3L0WEKdtXcE1tGMlpRtmkFiI7tyJqqgxTzY+XP7Qfr1dJD0
	UJsmT74lAoUpFF9UaKHwGihhqw8Ryc+Kg4BFIR2V/Fcsi+hqcs3BT9miOMSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762903300; x=1762989700; bh=H4d+K07W+Itq6CO+EMr4Ofx1o431+pUTe/q
	JVdEHSM4=; b=gBmI8XEE3PA14N2hquiJ2oSONlAx7C4sOqFEnqXwfJxbp/LSO8A
	mnr8kDfD0s9+HVOVbsQD8AvodxA0VzqDBZbJRp2XpU1vAJdbxplUbmnA0jST9+yM
	S7m+mkyHfUWQN9ef2akNvMGGaYBmoqw3toN5BN2SEtqtMzkOKWlI4/XgYi1CAEEg
	QDsf5KCa63IxY2OCQYdWip32KGV9gvnKLPlV+XCFsb044LCBaYeutdI/0UEPyP4v
	xbzfXozFR+ITY0zJpKiJJLIuzpDCQa5xsE+L5G0tpeAYg2So6Wu0l97EAIpLQ0Ab
	QHeYWduoHW35lN8QzquUbYIYIQ2hVKOBVqg==
X-ME-Sender: <xms:BMUTaVVEL0vo_woBLRzYqeWSwyvNwq1pI3JTRw_igA-ep7Cmxm0qIA>
    <xme:BMUTaUpxSb3GSWxp_ooDvxYBZgHdIS7-yaCQV1tg1Nm15qH7XKP4OKuwhnBuP4gI8
    pn2L56q_Hy9u8C6YvrqPKMDDYJTv6BjWOA1_uwG9HmETliStjU>
X-ME-Received: <xmr:BMUTaXl20sNtAoO5M12jM263QcP2Bq3e1X5JDtVi2dSkaGXa6XuZm3kyj8P1KvaOp2vJrtn18m4wVxfk5hCMja1-5KmsJS08_ovg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddvgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    uddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BMUTaU1FghE7P1G7_1A7KMfF59Nvid4R-AdcJ17LUcXpn-Te2GDpug>
    <xmx:BMUTaUQ-9U99uSZp2mbPWWhoqG0XIsSqAwDbVBRMAll9791eTnTcPA>
    <xmx:BMUTadyYxKCHdTeVxo_pyUt2xyE9f9-HQpTznLPKIcpxQBr9yY2tlg>
    <xmx:BMUTaUAOnkrGB9eFaR_XaiJb74piHUpBr-9lzXGd6zA7X_AIzfGF7g>
    <xmx:BMUTabbDcjj7fmVdRcCU5c5aQxJVJZMfuV6H1B75GOO0CIEUB1oGs5Kp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 18:21:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Phillip Wood <phillip.wood123@gmail.com>,  Chris Torek
 <chris.torek@gmail.com>,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 06/10] xdiff: split xrecord_t.ha into line_hash and
 minimal_perfect_hash
In-Reply-To: <3834ea8f9becc9d6e1b407679e8a95dc6c9d56de.1762890152.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Tue, 11 Nov 2025
	19:42:28 +0000")
References: <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
	<pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
	<3834ea8f9becc9d6e1b407679e8a95dc6c9d56de.1762890152.git.gitgitgadget@gmail.com>
Date: Tue, 11 Nov 2025 15:21:39 -0800
Message-ID: <xmqqwm3wtat8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> To make this clearer, the old ha field has been split:
>   * line_hash: a straightforward hash of a line, independent of any
>     external context. Its type is uint64_t, as it comes from a fixed
>     width hash function.
>   * minimal_perfect_hash: Not a new concept, but now a separate
>     field. It comes from the classifier's general-purpose hash table,
>     which assigns each line a unique and minimal hash across the two
>     files. A size_t is used here because it's meant to be used to
>     index an array. This also this avoids ` as usize` casts on the Rust
>     side when using it to index a slice.

How much extra memory pressure does this change cause?  In a single
instance of xrecord_t, we used to have a single ulong plus a pointer
and a size_t; now we replaced the single ulong with two 8-byte words,
so 33% more memory per record, which is not so huge a deal?

>  static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t *rec) {
> -	long hi;
> +	size_t hi;
>  	xdlclass_t *rcrec;
>  
> -	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
> +	hi = XDL_HASHLONG(rec->line_hash, cf->hbits);

Very nice that we can lose these random-looking casts.

> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
> index 88b1fe4649..742b81bf3b 100644
> --- a/xdiff/xtypes.h
> +++ b/xdiff/xtypes.h
> @@ -41,7 +41,8 @@ typedef struct s_chastore {
>  typedef struct s_xrecord {
>  	uint8_t const *ptr;
>  	size_t size;
> -	unsigned long ha;
> +	uint64_t line_hash;
> +	size_t minimal_perfect_hash;
>  } xrecord_t;
>  
>  typedef struct s_xdfile {
