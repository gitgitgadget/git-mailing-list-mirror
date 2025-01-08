Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA25C1FF1A0
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352943; cv=none; b=shncxjNOX/N9sfRK7vWdseMwfksSW2rAKBgc4L9idYtTBrQ6qq3jCEXdvmzEhwqE3nLnI3PFN8YkanH4MKbOWvUI8B0h9SYzpWVnDSHTJrsPJq3ulN94aPG8iSenw4U/k5ulXjzyxqBZPaurhV3LD+uOD5Fa4inhAY2KH7xwpYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352943; c=relaxed/simple;
	bh=LTr9lQGuzi4JuVmDW2VXvkJDZskfVM2E2Sn++Oyhrvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAvyOiY4LeH1JIEYaecYhL4HxO3kZi4qCauM8hfoDgzdx7+VaGtS9GL6n6+rOXSNyQ+kiGKXjGH1p5BZfBsvU/a3R/8CUJP1L57NVAPIiNwzhaT7SZJPDCf/zgA103nsMmZsLX6S4kRzAPoZzIBXw0eVOD9ZE95ORmOX4v+Ojho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dd8sGmbM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vTnR48FQ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dd8sGmbM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vTnR48FQ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 06BAE13802B2;
	Wed,  8 Jan 2025 11:15:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 08 Jan 2025 11:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736352941; x=1736439341; bh=v7T0cNLOIk
	ObThrA267qZeODHh8uLex8VtEJoEx0ysw=; b=Dd8sGmbMyK/fNG7lQhcy5ktlpT
	K81IWnkBXCtds4XdNOYRzCi9R88nv0bp8DUbXgGfWcxeotqH0qQ9RFeln0nJrd2E
	uafQDGgBuZcTJEkxwh0pHVALmGqwcMQgv7CiMVRZ+i2FuRmcjbv2l5HxLk19HXs2
	cdvR3w/T2KIfZ4eqjZZ0LkQTGYQ91rldO1YN9sDZt3yRydGRCn8KujC4Fwah9oLj
	5rI2HHDVdxq5IaSV38gbci1sAYXnNnKuqTXUNSVPE3MzVSwBQB3ItbGxt3kDkcVe
	O49lgQs5eFJHh646CztxBcEgmXguOqTZwxSpWeE8Qofy1IgmBDJ5309AY4Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736352941; x=1736439341; bh=v7T0cNLOIkObThrA267qZeODHh8uLex8VtE
	JoEx0ysw=; b=vTnR48FQbGyhYVKtAcYEFB8AKk3fFvg9LJK/lABdkmrDxVIDo1b
	/V7TqBCvB9BjulC9p7hGZo/G4VuxbXxUV4btDKhSIT6b2NIxKsXgqsZK8yKJ+ksQ
	MSYhh5JFKrWWHie0+4cZ0lmvXxO6Jn9OcRP18L1QX/zi+toX7/5A15CVBQBBWBqL
	/UBBhrF70IpXLiYgZjfZKczkeCdBd+VG5vc4oDBjyTmLulJqWTVDkhw5AamW73JN
	hUhb0HePWaOZWhGNB6khmqwl4I9wDU6qbe/cu52GL4FEPPGkHCDJlprxRPue5A/Q
	Y/A28fHlRaosTsEe/c4REMZGZQ4RfySXgZQ==
X-ME-Sender: <xms:rKR-ZwpfttIncOtcLsNLBcS22z0RhyDXB20nH-IDoRrZFlo3X84M3w>
    <xme:rKR-Z2qPNyKEFX2M05HsCGcqwEFtsjiSPao5hRo4QSHwWLH_UgzHkdZcBm8CftW7A
    Mx_uoTA82JDQ7WAHQ>
X-ME-Received: <xmr:rKR-Z1OkmZVWXa1l8qAt9-kE32XUhpiBtMYQaU_UgxA78lWKGOkoRWf3329RXvtAoy65LCyuEBkbe4c28LgMX7Ymxjx3ZR7dy0Gut2l6S6BVww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rKR-Z371dHdua5Jrcd6ljZAeJbw47_8bI93bRHv7H7mn6RAC89wBDg>
    <xmx:rKR-Z_5-x8HclUXveW136XUTueIEf4PnhpMALT23FR8w3Va69zrkNA>
    <xmx:rKR-Z3jiF5W8S-ulhDHxgwrvuTBSC05Ucb69UtnuJGg7Wrs5dF6ZnA>
    <xmx:rKR-Z57O4Dme6cHdD28QvuatIwnoKbKYJALNkdbNNxzaqX90OVEXhA>
    <xmx:rKR-Zy1TFmpYRmXuUt1tyyhjFmY-znOHMwCUcz96RlItwLveffdXWHht>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 11:15:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d4820851 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jan 2025 16:15:38 +0000 (UTC)
Date: Wed, 8 Jan 2025 17:15:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] t/unit-tests: match functions signature with
 trailing code
Message-ID: <Z36kqlcKl20AkJvW@pks.im>
References: <20250107091932.126673-1-kuforiji98@gmail.com>
 <20250107091932.126673-2-kuforiji98@gmail.com>
 <xmqq7c76trpa.fsf@gitster.g>
 <Z34XvPjhY15MFHrT@pks.im>
 <xmqqcygxpbpy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcygxpbpy.fsf@gitster.g>

On Wed, Jan 08, 2025 at 07:27:37AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > So I agree with you, let's scrap the idea and have proper function
> > bodies instead.
> 
> Yup, sometimes, simple, stupid, and good enough is the way to go.
> 
> We could do
> 
> -- >8 --
> 
> #define T(testname, input, expect1, expect256) \
> 	void test_hash__ ## testname(void) \
> 	{ \
> 		const char *expect[] = { expect1, expect256 }; \
> 		check_hash_data(input, strlen(input), expect); \
> 	} extern void test_hash__ ## testname()
> 
> T(empty_string, "", "da39...", "e3b0c4...");
> T(single_character, "a", "86f7e4...", "ca97811...");
> 
> -- 8< --
> 
> which may not upset syntax-aware editors too much.
> 
> Unless there are more than several dozens of them, I do not think it
> is worth it, though ;-)

Agreed, I'd go with the simple solution for now, which is to have
function bodies.

Patrick
