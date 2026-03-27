Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEF931716B
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627838; cv=none; b=qTvQyYVyHdroF4l+CaEuuQXlfl9yrxHKvnl5rFr8htwRHpLIonIBONmP87OtRrvbDpEXnSQzi6NGDtRItIjZ7QSe5KsH7HnjXF20shQhNEfU3vqx60Fjy+5V1fwbQq/o6j6+iU8G6WD1nyEYHT/eZKn4Cd2vccqmHvSDhhcfz04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627838; c=relaxed/simple;
	bh=MnYjhWLz4YoijUWaXjmwmXgeklyrpy+LcJf8dapPJo0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fIJOl2Zsi2AAMAuECXubga5yTgulLHnrhmhFGmWdB4dTaaK7ZAleHcEZa/wUGv+UnmjERZGPSFuZ8yZqlv8VgLHZFeJYHAjKpNWWL4llwQISWE+NjAohW+QNzq98vJXX0RDhpWzkgNggu1T0K3dc3fYuiB3AHgOcr5K4omZvnw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kePr9b2h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FkN+AOk5; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kePr9b2h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FkN+AOk5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B06497A0150;
	Fri, 27 Mar 2026 12:10:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 27 Mar 2026 12:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774627836; x=1774714236; bh=QmqaMjv3OZ
	o6HKpSFoKiRAxP0AJmnjfzC3Eovup0DjA=; b=kePr9b2hFtZqLOyH6GROSZoOgO
	Ir5Fa958OH6lfqUUmH/MkOry1MP+HRNKVUSsaOw+LB0+TciJsx6bOtD+3n//BNS6
	u337jikINlFgPaKn6ci1WuAfCZxQx2PoIgJHmrUhkoWov44PdEzwMx+CmJXfzOqx
	NuuOIXEEmdSqHguNrbTABlRsiJ+1SkEftW9Ai61eGovWfylcDNPYz+zfbD7GK4VG
	hUnWQYiwuk26pMJkf2bOksl5l6M7rnzwcGobpe09949DADbW838a2aeFgFEJktjc
	lKk3q0FScfL3dt4TMl8qbrGIB1ZQwzgo/Tm1/QEd8lznUzCTqnB1ckOZxnzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774627836; x=1774714236; bh=QmqaMjv3OZo6HKpSFoKiRAxP0AJmnjfzC3E
	ovup0DjA=; b=FkN+AOk5RQNTsAu4e7oxtsgC2EySdv5moigIhMsCe6AKbk9GhXC
	tQUHDHYYaYxXyKI2cqqsYCNmzBp/tn7iLhU8XwTyggP8GUIsQzTOPMCxjn0L6wmB
	bM3T+DnjTjYuYzCAdPDlIlpkwz+IQOn62HWXYmajOZ9yAEf3qtBmg8kG9GNPetuK
	ArUCWkKN2XC5qKEzLSBvRlD8lj2YUEqhZ4db7vAZ/bWseOQB1kNsaSV6N2HVLvwB
	tCC4v5HkxcCHzwq5a4QkdHnAZjz/aiZz76qWTiP9mFjqMpl6h6+8kMNLiA1Ipr1f
	0eePbcJ3GcurqRpi/fFUGw0nNJyqt6xRJjQ==
X-ME-Sender: <xms:-6vGade3HisgHQOhAPZnTYMXnhXxKUahTLtjzBVV7LGVSw7W5hXc1g>
    <xme:-6vGaSMxokSRAk-V8lnRvY0rwUj0a5WhRRQjm0HqAklf_WhJYoIocrOTFak_WOyCl
    shcBE53J5nkzSOGelCD6f_7V4pPiTt0wECLeSF9SV4Hgd9FGt-YLw>
X-ME-Received: <xmr:-6vGabhrYgXVw-5iZqBZiGDcahirZ3li-45ZxiTQrQRucM6aQoD9InGRzZjGwNzNfXH5fE6fS2dB1MQcVr_CGL9xxTU_cucWDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepvdffueegjeetveehgfevkeduleegueejueeuudfhffevteduhfdvvdetuddv
    geefnecuffhomhgrihhnpehsshhhihguvghnthhithihfhhilhgvrdgvghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopeifvghslhgvhihsseho
    phhpvghrshgthhgrrghprdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-6vGaV07b254hH6iqI_WP9JcwLS7vWFjBDNcN-7CAhzXMTeDYV4Cyg>
    <xmx:-6vGaVgKrwFjirmp9gcALEz7ZNXDfdllEimrDrfBGoyAGVvXBMrJNA>
    <xmx:-6vGaVfFiCKOapYJTdu8zRhmLtfelUIQ_b2ifJVIpR1jizjBexk5BA>
    <xmx:-6vGaYlDp3vRIdyFvkHza9noAMm3xFoQxy0_SMzws-lbtDd7oxxt8A>
    <xmx:_KvGadSqZwqww96nzz7sh41v2jxDj5t7ILfj8ssUrbWOSaXEXbZsJuNs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 12:10:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Wesley Schwengle <wesleys@opperschaap.net>,  git@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support for per-remote and per-namespace SSH
 options
In-Reply-To: <7d3731c5-d766-47f5-af60-813b379cbeef@kdbg.org> (Johannes Sixt's
	message of "Fri, 27 Mar 2026 08:51:32 +0100")
References: <20260326233739.2911354-1-wesleys@opperschaap.net>
	<7d3731c5-d766-47f5-af60-813b379cbeef@kdbg.org>
Date: Fri, 27 Mar 2026 09:10:33 -0700
Message-ID: <xmqqbjg9mex2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 27.03.26 um 00:37 schrieb Wesley Schwengle:
>> * `remote.*.sshIdentityFile' and `remote.*.sshOpts'
>> 
>> Configuration set on owner/path style. This is to support `includeIf`
>> configuration management. For example, a git-forge that host both
>> employer/client repo's. Eg, `git@gitlab.com/waterkip/git.git' and
>> `git@gitlab.com/corp/git.git' would have something configured as:
>> 
>> * `core.sshIdentityFile.*', eg
>> 
>>     [core "sshIdentityFile"]
>>       waterkip = ~/.ssh/id_ed25519_me
>>       corp     = ~/.ssh/id_ed25519_corporate
>
> This can be solved without a changing Git today. You configure the two
> remotes with different fake host names:
>
> [remote "waterkip"]
>   url = git@waterkip.gitlab/waterkip/git.git
> [remote "corp"]
>   url = git@corp.gitlab/corp/git.git

> And set up the real host name and identity file in ~/.ssh/config:
>
> Host waterkip.gitlab
>   IdentityFile ~/.ssh/id_ed25519_me
>   HostName gitlab.com
>
> Host corp.gitlab
>   IdentityFile ~/.ssh/id_ed25519_corporate
>   HostName gitlab.com
>
>
> For this reason, I see little incentive to add complexity to Git that
> achieves the same.

Very well said.

I somehow thought that this practice is so widespread that it was
one of the few first things any new people learn to do, but perhaps
we do not have a good documentation coverage?

In any case, I do not think these network/transport specific
configuration would hardly belong to "core".
