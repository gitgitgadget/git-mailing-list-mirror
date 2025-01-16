Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970622AE75
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035871; cv=none; b=fKmogBCGbOhPkEp/iwly5iyt9AbO90Lpx9PWerCxll8n2AzcZCWQ7tbhhe1S5juFztu5Xj9p0wEP2oydIF0P5fd+8j8swSwbrQ70DeHyHLgEj1tkL5T4iQAvrel8sppOgfNwTOr96aw7AS0aoZm4ZonOdDCQ0FYxLAUwdPucfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035871; c=relaxed/simple;
	bh=rSAdPTNXE0K1Aw88VDksoVmWBs8TYA9XhBfS0m7Ph2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXEFCVMyPTSj74dOUBWE3FY/Tyw10msWWhYvnDmB92yMpFEIbFbg3TNf8s9U/WnQKQ60pwtAKLPvJKT44HhgLTpYdePI/SkHdiA6VLpSsZ/v96sTP31GGZ31dDngjZ8xpXIM2ndUFTJu3J6eIaBsCsV5uvk0f35mjycx+ISmioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qr0AuuFs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XK9fy0W0; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qr0AuuFs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XK9fy0W0"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A7571114016C;
	Thu, 16 Jan 2025 08:57:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 16 Jan 2025 08:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737035868; x=1737122268; bh=uDHS9HUc6b
	g0kIemtOfijRzgU2R9ADEWBnohZDJHe6Y=; b=qr0AuuFsl3Cwa8aDbZxxDqi+IO
	f6cVazxp3Uswz6Pr7s+44z9BSAUblzM/pshNnqKmLu82Xs4+fBIToolMzIK8g2Xw
	r5jUAgzqWyC5i4M9wr/F3EX7AuJDczsVRWmfDe3SN1ZZ0uysxdpznkoM+r0WDt7k
	btGFblnPjX27fsZcVCUbV0BwWBt/qhaVZO8TlpwHoHbv5Zi1R8h87rTlxOM1hQze
	ER6AaMCcubnZLCtLSTwZCGWf5hUdWemJkwb/rFXqd7tjPmoQDYaqIHnuadLOobGb
	GmRjvhUV2XBRQXGHwz8Cbzvh6Xa758TEgVz7yju0KFdS8PpCyyDIWQGppG/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737035868; x=1737122268; bh=uDHS9HUc6bg0kIemtOfijRzgU2R9ADEWBno
	hZDJHe6Y=; b=XK9fy0W0To51oaRcrcbyQujYdBdrVDH3a/SypQwF0IPhJ0Yrf2u
	ByBvc6JRB34TIZ4Vb2MaIbunlBzyNi1OJUtjK6/w8zGnRqWQcIbA1iR1zbYD0toW
	25fU/n3jAkitUiMZobHHPR1XGZ0exyvVsHj0xsyG109w5LhczuFu5G4vV+2aj3C+
	XOpXnk5vUmKjRTuL/mDlA4z/XLT2eA4y08FoML2GJwrM9Kai5pXLi/pvOWtvpxJA
	/axOktgd5fpB4jwvKIm+XeeST2bGEE175CtPRQYPnAyt+AtnNhIeO/PIiqXoSyWq
	10SE44basiDkRp4j4mRIQyVSsURDG5FbAsw==
X-ME-Sender: <xms:XBCJZ9iMOz38vV5cICAbGW-LpxtTZPQlyKtc1unwAsEVHkftZFr90g>
    <xme:XBCJZyAk-wHvI_3lLqbko29xCJiCtG1ao6Y0DPLWqdGckq7rxxhNPQQ2NPg-OpSq7
    wMHcU6nuUyyaWYRXg>
X-ME-Received: <xmr:XBCJZ9F5Q393iy16yyggiNjOwMZhjS9VwAtDe28GKCNVnRmo-lM--4XkiTvyiRAzqEseQ-OXfBJwxDk6Uphy-KDgvfRkc1OnOXWmDVXbUCMeVzMktg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    mhhhrghgghgvrhesrghluhhmrdhmihhtrdgvughupdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:XBCJZyQQvJ4hTr5iK-wthIM_oC5n6w_hDX9fTmgJnPMU2t8wkU4oNQ>
    <xmx:XBCJZ6z7BuKJwYsbonqWVSuIiapUocGPuuaeifpJLP7M0LzfqE9x4Q>
    <xmx:XBCJZ45MjC7TSmuTyp3xEUG5eQBhqPt1gHUfUV9CX2D3V-DnVn_nhw>
    <xmx:XBCJZ_y9CQjk80w_bBeiK6dtQK9sfJCK-l79Zp11R1ZkcO7lyrBgdg>
    <xmx:XBCJZxrIk5AlahjEZ9Cd9APIQCwNC453rdcb4jGuLpO0N0ZaouQl5RGE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 08:57:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 348dc613 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 13:57:47 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:57:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 07/10] packed-backend: create "fsck_packed_ref_entry" to
 store parsing info
Message-ID: <Z4kQWgYXePBDthsl@pks.im>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qOEvyeoc7vOW73@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qOEvyeoc7vOW73@ArchLinux>

On Sun, Jan 05, 2025 at 09:50:10PM +0800, shejialuo wrote:
> We have already check whether the oid hash is correct by using
> `parse_oid_hex_algop`. However, we doesn't check whether the object
> exists. It may seem that we could do this when we are parsing the raw
> "packed-refs" file. But this is impossible. Let's analysis why.
> 
> We will use "parse_object" function to get the "struct object". However,
> this function will eventually call the "create_snapshot" and
> "next_record" function in "packed-backend.c". If there is anything
> wrong, it will die the program. And we don't want to die the program
> during the check.
> 
> So, we should store the information in the parsing process. And if there
> is nothing wrong in the parsing process, we could continue to check
> things. So, create "fsck_packed_ref_entry" to do this.

This step can be avoided if we made the check generic.

Patrick
