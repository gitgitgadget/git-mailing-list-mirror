Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009862D4B6D
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702180; cv=none; b=heLhoYjBSDJ9e8xoVfF1hsJz4aZLLtnYvma09341yKNakKmTJimcGcxv3ggifeRsctMLIsUzN3MsIFXG6pGPyhAV+h90yMipyvUBifZzvd/BMU6VFUdyEYMAO3j/h6UOwcl0FoCT5eutWteKE1sGCg0JAUZOv57slBZ4dgx6hM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702180; c=relaxed/simple;
	bh=n47dER7LrZlMIKabAVUlWrmEUMaBi6Mln/bfaPyWwpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CfGac0ysRlo+uVQARqmd4YY//6BaS1QtX6kyCkVcQgnOJalPca4Axa1qQ6lws7G2ft9DfmItPxbqRShQ2LV//F7EEQqE5Xs+KIzEWPc/1R2DBMLtP1xF0eKNdYOvuJZItLyF/Deo1uRSzS2Eq5VY0JnqpL72E1P2ycPUM9V9tig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sWthlKU5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eCn6bEB4; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sWthlKU5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eCn6bEB4"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 14CC81140182;
	Mon, 23 Jun 2025 14:09:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 23 Jun 2025 14:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750702177; x=1750788577; bh=LLy9W6rUbs
	2A2YaoD35EtBS0Ns4VHma6wcCnM3WcZaE=; b=sWthlKU5rvBQgyWKgjqFemCZAz
	1t3yaKqdNrAFbDDkvDULByXrmZCnMCZQFUVAh62CSsY8qRVQcxDBu5NR2fOluLfM
	NYYYok97QA2sBMN23NrbEL/k5yMQ4m0OZskcIosWLkgQJPYoDjAEL2PabZ9sEeum
	GBQXQArtstXgrPbVhEREuLKx3Qj12Q4bhBBn6mea5RM4ysV738Zdc6qYgb+Sib47
	msN0/IXj9nM9e6TA1F2UqD9ReTwcv3SV37wU9RFom3R4ykMtzL9Tgz3zAqWgtNWS
	rslptCwzIAIh0sq/1Cped86U6YIiwnyB03P6fXk+d7dc9Rd9pbHwa39RIZ+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750702177; x=1750788577; bh=LLy9W6rUbs2A2YaoD35EtBS0Ns4VHma6wcC
	nM3WcZaE=; b=eCn6bEB4xq0Miczo1Uj6SmAPWBwR8vt+N80/Y/vOxKO8qvpqxpa
	VdN8I7cI0kK/yzQjct2h/afbln+WzBgZLT/IUN9YtaMuFQLXu7PC3/aBfIXyQP3n
	zaQq5mhz2OhR/bkpHCFJIIcG228y+eLspA7Loszjc0UdBnNH/D4SVCR7gvXw/WUq
	G0KxIRJSe3vyiuhm5vhhDtQXuSZHPRcGUkXLp/NVOChbeA2wdSsaFu7ldFzFFhoW
	XEtnurAuwt5vSLxguCO48ZCCHNwUgKR8M+cZGfl8X/uUlesz6SuiE3AghBUzcKCI
	Gl11CKqnrG3TcuApzHeuiP1zDM06rFq/LBQ==
X-ME-Sender: <xms:YJhZaJM99H8C4xwvE5tJWfogAXw48tiAnJqUfrOwFKWHYLO9sZND7A>
    <xme:YJhZaL9lym-2gTyw7F9opQnAdu0DjeUNgkgz99LoNqdNPy1KsE5yM63kJFAbGObBs
    m5dKrJkxuzBSd_3jQ>
X-ME-Received: <xmr:YJhZaIREC9Za6IUNyTqrro_y4TXJsl4LG5qivqyEkFsMqgaCsruVkb_zMxdEvRk8973ItMBeWQIXWiEnJ-tWGl96UhltINj-r1xgCps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddujeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvrhhitghk
    rdifihhllhhirghmrdhmohhrrggvshesghhmrghilhdrtghomhdprhgtphhtthhopehjie
    htsehkuggsghdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YJhZaFsw7igeK8uzerQAp7CWLo4mwc2mUGPmasHMaMBqmmQm5RGPqg>
    <xmx:YJhZaBcdBCdpIg4xhlSzaqFfY85E5WtPRg4qFeTnKxn4w1d4ofMZig>
    <xmx:YJhZaB2p_ZKuSL-7v2wjpArgLIErQ_sXPMiUxpW2eYhGHh93GUkkSA>
    <xmx:YJhZaN-gSvtCyA0XUchFIucsoasC7_KPV1JfOsZzeQRLaOKuGa-JIA>
    <xmx:YZhZaLzlZl8m8TJOaYMzYpEjLi41tZBwmx7S-rDM90mC68GvSlEiv47B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 14:09:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derick W. de M. Frias" <derick.william.moraes@gmail.com>
Cc: j6t@kdbg.org,  git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] userdiff: add javascript diff driver
In-Reply-To: <20250623090538.154858-2-derick.william.moraes@gmail.com> (Derick
	W. de M. Frias's message of "Mon, 23 Jun 2025 03:35:46 -0300")
References: <4deb24c2-98f2-40f8-b50c-c74485ebc10d@kdbg.org>
	<20250623090538.154858-1-derick.william.moraes@gmail.com>
	<20250623090538.154858-2-derick.william.moraes@gmail.com>
Date: Mon, 23 Jun 2025 11:09:35 -0700
Message-ID: <xmqqcyau5nz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derick W. de M. Frias" <derick.william.moraes@gmail.com> writes:

> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -238,33 +238,43 @@ PATTERNS("java",
>  	 "|[-+*/<>%&^|=!]="
>  	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
>  PATTERNS("javascript",
> -     /* conventional named functions */
> -     "^[ \t]*(async[ \t]+)?function[ \t]*\\*?[ \t]*([$_a-zA-Z][$_a-zA-Z0-9]*)[ \t]*\\(.*$|"

Curious to see that anything needs to be removed from "javascript"
section, when we do not have any patterns for the language in the
file.  Which version of Git is this patch meant to apply to?
