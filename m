Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BC0211C
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 23:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748994478; cv=none; b=dd8nylIfvNGynh9GZfKPElf03eUm7q7hvDIqp9+YLvuXiaRUQUDiYwMbDOwgAcWOVQSfqTBUtAdecmg8ooEtZjfZzkKBWdaPbrkzBPYwJpQApkSqGEGzCRgxPDJcixiN8BLYtT0Vi9m2Akqy1RSjzUK+koVFq58NlHPsyo3dJBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748994478; c=relaxed/simple;
	bh=A1k/mvUHZI42yu+tWazB9/tWBvPHZKnsaIXIjUVHcfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aP74REZ7+t249QAt+glUMZK32tP/3G3puodvkC7QQQPs97DMFOj+eyigQ8sRaqOLBmYee/CwlGvy5hDE8uJDY1ktk80Ies2QfwL5LypnCbpmLwF1iA9Fl4NUgyUE9yBKFpuhHJNrCgiUTxd0C3n6P2Sw4xIbO1dif/C7ROanR8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rXFNRh2P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dHrnw4qw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rXFNRh2P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dHrnw4qw"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F1C7138005B;
	Tue,  3 Jun 2025 19:47:55 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 03 Jun 2025 19:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748994475;
	 x=1749080875; bh=MkT+EVOk1q65Bt8Q2QGt4SykvYvAjEhU57Z5GhJzWeY=; b=
	rXFNRh2PK+BuBtMcRNfNubxMRi3FB4TuYzJ58OihFEoBko5iIcfOeG5MhNEIb0nZ
	EW4B2NrmyvG5vT+uY9/LlGD5acO7cBXcheeMzhsU82HO05NbVBj0l5DSNTITHXRu
	eqjzY8vvBInVCUz3mHL+BpFGxtZoME4Dk2vgwIcGladH+eK6RpOVSnujEQgWzZqK
	h2hoUt/EgtOHs8YuSFcp4x57PL3eK7qQDGQ2N6uLqwQ1Ax0Zguo5wNxUmO6N3xct
	5OrJtlUEKHWlH0Lu3o8D1FGSHw2rl33K2Vu/eXc4US63UoLtUDYQ7CI8d1diiyc7
	03acxuZeuwhquUtud+kjeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748994475; x=
	1749080875; bh=MkT+EVOk1q65Bt8Q2QGt4SykvYvAjEhU57Z5GhJzWeY=; b=d
	Hrnw4qwGDpQMJLmgLX1lMebLAdTeFvbSpbRxxTYHbe22jsgPZaK8urAWGViim6K6
	s2ws3bmPi32xDVnb8vnH8vzqTWnS2ISNjqjGE7MS7lJP8LwZBYAu3V1xMz/PXNAt
	UiBJgoAEH4iBQWIiZliUqRxJroRa7VSX9yy5waSxBS4A88pf6xC6AgbvQs0WhYSH
	3L+vqRzC3iYd12hJVtelDnq7IVng1Go1VCivV8qAz2szfQwbZq+3dEX5wwzB81qJ
	CFDACMn7fSmYq1zViz6RxUN+n4DwlSFpj6ucjy9NYmjhhq+36pmcctqeRE6DKzjR
	dyFfM1SqYuKTNQn4YvllA==
X-ME-Sender: <xms:qok_aFembPGvuZcrtx6RrGkVpEz5oXBsoeuugJNTpGxGLc3RKzl0UA>
    <xme:qok_aDMZ33pQu86yaL91DEhK3p6NLQ_Hw1skWWqY2HX83gXp6j8AOx2cZN_hQSbj3
    tunyrECcjlYGUx-Mg>
X-ME-Received: <xmr:qok_aOjkBS7H4zqe6uGKr9ZPnVN1LexgXI-170pY-tMsIYb-DohGz3QFbzUrEI8D0NaDPMzDllGq2YLr4lm1RmD5pDXVAP7KvVpT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmhhesghhlrghnughiuhhmrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:q4k_aO9S7l5uIY95HQCcASCQ7xy72U8lQR-VLWBqw_BpoXV7qooRrQ>
    <xmx:q4k_aBvOk3xCboOvIiPt6O8TGuFWbCDCrxPPevmKcP46BSwwCD4Luw>
    <xmx:q4k_aNGf5cF-8uxh75LMMpQg2qnK62U5-3yb_l9tRTvstQE-UGD4Rg>
    <xmx:q4k_aINjpOH3Gu0MsAw4Og_6adJtUaJRjVgsyMKSPoVZe2Tv7rGj0Q>
    <xmx:q4k_aB7_0MeFrb-wg6EtMPvK4HWEICPQkk6JBPWscSRUOpYAW8ZwU841>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 19:47:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 2/4] Fix use-after-free warning with GCC at -O3
In-Reply-To: <20250603230646.2322671-2-mh@glandium.org> (Mike Hommey's message
	of "Wed, 4 Jun 2025 08:06:44 +0900")
References: <20250603230646.2322671-1-mh@glandium.org>
	<20250603230646.2322671-2-mh@glandium.org>
Date: Tue, 03 Jun 2025 16:47:53 -0700
Message-ID: <xmqqwm9sfkuu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Mike Hommey <mh@glandium.org> writes:

> Cc: gitster@pobox.com, Mike Hommey <mh@glandium.org>

Not to me, but to the designated area expert.

Thanks.

> ```
> reftable/basics.c: In function ‘parse_names’:
> reftable/basics.c:233:17: error: pointer ‘names’ may be used after ‘free’ [-Werror=use-after-free]
>   233 |                 reftable_free(names[i]);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~
> In function ‘reftable_free’,
>     inlined from ‘reftable_realloc’ at reftable/basics.c:30:3,
>     inlined from ‘reftable_realloc’ at reftable/basics.c:27:7,
>     inlined from ‘reftable_alloc_grow’ at reftable/basics.h:228:10,
>     inlined from ‘parse_names’ at reftable/basics.c:214:8:
> reftable/basics.c:44:17: note: call to ‘free’ here
>    44 |                 free(p);
>       |                 ^~~~~~~
> ```
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  reftable/basics.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/reftable/basics.c b/reftable/basics.c
> index 9988ebd635..de21fe6ef7 100644
> --- a/reftable/basics.c
> +++ b/reftable/basics.c
> @@ -229,9 +229,11 @@ char **parse_names(char *buf, int size)
>  	return names;
>  
>  err:
> -	for (size_t i = 0; i < names_len; i++)
> -		reftable_free(names[i]);
> -	reftable_free(names);
> +	if (names) {
> +		for (size_t i = 0; i < names_len; i++)
> +			reftable_free(names[i]);
> +		reftable_free(names);
> +	}
>  	return NULL;
>  }
