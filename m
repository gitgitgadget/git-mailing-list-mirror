Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DD642E410
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788379718; cv=none; b=MFX76SU7+s0v+ZAQjfCtAKM6sPvzBXwzwDiCOsPjLJxi50vGZJ7xlZoeJI6dtNJ2FgQu1KuycyS2yjN6kEHrHH9/T9ctE3+bJ8oCCz4yR3X3gQ5nqSXsJr5wNOJAWPXcKfRnYXjGjpEcbu6Ij4iEdsHpjju9RD9tCFcHxT8AA9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788379718; c=relaxed/simple;
	bh=aLcJP8AOc4IdGUWEEv6VxhS98y+hzhvKcErvBAPZEIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lBb0cktm1zBiGZ2bNJclFtaEl8go6f5g+dST6IanuUUdJ27TSaCycuwB/R4gwvMp7iJEcPPuTNNK6vY4ljcE7mfK1hn1lUk8rD0iWnD9MgtqypwOnOTWPCDHdLjemuHPhnlk3nWI2BEWcXThHWfPfuggA6SX13W4jTwAH+xSvpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tC64aMJk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ualWl1wS; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tC64aMJk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ualWl1wS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F41907A0147;
	Wed,  2 Sep 2026 16:08:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 02 Sep 2026 16:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788379715; x=1788466115; bh=LPphEd/zyP
	tbcxJb1T86/DqKm3Od4YW/JhudTWH85EY=; b=tC64aMJkJVdTP1RufKp7aFeqqO
	q0r5j0FOJ3Lb2o952hkuroH5pInfqjtUeb2UuH2i0DNjpCjx6LfYGdtb4xk+Plap
	w1iAr4l4P0kJxM2dFY2vEho5e6oonCvCB7lMrt8F+/HNkRq8ZEgjl9cTSlvJR3on
	4ZWYk4q/Jl1VQlc+5ak5EK0ZW9vlFzeyiAVzxzvIKy7bxra8bHWn0Hi4iqA0TdwK
	wX8Jm9b95hscxn0lfbsRfESf1xD46bGZXB7R429sotYb5PMDzd5iikb/WedceAEE
	Vlaya0VXtpkA6o0rKpyIi0Cj3+4UJbC7OeLVvhaoZUa2BpKqVhl3vFsFZZbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788379715; x=1788466115; bh=LPphEd/zyPtbcxJb1T86/DqKm3Od4YW/Jhu
	dTWH85EY=; b=ualWl1wSFrj4xYigYewU4SrKO0+n1IQ9zBdpCG6T/drR14U4bmU
	A0BYlyu02HU2knGti7UFu2hvevytuaY8o/WCN4lO9M5nsCl5eapZSH3p0XliNgeV
	0lFiYRkOOnXDefFEL7jnrOGLPhJBs3sG2yXmTZUgey9sCEYeogIvKt2SSl+0qAZ8
	tc+x/10R0Psu2g9Bie+wfOwdvAdwU8ZaI9p8CPFs8rfAcnD1K72VnIrsNbdWM8DZ
	WFAJOYj8VT1Y08KYOIAbM3xLIU3KXA3yukM8Uk8Ho1wKspPMfc3HTU6b9GguE0El
	WFbwrTY1WmJzLlx2jtrsxlQlzKBjuCC808w==
X-ME-Sender: <xms:Q4KYarTzdOMOzt8JKPklrY0zRQubB0Cw6wA3icXA52cOCyH4cmmTYA>
    <xme:Q4KYajpi3MjIuQLL2Nu_SZUQeFIIojjBAgt9Jmvy6n4hFC7zhXj-Bk5S2D_3iIJ8x
    oV-fnUt9kkB0QxVBynL-vGZVJw0N-QBOW2UBMbgT8h61ny4BI2MfWQ>
X-ME-Received: <xmr:Q4KYapKBoAKRXC-Bxc93-HUtYtoFsLZgggQ7qE7YmxoOMEUFqPOJPnmzfPJyc0Qy85yzAmHykayJnDWMui3KmVRrE2qu4LlP2w>
X-ME-Proxy-Cause: dmFkZTGuI+6oNP45z8L12AZefMSCSt3BrZQ8hnrXLxHG4c8ZQVtimnuxr/eUyq1i3Zc6eJ
    RLPTirXK70h7q3rEqrsU+onrCePGpseOsoLP+vb+7I0aQJY3daSen0yzolQBgbvv+yuC7S
    MmgPcxCWoFUksDYCrLrXYFXi9h64Z3pTLFWVq1QUYIOdVErCd72eYKGa5+81PBwdBanQgD
    N5GApTptqoD+z9JL9RXC74+A6zGqc66LVoFtUo/BjrfX6Q9gvIyiT/qZm1vH4WlTy8vEQE
    4/t2oc+7wAwn6XzB7gPxV4zIuQMxDckPhVAUPFi67NnBqT8tsFTu1Vg09rwzFG4CU6pGtv
    k61bMM611bINQWJ7z/4wmk3+FuqhbSZQ4PvvWepeN7oTlhZza9tQD8nW14nzA0QPprmdCW
    t3jE/XdFdu4EZM7+KgQqdvzUH6R7lhjgyocv2s/Km+ZPiQGbbcNhW6wpUhU/DOM95pJ/g3
    h5PJJty/qQdpKQHNMvv836puOt51z3cjZP3LkX7JgNGP4mHB8p6jWFkbHv6uH6bZW7/hbi
    VfQWXfEJwMTR7Ksnf3nLY1UiZVPFe5e64NpA/xDAxVo431dr2sG1LDOP3RwRSYEpAEE0KF
    FvPAZTPfxP3PYGyHqKXMBaMneZiao8soTYT0HIevIIKqpjDGktf5BF9Xa2bw
X-ME-Proxy: <xmx:Q4KYamqB-eZ8nQKdbn3thqo-TcvTGC60fGurcLajXzArgDmo1HT3PQ>
    <xmx:Q4KYahwTT_E40F80PV41uUEaY7UvdH6wy1mMLCMgCSoVYKV15uAbhA>
    <xmx:Q4KYaqOkorMh9qQNGFhcAqOQJRjedjrzjyFxYdLgpo4xwrmTKkm5yg>
    <xmx:Q4KYam7TpxLyxHg7tlDF1s9VmSy5oSJQQhycIYEMwrG2lThynUor7w>
    <xmx:Q4KYah4M1pC3-v0Cb7tINdhvYY5I9Dyl_-2B7M4wI5DqpmxL7cWOlrkX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 16:08:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4 1/2] stash: reserve exit status 1 for conflicts
In-Reply-To: <xmqqwlt3h1oc.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	02 Sep 2026 12:51:31 -0700")
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
	<pull.2364.v4.git.git.1788373743.gitgitgadget@gmail.com>
	<ff4322180294c784bcd5f4e92b35e4b334324ddc.1788373743.git.gitgitgadget@gmail.com>
	<xmqqwlt3h1oc.fsf@gitster.g>
Date: Wed, 02 Sep 2026 13:08:34 -0700
Message-ID: <xmqqmrtzh0vx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Harald Nordgren <haraldnordgren@gmail.com>
>>
>> "git stash apply", "pop" and "branch" exit with status 1 both when
>> applying the stash entry resulted in conflicts and when they fail for
>> other reasons, so callers cannot tell the two apart.
>>
>> Follow the convention of "git merge-tree" and the merge strategies,
>> which exit with status 1 to indicate conflicts and with a different
>> non-zero status for errors: those subcommands now exit with status 1
>> only when applying the stash entry resulted in conflicts, in which
>> case the stash entry is left in place, and exit with status 128, the
>> status die() uses, when they fail for other reasons.  Document the
>> exit statuses.
>>
>> cmd_stash() used to collapse the return values of the subcommand
>> implementations to a boolean.  It now maps negative values, which
>> signal a failure, to 128 and passes everything else through as-is.
>> The only implementations that return a positive value are "apply",
>> "pop" and "branch", which return the value of do_apply_stash():
>> "apply" returns it directly, and "pop" and "branch" drop the stash
>> entry, via do_drop_stash(), which always returns 0, only when the
>> application succeeded.  The positive value is always 1, as
>> do_apply_stash() only returns a positive value when the three-way
>> merge was unclean.
>>
>> Make the convention explicit by introducing enum stash_apply_result
>> with the values STASH_APPLY_CLEAN, STASH_APPLY_CONFLICT and
>> STASH_APPLY_ERROR, and use it for the in-process autostash helpers,
>> too.  They spawn "git stash apply" and can now tell conflicts apart
>> from other failures, e.g. a crash or death by signal of the child,
>> which map to exit statuses above 1.  Since we know the stash entry
>> was saved, tell users so in the error message instead of leaving them
>> wondering what happened to their stashed changes.
>>
>> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>> ---
>
> The above is on the overly verbose side.  The first two paragraphs
> give enough discussion and the remainder mostly repeats with small
> details sprinkled in, which can probably be shortened to 1/4 of the
> amount of text, but it is OK.

Just for fun, I complained to an AI agent I had nearby with the
above four lines of critique, which spit back the following as a
replacement for the last two paragraphs.

    Update cmd_stash() to map negative return values to 128 while
    passing positive values through.  Formalize this with enum
    stash_apply_result and update the autostash helpers accordingly
    to distinguish conflicts from errors and inform users that their
    stash was preserved.

As I said it is OK already, you do not have to adopt this shortened
version, but I personally think that this level of detail is enough.
