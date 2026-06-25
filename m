Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0435A331222
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782418632; cv=none; b=NUJtfsIcGYD3yJ2GuJyBT5Uf4UXdD0k6bSM7ONlIof8FFbrDz85Rnoz6gEJvwyUpdGqdKYbJw6syNLpgmAH6+BB0axH1OEq2ulDLMIezeQlXmltN/61X/TObmasF4ZKVkIeIkPWAamqrwBKXXdGfiFYYnin1fDUp7aEYfDZSMwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782418632; c=relaxed/simple;
	bh=jt7jyAo7k0OULzq72qktPQTTDknTl0rKIJcbByHbZV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UZatxg9hpH+uLW0RTEjpz0+5tbTdmzdGhEWqoROSkMXHhkBtD7xrG9g2nq+UPIfsEk4Q+CeXcJysxEkbFSQUfCIYCFie0FghZkaqGWBpzL4ZLibwT2svl3xxtcDtbPAIuJeSVUDSXGfTLTtxnx59s7E0YSQ0czvU4LCb1+09odA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LtrRQxcv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C0N+vyPO; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LtrRQxcv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C0N+vyPO"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 698B3EC031D;
	Thu, 25 Jun 2026 16:17:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 25 Jun 2026 16:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782418630; x=1782505030; bh=CaldlUaxgI
	l1hpzZdRwLG2v3HeMD/D0nE0m8wIZK71g=; b=LtrRQxcvmhCvs1LeIcp9wX99Yb
	IGer8oEbOhv9/BxjgFoavNwdvkODg2pdyu3ShsEbDGtnOptcfVLwIt2oAiUWPP8L
	3Eizzw5kZ+0lh5wxQ19hQD1qjanSZ7RqEXyS4TTJ8II2iArHrwO3V5Szj1GExBkL
	0cC/j0HA3pr57U020hM9VbiqXiHAmgI/QYBODAdCt6ObFf4vw7w97Yud52T8GZ8E
	oldQzm8VnNKJSFg8hAQCjp3WU69X0R3sapP3ZgbX8xNjoFMcox1uDcXIx/x5Rtmm
	HL/NU+f8scK4RKDbY8r8ZDWtNSnfBrVARHyCRiUH6Is/wZnqyz8J23VZk+3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782418630; x=1782505030; bh=CaldlUaxgIl1hpzZdRwLG2v3HeMD/D0nE0m
	8wIZK71g=; b=C0N+vyPOWZN0mDFiLnGnitZ+qjoLrXfaXViyMLAgpe8ykwDMwa+
	OjoQCT2X7uraQbcHZmYM6FFgn7uYWG0+waHXZ3A2yEhqmvJoqfNdyWY5RjM7EXFf
	MvO1uBF9hKYsNSfJFs2CEaUnvPAEJCG+c6KpjTflRDfrujT7ohe7azZvUcw7oKCw
	uh66LIqciKmCvfzH5wHVDQouSt2tK6RNFABpaejjkpLMXxT+PKjHvjxkLvk52E/G
	Gx807c57G0svZw+GyEWkdFk93Nfat2zuNEeK1anTRcjlfVDgg0rWuk4j9X/B3rp7
	gVAoB9x/gEimRopaQ6KbbhQxjz51EhYRKrQ==
X-ME-Sender: <xms:xow9anpgVz4C74M2a9c5u8icVqofJkZ12pHxSWadxAKuBDGely_8jQ>
    <xme:xow9alXxyr8o-JcBx1ndmwWSfRuGT_4rslsRBv0ScE1EuDRT6bc27kDppmjQzhE1q
    jeniGf-O1njjak4c9Wka43nzdUEzznNslDpc5WNavRD0ertK9Ef>
X-ME-Received: <xmr:xow9auB5WnfeuCGxF_5mTgM6S0of6CSlLlxdlST-wnP4XBWsLykq-bCFxNp7qH1pGsfXP12PJs5ZJDifvOSA1QvOfN13__jKXk5BLwE>
X-ME-Proxy-Cause: dmFkZTEGvMThyfWClaoLLq/Pz77s8AH+4jWUWPLsCGywNEDbZF5tBT6P4L7phYh/kpA1ZH
    YUjgxHAOFxFcwU0Oo7AoreYhS5w3iTAc+xYyfSF9IixJVW9L8RHbCTZDUTtuqqZPXIud9E
    Bc457gt80DfU2Uc2MNxbsHKDvSIiiWqMonfhtr6UHStJxB+30mv0ujmCoTuJ51JOPVEh1S
    6PMLPutUe2tIgdvr7El6+aj0JWAZHifrptd6l2PWVA8FDr3CbhZ4KMdH9HnKIRvWJgNPtj
    ouxWQjJnDa3vMB9p19lDnAxVDi1GRny8yR3xRDH7481yJifc9zDMu1E4z4l1Whq3vUugnQ
    ZH1AjLIoHouci8ujlmPyHHrd1riRTYQGlBu2+chRLfErF9N7brSi0KnARaVLeR7HZWnq41
    NIDZOJW4nket4MRyKQ4i45HQF7upqAofn+6+e/qAjTRDvmM1/LrpkfiBeueCD7QUkkzeDP
    xYwxE6za2nquThRqbFd1CIFo/GuIcdjExs3QJWaLmf4x1PWab08sP9xrpD6gpETom9oON2
    dt9L4xUKmkuCZCHYThj40LayQT59n0KevyP3CJW8goW91vM3+hG615BmyQ7CgFYya3yiyg
    vmU4h9xyhxxxmoTgimj2VBbyrKUepkX7Pz75Voi9i26euSODs4eaUHC5zWuw
X-ME-Proxy: <xmx:xow9ah2Ucpm7fo89xkJ-aTCdsj2R9wYEIsKa5tnmojbXdAm5qOps1w>
    <xmx:xow9ao3tDF6TJdkrwIhbww9WcMkYVc3e58XhNQUv1T3opSo0RVi0yg>
    <xmx:xow9auDxGXyL1JwwRB9-OWJyol_j7JWKCBMbF46zZUBPnLzml3xXtg>
    <xmx:xow9av6y4244PNZDRTcl049qldMGQLWOjvluuuWzJq2nS5NdgZDv6Q>
    <xmx:xow9avMjheuyRvtKA8BUGTumPD4H-_p_b3g40zrcMbq7ycb556RXYmdw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 16:17:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,
  git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4216: fix no-op test that breaks TAP output
In-Reply-To: <20260625185112.jjH0K9LI@teonanacatl.net> (Todd Zullinger's
	message of "Thu, 25 Jun 2026 14:51:12 -0400")
References: <20260619-pks-t4216-drop-unused-prereq-v1-1-2ce0d7bea088@pks.im>
	<ajVMZpjTKiXc7TRe@nand.local> <xmqqa4sqlchz.fsf@gitster.g>
	<ajjBmi39IFJW5p5V@pks.im> <20260625185112.jjH0K9LI@teonanacatl.net>
Date: Thu, 25 Jun 2026 13:17:08 -0700
Message-ID: <xmqq8q82fk8r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> Patrick Steinhardt wrote:
>> On Fri, Jun 19, 2026 at 09:29:44AM -0700, Junio C Hamano wrote:
>>> Taylor Blau <me@ttaylorr.com> writes:
>>> 
>>>> Given this and the above, I would probably err on the side of
>>>> designating this as 'test_lazy_prereq' or otherwise silencing the output
>>>> of 'test_cmp' so that this does not taint the TAP output.
>>> 
>>> We can argue the merit and demerit with a good log message.  The
>>> central issue at hand is how precious 52a9 in the script lost by
>>> this patch is (in other words, are we checking more than "is our
>>> char signed or unsigned?").
>> 
>> Ultimately, I don't mind much which way we go. But if we want to retain
>> this, would you mind sending a rewritten v2, Taylor? I feel like you're
>> in a better position to argue why we should retain it.
>
> Is this something which can be merged before 2.55.0 final?
> It's certainly not a grave issue, but it is a new test
> failure for anyone who diligently runs the test suite on
> many (most?) non-x86 architectures.  It seems a shame to
> punish those folks. :)
>
> FWIW, Tested-by: Todd Zullinger <tmz@pobox.com>
>
> I tested the earlier test_lazy_prereq version as well.

Good that you pinged, as I forgot that we haven't seen Taylor for
some time.  Let's merge down Patrick's one you have already tested
while leaving it as an option to resurrect the "52a9 is still
precious" tweak from Taylor perhaps after the release.

Thanks.
