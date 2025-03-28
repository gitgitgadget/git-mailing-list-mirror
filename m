Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93852F3B
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 09:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743154268; cv=none; b=sJ15pKMpEiethIwVsgAUi1UzVpcrYVgQUA7xrHV6ehmYHf645Hg6cqkdckwa2NPSJZoWRlGgriiMF7WhLz75S9zaWEIYjz68l5UKbHfPIi25d6zpWaTGiwgFeibFcXlZjTOBuSHLjB/sScufSrWeHjb7afYTXy+Py8nLWRaDxiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743154268; c=relaxed/simple;
	bh=1I5NQFuSaqCRHmwhTSPpUNykYND4D3frtqU0tvnZz4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mG9ieH5OaCk/zPF1M/y7ir6m3kKVHcFl28RU9xktOU84d1MF2ZhmmODdb8d+/+F3v/wxFy/pMPjMH6eCnBnpq+rvSQFtOautU/p6Mk7dTt7F/yMJYpUwvGwRyhaMjZwOQ33R+0rdKHXKppWK3A2v854hja0KbwMFGHM4XWXbbMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mOthNFuj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rdiHlu1j; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mOthNFuj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rdiHlu1j"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id A2DA911401E8;
	Fri, 28 Mar 2025 05:31:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 28 Mar 2025 05:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743154261; x=1743240661; bh=SuI5b6WVJl
	UShG5Ug8FsbZUoAPx6AMs+yrJ4jyrO++I=; b=mOthNFuj+45yjFQ6p7Yd/CBQlM
	G9IT0Ns3HbwGg1YjL3X5eMNgicrnWFqXzPZPi1Swd4f0/Vfo5eiXubAY0cK1CEzC
	G5eilpqogGkxWdLpuQkKZ4sx0FWdhFILo68hBg4dX819tMSJjcjCpiP2h/C04Qx6
	xTFWWgxUEFv97woFEOuJ/6/sXsmAgm4/RbpTrnfcsOB3G9lpB8GCtuloYh7VSCCP
	GYMfCnErj6ILGDtySTectrxJob+xGUCnOswnpd2llkEcZ4AUfNDHFvVeD6nC2pAQ
	XiQGP7g27IidGk5/svJRgBjL5umbwYlQJoINguc57wS7GmV+zP2I9Grma/hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743154261; x=1743240661; bh=SuI5b6WVJlUShG5Ug8FsbZUoAPx6AMs+yrJ
	4jyrO++I=; b=rdiHlu1j3Iq0JSkkVfu9qwA0c/5rKgf+yItj2Qu985uo24Chgz2
	HkluK0cN7mTqEdWqI1lAA2uOn2gKx8Md2GbJBJeT73OVUlzLNA1dGcL9ywcURaXj
	dXtebIAnFRvouwdWLGHbvg4Vm4b14JteF9MLIReyXGWcCtk7A4aN5ie+n3WJrRgH
	5mZmBcrfWOqnE434IS7YJCowbVqIvMWOxRoXwKEGhCef1PNPp17IisBAuaJFrcI2
	XmmVSpRhW3EICUL9hULouyxq/2RlBMpzuG24tlhCSBt42GoeIIPx5GLuFfOBepOW
	d9asR5f4ZvxmYiyUli3whqi3HfwM5aJ06zQ==
X-ME-Sender: <xms:VWzmZ1pvneHQzOXvpJ2WHAw9UACr6UqWE4w1uIWd2ewwvIvbXaiQCg>
    <xme:VWzmZ3phAX3VU7oAoQgIk96niUKHBQOHtgWbqhSDhJUGSMSJMQCEMbnfdUTYITSiW
    F_aJN5ASNaNyLdL4A>
X-ME-Received: <xmr:VWzmZyN1AhfBp8wGXh7CFzCJNW31PPxj9eKgLktHMfSdPyNvTo96uNLkkdSIeakIlSVyIjI_pPuWmVrXNPfdOS41AEJ7ACqxI2I-rra-SIAVVIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedv
    geeiteegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhlrghusghithii
    sehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmiiesphhosghogidrtghomh
X-ME-Proxy: <xmx:VWzmZw6-cJzXEXv_1tfIQ_y4X3snVTqRau8w5tFB51TK7xOCTnR4TA>
    <xmx:VWzmZ05E7Xu4NvVWqCbzofJA598BGQOOy1FucfzijHwav7Y20hlbTg>
    <xmx:VWzmZ4jFMgyKz6z9ZbGXz_snuTkwLz_o0sJ1Ik5wnQeiYEUjIswRxg>
    <xmx:VWzmZ27cE0uq2j2Aln-pLPyrQ865slvV4ga6yPToDFuBnTk4W4pz8A>
    <xmx:VWzmZ_1KT4Y0l0ElTlI0tKLfXqlNyJiWvoi-rg6oqKelpEi0KkxB7mRu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 05:31:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8bd4a627 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Mar 2025 09:30:59 +0000 (UTC)
Date: Fri, 28 Mar 2025 10:30:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Todd Zullinger <tmz@pobox.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: Testsuite failure on s390x and sparc64 after 6840fe9ee2
Message-ID: <Z-ZsUsaSw2pQwlYb@pks.im>
References: <89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>
 <Z-R_Zmr6kxCPLm-O@teonanacatl.net>
 <Z-Zr7BZL1UGqVxKu@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-Zr7BZL1UGqVxKu@pks.im>

Also Cc'ing Stolee's current mail address instead of the GitHub one.

On Fri, Mar 28, 2025 at 10:29:16AM +0100, Patrick Steinhardt wrote:
> On Wed, Mar 26, 2025 at 06:27:50PM -0400, Todd Zullinger wrote:
> > John Paul Adrian Glaubitz wrote:
> > > the following commit:
> > > 
> > > commit 6840fe9ee29ab51ffd7d924c624dc62da22c50bf
> > > Author: Derrick Stolee <derrickstolee@github.com>
> > > Date:   Mon Feb 3 17:11:05 2025 +0000
> > > 
> > >     backfill: add --min-batch-size=<n> option
> > >     
> > >     Users may want to specify a minimum batch size for their needs. This is only
> > >     a minimum: the path-walk API provides a list of OIDs that correspond to the
> > >     same path, and thus it is optimal to allow delta compression across those
> > >     objects in a single server request.
> > >     
> > >     We could consider limiting the request to have a maximum batch size in the
> > >     future. For now, we let the path-walk API batches determine the
> > >     boundaries.
> > > (...)
> > > 
> > > broke the testsuite on s390x [1] and sparc64 [2]. The following test fails:
> > > 
> > > not ok 4 - do partial clone 2, backfill min batch size
> > > 
> > > CC'ing the author which is Derrick Stolee.
> > 
> > I reported this during the rc period.  I didn't hear back on
> > it, but hopefully your message will arrive at a more
> > convenient time. :)
> > 
> > https://lore.kernel.org/git/Z8HW6petWuMRWSXf@teonanacatl.net/
> 
> Copy-pasting the test logs from that mail:
> 
>     expecting success of 5620.4 'do partial clone 2, backfill min batch size':
>             git clone --no-checkout --filter=blob:none      \
>                     --single-branch --branch=main           \
>                     "file://$(pwd)/srv.bare" backfill2 &&
>             GIT_TRACE2_EVENT="$(pwd)/batch-trace" git \
>                     -C backfill2 backfill --min-batch-size=20 &&
>             # Batches were used
>             test_trace2_data promisor fetch_count 20 <batch-trace >matches &&
>             test_line_count = 2 matches &&
>             test_trace2_data promisor fetch_count 8 <batch-trace &&
>             # No more missing objects!
>             git -C backfill2 rev-list --quiet --objects --missing=print HEAD >revs2 &&
>             test_line_count = 0 revs2
>     +++ pwd
>     ++ git clone --no-checkout --filter=blob:none --single-branch --branch=main 'file:///tmp/git-t.sYdo/trash directory.t5620-backfill/srv.bare' backfill2
>     Cloning into 'backfill2'...
>     +++ pwd
>     ++ GIT_TRACE2_EVENT='/tmp/git-t.sYdo/trash directory.t5620-backfill/batch-trace'
>     ++ git -C backfill2 backfill --min-batch-size=20
>     ++ test_trace2_data promisor fetch_count 20
>     ++ grep -e '"category":"promisor","key":"fetch_count","value":"20"'
>     error: last command exited with $?=1
>     not ok 4 - do partial clone 2, backfill min batch size
> 
> It would be nice to learn what the file contains instead of the expected
> string, which might give us a bit more of a hint what's wrong. You can
> for example apply the following patch:
> 
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 79377bc0fc2..197494cd28c 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1975,7 +1975,7 @@ test_region () {
>  #	GIT_TRACE2_EVENT="$(pwd)/trace.txt" git pack-objects ... &&
>  #	test_trace2_data pack-objects reused N <trace2.txt
>  test_trace2_data () {
> -	grep -e '"category":"'"$1"'","key":"'"$2"'","value":"'"$3"'"'
> +	test_grep -e '"category":"'"$1"'","key":"'"$2"'","value":"'"$3"'"'
>  }
>  
>  # Given a GIT_TRACE2_EVENT log over stdin, writes to stdout a list of URLs
> 
> If you then re-run the test with `-ix` we should end up printing the
> contents of that non-matching file.
> 
> Thanks!
> 
> Patrick
> 
