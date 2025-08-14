Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A10266B59
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755207615; cv=none; b=XQHz4xC1+C/OJumeU9efy5U3XlrCvPefLfPqX5NRzxrjO67vc3NALwwe6TVNqH6Yo3aH46WkMUAuws//wqsrFEVCyHEW2a4Vg/J0Nogp3e4hN3GBcV89qZE42Z0I2Hr+MqO6ut7r6qqmLrbKLpSS2ZtbIs8bs0XSJppO02xFVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755207615; c=relaxed/simple;
	bh=kS++VPKVsCgiS2A5bdRPVtXvH4YQThi183vnO70JlVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RlLmI0qoWiZ9NDB+Xw0sXoRg6vUiUY6e8lWzah6kAdUtPi0TL/m1fvHuAmrPZWvOajgXTaDZqnj3VBkMJRXWgiyg/akStoFNY+AmCf8o51p5ExxbuA4kuO6hPMuXLfbEO5cWq+o/0nxqVVnCUu2xyYrzx70pEmseffgv20mOMfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iFNimIEJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lq3lri9O; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iFNimIEJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lq3lri9O"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 20C5914001E2;
	Thu, 14 Aug 2025 17:40:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 14 Aug 2025 17:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755207612; x=1755294012; bh=5VST+aP/IW
	uxYhkus/uy+AzJjt94WVgX6KF0jc+gE9A=; b=iFNimIEJUWZpIYlCgNWRT9Ash5
	1hXCKIwuAXZdj5NjiV8IIjLEJkXJ7JXlSkH2E1fGsFiBXAc4Gtw2/G7HcZS/GZAf
	JKjNuNvEDJnlEkeq0KjAaZxdobOA34zZOwhOPumpfPNDsIn9QNQshiD3d7L1N9Wl
	UOevAhU+sqLiVWjNxH6S0zym08s7gbnBQCda3dV7RQe9dpqPRNAtmfw4ntIM6Hv5
	LsSeJBoNXInHt1bUV6M51xAd1s4ii/M+9gIre2OpMskecj1E09dYWC9z37OUSugh
	oq/tym9qJz3+ixrFS5K+r7OsXV8LW15wUDMWDjgdHsamTIxmtbPTWH8/lFMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755207612; x=1755294012; bh=5VST+aP/IWuxYhkus/uy+AzJjt94WVgX6KF
	0jc+gE9A=; b=lq3lri9OMJomdCYA7kwGx7R8v7spLMeRldODxkZOBhDDxo+MW58
	x0Mcb/5nAUCv8gLJoLpbz9wf5g62nrjKLam66P3sGqTfJS1crN4xORaF+cqeZ8RO
	REBRscwfzvKtWAI5i4RdF71QpLWaCspQ4kC5SIV8+6l/8ARm3Qfw+2SzQ4uqBPS3
	scBzCSDfHg3QC5vyv0P8WExOo8wQ3KlfWarPXdLChs0DsoQeJIkYt8BBFH1hPn9k
	hGR+PF0b/6R6fFwe2Q+TEIW2u3dokSfXzO76I8OTcONXhVfkNp08WTythD0FtlhS
	7gd2H5SLsPoS9CYBeYthOMwBt674MMm/A4A==
X-ME-Sender: <xms:u1eeaBr6RaDHyymNP1ypqFDcscUX4Iliv2h5s5AZ6rxZFuIg0ZWfpA>
    <xme:u1eeaPJridsnZ5YijQMYGTnMSJjjdM25uJaUbMrdNmXotolu_TyPqngqirihVO7gx
    kTiM-RAb1n7r0gpTw>
X-ME-Received: <xmr:u1eeaEqMN9UY6icN7Nb5r43qFA-kgbP2VhC0LMTCed_KOj7kMxy6ymbMFIKG6hx-tYItZUPEjPec2aKLPfmO1Rpf8smosp4uPOD_5fc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopegurghnihgvlhgvshgrshhsohhlihesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:u1eeaHz0_mXhHa-GnmEhcSznhBsq9EwMBE5qqNZUhq-hJvqJHDhFcA>
    <xmx:u1eeaIPagWuujGS4VKLI__egcqZyvDtwQRfgM-55IUL0Xcew6On1_A>
    <xmx:u1eeaM4DmdG7g9rgOlSGnjkxyTM5CT_bzIB7E1PmO3lvdP4aWZ5afA>
    <xmx:u1eeaBn06tQ_5OBGhsPcuy40b36B7Brpn8Perlc24WJvFQJoEwGqJA>
    <xmx:vFeeaPIo4fOur6JZxbKvSAq1MA1kNNpDUEDSNML-ULdfKCBRIAj3Kadt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 17:40:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Daniele Sassoli
 <danielesassoli@gmail.com>
Subject: Re: [PATCH v3] count-objects: document count-objects pack
In-Reply-To: <pull.2031.v3.git.git.1755182034719.gitgitgadget@gmail.com>
	(Daniele Sassoli via GitGitGadget's message of "Thu, 14 Aug 2025
	14:33:54 +0000")
References: <pull.2031.v2.git.git.1755177382349.gitgitgadget@gmail.com>
	<pull.2031.v3.git.git.1755182034719.gitgitgadget@gmail.com>
Date: Thu, 14 Aug 2025 14:40:10 -0700
Message-ID: <xmqqwm75y43p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Daniele Sassoli <danielesassoli@gmail.com>
>
> 0bdaa12169b (git-count-objects.txt: describe each line in -v output,
> 2013-02-08) forgot to include `packs`.
>
> Signed-off-by: Daniele Sassoli <danielesassoli@gmail.com>
> ---
> diff --git a/Documentation/git-count-objects.adoc b/Documentation/git-count-objects.adoc
> index 97f9f126101..eeee6b9f7f4 100644
> --- a/Documentation/git-count-objects.adoc
> +++ b/Documentation/git-count-objects.adoc
> @@ -28,6 +28,8 @@ size: disk space consumed by loose objects, in KiB (unless -H is specified)
>  +
>  in-pack: the number of in-pack objects
>  +
> +packs: the number of pack files
> ++
>  size-pack: disk space consumed by the packs, in KiB (unless -H is specified)
>  +
>  prune-packable: the number of loose objects that are also present in
>
> base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1

Looks good.  Thanks.  Will queue.
