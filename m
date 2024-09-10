Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A21AB508
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 22:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726007364; cv=none; b=kIxkGFlNmeSPWgnZPxVZwZu09f69ijhZ+VV98byCGPRFYCVenfNwNn5jMLPY2g/hb6rK8kM96/qCcTXRMKFkCh0Led/vRxAoGCa4I49mS4L2Ma5RNJ+k3aaxmDqHmc7YmtQWvTtERv3ohajuO357pRU3WtedIk4ZeXrfkAMdJ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726007364; c=relaxed/simple;
	bh=d08Qq4iWXH0ZsvwEVmNcBZsy+qQOMgD2wqYsa0mHwgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N3d1UXhXz5BrsWlBKRX0uMYpSYV0u6yOY5niy2EGxFZjZSRSBif7dWQclY6zQGe41zq90L3TPT+/6hX/xg35m7wWhzKOeMIbA1pg7KzO0jOTw1RFnAJfkN1myHU0JlsE8yBO9wwL9HF99rUlow0gfNUM4rqCjVS3DRnz8m0si/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KejDHiWS; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KejDHiWS"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ECA41369AA;
	Tue, 10 Sep 2024 18:29:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=d08Qq4iWXH0ZsvwEVmNcBZsy+qQOMgD2wqYsa0
	mHwgY=; b=KejDHiWSfRaH5t9aPXMOMHrxXCflZN7jtuJwf1/Mxa9brKOwfJEM+G
	GEPIHB7JQQzd03mGwaLQzyBtHQHfL2KrDh+VBp1jgUl0hCB82+xaOy0NsKxHnB/7
	hXIuGh1pU4khEGADkAX5t3c1/QFrhXhaDNuyhiXEC7Mh4aOOvSvO4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3FED369A9;
	Tue, 10 Sep 2024 18:29:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 526FE369A7;
	Tue, 10 Sep 2024 18:29:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, 	Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt
 <ps@pks.im>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v2 0/2] set remote/HEAD with fetch
In-Reply-To: <20240910203835.2288291-1-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Tue, 10 Sep 2024 22:37:12 +0200")
References: <20240910203835.2288291-1-bence@ferdinandy.com>
Date: Tue, 10 Sep 2024 15:29:20 -0700
Message-ID: <xmqqldzzcfcv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2009B240-6FC4-11EF-903B-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Bence Ferdinandy <bence@ferdinandy.com> writes:

> What is missing for sure is:
> - documentation
> - tests (if needed)

What change does not need tests?

> - settings
>
> For settings, my idea would be a fetch/remote.set_head that could take three values:
>     * never
>     * missing: run it only if the ref is missing, this setting would basically
>       allow replicating the result of a clone
>     * always (with the other patch, this would still be a no-op if it didn't change)
>
> This would probably also require a --no-set-head flag, to disable an
> always/missing setting. A --missing-set-head or something of the like also may
> or may not make sense. Alternatively, only two behaviours might be enough
> (missing and always) since clone already sort of does this.

If we were to assume "always" is needed, then the tristate like the
above may be a reasonable way to go.

But as I outlined in my response to [1/2], I suspect that an
approach without configuration or command line option would give the
users the most smooth experience.  They are used to seeing "clone"
to give them a remote tracking HEAD and nobody complained that we
lack the option to "clone" to prevent that.  If "fetch" notices we
do not have remote tracking HEAD for a remote [*] and stores what it
observed at their HEAD in remote tracking HEAD, that should not
bother anybody.  No matter what mechanism gave you the initial
remote tracking HEAD, if you want to update it to something else, we
already have the "remote set-head" command.


[Footnote]

 * One thing we MUST be careful about is that some remotes may not
   have ANY remote tracking branches (i.e. you only want to use the
   remote mechanism to give you a shorthand for URL, but you do not
   have fetch refspec at all).  Even if refs/remotes/$repo/HEAD is
   missing for such a remote, we should *not* attempt to create it,
   as we are not populating refs/remotes/$repo/master and friends at
   all in such a case.

