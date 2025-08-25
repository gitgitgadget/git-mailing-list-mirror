Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B4E1E89C
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756155477; cv=none; b=HN6hcmb2cQW55Pq/L9V0ls72B9t1buhj/MXty+lBMiIqTxOBXBZPCcqJPU/F/R39KSuSbCpWQAQ3Fk4vbtwd9ICFMGSt1h/b7H5/e8Zy8ry+VsB2+YkTG0YkrYUEDaDZcS412Hs13xjQyOwpMFFXt+yurF49k4rC90TMW22911o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756155477; c=relaxed/simple;
	bh=T7gYDUM+4eV6T3JeV/4iDP/x+rh5VDc3UzhTlYrOSQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NDCFsrqciSdfcbIc+2yx0XIuwfywP1fICFlUdJS1NMJ3XB0Q3/yQsuoKE08GZgvn1X867NkhTKqhXD5hidWBfgtrfX41Rrb41pCPqtfkyAfgtqcjCMqLJMj0SpW0S9jGxGLANSLhH45aklQklu4TB34y7h2zK6M3z83+9su73z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LIyO9Gyl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hhef2H2d; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LIyO9Gyl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hhef2H2d"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA01D14001A2;
	Mon, 25 Aug 2025 16:57:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 25 Aug 2025 16:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756155474;
	 x=1756241874; bh=T8fWN51hxoSjOKUgmBtnynHD9l2PXTz7Rvtv/gRe1gQ=; b=
	LIyO9Gyl6Ye+1BuyuhbQrYpCylbwRlf0UnoMBXKVGlsVaiRFkLaD0/y6bZjft2tk
	ZvOmHBcJ+5yBv+np+/v3ZQMYBG3nwuaTtD+dn6mxBb3VFMkJaj/Izz3zhVX51/qa
	yFpdlVSXvFyxUpZTU8YO2ie/eZPJ4jeEuWjh3KeWxAPOrqYbNxTaL5ehIp64xY22
	UWHjwsSxIhK9aCigsh/LCSdOhfR37GPMhTL3Ykq5V3dyLGGyWGH/jbj1KhkverRn
	amvF2AA0hNbVwMQQgO46jYvxZdNRhPVrzhwX8Mlgf0ihq6P3x8yYefGRCcQI2Hvi
	9V7uu+Z74qV/hcV8sgK7IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756155474; x=
	1756241874; bh=T8fWN51hxoSjOKUgmBtnynHD9l2PXTz7Rvtv/gRe1gQ=; b=H
	hef2H2dt1xtmONT3+A/D9OvnJMK4i7UE9lhDRej3cKpwzoE5MGrtJT92/lwlmA6Z
	R7tvr/2h+ZUlBHjCTZfFpCzlYBG8UCbDomIsqHa/98qBRocr/dCDQc7uuBYQUIGi
	9lYZoBomfqv9M46wgpi6bfoRJR5PK/GtZV+5NcU7IcNeGq7Q+HL4WsSUKEEF2+PY
	PD8/zcO6HooG2Ixc+ZUPFkbbZO2PJN2NnmBA1TBl4T99MxrX7Zo1N+MfZej0Sbe0
	cteSMci4ctjdt0m74mt67NX8cbXWWaeBAaRkZA79xcIvW9LRXoJvVlcpRhAtCp8o
	i42mt+E0yh8SuGCkGyFIA==
X-ME-Sender: <xms:Us6saP5dA9ySLPXLF2fMTUmGd4DJ4r6I6FXFa7TgnME-xjlC-YHIJA>
    <xme:Us6saIJBh9KXEgN2xr9XrC_KarZ0id8faO188-hdAimLbT1fZr_R4qhmCiCwlMtT3
    dq9kH-p1TI77oQvdA>
X-ME-Received: <xmr:Us6saP4zFDHK1zKXOgB-wB12yp_yFAr5M7qjo0Rj4c6JlfTxnR63VMMpqsRKdA81m0HxpErxIaLvm3VEuKHrvWtytTLYCphpn7VnyBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeefgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshiivggu
    vghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Us6saLzS2ahvnd258UCsJkJg64TtXW3kqo7JncbmNAvvlKcDJTd1AA>
    <xmx:Us6saDYj9e_ee0RxcAZqoPqL_kumjVjGUHE9GqaCtXdnRXwZL0lb2A>
    <xmx:Us6saNSLnSBiAlYf-lautCgOqIcOZXQnm0RQ2CkBk68hQHlFKPXSvA>
    <xmx:Us6saNzBU5GLODJY1GDHlY6-Sm7wDd0E1SRWCMEYkTGQldUg4-vSrA>
    <xmx:Us6saIzsiaUs4btaI5yrJ1nkYz3s3L41nyiD3cvYrTiy4jdHqnTl8S-v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 16:57:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] line-log: simplify condition checking for merge
 commits
In-Reply-To: <20250824190644.2573279-5-szeder.dev@gmail.com> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Sun, 24 Aug 2025 21:06:44 +0200")
References: <20250824190644.2573279-1-szeder.dev@gmail.com>
	<20250824190644.2573279-5-szeder.dev@gmail.com>
Date: Mon, 25 Aug 2025 13:57:52 -0700
Message-ID: <xmqq4itvp19r.fsf@gitster.g>
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

> In process_ranges_arbitrary_commit() the condition deciding whether
> the given commit is not a merge, i.e. that it doesn't have more than
> one parent, is head-scratchingly backwards, flip it.

Hmph, the condition is about "is it a root commit?  or is it a
single-parent commit?", which does not sound overly complicated to
me.

> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  line-log.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/line-log.c b/line-log.c
> index 71fa857ee8..188d387d40 100644
> --- a/line-log.c
> +++ b/line-log.c
> @@ -1273,10 +1273,10 @@ int line_log_process_ranges_arbitrary_commit(struct rev_info *rev, struct commit
>  			struct line_log_data *prange = line_log_data_copy(range);
>  			add_line_range(rev, commit->parents->item, prange);
>  			clear_commit_line_range(rev, commit);
> -		} else if (!commit->parents || !commit->parents->next)
> -			changed = process_ranges_ordinary_commit(rev, commit, range);
> -		else
> +		} else if (commit->parents && commit->parents->next)
>  			changed = process_ranges_merge_commit(rev, commit, range);
> +		else
> +			changed = process_ranges_ordinary_commit(rev, commit, range);
>  	}
>  
>  	if (!changed)
