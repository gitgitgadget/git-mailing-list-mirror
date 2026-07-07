Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BF242E8EC
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440909; cv=none; b=euSrYABMGJSYRVe0t/yMxMDnm4uffFkrVJXOIvi9JJ1jmZL4935vH3zC9lKScdog6Y1KWWYRaiiAtbfWHzmRBTUyTxzJ5WOOJbHE8HNzGcyb60zYrv984H8FO9ZeNqQWIjyaOe7D25QcV8lUaHVmq6UXQ5g6Q8J+eYRaTr1+GvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440909; c=relaxed/simple;
	bh=sJy5XWmJY5CvBNNaozESTJv7pyAiw2MuNSvhEcFoDlQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nKOPXGWlnnHsDI+FzLXr+0T80TTb25DhB1bqJBDFz73SDu9cvF8K3VbJCtsjQUJ/A41jDZpHwhwFzpw9oCfG8Mr9bLOM6yOWCS+r70qrSTHLRZFwFk4m85vOW6s/d+2Zla/4jZbCRJ6UulNikwr+X4kYTknukMaUeNlhRI1GHfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e1XjZ0GR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kCfYqWoj; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e1XjZ0GR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kCfYqWoj"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C2F9E7A0145;
	Tue,  7 Jul 2026 12:15:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 07 Jul 2026 12:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783440906; x=1783527306; bh=I+VmpqZXoR
	BYuJGoxLghSBN5Ob8HyNV51X1e0UGWy1Y=; b=e1XjZ0GRxNDqrgXHmNaU5zdnGi
	d3ngmPKEAz1H6DTZ2loL4z7/4BPXPQXwoTNTChaMNNMNVdOBZfDkqaitDZytTqfE
	TWS8/kWBld2EAGlOV+WfKKXdRbD4OVUz0zIbKEjkqXg67Gu/64UUTxjpHljYl0P1
	VS/a5IK9aEOS9J9ItLjs6H8QVy9D68yt0F9PtDDD6b1SHQyclu4yLd+qkU5KjPeC
	z8FN2hJwBHBCcqedPenE6l8bZsonNwqoXmWPheT9JU+wh3HZifu51+XfWjO/TbIl
	qh8B/GdSKCbZUO1pDuTSn+KQI4ndVO8GGHvwkoTYDVWmiBkOY1gY9GrK0TQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783440906; x=1783527306; bh=I+VmpqZXoRBYuJGoxLghSBN5Ob8HyNV51X1
	e0UGWy1Y=; b=kCfYqWojgJgZzmekkFQHtIqV8QL8SskoHOcK20G1N8QGzCC3UWO
	wfiZ5LyGKo7ODvtRvOO3DnmOd6rEDYiuFEu2wlsgZm9F0AwxieDR++yXNtqDLpDu
	9Z1HuQsO7l+X6iWzDSiLhPM7hFMZjTQ6aJP5Kl3OZjL6033RQOvDfxGbkty83V6h
	GtsDST30xPBl7UGITU369o1uZYtG/vaJ91q9VPJaVzDeSe40vVwoxntFS7oc+QuM
	fpxlrGcCj+JgBftX4iBllj3JOXx1RfJC64LdqlVf/KFDfCTsheGO64KYXMUt0Zbn
	8MgcFLycO4xlHdGS3JhCtvnRBvB6kW1w1zQ==
X-ME-Sender: <xms:CiZNapKI3GCW2CAjFgq_jGAniLIwnp3TwK62QHdlwcia-iXODuA1Lw>
    <xme:CiZNasA4Xv5dIrbNvKGQkNKu2jxp1noS4dOKT1Dw4w26jg_gD7EQX-WCi-wdN1Rmu
    XLMVpvtcO1rHZ2zjet3GcFPPF-ZL7ppesUIWUOyQdu88Knqy8eW>
X-ME-Received: <xmr:CiZNaqA8LWmRiqV2HgN0YrQwAeJmLLMs-UHdNOeT9VUGN_OkhqQN2Xelp6eutC7JDACI1wFinrCW1_cLal1ee7HN4V0vKz0j1-m4Wg0>
X-ME-Proxy-Cause: dmFkZTFhPhUDJEIeClL1bRJnlQlJzAoCONWjHY8y+qpLJj0z2qCK1MT3DMPxdDUHobA9tC
    f2MDyJhlrp0Y8k1PHl6fU/fAjLTobSvM7GUJ9vK7wpkgFg6SxYqo4C7A3jYi27zwx1htBk
    2HjBdNgoqSvW06LqFRczlBkxDCy4FkVxYGq9exinx2oox/NQ7QHQly7z8zrFTV0r9Fb3pN
    ft5sk/P7JGxom9vyXy3Ae1JPlHWg3/rQq3r6zNfa+VEWeb4UJtyFUjwfj/4A7i7w1V/D/4
    zwUz90WCjkDs5W1pZzUgWBMHpkgu+MgvYwGW22G4OuCNWuyOVcjfPEu+V+ImFLJwWTuAY5
    l82/178DI7Oid5FO7nPzp9Dr4B1Icjpb6eALXTcIj9mmVoqcF6rpg/0enkmCOXZ79GMYCW
    jopD1dbbKIiWYAF6A4CMYuOykYpBv3/wNankp8xRsL6Lws+p3dJGI++QnmbZ84LaqTapRY
    xC8G4WAiAtOtOV/zpLFf2lSYH2rRmGOWgjK0cvKlNcEp+79Ec5eo9nwfm/sh9ceOGQdcIB
    Q2TyWxLwxUqz56OfChls9U8vK0J1ZD6M2CrJHE3FX5vGZYr3+yqA2QIgSZ4Ynns1/sgl7A
    jenUqCP6At3cgETDCHQQ79FRjEdzTjq6vqpaWFIzK9erLITsK3yt5/S7J3Vg
X-ME-Proxy: <xmx:CiZNamC625WtJ0R4Nvszgl7kAaVnonaj9qAVLTwf8tK66EemdEf9ow>
    <xmx:CiZNatpXln38lsxzIAHgOo7NTCqteYKpt5cms70J7OUzIDcDMJZS5g>
    <xmx:CiZNaomd5ZiUcZKRgs-4v-Aw9C56uRXROJSckG2VDDfm_6x7VlmquQ>
    <xmx:CiZNalxx0sNt57o7sSqhjctA58yoLmJrUyBm-hIBjtUASOERm5LK9w>
    <xmx:CiZNasy-BCZr5ZudtlNsB-3QpICUfuHQcIqjR51e8KxWCYvdrRFfZpUw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 12:15:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/7] hash: convert remaining direct function calls
In-Reply-To: <20260707050417.GB1288294@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jul 2026 01:04:17 -0400")
References: <20260707045556.GA1288172@coredump.intra.peff.net>
	<20260707050417.GB1288294@coredump.intra.peff.net>
Date: Tue, 07 Jul 2026 09:15:03 -0700
Message-ID: <xmqq1pde93p4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> The previous patch added a coccinelle rule to make sure callers always
> use git_hash_init() rather than direct function pointers from the algo
> struct.
>
> Let's do the same for the rest of the git_hash_*() wrappers. I split
> these out because they're a bit different: they implicitly use the algop
> pointer in the git_hash_ctx. So when we convert:
>
>   -algo->update_fn(&ctx, buf, len);
>   +git_hash_update(&ctx, buf, len);
>
> we drop the reference to algo entirely! But this is always going to be
> the right thing. If "algo" does not match what is in ctx.algop, then
> we'd already be invoking undefined behavior.
>
> So in addition to making it possible to add more logic to the
> git_hash_*() functions, we're avoiding the need to pass around the extra
> algo pointer and make sure that it matches what's in "ctx".
>
> The rest of the patch is the mechanical application of that coccinelle
> patch, plus a minor cleanup in test-synthesize.c to drop a now-unused
> function parameter (since we don't have to pass around the algo
> separately anymore).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/submodule--helper.c |  8 +++---
>  t/helper/test-synthesize.c  | 29 ++++++++++----------
>  tools/coccinelle/hash.cocci | 53 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+), 19 deletions(-)

Looks very straight-forward.
