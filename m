Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42F922A1E1
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717046; cv=none; b=dFLLCLDH+T3xrmq5RmHvWVPruWuOJ0yo1amf8YhfKIQS7RB4LSdgn02V9GKcRNi99eVd78+I4Asi3awCQ8BdxaMSnlx+ZAW8N10Jt+B5N5RUYyibWk0YGVkMppka8NeykZm3tM2SbErg3DfR88EuGVfnBp56v0yJVtYc/w9849U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717046; c=relaxed/simple;
	bh=fULkDVO1kOUu5nEhM1PF+/kuYSyGmtqESpY3nq3bFaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPYimTJIwUjg1HEKsu7litnIFGomkZ9dIriwGTTHtx8bEd5/C5CzChOn5MDvjcfwBbp6PytzeCUgWWkRVBWYa9BYAdzFWyHgjs5ZwuxSc/RwSTZrtZnvm5cXWEzDejB8p035+hMv9puSQlosCaocWD03ogGTZQfONxiRJ7ayXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jSJPb+Jb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=El7isngY; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jSJPb+Jb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="El7isngY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 298987A01AE;
	Thu,  5 Mar 2026 08:24:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 05 Mar 2026 08:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772717045; x=1772803445; bh=Bxr4GV2r28
	lpwvA/3ZjVktrpuRk/tD8qcp/39h2CGeg=; b=jSJPb+Jb06h0gqsPU9S6aM5i0L
	MDWMBMJqh4A/bAmy8VEWRo1Gjzq2p498wXjKaGKukAx8Hug4/P3FwGNsR6W6Hxd0
	p7yulMMTdccCbGP+M5dQQ9rE4uHDiCTW3nMkbrwMB+qsSQ8y3/GC8ODHboeQtpm6
	RCp5i6oxcfN8vsbq+iLf+J/jvdfP02ZiF8gFgxAeeIDXtYxvZ23jhOA6dZxciUYX
	C9MApmETrDuDz9HB3CnLInvb/y/Q/JwhDkLoyRe/fiBQejSqSB7DtVcz/p3n6DX7
	/++yQDeXakfEFRVz7lVIxwVfsHDWkg/hhU/IFD9aNMH32GJmHX8I23pMtzHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772717045; x=1772803445; bh=Bxr4GV2r28lpwvA/3ZjVktrpuRk/tD8qcp/
	39h2CGeg=; b=El7isngYK5zc9ckuP3IZ119uy+Zi+GOk2evTYXee0sfsvwshGye
	XGCiMuXEYupYhLI0ISV90DkA3a/nUEuaAoxSJsu39f2FRBWiQJ9Wo+TWAEdNviLB
	QTO4KVROISGWb6zUM5RE1+HevmyVOjlAvIre8l5KECB3A0Saz7M5B4bIXTZ+ps+x
	u/WXN5xEMxnAyQ5M7k+cBe/GibyrfHqxiiyOG/bqPWb3y0226tcNxU16xuryPX05
	2T0eSMUA2ZIHkw7uZU760FDl5d1H2h1oaA6wtFxOIBGpFXNEDcN2OgiHHIcmd8Z4
	51VspaNbjDqwm1JQ0hcvvxLtApkbJNWBzJg==
X-ME-Sender: <xms:9IOpaeUgp9pIMosZw3bGCeL-gbfsaCnml5GDyOnZE5hIZk1JnS1kLQ>
    <xme:9IOpaQlfZgIy_GHs8KpaTsozxlrdpyAkIjt93xzrdfUss1kXy3dkFC7eQnVvfJU1Q
    s4NE7Pju5JQXdpB3LZlO_Ci2OjO-Bfh_ytAfjtJ3k5wxu2SCLaqYQ>
X-ME-Received: <xmr:9IOpaQCDjZ2hUikAwH6Z_SCoh71vaC9tZhqblneAncj0EAnw5DdnOX8CeF8YzCthKloy4JB7KByef0LLn8uHKcj9Q_KDJpjydPZqJh5U_5qP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9IOpaQcQzSRiTWUqLBMyhXYTLr8UfNgdD8ZO7dOh5LEDFqmEbJeo5w>
    <xmx:9IOpabKa8KkbbgPrM_fOv1xpX9gG43qEMLXBzue_HhqsAy_bSPi_UQ>
    <xmx:9IOpaTe1HRyeijRtwkvGcgSCfLDQOtuskEZwpLx33ulIMdhsZlo8-A>
    <xmx:9IOpaS1FvkV6GdsbKIIizbNooutxsdSGdJBfa7mZCpHZgagTxfpNOA>
    <xmx:9YOpaTHiJj3BWLmOlW7BIeID-NjaNuu0xwaAxcuTPPJBlh2oi3EiYWTF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 08:24:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed42a215 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 13:24:03 +0000 (UTC)
Date: Thu, 5 Mar 2026 14:24:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 17/17] odb/source: make `begin_transaction()` function
 pluggable
Message-ID: <aamD8bMk0FLhR0dl@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-17-253bac1db598@pks.im>
 <aaiqJlmFgi92a0iC@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaiqJlmFgi92a0iC@denethor>

On Wed, Mar 04, 2026 at 04:01:32PM -0600, Justin Tobler wrote:
> On 26/02/23 05:18PM, Patrick Steinhardt wrote:
> > Introduce a new callback function in `struct odb_source` to make the
> > function pluggable.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  odb/source-files.c | 11 +++++++++++
> >  odb/source.h       | 27 +++++++++++++++++++++++++++
> >  2 files changed, 38 insertions(+)
> > 
> > diff --git a/odb/source-files.c b/odb/source-files.c
> > index c32cd67b26..14cb9adeca 100644
> > --- a/odb/source-files.c
> > +++ b/odb/source-files.c
> > @@ -122,6 +122,16 @@ static int odb_source_files_write_object_stream(struct odb_source *source,
> >  	return odb_source_loose_write_stream(source, stream, len, oid);
> >  }
> >  
> > +static int odb_source_files_begin_transaction(struct odb_source *source,
> > +					      struct odb_transaction **out)
> > +{
> > +	struct odb_transaction *tx = odb_transaction_files_begin(source);
> 
> For a given ODB source, I would always expect that the resulting
> transaction would always be of the same source type. This makes me think
> that the underlying logic to handle transactions should also live along
> side the concrete ODB source implementation. Doesn't have to be a part
> of this series, but maybe in the future we should just merge
> odb_transaction_files_begin() into here.

I'm not quite sure. The current transaction mechanism we have has two
different modes: it either writes loose objects, or it writes all
objects into packfiles. So arguably, we should split up this transaction
so that we implement it on the respective sub-types of the "files"
source and then have the "files" source route requests to the correct
backend depending on the current use case.

But this area definitely needs more work, agreed.

Patrick
