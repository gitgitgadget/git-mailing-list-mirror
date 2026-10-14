Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE16411A08
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 07:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961741; cv=none; b=Kv5xhjZphm4g83sdTvL1gKn/cmSBnF71mhdsAyxLIHb+ULRHAaiM7t05dwxsK1m6/X+w0oN1eKliZfp6ldHo4sSfaOoRhFX9cMNluZVuU0VV2mMi+M4OKp3jV5NfO/qWfF9NoGPfnv4tXof8EUj5zH5fg85RPIXu4zRRZhenkM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961741; c=relaxed/simple;
	bh=D09hg05kjcpnMEz7p9CWba5Ej+kdRWgLVp8Sx0elO/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONvBQUYRwLVH/zJn0JbHR1thcC4ec4H9CLQNVnTUH89UvlrJTl9RFlLqpZFLwHl3aS8bEmWZMiaukcoJtX5HanFxzCZfugwf705/vUPeb+MWFkW3gc1QT7EEsubpBsHkWUhsiwal6kE0u1Km8qagZ2iUZRSGIn5cpJtzPy6uTbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G76R8o4U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JgYhX4Mk; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G76R8o4U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JgYhX4Mk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A3AA614000B1
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 03:08:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 14 Oct 2026 03:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791961736; x=1792048136; bh=0D+tB+G83y
	dOareqGFkERr1KltRr1ngzF+u8Kp0G8OA=; b=G76R8o4UXSDjQkIld6H4A4XReC
	IBDXO2f0Chkd0KLLqu1rwZf+wQPBQqbxvRh0Pr+I0H9lVzQUGwxgvdlBYV0cJKxg
	G6dqjvMFIYpmRM055xqvayjt3eS2aZfjFOntEs3IiVDhqoMeCRVwM3/Zd4ENZSEr
	IAJm4jnjaYzNLLSDEo55RI3DidzJsbuKSFkxSJmwv9tnmvrUAz4p3+sdjdZNUeP8
	CFvcca2kBwat4q1lFxghuBcqjW681+kSqrYeRWGRnqkmTvqBCFp2TE4NQl04NAKh
	gJIdnxckzxOoAQhqsai/NikDhqsUCALx6/zY7xU8Nrjlppezfll3n52iTdAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791961736; x=1792048136; bh=0D+tB+G83ydOareqGFkERr1KltRr1ngzF+u
	8Kp0G8OA=; b=JgYhX4MkJWK/JExbHRHyopVQX+6air4J5/yTgDoesoY2oU5veV/
	TEAhA93AnTDSM6RoTdZCgE2uHKtEnHsHzEqwSpoxQ1/PGcsRoX2FhqxXSPWsiqus
	SkfeF/s11EldhyGuxMZiv6ew6ldTscrac2EhdGtRYr4N5EgI6az/JuqAitGOgr87
	Zax0R3FZKwbU39Aue48Nsy2XdcqLETbTboWvzwoZYmbxiMfPnahLnaUOKv0YktbK
	Cq43lrEbgdP66vYlGN/OZNAqnTulu7Th2p78sKDDx1O2VC3wHdPC9Uu+LE/fi7Oa
	0A+6EW2fY7ZWDRYRpUz+/4gjWsssACY3QXg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791961736; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hbGvXKBpCkueJNR71z7hBZQkHH861ManV0ekPrKP32T9B2S
	bth3aBrFcBXZtimPhUei54iHbsAoWIqfAfCLNOp+vToTVupQvgzPAOTzCIozB2/t
	XlarbMvzgnq2XxBoWGaChuq1wI4k4p0oYEHzf1RM564hEjURcSLGltgCLWKCORrX
	jTSevJfw2zGbnA1rGRlQ7gPlgQsRykOoUfYODmdN5MPykQF0bN7749hrt34lkhfj
	AwMwRNURqMOyoel/wkymiYuTOKhVcMUBJurmfu8J4kuoGPfm5gK5c8e/eR+FkDbP
	2ABkbzBKXYKGCCZ8gwR0IHYHFNwsXL63dFAj7ow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:tvksqXMKE2Uhp6kaZyDusDCWksEeJrufrFMssfZaFZ0=:D09hg05kjcpnMEz7p9CWba5Ej+kdRWgLVp8Sx0elO/U=;
X-ME-Sender: <xms:iCrPavb5OYMdVM9RR5ME7hpiuKCCvBMvn8li5ZmZgiD_6eDYtiHHaw>
    <xme:iCrPakYRnpGSFVLtJBq6tbrgihzR6RZsXsO_zTmS8MpkTx-2j0miRYwDFDA91Y9R-
    x1ikhV9Km7XLt2m82NnexRDjUk3pki8KeyB2A4P8do4Fu86UwQVkA>
X-ME-Received: <xmr:iCrPavk0o9j9qTrnr2HtEr3834nd1W5RfZNrGOIXGOtIMhSUz9PzRw>
X-ME-Proxy-Cause: dmFkZTENZyUAFSze+xejPImubMAGptLnNXXVwAfsyIUtHfT46HhBom5KfGM8xmuUaNOE3Y
    7q12v2fLCsHY6xoFakFF+H3kbW0ksSa9tfg4iuFDg7C2a2cPQZ4k3nayG6s07KrmE2tvqy
    MXmGL6fvLTx9lSTN2jzSKTRfuu8KJ7yzr9BMEh46BPXtgj1AY3hr+EQL8zRgJCJETRMjDQ
    lE3bPml/DWaiCOZ4Ct4APe8z8kF4SxeCPej2o+oaZUFZdWdNpBtnm1oLuEL7WBPET00oyL
    SwoBHyCdNoEsjQogHcV+i7yQmeE0+KP1+n/4CBu+xRAn/bh+SN5bIO4/W1UvCF44p+zEmx
    ISKdkQPMGYm+jOSI5MULdaHbN8MIjQdqdmtMfSB/iYCPQWgy+YYHdEhPBz9+RccGA5Cn1M
    moooAXk6zwrZ+l8nl2oHeIqoBjqrPmwirEF7RrZ6QWM9z7vnehD5NtJM40od1VBY2oJx0W
    oXwrGmCDB9apX/QXClPQCYzlTrrHvvzyKDMzNgdgb/qPtIkgSnZWf8UyatA8tY52TNQrA7
    lV4Q0eIg85nRz8mt7a8ZOwcr0ViWFXVvtc2gtQY8NFN3CNgPYLQsseY34RfpUoLGWW+KVQ
    eXlAPB25CWHtt4ov3BPcPwnXnjoPg/vvOlTIT8lMsGfV+ex8GBNYWOdR73kQ
X-ME-Proxy: <xmx:iCrPagyNe8pl4smSQR_FFtCPXbq7jTmiLUd2Z58YIK1pjwBAxzc3eg>
    <xmx:iCrPatNTKpD652OXVEgBfEKYtelVZWHqa_f-HUXWfrkMBTYoXCgKgw>
    <xmx:iCrPakQucUeFf6yWCHgpmGOl6btaBapLvH1K91v6fElsSLGoKCxL8g>
    <xmx:iCrParZ9BpUswA2wrWEZJPCDB9ZWZZ-9zMtsRJHAx23ZtANMkaQa8g>
    <xmx:iCrPaiw70dL7zl6iarB4WUjs0x7pVJVXi7DVo0mvsjoX4UqhVO2Ws5S7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 03:08:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cbbc365c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 07:08:54 +0000 (UTC)
Date: Wed, 14 Oct 2026 09:08:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2026, #05)
Message-ID: <as8qhADRcxyQ_rMn@pks.im>
References: <xmqq33u9uprk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq33u9uprk.fsf@gitster.g>

On Tue, Oct 13, 2026 at 04:47:27PM -0700, Junio C Hamano wrote:
> * ps/setup-enforce-repo-passed-to-create-repository-has-no-state (2026-09-28) 7 commits
>  - setup: enforce that passed-in repo does not carry relevant state
>  - repository: adapt `repo_clear()` to fully reset the repository
>  - builtin/clone: don't apply "core.sharedRepository" to leading dirs
>  - builtin/init: move handling of "core.sharedRepository" into "setup.c"
>  - builtin/init: refactor messy creation of leading directories
>  - path: introduce `safe_create_leading_directories_no_share_const()`
>  - path: drop useless `safe_create_leading_directories_1()`
>  - Merge branch 'ps/odb-alternates-at-creation' into ps/setup-enforce-repo-passed-to-create-repository-has-no-state
> 
>  The repository initialization sequence has been refactored to treat
>  the repository object passed to create_repository() purely as an
>  out-parameter.
> 
>  Waiting for response.
>  cf. <CAOLa=ZSX0e25wK5qQwznXN9rVM+WHn8631pkTEN9Zm-BrXfEsg@mail.gmail.com>
>  cf. <xmqqtsn9mkog.fsf@gitster.g>
>  source: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>

I think this one is still stale, see [1] :)

Patrick

[1]: <xmqqjyo016z4.fsf@gitster.g>
