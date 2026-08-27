Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E77925A2C6
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849702; cv=none; b=YRoHinaRlYIuuH94G3fGnq4T/BXdXgQlME7H/TxKTcKHCFsOY6xAYS64GlipMMauweTZHak1xejs5A0Glz2eZ2D3XCxzM6bmbeTciQrbHU/BtaQfWbnt0ZwVG+lV6mFc1N93HEll4rovGs7tSHCyLljT2RROxYjOA/Cb4TxoZ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849702; c=relaxed/simple;
	bh=F51krKtJITwX5RdLIl6guyBINmLX50XTFsnAOghToKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mHu0l+IWk1YawXFAIbQlMlmssl2duV51Y9WRBj6n/XVeASQcJbUFZzlkJUVNQxqd44FvJqd/RV9Ycxd7piOMopGyKcTQbE5T/vM9UGDQRRzyu/QPQyatAeCtX3j7eKnDoDxIS4xXHT7z944Mj3uBKumvzqsSxi8G8CRzIl1qxQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bQMZgXnw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gBlmjzRl; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bQMZgXnw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gBlmjzRl"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 122BA1400151;
	Thu, 27 Aug 2026 12:55:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 27 Aug 2026 12:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787849700; x=1787936100; bh=jIs/x2eoyz
	i9wXOmXTMIWua9wbfa28cgxwesEjwa1Wg=; b=bQMZgXnwz8eROsiyojA9LA0Ju4
	7dF2DUW9wFNZSRxFZC9DrDIw865phW2DJYVgr1KrBNBzT+tH1PwcL5k30AVVFFce
	8pXpssVJTf9zDoTcCUedgSD7bYiEGmzROFVMy/MnDrNUvHOTyILFlAT+yOXbiiL0
	dRalzDpiK+WiDduP05Xoz+2mwkEQhZR/WHac12KmEAj/AnUPFRw2B01WH3+VuLRg
	G2MayDQuPrFGFxF1QObykk9/SJKH230U+ylxQhFglR+gII/HiNHfZDZbOWYQ5QRu
	GhdgFn/trT2pxkgI9/K3DYc4qvAelLgjdMdtJSJiee7K2+xXoLCHNvFQ51qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787849700; x=1787936100; bh=jIs/x2eoyzi9wXOmXTMIWua9wbfa28cgxwe
	sEjwa1Wg=; b=gBlmjzRlG//1QVnP5T1b8VylBA9/bVITaUPAqu35+hNg1VPtLAu
	o6DMB5gkJgl+jfVHPiqg7uG6S11XqpJHXCNanc82sVnLWbd9PFtLeGRd6NLRyGA8
	07q2P1VBV7NkPgNZ75ruXwoKjd8PUhYZBDq3+uikKeo77UB2aDADwrEyy7yJ47Om
	Y8oZgGzw9SBpext5j8szfrIHit5HRs65XVgZSja9suP8pQkOr9fNuiUg1jh5Ievw
	RE1EnOaK36BPKmBpUMT/Dfy4Mh4t4bggYoBPO0luegFkjKGt+MiMG9KWaNxOp3CK
	+zudnw8qMhMbyM1vYKpCyFxkM79M3guIV3w==
X-ME-Sender: <xms:42uQahLlIOKmyjVepPEqRtuA_oTGiu3rhujUqsZk4QvozM1mcD9qeA>
    <xme:42uQakCblLnHiAEDN_WKw9wqwsTIvQAr9EwuJkfPx7Mjff5efu8QvpFV3nIeQs4Wa
    yCZ8uAu8xXUOEWjYRjD8VTd9YWsonQ_JwpwvM5MtpnmCxqtBjVU5Q>
X-ME-Received: <xmr:42uQaiAt1MnezMv3wYjlF2I5tWVYhStENHFQST9AoZymZoaIwcd3YIy1EHUPx1IIFin-lLBUfk-sL8XQNCn5IX16ZDCqjKrdrw>
X-ME-Proxy-Cause: dmFkZTGG/c61O3eXvmiak5zrg2Cd7sb7pbP4yc/8yeVnU+Ehwu4H52jKafVygEv5HNpmx5
    luTbkHAW9ZVqRah0wAzU6ETAYFYY/1RjnUuw+mDq/Kz50OWUctHVuOj/gp7+5RBdjIvnI1
    JeleRHAWnbs0ANjQJ4zbRxesgJKZ0gSFx9LGT0pURl3dDB6/PKPsPZiVnq5YZjozLY1H2U
    Sm6sH337A05GDyOsrIfoNdOqnKCHqlq5h5GTi+XtAmc4GhN1xrCt7DuJMH7knM5v6Dwcww
    nPeEDArPxz48KOGqzk0wWIq8AgPGp3mGEB08kSsvuZr9VFYHmd77Jba+duN2YQfPN3leqd
    H/IwoT8LDoJ443Fh3qjWRF5B6qacXF+hC/8NBefpwomb+ls9FDCjwdCy0hkX0w7xICmJsa
    59J78C9qBBAo63wGdRkk9Lw+2OcE98wxwygX8sMoCAiiU6dp/ibZCnyXQXLN1mHQvpe0fv
    N/NQpXIndqwraYj/E0akLKiYav+an+u1YjuY+eLDpby/i1Dzy2OISOhLZ49IpCR+lrDLjm
    BuQV5YAIdSze9bduXOIxubKT8tFbaw08rl6DSACYcDK3H1C7INiYZpf09uOaxsyWta59vQ
    3if3DLedpgrjuQmVyA1QTZijfTdPJpC9Ld2B80j0c9X9ZgE4E1inLZuFcW0w
X-ME-Proxy: <xmx:42uQauAgA29aucDBjyZwD5By9uFICI_s_-MnSf29YwawOr3s8PK31w>
    <xmx:5GuQalr8c9f0R_vWQfrlnM0WoQu83OhmSb4U6L0yLFRGQDzmjhW07Q>
    <xmx:5GuQagmoD6SeOodPSt0f1xsYV5RPKT_ObpYo0fEOXAt8aCADZJ9BYQ>
    <xmx:5GuQatzpJ_iKNxsStNDYSqV6FX5EOVwanbb15BUE2q3dQFzjDYk_oA>
    <xmx:5GuQahRbH3TfIxO_2GSBgYMGpsibrsOgma7gDdgZFXEbvPv2nP5avuZ3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 12:54:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/3] commit: reword the empty-commit rebase errors
In-Reply-To: <dec05fd6-b99c-4a71-b80e-24e7d6de4b62@gmail.com> (Phillip Wood's
	message of "Thu, 27 Aug 2026 16:19:09 +0100")
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com>
	<65c48ed3cb638cf0be18a3aa6d86d4c4f2cf01a2.1787792534.git.gitgitgadget@gmail.com>
	<dec05fd6-b99c-4a71-b80e-24e7d6de4b62@gmail.com>
Date: Thu, 27 Aug 2026 09:54:58 -0700
Message-ID: <xmqqwltba4gt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> @@ -521,7 +521,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
>>   		else if (is_from_cherry_pick(whence))
>>   			die(_("cannot do a partial commit during a cherry-pick."));
>>   		else if (is_from_rebase(whence))
>> -			die(_("cannot do a partial commit during a rebase."));
>> +			die(_("cannot do a partial commit while resolving a commit that became empty."));
>
> "while committing a commit that became empty" would be clearer to me, 
> but I what you have is definitely an improvement on the existing message.

A stupid question, but wouldn't a partial commit of an empty commit
still an empty commit?  IOW, why do we need to reject a partial
commit while committing a commit that became empty?

Thanks.
