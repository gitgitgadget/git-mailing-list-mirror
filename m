Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D943FA5E5
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699167; cv=none; b=XSGeZ/anUG8FaTurKCEETK2eZZiQfGL4XjCOQw4sXE1I2UG7Ky5QI5dkhD/KUv9FKccD1jDRwSubQeQXjwGukv6TrYLlANg+ukgEly/r4Psy/QIfHyXZHN588juxCQjWPsamoqOhhkLSsoB5sHHslCgCyp61A0Q0PPDpbkzdPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699167; c=relaxed/simple;
	bh=YCSN2K+Cjob2FmqoP9ZTbnf/Pz8PLi1qAM1qkxMWYik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=glvRvPLn9pr/7hYR75Zo6dEQYgdNfQcNEjYpRa2ugclx8FNnKZZ/s4j44lh3EzZonQVpoGGnoo0Dj8EEg6xm7nh51debDHSk3D97bBI6DFQ1FasKfxTUtmJarJN31nwXWIV4AvuucHRYgT2f2YboRN5GK2S5nxE0tV4wRIDYW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=owfhOukM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ccB4vGEu; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="owfhOukM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ccB4vGEu"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2D6E11D00133;
	Wed, 17 Jun 2026 08:26:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 17 Jun 2026 08:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781699162; x=1781785562; bh=faj8V3sqev
	tTLMatk+di2R8nJ+ylgE88F44HUB80Cy0=; b=owfhOukMOJmTeikJAkaXuVYre9
	OcAsMnHyvYQ3fybt+L+AIpBQfS+sz0jR2uzurXjThB21fCZTkBOrEOfzCaTx3EO+
	0amuET2JOWQ7Rji0GFkHWYfHimMle+eQDDdgRXHXtVep8a2QF7wt4UDucwGJXGHU
	ycipdJLVYswlKtqcW4nDlIaKLnFSGGuZr390RVh4Qso4YUqQvFnu2trNsoQ0Z+nt
	f5sAGStQwVogLw4PjfcIRcyJl+xKOJu8WwQFkc4KtFXaD/5SLJlRu600Ylx5ktD1
	NPGnIAOnZiltblZTNrW5V5cWON5Wl0Rqq9ioIf+gP0kaXwkvUht+UuECwWWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781699162; x=1781785562; bh=faj8V3sqevtTLMatk+di2R8nJ+ylgE88F44
	HUB80Cy0=; b=ccB4vGEuguXJw5+aZrjDU64S3QtGONIuFh9NWTiqDAsEiCG7U/6
	0lqOz7i2cMMMazmwruoamXEBiWXPWWljpMHEV5/dWf4MnholGyUysxY+xMzGdrr+
	v5dZej1AO/e4TyLQHxFY42ibF1bjNZzUgYZ4eAHLNUrcNxs/IKkDVOJOiplzmRT9
	QdFym86EBNo6RWEuaNZsRdXejVAeff7m3sWj4qLbSu7VR3bRMhJPyQ/8VgM4l3YQ
	Py4q5EfvZWWGabgGtBpJpc63nfBxy0MXd7TTp/Y1adlNCVGIC3jZ3UtPZMnQcSUB
	4h+6JBkjvnXxwvfp6rJCU268SF9K/eJeTyw==
X-ME-Sender: <xms:WpIyakolLk7BLjrKHZix3FbrPDfPGGqExhFnFQMPADjXXuPnHd9R_Q>
    <xme:WpIyaiFUMP3v6j_PWavD6uurP3GdHORKKN4FfDMrSvWV3f-ifWe-n816CpE5BRg3N
    YtOyUH9-VH2I3jlDttT9Lu5KnWHjIzTJJfW2zyx0r9NCP5BaDOURQ>
X-ME-Received: <xmr:WpIyammAE5pMG6dDZ0gisV0hCdkudAPv5mGKyTawnqglg0UDxDHq3gM6CGPxOBnA2SarRN7jXw9E15vg8TCwRvzEA8jwcWCRMdMx>
X-ME-Proxy-Cause: dmFkZTFzi9cKuuZ8/QdxIXqH8VyHsfuTcdhWMNhOXVMSYCn0X9rmEjQLOvk0+DxXCAi6pn
    PmvpFJM3y9NxMCw/D7qYV6mBtl/EM+n9G6CkTg740bRu4DuQgPXJqISQ/UDWUNZBEFrnEP
    ezw0ZVJuDuN/uwvZAiB7sLZNTkYwdlN4AOmuuUq5056CoC9sdgOdD7oGTtGjyZSB0ijmsC
    0ssvpa/dWuFXVNM8fDZPPLiU/5lZaCW8T8x2mR/JvRCFXcMgVf6AKfLeXdTytQVOdsvDs8
    vYSIt3PUX4eNEj2AMj5Uw5r/zMuEM5tUPkPAF7uQzzZuQ7SdECq1ox82w/MfpSO6vR6gYG
    gID31ZYbpilz2g3VZ16oHv4Y7SB0pAcibwjIDJjIkP8uJy1zju8rG6L0u6kEfzeNtUlZLg
    mOQg/DdRj9k1Ls2ROdUFoyeJXpj5nkP6sqIK0eJITiqChhxrQwECVUcJIIzXWtbvUdI01x
    N4/H+GT2XFyj87R6X4dRW7nWRZW6pv1XYK4KW9g5dKFXW4Rhxrgxo+eykfcfQZuOkj+VWg
    XEdKrVeSIM2l2y6FiLvV8OmqWmxqQobOMKfLHqDx5lk1G75j1Lc8S9CIKIs70j5hGgf/wK
    V89XlM9Clmak8SG3vrnuZtL7TZL9xr8+NVye2lfEPmtI7vsXQX7fjmcRZ6Uw
X-ME-Proxy: <xmx:WpIyalmGQnfCB-02UhP2EjWfRqbqevQaAwHoHpubk0cuo3xoSMrtGA>
    <xmx:WpIyanuldP4ILKaCcFQiDxND_bU2FXxXOV4AvBRzliOWVvCwSO_oRw>
    <xmx:WpIyaol4TGbuQVsa-QSbc4zDPoDtHQCGpZUThOIFFsBlC-YfeqJR4g>
    <xmx:WpIyaity-ZxyrbUVt-zVWNJk_qoDT0E0SlsazRXl86pTrje3hZ93tg>
    <xmx:WpIyaqNmtew6GvWUT1R8Q3-ZdsJBmoKotbT2ICzyoWvX9dTVCi33CA3Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 08:26:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/5] builtin/refs: add ability to write references
In-Reply-To: <20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
	(Patrick Steinhardt's message of "Wed, 17 Jun 2026 12:15:57 +0200")
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
	<20260617-pks-refs-writing-subcommands-v2-0-07f3d18336f9@pks.im>
Date: Wed, 17 Jun 2026 05:26:00 -0700
Message-ID: <xmqqjyrxz73b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> Reference-related functionality in Git is currently spread across many
> different commands: git-update-ref(1), git-for-each-ref(1),
> git-show-ref(1), git-pack-refs(1) and git-symbolic-ref(1). This makes it
> hard for users to discover what functionality we have available to work
> with references.
>
> We have thus started to consolidate this functionality into git-refs(1),
> which is a toolbox of everything related to references. Until now, the
> command doesn't handle functionality of git-update-ref(1).
>
> This patch series backfills most of the functionality by introducing
> three new commands:
>
>   - `git refs delete` to delete references. This is the equivalent of
>     `git update-ref -d`.
>
>   - `git refs update` to update references. This is the equivalent of
>     `git update-ref <refname> <oldvalue> <newvalue>`.
>
>   - `git refs rename` to rename a reference, including its reflog. This
>     does not have an equivalent in git-update-ref(1), but is inspired by
>     and supersedes [1].

... and `git refs create`, but we can guess what it would do ;-).

Will queue.  Thanks.
