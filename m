Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F75450EBE9
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541570; cv=none; b=Q+DHwhSc5+NpB+vcU33v6wp7f4qwXGPMTWAvsiFZMtY4b53DqPzSLf4CY8MasAciz9fj3PHH0Dz9Aj+3z7BBWitzLNndfVPLYi6SqTUtINGW67w0e79oF9NCgNYrxS6b7GStjskYwYdZmuhPd2DNZ7zLkjRud9rncjNsosufClk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541570; c=relaxed/simple;
	bh=ti99fFINOayOlkkxnQ3oDV7NQIdYnZCM93qRWQesXCY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lNVaNGLkYRdrRvKjEDf2c8/qdqTekUBiSnVbccbDDseDdOFxjNjOPHz8hDuRUcPUZQhBTyLWfkiNNEXySsVmV3fXrFLJotEwVTxfFbUVI8xTbwk7oPPPwQ2qhdGsaNKjv0KBKF2LiKgkw86xT+R0eDcsTCM43h8706vaPYLipyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j+Ou3jei; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nt//c8Io; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j+Ou3jei";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nt//c8Io"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8FE2E140003C;
	Fri,  4 Sep 2026 13:06:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 04 Sep 2026 13:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788541566; x=1788627966; bh=k/qWsKI62e
	heDyMgYI8Q9sxKTovdzn+gq0Al1hxaJVc=; b=j+Ou3jeiCRiD0dBWgas0O4yG7V
	WDNpQmFlHp5doOw+5M7oO0qL+f8Si693tq05Y8Mdm0a1Sp/wkl9eV/+wMloDF8xt
	TFruT3lW1hsiSoAaRSuLU9FLpkI2AAY/p85Xtc34ZzlJYh91Utnus1Ud7vPtX8Cn
	WH6+cQ7zszTd4I5Mt+wafICEEMQ7ZEBH4iIzc7R6C2hrxCHgHFDm3EPcslycz9LD
	+64WDBmh9YJxeg/FiV+98zl0cnH4BaKtHw7vz7w1AJqn5+CQVfV2AvO95RCrh9wI
	ZYXbr8z9LyZ1HUJlqThd1aJFp1mJPRh/nNzTaDrg4sg+gv4bb0nyhVAYxLxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788541566; x=1788627966; bh=k/qWsKI62eheDyMgYI8Q9sxKTovdzn+gq0A
	l1hxaJVc=; b=Nt//c8IoLKP65ere4s/u4huc8YEyVsbQ8z+Ec6+V1jTEBGRwKyW
	QC+o3aEVEMxX7K3c56Mg4g4bBDxjPdvItc5Uljg2blUQYSBcmLDTqsUrCtbbeZsy
	WOPVnlpKh+vO2EpUMvPU/xSVaMOAlknTJB8haMxB/ztxlhuyZnSQtZxpB+oVHCIr
	H3mjk79VAQBSfLLXqvXOeCQp1RDSvxaCDVJW0qBlILP9hz4UqPOmClxMhDG8FpHA
	uE9+1X0g/I1e0YgNMqGK/rpAef5ByEQWS1E6YJBdzRFnANwY2ezP1+bLUcgGED9B
	h0ztNtVyplmLOR5XVI4N9BjFY8BuvuDpGqw==
X-ME-Sender: <xms:ffqaalzuOycN743mhxth__Qkr-7W1sN5yWLJnztSwvK4-vxBWAlT8A>
    <xme:ffqaal-TKqB27qNopEPP08GkMORcyIFrGpFt9l6JWBTR8Ea65vf227yBWy2Yixz6I
    0XDPOdzbhTOt8uQSJKm2fHlIiKmaonu7i0Ym1H2kAB8I7HcDGuMFfU>
X-ME-Received: <xmr:ffqaatjt0PefGuHERcYTLe0fsFtDzwLobVuKkWpi4NWQaIYn7eITHX9RJmrruTrmwpMfohWp6ZaKNsq6nfbzo9nJa3_fG9r6JQ>
X-ME-Proxy-Cause: dmFkZTFjZJe6dtltOA7XfDh1BU5yAgBwY7oreDy9iERn7LClv0RAw2yIUk8tL3p+Wcs7QJ
    79IycW8//gT+qFPwDHLmDfOj1SzMJTjLvX2c6oo2bL+F8A8wz5TrvJ8wlnatxF9bi4U0kg
    8XhFxYGWYWw83u23tpKDgM3IGGTzOe4pnG2khw7Av7u0cLd4NjwYeM0NUyHnaWw9xEfSTN
    ll6dgZYxiaPrguF6fyoSDV9xwqFouG43nDjB0qgJ/7wY7Kbn9e5HNE97OSqhWHnIfFMVOB
    eVzYqxWIrFha991XBEdqUIvOnUrzHT+VmKF7lKVtJKW6DI10hiJLp0XIqeJuODed7fuulG
    oUvTca1QHpoWUI/iEYhUGj7GhuPTg5fivWMmDgcTxVLvnGubz41zcsHCCU+4GfWjWk2cnT
    qa+JgIUBSKb3UZVbbo6UCmkAuD3EhsuI/vdFiLjiQ2oRrjc0x3QJ8+x1CeF5mOHM5Hb8t3
    n6MhMsNAMv8zrBqce6wLKxm68eXAntZbAa4/2Q7/nymWPtb1Nh/RQCMFJLjZZN9nGGEGKg
    OY/YpuJrbk6y3y4uCMd7ycSpMPsEjBhPiO5DYASZDMCtfEkYhD52AbwfSFQ97cFljrOoH/
    hRLov9GzgYvg3VlfaONcLeKjBSLGaRWFBcczF4cXehfYOsuab2/QJ/H0wRgQ
X-ME-Proxy: <xmx:ffqaasG0Eh8QrN8B3MuYALxJXUxvpOgS2ruN5mWT948iPxFFqfmrcw>
    <xmx:ffqaas-3In1lEQoc1W6qViaBA_SkLzUuFUwcX3evaV3mRnF4zt1S7w>
    <xmx:ffqaajw4KfxTmxshdJMejtI55HS0h__7IT9YZL2FUKtgL2uYCmD6GQ>
    <xmx:ffqaaoOX79gvklwBXrne35k-2ntnHSJkB1aBXE9zKcfHmY_sEN7FKg>
    <xmx:fvqaao8F0XuWZaGpfyDuFnN-jpIfQzwhNs0zjHiE5IDrikTBii2GJLXY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 13:06:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Thomas Bachem <mail@thomasbachem.com>
Subject: Re: [PATCH v2] rerere: keep a background gc from killing a rebase
In-Reply-To: <5e613735-60e2-429d-a5bb-1a4f03578604@gmail.com> (Phillip Wood's
	message of "Fri, 4 Sep 2026 16:21:34 +0100")
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v2.git.1788507876543.gitgitgadget@gmail.com>
	<5e613735-60e2-429d-a5bb-1a4f03578604@gmail.com>
Date: Fri, 04 Sep 2026 10:06:03 -0700
Message-ID: <xmqqfqzp3q10.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Overall, this commit message is rather long and it would be helpful if 
> you could distill it to remove unnecessary and unrelated details.

Hear hear.

>> +rerere.lockTimeout::
>> +	The length of time, in milliseconds, to retry when trying to
>> +	take the rerere lock while another process holds it, typically
>> +	a background `git rerere gc`.  When the time is up, the command
>> +	warns and goes on without rerere.  Value 0 means not to retry
>> +	at all; -1 means to try indefinitely.  Default is 1000 (i.e.,
>> +	retry for 1 second).  `git rerere gc` does not retry, and
>> +	`git rerere`, `git rerere forget` and `git rerere clear` fail
>> +	instead of going on.
>
> Why do those commands fail rather than wait?

Isn't locktimeout about waiting?

After waiting enough, why should it not fail but proceed?

When there is somebody holding the lock, they acquired the lock
exactly because they did not want to see others (including
ourselves) to touch the rerere database until they are done.

The description "`git rerere gc` does not retry" is highly
questionable.  None of the others retries, either.

What makes `git rerere gc` different among all is not that it does
not retry.  It just does not insist doing a GC and instead leaves
without doing anything (and without failing).

I think this is justifyable as the actions visible to end-users of
"rerere gc" is a vague "discard old enough crufts to gain the
diskspace back" (as opposed to "I know this particular entry is old
enough and I want to see it gone right now").

Compared to that, with "git rerere forget", the end-user explicitly
says "I know the specific rerere entry i just saw reused is *wrong*
and I want to get rid of it".  If another process holding the lock
prevents it from being carried out, I'd prefer to see it fail loudly
and let me know that the entry I wanted to remove is still there (so
if I retried the same merge, I'll see the same mistaken resolution).

>> +		if (fd < 0) {
>> +			warning_errno(_("skipping rerere, unable to create '%s.lock'"),
>> +				      git_path_merge_rr(r));
>
> A background job that the user did not explicitly start printing to the 
> terminal is rather confusing as it is likely to get mixed in with the 
> output of whatever is running in the foreground.

Very good point.

Thanks.
