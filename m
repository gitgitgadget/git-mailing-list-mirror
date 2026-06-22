Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC293B7B8E
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142993; cv=none; b=kTk4uAb5Fv5jd49eMCdw9Ny8CPdJCKY5rovJ4GcrLtglRA9VQavLtDZK9vhO6km/4VTjeO20i3NpdHX01KWlc3ZQgDA+RqNcU1J+AuT+rm1uh8u5tVNS4jW1n5wdEAczA57TBHCP6rAnbifdrQhJ3oX6Qi7lR8N4DgtpsdoeyI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142993; c=relaxed/simple;
	bh=ReYE92QGKtG/OYyNiLecrkpk9DdIHGOXfj6wUR2yyGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bC/S4gIO1vme10s/uA8mepC6ofN2nOv6eSwrsF8P8ks6dnRh/PjRFU/20CX3OYugoAUg+ztANDiA13Bt3KzQw062AVvEgEWeYCpimfua++7bpM2nqc7E3UtslDqEgIdPDlKcwOWAx1Of/FTfmqHC7C591hzNYikAgDFEAD2pMwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E9xnHh1t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZcremSdw; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E9xnHh1t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZcremSdw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7BCF0EC02EF;
	Mon, 22 Jun 2026 11:43:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 22 Jun 2026 11:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782142991; x=1782229391; bh=UEZSC8rvvF
	Sxs+AoX+61wBFwc4jQxLgUo6MQZXFWiK0=; b=E9xnHh1tSvw3Gqg/PlP1aHMxnP
	K55lIiqHk7jBsO78ake01k6nbPK6lcyUcLD3BpP26Yj27GZdHwDKteInTsKeUeul
	GGehliaint2cd3uY3mHj4glNDl8rsaP2fmFTnUw6A1cB/X51wzjLl7LJsmHcB/N+
	fyoO1js536W/JF0YJBMsIrzIZB/nEQ32IVztkdobG85q1m71Riu3ZkAQcxo+m5eT
	xxJhy2FZ+6SMzDRs7EbVJPq9xwg9FaaVtzLgucgqAqWrudpUGly7GWFpbJUaf2uG
	gqgWFemCouYseXHXAiPuCK3KTb1yywbWqAW26WOjL29MGyIl2PkGDITr/JGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782142991; x=1782229391; bh=UEZSC8rvvFSxs+AoX+61wBFwc4jQxLgUo6M
	QZXFWiK0=; b=ZcremSdwWmz87Nit7FUJch2VCZzS1q9oFwhE2YDFRuNt31OTy13
	ST7/vU3c2h4HPisOX9MwDNLRx+4FqZcg6yxm707Zpm3HKAzOKU/5Ujb0pkN7U6L4
	hllJeA1qS0yIX56gcJbXgDsUVcDuT1ll0iRlski7QzPIdZcKokj2Oq6y+IlAZyh+
	u71v2T7rXJ45oZCj4/3XLTFhH284WLapFkJVWes+WtPlqFwyKpcHTSLDw/In7Fsa
	pDoxiJBNrzY7pwb40bFTkL4Uqp6agKRL54RzZKIwdKkFAhrbZFos3PKZWKINE4Wz
	dyjcQAUj4XuPzvpDtPlqrQ8k37ZaJ2SJ9yw==
X-ME-Sender: <xms:Dlg5aomCU_p1VgEpBw2RTidrHCazs7cF_B56gn8CYfgFvL2xrLVM6w>
    <xme:Dlg5auuQTtwKTwXeUbRBiWdyXLSntIqsXnUO5WOQQTNDWa-yXvLzRBprojflT0Jlq
    lntpK97mV441Yo7yJMWHMa4mYd5O2owVOheWOc8O2tzBON1vWkY090>
X-ME-Received: <xmr:Dlg5au9oXWnXs8TnqHoxzfVdKmk7sLqHXaYAd79t8JiYddhcNn1g45K1qGOPBXQ049AUx2DPnfnBa_HXkVXaq1vb91h_8CCXw4mcTbI>
X-ME-Proxy-Cause: dmFkZTFiHdARVYqR5hLCiiZxKmy9YG2l0cqAjedSg6KgjiSg/l21VLkryBiwlvJyk2B/Lo
    dXMAp/xLXIvBbLALDFVLSN5s0Rfs5VYEqjlrx2KDOptS9StNNKOC2HHFtcQHTHQPtyHLB3
    8QUA7Fqo+IrPvTi9MxPe/0z4v2/qOX+wNdu0H4ubchfcGVbX0wWBlwLRmSoIqOPFEBizW1
    9PP1+VSUP7Mjk8+sAaaED2o508iIW27n2wC5WnVq+mCmNutC5YY9LBZAwyOjclAOwybSfq
    UH9HNryfcG2I3WztC+nwPC5vD8GMiSq5IUhWo49/FYbtyme6AxsFCCMErSAepbTJcWALAs
    px0Dw3CzMtejlxQieg56C1rpbr4Dz+y5K430KXOVEmIXP8u4tXLzO2IMyViBAWEUjElxrH
    DQobmy3aETKICVJX/8NAfTTMXc+mDO6QN6oDejKO85dnZVZmWvxrelMICElcuxcP7Z6Z+s
    9nguvaxPrMHOJYOAEbHMYDvVN0hHR9ZrfvWC/3Q1wKI+bKY7yTcVUeClFF6ftGKS/xqfYy
    fYk/kOYN9jghvJjfpdvOOU+0eYiuEVk80bR8IGHvBMcjyYiIR7mfHiD4Pn+93cn9tRijaD
    BfN5YJHObsbc5bBIbAYhgaDdx/1GW5hF7sS1IaeHNw0ccy071EiZF4ovoheg
X-ME-Proxy: <xmx:Dlg5agOSAU1DHGhE0VDFrVyzQhiDYF0QWHYHg57xZdsJjMlJi1RMUw>
    <xmx:Dlg5akGas5ziLYgKhzL75y0EO9gcZ5WfC81gTTL-AuOJ2GQj3Gnl7w>
    <xmx:Dlg5amRt96r09ZGArcnPMU_3oiW8jynLZfymsd9pnuDB4nc-IQbfcg>
    <xmx:Dlg5apuzCv5bK0FddmL9b9w3EEK-J7t99nSLW9aLCMUtcSE7cZB7yg>
    <xmx:D1g5akoUZojih9BY8eSFQ34QhXbFLizh9-RWYXf9huu1V_JB_Znjj1DC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 11:43:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v4 1/3] replay: refactor enum replay_mode into a bool
In-Reply-To: <ajk-YQxLWfspNWIm@pks.im> (Patrick Steinhardt's message of "Mon,
	22 Jun 2026 15:53:37 +0200")
References: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com>
	<20260622-toon-git-replay-drop-merges-v4-1-ff257f534319@iotcl.com>
	<ajk-YQxLWfspNWIm@pks.im>
Date: Mon, 22 Jun 2026 08:43:09 -0700
Message-ID: <xmqq7bnq37jm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jun 22, 2026 at 02:41:55PM +0200, Toon Claes wrote:
>> In 2760ee4983 (replay: add --revert mode to reverse commit changes,
>> 2026-03-26) the enum `replay_mode` was introduced. This has two possible
>> values:
>> 
>>  - The value `REPLAY_MODE_REVERT` is used when option `--revert` is
>>    passed to git-replay(1). When using this value the commits are
>>    processed in reverse order and the inverse of the changes are
>>    applied.
>> 
>>  - The value `REPLAY_MODE_PICK` is used when either option `--onto` or
>>    `--advance` is used. In both cases the commits are processed in
>>    normal order, and the changes are applied as-is.
>> 
>> Since there are only two possible values of this enum, simplify the code
>> by converting the enum into a bool. This avoids adding code paths that
>> check for invalid values of the enum, and shortens code where the value
>> is checked with a ternary operator.
>
> That's fair, and the result is easier to write. But is it really easier
> to read? And what if we ever have to create a third mode going forward?
>
> I'm generally no fan of booleans as parameters as they basically give
> you no information at all at the callsite, except if you're lucky and
> you already have an aptly-named variable available that you can pass.
> Which seems to be the case here, but I'm still not sure whether this
> change really improves the code.

I tend to agree with you on both counts.  The "what happens when
somebody else wants a third choice?" is a quesiton I would ask the
first thing as the maintainer of a project.

Even if the boolean parameter is so obviously named, the callsite
can only say "true" or "false", unlike some other popular languages
that lets you say

	my_function(use_revert_mode=true, verbose=false);

and you cannot tell what effect the author wanted out of that "true"
if all you can write were

	my_function(true, false);

Of course, we could go ultra verbose, like

	my_function(true, /* use_revert_mode */
		    false, /* verbose */);

but then we are often better off writing:

	my_function(REPLAY_MODE_REVERT, REPLAY_QUIET);

Thanks.
