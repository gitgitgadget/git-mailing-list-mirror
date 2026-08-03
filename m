Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F140D421251
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781441; cv=none; b=jn7WddMeM4dpQgiBVMkFu63vZet2UblcNEv4rpD1lsPA5dACuf7uRnsaXd1dyAsusCvAJUNUap2bo+WfJ9zsHTocmVz26lBBrz6kxZQEeG4UvWs8pJB2+0+iZGrbdOSvci/ev5Ct5ZhUvh29RWEiVyNAH9NcoE5KBPeOw9EWT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781441; c=relaxed/simple;
	bh=EpX8X5gnHCNzVN784sibW53I3uItzrvBd+ZrI0oJAt0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WPl5U6h+cWw1naEqjes3J0gnZCoy/96oAtg4tdXe6pECvEaLvuv1H/FEhON38gnDLzx1WJLi/dPGnNn2WYm2KfLDdYEIeh4StV8i2gyMzTyqgRdQ5c63yVILwyjy2kFIjwITHA2BLRSIzJZMOpL1O48EVf0P6bmI/OxyWolEzk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=If2FT8P6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ljXko5kD; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="If2FT8P6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ljXko5kD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 101EE1400132;
	Mon,  3 Aug 2026 14:23:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 03 Aug 2026 14:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785781439; x=1785867839; bh=LSo2N8b2Oi
	7rHA5io1aWkM5EqrKTj59S+2kMU9Nu+bU=; b=If2FT8P6T60UWwFKh9Z36GvK5d
	UF6rCdYdqnJjnMy4CXoz025suIajqB+j/SJrTyD+NQO+Dz7YA2RaehJ3deDHGafb
	Fd8e84dQObBrWwyoFaSMOGCp4ASWyA/oYs3gX2ejtnZAticHjg2AyYG+JzU1ogtD
	Orom2/40ei54u/ult4d6EL1QXbUYfFFy01X6abPVqn37M/301PZ6NHbHp8ey1S5R
	akjo/rXYrGlM9LjKsRdTTwCIqX2f9h9jsO14RlVIfEwYFEhOvB6GGaNG2fS+5Av5
	GRGzyKcc0w6N8m0TYqpnDFWOE3ymc53wNquh6P3fSqLuUzx28mIgjGHVLcaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785781439; x=1785867839; bh=LSo2N8b2Oi7rHA5io1aWkM5EqrKTj59S+2k
	MU9Nu+bU=; b=ljXko5kDlZGIZaQRMBYncqZEzreZcGkE/Bu0u1Z8lRnABEbjXeB
	DXKfHjMm4dnegbmjGuZhV1hY46sxgatlr9cS2MMNDXeAuV7Vc+epPiExTAESib0G
	/rfsZGosVpTxe51d5hBLt70qIFTeGi2jvLhCR6hEEuh/4pIa4+vGTFSO8dkxUeyA
	RrtorFgUMk2ANXtefhqriSc4+MzmtEvW1m8k36nJS0HPQxj6VHGb03qGpcioi5DD
	BbkWGJTnn8B1Nt2LvwMMeaPM/k+BGnn8rVxRtEIcEsLmNXYnddztzvPjjpSo/TYj
	bPaXBxUmRYWfIpmnEFLbWDvALBbKTSQVutA==
X-ME-Sender: <xms:vtxwaj2S84BbvQ4nJCz4xp6wuUt2XjB3hEQ3nxIr6BfwqGA0tzVGVQ>
    <xme:vtxwalxTxWqLCpVvK6mkg4vQKCrq74r8Dg4ghuRQYCfIyPLFfsIw86lDNCwJZG86V
    4S7gsm-FaVJSmavvoXrzzHjJHl3cd-DCbVRK9ZnrkqY08M30dagSA>
X-ME-Received: <xmr:vtxwatuAfKjxifcu6O2eTHIHH_2jZwgM875cpBTLecQWYlV-K-gnwfVPzPNraF7pzAcNnV8QZPIWCWQBUWYP4B2RRHKWC_yyDw>
X-ME-Proxy-Cause: dmFkZTEM96j25qluJ8mqAsuNvJnEAlpIVU9PGfOXWv7w0PUoHTag8KnYY6qIy8p0qKhos9
    TM0glv5xZxf8hD+Wle6JEL5uelFzDArjpVfrs5+PbciHIS2BB6jJ73QSv6V+YVGwHTsHge
    f/dYITPkGS821prwA/fYVVdVsJ17CG/CKcvTfO8IEJh8v23YND+48e7tW2PPH7bnYxtfJ0
    90XT/Kohu2V2e2a9rykMyV42jXAbtR0uBQgElLQ6GwN69XHBdQU5NwfMxhpEhpqb4dJSKY
    vEaNzHxmd5fYMteeXhCv2DulVXFiCV6lM3Wc7NCl1PIO7QFRs42N95EvwIPlN/oiaLhNGM
    YAz4rso4lzCcBfdeP3ZSCohSNi8j6ywkqzcEzAPTD/GqQI/98Q+ncilLCkPW85/qYL6IWv
    9gFyXV5P8uyvDa/3bIvTQhGfHbcM7tS8/yd0nSjzpBARFNHJDTPF+2n/TztvA9KpIER0VB
    VmTPu24NEhC3ap+JaKnZymgvfSLktKN+t197y7n0kpbsvZ3QUEzlkDo75l/QZSPAhJdJ5i
    VemREaqEyA+yER8OiTQxtcRzh8N8Mg8EtEenkpFSkL8ZbTXoOy53C0mXKrzMUhWAFOavqN
    LFWGhDT2WaX53m45Nt4a+k987ZhZeF0L3Mrr5aaJK9njL/uGOqqiaQLdPlUg
X-ME-Proxy: <xmx:vtxwavwOmTDEWWDhYtJrS8_U7l2TvJULtSaSHG7Sy_RfXG_0w-U0fA>
    <xmx:vtxwaoCYZ_NxDCxS91G3lrQbVJQ7TZTxNSU8Jr1Tl2VzqNVewN3LOw>
    <xmx:vtxwalcNT9s3wK6zoWTXHpB-M9bZNCTDf3XCxNQa-rWK_S6P7VYnFw>
    <xmx:vtxwaqlO4TJTNfGF4tM88QBymDbUjMXcAsgjVIL--Qkv8ZF-PpYFqQ>
    <xmx:v9xwaunckHZvb5YvJXRFRkkLKEpq8WkVOhVbKlkzH7Lm4ItzSsNJfVLL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 14:23:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,
  karthik.188@gmail.com,  peff@peff.net
Subject: Re: [PATCH GSoC v3 3/8] fetch-object-info: pass arguments directly
 instead of a struct
In-Reply-To: <20260803-objecttype-support-v3-3-7176fecf7950@gmail.com> (Pablo
	Sabater's message of "Mon, 03 Aug 2026 16:39:30 +0200")
References: <20260803-objecttype-support-v3-0-7176fecf7950@gmail.com>
	<20260803-objecttype-support-v3-3-7176fecf7950@gmail.com>
Date: Mon, 03 Aug 2026 11:23:56 -0700
Message-ID: <xmqq33wvyseb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> struct object_info_args groups three pointers that already live in the
> transport and are given to fetch_object_info().
> Grouping them into a struct reduces the number of parameters, but it
> suggests that fetch_object_info() uses all three of them.
>
> Drop the struct and pass those parameters directly to
> fetch_object_info() and send_object_info_request(). This should have no
> change in behavior.
>
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  fetch-object-info.c | 53 +++++++++++++++++++++++++++++++----------------------
>  fetch-object-info.h | 17 ++++++++---------
>  transport.c         | 11 +++++------
>  3 files changed, 44 insertions(+), 37 deletions(-)

This has lots of changes but quite straight-forward.  We lose the
intermediate wrapper "object_info_args" and the uses of the members
of that wrapper structure are updated with direct reference to a
variable.

