Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3445D35DA75
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624939; cv=none; b=VVw/pJCWEWBnaJacTBv9q8dq6MchIZNi0UnHPJqk6LH2w4fbLl/3wYBG+zps+a/PPh10VyfJI/dInuoNadKdEUeE3QpoDJIA5Wsv2o21C3AYBkviMjpcxZIP0xUSDQUQFNE8usyspHJ2EiNeo7G08DBBoSX4gXLWj/xVSv73u5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624939; c=relaxed/simple;
	bh=htZ0gn4iOLrrklH/PH4vVhHs99xd8luotRkf2egq9fE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TENGaiDQr4Y+GiVFvObLeWwduNIyhv5J0w3xKg9cvQpwHOUH7FwSuY1pUNStxVzIUkN73IDtpKfLj1xlUboQgXrd2LCsodpsDpKSJKbpJKar9X5k9iQvGwSYnyLTn4Pu+yhDeTOzlxBnEkcAKionZCKYj3man+4e/Uttbhr4Xoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sl/Hq8MT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PbyOzBSm; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sl/Hq8MT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PbyOzBSm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E4111D000B0;
	Tue, 16 Jun 2026 11:48:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 16 Jun 2026 11:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781624936; x=1781711336; bh=o+kCF8neba
	YX0JAMYGsLdjeMBvrQ/Kc4yIIHFbMWmW0=; b=Sl/Hq8MTBY6GEONUPzP4Xp1nxc
	TaQSuCoYIn2e1+lVg3yI82Kr5t5xsD5PoFSv/lRqp/h7blSlWfURG8ExvbK46SqY
	6ovB5cCThzx5yqtSgCrVEH9bu1CgftFraZeBIHfuNHjKvCFdyBenjs4jnm243/Ya
	CL0WkfLXnFm38Cqoyd/AHwlrkVklAC4GtMNl+kt75fbUXUsXLeFUjWS0gKls9gVX
	+k6IshWMIdL09AC9VLlWIhVzuRD6zZomExCVFqtoYtf+1pUZ9xiowJJex/eK9tWx
	rRLa3To1bBaxa9HoR+liykeNLqF6XlSu0tbQwvJhb0uLw627mznXGVSdghig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781624936; x=1781711336; bh=o+kCF8nebaYX0JAMYGsLdjeMBvrQ/Kc4yII
	HFbMWmW0=; b=PbyOzBSmW/SBKfTKa3d36HZjQUTR7Ux4wZ8TwHYk8SsJpuPYest
	UQMR5iOu7koa8a81NhGDN3vXJCK8qTjwNFEXgmS3OAaMWHdzhlPk+ifd2miuVM2o
	NmiI83eHrSQaIIaSJxkV458hhaFaxID9HOO+ihyBwO8UGCNa6tPl7FIizBy55LIF
	yVnj8skcMqdZaPoX+zq7OUBHuABB3DhzMPIv7ak8Anxq9fUSIw2RwDQDuLV3Uv/r
	5fLcKI95D1k3BzOllGOLNcO4XIobB7Jjwa7gtYdBsbbvwaaYrmFF1vyJWC1Snz1/
	cehKsv5KyYmqujqoj9qaBi3NhfQBF+WCyRw==
X-ME-Sender: <xms:aHAxav23W6VtX3Qj_AIfcVLZ5gmml39ndIzC-138xFIt9ctcq7suIQ>
    <xme:aHAxak-Lw-3qxChSmSIWn7DoxJBYFdHLiZqCumukbZJp3vP49altNBDQBAUxh_n-K
    ViEmieO1N9mgBNN5VvVZtxujAgYxyVlq_Grjwb3fG_LZxuyh9A>
X-ME-Received: <xmr:aHAxaoPdUX3CSeHz7YS8Uhrbe5icZnFR3L5YRtcUiDXA26KuYDMkOEyubeXvErO6MHEEqid33t5o_75GH7Fh77H78aIIb1r5CXvz>
X-ME-Proxy-Cause: dmFkZTGaA9zoBYutOaeluXdkobG1Tnkm4SY86MJMmRTYW6jHiBtwR+ccg0fasHo76aps6t
    ITA5snLRnrNNKnrqEcKT/uzvwuFtSQQGZGacIyMmgiKztmqMl8jOA8HEhINiOgJAGBkr5w
    iNy3JYnHzVjh7xsP6sCN0W81MPEWgCS3HDNPJe3V5u64mhyBBBGtPNNc/vQJL0XeBaSziE
    x5plq/pQgn6vvIhukXYe8zhv47fZP1qhpvD9ZwoVVrRDMGzxWQjlzKdTl/V+TTscIg2YTn
    M7kPOpMkM9qdI8vDuBx+BEp6nuRd87qPRt1O+QSW258tu9Z5HbH/qwOBAxL77X3sn4GiVS
    cl38+bhIDGdoHFpT3iznZc7XyZggAG5VooCMTtfdVJHxynaGfUBr1GPMJl65qF3ZZu9ob6
    /g21DqT6Ri5lRczQmwFxek2lcQYFgyDQblXoeiro08isRwlB5EOQVqs13dRD3uECa8yfNX
    2j6gekoHTLgqc9+nNzntJanPNFRjKAL0+DpR8vdzRqog4zpJayjEZ8qMmMT3ZfCfgZ837m
    aVLGjUFjkwzxdfN/I5qLZk2fq7OxidSeCwzkbBo1/13kN66/PVPlTcE8mS3RY1t+WW2qZd
    j/GadgqEBCUaOvBtCwgKxnOzVbwBAdPH14OXZHPG6VP/FNPz2b7UP36G9zpw
X-ME-Proxy: <xmx:aHAxagctRD2Z98VTNq1z_uz9TmWnEQejgUwQmXk4QJ02YkrgQRdr_g>
    <xmx:aHAxavUyBSCq017jFBigyRD__avgZVF7ZAmJtwFvQ62czsLGtTSFrA>
    <xmx:aHAxaggq18Hz_dt9UXHzUQQHf8N7CJFSNdU-DPPwOxuMpIYZ9Ez0JA>
    <xmx:aHAxam9d-d2m_r56N1wd4ypcc1Bp-crBv-UbYeXXafU6_u4v1uUr0A>
    <xmx:aHAxapsmc1hi-Uso0tb30CCEM67YQTtU5P0gUKkI_efyRgE1DWm0DcOc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 11:48:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Tian Yuchen
 <cat@malon.dev>
Subject: Re: [PATCH v3] read_gitfile(): simplify NOT_A_REPO error message
In-Reply-To: <20260616144554.GA2305974@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 16 Jun 2026 10:45:54 -0400")
References: <20260602061159.GA693928@coredump.intra.peff.net>
	<ah6WEtk2pXyViEQA@pks.im> <xmqqeciezh0w.fsf@gitster.g>
	<20260616111919.GC687438@coredump.intra.peff.net>
	<20260616123516.GA2301231@coredump.intra.peff.net>
	<xmqq7bnya7gh.fsf@gitster.g>
	<20260616144554.GA2305974@coredump.intra.peff.net>
Date: Tue, 16 Jun 2026 08:48:54 -0700
Message-ID: <xmqqjyry4hax.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Tue, Jun 16, 2026 at 07:25:02AM -0700, Junio C Hamano wrote:
>
>> >     +@@ t/t7450-bad-git-dotfiles.sh: test_expect_success 'git dirs of sibling submodules must not be nested' '
>> >     + test_expect_success 'submodule git dir nesting detection must work with parallel cloning' '
>> >     + 	test_must_fail git clone --recurse-submodules --jobs=2 nested clone_parallel 2>err &&
>> >     + 	cat err &&
>> >     +-	grep -E "(already exists|is inside git dir|not a git repository)" err &&
>> >     ++	grep -E "(already exists|is inside git dir|does not point to a valid repository)" err &&
>> 
>> A few things.
>> 
>>  * Will we be happy to see only one of these possibilities, or do we
>>    expect to see these once for each kind?
>
> I imagine it is only one. This all comes from 9cf8547320 (clone: prevent
> clashing git dirs when cloning submodule in parallel, 2024-01-28), and
> it is expecting the nested path to cause a failure. Which failure I
> guess depends on the racy ordering. If we create the inner one first,
> then we probably get "already exists", and if the outer one, then "is
> inside git dir". I don't know exactly what sequence yields the
> NOT_A_REPO message.
>
> But none of that is changing in this patch, just what the user-visible
> text is for the NOT_A_REPO case.
>
> I did briefly wonder if we might see "not a git repository" from a
> _different_ code path, and need to catch it along with the new message.
> But running successfully with --stress implies that we never see the old
> one anymore.

I see.  Thanks.

>
>>  * a recently started in-flight topic tries to catch bare "grep" and
>>    fails until you write test_grep X-<.
>
> Yeah. This will create a merge conflict for you, but hopefully the
> resolution should be obvious. I don't think it makes sense to fix here,
> as it's orthogonal to the purpose of the patch.

Yup.  I agree that, given that others in the same script will be
updated by that other topic to conflict with this change, it would
not make sense to do the same changes here.

Thanks.
