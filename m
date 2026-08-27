Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5D538E5DC
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 16:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849570; cv=none; b=GDbt02Y6Pnsk0mqr3C7G0xC02vpohCMU+54C7Xo4xTCjVcuMia+AJRYl4EkLCq62EjgK7mt2XSpUjGMUaFQb1U5HmCYePY57l/j956O5jn5KEMAvrkP6iZULZvptzNtbEsTNZddxrdwKKLmFcq7Or5MhgC5NEJTZPh3xTA6skzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849570; c=relaxed/simple;
	bh=+ybcjmHF5JrKYDBRkRHTclaR1rJ8MElSWKvjEoIfAhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Khvb04jcNRgK90+aT8RpGD1H0i538GHN5/wuSVOJ61TgXzq1Hoe4x5lUJJqWhz8G01cSFaZp2cg5vgKSEALpv/TMmMpPZ6M1vFVLBE73ggnqCUHWHWcU4UfZeZnPNO7TPNodqddevPdZGHJVrrW/h9lj6Jd+lXKLMipP2Hxp0FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fw+WRDic; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YhHuePfJ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fw+WRDic";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YhHuePfJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 393DB14000F0;
	Thu, 27 Aug 2026 12:52:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 27 Aug 2026 12:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787849568; x=1787935968; bh=uZnR/SR61B
	YRg2mEqpPA5iMYe6cpl3uX7nIBB2jZlqA=; b=Fw+WRDicXSUTbqUeZzfSFj5fH0
	bWxIgQB0ojWkoP6OemxwDQ/++ybdbv+jTgHd6XO/PBvGMlGtwMkg8orMQb/IjNKq
	VjthOT2SAYlIkAHp7ZbXHw0/4XPZe7I9j0cHuVxxy70KUYNtZEwFHJv+JZMbQYO1
	9YSr3RhNsC5XJ+gN11y9GnWIQitFDmuyM4dplBdDzbBgZXCgYrPcl/plm38NtXIM
	o21SirCNYwY97SM98GXKxpSmSV0IskebwsgDAKeQsQT+IVNwRR2KI326lC55nxXV
	/+oG1tseW9iDg6uhwjzbQ862mqy7fUKVxjCCOu309iBeusNQ72OTEDg7UzAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787849568; x=1787935968; bh=uZnR/SR61BYRg2mEqpPA5iMYe6cpl3uX7nI
	BB2jZlqA=; b=YhHuePfJQF/iMD4XghOFyykLGYpTStj1OGTPZtjVT6wdpn7cFbt
	bkGFsXv6zN8d0rg54jEfq18nH5Gqzz5V5M4+qY34XNR6updRzsK4i/4Qsmvp8vff
	kscrRGW2AhDO324qUR26rA/k8eJib8haCXYvjTza4K5RwEjBR5Zx6Ne422ELJaUY
	cK7oYfTl0ka7/szrGb7Rk0/TLBgdmb2X1lJgkZIBT5N4cQ6mr9hcQ/JvnnNPVjYI
	6OhJBhvA1anYXRz6yOiKubcAwIMipZyjFWzG8A0nDUGnLnApbgIAS3B5yNKelCY4
	lfnZj8IYRzaK/ymloe5Rh3wzPi6PJN9bg8Q==
X-ME-Sender: <xms:YGuQapi_Xlf5pXHnocANlDmYprsnGArZzE0AI-94udy2pHqpFz6awA>
    <xme:YGuQak4Kx97IO3_eWMSCyXk1UF2RlQKmqTHK8zCaacl95i-6pajqid-FCIWf9O4tj
    Y3OhsErFaMmIdfYytLq57mNfXk-VhYfjAJ9lNI6acnqGtUKLljiMQ>
X-ME-Received: <xmr:YGuQahYK_HSwUDCxsg3XPWloePGNkShc3oxe_Fsa7qdx7jwQqPVm7iM97tP5cJiLHXqb8UTma5KwWc3X331wwWT1eEJcfrHkFg>
X-ME-Proxy-Cause: dmFkZTGG/c61O3eXvmiak5zrg2Cd7sb7pbP4yc/8yeVnU+Ehwu4H52jKafVygEv5HNpmx5
    luTbkHAW9ZVqRah0wAzU6ETAYFYY/1RjnUuw+mDq/Kz50OWUctHVuOj/gp7+5RBdjIvnI1
    JeleRHAWnbs0ANjQJ4zbRxesgJKZ0gSFx9LGT0pURl3dDB6/PKPsPZiVnq5YZjozLY1H2U
    Sm6sH337A05GDyOsrIfoNdOqnKCHqlq5h5GTi+XtAmc4GhN1xrCt7DuJMH7knM5v6Dwcww
    nPeEDArPxz48KOGqzk0wWIq8AgPGp3mGEB08kSsvuZr9VFYHmd77Jba+duN2YQfPN3lerM
    lnjad0fc5SpFvdzcr6SsEDfCCtDiZOtGo2jEWVuJdgEL5ZcGx5Y1pKaxVowEJgGl+evMDd
    pgfH//v+ZO6OM9zcTcxGib7Czv1qeNagc6IE0Ct/0MeuoknfOW4eiqnMGdYpXse6furk9g
    8jo3jRxtXYNQKFTMtKtzXKjzBvinmDhA70tJHh1o3YP7OCt3PY3NKX32DbmBq2MCIkBuoM
    0yfu0nBmj6o8tOcRmg4b+yz3Mmf+ynmnkQ02t7ml7zclgUlfBRumV91KtkI92i76msc9W0
    QjBbvNdIcJCxVMbLH7hcZsuQVyXARPsTaKkSym8FbOPQbnpIVAlDTT5dPuQA
X-ME-Proxy: <xmx:YGuQap45SSaFK5V_wHax0tRwRZCJPNUEyOs4YotuXkVRBaG3_sChEA>
    <xmx:YGuQakA5r22HSjoQHJXghFnKVgMPdCj5gXIVEIrB0UWi5ln7NHoIMQ>
    <xmx:YGuQavc5B2zvMajONeOVOXjqHrERpmTHYLr6sxdaEwbWQGOnjUf6Sg>
    <xmx:YGuQajLgFHXgswgW_yeFQALHfrFZ6cEmc_NwJDQ2NL8YsRtmmwL9sQ>
    <xmx:YGuQalKNNmvsQObdyepajR7TG7x-sj7nM0bYYpewaUdrSthtarnlau-Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 12:52:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/3] commit: reword the empty-commit rebase errors
In-Reply-To: <xmqq5x0vbjxd.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	27 Aug 2026 09:35:42 -0700")
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com>
	<65c48ed3cb638cf0be18a3aa6d86d4c4f2cf01a2.1787792534.git.gitgitgadget@gmail.com>
	<xmqq5x0vbjxd.fsf@gitster.g>
Date: Thu, 27 Aug 2026 09:52:46 -0700
Message-ID: <xmqq1pbjbj4x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> +			die(_("cannot do a partial commit while resolving a commit that became empty."));
>
> That is a mouthful.  It also is awkward to say "while resolving a commit".

This still stands, but I haven't come up with a better alternative yet.

> More importantly, I am not sure if whence == FROM_REBASE_PICK at
> this point in the code flow is a sufficient sign to tell that we
> were not just in the middle of a rebase, not just a rebase stopped
> with _some_ conflict, but the way the rebase stopped was because a
> step in rebase resulted in a commit that is no-op relative to the
> previous commit.  What makes us certain that the rebase-pick is
> empty?

This confusion was because FROM_REBASE_PICK is a misleading name.

sequencer_determine_whence() is the only place that declares the
whence is FROM_REBASE_PICK, and it specifically checks if the
rebase-head and cherry-pick-head are identical before yielding that
value, so by definition we are dealing with an empty-pick situation.

This came from 430b75f720 (commit: give correct advice for empty
commit during a rebase, 2019-12-06); interestingly, the name of
FROM_REBASE_PICK and is_from_rebase() seem to have confused even the
originating commit ;-)  The lines in question

+               else if (is_from_rebase(whence))
+                       die(_("cannot do a partial commit during a rebase."));

are from that commit, which wanted to "give correct advice for empty
commit during a rebase".

We may want to

 * change the code that does whence == FROM_REBASE_PICK to use
   is_from_rebase(whence) everywhere (other than the implementation
   of is_from_rebase() itself, of course).

 * give FROM_REBASE_PICK and is_from_rebase() better names that
   contain "empty" somewhere.

to unconfuse me.
