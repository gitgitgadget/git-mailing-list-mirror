Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F833DA7F9
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815679; cv=none; b=dZj7lWWRUn2CGxz2GLWtyS4sux+z3GzQUQEi/ruFpx5ynHIH/yvNheECIuj+QmyiAhdD9leYZvlD4khkXqJaDVdTNIXQvqWhBh0oJ6YUk16FcZlH7wiA/vEDFaPLasg8ejQjTSLOAwsqvebSMjWB+UKykctVKodFhmoMiqfhPf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815679; c=relaxed/simple;
	bh=DbRTzQp2xYXAkemMGJOUV5Ab7X/Re508sggaKBikSWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FK9nQO0XC42c4t7A7dgtuTVb89blE6ICD1NG8nc0SpcS1yeLg+CRwSLVd7qRslznR+JmjzFYNidCX2cEEX3gu5KNyajxt6O6qmR5KRMhmOuAZvB4LetOvLs9wp3CskQybmcsBnlYj6dyQYeZaz08n4XwZ1X0z0bv2M7bPMmCm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fGiUgsVb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BtQmnTS8; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fGiUgsVb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BtQmnTS8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 65D1FEC0866
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 10:34:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 12 Oct 2026 10:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791815676; x=1791902076; bh=wMsLElEY/Q
	IKQC7OD5aFg/4UNOwb1k1xMtgS6IyCPLU=; b=fGiUgsVbNFXPgheZnF9Va48ZXI
	t5/qqMn7GxqhnD2zeKxyIRuzemNDTa85EDERfEaK/DNVBV2eylQn7O2rh5ucrQUv
	X4HmktwV6EaAlf//SVq/ztzsxx3hNL+w/dQRQomfjkkF4gA7/ACpUVVa06WM6XNO
	WNZx9gR+fpSympi6PXvXoaDzS4kbftBnP3wZu0B//ECD2QOxdfJunmxQaM4QP38/
	qy5JO4ETJTEFV/RHTX4WvrflPwgLTt/hlRuxYBtVxMYjAP8NZHCTlYN5tHxV02uw
	q0DFoRvrgHb7TOPqV4uWljCJQpgz6yPv+eZQ8GQXyinodE3sjIBKOqPoWnIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791815676; x=1791902076; bh=wMsLElEY/QIKQC7OD5aFg/4UNOwb1k1xMtg
	S6IyCPLU=; b=BtQmnTS8+4iNuDJHDKRehP7X3Xl5t44kxm7efGKbZJD0psY/SkJ
	maPUv8A2+GDenboCqcEGBxO56kDoQt2jZtVaxpR7o4S/hZouWoRFpEW3j43rUUKD
	w9CehlLpS8UgrpLZRMWRzlyuJySaRL6mDm5I6F33ttI3tG7EQbuJhVHcGJXX/bF2
	6Q7t+/3St7AafznvXPli90NIz0bt4AZCSMkOJUsQHAai1XIkVPlUJkdvhmnUNczE
	yUPPAdiz3owElIpfvBDaPjzNEUk816CqQIYPHYRCqu61gNh4ejqZIt5NMNzZN/E7
	YxryUubO+mVrk+juKnuMvq54DR3kZnx1PkA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791815676; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LTCudMf8oFZ9p7OxZRGF4MOkgtKmLY/AP05HZVv+b9XGhvK
	TpzMYytOLM5eNjo6LvBkI/0G3AxmX8oXPBpELFSXpR3Ce+sqgaMvdUGkBsdb+Hbc
	tXlTadTFG6voEB6c0p3e4BrNq7j6FyyIgd7OgMwWHkUPIau+DL2iyo8i0/CIV3rb
	pvDLwSDPfa9nhf0D3aIncUNBfEvgC1uar3olqAvenLII+BupytwfPoFAmPSFIkS5
	oov4jJHKh5Uv1Cpq3/Oxj0LvrqvYbEf1GxGjwTP07XuD8vYb8rAhrXKUEZ/VHNVP
	swRSlsDE4pHk3fM9FhxfF+xTW3fp+wOcDwZ4tcQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:IaE69xkTDu04WjoZ0qB8t0C2IQGTMK9W1qhT9jfVawk=:DbRTzQp2xYXAkemMGJOUV5Ab7X/Re508sggaKBikSWI=;
X-ME-Sender: <xms:_O_MaoxFR_e-7JimJqMvidqwJR34xEZDVuIBbYViQ_XHB--bbJtkjA>
    <xme:_O_MajJLEfICmYpSl_ifA8e5bFhYyAlsdUaoG3lJPCHzWoeKMnE9KuG2CEEvP_y4U
    8KmUeZbb9nsZr4c1rNP1xd94Sn2NKRKZo0VfgoiUHEUp7TPLLlanA>
X-ME-Received: <xmr:_O_MaiqDFuxujFdJf37bWu_Rq7C3lXr1scOFZTMpUO9ngeUPtVoe_lzn5SMSU3f-sQITPwHmbAakm8hpEyZnxh4WPZmQFT-Df9uP>
X-ME-Proxy-Cause: dmFkZTFSHdIBZGDxnd8CVX0L33H5I6ZN23vQCWCc6OIbd4XlyDJ0dao/mL+1E6FjF+Gau2
    voI/TG3mBmFa4fW2btgczfkmb+FZREYd0lkHFDZ1m6UUg2aY9GjunwJX9pYW6fMyIHAAd1
    dhDSoL3R1tYzXRfPyWcJz9oymVY5EelHy8dbti/DFk5ZmwZkKf6kaVvO7cYLXEp4pmdl0z
    Vh02KRMly11TVXqj8AcxcIUwPgX1CYjY1O/SD4x8eAk+E+Pgbm5oUyJihHIHPFNVO//cTq
    v1+NnjMM+7ZHVzVPcspPOAc33VieUxJqAUmBDf60FF5JSfV+96nFjYVT/QUlujPf2hWOCs
    5U3OEzOAqSeA9igVu0lSDxrA1W4WWMCkwBou24ZpN9XUmDE4b7W2FGMCTyy1AkRNZZicVX
    kk2OxUUESVW1oTn6D8Zic9mlx2kANhq0+W9FB6gTzR9xB4mNtsko6b3uTbc2FnFS/SVkLv
    d6tAfozFe5MzVqNTZf3K71fx0en7gywmkNVVtj1SROB3AGPllT+inBd4j9ZaP6Z8s8gTOJ
    ryPuqDYnlVGlea2p04q3xZ+2teY6fnytO3AnX5JmYFCCx/W7uzU4HImcoDudcVxXd0Zlbj
    JCyMQaS0chEwPmq7kGWxWnc8dUJcu3tVxd2JQPXOcmQaUp7k9i4VN1y9Igrw
X-ME-Proxy: <xmx:_O_MaiK_xpsgOuiwnKYivsf5aa3Ix5i37yhYP24snKF0ahu9Z5Zifg>
    <xmx:_O_ManSqxcemf6Gk8NbsMfQRpeH7UzAx-xZ0-OEKt4ycGvV39_cnfA>
    <xmx:_O_MahslOmWMrX7vC9Bbp8Bcf483IkxUZZsq-x9roWyNTyo4j_a5mg>
    <xmx:_O_MaoZWNUwGt7PQKrs5bVgo6E28nrEfMOp7U3lL-oDVKALuMzAgkA>
    <xmx:_O_MagVd7j0V-yOZnkufcb6Hj74tq8u8hOxRjQ6XDfJs2Frbse7K_GYW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 10:34:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jon Simons <jon@jonsimons.org>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] SubmittingPatches: avoid add-failing-test-then-fix
 anti-pattern
In-Reply-To: <20261012030029.12200-1-jon@jonsimons.org> (Jon Simons's message
	of "Sun, 11 Oct 2026 23:00:29 -0400")
References: <20261011153206.72386-1-jon@jonsimons.org>
	<20261012030029.12200-1-jon@jonsimons.org>
Date: Mon, 12 Oct 2026 07:34:33 -0700
Message-ID: <xmqq4ierasxy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jon Simons <jon@jonsimons.org> writes:

> +A bugfix patch should include tests in test_expect_success() blocks that
> +demonstrate the breakage when the code change that implements the fix is
> +omitted.  Submit tests as `test_expect_success` in the same commit as
> +your code change that fixes the bug.  A separate commit that only changes
> +`test_expect_failure` to `test_expect_success` can leave the behavior
> +being tested out of the diff context, making the fix harder to review.
> +Reviewers who want to verify that your test reproduces the bug can
> +temporarily undo the code changes while keeping the test.
> +
>  Pushing to a fork of https://github.com/git/git will use their CI
>  integration to test your changes on Linux, Mac and Windows. See the
>  <<GHCI,GitHub CI>> section for details.

Doesn't the second sentence "Submit tests ..." merely repeat what
the first sentence already says without adding much value?  After
re-reading them three times, I think "the same commit" is the only
new point.  I would condense the first two sentences down to

    A bugfix patch should add, in the same commit, code change and
    test_expect_success() blocks that demonstrate the breakage when
    the fix is omitted.

or something, if I were writing this from scratch.

By the way, I consider that the SubmittingPatches document is
primarily about giving readers a set of rules they should follow,
and not about teaching the reasoning behind a rule to such a deep
level, unless the rule requires judgment on when or when not to
apply it.  We agreed we do not need "unless there is a strong reason
not to", which means there is no judgment needed, so I was not
expecting to see the latter half of the paragraph.

Having said all that, i will queue this version as-is because we are
quickly reaching the point of diminishing returns.  Thanks.
