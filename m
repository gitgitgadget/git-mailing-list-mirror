Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3B9218E91
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422515; cv=none; b=I2mlnwqkk1qPDvSNCQAP+XypREmiBEKlGKTZCX1Pzxtk7k/se8Zsxz6qvQtM3R9vt4n/rlmHUrfMAdFrpoxsCCYrkb/F2W/I/8wKhmbCjCZiM5NNrY7dTrNbMD4Y2YGfLLV62gUv5jsaaTzEAoFRY+aQ2qNrt9HDlC1acdI6YV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422515; c=relaxed/simple;
	bh=Yc6OmdK0s9GYpTyB5fbfHHnIXy6eQT6emO2aVIaZb8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpGWTuBVNE8+r3I94GXSIDtwcgMcOMICdHhrLGoN5gwagVA4ab5jcF1wpjUMjdadGDEdac1Tso8eF2t8PGbqADduMEa9aDnUY+hneQ+pqIgZsJeDzFdc/R5ZOzU25K/mjwOTX7ArV+ZTLsLzxAM6P5NhS0tijYLTlmUmLMDb41U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kbfBQcLM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XwUBcfPs; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kbfBQcLM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XwUBcfPs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 71A601400238;
	Wed, 25 Mar 2026 03:08:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 25 Mar 2026 03:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774422513; x=1774508913; bh=yvfJxFxlhx
	IyY91HOOkUgYZRL5lbI+z6ijfzuzfAPu4=; b=kbfBQcLMiYWI41YO10erx3Sapb
	BuccIr9EXxEY+x2usAawrdFj/DmInRODB8vSmymXQs1tfZvQLCcgoECTR/ugTTiH
	PUf2WT1IEu/6wi2IYRuBEhs744QQNqIKgsJDHiVcwanO33RM4KK78+bLRrmBnWnT
	6H4aJJ2ONzNgw48tDBL0XrUSJqeGC+JvRFMWAZZfsd/F3u26jBPa435HBdBJzHaX
	dNp1zcl1+DGyc5zEfqFisqft+zjDCApcTiOIR7XXZJKcCQR1U0oqp2IbWNfqSYhf
	B8PNvuOZTLREEei7wD+VwPid30rZ39lwaXcilfkBT7LHg8edRqAWxEQShUWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774422513; x=1774508913; bh=yvfJxFxlhxIyY91HOOkUgYZRL5lbI+z6ijf
	zuzfAPu4=; b=XwUBcfPszK6nTJ7j+X9LfTtIfjkgCb7/D699sQiTpA4aMwmT4oB
	J4N+IzQJ15l6LnGX7JLv+t/aIruw4FnuqljmgDctKnObNWtOVZ+I7njcGUfntgWo
	GcUYAv2SML8SklcbbRRHPDCH3oinADWbHqfC+0rlbOZS80vBh7Cnqp82riAgo5B5
	rT15SB/9AgO7PE+vQEGogJIHdtr65xKL4nuSPiQQrDQnJ++tQ7/CRUSvgu8NhH3C
	5IwoAqeBaf/7H7UsFo/05h67bpfhkQUK5nayEqQEWTpmwfkoT0p9g40I+bSQJoER
	Dpj2MtaLIH7FAEcsxr3CCW3JPc8Si8nc4Ow==
X-ME-Sender: <xms:8YnDaW8egXuQVUKq-FcKJ9FSXVq1Ubtk9wliKtm4u6mee1ukmxTJiQ>
    <xme:8YnDactOOcChQ9M4AefuRCIbG9soI7RBp_U8U4jGMza2NH65Sk0Swd7GVuiwlnNKf
    1jr34cF1BakVzs3x-4fdMc3CYcBpnetz6T1_tdMr_trBXhp6c3_>
X-ME-Received: <xmr:8YnDaZrknTakq2DBHaBcAXmzr77zKnVQtsgJ9Vurz9a6YnqJkCEPglCfxXoEaYwGq_9jTC7Yn4ObaknPt0L7LR2k2XdqFVee6cG1sC9SQO4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdefkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8YnDaZn6bo6e4sEEyxKfbQqZfFL3BhmlSb96XoC9dYgIqEBogobXWQ>
    <xmx:8YnDadymOPcU_arn-QCt9UGjJsxG3SxIzqn5KTDD_gGt5fgq6fctkQ>
    <xmx:8YnDaRmfcGG_MFTkh95Gq2aYADivM78V-9ZAn7ldtU2c4KBDJrPZRw>
    <xmx:8YnDaWfmhODfNbXY6Dt5PK4GSIjFAF8FYkw3Gi08J_0KX6lwnSpmiA>
    <xmx:8YnDaSUQibvz4uKnxzJHknVw6DeIVjrda3b3qDsOjSG8WJQjw86AZb_4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 03:08:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cfc816b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 25 Mar 2026 07:08:31 +0000 (UTC)
Date: Wed, 25 Mar 2026 08:08:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/11] detect misspelt test_expect_success and friends
Message-ID: <acOJ7EHFF11LJRKS@pks.im>
References: <20260325062114.2067946-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325062114.2067946-1-gitster@pobox.com>

On Tue, Mar 24, 2026 at 11:21:03PM -0700, Junio C Hamano wrote:
> Recently we saw an unusual typo in a test that misspelt
> "test_expect_success", but this was not noticed for a while
> primarily because the test script itself did not fail due to this
> typo.  The shell and the test framework did say
> 
>     tXXXX-xxx.sh: line 22: test_expect_successo: command not found
> 
> but otherwise kept going.
> 
> One way to help us detect such an error is to run our test under
> "set -e", which will abort execution after any command exits with
> non-zero status.
> 
> However, there are a handful of places in our existing tests and the
> test framework itself that depends on the current behaviour of
> silently ignoring a failing command.  Here is an attempt to fix them.
> 
> The first step turns "set -e" on very early in the test framework,
> and fixes one place in the framework that assumed that a failing
> command is OK.
> 
> The remainder of the series fix one test script per one patch, and
> at the end of the series, the whole test suite pass for me, even
> when merged to the tip of 'seen'.
> 
> Note that I let cvs, svn, and p4 tests run only up to the point that
> they decide to punt due to lack of external tools and language
> bindings they require, so for those of you who do have the necessary
> bindings, the scripts may still fail due to construct that are not
> "set -e" clean after they call "test_done" for me.
> 
>  01/11: test-lib: catch misspelt 'test_expect_successo'
>  02/11: t0008: make test "set -e" clean
>  03/11: t6002: make test "set -e" clean
>  04/11: t4032: make test "set -e" clean
>  05/11: t7450: make test "set -e" clean
>  06/11: tests: make svn test "set -e" clean
>  07/11: t7508: make test "set -e" clean
>  08/11: t9200: make test "set -e" clean
>  09/11: t940?: make test "set -e" clean
>  10/11: t5570: make test "set -e" clean
>  11/11: t9902: make test "set -e" clean

Oh well, you beat me to it :)

Patrick
