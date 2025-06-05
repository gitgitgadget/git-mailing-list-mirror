Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0851C4A20
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749121857; cv=none; b=iLq82+98wLsHP008kDjOWFxcx35YH06rDVfX0CzU6P7W6/yYHuWmoJj42KBjM0coitezjfY3OB6w+R70ntGR5zQy5t2T7jqKG4sFNZqC8pQ8nR5ZEacJQrLc20O+/T1dvW48m9oj0llUbjL/CmjMiu5K1KiHadtqlV0gGHHmHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749121857; c=relaxed/simple;
	bh=Kda3Kg509aq4XXrkWCldUaLhw0XCS/Hg3SfwI0sHo1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agUIGNxHyDeodXeGXe5IK14NzPPDr0rzzjpmeuswX/kkB95b+9D5nZ2oYXeA4ZIct3+gktJtjRxyTzj8aNE3c8DR7BBVqi+0wNerOhzMOiSNaJZcRKwf0p/x3hD5IUjxj4Hdb5CpyY55USyIJM/NCyvK96dzbXmaC6cnB1W1VA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gm7U1Y4z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VVZ1Qgk5; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gm7U1Y4z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VVZ1Qgk5"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C082F1140138;
	Thu,  5 Jun 2025 07:10:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 05 Jun 2025 07:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1749121853; x=1749208253; bh=pixXA9w6tI
	cppOsKT0rXr0Q1LBx5gmCZhQnqeA+DwCY=; b=gm7U1Y4zLcqYpHWRMZJIpMz39S
	0pEMLxeeTIT0DR0fmgDJUQy7r9VhVbJ6iWPdtCc08+6Gpz47DCabBM8E4vQdw7uR
	44WNA6ud/2Y9fe8nUXb+An/hDExNyuhH+6jmW8sLOOQs23Msjenr3F6OAcesC+Fy
	aC63byq2aOLhQLQNbff5feplkJ2HgfXg362k5+FhLnE7P+4OucmrXlJB7an++M0M
	5NQdwe1GVbB5GpNWRFXfg+FAQM59g97llr0fKYr9oUYBjG0GZtJavwTNClVgAI/r
	yxuqNwNt9DynycNjpcJPNVnFOBkZMD6Xq59t6LFvuYwazVjbZ5Xt6akhMu6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749121853; x=1749208253; bh=pixXA9w6tIcppOsKT0rXr0Q1LBx5gmCZhQn
	qeA+DwCY=; b=VVZ1Qgk5qRD0Kvwis4smQK8+Cgjeh7g1lWFX+fj4wj4JI9kxnY9
	KvJUurJjWYkFSBqPaL+h2bX/yLG1QZ92nerEUpRHn7xj3XCFpVPGNZ7fdhyQLVoT
	ru03wxa0nDSYfy2RbcrBaJ1YnMh3MPRgfZP/Wr+lCBHlwxgR9XgrJCHe9L1wSQRo
	gfdAqQhJRb4YGGNnIpCOsGid65xOm2Mf5xGw5uodoBWViIjsmriL4Tad68mHkCqB
	6BqgLwzrC/AMVjOvSE7YI+G28YbF761rKiQPDumlfGySEGMy8rTz+OTpnMM6YOLQ
	+7y8z+yXPTL8IgG2V1WJC641knDoMbN+S9Q==
X-ME-Sender: <xms:PXtBaAPV63LE_IRZ6QN8JVC9GwHdO9x_lmwkuUqYy9SLAaFzp8OVXg>
    <xme:PXtBaG-AhBAc3v6zk3gDn-H8N014EpZuktQ1tyQq1S7Hf-q0ZPq-jgl-ScMCl3fiH
    vIqXwFfMk7KnU2EFw>
X-ME-Received: <xmr:PXtBaHTBgrPUPFqzaExP04dI8yTElg3Cl8HXa9QquZJBR4_kciQq_LHqTNUgRu7lQCAo5EJRSQ-5c9fqpJ8ByvYu-O81tVRuocX566cjTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgt
    phhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:PXtBaIsCThyPnvv-dmDv8x58NA5ymm2MPkHBQ0w_W65_Z-4CBe4HRw>
    <xmx:PXtBaIe750FjZcU8cLmks5qTKeet39AwXGcN-waW4Vhr7BV2erL6Nw>
    <xmx:PXtBaM2-gLWOKEnbdxA-bc_le0HrPwdVFNfLv3gb-Y8oTesBoYELrw>
    <xmx:PXtBaM_81hAPTjl_AAI6e_5kUdMnJWyCOYv2IXjjfaQELl6gwfgz0A>
    <xmx:PXtBaEK0aMVZHyEKk0WiCNiyN_W8MXbv3-9Q3iuUqC_f_L-0cicdaSir>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 07:10:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 86346221 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 11:10:51 +0000 (UTC)
Date: Thu, 5 Jun 2025 13:10:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t5410: avoid hangs in CI runs in the win+Meson test jobs
Message-ID: <aEF7NRgEfMhQmDw9@pks.im>
References: <pull.1932.git.1749118606047.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1932.git.1749118606047.gitgitgadget@gmail.com>

On Thu, Jun 05, 2025 at 10:16:45AM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> index f76a22943ef..09d6bfd2a10 100755
> --- a/t/t5410-receive-pack.sh
> +++ b/t/t5410-receive-pack.sh
> @@ -41,7 +41,19 @@ test_expect_success 'with core.alternateRefsPrefixes' '
>  	test_cmp expect actual.haves
>  '
>  
> -test_expect_success 'receive-pack missing objects fails connectivity check' '
> +# The `tee.exe` shipped in Git for Windows v2.49.0 is known to hang frequently
> +# when spawned from `git.exe` and piping its output to `git.exe`. This seems
> +# related to MSYS2 runtime bug fixes regarding the signal handling; Let's just
> +# skip the tests that need to exercise this when the faulty MSYS2 runtime is
> +# detected; The test cases are exercised enough in other matrix jobs of the CI
> +# runs.
> +test_lazy_prereq TEE_DOES_NOT_HANG '
> +	test_have_prereq !MINGW &&
> +	case "$(uname -a)" in *3.5.7-463ebcdc.x86_64*) false;; esac
> +'
> +
> +test_expect_success TEE_DOES_NOT_HANG \
> +	'receive-pack missing objects fails connectivity check' '
>  	test_when_finished rm -rf repo remote.git setup.git &&
>  
>  	git init repo &&

Quite interesting. I any case, I think this is a sensible fix for now.
It's a known bug, we know it's fixed, we just have to wait. And the fact
that this prereq will basically auto-disarm itself once we have the new
version is nice.

I did wonder whether we can maybe rewrite the test so that we compute
our own packfile instead of intercepting the one from git-send-pack(1).
But I'm not sure whether that's really worth it.

Thanks!

Patrick
