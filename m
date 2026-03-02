Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD165387563
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441451; cv=none; b=jA9cQJ0eiqERIz7v8Mh07yZ05LygfP+UtZz8karFib54PqP50VMPwJ2RMbjSJhjZwohSpiCgT8JtV6D6w9jF02dtRgZwE5vF5lPhKtTa0C2gbCI+StsUBcaQdI0BkN/W5o8Fs3KcgW71LBNPSEKzLQ4TZSUwi3sODD/gXLvpcjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441451; c=relaxed/simple;
	bh=ddoTRKD8n+Rp4H+vWwku9aBgrMmvsb/DIKXwqDANNck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnURlh8pugyXFarNSuPK6VOh+urau9vdFMzGNahtmCxL3Ix2luJ1AI8D+9CzvQPrmKC78IbG7mrkRW3imTZT3yvErF3io2Ik9/uoE6jx8an9kFSn6AdTkN6tXiBquZMNzeVOPqkobLwYlMAUxkWJ6loSbe1bqX3y4egz630G8dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IvkCELHU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NpLux9mt; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IvkCELHU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NpLux9mt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CCD5714001FA;
	Mon,  2 Mar 2026 03:50:48 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 02 Mar 2026 03:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772441448; x=1772527848; bh=wBRcj3+Qwp
	Qj+wEckxZnFBGnzbOaeYnmAiqR2g0m4vA=; b=IvkCELHUN1PMVbnLyzcdax4xa1
	0X85oJCBc9M/NXZR6qbUIqFd9xJcmya9SKXpaAy0NlVCd5YZaMPDN2z3a55cPf1R
	rNu0vQEoYoXa8nDxEyOJvyoLmwlBDtRyHtAcIo3F4IG+DOnzMjFbCs84r31dQGtS
	hzq085kH0R1SwODuAXpO1kT6gb2uOGXxpXXOI2CJwZi50sSN8GnJkCsQsVHUunfq
	gLHG6g0+6u2odW1Oi69gb+4l9lLHvPNTsvbMCATzySyMPPxH08KDRHQzEVHTyGcJ
	1JrI+UZ4himvVq2XzyzmNTX6MQJZdKpLDKAa/cGKNLhsKNTCAVy8sqJoHKwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772441448; x=1772527848; bh=wBRcj3+QwpQj+wEckxZnFBGnzbOaeYnmAiq
	R2g0m4vA=; b=NpLux9mtgfex3Q2bQg4zN2lIQznG/A69dKRipmM/1MOzerlh3mV
	ovwTgpWMzyf+zjOXzMhG+BlqtnYMGJVvU32QacA1dpOzm3lBizfcq61MobGfIv4D
	6zySJmag+55lOLb5R0oz184LRIJvTjtHN1XBwGqKzmHfF3GzoyQdLPN6xLzYO1rp
	+ADZaC6VzTnsyMeWC7ZIPGP9Bz7BlapwvZcKyQQ1xyv0FhlenT4GkvEM89eu9iQP
	qKhnTG/k87+4iuM3VyQdrzIbRLuJhMyYm7AnkZ1r/e/SWGdGo0vLI7mhDMHiELbG
	FtOZyoq0vheib/WaBOszcY3cYAQvmDvKGNg==
X-ME-Sender: <xms:aE-laXE5-RMNs6_lsfCgI3akstSmeHWzPbkxpG1AhdF8EshINiIYkA>
    <xme:aE-labzytg44gXmrGsLy42YyjKjDcDRBTu9KDavDYbasKa2hXiUJnctIswOQUiQ14
    tZ5cZGEWA9BGRPdtudt_tw8JPwkDPwRucI5AQkTtdq6wqMUsRky>
X-ME-Received: <xmr:aE-laWhKyKNfMfoB_TfnFtwEmkYZlrOyQkQGwHAbQtfvhjgNc84010ukzLWzJmwj0pXkK-RY5fIhX08LKOQkLTbd4K_7GTiOcICdPaEq_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheejvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhl
    lhgrsghorhgrrdgtohhm
X-ME-Proxy: <xmx:aE-laeyhy18sCGNZ-E88z2RwIHT7ZrfdwSsCmKWT3OZvrL7dWClj9A>
    <xmx:aE-laRJ1HxVzyFx428mkhWqmU9XY2ZsbaqzVUKdGu5WUkWZFpr0fKQ>
    <xmx:aE-ladSFvNRhUiYYR21W2MDJMDnIbqc7-9X1vsHORMVymjdlaSfvUA>
    <xmx:aE-laRp9xJnsVXNTr647rp3rUmnvtBkVt3S9l-misNnNcwx0HIl8PQ>
    <xmx:aE-laWCjHPWHC7ZC3JtOe2U0-BpoYNKx6wdWivzpyikVNouh0WSj0lIx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 03:50:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7a0d1533 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Mar 2026 08:50:46 +0000 (UTC)
Date: Mon, 2 Mar 2026 09:50:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: Re: What's cooking in git.git (Feb 2026, #11)
Message-ID: <aaVPY9b37zY8SLup@pks.im>
References: <xmqq8qcdof3f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qcdof3f.fsf@gitster.g>

On Fri, Feb 27, 2026 at 05:02:12PM -0800, Junio C Hamano wrote:
> * ar/run-command-hook-take-2 (2026-01-28) 12 commits
>   (merged to 'next' on 2026-02-22 at 4aa543f115)
>  + receive-pack: convert receive hooks to hook API
>  + receive-pack: convert update hooks to new API
>  + run-command: poll child input in addition to output
>  + hook: add jobs option
>  + reference-transaction: use hook API instead of run-command
>  + transport: convert pre-push to hook API
>  + hook: allow separate std[out|err] streams
>  + hook: convert 'post-rewrite' hook in sequencer.c to hook API
>  + hook: provide stdin via callback
>  + run-command: add stdin callback for parallelization
>  + run-command: add helper for pp child states
>  + t1800: add hook output stream tests
>  (this branch is used by ar/config-hooks and ar/parallel-hooks.)
> 
>  Use the hook API to replace ad-hoc invocation of hook scripts via
>  the run_command() API.
> 
>  Will merge to 'master'.
>  source: <20260128213927.3026875-1-adrian.ratiu@collabora.com>

It would be great if you could hold off merging this patch series for
now. There's a rather steep performance regression in the "update" hook
caused by this series, see also [1].

Thanks!

Patrick

[1]: <aaU5lZwEuR4OrxCl@pks.im>
