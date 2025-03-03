Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B01DFE1
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040938; cv=none; b=M62Tqk22jH1KX47cB3Udq3iRYgsijd9gDUE9BSIS91VRFbp7ek7ro5ia2/xsTFHJHcCxeIqj9n3NBnt9FyvnSFzvWSwVUBnKdDQYmzfqKrXEd56mukDSCI6h5oUCVynZjfgLqB5P+qg9NQECoKU+at8DyPvn716Rtf6elcw8SCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040938; c=relaxed/simple;
	bh=BSfGLM0VsKAD2gOh3/8L9fIL/Yvs6V1tcvjshQS54KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IL535ncx+x7QCQR2vdHwgwL5yMFNBty/EMW3vS6riprytmlCh1zFWzi80F7t2oq42Ruhb2VZU+xBXLHnBLdc2sQqahUQKfF6ORZcBiO3W780L4ZMfd9/yleFFzNIFt3JixkK+9eNPuMyF3Zdt9vPKWbyRPUrw3feCNBylW/a6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SJ51jkVP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4HAhUuNa; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SJ51jkVP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4HAhUuNa"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 49F211380A2E;
	Mon,  3 Mar 2025 17:28:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 03 Mar 2025 17:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741040935; x=1741127335; bh=NTyf23FG7g
	dkNxPm9GZxaKZSY5Ddvvrtt5t8TDdAp3Q=; b=SJ51jkVPwwEOzKnNMrbF79p8GT
	9aYMlSvPsExgxleYftDhYHjWRT7OtjPiKSOltaTnOTgOi3H+YvjblszcHUW3/YOB
	NgsWRou8rZS29guod4th/j5cwchko80WeaRHzQ0zCAPzQUtJHhtIWrBcgMm7wx5/
	7sw7UIJi/tDcwDc5RofOa9ni9zVwfH5QuBZgxGJGNQuDz1dctzBUnyz/GKOIm5sY
	A2qGNHLRyeC7eAV3rwNk+ifJ4oB2CMtaSl6iauNRRIIaIrfbXJtUTvhFC8OzENmT
	0cPmCoe67CX2ZykBe5ZqGCaz4WnvDpnUPgQEs6MnAKXOQzITUpIvi8wofCAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741040935; x=1741127335; bh=NTyf23FG7gdkNxPm9GZxaKZSY5Ddvvrtt5t
	8TDdAp3Q=; b=4HAhUuNaTBBAA9C/UJeEwwB+J9gOqkBWDflsxwVYMFnMb0aaAvc
	zkFz/YctgEKnXb+hFOOrxO5DrLf2m+ZEDUEgKXabxy1Cd0Wwv+h0XSuajz+Djobp
	e0EtSQXDBZp/snDfBHuTgzoQe3matYA0qy9i7jZCmi8jfT8y9EilDiKNjbIbok3l
	XqLvcCvQJw6dYVf9evRduNMM3dVSVDThSMhyPTLZhBPit7klshwLHatPDWvGwgAa
	LHRsfoPLF4lAokuhcxRv+kJLyPcvojpom1epTldbKPiCVmSpI6hku+3rHoiSSpLh
	s2OakMVediIvyzgIGl8wihsL73tPoTqsYHw==
X-ME-Sender: <xms:Jy3GZ5WyyLPwBGT2WFvBKKZ1sT6-rm0Zsw2RCOm9aX1bSWaA1YAX9w>
    <xme:Jy3GZ5kDOPxBz3_LUn3__9k48fkBZqz5-JE9OOF2XIh0EwrG4llsYZuk1rY5GC7TT
    dc5-KcojtTfKmvi4Q>
X-ME-Received: <xmr:Jy3GZ1ZWga1JVi7v0iu6AgkUOBjtB2i0XJEUvqY5_IFO2m_gkRgc5pd60Z3WxCO1XtNR7CF3VkhV1eVYueh0ZTVTaea5lpKy9RVCo11gdIrBZFGzbf8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefgveefve
    eihfehhefhgeethfdvffehfeehueelheeiffeuvddvuefhveffiefgueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:Jy3GZ8VyzoP1BJF-e2CrapESNENOWohnrkpXYLFDOf68eMSPhattsw>
    <xmx:Jy3GZzmg43nVSPAdEvw_ioFWq7hA8FlIi2v8ZEJ7GciqqZGvXvf61A>
    <xmx:Jy3GZ5cKUQui33-SKw60qCrdeJrIMvb1JC24izWB3ghoYeH-6tiUpg>
    <xmx:Jy3GZ9G91shwhD0WwQaJle18WXv_QzvHjDs8mA9WtkaFmumPh2WGvw>
    <xmx:Jy3GZxiMgQF4T5nfFi1g-QOEiCXKGWupglZol5eQsV4VCTWre5yYX031>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 17:28:54 -0500 (EST)
Date: Mon, 3 Mar 2025 17:28:53 -0500
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 01/34] t0450: *.txt -> *.adoc fixes
Message-ID: <Z8YtJd078J44snOE@teonanacatl.net>
References: <20250303204443.360595-1-tmz@pobox.com>
 <20250303204443.360595-2-tmz@pobox.com>
 <xmqqo6yhvl2o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6yhvl2o.fsf@gitster.g>

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
>> After 1f010d6bdf (doc: use .adoc extension for AsciiDoc files,
>> 2025-01-20), we no longer matched any files in this test.  The result is
>> that we did not test for mismatches in the documentation and --help
>> output.
>>
>> Adjust the test to look at the renamed *.adoc files.
>>
>> Signed-off-by: Todd Zullinger <tmz@pobox.com>
>> ---
>>  t/t0450-txt-doc-vs-help.sh                    | 50 +++++++++----------
>>  ...t-help-mismatches => adoc-help-mismatches} |  0
>>  2 files changed, 25 insertions(+), 25 deletions(-)
>>  rename t/t0450/{txt-help-mismatches => adoc-help-mismatches} (100%)
> 
> Wow, good find.  This is especially bad and I am glad we caught it
> before -rc1 (the hope was that all of these should have been caught
> while the topic was in 'next', which was the whole point of cooking
> it longer in 'next' than usual, but that plan did not really work).

Indeed.  I haven't looked closely at the CI bits to see how
we might be able to improve this.  When we skip tests
unintentionally we just don't see that currently.

I have a file of patterns I expected to skip in the rpm
builds when I maintained git in Fedora.  I'd regularly run:

     grep -E '# SKIP|skipped:' build.log | grep -Evf git.skip-test-patterns

to watch for skipped tests[1].  Those often indicated that I
needed to add a new build dependency, but sometimes catch
issues like this.  We have some similar things in the CI
scripts, I think.  Maybe we could add one for this sort of
thing.

What I don't know is how many tests we skip now and how
those differ across the multiple test runs.  It might be
annoyingly variable to track what is skipped between the
multiple OS types, releases, and build options.

I don't even know if we have the same data in the build
logs.  The rpm builds I run use `prove` with verbose output.

[1] That is also how I noticed that we've been skipping all
    tests which rely on the GPG2 prereq, as I mentioned
    recently in <Z8HVkqqD054QGPIE@teonanacatl.net>.

-- 
Todd
