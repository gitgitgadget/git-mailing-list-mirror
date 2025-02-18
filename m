Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4E280A51
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904686; cv=none; b=NaO+r5wjuqWO9sM9dwoSSLp3q8sgkI2WsLU96dJW6jAXdm26WSvCPJm/BMpgeFXoteqGJUFJ4H4ugkWP+Z23BDVIQsfK+z0y441cxwOpkzy49KzHh4AcepZWLaNrSe+LRKFrK3RVLwc40+g1J1lVH4n1x9O3rpF8I6bTDs1cblw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904686; c=relaxed/simple;
	bh=Pd02819GTKLbxlPeQfdDeFr/FTsxayt9LEZcb23N2uI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CplA4wIlVfmlmzyn81V6eg5+8jDjoykW91FZ7cvS0K19NhvqNxHPKmVacnzvbU9QprW4En+y5PBJkwndZ3YRAlDqzqVAIfK5Hl7R8mGxfuSJq1YJ8asFi/0uMTs5K3oM7VCsw2pVhwV8VcoX/xC1jhYN6KrOF+Z/T0JYWZoIquk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ERykgV2M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kBQimGdt; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ERykgV2M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kBQimGdt"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 0D35D11401B0;
	Tue, 18 Feb 2025 13:51:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 18 Feb 2025 13:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739904672; x=1739991072; bh=6wyVromq07
	pFzWuapIBMmntHiNWagsB1Tgm1v+lau6k=; b=ERykgV2M9jbGEE++F05IInR6lF
	4LJQvpya+DlMTLs9sjFiVMLs3BgLxWnVZUx3tImiJPR4DSTNEpVX+yMiQWnHEecz
	xy1ZaFH06EgSXcXExfiN9rA7rWIdpR99SzZVl6L75g5j74jFJ7BKCollGybo2BPA
	7BeyBQWoSyf3yTfNIuNalg8Set3X5JNIAmztOIaIjvJgdJxmcIFuCFMMI0e8UbJw
	qLQjWf+IoJScBxnuqJqkS2GSacaY39OtTmNmdkTNnwunW37aV71ZaSsqgKrcff5t
	2boddg1PLk3WNOoIsG3IY3AhS0TjFsMrDPLKf9Vss4Nz3fQIRjkAjrmKjxPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739904672; x=1739991072; bh=6wyVromq07pFzWuapIBMmntHiNWagsB1Tgm
	1v+lau6k=; b=kBQimGdt/h3X+OwdFI/uSj3LCzuV3nRYva+ZrLdxE4XQ/FzHkYo
	u3CsP/9soqnsqkA6BI5bj2fq3nHyYql3U0TsQR7lR9oLaj8sI5mGYaYoXRORXpwj
	U4WfXz81fWnyLADQUjiLBHM2lXh5+mOOqawY2RNhvIteuKK7OoF+stilDFwfXpFQ
	gPpVbhqJJhfO/pqkH16vLRs/XeCjIZ6kv88rx4HuZnx+wuwaV6l/e7Wr0vqjh3qW
	akVvPiOYBsKeLVZxapcgJMhLU1azgkQpTB3e89zxbUGh33b74eriyvzz0EXos50/
	K6on6sxAVjG6Pqw43uYQMgLLELb3YMtJkKA==
X-ME-Sender: <xms:oNa0ZwUDsrK1a0HwnZlpzq2dv89CsdcUeM81We6G0jKbRkXjEDvZfA>
    <xme:oNa0Z0njE2t6YPRsqiXVwHzaBqN4ytzc5FAjEvlncL628R3aOUGJkWqtn0Jn9kFFL
    fp5ci-ZHG9iYlOZvg>
X-ME-Received: <xmr:oNa0Z0a0V0Ia-jfOSs19EF9tJQOFN1OyUdRMvzcLnyxSJA64JmcBlgfgrK1_PAcmJSVES5TLPQsic0jQgjBviKxoqXQwatBFrtDq5gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepmhgtvghplhestggvphhlrdgvuhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:oNa0Z_URujSzLhwQKjAijuKL2I_JNMYdKU0nyQWCH9xx24efVZkixA>
    <xmx:oNa0Z6mHe996oYbE3dOD2tMwgXhf0ImzoWPEtECnrrz3F0ewhUFVSA>
    <xmx:oNa0Z0c1LUJ44R8XyRv9KRbu2xmFQV0Msfuy3-wh5RdqC6laD0jAvw>
    <xmx:oNa0Z8EKL-0KT1_6fM1uVB8Pnl28saYu9O8YdmxFu6zWMsElkhJ1FQ>
    <xmx:oNa0Z7DQlIzUdDjvWDXoHhEqnPMoGFy6j6eV76KW6HCV4A-9EuDawLcQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 13:51:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?Q?Mat=C4=9Bj?= Cepl <mcepl@cepl.eu>,  git@vger.kernel.org
Subject: Re: [PATCH] doc: fix typo
In-Reply-To: <Z7QszEnV4EzQMJ9R@pks.im> (Patrick Steinhardt's message of "Tue,
	18 Feb 2025 07:46:36 +0100")
References: <20250217130902.2706880-1-mcepl@cepl.eu> <Z7QszEnV4EzQMJ9R@pks.im>
Date: Tue, 18 Feb 2025 10:51:10 -0800
Message-ID: <xmqqo6yzkrxd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> You should probably rebase your commit on the latest `master` as the
> file has since been renamed to "git-send-email.adoc".

This looks like a 'maint' worthy material, though.

Downporting with cherry-pick should be able to deal with the rename,
but queuing with the old name on an older maintenance track and
upmerging should be cleaner, so .txt is fine in this case.

Not that I plan to do Git 2.48.2 anytime soon, so either way it does
not really matter, though ;-)

Thanks for a review.


>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
>> index bc3ef45acb..d762058907 100644
>> --- a/Documentation/git-send-email.txt
>> +++ b/Documentation/git-send-email.txt
>> @@ -389,7 +389,7 @@ Automating
>>  +
>>  Default is the value of `sendemail.suppressCc` configuration value; if
>>  that is unspecified, default to 'self' if --suppress-from is
>> -specified, as well as 'body' if --no-signed-off-cc is specified.
>> +specified, as well as 'body' if --no-signed-off-by-cc is specified.
>
> The change itself looks obviously correct to me, thanks!
>
> Patrick
