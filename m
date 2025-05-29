Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF82B1362
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535439; cv=none; b=iS9UCUMLl42uwulJfTWpLOY0jXJdR/MWZP7taZ2HwtqqHWiRWaCCC9IykxrJCwjzWA6ylVxi1mKKtQbp9341D5nEbHJQNHPrYMgEnLQDN0IF7+Fk1dJrGikfNTXMwBz6NjDx1Up9F77XDDJ0KQ1txBZUK8CxFfKAt3slMIS0S/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535439; c=relaxed/simple;
	bh=SN4KV1Ywwam2vFSHDtF76mcgW6ADHLQDHlWdmOYns+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vDUL6Nh5cbZha/ipNHR63t0DYKUB5hetYg4PNLeYd5URwcb3/uTj7M2+YsMO9g+rkGvgtM+dbzkgYtplO8gV/IqTjutp+y5pImCBdjg/nCu5RlziNenquvpU9bvh2CR7qORLPGqIjkIPznv4oGwAEVmjnmCJnpcBiC0/wwMOd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XNt3ypGs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kq8DLWVV; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XNt3ypGs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kq8DLWVV"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D052D13800C9;
	Thu, 29 May 2025 12:17:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 29 May 2025 12:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748535436;
	 x=1748621836; bh=n1QNhopAdipwKe9L5YjkqWI16F7ibUCyCklkVp/uJyY=; b=
	XNt3ypGs0BSciJZDkODCQnuOhMUXq6h4WOkSJ0RNWc3PqMy63B3lvBkBRkljZUL6
	5tWMXnxgToxUL2Rj17SEUWokOAQdG0petpYkEUn0pDhFQm+U7ii+bHa2FWOuzWIO
	mLSAXKFKDdZBJsOjH5bKAgTYHzkcAV8XUL52EtDWORMNMFyL8tRqrdJIqoM/xb6o
	BHfKCRNYCGnnTPzO0bNfOtoY5j9Hko1emv9rlOQl1W82BDRKU25b/rBhl5adncog
	QhSEPIr2WWyWvzm1mnv28hTHrfIChkoF4Y1KMVbiZIPFKl/PhnQANG+8u6crqV0c
	quqrxSy864WTD8u3acaWmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748535436; x=
	1748621836; bh=n1QNhopAdipwKe9L5YjkqWI16F7ibUCyCklkVp/uJyY=; b=k
	q8DLWVVHiWUAbEUryKB6sJNIrs+Hn+o+xzHghQ2QV1HAW+H5BaPTuMPsnrH/4+0H
	tjAzZpj/XxFWv6u3TRPTBO+kdVV92s5ClWj4a1HaQiZs/GGYq64jbKcbLUj2ddjS
	auhlBNAAa1q9gNhczEkD6q/+zFxKppzShQVuSBAIt0Qa+iKiEW1tthgNYUCPA8od
	wHu2qWKQ5rWRAvyevjKMcoS53BCYXpuiyRnhRAuYShvH59CGsGvYaKqleGThVXAc
	XkU+IpQRVjeymtcW7EkP23vrjtNpxNglhemeMAXHJNexsfYn5rP08xsIKzebv5z7
	xuUdbMdqgRGQzpZOjwTww==
X-ME-Sender: <xms:jIg4aBEsoZ-V8Bp2TeD-BvMh-hSgH1obHgwYwqzNr8BLAzaKajbcpQ>
    <xme:jIg4aGUl2WoqGa1ctjciSiso8NArGpPOnrTipPtgDKUYK0P2r40nIEf25SbpicODJ
    iktbFvSE7ZmssBWQA>
X-ME-Received: <xmr:jIg4aDICipz5L0VYGh_eLAyldSdSQOXkHSDDbDcUt-IsESlBBc2PQLdpitPeIJ_EHOQHh67ZxQAtBTy__WmSQfhLdoGRl2EIoFjNp-4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvieehleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouc
    eoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdet
    gedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphho
    sghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jIg4aHFHt0swvsZIlFEY6O33V5DijMt4Y77BjOSoOai3ADx2GNojoA>
    <xmx:jIg4aHW1qP3-eEPfpZmEWjgMcbc-KfeRW6vN3n_a2_JaexBuyIasuw>
    <xmx:jIg4aCP9ntJf-Dl4qaJPoHTfsZIT4KZebh6Dbk4SDnMyCYL4x5N1fQ>
    <xmx:jIg4aG3LAK7Ab4P5NNBU-hqpH466EdFo4FR-BuTEaeOzMBq5m2lChg>
    <xmx:jIg4aALLY5Vu8j7IvT7k5crfdLMqANAPy1BFGKgTSkWQ0RsgfAn4NPIs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 May 2025 12:17:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  "Randall S. Becker"
 <rsbecker@nexbridge.com>
Subject: Re: [PATCH] reftable: make REFTABLE_UNUSED C99 compatible
In-Reply-To: <20250529101136.16219-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Thu, 29 May 2025 03:11:36 -0700")
References: <046901dbd002$a0c245c0$e246d140$@nexbridge.com>
	<20250529101136.16219-1-carenas@gmail.com>
Date: Thu, 29 May 2025 09:17:14 -0700
Message-ID: <xmqqtt53l7cl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> Since f93b2a0424 (reftable/basics: introduce `REFTABLE_UNUSED`
> annotation, 2025-02-18), the reftable library was migrated to
> use an internal version of `UNUSED`, which unconditionally sets
> a GNU __attribute__ to avoid warnings function parameters that
> are not being used.
>
> Make the definition conditional to prevent breaking the build
> with non GNU compilers.

Quite a reasonable reasoning.

> Reported-by: "Randall S. Becker" <rsbecker@nexbridge.com>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  reftable/basics.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/reftable/basics.h b/reftable/basics.h
> index d8888c1262..7d22f96261 100644
> --- a/reftable/basics.h
> +++ b/reftable/basics.h
> @@ -16,7 +16,11 @@
>  #include "system.h"
>  #include "reftable-basics.h"
>  
> +#ifdef __GNUC__
>  #define REFTABLE_UNUSED __attribute__((__unused__))
> +#else
> +#define REFTABLE_UNUSED
> +#endif

Corresponding definition we use in the main part of the project
defined in compat/posix.h looks like this:

        #if GIT_GNUC_PREREQ(4, 5)
        #define UNUSED __attribute__((unused)) \
                __attribute__((deprecated ("parameter declared as UNUSED")))
        #elif defined(__GNUC__)
        #define UNUSED __attribute__((unused)) \
                __attribute__((deprecated))
        #else
        #define UNUSED
        #endif

GCC 4.5 or older may no longer be relevant, in which case yours may
be good enough.

Will queue.  Thanks.
