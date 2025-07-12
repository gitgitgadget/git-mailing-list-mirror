Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1292B278E40
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752329291; cv=none; b=k0a6i5jCxzfZktPzsJUB+qemzEMuBHj8YyW4bvoVpcNbyy9JDh+g2poB3don6hUliQofxJL2R4fafVhQiwZN2biklfuyAHgm+OKsDkM9khyQpFxWIqiIoMzwH2Odv/dTvHGlrGy+AYaj2KhZYduKMQzRwnWtvnqWUiVxop7wkTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752329291; c=relaxed/simple;
	bh=oMLgihxEGN3c5tv6WERqIKbnkjPF4yOdkb+v9Bp5ihA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NwgjhNL3RYC4565pJFbYluLL3+GizpA/GOx3KrVjnGClPQD0INMltVpYb+P+bDEdvqBdK90Mc9ma5geeMVwT6fOCFivEuFaTxR9Fs8k6yusGRm5FLo+9elkpThtOr+er6gMVvSaeLQS1nZHr2L38Ca1nG6IezXTeqCyFLLoTHWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kjINibKL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WUcIrm/Z; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kjINibKL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WUcIrm/Z"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 13CC6EC010C;
	Sat, 12 Jul 2025 10:08:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 12 Jul 2025 10:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752329288; x=1752415688; bh=4HcThfYp97
	x+J2P2rlTWd50KOOFKg8un44b6gTf7UO4=; b=kjINibKLkALuQhoBxZ/mOEMddm
	Yqy86JIoylQRQn/HqOHj/uXp8cOu0xH0xHeZ+2PKjFO32FQogE9pVInUh51MeubV
	kv/EWn72QHi+I0fWCenmCySX4Kn2NtUlfz3SgMboU6QuGSjgnY+zCgau9VDWuuYE
	ewMrpSjUHchUUxeVOV1xwdUGSm+EJzwuWbmUG+cdjwx0chK1BXmDn4qNoqYMAVns
	v0roHLvS0YzVImBtPUyIYi+gSKo1aFtJwpwY+MfSjmS1qsq2ggrQ7eq03xMpxfjG
	WhqnDYurSLlHkVoeSebllOXvMZW6xPiNL5jv38FpsNucEww9ATM5JtUY7wXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752329288; x=1752415688; bh=4HcThfYp97x+J2P2rlTWd50KOOFKg8un44b
	6gTf7UO4=; b=WUcIrm/ZFF0Cx5rX5aITPl5477XnmROp7DwMGoyuKUofFKD2XuH
	XEatznOtF6uUbAi6sawqw5oijwXsFjMI7cpGfZbjTSl5ir1Ul48fz6czHa3ScJwm
	F+OCxfJ2FHOxEq1YYYXXty6BHuZs/3LbhSh1r8kK/AizTMX+t83mXbDnNKFdXIGv
	hsto+wpHsEMb8Io8MRXSLl+WGtefJWplN60aCDn4iOIWVgtwg5itHtXtXErhrv5w
	HeYfuaDwfEOylmCYc/Ck7FgkZlZvu5vxpUJqlyrID3s/cDdkzMblILeota/Us3Yv
	asMLuy9rjgztdfnVGV6gLaWlMlgLz/uvvqA==
X-ME-Sender: <xms:R2xyaKLCuzgyNwijmq3sWENIQiv45-zf7NHadfJvO12h6NH8P44Iyw>
    <xme:R2xyaMt4ETDpvWKKRfRS4mX8n33RFB-OPIKzO_kjmr8ujsKm08bdiZ4JazL8V6riI
    koIu7XXiPtroN4b1g>
X-ME-Received: <xmr:R2xyaHTeOmjxcAO2jgtCD5aFZC9vzp0Nnmd6al7BS6wjtDE2UyZi8AthULMfDOT3gtDoRVlysMALVDogCDhwP1PvMcpsywHg9tQQqxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegieeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehstghhfigrsgeslhhinhhugidqmheikehkrdhorhhgpd
    hrtghpthhtoheprhhoshhssehmrggtrghrthhhuhhrrdhiohdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:R2xyaCMlHp05T712RREt9EG4Xx92OMksTxUEN9Y6RfQS6HTZauK3yA>
    <xmx:R2xyaMaPDeBe3P6xFG9z2s-vKQy4Da3Q-n8q086SGBYB-DnLZgORRg>
    <xmx:R2xyaMwuZVscVOlrqDhZaoZo3VLrubjrulicBLeAVhl58DZ8m8s0pA>
    <xmx:R2xyaHIbXfkJtAkaZ30BQoCzpEEosjQ9KCU21SQhkaXdWQU3TtCGQQ>
    <xmx:SGxyaLRVh7Gik-Zz-AIt43c80n6lyohId1LC7Pz2uVoYgaroHCzRAFuY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Jul 2025 10:08:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Ross MacArthur <ross@macarthur.io>,  git@vger.kernel.org
Subject: Re: [BUG] gpg.program: '~' not expanded to home directory
In-Reply-To: <87ple521gv.fsf@linux-m68k.org> (Andreas Schwab's message of
	"Sat, 12 Jul 2025 11:38:24 +0200")
References: <CAF1X4d7N1xdZt9JkVZytbEU1=7q3X_F_nqm4EG82B8-cVa7g8Q@mail.gmail.com>
	<xmqq8qkuxoh3.fsf@gitster.g> <87ple521gv.fsf@linux-m68k.org>
Date: Sat, 12 Jul 2025 07:08:06 -0700
Message-ID: <xmqqy0stwlh5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Schwab <schwab@linux-m68k.org> writes:

> On Jul 11 2025, Junio C Hamano wrote:
>
>> I think that is correct; I do not think gpg.program is to give a
>> path to the program, so comparison with core.excludesfile is
>> probably not so appropriate.
>>
>> It gives a command line, e.g. "mysign --compat=gnupg",
>
> gpg-interface does not use the shell to run gpg.program, so this won't
> work.

You're right.  Thanks for correcting me.

I should have gone to the code I wrote instead of answering from
what I didn't see (namely, the word "pathname") in the
documentation X-<.


