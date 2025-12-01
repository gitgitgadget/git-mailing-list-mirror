Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7C30103C
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582427; cv=none; b=GalJ7dH0LOWg5vFW/8FACLNj0Mo937+b1r4kiC65JLgbcbTMuSlBXmmO+IHvMFl/0L6LtaPmfXanLnlt/3w+oBuTLyaZHLS7FQfyd1ch3tYe44Q2yv7fn5V4tF/sr2Byq9rOZQZ1f2a9xIb44jMTHDVq+sRu71TdIfsPzHxhdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582427; c=relaxed/simple;
	bh=Rggxo+y5RGAcG/kZfjhHfbEMemwxDAYrakB/UES3R6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQk+TH7p4Y338cipbQmPNgX+pJAPmavjSRyKT4ICn5tlovx1OrjUnAdeQyfXZ6QPJa/UWa+s15qIwy/yGpuozCIeoIDJcz/+L4aAaG4AyVzIr27QY4pa6tOsNIKfDbRYX2KIsvau/fy2O1g7T67Enlt+1XDp6jMBDmTttxdQA+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aIwooeRf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=miR971EF; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aIwooeRf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="miR971EF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AB805EC070B;
	Mon,  1 Dec 2025 04:47:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 01 Dec 2025 04:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764582423; x=1764668823; bh=nBTDQbEisd
	37adxHhUd7MzYvVJvDyhTihQFtAxY+bv8=; b=aIwooeRfwHBqDy/YZAprUly5mr
	VKUIkpYzOS+GlKAVY61Rere0hA22LI61nqGbfFjDCNgBvBW2USdWzR7+tE3wSrXE
	dbrBb06MYDyebGsOegyircW4haEO9KvJzXuPj0qhKDXjTHcXBM2W+o6J+QsDitK5
	FXLVfm2Ntub+urDLi7RyHe5RKEt3lJisYTAOOhuNcQLJeeKLSXJCfcKHxex7ir9b
	Mc3P6e+a2HbACKN/LdDjj5IhgKGMOFOx9dZqoZaYwxcUSd8O1CrQI8J8nZC/9RCd
	wpXEMPdr4oeWoW71VTe3ysXvjOSzVROx0e36AD+Z+Oer2wWAakq/8eyITBEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764582423; x=1764668823; bh=nBTDQbEisd37adxHhUd7MzYvVJvDyhTihQF
	tAxY+bv8=; b=miR971EF94I867VN8wvBdALIQxkV+X5wE4NPwKAMV2YNMAP+7uk
	wOyevVdNPf7MTrLvkdaWlk2e1LTUHgHvaXhJMokxxaK7F3x8eGmM48mNFS63nwwM
	leOCDEdBVIf+MHxT/evlAIQcN58OQdpN3D9FuTz6TNykx8XZnxUGm5ROV9gn19gF
	OKc3NC6isFbekuDEFIRt1U4uwxlCKlzdwGjU+aMiLApWJh0ZiLQjWPyykXcdlLHA
	ROk3evc76Tz44gAj4Ph5zpjwtIbVTKSnounE/18DwfJj6yMNQSurEfnyU6ZMPcrF
	fQPm1YdjTe2m4/X9LMU08e7IUBrLvZkTNeA==
X-ME-Sender: <xms:F2Qtac00V1hTV5FP0TnmVyG7K9HYIZYm9-ZA-UEfxy_wVIv1V0a9Tw>
    <xme:F2QtaeigXxul0Qy8lLgZ971DYrn54JZeb4H7VLxk4wcM407JPgN9Py-Ai1m84dGor
    KFUC-_PBbpgk2n8rygGxdlQ0MRFYMeILsYvTO18EC6ZIyMrTt0Krg>
X-ME-Received: <xmr:F2QtaST7pUwf_MyBA4TP5uhUPFB6gXbIf9eWekisxKJTCyegGdW1Fa1V6_K2yk6doDkNFX0I3TXmgIZx19aOqYxmB-XOyh9_aU3E-LZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:F2QtafjJSGiZsSgxUZ-LtruHd4HaejbHaLwWrqekSSmyxbxc3yK44A>
    <xmx:F2QtaS5KdHfW99jPMy6_GXfG8clDEMVh45mjonzYXZ37iesONRwjzQ>
    <xmx:F2QtacBqIqgTlxz4-aiA9nI1QvHj6L4IhDy7SHEkloZYAa6CmsjQbQ>
    <xmx:F2QtaZb9Ytk_vq3GUKUxDC1gpbfoUGEcSre978Ktux6hU0PrnIeZgg>
    <xmx:F2QtaYDVKQTb6UEJJ-b2v4rvQB2zGxWKswWVKHTvjUrolmMBtstxAFwr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 04:47:02 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 56f69472 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 09:47:00 +0000 (UTC)
Date: Mon, 1 Dec 2025 10:46:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 06/10] t0600: fix incomplete prerequisite for a test case
Message-ID: <aS1kEb2dvLU-7FnM@pks.im>
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
 <0866db0a17d88016617e7e626dc032af599679c8.1764440906.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0866db0a17d88016617e7e626dc032af599679c8.1764440906.git.gitgitgadget@gmail.com>

On Sat, Nov 29, 2025 at 06:28:22PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The 'symref transaction supports symlinks' test case is guarded by the
> `SYMLINK` prerequisite because `core.prefersymlinkrefs = true` requires
> symbolic links to be supported.
> 
> However, the `preferSymlinkRefs` feature is not supported on Windows,
> therefore this test case needs the `MINGW` prerequisite, too.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t0600-reffiles-backend.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
> index b11126ed47..74bfa2e9ba 100755
> --- a/t/t0600-reffiles-backend.sh
> +++ b/t/t0600-reffiles-backend.sh
> @@ -467,7 +467,7 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
>  	esac
>  '
>  
> -test_expect_success SYMLINKS 'symref transaction supports symlinks' '
> +test_expect_success SYMLINKS,!MINGW 'symref transaction supports symlinks' '
>  	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD" &&
>  	git update-ref refs/heads/new @ &&
>  	test_config core.prefersymlinkrefs true &&

Makes sense. There's a couple more cases where we set this config key:

  - In a subsequent test in t0600, but there we explicitly set it to
    "false". So this would naturally be supported by Windows.

  - In t7201 we set the value to "yes", but we never verify that the
    written reference is a symbolic link in the first place. I guess
    that we could rather remove setting the configuration value here, as
    we are about to deprecate support for symrefs via symbolic links in
    the first place. But that's certainly outside of the scope of this
    series.

  - In t9903 we do the same, but likewise, we don't check whether the
    written file is a symbolic link.

So yes, this seems to be the only instance where we actually need to
adapt tests.

Thanks!

Patrick
