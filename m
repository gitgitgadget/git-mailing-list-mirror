Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121194CDDFE
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660365; cv=none; b=Khnmp1jpx7zf80QZ31Bkccr00Rm/4eiWk6C+CEMag3dL4014mTSkRL9+rkLLKKUu1EinP4XEovb1VJO1qWWSZUIffw2erMPwTWEYlz/G6Cwj/DrPKdBwZQvVccilVaFOACZvzNh+sBEt6W7s2/932V6kjTHrHfLOnsogCgvCJpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660365; c=relaxed/simple;
	bh=z3oDhxAjNwwGxO8pkzlqWvd/xBlNYLi0tCFidGeYMu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OCdY4v3ZuFc0KrQII3JJ88RQlxbzTEtHyB2R4eyr87wuWuvaeQwCtZ94BrjEHLpcKsnkA4DmiPDOJB/NSSacm7x+lKx5t4NNNws7kbyZR3wvYBD9Q0/F/qHgZDEpVV+TbLQOgU3O2yMEJHumW5udYuash8OBp98Q4xjgTkbOYww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g4TBJtQw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Euxj0k5E; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g4TBJtQw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Euxj0k5E"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 39BB11D00116;
	Thu, 17 Sep 2026 11:52:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 17 Sep 2026 11:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789660362;
	 x=1789746762; bh=8iIMiS+2zTEIUlyBLYq6PFjCjVNG0uuqpo1wvXq4jUw=; b=
	g4TBJtQwFcVl7qTZWSeGrM46bLw9PTr7oQFNgu1dmTNykdi2rqf8bw36xVJAU3rP
	Na08PeRXimKSLwgtRBhAHWWHh0wZMuKdE6sAREAXb5R3X9FN5b462cZ9ZWC6ZhOs
	Oositv2qnGRX3xfGngQbs8sBUKq4sICrg0KxgffX2MdCiwkU3FfG57wVF38i4xlJ
	8Ss+iHBkzvV/oN3rE0mc6HDqFBw1wBc3lKYJm6Xkhkw3eMMEO5iAqHPAJYtQX0Cs
	rr4Xy2GOmCKrtb2ahE2Gy1U+frztMWSAM3fNM2hOQjjam+UgUbNQ6lRSU3uI3gNH
	XYO/ijCpkLFsws5TTRYzNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789660362; x=
	1789746762; bh=8iIMiS+2zTEIUlyBLYq6PFjCjVNG0uuqpo1wvXq4jUw=; b=E
	uxj0k5EYREuuBlj9shluVqdMT1HH9jxRd18Mke5V+l39gHntZfYRsC8idVJybrPl
	Y9TJB2oX9YgiiyJgNlPeiBNdEpLXfFMqf78qWpVNKY7HZeKPVg/yI9ifpxoVRoeE
	rl1C9tMBfBz7byoTzBvCPNe4Qo+ZofiTYtWC3Y8gcOVa4akqk7pjh/HbICl6YdTq
	aegyORCKVobT46hURLT1NsRLqXm1msvMvjTvHhKRbDHEx2rrJg5LMrpTvspaVKq6
	qYAKEN3HZbyxtqmWjAAcBqfPPzMf9R8G480msi0vPqNQy5I4OnS93sLKdifp8aGy
	/HcXfYbHja6CEluQl6etg==
X-ME-Sender: <xms:yQysanXNbhy5n-hgWDk7z_8leMLx_Jvbql_wg3jWWk_6AogAPH3fyQ>
    <xme:yQysanCQcjf6g31rmYY7lx8Z2rNu-Dy0hts9gTNdyn9NT3_1y8ORO2i_gtDvEJEuL
    p-V8IapyZcQXD4fX_muUwZUC5LVf4wVvme4M-jwpPO2iWHovygIDg>
X-ME-Received: <xmr:yQysagwoSgVPvxdjkY4H4P1nNMZimc0t814R84iSo-ENm9fkAi3-yIBof1pNyolA8V8uMbLRf71u8z24i9b3niepAOG2BOVf50AZ>
X-ME-Proxy-Cause: dmFkZTGzLxTl0s1hDbIH4eNXt/jgxH8wgWq40xek3WXvQIKLUg3X7R6Ft0Vdzg+AaTnfky
    r8NXna0abahIpl/QH8/qDlFvJr+Mz4og2ewKL1UK67ljUU3tbyscEL/lo04LIlBSM76NoE
    tCkGknBmtPe1vXeT/06SGbgtO9eGJiGQ7EmN47tzOxBwp5j/NrCdNzGigyqnPzWDaTwD9V
    18ZCa7RqiojuXxlVULeS+1rds/QBvKFV2Px/hD27L5uESz00YRXxfyAKCanwkgzpT8dO4U
    llL3bbLapHl04DOUjA65ybbrPLsTmQCDObhN+O4/yzus/cs2ZM5cWbGpqrqOx/86h9HwPl
    m9olm/W/p5c2MYUI6u0MTq4rynVMpu5+w+8iMlvRdYd3oG1RKFhNmiMBo+CBzyIyFrOLrA
    HvsscaQjUKqiu4qL208R6/zAvjDuDYUCrA1Mpzr4oE6HF3ODt64/SXzDTzGT8h9qJA7z9a
    InbPK3aVRS9/unZn8Fpdj5SJQL0jaQRcEMob8vpsXWOOZzPi5KqWJcLZ5MKxorAdFJ6ltq
    q0O7aI7lCNBAZXF5Z0DTNjhfzhZBQlJmB3DN6BcKLAKnoOWrWZQOUMzv6x1deGdhcQ3V+3
    iot+bBNaDJfivC89uw3tdhxEkgYQUzEUdz87+KgumlSjIso5AbNeQealaftw
X-ME-Proxy: <xmx:yQysasBYaBwpfSVdTt6L3YGV8AX-euzQWpvj-ziJU8ycZWhPiskx4g>
    <xmx:yQysalbFi5NVGMcMfmLZ6CeOSPhLo1PnGFdulsCks5QSK-ivY-szhg>
    <xmx:yQysasjKp--5gLNTsFcu1paoSK4cvEcKIVNNPH9cH_7mSSqhcDr_mQ>
    <xmx:yQysav4Q1JjCU64Djn5mHA1Ch29ZFZKwgXzev_iVA6ZpVWcDxtz8Dg>
    <xmx:ygysarAm3yXTXgzq97EGiTQEQ9L0rSUBnR4s16t2WwvzeKKehuknr582>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 11:52:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2026, #07)
In-Reply-To: <aqt/ceazKbzzmZBC@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Thu,
	17 Sep 2026 07:49:37 +0200")
References: <xmqqzexhuia0.fsf@gitster.g> <aqt/ceazKbzzmZBC@szeder.dev>
Date: Thu, 17 Sep 2026 08:52:40 -0700
Message-ID: <xmqqtsnnub7b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Wed, Sep 16, 2026 at 12:07:35PM -0700, Junio C Hamano wrote:
>> * sg/precompile-git-compat-util (2026-09-14) 4 commits
>>  - Makefile: precompile "git-compat-util.h"
>>  - Makefile: reintroduce REFTABLE_OBJS
>>  - cmake: remove any "$(*_OBJS)" variables when parsing Makefile for sources
>>  - Makefile: remove XDIFF_OBJS initialization
>> 
>>  The 'Makefile' has been taught to precompile 'git-compat-util.h'
>>  with GCC to speed up overall compilation, while excluding sources
>>  that do not include the compatibility header.
>
> It works with Clang (and probably with other LLVM-based compilers; I
> tried the Intel oneAPI compiler) as well.

Thanks.
