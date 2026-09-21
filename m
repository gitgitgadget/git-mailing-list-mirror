Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0314B827E
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003465; cv=none; b=TFXwpGsPMgFj8fCKHOcyqf1K8VIbsTPGwYDBi9lQkfM/7A9Z//k/ibfNaEmJIFS0fm6yeLYi3AVGOxVw61CcToDitVoxI6rtjCxy8NlgESfuNDpBV0yWbniJym6wKESTNMhPo5tV8W91zTpB4ANoUMu9FfVole4oNbfNCtCKtJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003465; c=relaxed/simple;
	bh=P7Gza/Q3m2eMnKuzAyQ+Z4YQyUZlnpXvFqygcfQtnTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=os5cDZeI32NNelVvjSMrN2qCtp1nJBO5h7TuZz2CWdapSjZVtXu4TJ5eE4U48iHF92y2N9I3joxxTlzl21FBnhAHX+tGRB3HXblgx+Z4tByxQZo6WT2k9vgoWIlMUittV2Xl+iemjrHDOrCi7CZgXY3htRPxQw4JrVmab6FyKfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=t65cMHuA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LtMdJlFe; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="t65cMHuA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LtMdJlFe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8678814000F4;
	Mon, 21 Sep 2026 11:10:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 21 Sep 2026 11:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790003458; x=1790089858; bh=zLcKeCLZCs
	hu6k5WHO8N8m3ObdFMTvFc9KPzFzSD4c0=; b=t65cMHuAtn0wRUL/VLctnh0Af3
	UgAPEuGWOYXhKYN9pWHij/k+d3+8pTEDMdKyFDWJFCTQJXO3BzRNaIWwKSD0dzF/
	eGR4GrOqZpxt6gg5Va4nOGOJILuQdS3lBFSledcXlS+cMo9YJK5MI5AndNU8jKSq
	cXhOR3rIK/5qVEEmJEbgG2U2d5i1Gfi9Psht1/ztZayz8QMYJf3OfM4yjKXJJnPZ
	lL8jgGVp25JroE4nNjZU174tLoPwO01tjLcP8Z6mwi8H1pMHH3gpsDtn7sibpF3E
	rsxOiz0ECtwnISptFwSNh+UGrasBrqz1tLuJdXfwr3NKvtxWh7A31o8WiCKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790003458; x=1790089858; bh=zLcKeCLZCshu6k5WHO8N8m3ObdFMTvFc9KP
	zFzSD4c0=; b=LtMdJlFecKLB1bs+Wpn2gvmRkVXZ51pxquvgq9NKB/rJwlPYUyD
	xakvzizI7fO2PYgo0SKk8+5q1wWgnVOcgXNmbFgIoZlrlt3XC60GGp0HF7p7mk2A
	s9huR6Z+OLWmRmLFKSHKYBeKTUTkRuUWRviq4qaqcDN6Lh8+231FdLtASKZjfgeP
	s+hJ5baaqfyUZrm9b4VLzL67VNTI/oLVlouSpsUWD94mh94gN72fXnjUsL4fj4rl
	aRN9dSDgORJ+ANbZ/cdKzrJFkAJFYWzSzcPxHOBknSmVYyOPUfNBhxSVUeAdv1PC
	hI5WpoZN5uwOoKheCQfe7fUOdrxTGdP2Qjg==
X-ME-Sender: <xms:AUmxanwaCg5VoCjbh5gVooebjBy5o6j7hl851mIGKDd8rrCPjqMUGw>
    <xme:AUmxakNk9Q006wOYhhnemzcp-smdUAJfoKuC-puE9GegVary_M3J70RNWomXPRZqA
    mBgyqu-iJVNcqEnYkSZ3ZB2OUBPxn6unPDeZ4bNuX_0e9-itTA5BA>
X-ME-Received: <xmr:AUmxalkS1HIldpImu-px5JJ3EYQZlGL8c7FytLynW7lF8MoS79z1zw4ktksPMUHcOIWVzUz8aKK2CzLXNxFGWVlprnRW3XmdfPgY>
X-ME-Proxy-Cause: dmFkZTEJO/OqH5bdiHf0NvgpUFeF+JapgDS5H1j2miz5ocDGT1SA9F71/UXF/PoI6BidPp
    yeZQVg6nEZS73ARJWhLxaaqCw0UPH4SOrOsE10S3TxG8S6PKZs0x5Mxf+lJvx8w+IiYGEe
    ClTUlRuO3GSDMm95EfCqmTc8KRwM2fv7Iv+8qStD35YPK5twXD9fjsSCxvWCJqvW/rTobN
    x8E9CS5XP7/jQSwAkSRYe90d4GaEgrWU9bGtqh7XwZ53eQfTHIAZHO9/PBz2NPS/37imWS
    DEIknBU8bHiR9SK2cfVoRq+a/uXO/A/SkpOTQEhYTLCoVdTsYoIysJDm3EzZY4JVzSZRl4
    4RZpCmRtMH5T5fJhgSGOWrCofZ4656+d50gI6r1f+eCHfHNxrd/mRmyHD/bTjDXTq/DFR1
    LNl42/fGfoJl2AbxtmoSB4gAZo8cq9juNc6DoBETvluThQwvre9cuTXc1TDTz6za1uwl7U
    psbO+1Dt30Reaw5c7vA/N1ZG8EN+WzbhZVaOMcibK1ccQTnFpeRfScMta6/oehYQ2zEVab
    J17i/FPMr+qC5VdXWDwmI2Z+amT0uxqfB/cljlNJ/X1ZKN9X/aI+zY+CMTzORFVPt1f3mv
    XaI642CA8NIuiFapMQy3HdkJc++jP/B8AX6RSS1SNrMvjeFyCjRbFxfo7DMA
X-ME-Proxy: <xmx:AUmxahR8dZa3Lo3a7j5FMjeTYvYHH6coLfHtDIzmnAXL3beNEEPKcA>
    <xmx:AUmxasXI9iC2nVLetu4PxxGWn0Ps0KMxBIjc7sThcO_sMwsqeMtpcQ>
    <xmx:AUmxatJg3CSHItH38YA0ApidFJm9S3C2dt_LIWI6s49EBhvaLpabYw>
    <xmx:AUmxak0eEILz0myCjiOA4jtF2YZ-O-Bp4UKYYU-TaANj9Zw7iZrhjg>
    <xmx:AkmxakjUZ1kmELwJonso8_y7cUe96442tWBG00OKcEhLdZ2XvIAy26P4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 11:10:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Eli Barzilay <eli@barzilay.org>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Elijah Newren <newren@gmail.com>,  John
 Cai <johncai86@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 1/2] builtin/stash: remove unused header
In-Reply-To: <b6798c8a25993913d2ba13b8f3b08d602364ca44.1789853192.git.ben.knoble@gmail.com>
	(D. Ben Knoble's message of "Sat, 19 Sep 2026 17:26:35 -0400")
References: <cover.1789853192.git.ben.knoble@gmail.com>
	<b6798c8a25993913d2ba13b8f3b08d602364ca44.1789853192.git.ben.knoble@gmail.com>
Date: Mon, 21 Sep 2026 08:10:55 -0700
Message-ID: <xmqqse32od1c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> Clang complains that oid-array.h is unused. Certainly none of the
> oid_array* functions, types, etc., are used, and the


> transitively-included hash.h declarations are used but covered by a
> pre-existing direct #include of hash.h.

Good thing to make sure.

And the correctness of the patch can easily be validated, which
makes this kind of patch no-brainer to accept ;-)

Thanks.

>
> Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
> ---
>  builtin/stash.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 7a9843413b..dfea2d2c4c 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -31,7 +31,6 @@
>  #include "reflog.h"
>  #include "reflog-walk.h"
>  #include "add-interactive.h"
> -#include "oid-array.h"
>  #include "commit.h"
>  
>  #define INCLUDE_ALL_FILES 2
