Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9541F34CDE
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 03:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733454480; cv=none; b=b79t9cuCEJlDC8Qqo/K+Am5sTToxZAXNamBWoXny/oCDxAnMu9OdQ+nTLXdJOa0ZdqZcsuTgalM6kslOw/Pm4wBhA+r5IrkinpkNA0r6h4oQz/jkqd7fFtt0kBjYAJOibF3sbMv5dvgzszO+UV1WG+9ujWLeupHCPGW4QPW0wiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733454480; c=relaxed/simple;
	bh=P6P2hzQDimL1Ge3iCNL+h7C1rjA4W6b5lTfHx2FDDFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T5B+d41ztOtFy5rEluCqkSPfyQgc4Oh5UjTMY0GBHPtQprT2CEoVAIGhKmti7KqjDvCK78GRN+6kAKetr1itWIpEQ93n24dCCVZJpsTRGkksfzTA3zLKeRh93J2cSvoN2WV7tueUlbWdkXZ8sTl8zzAB8Ip0wo4gs+2N72tYcW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1HLPMPIE; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1HLPMPIE"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 85453138014C;
	Thu,  5 Dec 2024 22:07:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 05 Dec 2024 22:07:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733454477; x=1733540877; bh=I/AI8sblAsdsJIFVlqyGVSGasW7nUb9DNUC
	HT/dkczM=; b=1HLPMPIESwkbCkmExK17WQR1KJRtFzR+gVighKhKxcMznRjVoGt
	DfeTHWlukxrc24GWyy9wV/+mooSfGE8aQc6Tuu4i1iOP1UbrlmSWc20rSOke1nAJ
	ubpL8bHbMX6/VvPsLWh9YFoyCdYsg6O4sXlik139qm2YSbSmGvGlc/PAVlGvBEja
	yvmwLG8jhJF3vNXtw731eBEJ807cPpTQPqZwlCp8+wa5h9apoi/Y8j+tikaGKrdC
	7WDOXnxtnwsfADVtiGQdpNo7KUR9uFp1vQjWZ9c2XhYmZVxgbtqU9ApVm0rePEw1
	4hHnmNXzjAV89JI/ageBiipew6234mJDT5A==
X-ME-Sender: <xms:jGpSZ8aFDy8G9dUsAL1kfxDaOxcmTmtpByfQOCR3MVqAg1-y1llDgw>
    <xme:jGpSZ3b1SUoe_7G1LJPJop_wn6NxqOtQliWCZ4g6GC2OBvhWgINlQ_8uJwxubQy6U
    ZF7Lz335WeFI3AMYg>
X-ME-Received: <xmr:jGpSZ2_fLagkQuELUFlfx3UvUUa6XVFMAFzeYLE04b-1gILUiKvqilX9z9waHhZ2gLJGH8V7URoKrpZuUPGRRFGk_KOjRwFFiNPVyIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieekgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthht
    oheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhih
    hnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:jGpSZ2pIfVOUA_PMqt4DcfJG1ps4Y9JSBwDEN0TPlP3-YsN9T5uEew>
    <xmx:jGpSZ3rVYgWF8VGzXQTAVmb4LFUZqrGMf3YCj7vOdsa96ilAoniKFQ>
    <xmx:jGpSZ0QdPzAtMVPu6uS3SfwpLTxcmKe3t5GdZ5QdsmymxbNefgposQ>
    <xmx:jGpSZ3ofeKRTUepIuXLYejarH-KmrcZjICb269pMdxtNGNU2TQYgVw>
    <xmx:jWpSZwQJp7-UuPEqigHbC8FJTJVyNTpDnrtoFB1ZivDDKVr8GzwXaekJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Dec 2024 22:07:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  bence@ferdinandy.com,  phillip.wood@dunelm.org.uk,
  l.s.r@web.de,  Johannes.Schindelin@gmx.de,  karthik.188@gmail.com,
  me@ttaylorr.com,  ps@pks.im,  jonathantanmy@google.com
Subject: Re: [PATCH] Fix `git fetch --tags` in repo with no configured remote
In-Reply-To: <b41ae080654a3603af09801018df539f656cf9d8.1733430345.git.steadmon@google.com>
	(Josh Steadmon's message of "Thu, 5 Dec 2024 12:27:20 -0800")
References: <hpaekjhdpcovhdptdntdligp5jcdp7mygh5brnggu7itf5grzp@vl4l7uwnb3n7>
	<b41ae080654a3603af09801018df539f656cf9d8.1733430345.git.steadmon@google.com>
Date: Fri, 06 Dec 2024 12:07:55 +0900
Message-ID: <xmqqo71pzeyc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> In 3f763ddf28 (fetch: set remote/HEAD if it does not exist, 2024-11-22),
> git-fetch learned to opportunistically set $REMOTE/HEAD when fetching.
> However, this broke the logic for the `--tags` flag. Specifically, we
> now unconditionally add HEAD to the ref_prefixes list, but we did this
> *after* deciding whether we also need to explicitly request tags.
>
> Fix this by adding HEAD to the ref_prefixes list prior to handling the
> `--tags` flag, and removing the now obsolete check whether ref_prefixes
> is empty or not.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  builtin/fetch.c  |  9 ++++-----
>  t/t5510-fetch.sh | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+), 5 deletions(-)

I see Bence is happy with the fix in a nearby message, so let me
queue (and perhaps later amend it with Acked-by from Bence if we see
one) the fix.

Thanks.
