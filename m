Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18B34389F
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791762271; cv=none; b=laSorjLFqXmXiYM+SrXL8IXzjaV8GENyEzQuSWpJPvSKNTeP/xkQgOKWGh38Qq4RN1JPZK0lJhSIkedwE0xU+iUGhpTRrCGCNm2MkTaKYqZJZGtNyCpURnTHuaQ7/oY1/pJwlAXDg5uVx7Ya2rP9w2svEvMQVUsI57zW+xXudgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791762271; c=relaxed/simple;
	bh=BdKLG3cFE25lpi/j/2Cs2NJNpitkW65vMhi2i1pvIro=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E+FRkMdnL6KJFYcdwsPL6EUKN1/8b2An/FsK3TR/eIdaGheIxeSOev5K/Sf4/EIJcz8A6RgQ70nBa143lPVqrMVU5OicUvCCJbIjzNLgM8kU79U1OBe14Hq1SnLr+Kq7Oa5ut8b4ida9ynvevNNnlPUEhl3UNnBXeb5bWDUf8XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jSIlKqJL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZIvz3Zfs; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jSIlKqJL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZIvz3Zfs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C9575EC021A
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 19:44:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 11 Oct 2026 19:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791762268; x=1791848668; bh=16ayRRX/Lm
	XfbLACMLPM4YKlHEwc5TBSXykyPI20tTc=; b=jSIlKqJLrSscbVmxUZJJ8siwMN
	LmjVGEx85VvY0xW+jGwXZ9qYf/yyAIMyljoyIsXzUFK3BfupN7fhajT7NOJ9mps8
	y62fBxoakNe/b5VChvtc7tMbb68DQRPhkQurFFNbZBr2qEA006Z/aIzW6rHlnKRE
	mC3lflT9kcrLTzllDU2HQK+nSVLnPlcSVvREgxXt7iW/+5hZzR/Cji3rx5Aarb6J
	x8tDyr0r/p7HnKwiHOESM4Xww0QbuRahvK3pH5C9YIBKKNfZCWz6Ia8TOpBW1EsX
	zeIqhGEKRLHZdKkATPlFs1KnsGssAoCgt5w/BFkJ1H99WULGKTHUMk06vFDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791762268; x=1791848668; bh=16ayRRX/LmXfbLACMLPM4YKlHEwc5TBSXyk
	yPI20tTc=; b=ZIvz3ZfsLs6Pr+1RLXnikuZziGXzDHzOE9obuBMtAi8QLbwerj4
	HhzV4q+sbt+IlHQ3nIQECMUZj8L9GLHZ6LFTCOkJUeFng+y80V5jBxD59YkavCm+
	Sj6UnFSP6qeFsOaVTnbqGIYsUb/zvMjjdS69Bgjy1955Tdh5sc/GS9amBBqaMlKD
	bQlSKmT1bPwi/OqTrgwM4JXkElOgk6AYCvjZlnQluu+UGP9JEJFmqc+EIuReMLc+
	MtEu+j4O6HEySVLnjeiGm4mV28E2D5sRxD08yxNQMUzGRh8MkBzPECAddzrpc+0y
	vA1AMgggmb7HHRBDDmBed+xeU0FBB6gnxfw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791762268; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:OvQveiEFSbDl4QUhYoT7nqallDF28em1Ld+BasAbk0o7DDX
	dVzQz0+T/3TRIXxn/ULxNcb5r1w+6B5oj4Qmx1sudgdQ8RvFHD+POIpWAjc92r0b
	23D2zxwGchMILIIrz/vOT9tKyqK4bE1iMGNV7ux4sREJEZ0bdUsQLcoEq52R+GAd
	oMe4mM5jsmUbfXr1J5udIY91wrp/TisYTcOUQUqq2rOqe6EE5og91Eisw3qXLj57
	bQIZFkrr6jbl/hKqbiUk+rSNTSAKbUglkRNU58YkIOH2Ez8tV6VYfx8Y4BCFbw3c
	q1RG0Z605nyz7DJOJ3dT3gHo4frHeRqXLwAzLAQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:gb9Qsl9Btwt7OUoxFtt4tvtvVg8Rw2fT+hQac+wHDlw=:BdKLG3cFE25lpi/j/2Cs2NJNpitkW65vMhi2i1pvIro=;
X-ME-Sender: <xms:XB_MatZqsqea1kafEzi6HidLKFPoMswVjSOv92Esz0A8SGW0UAJcSQ>
    <xme:XB_MarSnaN9Igc5Fg_gXrtvNi7mQ9JXDqYqF0R2twXfqiDeeXlx9BslQYpJF8Gbho
    dB5xQLjKsqNcKLsx39OXCy7IGRf1wHpZnZBZJhwZdXd3FHemyy1Q4Y>
X-ME-Received: <xmr:XB_MaoSyPXuoOOgOxXpxMa2d5lRAosevaYdRE3v0iARsdvTIGKs0vwFBIg7S-IhRskXD7GtyKt1uK1EpeJuNeeKzPulhjrkK3Cst>
X-ME-Proxy-Cause: dmFkZTEzmjCS3+oReSK4Jwug+ruKcYc4Wo39IGwLG3KIIVTt2HLykMxuaXEmBTe7JZqWft
    q327S/DLh7K2Wzkj70FkHI9NRLEP3tfRlC0EKEYdHFnIrX7av6F4mnLMFOf8MG9Oo/LNAk
    oJqNWkCSPjXmkEDuK32BzaHE2Ufs/hcDdFKzMrT/S+5RqsW2KIPrh0qVvZcrogKgKeyy1+
    3+A5px2GjMS5QaUjDiQYq4I8M235VsNlVTn4wlIiL5gSo/1USavE0x7s28/BPWeqDGnoAA
    WISBxuoz8+TVr7Ub/4/IK7U+veiQZN8kb9LbAe1KdadSdKQ/htGbvp3G4eORUH/mrYTIQs
    BfT0VOFLx0RXTYSibDtPvJz3fbrxZ8Nqr0vnlaK4nFAIxcWzHIz+hAf1sV/M9CUDN4gjy1
    bYK5GqRc4uVKTX4lwUA+g6fvD7wZ/3n3i/MOSHFSTEK0WDk3Znoljuo0YH9eg6XvTkoiV8
    bWKS5yAPpZ8Mcsf6HeSpk+vdvaJW0uqKey4bK+A1uVYRC9S4fEhKOirsLjv9L57DEp+8uD
    4KsUkp9xpVuGk45cPEJWXqdN/f1oBeGiTf6IU0BHCFPdxW9DV4W3oh5sGoQvF2s3tbxy6Q
    FgpO6GFwMx5AN/F4R2et/V65SGzcoXBK1uajsj6P7W78KtRgh2Z1M5OxtgmA
X-ME-Proxy: <xmx:XB_ManTE-HZLGZ7Jimk7is6whyjaIdy-GMvLagsGsfdTF-2j84FkQw>
    <xmx:XB_Mal6acRAHUzRL9cmFXYrOmAHqrfjcc6SSv9a83jbDfC4fhxqckA>
    <xmx:XB_Mar2Hs-dxThmYMvrQBtYTJrtO4rhpEg5nGB2FM8vYK-SAayN9lQ>
    <xmx:XB_MaoDh2VFwgdNQFmESwaB24AeknKe6sFkyUjEhO5LWLHy1fO9flA>
    <xmx:XB_MardCPvnv8SoXSyTTn_m75k4zW8lfgOHk_vr1Sh7yGXsdE9zSdBZ_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Oct 2026 19:44:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jon Simons <jon@jonsimons.org>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] SubmittingPatches: avoid add-failing-test-then-fix
 anti-pattern
In-Reply-To: <20261011153206.72386-1-jon@jonsimons.org> (Jon Simons's message
	of "Sun, 11 Oct 2026 11:32:06 -0400")
References: <20261011153206.72386-1-jon@jonsimons.org>
Date: Sun, 11 Oct 2026 16:44:26 -0700
Message-ID: <xmqq5wz7dcpx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jon Simons <jon@jonsimons.org> writes:

> +When fixing a bug, you may find it useful to first write a test using
> +`test_expect_failure` to confirm that the test exposes the bug.
> +However, unless there is a strong reason not to, submit the test as
> +`test_expect_success` in the same commit as your code change that
> +fixes the bug.  A separate commit that only changes `test_expect_failure`
> +to `test_expect_success` can leave the behavior being tested out of the
> +diff context, making the fix harder to review.  Reviewers who want to
> +verify that your test reproduces the bug can temporarily undo the code
> +changes while keeping the test.

This indeed matches what contributors have been told to do.

But do we even need to say the first two and a half lines?  One
might find it convenient not to write any tests, or to be satisfied
with manual testing, or to send test_expect_failure() separately
and early.  None of these is what we recommend.

As you described, adding a test_expect_failure() test with a large
body alone in one patch, and fixing the code in another patch would
show a change from test_expect_failure() to test_expect_success()
without showing much of the body of the test in the second patch,
making the review unnecessarily cumbersome.  If the test is trivial
and small, it may fit within the diff context and avoid such a
problem, but then there is no need to add such a small test as a
failing one in a separate patch in the first place, unless the goal
is to inflate the commit count.

So, unless we can think of concrete cases that qualify as a
"strong reason", I do not think we want to write everything before
and up to "a strong reason not to" in your text.

How about a short and sweet sentence like this instead?

    A bugfix patch should include tests in test_expect_success()
    blocks that demonstrate the breakage when the code change that
    implements the fix is omitted.

