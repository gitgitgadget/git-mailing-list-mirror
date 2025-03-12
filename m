Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0338B2566D5
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793804; cv=none; b=DiuSXzWYu9nDd1TpAtHy2CvtQ3Ai1CJB2QI/JKvP4L8AhTvC1Wh4y5FM2gdw5l2+n3yrps6OMUd6hkBqPuKdwucJcnvbzqFftbdXfQhPEKnH0aA4q2cS9oIYHPFRNjY24BnedoCWv1NPSIbXbxSqKOwhQ/SBQUDPoNfFkEgmc/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793804; c=relaxed/simple;
	bh=tLlTRsYWtMxV6bZesOwW/mqo4ZYuYRObLPrDNysQLfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WniUhKKCLg5MXIStgPcXN87ZqCOZK2eWl1jXpxf3B5CoNUJ70XxpGKrULkN5l178Qt/tXVXByzNpkOnHN3k8XVg9WtkGiH2m/JKfKUmC1U6UurunN8Zum/3aZdAz5pClcHVmiAFuJSeubexaTPxiIZrh0pBsu96EWXjO+tYOkBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mQwmWUHy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x0eEcN15; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mQwmWUHy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x0eEcN15"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 05EEF1140190;
	Wed, 12 Mar 2025 11:36:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 12 Mar 2025 11:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741793801; x=1741880201; bh=bYl5LR4Ejh
	sTmVCZOp8Na86zGhVquRxpkSn1kA/kYK0=; b=mQwmWUHy0TZKJgHu7vAOF/kysj
	TueUSHl6RyCAC8wNVqKhzsk23lM8XmStclGDSHSFcLIKp8qhY63BiVlSr52tx4Z0
	tN+UaL6d68V+XPArfzxeMJA3TGFLmfiTYoUZxKm6USi8c+R/oKmnsjCCm+/DfuaN
	4wIRxvGx4OM7z1Br0dFXwYVntkaEehfFoOQefhuQCqZcTd8oQIMmTKorygWSfyHl
	0SA/4Zwtca65+4Jvk4Ol/1rTySB1lWpP+7f/smdjmqi50vTyhbR5XQObrMELeByj
	bpxHzJ1qbPUXHgqzDnnj9GnxubKoCHykHJtD9YY7J3h6m1mKtaYiW35QxRYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741793801; x=1741880201; bh=bYl5LR4EjhsTmVCZOp8Na86zGhVquRxpkSn
	1kA/kYK0=; b=x0eEcN15Cgktpz2Y6Au0IH67Po5S98aLqsD68A262mRI4CSUaKj
	OlixSY8tOMPXn8EWrpumJMilbxqQ0HBLlmOZ464i1Jj7N2thsJAURQ4Ydek0Ly8c
	BzCJZ8RKDEc3RReZ23OFlBIlB8yDUZWmPb41RzDIyNl5OxAgelYaOA+vpisbgd2u
	AcWuVIxVmka1aJ50q/Ni2vUVp8LMvE78xuhKU43V5EAGqQXvk8OIWZ2a1fOVzkcG
	ZG2Dn9KYZx3i51/zi058RHhfdmUp7i7xwFrM0XA4Yw5WaDaM/lnFZoKiqjS4Q1rE
	m9Az/QTIMEpFTcrmmmhJgCBiHe3wvo4g3CA==
X-ME-Sender: <xms:CarRZ-Z6E1UyLXhiakNrO8dy3odcTrbNWdGD0cbEDDfrFJHSNsfuuQ>
    <xme:CarRZxYUtMHI8HVvnftyfeO7sCR8ULYcbPZ0Cd3KEEqe9dEacYwl0FpDrbEp7lL47
    TMn39rL6QMp1Ie1Mg>
X-ME-Received: <xmr:CarRZ4-pYNNxzSbsQCud7uGFGghV27bhnLJHHUs_Ss1TN8XmFnwZ6ciM3A4h4uS-zkScTi3ZAnoP3G-aIEzbzfcyfGYjks2wCo3dRKQWu1FL5U_7fA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhi
    drohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddu
    keeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:CarRZwoYNm8kaJVlrNENrz0pEYvtJBvol1D2CzCHiPegbMt14Inktg>
    <xmx:CarRZ5r8HAULrxuOXXMMDSr3PZQsFZDgpsaUDFhw8oQ2WcND7JmyCg>
    <xmx:CarRZ-SFKCO0-89HAzeMwl_u7vA1tWGbv-zU5wj08hl9yslqhHJ8tw>
    <xmx:CarRZ5prWfnhdVCfb1hpEtVPc5VkXgUC9fEiLeLYbXEAg4oCJYgL3A>
    <xmx:CarRZ9LPQuP4295MwDdfoNcuH1ibR3-LIGmf38FeaWHo2N7mQ5hpPCYs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:36:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 25a00c0e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:36:39 +0000 (UTC)
Date: Wed, 12 Mar 2025 16:36:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 05/16] refs/reftable: batch refname availability checks
Message-ID: <Z9GqBsUdefVlNusR@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
 <20250306-pks-update-ref-optimization-v5-5-dcb2ee037e97@pks.im>
 <Z9GD-mg7CrvUxgqH@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9GD-mg7CrvUxgqH@ArchLinux>

On Wed, Mar 12, 2025 at 08:54:18PM +0800, shejialuo wrote:
> On Thu, Mar 06, 2025 at 04:08:36PM +0100, Patrick Steinhardt wrote:
> > diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> > index d39a14c5a46..2a90e7cb391 100644
> > --- a/refs/reftable-backend.c
> > +++ b/refs/reftable-backend.c
> > @@ -1379,6 +1375,13 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
> >  		}
> >  	}
> >  
> > +	string_list_sort(&refnames_to_check);
> 
> I am curious why we need to sort the refnames here. I think at current,
> we don't optimize the `refs_verify_refnames_available` function. No
> matter whether the `refnames_to_check` is sorted, it should not
> change the result of `refs_verify_refnames_available` function, right? I
> guess this statement may be related to optimization part. If so, I think
> we should delete this line and add in the later commit.
> 
> However, I am not sure.

You're right, sorting shouldn't be necessary. It was in a previous
version of my patch series, but now that it's not we can drop this.

We may at one point introduce an optimization that does depend on refs
being sorted. But until there is a need we should skip unnecessary work.

Patrick
