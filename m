Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814BB17837E
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704057; cv=none; b=oYEuKjEcTmd3c5P4vHkHhSj1nrqPB2AfCCqWlbhMaAlQFCFN8lij7WMtjngbMxsck7qXDlZgIvWl5PBpCwz7dfQ4b6oO+BbHKsbNjxqXpBj3pE6oqdAG3xzbVryxa3gTTP5YOfPwuTahRN4re8D4+/xkE93v+/tQAA18Ato7ZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704057; c=relaxed/simple;
	bh=vKh5h5KipVJ9EEirEoNSJf0LSBNykVNpv99dbDLZ6L0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=T8x4TWp762QDS5vkixKf/bplCEXJrLuA5Y0ivfGpc3S4U9ltPrS0vRdAnl1P0gCStAgDkxMryaySz35NDJMVZ1U9c7IWMtBFVwjlHopvTM6mMQlUWlaKsrdHwd1NJy6F54UPvET+tgfLBFH387DkwPqZQKm8DPqBSFsVGtCUiwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io; spf=pass smtp.mailfrom=jamesliu.io; dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b=WX93Oiey; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gq2h7Upb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jamesliu.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jamesliu.io header.i=@jamesliu.io header.b="WX93Oiey";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gq2h7Upb"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7E3AC1151C8D;
	Thu, 15 Aug 2024 02:40:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 15 Aug 2024 02:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jamesliu.io; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723704054;
	 x=1723790454; bh=Qkh6o+XWLGSikOktn8UwkjEMC0JOHHgOpIaI3oL1wQY=; b=
	WX93Oieyf1JvrIMYYpJx0a1eRqOqLsBRyxx8G3qccX3BdXC0fuXZ9MEd2QYSeb/g
	2Y6FYRjCM0Lpn7sXB1Kpts5ClV4ypBA2ZdAUFFxf9owR1DVYUUfhCJj7xO+SGkDG
	mpdSS0X07oK4Qiyuxtom26YowPXdptpoG/cka3iieLNEPtRdpRwFHT+kJiySCO5b
	UzKzL0d6ZCjUtEZGFztkEc+o0SABO2aB2J5J+xxF72T13CAo8LQwfLebHEvPK44q
	hoIMWvO4D0PNaBE3VCOKFspOBZN37xMpjRdFSUgcynHDezo1QukChF96ay2I1lcu
	p9L7g9aaD9ETHntFTKLMmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723704054; x=
	1723790454; bh=Qkh6o+XWLGSikOktn8UwkjEMC0JOHHgOpIaI3oL1wQY=; b=g
	q2h7UpbF92LS8T84PPBpV+M+a6VI84me5cKDS+GdFo8aS3Jh9apqqrM4dBYjiuJQ
	sau+q9x0UfVKHjkNp+mGJHk5O5kmgdKj4k7Hp3sX2UPvI3I221XQIOgd+Rg3nEQN
	Td7vAijkOBEYDUVkdU3I2mGVwNoa8r6gCc7naEnOYPoV7oEB6rBCjVQA0hPKXkCG
	y+3tiIgYTt1Nxhy2nBC4LitVJ7a511+VZgOACxsdzEalqN25GpIrc9uaIZuRmc/l
	8Lj6zPVQ22fVH1YAGdd8kZtahsULjBhwOONnA8oMvr0I11yDnpqMztAmmo980AYR
	lJ5ib0QrDtKkw3isS1qtg==
X-ME-Sender: <xms:9qK9ZmrQACK03WKGyQbEnJlKkMnzXq5q_zWmhi5dQzXN6kIKprqhIg>
    <xme:9qK9ZkoVRove08T9eTqRDoztPSYVDF8k2LSgJiYDbOr7R2tJNxTUsrOBCDP8cC4Zj
    u4on9gTiBhrfCHVlw>
X-ME-Received: <xmr:9qK9ZrPkjwcNcdR7mHRU7Zd4bUtSWwAuJfFNl6uIgdDFfvirEdDGVPbCC-JO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpegggfgtfffkuffhvffofhgjsehtqhertdertdej
    necuhfhrohhmpedflfgrmhgvshcunfhiuhdfuceojhgrmhgvshesjhgrmhgvshhlihhurd
    hioheqnecuggftrfgrthhtvghrnhephfetueehudeltedtjeekudelueeihfevheeugfeh
    hedvieektedtvdevgeeileetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdpnhgspghrtghpthht
    ohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9qK9Zl6epNPJnwNHk5evpCO6_Mrhb_OV-vL8ooNcP-nLpt2pOItcwQ>
    <xmx:9qK9Zl6mS8INmXSw67wWuY__SnQq5xvY-dWyea1nHp8xb3dvDWEHyw>
    <xmx:9qK9ZljmPBXfsb9VrEqdBmM3IaCfiSnlPnlqAT4QfyM_qZnrP8_e_Q>
    <xmx:9qK9Zv60nt0F19ByVmfIjmz_9k7zJ8NAyKFPzh5D1mWiTd67k0QWoQ>
    <xmx:9qK9ZlHhdTIq_7LL93bfl0_vuJKa7lFQ-IJMhzeUj3e7B2HSSYc2qENb>
Feedback-ID: i93f149ec:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 02:40:53 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Aug 2024 16:40:51 +1000
Message-Id: <D3GA39J7D5UW.KCFXXN036OD@jamesliu.io>
Subject: Re: [PATCH 7/7] builtin/maintenance: fix auto-detach with
 non-standard tasks
From: "James Liu" <james@jamesliu.io>
To: "Patrick Steinhardt" <ps@pks.im>, <git@vger.kernel.org>
X-Mailer: aerc 0.18.0
References: <cover.1723533091.git.ps@pks.im>
 <8d6cbae951177718b49d5cfbbeca2d5b0073e266.1723533091.git.ps@pks.im>
In-Reply-To: <8d6cbae951177718b49d5cfbbeca2d5b0073e266.1723533091.git.ps@pks.im>

On Tue Aug 13, 2024 at 5:18 PM AEST, Patrick Steinhardt wrote:
> diff --git a/run-command.c b/run-command.c
> index 45ba544932..94f2f3079f 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1808,16 +1808,26 @@ void run_processes_parallel(const struct run_proc=
ess_parallel_opts *opts)
> =20
>  int prepare_auto_maintenance(int quiet, struct child_process *maint)
>  {
> -	int enabled;
> +	int enabled, auto_detach;
> =20
>  	if (!git_config_get_bool("maintenance.auto", &enabled) &&
>  	    !enabled)
>  		return 0;
> =20
> +	/*
> +	 * When `maintenance.autoDetach` isn't set, then we fall back to
> +	 * honoring `gc.autoDetach`. This is somewhat weird, but required to
> +	 * retain behaviour from when we used to run git-gc(1) here.
> +	 */
> +	if (git_config_get_bool("maintenance.autodetach", &auto_detach) &&
> +	    git_config_get_bool("gc.autodetach", &auto_detach))
> +		auto_detach =3D 1;
> +

Do the two `*.autodetach` values need to be camel-cased or does it not
matter? I've noticed a mix of both through the codebase so I suppose
it's not case-sensitive.

