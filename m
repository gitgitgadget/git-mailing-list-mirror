Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F8B4A99B3
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788376480; cv=none; b=J8xLEXa3RoHnlYHNrzFe4SzdLTyCq3JsmRWTGVgPe/DJxGb3KA7a9DmAbzgzUMPyE7hZ5SGgbWm0qINQV7GMD65abOnEqG+S5eB9YTrmdDwnfAbGvGDhUPEuoHOmxESYNcUp4ofWmt2seJ/27PyZ5akwyUhqR+nAtHrrXlVphK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788376480; c=relaxed/simple;
	bh=lsXK4gLmuTPc01dHKSPnAcdWGrLo2DbtrEnmnPXfTUI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hv9IQrXmPe64xgt0SRRIqta3S9HotTZAO2uk36WqySiRRTADaNWj5qHIuG9gWdBW2J7JYqqgwjZ7HyR0oFvf4CqbCOkhixqFdlEk7gdwKfoF0XcABPdeVlavqYdTJQuxRCrjBIOhH94UtGFRfkt4B2xxaFN6Cf4LmwyEIwckblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z4xORkB2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fNzzmmC3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z4xORkB2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fNzzmmC3"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 10F4F7A0018;
	Wed,  2 Sep 2026 15:14:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 02 Sep 2026 15:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788376476; x=1788462876; bh=zFaYWV2D8N
	FZgn+1NrBGW95jFLhm+bjvvpbFYOM3SLQ=; b=Z4xORkB29G6UenqGF0jC6kV3ow
	1wUAVdxCUAsrBvaatSJ8ctBcM6fTwFyQs/D7GM5t5s3tcxdEKW6g/zJ5Ufz5vPRF
	JRI/vuPpJCA08BcLX1UmVDOYTzG+9nr+HfOYYyGu0yHE5xPPzvTS3AxQmme2Mb/T
	MARUZbuzpEbBH++i7teewyo82yQvXJhfer77TiM7FKnnwQRiqfBAi9jTVmIUS1Dc
	tm6peRdsUJ4C+vWQd0mRC/hdQrKVgaYIwnMp7JII9uli1cm3hyiytkISdk4XJiRc
	RxHPNQRieINZ1+YLOr/Z4c/25psLFoUYks1b2yywA9mCLvJnOxg/QH2KadRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788376476; x=1788462876; bh=zFaYWV2D8NFZgn+1NrBGW95jFLhm+bjvvpb
	FYOM3SLQ=; b=fNzzmmC3IEhsXq4eCGp3aDPhCXYm/z5O3RTFjFahXcjNcw0iXfA
	NykVHUXhbktF8MYA9tNJJb/7zp8Yxag4ydF5zxfNxt46ZFZ1RZoAOjlhkVwHDyyt
	HJ/3drH7tdSkSHfHbmnnnRs6RQSLYNBFC+SF3m5rf9UrZCphEn6EO3Ji2QB5stgZ
	IyLJ3TBrv1060etWk4iUEfQ6Mh0WcqBjX4u2T+C9hDpOynWeCOV3Mq5iAT4G9SfG
	7sHRHhK1whqvAw70N3VzT3IKR5hw6IY+Y6hkVplBCGmm7DwMsWy2kLWS1qL8UWZ1
	cvc9uR1YPFWpRQ5JJdiaqmKiYAIMshTNFVg==
X-ME-Sender: <xms:nHWYagL9r7V_HZMM9-Ai6FMi5w9copA_MjCvbA4F2rwtJ-MkEA72_Q>
    <xme:nHWYag30xQF_fkz_X9Ptf4dRpUuTxs_RYQDCsWILSzsFG0Aet7UrOIYIlaZyXNzPP
    jxY8IAqLoVs_V0hlD5cIiETRtEHAsksLxvwIxk2_d_ZFQZU_F_t>
X-ME-Received: <xmr:nHWYau5rPSRYn92ptQvfQk36pCW1IXJQUhDle6CUgqELGs584c9prJsAzCN3amAWyp5cNF4VwBc8xEIdBgIkqaiQ1YvV4yLayw>
X-ME-Proxy-Cause: dmFkZTFQsrMR+xfC3juwpe2sESMC7YGUrFoWyHDA77vpMlf+fHTSeeD4Yszv6gYHjXYel1
    xpGngYwuAmuWmjx/rATGGk9dToNBIUb4rSa7eADM5GsWBAFj2RU/VHpge/AgEo2lCwiEjL
    xykHGG6h1KbFM1Ad6hwqMDGDH6XDO4VUDuviKC4YtRaMAsG0ujTyUZ7SqN0v3Eu/BILpwA
    5M3g+lZI/WyxJGO04KKT3aVq6qxCLoiGbyPKrjfGcnwni7kfYbHTuLuczi6U/2BiE002rz
    OrWN6a34mTTwkZ1tKqBHctFM7BdD86AYGk7oh3sPMjF1QS/KDwZ3E1E+FLGrthp+utExqe
    J/2a4Hu7Y2l9FzhyxusXNESRe5IMudq1R6529PftbWikMEN0LYbMFotwgU0a7kFrm0Q2zA
    FD3SX9UW2g7N+F0y31wCShI9KkO+wmmlgpzGUF3HUDeqT/I4P4Tx4lLsxQ46wpOGAcCuXc
    vQBL24QYqDzDHxfBCaHlzxAPvdVySFe2aQPDh4i26+C3q+Y9bevunPrDkdJ4tTaQl16XtH
    8F0c6P18fnvRXwZme+NGlNeu/28k+Cax/m6yK+qGmGuJtUFEyAJO5r98FN2E/8BsWIEmnq
    zzk8wUhF9ndkmM7iHpJ5sjMvPQK7pDUHfOtOfzZ6I2SZXwdbL+Tr2FLlPtfA
X-ME-Proxy: <xmx:nHWYah8o1NKhOQLwekpJliDGjngEKx4_NP4-6UUFj6-NingHweqJlQ>
    <xmx:nHWYatVKz7I0eQKroQ6G1GvjhqwUFOVIX8alJU2kNm7NNty6GvWfGg>
    <xmx:nHWYaso1Q6B78hutWct8vmTljZHByLlN53YAQ4_rlzRIrdCtF68mWQ>
    <xmx:nHWYavkgtvQDz8ZiUc6TKmVjeoI3jCID2PWdk_C6AYsPDGA7o2AH8g>
    <xmx:nHWYatHOug1D5v5kBU_tEvYeQOwsbI_BTuDe_4LwnlSwd3z7j5Sv9uUc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 15:14:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  kristofferhaugsbakk@fastmail.com,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5 3/3] hook: introduce the receive-report hook
In-Reply-To: <CAOLa=ZTfPq3r3b7EDOSrG0-uSFQGgu-k3agPJgUV9xao8WsQrw@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 2 Sep 2026 07:42:19 -0700")
References: <20260901-758-introduce-hook-v5-0-35cdc6be3cc1@gmail.com>
	<20260901-758-introduce-hook-v5-3-35cdc6be3cc1@gmail.com>
	<xmqq4ig8uco1.fsf@gitster.g>
	<CAOLa=ZTfPq3r3b7EDOSrG0-uSFQGgu-k3agPJgUV9xao8WsQrw@mail.gmail.com>
Date: Wed, 02 Sep 2026 12:14:34 -0700
Message-ID: <xmqqik4nihyd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> In any case, if the actual ref updates and the reported ref updates
>> result can be made different, somebody then needs to step in and
>> reconcile the inconsistencies, no?
>
> Naturally, the server is in charge of that, this is similar with the
> pre-receive or proc-receive hooks. In that aspects this is very similar
> to the proc-receive hook which transfers the responsibility of updating
> refs to the owner of the hook.

I am afraid that my point probably did not come across clearly.

I am talking about the repository on the user's local workstation
from which 'git push' was run.  The server reported that the push
failed, so the remote-tracking branches in the local repository
reflect that the push did not succeed.  In reality, however, the ref
transaction was already committed on the server.  When the user runs
'git fetch' after the failed 'git push' returns, they may see that
the server actually accepted the update.  The server cannot be "in
charge" of that, as it is incapable of resolving this discrepancy.

Only the user, by choosing to fetch again, can reconcile local state
with the server.

>> The way pusher perceives the state of their remote repository they
>> just pushed to, which they learn from the output of receive-report
>> hook, would have no link to reality when this hook is used on the
>> remote side.  This may matter because the "git push" updates its own
>> remote-tracking branches to match what the remote says (i.e.,
>> pretends as if "git push" was immediately followed by "git fetch" to
>> the same remote).
>
> For remote tracking, that's exactly the conservative behavior we want
> from the hook. When the hook reports 'ng', the client does not update
> the reference to a new value, meaning the push did not happen and that
> is what we want to convey.

But still the server side did already commit the ref transaction so
the update has been made.  Here is how the proposed commit log
message explained this:

>>> Note that in either failure mode, ref updates already applied by
>>> execute_commands() are not rolled back. The hook can cause the client
>>> to perceive the push as failed, but cannot undo server-side changes.
