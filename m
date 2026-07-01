Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FA634678C
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917114; cv=none; b=apI8Lwq9f3YAfkbz4DCdP9ZDtu7nLGWR7eKZb8Cophqu8q71IRGGKu/GwM1UsZ51l5molTqvU/yr92RNJk0q+kebT0vLnrh24D/RNoVMzIPf0hXUD6Mx5D5eCPwkAki7IEPI0wWfa7EGoRdHzuAYOcBfNFX0eQBZYKSNNlvvrtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917114; c=relaxed/simple;
	bh=tsF556405ZeAIilUr3GQPgb3/2bjxjZduCl7HNtBZOw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rtqf4RQ9Up8qVr8FVbrjFwos5RB1XJfv8mIVF0K80JnosHedx7f4aiuTdHTrnjpQyBaRXiUJ/QSPtU/HDHTZDjlX074c28PKmXrRC52hz3HzOirvVP0uK5ILg+3l0pBpMcdoXcYIFXeqsjmwelqvbiH+SwPyN5j3fZ5NoQib+sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RLh5WHN0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PHaUGeiU; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RLh5WHN0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PHaUGeiU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D4CBC14000C2;
	Wed,  1 Jul 2026 10:45:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 01 Jul 2026 10:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782917111; x=1783003511; bh=h9qiK108lL
	2U5UIP+iv4F9g/VkfVt2xSRht727Al0oc=; b=RLh5WHN0UySKAyCSXMQYweDvf2
	SszkIbkPYX+A9J0mruo+D3U/yRcUjazhpDRgmImpsEQjM1UhYPTS6A8OhgFR3ZPO
	StnRLZlZYC1Yu3MQJ4ZwXWmKOOmfvwli1o6d3lVa7wY2UrQ5fSqDGLqnz3EBWtEx
	MAijthQgKsvTozizeCR4psB76ZXNlXEIb6m0xyu0LILWKAs10Zx5oGxulUrunzdw
	nmOlMeUVkLfved2OTrfT61F62Q4/+FHhz+hvA+rjJ/YKZOf/+mEKqkEHD/vla1A1
	nofetTjlHgD9ER1CLWkh9V9ajwoR3JFS4iL1mTx6iLQUYV3Ukr+wQ4KM13jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782917111; x=1783003511; bh=h9qiK108lL2U5UIP+iv4F9g/VkfVt2xSRht
	727Al0oc=; b=PHaUGeiU7vSvspbM4yRnKZXv5gBQAAM02GrmoTXvYJqeFrOi344
	1EWT1stMN/utkoE/lRYSE3DmyAa6lTbFyWDKpqLxl+6nYqCDrD6s2KwVVnyrEIV9
	WWafWxnpMbVhz9+TEY4YbyCaAZLKV9Iw7g497/Hf6ZbM1R5jnOsi1coxS8l81iDp
	C99cwAHbxc/vzdZ13WWMClSQGltXTfSt+5HKTxJFab+AUYW0E7/0sZibrS8/R8kE
	dqtCV2bmB03biom+vH/WoOHm2i37s+FYxw686qlevBnZ2CFoyf5GcR5vqF7t9TfC
	t4VWLPVPdxO6Uh4IFiOmnnSEV8VBo8bICOg==
X-ME-Sender: <xms:9ydFalXbvmNn2Rcc5GzS2HGSmY7bcwcWfExPiaA2ZnICsrXG6YVYIg>
    <xme:9ydFaqh2Ouc9eHCoNoWJ-XexesGrDxHriWIQdQqdneRUgajOo6oQloKwZF4oNXoj8
    zprkrz6WOiJgirRCIy_boNjCnOIz0mFOa91kLbMI-0S8k4iI-OVHQ>
X-ME-Received: <xmr:9ydFalql3474IwrvAc3hDLF2AW0JaF5IJUf4SJW1xvpuEEaaboSp3KQQv6f_UYPW8QaOY4soTxdrhiEg2OYn2izI810-GmgRAc1y5Ls>
X-ME-Proxy-Cause: dmFkZTEanh33Scgfkhz8frQzoHCf0Ut7WiBz1KzkbEnEOm6uCY40uxwz5HS1agQbyVh2ER
    PgCkdsPZ9ktydrFsM9zR8ROgVceHJkOwGmumhz8DMY6Z6QCJQXr7HosvnmPmUZjgu3qRdP
    H6Yp7syO6818oen4DwM5U+TSHP+8fzoVfYVS0R2cc4SQt4uewdd7TW0vso+plRiDGJk0Vl
    3l5GGqoS+GPQo9bm6X8GArJwhryJu76kCTtkMPC+XNh9UlExkh8Ld+2Or8vMq3sXh5TqKb
    IMdOzSH8Y6L1diDivomPOx8IBI25zGxORNyc6l/MRaJLaumxN9oCLD8jVXIsf3ABPQTosS
    Jp5vJr/tyLhAZsYpdy65YJv7+jXEqZgSUgmU76JHzHWHCFflOI1w5degUwlWURYRqdCiW1
    EvUlq9LQRYIayw22HVEgTg7ueypNdfWf/dq3x4eURGrxdm1EGpBj1CSLMlWexi5caYol5d
    au5mlyXBif/DGtioJ9j5drS0aIlJVm5Wps54QA4p3xFRe4Un6mVaN/lDc0t+TmzyIPOlkx
    3CG/7C5TQe9JBZyeSq1FHeWuSH0k7Uk3Gg/SpkMzTaBYATqhZPeXgWnRFEXPkE0CKNVDL6
    m4k7r/NexpAHxsikaMKvVxYFigEjAOusLXHm1H9Vkh1ErZ3RAsS1Jq/+3eLQ
X-ME-Proxy: <xmx:9ydFaoH5YVBNa87X3nT7KLCbSAIN8mYvE3JBwvOksOq5wenJoQTkJw>
    <xmx:9ydFai4e1OnUD1d9xfWA8XQdhF0rf7ycPTcFUbf2W2DnDKwfMD6Swg>
    <xmx:9ydFaocUolBdB5wOrB04nQ3Tvu35C0efc_f3zCXm8K15VYYTHXHxhQ>
    <xmx:9ydFal5AjmVAfCOVMI1ywyHf4XgO_SQ4pFUGZa_5nVMAOupcljYeGQ>
    <xmx:9ydFasAOZuEVI_cIgfw8Ck9Bb8UcN9CqeiyNXmc9Ir2XVnzQP7_C6Dle>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 10:45:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Elijah Newren <newren@gmail.com>,  Derrick Stolee <stolee@gmail.com>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v2 2/2] Move libgit.a sources into separate "lib/"
 directory
In-Reply-To: <cbbb08fc-fd4d-45ef-927b-05ac44602ff1@gmail.com> (Phillip Wood's
	message of "Wed, 1 Jul 2026 14:26:59 +0100")
References: <20260622-pks-libgit-in-subdir-v2-0-cb946c51ee7b@pks.im>
	<20260622-pks-libgit-in-subdir-v2-2-cb946c51ee7b@pks.im>
	<aj9wcFEb6oCRnfn2@szeder.dev> <akS51xJSP4tkP_pS@pks.im>
	<cbbb08fc-fd4d-45ef-927b-05ac44602ff1@gmail.com>
Date: Wed, 01 Jul 2026 07:45:09 -0700
Message-ID: <xmqq1pdmrcp6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> As I said last time this came up, I don't really buy the discoverability 
> argument because there are just as many files to trawl through to find 
> what you're looking through and now there is an extra directory to 
> check. I think the solution to that is to recommend folks use "git grep" 
> or ctags etc. not moving code to a new directory.

Hear, hear.  Also it would be great if we can trick some talented
technical writer into writing the "map" of the source so that by
reading this one or two pager, any new person with reasonable
competence will know how things are partitioned into pieces and how
these pieces fit together.  I wonder how good LLMs are these days?
;-)

> I do however think putting all the library code in a subdirectory makes 
> it easier to say things like "please try to avoid new uses of 
> 'the_repository' and prefer 'error()' over 'die()' in library code" 
> because all the library code is in the same directory. I think that is a 
> much stronger selling point.

Yes.  "library code (things outside the subdirectories) should not
use X" would work just fine, though.

> Another cost is remembering things have moved - the other day I spent 
> too long wondering why "git show origin/seen:wt-status.c" wasn't working 
> until I ran "git log origin/seen" and realized it had move to 
> lib/wt-status.c.

Yes, this has bit me multiple dozen times, as the tip of 'seen' is
contaminated with this rename, already.  It is a huge pain.
