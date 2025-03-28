Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917ADF58
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743176251; cv=none; b=NTNz/zNYFGdfEOZfh4s505MngaPe5YX1+dx77r6slYBLWy0ByXQNbyRb73/wndrWcmXfX+AOCOjcR5jgVbV4FPjCAqm4TydBZXzCdie2sXFkyrzx15jCQIl5lsDsni5Z20+I2LYrtDvVmN25edGuM6W5CXvpukZUfb2VGlCpsNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743176251; c=relaxed/simple;
	bh=Nrx9A4OmerjVIahVf4z1sPLrxjDBfgxcZfwvghV9imQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M72p+jUF1ddIM/S9sGpyEuudXQmOYO4VtgG5536ukuGOZt5v/YXlXv/1WCav/L8Hg4I4ZQNk9Jg2DzSM+f5bsyEmHq/yJFyQifqWh0FPq+xrIfz71VU+ztFpHtRyjEHe3S0c9pj7X5/+g5gKvOueWt+xFvjZsRnqdtw++kv0V3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=et6+lJZt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YbGJOptQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="et6+lJZt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YbGJOptQ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AAE4E2540123;
	Fri, 28 Mar 2025 11:37:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 28 Mar 2025 11:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743176247; x=1743262647; bh=JtjmSoqpGO
	CHTWOzMa6azTjq9b5L/A4ZZUNk6GAPQP4=; b=et6+lJZtRTLElgewRKrjR987KP
	N5JTXpObZR5YPvgurHcxECtTSf6nAwVFhAUiYYD9Aj4QVUWTdGvTkM3rFpuqhPzx
	UzF3fZIHULT62i8eRxaAp+a99SSfvyK8+ykXcZu7xM4ByxiVwrSbDeTvoIkEl39f
	lzl49gMroYMyQ/yRLOBucHCzn570E6HuOtuTo7Uj60WM52erVs8mAGPYF0MLu5Hx
	KTYaxGG5834QGvyXicliOjfViQhcklw5nJ9T1xg1SvXis822X4v7d81AjiBwQoQY
	/p80ZT8a0vlgTfFpYFe7DiE+Eox+3CsOdlnK554hmSsqabXs6+87LO0lxwMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743176247; x=1743262647; bh=JtjmSoqpGOCHTWOzMa6azTjq9b5L/A4ZZUN
	k6GAPQP4=; b=YbGJOptQ6LG9uxpouMwwT2HNFPhPmkqLE8oXY9uaTaaXCQBkMsc
	M21hHyWcGLJEPHq+YQ1x+9RugOz5Sfhc7pGnLRKiPacANxUzt+6Xh/inErRGsr/L
	mn2lhb4LOztnP+UjU63FMwZg1uj6Xu3l++YKIqozXrcdLu9zbv/Su5OLW+WtFJkG
	r9BqpAvgCdEbb6LvPEelREhcPD2yzzEydrg3BABuUSZb+eFGb7FQITK3gDnEBS+O
	DJ16buXZTv74nFo9ClCBwtK80xZJjJHal0dhVTZJsGgUWO6AVLGyZY5NVTQtm76M
	KjAluX7zyALdFunUWhYOqNDR0gPWoHG124Q==
X-ME-Sender: <xms:N8LmZwen7bEH61QviWAj7Ycyln5dakzO2THp767L4RZHIGVjad8aDA>
    <xme:N8LmZyOEqppt_TnpzGoulp5UasROovauob-OhiB1LlV89hVwpy2j5oYpJGCu3JjHb
    Q3JywNCd9QE3vhgWw>
X-ME-Received: <xmr:N8LmZxgN9i5ULAC14IpEgPPPFOyBH8hnPhjHmUrpwy3Mzb-Y2p3XeGKEE1DxnJPeNnlbaomxyq9KxsSyGSmn4HdNuag6xgIOpbSFMNE06ClmoXvvcskW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeduieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepvfhougguucgkuhhllhhinhhgvghruceothhmiiesphhosghogidrtg
    homheqnecuggftrfgrthhtvghrnhephefgvdduheejvedtudelleeguefgieekgefhveff
    ueffvdfgheekhefhffejhfdvnecuffhomhgrihhnpehfvgguohhrrghpvghophhlvgdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeht
    mhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhn
    rdguvgdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghrrhhitghkshhtohhlvggvsehg
    ihhthhhusgdrtghomh
X-ME-Proxy: <xmx:N8LmZ1-PijVe8lJ8AFLf2K8TMA3XO2PAoWSpivjTcn5F25rWoY5EVQ>
    <xmx:N8LmZ8spphLs_AshL8rHJnYniAdriHZ_suuj4Vma8i1UcsEPehmCXw>
    <xmx:N8LmZ8HJVkzjw6PVBSKvBAOr13CMyYpJ752rsu0C8BPpJNCQHm0Jsg>
    <xmx:N8LmZ7PewEiyzgmj4oIIk7w4gw9BMcjBFiYn8-4oO0pP_zPLM3cAkQ>
    <xmx:N8LmZ-Jw_ty0d-7_WaT8UbX_hv_tWkd9PvTujoiqrQZg5mUmZm5z7ZMB>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 11:37:27 -0400 (EDT)
Date: Fri, 28 Mar 2025 11:37:25 -0400
From: Todd Zullinger <tmz@pobox.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: Testsuite failure on s390x and sparc64 after 6840fe9ee2
Message-ID: <Z-bCNdOOLrM2Chb8@teonanacatl.net>
References: <89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>
 <Z-R_Zmr6kxCPLm-O@teonanacatl.net>
 <Z-Zr7BZL1UGqVxKu@pks.im>
 <4276c8d0b72f11f325482756d3bc251327d0ac47.camel@physik.fu-berlin.de>
 <Z-atRMGXHilZRTEL@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-atRMGXHilZRTEL@teonanacatl.net>

I wrote:
> I don't have a lot of time to poke at this today, but I'll
> make another test run on an s390x build host without that
> patch, but where I can save the output and post it
> somewhere.
> 
> For the Fedora packaging, it will be something like this:
> 
>     make -C t all || {
>         (cd t && ./t5620-backfill.sh -ix);
>         ./print-failed-test-output;
>     }

The matches file is empty.

    $ ls -lhn batch-trace matches 
    -rw-r--r--. 1 1000 1000 31K Mar 28 11:09 batch-trace
    -rw-r--r--. 1 1000 1000   0 Mar 28 11:09 matches

The only match in batch-trace for promisor fetch_count is
from the previous test:

    $ grep -e '"category":"promisor","key":"fetch_count","value":' batch-trace
    {"event":"data","sid":"20250328T150939.623820Z-H9aa15b67-P0008f613","thread":"main","time":"2025-03-28T15:09:39.625484Z","file":"promisor-remote.c","line":55,"repo":1,"t_abs":0.001777,"t_rel":0.001777,"nesting":1,"category":"promisor","key":"fetch_count","value":"48"}

The trash directory for the test run is here, in case anyone
wants to poke at it:

    https://tmz.fedorapeople.org/t5620-backfill-trash-dir.tar.gz

The full build log is available as well:

    https://tmz.fedorapeople.org/git-2.49.0-s390x-build.log

If you search for 'BEGIN BASE64 MESSAGE' in that, it
provides a command which can be used to extract the full
test-results directory.  That's used to get the output from
the build hosts where shell access isn't available.  I don't
know that it's got anything which isn't in the trash
directory tarball which I already extracted, but it's there
just in case.

-- 
Todd
