Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F87014A09B
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523996; cv=none; b=c2kLmz0IVOcoM6LEXgvHgS0BUSTiWIQLs4oPMIxn0IVur9/6qBXn2Q0FKuQMjn/gMyISMCiuQSxfFRGF39YSQEEQGibFArK+dVtmGa12T+hPiZdpNRrSJKZGlFB8unxFAztsH+j474+vADzZNpyxqOXs9qTEniVkkIchg5U+gqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523996; c=relaxed/simple;
	bh=Mvm5nOFDlCqJ/b3o1Lyrl/aIoWpoRV12esUOfdS3l/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fPXHdJpydTrvHhD4+4ZZelpraVdFQm+ZtoDlSeAb0NKjiBusJb0RWJZ0MEd29qLIQdtSaaYhagPLbsS76H+HpAhXxsf+lwGR2RkrcM5EFRZRaBRoelHJFi296jvf25qQ4LOpJTbXZMCsLC3CYELuXpeoMThdi9da90XqM2IR1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=A9krlntm; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A9krlntm"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 109191D1A0;
	Tue,  4 Jun 2024 13:59:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Mvm5nOFDlCqJ/b3o1Lyrl/aIoWpoRV12esUOfd
	S3l/g=; b=A9krlntmGcmq97wHJx9WjOmI5yDsGnPoVsoLEGau1ZYsoVzt+SjkEs
	2izoZJL5WoCz0mVDoRf84JfQP3CowdaRJ02hLxZ4GzMgHip01/UiJw+IfTMkbEUw
	BTM616EA6sqMdh5bFypKdn6jiRUMHKbmVNhusEllakpDdCQDqukes=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0725E1D19F;
	Tue,  4 Jun 2024 13:59:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B9CD1D19E;
	Tue,  4 Jun 2024 13:59:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood123@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Dragan Simic <dsimic@manjaro.org>,  Karthik Nayak
 <karthik.188@gmail.com>,  Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v6 1/4] docs: introduce document to announce breaking
 changes
In-Reply-To: <a260bbf281d2975562a042a71ca0dd7f88f03da4.1717504292.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 4 Jun 2024 14:32:36 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<cover.1717504292.git.ps@pks.im>
	<a260bbf281d2975562a042a71ca0dd7f88f03da4.1717504292.git.ps@pks.im>
Date: Tue, 04 Jun 2024 10:59:52 -0700
Message-ID: <xmqqsexsvbaf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3EBCDB92-229C-11EF-AF17-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +* Git 1.6, released in August 2008. In retrospect, this release should likely
> +  have bumped the major version.

No need to reroll just for this alone, but back then, a non-zero
third component did not mean they are maintenance releases (e.g.,
v1.5.3.3 was the third maintenance update for the v1.5.3 series) and
v1.6.0 _was_ a departure, a breaking change from the v1.5.x series.

It is more recent tradition that we only use three numbers.  I'd
strike the whole "In retrospect" comment if I were writing this.

> +to see the message and its surrounding discussion. Such a reference is there to
> +make it easier for you to find how the project reached concensus on the

"concensus" -> "consensus".

