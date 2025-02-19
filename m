Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42701DF73A
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965942; cv=none; b=m8NRwdkrHGdbCnJANxC5DjJR2v19QQ+SCSKab8O6uEAPdfMA5p9eVEHy2NiQkH8m4pGbBL91s9FgGcQoeewodqDHdmkAkri/p+5QBZ5CtMUMb2sXITi77Cl8aLVwC6oK0QdgV+HBETXxVHG1qwJbgaDXdsLxUCBWE5w350au37Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965942; c=relaxed/simple;
	bh=8H+nVx5b3AODabvD/IvlWVgEFVfCsmbYKG+dUpDLvFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Az037e8/pxT+Xx9hx+1f3vcadSvNnRn3Fs/XEfEn6c18AxWX6VbZiIVlXDG9EI3UUW1DKUxpBuk7vJ0eyVn8SY+zB/tiwTTt9FDT6FUt6VTFsCckAOcemXffXBOzNzAZ+bVwAgOlushKtvxm/lfcCIb7Xr0XpeWEzAYI/XYaOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ICATf/tv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VPlNApQV; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ICATf/tv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VPlNApQV"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D53A41140113;
	Wed, 19 Feb 2025 06:52:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Feb 2025 06:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739965938;
	 x=1740052338; bh=RgZd/usw4Pz6JGUOgAGl+0hOwZBHWiKBIZ9PrWDBFxs=; b=
	ICATf/tv6kRbdBI+KnW/LucDn1ElMwht1DL1cEA83JnTMt5s1asGtjYcuADcBZyr
	B6omRaTxduyZ8dOdRl1NwHz+GToRoP55aK1ah8jcAarsVixgu/+IRPCaaSD1/v0H
	QaF2s9PC4jWpIANFBFjT4PQE6kwEKRKjsPfiRSTGYJ2v7/V2GaTH3h4J+F0pyD8g
	9s/Q+rMdahdAJ6WH2cmPekvyIvG6YsJW/YWF+uyqXe6p6DLDYqOOx0LAxwQqg1ef
	cs/As9t2KeL+Fx19E21vYIOHWw9sbT+O4uXgIo561Y8jYMMcpsTleP6JWAei91Mh
	aYy3cukMah0EUbhlJzaqVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739965938; x=
	1740052338; bh=RgZd/usw4Pz6JGUOgAGl+0hOwZBHWiKBIZ9PrWDBFxs=; b=V
	PlNApQVg5v5Jo1gANyjAn3UdBEYqIzFxkBOj7HRguha0jR67t9MmgIH0P3EO2Itu
	6m05tpuvCjfjZK3kx0Sb+He8jG8rsEA4TAuwSoPYmCLZ38j19dTY1f8YfldfguLb
	Y66AYiahyB8BZmFhFkPRyopZ7cWBbvyT65phsDRWcDgpIufntr2OLp4DutcL7ASZ
	1GvncpKlTxesfSEyquZONvTS/qdRTigD8KZCthfOahw/CuyBwMxPtFdz9e2EQ9Gr
	5HotbNRtomIo7PfnCfHxVjSDNGbe8BVNE264bD46l+jh7lCgSUysGz9lXcSPIXM4
	jG9HxBAyhgmkIGueLzb/g==
X-ME-Sender: <xms:8sW1Z8nk3NnZ4_-lv9tSYWEf8rDIkcUYJZUmbBrY2WzxcrNlkUHR-g>
    <xme:8sW1Z70b3LcyOQSpFlyJYFSqnse37_oYsrR9RTLfVyQ9x_Qskx3W2zw4YwRLddTBe
    wxpABVb28A8_IwKMA>
X-ME-Received: <xmr:8sW1Z6r1P3mGtq5TUiPhKHdN0A8HWzknPmubuvvKBSSDpBMsdJVmdNQwcmla7YvmlA65MYOzEM1ZnstxL6iBNBVlccAc9aQNRBHDWyAp3U21jig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrgh
X-ME-Proxy: <xmx:8sW1Z4nBjUCY9a9hDE5mzRC7pk5LZZBsNkZbpqdSrg4B8AdSOytmFw>
    <xmx:8sW1Z61BzEzn6gIYcSUjEHVLQQOAgIo_c32nhzMctaSS9ANbpAcGhw>
    <xmx:8sW1Z_sAXEgMWqctxEdX6HHX4MY7qvUHHUmc9s031mIhhbZxIv0zWw>
    <xmx:8sW1Z2V-D3yvGBv3FljJDiPMf8J_2y4os4WivG_4yDevdKxvFtBkKg>
    <xmx:8sW1Z0oOYcEeZUIRfMH7NYDpDJ_y9XYeYXYoTw2mZX0x31KR0cy2fSqd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 06:52:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 26b0e73e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 11:52:16 +0000 (UTC)
Date: Wed, 19 Feb 2025 12:52:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 06/14] refs: stop re-verifying common prefixes for
 availability
Message-ID: <Z7XF77yKUgENdbA-@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
 <20250217-pks-update-ref-optimization-v1-6-a2b6d87a24af@pks.im>
 <CAOLa=ZQC+UXQGjOqot=pTopkd8mOjduixQ=rBnsis9g_3_HOqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLa=ZQC+UXQGjOqot=pTopkd8mOjduixQ=rBnsis9g_3_HOqw@mail.gmail.com>

On Tue, Feb 18, 2025 at 08:12:05AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > One of the checks done by `refs_verify_refnames_available()` is whether
> > any of the prefixes of a reference already exists. For example, given a
> > reference "refs/heads/main", we'd check whether "refs/heads" or "refs"
> > already exist, and if so we'd abort the transaction.
> >
> > When updating multiple references at once, this check is performed for
> > each of the references individually. Consequently, because references
> > tend to have common prefixes like "refs/heads/" or refs/tags/", we
> > evaluate the availability of these prefixes repeatedly. Naturally this
> > is a waste of compute, as the availability of those prefixes should in
> > general not change in the middle of a transaction. And if it would,
> > backends would notice at a later point in time.
> >
> > Optimize this pattern by storing prefixes in a `strset` so that we can
> > trivially track those prefixes that we have already checked. This leads
> > to a significant speedup when creating many references that all share a
> > common prefix:
> >
> >     Benchmark 1: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
> >       Time (mean ± σ):      63.1 ms ±   1.8 ms    [User: 41.0 ms, System: 21.6 ms]
> >       Range (min … max):    60.6 ms …  69.5 ms    38 runs
> >
> >     Benchmark 2: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD)
> >       Time (mean ± σ):      40.0 ms ±   1.3 ms    [User: 29.3 ms, System: 10.3 ms]
> >       Range (min … max):    38.1 ms …  47.3 ms    61 runs
> >
> >     Summary
> >       update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD) ran
> >         1.58 ± 0.07 times faster than update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
> >
> > Note that the same speedup cannot be observed for the "files" backend
> > because it still performs availability check per reference.
> >
> 
> In the previous commit, you started using the new function in the
> reftable backend, can we not make a similar change to the files backend?

It's quite a bit more intricate in the "files" backend because the
creation of the lockfiles and calls to `refs_verify_refname_available()`
are intertwined with one another:

  - `lock_raw_ref()` verifies availability when it hits either EEXISTS
    or EISDIR to generate error messages. This is probably nothing we
    have to care about too much, as these are irrelevant in the good
    path.

  - `lock_raw_ref()` also verifies availability though in the case where
    it _could_ create the lockfile to check whether it is conflicting
    with any packed refs. This one could potentially be batched. It's a
    curious thing in the first place as we do not have the packed refs
    locked at this point in time, so this check might even be racy.

  - `lock_ref_oid_basic()` also checks availability with packed refs, so
    this is another case where we might batch the checks. But the
    function is only used when copying/renaming references or when
    expiring reflogs, so it won't be called for many refs.

  - We call it in `refs_refname_ref_available()`, which is executed when
    copying/renaming references. Uninteresting due to the same reason as
    the previous entry.

  - We call it in `files_transaction_finish_initial()`. This one should
    be rather trivial to batch. Again though, no locking with packed
    refs, so the checks are racy.

So... it's a bit more complicated here compared to the reftable backend,
and I didn't feel like opening a can of worms with the potentially-racy
checks with the packed backend.

Anyway, I think we still can and probably should use the new mechanism
in two cases:

  - During normal transactions to batch the availability checks with the
    packed backend. I will have to ignore the issue of a potential race,
    but other than that the change is straight forward and the result is
    a slight speedup:

      Benchmark 1: update-ref: create many refs (preexisting = 100000, new = 10000, revision = HEAD~)
         Time (mean ± σ):     393.4 ms ±   4.0 ms    [User: 64.1 ms, System: 327.5 ms]
         Range (min … max):   387.8 ms … 398.7 ms    10 runs

       Benchmark 2: update-ref: create many refs (preexisting = 100000, new = 10000, revision = HEAD)
         Time (mean ± σ):     373.3 ms ±   3.4 ms    [User: 48.8 ms, System: 322.7 ms]
         Range (min … max):   368.7 ms … 378.6 ms    10 runs

       Summary
         update-ref: create many refs (preexisting = 100000, new = 10000, revision = HEAD) ran
           1.05 ± 0.01 times faster than update-ref: create many refs (preexisting = 100000, new = 10000, revision = HEAD~)

  - During the initial transaction. Here the change is even more trivial
    and we can also fix the race as we eventually lock the packed-refs
    file anyway. This leads to a noticeable speedup when migrating from
    the reftable backend to the files backend:

      Benchmark 1: migrate reftable:files (refcount = 1000000, revision = HEAD~)
        Time (mean ± σ):     980.6 ms ±  10.9 ms    [User: 801.8 ms, System: 172.4 ms]
        Range (min … max):   964.7 ms … 995.3 ms    10 runs

      Benchmark 2: migrate reftable:files (refcount = 1000000, revision = HEAD)
        Time (mean ± σ):     739.7 ms ±   6.6 ms    [User: 551.9 ms, System: 181.9 ms]
        Range (min … max):   727.9 ms … 747.2 ms    10 runs

      Summary
        migrate reftable:files (refcount = 1000000, revision = HEAD) ran
          1.33 ± 0.02 times faster than migrate reftable:files (refcount = 1000000, revision = HEAD~)

I'll include these changes in the next version, thanks for questioning
why I skipped over the "files" backend.

Patrick
