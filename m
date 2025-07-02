Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968AEEBA
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 02:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751423030; cv=none; b=fHuIhj54dQoSuswwWQCWD0NahFHOfjwszI+aRBLq0tEO2dA8N//2sMyUwOQjc2gfdp1QU/hA7aNGdMtT5vBt2ld1d7JnpwM2Bg4m6Tsc47KMUvh2VG6sCIZOhWwt6OBWHXJh2BLAxIazHmoRGQYmNlNMS6x8bs+cm0Aou70ENM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751423030; c=relaxed/simple;
	bh=Mx63AlK03xr9BuoeMpeBxH+JtF8D8hxmlmGgdw9GM7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cud7vsvQuYLkOCqf9to5vQ9UPBn+n9cuc1dQcTBEOZbNyyufTglwb1lXH8h/0KUGB7VcNixU+K73ZwnQmrN84SC0BJoEPxc05AbdJLy8ibJ++jFbtkF49YBtifYbyKmSi3uT+amIHT9c6ZiWyrHQFX85BF+eIBDJOltqyjdUUxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JB8mdDJc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TXXMooo5; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JB8mdDJc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TXXMooo5"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C890814000A2;
	Tue,  1 Jul 2025 22:23:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 01 Jul 2025 22:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751423026;
	 x=1751509426; bh=HlhzNCQhCq2MCEv05TDxl5ms+mnufMfUBAb8XxpIuqU=; b=
	JB8mdDJcgH/oT6NDyxFaB1B0RShMheleeECJ+0HBsxffTsFOvI6RmVqkaG+JS+qn
	dd8if51e2DIe6EzikNrKFHesByMIJ7DynAne5AlArP0zQhYYksttcT4bN1Bg8TG3
	uU4cZjdb6llnBY/5IQBaMfkwo1AbkaN6qGEadL53FvOXp5VYNtlhQ7JVUnq4vr5Z
	uqPbydUa/Tw8MQJbmiFN6KX9hmlDOpiZpwpve9oFi5dyORqw/f8q3iNBZnRjGYm+
	0Sc5nwQ5b2G0LscORX7hBIYmZ0a8PlQxQUhryDxdBGvmpTuAsnbdc9H+DSRg/kzv
	wchDA5QDR670fVdgaN2UKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751423026; x=
	1751509426; bh=HlhzNCQhCq2MCEv05TDxl5ms+mnufMfUBAb8XxpIuqU=; b=T
	XXMooo5C/sON3SPg/N1n6WBZMHaeYfooZTG+fFnZVIpG9dIfH4eqzBrQPDSKde+C
	IdByxrxOxJDSr2Gtjfq6sme51LUnMncsAl8OpnTiy9w3o9ShWubwIj6PKHeW19Qn
	w51fWS1ZVYHX0PoJhS3WJWSUgWhv6KlZWiEqPbj0tfBuDtwtQpP3VRCd1Dq3o8sY
	iYW9rfK4UI8qh9vErey1IfJhRW3bi3kq80XZyEXqz519BJpJpOZJgIyk0D3aTtIx
	NCbvGnRZsYHNhK4ktykwRz8mAwmpQL4YJdYd9xcbM3jwlHpH28zD0J4sley5jPMs
	7H9W5Wq4T2Vb5l7urGHqQ==
X-ME-Sender: <xms:MphkaMLV9oNl2__Qam6jIjPt0_yZHXMR5RJTc1q0p8lPv0P1ZRMBuw>
    <xme:MphkaMJr84ZLY41sBRoBShTkRbfEDCne51NXXquDhsXaTeknu4BmiLPCWIKkjT9nd
    7WfcD8Cr135itkkug>
X-ME-Received: <xmr:MphkaMuFrbL9153mlTJ0KLnnUvVKrqcs92FZNfpWNqP4f6ud_ewRUw-N9431BSRkSL9vUQtWzmyWBhkyyICWmkjhShB21ddVgogUIGXfXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekrodttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epudetheffgeeutdefvefgteehhfegveffffdtveeiffejleeuteekteeujeegkeevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehshhihrghmthhhrghk
    khgrrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:MphkaJbFHaAcb_e-a7EH-GIus3w3wj65UJYcC81mgha1Y50qt8pCNA>
    <xmx:MphkaDapvWLc1OXOT2oRc8z5fsW3D9xwbw4iCWe9WXjMvP3t73B4Dw>
    <xmx:MphkaFAsdsNNq5EVbsZqdYoG3LBvg77khCO3_Re1qTugaqkNvj40mw>
    <xmx:MphkaJZPfhENeU16KA3FbdBXQn0c-66UptJKdcGYQckGbHVlzAeO3A>
    <xmx:MphkaHmzqR9YC4TaIM88MZwPi_HSpnGtBjzJSw2Bt-eeldTq8Z9i2xFQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 22:23:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f4e9114 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 2 Jul 2025 02:23:44 +0000 (UTC)
Date: Wed, 2 Jul 2025 04:23:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, christian.couder@gmail.com,
	git@vger.kernel.org, shyamthakkar001@gmail.com, shejialuo@gmail.com
Subject: Re: [GSOC PATCH v2 2/2] builtin/prune: stop depending on
 'the_repository'
Message-ID: <aGSYLJaqDziLqtXk@pks.im>
References: <cover.1751296633.git.ayu.chandekar@gmail.com>
 <f70de9d549f2cb744810df7a9ee09e0b3626e62a.1751296633.git.ayu.chandekar@gmail.com>
 <aGPcKgR0G72JRSlM@pks.im>
 <xmqqikkbkglx.fsf@gitster.g>
 <CAE7as+YtmRxD3P-T4bzccgJnd0Ocj0kdW00g-=3gtdoWhTRVeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE7as+YtmRxD3P-T4bzccgJnd0Ocj0kdW00g-=3gtdoWhTRVeA@mail.gmail.com>

On Tue, Jul 01, 2025 at 11:39:48PM +0530, Ayush Chandekar wrote:
> On Tue, Jul 1, 2025 at 10:12 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > On Mon, Jun 30, 2025 at 10:11:05PM +0530, Ayush Chandekar wrote:
> > >> @@ -173,20 +171,19 @@ int cmd_prune(int argc,
> > >>      expire = TIME_MAX;
> > >>      save_commit_buffer = 0;
> > >>      disable_replace_refs();
> > >> -    repo_init_revisions(the_repository, &revs, prefix);
> > >> +    repo_init_revisions(repo, &revs, prefix);
> > >
> > > Does this work correctly when running outside of a repository? In
> > > general `cmd_prune()` is not executed and would instead die as it is
> > > declared as `RUN_SETUP`, without the `_GENTLY` suffix. But when the user
> > > asks for help we may still execute the function with a NULL pointer.
> >
> > Good eyes.  "git prune -h" would safely exit in parse_options() in
> > such a case, but this part happens before the parse_options() call.
> >
> 
> Thanks for pointing that out, Patrick. Right now, `parse_options()` is
> called just after the `repo_init_revisions()`. I can move the call to
> it before this.
> 
> Although when I tried running "git prune -h", it still gave me the
> expected output.

Well, as long as it works and as long as we have a test somewhere that
ensures it keeps working I'm happy.

Patrick
