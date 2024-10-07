Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268D18E054
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293124; cv=none; b=Xsz1uhoL+ZMXp+8rfOmijEfF2FD2BkiZoIVLjwbPVmWCYNsbCEVJE6vylNMg6UWsEOfa1g9LwD8CtEaVg/IZIT/AVaF4Bl6rU9HnOtwPGsdxXxf0dYiYLCj3gPB1pY0KBvVu3feMfwLMyyXq7/CDZDkGtuNq2xWzvmJdXlxpcM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293124; c=relaxed/simple;
	bh=lyN9r3tRSdc5nj9a1i9665s62gJoXF1gGxb4BXSK+Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSSFOZRJVU/JMFk8DSOdK21LK025hwwhGoKEhzbFnJ+axfmU3FcxlkpHTHQkIhKwn9vlRsK3269A6mSw0AXVlryYzs92/1OaF/XNyt4niGunfnN2Q94fBCYEvTVNrMxtZHxtROjQnqq80hbReH3otw/nLoZ+c+UKFN5d9GR/Ygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DD9MpxPJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=obmkiLra; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DD9MpxPJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="obmkiLra"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 521C225400CF;
	Mon,  7 Oct 2024 05:25:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 07 Oct 2024 05:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728293121; x=1728379521; bh=iEdzVtXn5q
	rCZD/BV9n7x8pGb8rlxCLD1RquilWBj40=; b=DD9MpxPJCQ2iGgwB8bSICzlW9B
	z+3mFDZ350+JgHGNNjRXKDV+N/UpdC3DF7Gz6R2hBeHYhIukcD+i4FRdY4koMZh8
	j07zyqpvDOYF0HtY9Vr9pwpVxI/iI1TtXiA+K6f/fH7WW5jsjSoxe/KKfcq+cT3f
	mnuf/t+b8GiehIFtZnPmqQ+8A00R80+skkGXLBzjUnhUPr5hqzubehtksboDb+rL
	erGpLnUqO9WexzHBrNFggciOdesnVMm/16YukYpXEjmB28OzmMedqypzMlYeKjR5
	WbMV8XyILourvwsl+N9Dw/OylHeCBCEbM+ChwJbLS+1cPS+uV2ZRLezUrqBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728293121; x=1728379521; bh=iEdzVtXn5qrCZD/BV9n7x8pGb8rl
	xCLD1RquilWBj40=; b=obmkiLrarTGM/n7WP4urr0G9eVzt/EjDyml+GmgSK8aC
	sf5tN5daJV5MQEI2VVuNERFCyXJrLL0fHUlSMbDicFk0Jj+FXrORHgcQMq3zDNRk
	DwGKIEVIhTLKATLKTMdQ8nYscHCHEz9Yi5lM3ilo/Ibd+eNZxaZBGQxHkxEMu2LF
	W/Jf9T6BuXCHQfDh+BwmLXMFlmLNUIdc3XY2sUyC0TwlOZ+QIonKBET4Hx1IGb2U
	H7D5GOcP2rXw2mX+54/9Hynk3mhDuf5T50HjVXnfwOrfJvI6Oafz2C31NjUYeifU
	mGaGAw+bH7j6Jp4Wr0PqB0tmYS/TkjYlIZvQ+QsFSw==
X-ME-Sender: <xms:AakDZ1aBEO9G8QQLECgs-dhf_0AJP1MvzLaUARgGAS4p7G3vPbjwAg>
    <xme:AakDZ8ZxeLXgxcwt-7TmzR6l6TjROtHNzuvRC35wtgdikVMtUzm918iHP191nW7-E
    aFY6ebZ_BAWpnCLqA>
X-ME-Received: <xmr:AakDZ3-taAiYJigrrB0xXH_sRooB_DV544EDmNwAjFYpuiDt_uskvT02I7R7Sh2Jou4oyhT1lVy6PylArFLFMPLAVXKqHLfeykdewy1y-VRftVB0Lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    shhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AakDZzplafgSCoHdx3Z0vVxvAztbkCVA1RBNSClOMAFdD6t8LtwHwA>
    <xmx:AakDZwr6jU_iv8b2gwDER9ia5wsj42J80gqWL8xj2mDoXr2VDnbZYw>
    <xmx:AakDZ5QONxznwVl4eip6r0gUF_8FGAPjgqEKmL-l2n76hxat1FkZ1A>
    <xmx:AakDZ4q-l7VDp5jM1DMk60txjGeUvuut47YUcxewxKU-qEQH6-9pUA>
    <xmx:AakDZ5nUyjyVWLrdK5rgBDK0-bk6apppdrFdB7gKY3WOcr2tZC_Q_u3h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 05:25:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f124ff7d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 09:24:20 +0000 (UTC)
Date: Mon, 7 Oct 2024 11:25:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/9] ref: add more strict checks for regular refs
Message-ID: <ZwOo9dQSr8Xu-PBb@pks.im>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
 <Zvj-sBX-0AFsuFDC@ArchLinux>
 <ZwOGnQSqmwALK-9z@pks.im>
 <ZwOfYGi21oa302sS@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwOfYGi21oa302sS@ArchLinux>

On Mon, Oct 07, 2024 at 04:44:16PM +0800, shejialuo wrote:
> On Mon, Oct 07, 2024 at 08:58:37AM +0200, Patrick Steinhardt wrote:
> > On Sun, Sep 29, 2024 at 03:16:00PM +0800, shejialuo wrote:
> > > diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
> > > index 22c385ea22..e310b5bce9 100644
> > > --- a/Documentation/fsck-msgids.txt
> > > +++ b/Documentation/fsck-msgids.txt
> > > @@ -3541,6 +3546,21 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
> > >  		goto cleanup;
> > >  	}
> > >  
> > > +	if (!(type & REF_ISSYMREF)) {
> > > +		if (!*trailing) {
> > > +			ret = fsck_report_ref(o, &report,
> > > +					      FSCK_MSG_UNOFFICIAL_FORMATTED_REF,
> > > +					      "misses LF at the end");
> > > +			goto cleanup;
> > > +		}
> > > +		if (*trailing != '\n' || *(trailing + 1)) {
> > > +			ret = fsck_report_ref(o, &report,
> > > +					      FSCK_MSG_UNOFFICIAL_FORMATTED_REF,
> > > +					      "has trailing garbage: '%s'", trailing);
> > > +			goto cleanup;
> > > +		}
> > > +	}
> > > +
> > 
> > I think we should discern these two error cases and provide different
> > message IDs.
> > 
> 
> Actually, in the previous versions, I have mapped one message id to one
> error case. But, in the v4, Junio asked a question
> 
>   Not limited to this patch, but isn't fsck_report_ref() misdesigned,
>   or is it just they are used poorly in these patches?  In these two
>   callsites, the message string parameter does not give any more
>   information than what the FSCK_MSG_* enum gives.
> 
>   That is what I meant by "misdesigned"---if one message enum always
>   corresponds to one human-readable message, there is not much point
>   in forcing callers to supply both, is there?
> 
> In my opinion, we should have only one case here for trailing garbage
> and not end with a newline. When writing the code, I chose the name
> "unofficialFormattedRef" for the following reason:
> 
>   1. If we use two message ids here, for every message id, we need write
>   to info the user "please report this to git mailing list".
> 
>   2. If we decide to make this as an error. We could just classify them
>   into "badRefContent" message category.
> 
>   3. The semantic is correct here, they are truly curious formatted
>   refs, and eventually we will give the info to the user what is
>   curious.
> 
> So, I think we should not always map one message to one error case.

From my point of view the error codes should be the single source of
truth, as this is what a user can use to disable specific checks. So if
one code maps to multiple messages they have the problem that they can
only disable all of those messages.

I don't disagree with what Junio is saying. It is somewhat duplicate
that the user has to pass both a code and a message in the current
form-- it should be sufficient for them to pass the code, and the
message can then e.g. be extracted from a central array that maps codes
to messages.

But you can also make the reverse argument: messages can be dynamic, so
that the caller may include additional details around why specfically
the check failed. The code and message would still be 1:1, but we may
include additional details like that to guide the user.

Patrick
