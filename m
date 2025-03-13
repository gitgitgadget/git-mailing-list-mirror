Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941186353
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741877114; cv=none; b=o0pEGhwjNbykvXT3gtfvZAw3rHNorJ36vaiXobUTQYaFNzkBBpNg/SFT0VYs1XaBDrh3pDIVmM9l13Q+qLKPfvJiK/Ay/7zxaC0zhexSdBmeqxn+22BpE1BOa+yGuXdKUA9/Uv+REdz0TKK9mu9CnPIx9BnAcx0j0Z43ArhQozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741877114; c=relaxed/simple;
	bh=WA6U8ZmjCUtexO65jPMDo984Nc0/v5lcYvJhOr4+u94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X92U9iclswTnLH9UF6jbGISsQwn+ZGVpT6r8Pb+6c06yQSbrqni+XUpOzTH1fdAiW61AOxAPyBvheHtukpYvrFe0CdR4chpOGXDeRSW3KUcKLEDSFBZYxH/byDIEpUQdbPEP3eFsxvPiGfsOjMJR3r4rFwFkPGfBlEnMElgE46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J2JVZski; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HFYmTFmM; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J2JVZski";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HFYmTFmM"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB2831140253;
	Thu, 13 Mar 2025 10:45:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 13 Mar 2025 10:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741877111; x=1741963511; bh=UgQP3u+hBJ
	GKLEbQ5dh/Cs1+rrl/7rKZ5lt21oCKM/U=; b=J2JVZskiygwdro+C6uHBYGMrfl
	vHCG5GHP/rgGmafAeWCHpifS/D4SHowfXPtQax6d7TuvzixkEX509i5e5abjrOMO
	79MdTxyUkHYcVZdLL+T2Ks8t6bzIBzzrw0oGuU76GEsdGSfapxDX3pkj0f7j/sha
	AGA+YAp0P6hyQbtMFHl3h9LQlVojzZ6tduWAqIIZVAnjtblBDjiUwWWyAUlafHKV
	wxK1hwekiGfw7KW400zLEtkgdTJp/bKH5d9zvDG6QGNTJj+Ny+JRwB3ksW6hEmBQ
	VqJO2lkIT3Q+eI+taMYnrJo7VUfoTKZiPeImDHrubCGVYpoexuDY0glgFLbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741877111; x=1741963511; bh=UgQP3u+hBJGKLEbQ5dh/Cs1+rrl/7rKZ5lt
	21oCKM/U=; b=HFYmTFmM6fu4BF70XJUPnXlPuiSLw838K6y+IRYBI55Wj0TqJGE
	kIm9+fK8gsxxLMDcPeWzZ+rcqzZRJk6QFcWzG3ETbZ1NK3kgG1inZcMV2SidiE9L
	OOQNmUOp5exViOLzjZvJaax3URkySqSvpNeTfqc2DyUwCwo3AMwb/oxq6pR8FSj7
	HoU2RK+2AvUuRyRqN/U7AssCeFPtT/hgbQ55PvQEBQZLJXyoVRLFZfcuByrl6hXF
	ONnzxq7VoqTGuz7Zy1dD94reUs9D5vGG9KyZP5i0Cwo7J0X3uXNCifxwqsGd1Qbq
	mVn0IvCupLGvhwboBR/NiFQ4nA4kWm++F4Q==
X-ME-Sender: <xms:d-_SZ2TVxsZ90JZpWP2Nkw7c6nWt9OkOW5dXQTPCi5KrmgRhuPXzRg>
    <xme:d-_SZ7zPhv5gfy7yDb_t4-zLf36eQEkEX4g_6wt9IbVi8iD6PwhDHgT8b1EPE-cnp
    0CIwOr32thTfzeheQ>
X-ME-Received: <xmr:d-_SZz2zuf5tMZQpE7aciLIg8-78LJsZFb58nDnpu9Z4kBwdhjEFv_AMY8-ftrmnSEh_lf9iwY02PuS0M1YSQTxazO1KeozUg2VWpfs74CI7K6y2UA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:d-_SZyCLObPsbNV0zNoZAoS6FdfC7XEYBgLTBFL6PRvXXW5bVfE4FA>
    <xmx:d-_SZ_jAQkAw4xlFqVvuO-FlDiabSbnxna3iVjZTjEm0ucDZZz9aCw>
    <xmx:d-_SZ-qVUcsFHCoR8erUbBmC9M10Gqh7TUMg_TI3_HkQ2cnOhT3cRA>
    <xmx:d-_SZyiiwnDlnAfAnUSRL9GdSRTEJUqxDes8XT2yHG0ps_A33DqX-Q>
    <xmx:d-_SZ_dNhwjm406Q8fGIrXvdBqYrela30alK69NcwFbuBkD4Bvs43UbA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 10:45:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1ff7297c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Mar 2025 14:45:08 +0000 (UTC)
Date: Thu, 13 Mar 2025 15:45:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, kristofferhaugsbakk@fastmail.com,
	gitster@pobox.com
Subject: Re: [PATCH v2] reflog: implement subcommand to drop reflogs
Message-ID: <Z9Lvc2YKr5jD5D6h@pks.im>
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
 <20250310-493-add-command-to-purge-reflog-entries-v2-1-05caa92e0bfa@gmail.com>
 <Z9E0oDgGOM1R-4mI@pks.im>
 <CAOLa=ZQ3Rgi+yyma0Zo6uK04eu9Lk1dk_uYTU-4hFfh9POTNYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ3Rgi+yyma0Zo6uK04eu9Lk1dk_uYTU-4hFfh9POTNYA@mail.gmail.com>

On Thu, Mar 13, 2025 at 09:24:16AM -0500, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > On Mon, Mar 10, 2025 at 01:36:25PM +0100, Karthik Nayak wrote:
> >> +			continue;
> >> +		}
> >> +
> >> +		ret |= refs_delete_reflog(get_main_ref_store(repo), ref);
> >> +		free(ref);
> >> +	}
> >
> > The code is correct, but do we want to maybe wrap this loop in the
> > `else` branch to guide the reader and make it blindingly obvious that
> > the loop does nothing `if (do_all)`?
> >
> 
> Wouldn't it be simpler to return at the end of the `if (do_all)`? I've
> added that, but if feel strongly about this form, happy to change it.

I don't feel overly strong about it. I'm not a huge fan of early
returns as I think it's easier to reason about functions if they have a
common exit path. But I can live with whatever solution you come up
with.

Patrick
