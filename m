Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC6238C2F
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761893331; cv=none; b=B4JN9+b7qnUrKhhzAPSD1yMvQuKG+yJ2jKM4cKxDhs59dtgGcCH5lkh1jryBo5xlZ4fmIG/Zp1mJ9hUWiYuduKckgUIKaPliWfSCXGxnxPdqLgFc4l+o1Gvkl/e4Av1w0ZYKC2r0RXo4CqLEe1hALRkHXSGelAfkbTaFH8HlsIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761893331; c=relaxed/simple;
	bh=ddn1RNBrCfvAB3YVLvIcw8n9Nt+DP4dbq6QdV0z0T2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gf9wrrgjoPVjr/H5HyQhl/dq93WV5wuTGy8xgU31NIhc67S1ILt7JhoBTnNTY/V2RkLSywBNinwYsKU/5HRwR0hTicZHygPz/ILocUwHXuuJaNeqXnD90O3SOsJH1uV9BzF/yUzqBNBqStDQR2xxXFkf0aFLN0eTyuHAkG5A0yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j0jE7Ch5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EVaFlmM5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j0jE7Ch5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EVaFlmM5"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9FADAEC0204;
	Fri, 31 Oct 2025 02:48:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 31 Oct 2025 02:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761893328; x=1761979728; bh=aVrgrdOQ7n
	F5yuRs5O/Mz2UuJDsj9RHt1zHcxn/uwnU=; b=j0jE7Ch5UyiAIr8NCsaHhQ//f+
	+eJwVZtPL0f7/LsW8+WIo1myT8yO89M9wM3WawAQ+M1DG+nQPbfrIdNgqtm2QZGP
	2O2NtM7L1rUGVj/HNkLTM/xXpJiX6aAn0tl3CL2YNlPB6VBdEy/W/mBkTWl06W1+
	zVrXjEVdTCa153D0Hssq1PWslmdIHGM8e648R4PXMuZatuyZSXlJBx1bf8GZl1zh
	DLmAQg8jeon9fRIkII41akQ2g3g+4E1KCC0SySK0XpIiN1j6oyMqS2LD3xV5Xo1f
	AFWsGhV6hL+/xZ8lu7LClCsnG7DBNC7wQ1/56t8pTFf1RUBOXYmDeYKmH9NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761893328; x=1761979728; bh=aVrgrdOQ7nF5yuRs5O/Mz2UuJDsj9RHt1zH
	cxn/uwnU=; b=EVaFlmM5HbpO1FqsfgsspDZdIH7PI6yVbC3ykoTA4q5yt3NCEZe
	PIWsjooNomaA+e5DKYqnHP1NPMpHfKILibYCykomYvhd446+DQll7mI5MEy1cnRU
	aKyVSVfG3U2WHvReTfONs695+igM56YDgu7jfD2lfU2sb3FLvDjLTsYspgNeRHgO
	N2q+a4vafCoH2eB30JSTkgQVAVJV4jJTpueXf2zBCxrGC0gZpSDMAFWTJMZVCfyZ
	4jCLqnciceUZKPMrhRRwNIQrzftqZm+awS+KAMKOrYL66vKtnPP1kWNcgCmqoilw
	rc6NZ0oOwYS1MRHRqJQbFs18/hKapD+ylXQ==
X-ME-Sender: <xms:0FsEaZZIHVoLcbtUKsCoYJOu0a_ca8aGGBCsKFcvESre4YLKqQaDPw>
    <xme:0FsEaX2jyF0UcEDFfM4hSQDCf6NeLpT5eIwdXZIXWZYvu3l69Fv1CXPH7dUffpBzd
    51k8IZRH8nv4zbfNXh7GgAn8OrnV2Yjw7Tue-Z0oi_cCUD434M-CA>
X-ME-Received: <xmr:0FsEaZXyCYOwHT0P9uoHGiJ6Bl1r5_CjzcKkprcp9mMxa215ikaAvfuKvyIEtPb9BUTmyjvfRd2UND0cBt4n3EyQ1BbDcTdn2HneAzVc1uMt6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehrvddttdelkeduuddufees
    ghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0FsEaRWrVHu841J6ctb7miPoHzCavvz5wWTHIWTG2sgFBm9DODtKOw>
    <xmx:0FsEaYcxf-xQ8ywq0wzcdK1o1xEJScxhCauOQdFlhWDELFTnt3vLKw>
    <xmx:0FsEaaXhrL0wdNLZizr7IW-S2IS1Ri1fZ8bTB2zlHJ4a_Uj2nEx2lA>
    <xmx:0FsEaRdbRZ2aE3ZgNADw4wrdraufSPj2aKp7mVkI7FR60p82imyw0w>
    <xmx:0FsEaZSr_TP7RZCGPQEpsVifbhiitGrzRGqaXGoZ9fyw5Zawq3fjF2et>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:48:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 85cddabe (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:48:46 +0000 (UTC)
Date: Fri, 31 Oct 2025 07:48:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Xinyu Ruan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Xinyu Ruan <r200981113@gmail.com>
Subject: Re: [PATCH] refs: don't clear oid before read_raw_ref in the debug
 ref backend
Message-ID: <aQRbygXjkffQoNPi@pks.im>
References: <pull.2089.git.git.1761881825025.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.2089.git.git.1761881825025.gitgitgadget@gmail.com>

On Fri, Oct 31, 2025 at 03:37:05AM +0000, Xinyu Ruan via GitGitGadget wrote:
> From: Xinyu Ruan <r200981113@gmail.com>
> 
> The debug_read_raw_ref function clears the oid to null_oid before
> calling read_raw_ref, which causes the oid to be lost even when
> read_raw_ref successfully reads the reference.

This sentence doesn't quite make sense to me. If `read_raw_ref()`
succeeds, wouldn't we expect that the OID was set to the target's object
ID anyway? So why does it hurt to set the object ID to the null ID if
it's going to get rewritten anyway?

Another question is why we were setting it to the null OID in the first
place. Ideally, this should be discussed in the commit message.

> This leads to failures
> when executing commands like "git branch new_branch <commit_id>" with
> GIT_TRACE_REFS=1, as the command cannot find a valid branch point
> because the oid is null.

This smells like an issue that can be be demonstrated via a unit test.
Right now though we got zero testing for `GIT_TRACE_REFS` in our test
suite. Maybe this could be used as a starting point for a new test suite
"t0620-ref-debug.sh" that exercises the different callbacks?

Thanks!

Patrick
