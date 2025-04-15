Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67A2750E5
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 05:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744696792; cv=none; b=F/Yf3pqod3+09QNXtx9BBhyqEdN9+WCgzD6IvasdgLWRf+yYHRhiLcoefAu4OqahPIxhUG9jtw6wGoJW4vnI9QgqME/ry7ITQwHQk3jfTxWbwbKyFfEtEB0npvIWorEcVZKre8tNmM7dyw0NFCbQloG4N0ziFE4RTFBw5yZ/F0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744696792; c=relaxed/simple;
	bh=VZDoLFJWkPcNr3ulMF4EQSMBMjTmCkS4wG4ZDplb+HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pzr17/RHywoQLK41t79s/CnaxNumGpOsF02G+/WKMbdVcpYT3RoOWswkDLA2Dt8Zsw8uGszbr/r7pFQVBvZirkFfHhP9oPYGAcVRP3eI19aKRs8cN+8oakf+PWr6LBE9bvbdPeLYmWbaU3HgsM2EVe7RbpvuuGO6tO5WFHzjlPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f4OqrH77; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=he1JUGVT; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f4OqrH77";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="he1JUGVT"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 73435138051E;
	Tue, 15 Apr 2025 01:59:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 15 Apr 2025 01:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744696789; x=1744783189; bh=/+J6nL99Vl
	yeFh2RKkXwLxWWZHgLE2VtQB39W7gKLOc=; b=f4OqrH77a/cJrIKMZ3rh2xtJob
	67S8HryjQZGiTruuERWjNqs5i8MNVu/+TuOrf7UwqaHjdhZz7EXAZt8Op+Txi4ez
	BhIrN76mbqozO7aFyngBwPIugDEwhf+SynKQQLf3uy/h+EJjCrKTLtuTr6VfjS7+
	ce0FuggyeDqoK5MWsUoXyIHafIU/X5j2aTORiKsyMiW/p4szKdn07dUyXSGON0gj
	kbzb/1CVtiK4J7rMcsIaXyxfeyCLXaGF+P98y+4v/eedI6/oHMJTYJ45NRD9clch
	n8iyBjXiIwLN48XG60kIlne2IKe2AHnLrydNfAqDvDZR7s+Dr8S7TePIGemA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744696789; x=1744783189; bh=/+J6nL99VlyeFh2RKkXwLxWWZHgLE2VtQB3
	9W7gKLOc=; b=he1JUGVTq+nrgfhEIv1BMwsu92c2kKjq2gNifCWg6oOwBcZ4+Ux
	jKpu5SL5nGq4CGyu7DJixa6+WVfQ66UqVfX2uVeNn+vPFAx5vz0GdMMRKVrVC8W8
	CF7VBDnF1hW56PchwAeuZ5MJnhMRAq5nh6gFNkg2/n+SUeqHlddWBKzUNUlX5iz/
	CvPBxhOV5YIeBp9DzZ1/uUhx6l9PdmsT4YR//usheI9X+Nm7BEKrH0nqQGnCi7hG
	WckRNYdWF7rHsx9zUt9JewoSUZ4meZfF7wpraVgAdzZ9ZqcwCw9GTCBY0gr8sQNt
	Bbi+QhSN0WKFkhtj+a365XFs/cdlq8JzmHA==
X-ME-Sender: <xms:1fX9ZyXXZbPA6kGHeAVZP4Yt8-5PxRD0MznCU_ZT6kq63yQh4dmIcg>
    <xme:1fX9Z-n0uZVivUX1EYi-M_WZtfj4-uAAWS19ZxOEA1X5BJ8MwyhZzAhv7T1ADX9jU
    ys6YIGMD9KLjhN2MA>
X-ME-Received: <xmr:1fX9Z2b1Yp5LWTLuDbBMorokEoY1fIcENfsMq6IJfG06sa9t6JAYNjbmASnfCJ5aJo4BiirUSQGv3NCUkrHzJn-kJABEXzEIMx11qo07u-TL0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddvieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesughinhifohhoughivgdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhgrmhhs
    rgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1fX9Z5WMh0v0MN6K14b4n3LuDUBvIUNG0Aw6rIUIo-uOW_GcOFwwtw>
    <xmx:1fX9Z8l9pPz3JQD8Vthroktjc887k8NUZ3PosJMvo5No8bT-NQsS1g>
    <xmx:1fX9Z-fAPh-6tw6_h0ALc6Az-yRqcEVJjkMW7echwyyrpUBPr12fUQ>
    <xmx:1fX9Z-E9mUiU86aanCjMydOCCCWIgHw4OANAOJEBNbdq0Eprl-uGqQ>
    <xmx:1fX9Z6_JUFcg2CEn3rZCCmbcYQTe1ayGPeQ0QJ4I4pK_MFYU2sd0Irbe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 01:59:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f7de5575 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 05:59:47 +0000 (UTC)
Date: Tue, 15 Apr 2025 07:59:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [-SPAM-] Re: [PATCH v2 07/13] config.mak.uname: only set
 NO_REGEX on cygwin for v1.7
Message-ID: <Z_310iVKmhrl0UGE@pks.im>
References: <1c04882b-e518-4272-bd18-ab918774e424@ramsayjones.plus.com>
 <cover.1743859985.git.ramsay@ramsayjones.plus.com>
 <324bb213426ffc9c1f9cd155de309bd0b63cdbc4.1743859985.git.ramsay@ramsayjones.plus.com>
 <Z_y_VeJzT82by8wg@pks.im>
 <db92840f-ed4a-46b7-aba0-b556ed33af6f@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db92840f-ed4a-46b7-aba0-b556ed33af6f@ramsayjones.plus.com>

On Mon, Apr 14, 2025 at 09:03:30PM +0100, Ramsay Jones wrote:
> On 14/04/2025 08:55, Patrick Steinhardt wrote:
> > On Sun, Apr 06, 2025 at 08:38:33PM +0100, Ramsay Jones wrote:
> >> Commit 92f63d2b05 ("Cygwin 1.7 needs compat/regex", 2013-07-19) set
> >> the NO_REGEX build variable because the platform regex library failed
> >> some of the tests (t4018 and t4034), which passed just fine with the
> >> compat library.
> >>
> >> After some time (maybe a year or two), the platform library had been
> >> updated (with an import from FreeBSD, I believe) and now passed the full
> >> test-suite. This would be about the time of the v1.7 -> v2.0 transition
> >> in 2015. I had a patch ready to send, but just didn't get around to
> >> submitting it to the list. At some point in the interim, the official
> >> cygwin git package used the autoconf build system, which sets the
> >> NO_REGEX variable to use the platform regex library functions. The new
> >> meson build system does likewise.
> >>
> >> The cygwin platform regex library, in addition to now passing the tests
> >> which formerly failed, now passes an 'test_expect_failure' test in the
> >> t7815-grep-binary test file. In particular, test #12 'git grep .fi a'
> >> which determines that the regex pattern '.' matches a NUL character.
> >> The commit f96e56733a ("grep: use REG_STARTEND for all matching if
> >> available", 2010-05-22) added the test in question, but it does not
> >> give any indication as to why the test was framed as an expected fail,
> >> rather than a 'positive' test that the 'git grep' command fails to
> >> match a NUL. Note that the previous test #11 was also originally
> >> marked in that commit as a 'test_expect_failure', but was flipped to
> >> an 'success' test in commit 7e36de5859 ("t/t7008-grep-binary.sh: un-TODO
> >> a test that needs REG_STARTEND", 2010-08-17).
> >>
> >> In order to produce the same NO_REGEX configuration from autoconf, meson
> >> and make, modify config.mak.uname to only set NO_REGEX for cygwin v1.7.
> >> In addition, skip test t7815.12 on cygwin, by adding the !CYGWIN pre-
> >> requisite to the test header, which (among other things) removes an
> >> '...; please update test(s)' comment.
> > 
> > Out of curiosity, because I really don't know any better: why do we have
> > to even care about such oldish Cygwin installations from more than 10
> > years ago? Wouldn't people generally update Cygwin every once in a while
> > to have recent packages? Or is there a good reason why we should
> > continue to support it?
> 
> Heh, as I said in response to Junio, I have a patch that removes all
> of the config in the conditional, so that we would no longer support
> any 'pre-v2.x' versions of cygwin[*]. I think that would be an entirely
> reasonable thing to do, particularly as cygwin thinks of itself as
> a 'rolling release' type distribution. ;)
> 
> However, I don't think it is my place to make that kind of decision
> and I was leaving that patch until last. Hopefully, Adam will make
> that call. :)

Makes sense, it's a bigger discussion indeed. I do think it would be
reasonable to drop pre-2.0 Cygwin, and we have recently become a bit
more aggressive in dropping support for ancient OS versions. But I'm
totally fine with not doing it now.

Patrick
