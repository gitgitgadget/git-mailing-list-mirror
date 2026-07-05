Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F951DB356
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783284763; cv=none; b=tcd7wC8PIQF1dRtfaumZ2/LuP8yJCIZEQe9B6lR2Rxpg0v0qGh/Td4NEq5Sd9XXhV9R5+jA7xozTmuVALmB+GWFVLh7VQIK2qNG2vq0X5oAJTHj7JaJAi4YzbBsJqJKPczww2pC7x5mUDO7gfEJuNQ8y9plPDsT5ovqQPKeTTZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783284763; c=relaxed/simple;
	bh=z8WEFND1/X6zcM8B7xaeeV1QWcPq1eDfISdnPqYDcDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uXPMLg/aXd5AIjM/qWxNwxcvQwFmFYZrN2sYsFe5CX2iPlYNEsmyC/plytViUcOFjqTYQGvQX4Rh0R8BNKDzVQVbJdmvCbHuk2INFKfo37N6Dtwd0M6bBJwMscxStcz8MqpwSa/fcpWEZK8am0ifVcMfrOTIf+bAzQcQkVYxSVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gwDME6rk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OuNIFtfj; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gwDME6rk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OuNIFtfj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id F2978EC008E;
	Sun,  5 Jul 2026 16:52:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 05 Jul 2026 16:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783284760; x=1783371160; bh=86D/xh8+pG
	XgCwFQhZDmGpJeM3sbqADxj9gBb6wrhvk=; b=gwDME6rkmrmzZigKAt1ninY6N9
	xHtCO/oPRUzl++sU9WNGMiBUXXJtD/IZmPhk48ba7VipoSON+QaB6tS0QwEvx4VJ
	OJCRZvUFzpHGQMQk4KoA4yot98fZMEmDQ+a8Fd6Tr/o9apL2z+uy+QlJ8KE1GF8Z
	sOZiPUZ31mFPk4pXBf7XYCxvfK56jKkJMJuCstM7qXahkRve3SqI6TKmFpihJBy/
	MysUr/5pyr9g3GvvpFPpsmwcdgnpU7C2md4M37f/FX5V3zvCXK6SAN4ESP8aa5au
	RaWQcG9N0Q/t8o72FvvWsn0Xb5bPiCDWUY0vsaZ31PcG4R3Jm/yyFck5JzYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783284760; x=1783371160; bh=86D/xh8+pGXgCwFQhZDmGpJeM3sbqADxj9g
	Bb6wrhvk=; b=OuNIFtfjB47UeUrbwr13BN3MRTa/d+zBVkeZt1nR9Du0ak/OlgG
	4E4nAIcgET/jwJzEXoiwJnqFAqjnVVJdpUGqV3jUZqcwGk7CnLP5IXYObf4dH2cX
	Kl3pbrUUPVSUO63PU4q8fU0rHd9QYXkW6Q8VmNf06eDWelwGut724fiQzHnF+LDZ
	U7951mo29KYf1Ct6Nf4ak0szNrKmEpH+wbR9j7kjGHfaVs0kmlf4rRKbhFyhHQ5X
	hm3YL7KdPAkb2OxLM0g7LeEzTUeiCT09Df80y5Mu0/i423IGHYdGiDeY2J1VBnE5
	x3qgIOArPpNeT8FTfY/b5TAP8DCymj5HJcA==
X-ME-Sender: <xms:GMRKaoGUunZTSFauUD0mQrHj2OxE3gm4yLiCrcFZFtNxpcsQHMudxg>
    <xme:GMRKaiCPeIIpJ-ed2GsaFbOY_yE-wFE-ZDomkMmbztPmQjVUVt71r21x1Ru24vS1L
    wKmD_oVJUay1Wn8MC4L1JRP3xUOUnxfSYQSfVF51zJlJ1XrqAODmjU>
X-ME-Received: <xmr:GMRKagWFINeuKl6h1Ge3R7Sq-_0nQfHRu2F7b_C5Nsg104oyacvRg3L5yXod7nuoY-QWl55rznPwYg0cwTg3ACJGmmXH4pl2ifomHgc>
X-ME-Proxy-Cause: dmFkZTEfKZnGtSdmLaP3y6oiiXqr4nJl15OSwkkirQgFKjf/8N9GAQaB+ENB+2ypt6GTB0
    Nstp2VlfOW3XrEiGqKujpu2GnYcjRkycyyYwuHeYqDV63dC7o5sHqsJtYZye2JnrOsnldW
    gHeQoG01GtuoRhlOjUJ3TnTw1o0Qbe+fj0TAmvP970F1AYau4uX4dwHQYkUrS9w+51Z1Uv
    F41GNZjNE+YrHD9EPLVtrjVKotq1rooI1skQ/w/JmEunpOQTA1OGICKGsjUK8RI/NSsCK6
    s/FTk8LyBTL3Y7W3dp6Trb/zWSyRSHKw+Wf7BBLFBfSJB6zacLNgiN3eifY2LVg0eyJ9bi
    lWJ1Y0lPd7ctiesTf40rj0G9ycAkrC4v+2P0F66xNrVaeEWY3gmgpCD2TpdcjtmmihLFAj
    wW2XNeFrRdzmjtZn8DOyjFXK9eN4vEB+y9lHCZD4Uo6Yf2MF5tDCgGsvK2V0o9Fz9Zb5nQ
    tcjYeWn9bVkVet4GFub8zIOt2hE9RHo05kp95+5f+LlRwH6uRMrNF53E4pbfqyW7Vvo6O0
    +MJTKpqOuzDNW5EFLFe9yijZKdFa+IhWV+U64KxBijzvtBFakU7ztltB4bBTFHhsygU49/
    Pvxp81/19gHMoB5DbXw6Pwby+eDBujeZ6kOWQqH87nWvK2btIB76r2ET9+Xw
X-ME-Proxy: <xmx:GMRKauqARBnvA6nVau47dYjWQlhVVrgpuaijPq403XuVOSS5wzlB_w>
    <xmx:GMRKakR7j4VBR9SLVd1y3t_fTSqYOz7Fvy1aEjSuAImtBB7tZQ2SFQ>
    <xmx:GMRKag2P7-9RVboQzA9UNZu1UK8elAtS-R3dkWBg9rYn5GmHJHAd9w>
    <xmx:GMRKaoBUDh0WZqWLD1RnwW74CZ5ihDCkhepMGqfMp2v1kzGuUpDTsg>
    <xmx:GMRKatDDigSkh705BnDD9o715Z0LGjUPdcePafkI-UAsq1ZWw4KY9DKv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 16:52:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Trevor Gross <tg@trevorgross.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Stefan Haller
 <lists@haller-berlin.de>,  Derrick Stolee <stolee@gmail.com>,  Phillip
 Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] rebase -i: introduce `pick -x` to add "cherry picked
 from commit ..."
In-Reply-To: <20260705140931.98262-2-tg@trevorgross.com> (Trevor Gross's
	message of "Sun, 5 Jul 2026 14:09:06 +0000")
References: <20260705140931.98262-2-tg@trevorgross.com>
Date: Sun, 05 Jul 2026 13:52:38 -0700
Message-ID: <xmqqechhcg6h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

There is another thing.

> Using `exec git cherry-pick ... -x` does work, ...

Does it really work?  I seem to recall there is a reason why "pick"
insn in the rebase todo list and "exec git cherry-pick" would not
work identically and the distinction is rather deliberate.

Rebase copies the notes attached to the original commits to the
corresponding rewritten commits.  This is because rebase is a way to
_move_ an existing (and hopefully not yet published) history on top
of some other base, with the full intention to destroy, abandon,
remove, and forget about the original history, and nobody will see
the original commits after the rebase is finished.  Copying notes,
therefore, is a sensible way to preserve the data, as these new
commits fully _replace_ the old ones.

On the other hand, cherry-pick is about _duplicating_ a parallel
history in a new context that is separate from the original, while
preserving the original history.  Since the expectation is that the
original history will be kept (and not rewritten---otherwise the
"cherry picked from ..." comment will totally be useless), and the
new commits are being created to live in their own new _context_,
notes are not carried over.

As can be seen in the mental model above, "rebase" by its nature
is what you do with the intention not to keep the original. From
that point of view, "pick -x" is a poor fit in the context, because
for the result from "cherry-pick -x" to be any useful, the original
commit you made the picked commit out of MUST be known to those who
learn the fact that this new commit was cherry-picked from that
other commit.  It goes directly opposite to what "rebase" does, in
that the point of rebase is to destroy "that other commit" and make
sure nobody will see it after rebase is done.

So...
