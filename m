Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D35C2798F5
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907356; cv=none; b=sVToLmJYd9WGGeGPRmukrq8kZBGdjahqGG++398i69lxhTnQIzrX0KMkRIcw8IgpWgCJcv1MranydahVmSy52bcYjsa8Bl5mKGBh/Djv/98fEeULi6D70Nb9+8tJzDkQlggQ6WsN8EKub9Zb3jlPeqBcJaUowUc4lwcfXoGntGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907356; c=relaxed/simple;
	bh=9Ncq5vJTYnF6rZ+3h5j3MPO+gqtwP4/ZWpvax+w+Uno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBoqVVHccLDNbtUH1g9VXUjHTV7BQU5D/qwB0fWKnm/EaUroVsd1g0i45CyzQ2TkfoRcN8UhYI90roCgjnhP251Z85+T5kP1Kt5udBJf/jQxUrCivd7Xh99NGlSyJVOfk+KUH9Nwi2iHLL8gR7oBmVQRUA6b+KI+Qgen1uHaMf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cRoUouBY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sk2LKVY8; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cRoUouBY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sk2LKVY8"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6436513801CB;
	Tue, 29 Apr 2025 02:15:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 29 Apr 2025 02:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745907353; x=1745993753; bh=6F0Xbxv1Ve
	8G+Is4RtQYhdyr+6/OaO5Z6xGgFd+a/LU=; b=cRoUouBYawK/aPaa0hCXv7sA7X
	eXGHeN1TZRUK29od5gb0vgMU1knud+yuqlxqbwz/tmk2bK6IFZH21q4XNTOPLXqM
	9NvtYE4NZ+1YgSMDDF9ly98aC/szA54RpNcQWbf8t2sLssRH82ca+IUOEgmjmpTH
	j2kc5OiW7Kc/4GG6uXKZPMoDkQqS+4ct2pvFh8bNKM87OZprpFehcrNJLSknuaxW
	90BNDn/vC3Ucdvc1wqAqK2HudW+BO03uJk9xdOddelRVblAUL9RDld1L0vm48aFF
	Mpj37cfj94pVC807UoBrDP68lt0+XV1ywjKkhTaCM6KquF0FHV89+P/PA+YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745907353; x=1745993753; bh=6F0Xbxv1Ve8G+Is4RtQYhdyr+6/OaO5Z6xG
	gFd+a/LU=; b=sk2LKVY8Yych84F0qNxJ9i69ED1FNULwnPEFb/HiNo8EsULi6zu
	IunTioVQ3mnSJWU2uSW110zZ71iAKLnrvZ631ulyGJTS7t2ARC3UxCn/oRtHEZlB
	HhrJ5mKXNCx50oJy3JBvLUOyG+rRI6U/3qVZPC3swZoVL12p84K3DemKgPt0gusy
	k69R1LVg3N6aM7cVLqexc/0J96kixMGGHIz7Tb9mDVFhHtUkA2Xn4M69eCOA+AEO
	Z23G6n4Y2niR27vuQyIeU9d72ZetjImPiaEMMW7CDXHZXpB1zGqZYI78GaLj55mv
	CUz8iPAEPknDWzH8jaKCCdDdlD6e892Y0xw==
X-ME-Sender: <xms:mW4QaCcMR1M7BWO175RSYr3QwlSogyZhtPFTsib2NEk5jX_VYnE-lg>
    <xme:mW4QaMNSFZjmhIniit-DwU0AW4wyHReoZR63DftJZG7JgtXs3AefEVgaaOl-9EN8A
    sgGOPNdhjOGTOoqjg>
X-ME-Received: <xmr:mW4QaDjHk0YbMSeW-dpQz7V__d5dTNP0oHAGuyF1Xj_gK2tWVbaNGZopOIKixheixENzKRIcSLWJn4NCpx7N23uGw5QBqeXRT2Ioq6wdrRI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeftdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudel
    ueelgfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mW4QaP-Oa05uLg5PZm1g3eQU8lv4wljQHEE_uqtZNRMROO9bJ1oX9Q>
    <xmx:mW4QaOvAnDeQQ_j7tkVkPh53YzjmtTGNUE1ivVcn_3QCtM9qunN1-A>
    <xmx:mW4QaGHim6bod8VE3snJtrvZ_GlUjtJrLzJcdYXJszT_QIQ4Lm9ykw>
    <xmx:mW4QaNMazD_VQWR45v99alPh6CtiQjiZYYcUVsRPppVURDLhnWmZAw>
    <xmx:mW4QaD6wF1TPs4oRG8V1kumCdJPAYw5jmtFBZGQ9c51uBW46SEwyc3GP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 02:15:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 98a4c70f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Apr 2025 06:15:46 +0000 (UTC)
Date: Tue, 29 Apr 2025 08:15:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 12/13] bulk-checkin: don't fetch promised objects on
 write
Message-ID: <aBBukgbWZRRLgnLl@pks.im>
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
 <20250425-pks-object-store-cleanups-v2-12-63f1695b7700@pks.im>
 <xmqqikmo9bzc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqikmo9bzc.fsf@gitster.g>

On Mon, Apr 28, 2025 at 03:07:19PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In an ideal world, we would protect against this by fetching the
> > promised object and then performing a collision check. But this feels
> > exceedingly expensive and ultimately rather pointless, as more common
> > writing paths like `write_loose_object()` don't protect against this
> > scenario either.
> 
> When writing loose object, wouldn't collision check kick in, and
> didn't we compare "existing (not here but virtually here due to
> promisor)" object and what write_loose_object() tried to create, at
> least before this series which may (or may not; I lost track) have
> disabled that check?
> 
> I think the overall goal of deprecating the function with long name
> with another function with a short-and-sweet name with different
> default is a worthy thing, and while I do agree with "as we are
> replacing function with another with different default, we need to
> pass different flags to keep the same behaviour" early parts of the
> series, I am not sure about these latter steps.

Yeah, to be honest I wasn't totally sure whether to include these steps
myself as I anticipated that they will lead to discussions that derail
my original goal, which is to clean up the interfaces in the object
subsystem. I decided to go with these where I thought that my train of
thought is reasonable, but given your comments I'll probably just drop
those patches.

We can still adapt these callsites in the future as needed.

Patrick
