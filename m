Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D142A1C9
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235463; cv=none; b=SjHha2FPWmtdrlZ5s9Mo/qcVnVRiWikgTJobsVcM8V8vp3t969S3x9b5zGmRn82VaslQXMw7moHV5IJbp4eAx3bryQCNNteHIPJQV2LJbg4xdRcGj/bKZseAPgtWiAKZnC6CI8qhLH9EjgSluMCALqL2rag+wm5GjlxTzz+g1UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235463; c=relaxed/simple;
	bh=H1sOkhGRsTJ8cCtztgLCimw0uCo93O3homC9Q2+bAAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gxqakj554+IMJXqoo9vnu0XLb8RP4m4V8hwV4RSyuYGd8utaR+Fw3pjsNUJTPHXmRDxQDW0ewbTcoPYz8jyvMI2n8jrPR7yDjP8d4V4s+azV6J+pAb33ieSz7Bix726GWAolnvBNPcPi7xFdPB+ndefK5S9YCy37keVvv1HJRoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QLs5iyNX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lBnVWsbm; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QLs5iyNX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lBnVWsbm"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 605C81380198;
	Tue,  7 Jan 2025 02:37:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 07 Jan 2025 02:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736235459; x=1736321859; bh=PyAUTXjVEP
	Mc24sR1RBDDAeqiTfEMAycQOLqNME03HM=; b=QLs5iyNXbseDFfUQuAN6axrBC8
	vuGQhFW9TDOIKBpI1yicNK1yulD6ungtwEAIZ1hOBhRNFkjDUTQ+w5x7yjL57x2B
	j7CKVwpnKbqoKWltBTo32kGe4jRCl8z7li5gcEcvM8538TSQYh5EU2AKFxpetSxf
	n19GuBP6hEZ/kskRnXUULqHKxdcL0b5AXDTXjZQOd47C/EiBqBEL6qmHtLrNhOmq
	sapI7Z4g+DeAlloisDL7uSQ0bPgqAqBDFPdAKWRFEzmggNspnXcU+XLIr52h32WZ
	UOHbOi8/mVVejdl0DBtS3JsKk219qkTfMDu1UR2u8xtM7zpBeGodFysT1TmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736235459; x=1736321859; bh=PyAUTXjVEPMc24sR1RBDDAeqiTfEMAycQOL
	qNME03HM=; b=lBnVWsbmeXq2UOM9f1r4aeqYVHQaLEZIDPz4TllopN3UxN/fMqZ
	2DDi2bUpGdmGfFIw1rTqi3LGXlQAtnFGjR31bQHvaDWt7gEkc0HjZp4pGhCD5dY6
	YQWAfVUUWA8r9L63zNpvXJiHJE1MtRTVilU0MNQa5EDrU5n61VPornXjkaODlsy1
	5ccBCeSuMUhPnQVCm4wYizTCUGVQFr+Jeg4JJi7tlmU6P1iGiOKow+2WfQSQ13wI
	uAeepxvs5EoDSE9qBCtApX6rPXZ8yjYa1lMcuFYZmRQMoZkhhpe547q5cfpCAH3w
	YGZpLMArsA06kQJeeYMQJH+zv/1fXDP5EzQ==
X-ME-Sender: <xms:w9l8Z2zy-6-eVQxJs4H-Ft2wkzwvv8qSduWdCkgdLKCb0k6jrPstkg>
    <xme:w9l8ZyRcmbULRc7f39N4SnCbVC62rWg-LxQ4V5PPx1yhqRrzESkTNglftiDHSBazb
    cI0N5hfmrCBG4Q7Cg>
X-ME-Received: <xmr:w9l8Z4XrpDvus1Px8SpgjQskyDr8fyavTbUgeol2vklQ3s_eUlp4CjSrr1goFVOSovH4RahlmBEZv97JfxXX4MMxmPoeo5xd39Aw80BgEw9NYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:w9l8Z8gxUUp29VrGYDUar7y8lxxCLt_mGPaB4tPzUq3unbvE0m7z9A>
    <xmx:w9l8Z4Cm7yexLs4KEknqI4TTvr3ly5bZl0G47n3hJXD3i2NgcVMfqw>
    <xmx:w9l8Z9KAh08eKLn-BTObH8L32tCkmgjAXjZNgOkRVFUk9EKcV54Eag>
    <xmx:w9l8Z_AWpOpIzM36-ylG5Cfy0g5L_RZORIFMZEBGz2ag2CAdMHFOZw>
    <xmx:w9l8Z7NufFtssOmVzgb2RwH6_fvcHZHkIgbqi8G7iffPafBvAX4O0tlT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 02:37:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de1d1a36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 07:37:37 +0000 (UTC)
Date: Tue, 7 Jan 2025 08:37:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] test-lib: add a few comments to LSan log checking
Message-ID: <Z3zZwDFJ-FWYYIw4@pks.im>
References: <20250107070409.GA584456@coredump.intra.peff.net>
 <20250107070831.GC584668@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107070831.GC584668@coredump.intra.peff.net>

On Tue, Jan 07, 2025 at 02:08:31AM -0500, Jeff King wrote:
> Commit b119a687d4 (test-lib: ignore leaks in the sanitizer's thread
> code, 2025-01-01) added code to suppress a false positive in the leak
> checker. But if you're just reading the code, the obscure grep call is a
> bit of a head-scratcher. Let's add a brief comment explaining what's
> going on (and anybody digging further can find this commit or that one
> for all the details).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/test-lib.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 898c2267b8..9f27a49995 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1172,6 +1172,11 @@ test_atexit_handler () {
>  check_test_results_san_file_has_entries_ () {
>  	test -z "$TEST_RESULTS_SAN_FILE" && return 1
>  
> +	# Lines marked with DEDUP_TOKEN show unique leaks. We only care that we
> +	# found at least one.
> +	#
> +	# But also suppress any false positives caused by bugs or races in the
> +	# sanitizer itself.
>  	grep -s ^DEDUP_TOKEN "$TEST_RESULTS_SAN_FILE".* |
>  	grep -qv sanitizer::GetThreadStackTopAndBottom
>  }

Thanks for adding this comment!

Patrick
