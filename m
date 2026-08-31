Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDA33FB067
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 18:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200804; cv=none; b=VhlFRt+M0bZ0OtrM9pYZUvqMhrZlqjLLHABy3SfZhb/hylzo7HdUE5IAfY6fuy3D9wJiQ+qJtWyHvGqZJe6gcPQlu9Uq40RVSk4LvNMsuBUy7CxdxdBTDYpVrhQRhYc8OYa6EAKDZ7w2XIkbN7vg0WjHU4DATJFTqJI40poueiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200804; c=relaxed/simple;
	bh=q1RuJk1mV2/KNX7KyGpOvAJPFlJgWeGTqla7W2Y0wns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lg/kGuxpA7BNfAXKmtRa17p8PecYMHRayZ7xRY7ecC+bKrmvXiazQaXkL2vSdtlAosY5f3BbCw3BD4KGApzTFczofkjTBL1SEFfx4lmIyr4CqVEiaxofmg8kGgsez0q/VJg5Cs1F0bzqFumgjKjMCU1UW/+9hUchhBMOgCOBcJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jcyyBUIe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NNIUxMRi; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jcyyBUIe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NNIUxMRi"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 22C8E1D000FA;
	Mon, 31 Aug 2026 14:26:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 31 Aug 2026 14:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788200800; x=1788287200; bh=4KZsALtCae
	XIERMY5XSXc6/ZgIL04wSnoAa3twO0SEs=; b=jcyyBUIe8kBPdBLBQEJZkMEIDR
	qlVf4gnosBYohUEWxbRsmhvIGtIMpfTFIzBC827+IANLzIneOHs6XeqilWrExeA0
	tJJcASeDwMvMp5fWT5dp7X4QoSAWXl7AA/c29/QPc0nnIlwMv+zxKodBpfxbD5Y+
	P7P7uScv6698UqQUbv1Nao6jM8VGXQlGaNpx+YQ9uDjINfjhaJDc0KPizpv/ZOd5
	292JRXqzbofWrbp98VWdc9g1L2zJd4CSWDm3678fTOHdT3y4p8iEtZe4OkCAiML5
	wtD1uvEZ4cWT79Wt4S8ID3Nn31KozWSpyzrZJ0pR8vbiXdU08nHhRk3Q1PQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788200800; x=1788287200; bh=4KZsALtCaeXIERMY5XSXc6/ZgIL04wSnoAa
	3twO0SEs=; b=NNIUxMRi8/ncvPjv9gq8wp5QU797rGRqW+gk2ZxQnhuakYQhlUv
	rTITwrKn6UWWYnax1rfW9lxW/ADouvEH/5wJPyNcuo+Id0CrRVk03qN9vdoDBbAA
	rCc2zRs52oCVILpM8MB8TDlMJPSpQw2FMUTbSCJ8d3ZIxhYwzwfbrJqzeHcnDy4E
	kmvUaEh/pYKkxxLR44waouLqsyzfX/pHLZWyUIPuK00Mcgnglzdb2IqQAT+/GWkB
	6zx3ZVJScBjWDC1LmTkINhD0JUb+94WqGWJ+rvBroOoMFVxBW9SO3eGZslUDmV3Y
	JnLr+959SYT2St3MNl1yUXTyyvMHBJCgFzg==
X-ME-Sender: <xms:YMeVahfUuJHdhlDIpjzkqYiiFdkoegJ0d2Q1LhW0NxWJRRUNDRRAgA>
    <xme:YMeVahf8QJCrzONp_X_eEegGt3dYw3qIVJeaI39sN_7ka4Ez_3n9kZYX6TzIH2JHI
    tlbG3Hs-kBnKd5QCxLk21N8tontVlrTjfvYkfTzlfXxBVCTG6jwSg>
X-ME-Received: <xmr:YMeVaszbnxCE1RvATh6T1JjLYEF8gdlM1RkmpWPo77sPY20wmVotfg4zuPYJILOxjeHmR0FV6fXI6cGKeUjAG04IctwbLsHEbA>
X-ME-Proxy-Cause: dmFkZTEZIPDKoFJNKK2cRcTB8ZiglPY7/mx8LVRisl2U38udH3MGL+F1HOlf3MR7bXYQlw
    9vwg0B0sLtNe6Ztv2o86fRVGZVCdQ37e69k5QyvLx8eospAIVBmJn2fWVaicceQP6yIVNo
    GBFgRpowrrgNK2BqCwQTDufNdT5gxwIYJpsB4R63SnLYqqNd57C5DD/4d2VHKF1A6nNzsi
    EPMoEjM+0JwFTzFtJYXsdkYU2e/vRmEbWI67tiYBUlG/+Of13FGaq2NozB6SbiwWbKQ4kn
    pI7iHM7V0g3HsjhXXeojerCFzHZrNhfDSzQeQDw5/s/BUsGI4BSlBJOgojgU8L7HJTSbo6
    bADXdDSeavBeZcMGS0Upyg+AufK4MXtFdEu37rM2k3yWHV605RnvtWN/h2NpUDzYUMAqyX
    bFZfFw0ZAsDLLQ7tlJyPbcIYC9EMEK+Dd3vLwQm1ZiFbuWH1Kd21J2/MWvAM/B1K8qLRK7
    NV6CdVrvETIo6cJVEflok+O9jLTfGqfNvW6MfWV+q+INw/ktTH06GL1V7TSevTXOQxbm6v
    7/nthmDRlIbPkoKYkKEhVF41wvpfguQVGK5o16IANQYzydr0Y5+wIJYjd9TUTLi9AGWNc8
    b7cz0ZHmgYAjiL2naMS6gznn/ARMqZSxcrwFbgVuxsN/Uzej3b/WHt/oyNdw
X-ME-Proxy: <xmx:YMeVag9MScoY-uGmBMuzjbGrMx1wW6BBedHARxF9WOdk5gKdeYLnXA>
    <xmx:YMeVasiwE2N7oI3-6O_NuqQdmLedO75-1Tn42yyK1SqEXgmXYIXcvQ>
    <xmx:YMeVavFU45pLWIWNm2Dg13jkXsfVpgSY5EhWBItQpHXwPQyImk83ww>
    <xmx:YMeVaj8MIvHpHFAFkMXtBlupYUgeWqgpxDJ7xv8vOxtbPG_OY_5fsg>
    <xmx:YMeVah7icOfqffkC2WSeDxP-GoTci9JMsN8MadHm5WJFbhSV5P76x0-B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 14:26:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Diogo Castro <diogo.filipe.acastro@gmail.com>
Cc: Diogo Castro <dcastro@diogocastro.com>,  Diogo Castro via GitGitGadget
 <gitgitgadget@gmail.com>,  "git@vger.kernel.org" <git@vger.kernel.org>,
  Thomas Haller <thaller@redhat.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] dir: fix negative pathspecs in 'git ls-files' and 'git
 add'
In-Reply-To: <CAJw8QBMmv=zLN6sd_W9uQMF3H6Baatyq=TogLyZSFXK2gN4V8w@mail.gmail.com>
	(Diogo Castro's message of "Mon, 31 Aug 2026 15:30:22 +0100")
References: <pull.2391.git.git.1787949348110.gitgitgadget@gmail.com>
	<xmqqwlta2agt.fsf@gitster.g>
	<CAJw8QBPbxangB90DceDXxaDmyz8fn5jbEUihhe2faJrZ3o7BeQ@mail.gmail.com>
	<a8955129fcb7478f9739c8586c6975e1@CWXP265MB5784.GBRP265.PROD.OUTLOOK.COM>
	<CAJw8QBMmv=zLN6sd_W9uQMF3H6Baatyq=TogLyZSFXK2gN4V8w@mail.gmail.com>
Date: Mon, 31 Aug 2026 11:26:39 -0700
Message-ID: <xmqqv78qw3hc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Diogo Castro <diogo.filipe.acastro@gmail.com> writes:

> My point was that computing the common prefix across both positive
> *and* negative pathspecs would not improve performance, and might
> actually make it worse.

OK.  Then that points at the right solution.  Ignore negative ones
when finding what the common prefix is, strip it only from positive
ones to reduce the width of the traversal to come up with the list
of possible match candidates, and match them as full paths against
the negative ones to cull "within the positive set but is excluded"
paths, and the posted patch looks good.

I still wonder if we need different implementation when we have many
more negative patterns than the positive ones.  In such a case, the
stage to filter paths that matched one positive pattern by finding
matches with a negative pattern among many of them, which may
benefit from having a similar common prefix (among negative
patterns) optimization, but that is a separate topic.

Thanks.

