Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05591A680A
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773946877; cv=none; b=Z6XzI5+bPBmq41KaTF+IvnYyKQZs6JPW7zwLy7YZU/kzC6ollur76T35tu0uikS1pYmuYF9f0WEuyLWghhA49/VhTiP01Nuhydh35AMDz5jvJCb9rIFeazUZDCe1TcraPgf2zxHAlnTWmgfsPcm+RN6Obmp4jTGHqFqtj7zcsOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773946877; c=relaxed/simple;
	bh=IGUJKSDY/ohLR7BUDfBEoV8RrBnlwA9sPMNQ6hmg5ag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g6lBknjRPsbfk4DQs7f9CAUkkapsSxAD4pGN/4aFaBYIeJmy5YXXI4Gn4xCR/jYkKqAgR1OEqLGmeVC0RN0lQVsn2VsvakunQDaOP1bTIvdnCPx2Lnr/wmCiUpo7LDMB0/tHiuytNEGzcQZhvhNtCnUfsow7TJiuPNI5g/qaNtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f5Ovzh7T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=okDIl5LX; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f5Ovzh7T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="okDIl5LX"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3747B7A021C;
	Thu, 19 Mar 2026 15:01:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 19 Mar 2026 15:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773946874;
	 x=1774033274; bh=XpQ/3HbxIWUw76uiT56DkXcEh/ixsL2UcvCl/52eeXk=; b=
	f5Ovzh7TUz4wKaiLsTiIKCvp9QkkeH9Pia28TxLDKaL6fHc9BrGCwc+OZrse5cGe
	XoRKYlpo1p2zYXO29JpHba5Fa/333hGfU/hfv34RWnM3FkK/EUJS3sP6OEBd5mOQ
	p/TnlTSHMTRYedtuoe4B6x8JIKkPJUg7/xkbcPep7jonMh09fGzBj7gglmtgyjCP
	bAcyyvgd/pQQwc1lw4nV2VFwJvC4zzUgg4+Eh7cCtpBwX4V7BNb02Jr0nXPXTsu0
	fDqakcO9ko28fsgQlfz9RRCHIjc9Ng6SdCiWOoqlpadykN71esxSedbB50ic8OZS
	vZRl8iIwMulKlPEqDrEWWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773946874; x=
	1774033274; bh=XpQ/3HbxIWUw76uiT56DkXcEh/ixsL2UcvCl/52eeXk=; b=o
	kDIl5LXCHMvoLPyLQKHyxhH3GxO59Y3t2CGMiWUo57Col27I7zpgsMjdPC/NC3h9
	pajB3/pwjec+9KpVirKZku4OwZUWaH/3MxQ5ulfdqP8ozfGAvWd0Hk24smAizfYY
	jPII7FmfkhgZRhcyujTf8YoCoP73F7eCaSJx69nJsXsHmpXYxWRp1ZwFcfgv1ivt
	qbg3EsA30YvfnS5D66McmRBrSG4MgBiO9kK5CjXyIDm3UxL9avdpw9KWphNBRxQZ
	HlSUgaplUTZSZwjoauxAyfrvHiPQ7b4QfYFxSxXqr5R3Nu5Q1XwV0NHHIXNy6+E6
	AKAxGz2fSd9N7hdkweHSQ==
X-ME-Sender: <xms:-ke8af1qlJPVmAbAKtAyRgYhw9VSD0IVgQxBDxMwzyhqhhsP2KMKPA>
    <xme:-ke8aVjTXufcwx_v4-1onn675z47bOGIPh4eNYQZwgZYqyTVpaVMQ5G8cF5oSfamZ
    gRIObgTmcj0zpOCsNx6j5rhsp1DRA582l2AHV1GHka4WcwW_MffDw>
X-ME-Received: <xmr:-ke8adQU3w6LK6PV9Wl3QfQB0bbsyAlTD8FNavlntvNoyou4nhIJV8kZhrFQRf--4djjsypldj0k5e7eUAUryPdA6J8sdWGvwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-ke8aejZ7LUx2dVbgKndpsnNYXvhGDnV6iBkG54rQ9FGZ13cJLlExw>
    <xmx:-ke8aV6z4L22D8VOLRfoxxMGzwJqGDVIQcHP4mtEpznSadTuGY7PdA>
    <xmx:-ke8aTBUDKMvaTTtJd7E7RTJpL8u4KX1JCwM4t8NgGi0aHGFnRPmbw>
    <xmx:-ke8aUYC9in7akE1WuQyf4AksQwMxqc9Q8PSathjln4Gnp1_xt3k9A>
    <xmx:-ke8abIlKkJVTj8vH1072cIftj0dcE_xYgZU1Vyp_7ATVpngVX8BOYgO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 15:01:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] split-index: stop using the_repository and the_hash_algo
In-Reply-To: <944c2331-4dec-4c98-9059-f41dc204ed86@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Thu, 19 Mar 2026 19:48:07 +0100")
References: <944c2331-4dec-4c98-9059-f41dc204ed86@web.de>
Date: Thu, 19 Mar 2026 12:01:13 -0700
Message-ID: <xmqqqzpfk5ja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Reference the hash algorithm of the passed-in index throughout the code.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Low-hanging fruit..

Indeed.

>
>  split-index.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/split-index.c b/split-index.c
> index 4c74c4adda..6ba210738c 100644
> --- a/split-index.c
> +++ b/split-index.c
> @@ -1,4 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
>  #define DISABLE_SIGN_COMPARE_WARNINGS
>  
>  #include "git-compat-util.h"
> @@ -6,6 +5,7 @@
>  #include "hash.h"
>  #include "mem-pool.h"
>  #include "read-cache-ll.h"
> +#include "repository.h"
>  #include "split-index.h"
>  #include "strbuf.h"
>  #include "ewah/ewok.h"
> @@ -25,16 +25,17 @@ struct split_index *init_split_index(struct index_state *istate)
>  int read_link_extension(struct index_state *istate,
>  			 const void *data_, unsigned long sz)
>  {
> +	const struct git_hash_algo *algo = istate->repo->hash_algo;
>  	const unsigned char *data = data_;
>  	struct split_index *si;
>  	int ret;
>  
> -	if (sz < the_hash_algo->rawsz)
> +	if (sz < algo->rawsz)
>  		return error("corrupt link extension (too short)");
>  	si = init_split_index(istate);
> -	oidread(&si->base_oid, data, the_repository->hash_algo);
> -	data += the_hash_algo->rawsz;
> -	sz -= the_hash_algo->rawsz;
> +	oidread(&si->base_oid, data, algo);
> +	data += algo->rawsz;
> +	sz -= algo->rawsz;
>  	if (!sz)
>  		return 0;
>  	si->delete_bitmap = ewah_new();
> @@ -56,7 +57,7 @@ int write_link_extension(struct strbuf *sb,
>  			 struct index_state *istate)
>  {
>  	struct split_index *si = istate->split_index;
> -	strbuf_add(sb, si->base_oid.hash, the_hash_algo->rawsz);
> +	strbuf_add(sb, si->base_oid.hash, istate->repo->hash_algo->rawsz);
>  	if (!si->delete_bitmap && !si->replace_bitmap)
>  		return 0;
>  	ewah_serialize_strbuf(si->delete_bitmap, sb);
