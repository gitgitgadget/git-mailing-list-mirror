Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30DC29346F
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 07:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828525; cv=none; b=JzZaqFzQGDPxKU97ioQ+FX2oznJ5hGzzIIF5pit3U/imMFEGRrN3PKASIyV5zGOr6X37nSGFhUo1XYgoDSmePHBW3wzgoLV56bWhNAK5xov4DnOb61mXQhsaZ/X6WbTRrVLU2VIahQzEnko42r0tfLGOxBvG6WxD9q+l6qJpe7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828525; c=relaxed/simple;
	bh=FCjVr2t0d2o+A6svYK2mnwlvhnF/SOzv6zEBli2rfdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiknzGFLuW/LPEEuiRUmsQufwCjroaBb6qAaF8/2IFyxn0q7Ztke3eKMsfodoVF/lbm8w5tfA95ohVJ3yzHnbqk14RPvL7uIo4aNOT37L93Bl64hi6azEmcVZIsFVyBJwKSkOogLu85tHM+316crJYv0T1oXKuhcXs5rEfjCuBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MW2LWYbP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BrFy+Sk9; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MW2LWYbP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BrFy+Sk9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0A8091D001BE;
	Tue,  4 Aug 2026 03:28:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 04 Aug 2026 03:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785828522; x=1785914922; bh=AxOCM3SYDJ
	w4YkCvY9dOA4D1SQmjNVTX1fq87iZ2ulM=; b=MW2LWYbPntsimAhlQMrZ/Cn+ja
	LsiTqcwbF0ueg7E3Br8tFvwUu2ZcZ4bzBb3sNTv5wbfWP5nDQQvUuwtcdrxLFZjT
	GfNwQYN1c59QzhdMriLZJvHAVSDDWDR2grIcUVYuW2fda1KjC1MyCkv1hs4TRM/w
	ii+0vFK55OUo0Cvm+9Ss1N8r7bq61LBft9tYkqU7WAC/MMR+PBSkW3aMoCp/pSxk
	Fp45E/T5F39XF02dKn2uYaAAu/dGsL4di7cD2ghbPbdhWpuRzUUZ4jcZM8WhU4WC
	7UzE5EVhjzgqRAvtMqGzKPjzmd4vZ6YIT1Png75OTAHsc4Ot997VWMraK1Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785828522; x=1785914922; bh=AxOCM3SYDJw4YkCvY9dOA4D1SQmjNVTX1fq
	87iZ2ulM=; b=BrFy+Sk9WuhYrx78dRRVKFFnL4b5RLubvBOT6nN4QAovR2G9cE3
	VJuHw9kkbiOYuw+LDunoDxgNBAeekKRBtQ2hbc5Qc5NZaNPKEmv2NTkWc3SyTKDs
	346GPKfTMUt2TpAdL31/uYVUS76LnmCuVUCDz7eKcxhVd5lZ8F820rAZ3xUVXCzC
	vMDnQJ/ZT/kEHxZFM/vr/gDGSqEJsQBv0FC3Bp2DwHz5t6n2pkjyfOXWLT8Dq5ZK
	KyFA6XDmD+9pcq90I5ZiZfl/Z+1WCrUVzruf8x30dzOkUcrAT0hsSgQ/Q7sv1jx5
	X/0ExRi8Mr8RxwDfWbRfi3vRUK6ThdQWlFA==
X-ME-Sender: <xms:qpRxanWRLyvXum0OZp5WXHvdUwgjP3xXkO8QGLL1y9j2u38wDcDSug>
    <xme:qpRxalmsX4ZSauv3JPZG2d9WSW7bDysdvIeGmft5oLgQm9_qsMmnPn1JVtkIOdpyA
    BvAb5q8VL5_r61_3hK5is8N8U--pAIxX8W1FYmjrYJMGXJRZTAAojE>
X-ME-Received: <xmr:qpRxahBO6W9duTJ3XuKqxle4VwkfYeKVSiJhO8zHaIw-NC29UmPUG54tY16eckhzFEyf9CA6whHCgsCxKyj7b9RAvRBzJWiNBL_MLg6E>
X-ME-Proxy-Cause: dmFkZTGHB/BtFsTHMxz54XYKr3pb1NdqVGZZgpa70fhzRiWBE6IpdGW2MuKshyDlUzvURR
    6Yi8GJNystEhuLYBJPTY437SURCIOdV7yOubHk2ki1jVAJOQ3RUuSP+tYYwM6Gn133767I
    MI4g9d/ruHt3p9GXxxb0RgeAYfiEniqlf82nYkABlCZl+uJgo2gXo3F7Fesvj+LURvjGIT
    XpjN69eeIZ7JyPH0NTOtOmO1FOSG1LJpHyDLKuNj6D3D6d8eJytVHieSFiuclOJDkfcOvn
    l0OqKCEm20UoMdFukL7Cj5ViFjYMGz7nemkB6ceKMDq7JXU3iQCwsEESdYDyxa9JdLWZPm
    ywwUmjBc0Qr5GOxWInZclYo29e5NOGtBu0n9RI9RkiGvH0z3VHzkmLX4f1nrOgnmkVvtqs
    D4sikShZBykS43fBSDW4RQWd67O0IQ7ryeQG3cB/W9Y3g8zRfKAni8qTIPWNKOhzBqh1RZ
    mRq7Xm6yX38ojMFldwIVXIdQhY6prl+C/RN4vHZ/faQupKl30sHtq+OEiRACKbaaWLF7gj
    aaOZEPrmmjkVTCPh4iHWpU8D0jk3Y7zWEvHurGbw0VtaVhmMMTsMZ/NYNG128Su7it4kbP
    q6o/QU+t1QiyY5u/AEkJUxbxLwR+cJzFSZqfY8k6FxfwcZrG+C4zNNlWlR+Q
X-ME-Proxy: <xmx:qpRxatflEkF8AvXav5AF6aStHtY3xWOu1FLUFlf2OAiEoWyMuLsfog>
    <xmx:qpRxakKEhe080BIO40FejDWMDHvAjIbnfqRrzUmu0wuliHMCF4DiDg>
    <xmx:qpRxaoeHHN0LZXQqs8Mi1TnWAjpVVndMKzR-hX4SB7Jw29_DjChZYg>
    <xmx:qpRxaj2x8aQH4-ZhuhvUBPax3QwQhQvRKZYKfMHwnW7lozGewUpWwQ>
    <xmx:qpRxasHbZ0nPmAW04UlGu2GsH3ZHKr9AMvJ2JSu5R51x2cxqmkyBvpUN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 03:28:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1d1e1067 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 07:28:39 +0000 (UTC)
Date: Tue, 4 Aug 2026 09:28:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] setup: defer object database creation
Message-ID: <anGUo7NZZE0ysS6D@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260724-pks-odb-create-on-disk-v1-3-3b3d265d979b@pks.im>
 <amkXcmwzbBYsMgjc@denethor>
 <anGTBQIYpDl7HbXf@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anGTBQIYpDl7HbXf@pks.im>

On Tue, Aug 04, 2026 at 09:21:45AM +0200, Patrick Steinhardt wrote:
> On Tue, Jul 28, 2026 at 04:13:42PM -0500, Justin Tobler wrote:
> > On 26/07/24 05:48AM, Patrick Steinhardt wrote:
> > > In a subsequent commit we'll make the creation of the on-disk data
> > > structures of an object database pluggable. This will lead to an
> > > in-between state where we have already configured the repository's
> > > object database, but it's not usable yet until we eventually call
> > > `create_object_directory()`.
> > >
> > > Defer the object database creation so that we handle both steps in the
> > > same function.
> > 
> > So IIUC, the repository gets configured via `apply_repository_format()`
> > which invokes `odb_new()`. In this patch a
> > APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION flag is introduced to allow
> > the creation of the ODB to be delayed until after source specific
> > on-disk state has been created.
> > 
> > Naive question: would it be simpler to just require invoking `odb_new()`
> > explicitly after `apply_repository_format()` in all cases? There doesn't
> > appear to be too many callsites.
> 
> I don't think it would, mostly because the logic to figure out the
> object directory and the alternate object directory requires a bunch of
> logic.
> 
> I think it'll ultimately become simpler though once we move into the
> direction of what we've discussed in [1], where we said that we want to
> move handling of those environment variables into the "files" backend,
> too. And then it might make sense to revisit this.
> 
> Patrick

[1]: <amLgMqkqxR8mKIbT@pks.im>
