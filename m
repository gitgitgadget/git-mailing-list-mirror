Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931993B6359
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 03:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784086486; cv=none; b=Zm2XtlWfKdqEfMnqxGHT4DkWGLJpIBmSyS9s6x6gUujorT7+j0Y7yQRi33Fq4te+merEhRQFqrfnLDSdyQPDfSOQZaniQzpWYHQs5/sp2oRiJbPMLgI3GLImgB49gkie+TpCDlZOgCl4swocUHyQwyGwxpN/w0DvFDJrhjJqFwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784086486; c=relaxed/simple;
	bh=D1YKYY2MJ7Q/n//h91ofZd3ZBneqtIvgFW/HEiU2gBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l+KPbo2oW8Z6CWGWWNog4ha6+9WZ8dvqZCzo/QRNM3nWjO2X3abLGS3Xbuy0vl7kkZByoNJTqJoxJTzlrRAdIfTx6a0EOy/q7mYyEshZh9o4wXTZFKIUrNs4CnjSKMWweT7VSlc+V2LyTOETEWnRUQ3AnJ3qo2PAeDyuOual9Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZjlqD8iP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XADMMnrn; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZjlqD8iP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XADMMnrn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E66C91D0018C;
	Tue, 14 Jul 2026 23:34:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 14 Jul 2026 23:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784086450; x=1784172850; bh=Bi5prdebVQ
	bZMzj+h5c7OxqAKGWZydEa4ct0auoaSl8=; b=ZjlqD8iPOcUHgSMNtxh0f6QTCH
	9ftKaRme0weFRdyVuKEmL4CP6BlfpY41sZgxlPcQlLC+9E+WZcnpMVTeaE10IznQ
	K4TTBzjK9huWQ72AmE7xTd/CxAIzeuHxVLwfW44h2NavYBz7KrUaGBqXqZFSMYpF
	gXKtMWAmvecyQTgQVcdkavgRQckNao8D98jfjCC42P7ZOtdUV5ps4mj/aIkVkh+a
	p7W5dh1/HXyHFhxRF9M3kZH7P92cSIpLeG3eUaPVKg4WiEqSBbzN/TLPZczbi2C3
	t3d7Lzv8b52G8lYkgmexOUSr43yb6Eup/MOTwnOj+YYo9fe2W3ivR3nZD0rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784086450; x=1784172850; bh=Bi5prdebVQbZMzj+h5c7OxqAKGWZydEa4ct
	0auoaSl8=; b=XADMMnrnnHCZGwyVRawjwljxG0pVZ/Qo9lLcEPMkQ5C1jpilR71
	QX7KAKHQtiaBaoz08bo21Tev3pS+Uczms6cAh1xLyywawud+ycGKvPNf9UaoXspB
	815ZkQD2oUzkHwTWvHSkh+yMa5LSgzvUcajT4wxD/w4pnbVKudiWSVNBQCph/dYR
	Zu8ePCAG2DSAKcQsVJUBcWW2helVs9OCYLeW2+LmPE7Bc2RZ2cl56peaD9h+hl2Q
	EyAEkyoOSExCcDdR5uBKqgwzDJJ7EGQQXXDJ6F3Fv5+pGtk9ys4EnwHPfkjm7YCD
	n9qXEks8Uis6Z9BZF+wXAB60ujWOx/TAu9A==
X-ME-Sender: <xms:sv9WamxscYUMmIoRd-C8y_kCfuGjyqSmQsP9KHSRnHSsj_4MKc5N6g>
    <xme:sv9WapspFgbhbbMUTXqQ3RNFkUDp3VYYVMf1wy5DWC2FPNWKWEB6MGI_q25amCwNn
    4dopCkR6pvrEkpTA4GkxMSMXs8utx548kT9oF1cON_2Ef-zwuhJ>
X-ME-Received: <xmr:sv9WalsBM3ohw-BWm9vUeVesdsyOcVt6-PNmY-PX176HmFhLf2uQe5wVho2uSreiAceGuc0RebfAXReBqkORCKo6jeC3d62DMWMO_aM>
X-ME-Proxy-Cause: dmFkZTF1fXVasC9XrxyX2O8MpSzggKxsZuzG6OUoVxVosqgZhvDXecFg0MmuKk8TZOiAId
    exN+ERzFUKMeByndECbpGAYIgZh9i34auPjt86BaPfIcFeTik4ee+vYbdIYyeb9J72UMsI
    YN4tWbjm5O0bFGh47f2blyGlqSFg4qvO9fnJ90v/q39aTUnf/nybWER2WlG6Tg5o6969Hh
    a5D3Z1Di/B+MX2tBWxH3RkKENZWgPGiIQ1+QI25mqmUKo4c8aKD1m1145w0tSV3gauGqqh
    ocH8KjAJnwwicoZF3FD3uFOfw9f9dTSGaXglUNj+X9G7YOuoWHgscpkDjf+4A4C66SNmJo
    nzS5TDAxgz0CaSxmgWKMm6/hU6ToAPeazomptM2pLtgFp79PAlDpcHsM0hf4tl0I5PoCb4
    nGtZXTu94uUhurTHLm1ZTTh94n6Q9LXawd/Z8HxUgEhMY3QCyXsYBzE+vl7RLF+WnPo2eO
    FmLT0S0FR5BNxvY47vAnMZq7CBFjsVfT/aMiEEhnnOyoRuCmu7nHHhDxabo0g4dAmmlnug
    bH2VTVu/NHnUpmBCRyTOe74NwnB5JPhGzeBl3qK5x5Fj9GkFOT7OYRX4yWi5b7Y3k+UNQY
    1dVXcPoCKZxaChuxy3+UHbO+0f1OZGGgLZyj0Eog20yZla/afSI9Hycx1T4w
X-ME-Proxy: <xmx:sv9WamPZne2de0O7lb4ach_sfsY5AbyclNWtcFApNTtk8S2ZJaYHYQ>
    <xmx:sv9War38KanIVM7FoexGpv1YUGqwCTo00o9Cd6mRx6mrO9LJJnUHNQ>
    <xmx:sv9WaqPrv65ODXGtx_WBKJOhWufASsI_sE9qUg2XqyXUScqrS7OgYA>
    <xmx:sv9Waj3Qgtf5Ew3JF8uAJFHOq2waK8i34RGSm8NVl_-iOcP__JkC3w>
    <xmx:sv9WapvDgoHQyFY5mNrW9sOzF39ZVkxHTFPVo5sQI6SRhgv9Q4LY-jTM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 23:34:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] show-branch: convert per-branch flags to commit-slab
In-Reply-To: <20260715015158.48559-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Wed, 15 Jul 2026 07:17:22 +0530")
References: <20260714220042.GC4095533@coredump.intra.peff.net>
	<20260715015158.48559-1-gatlavishweshwarreddy26@gmail.com>
Date: Tue, 14 Jul 2026 20:34:09 -0700
Message-ID: <xmqq1pd5q632.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com> writes:

> +static int show_independent(struct commit **rev, int num_rev)
>  {
>  	int i;
>
>  	for (i = 0; i < num_rev; i++) {
>  		struct commit *commit = rev[i];
> -		unsigned int flag = rev_mask[i];
> -
> -		if (commit->object.flags == flag)
> +		if (test_rev_flag_bit(commit, i))
>  			puts(oid_to_hex(&commit->object.oid));
>  		commit->object.flags |= UNINTERESTING;
>  	}

These two perform different actions, do they not?  The original code
insists that the commit is reachable from only one tip (i.e., that
the commit's flag word has only a single bit set, corresponding to
the i-th revision).  This is why the implementation does not use:

		if (commit->object.flags & flag)

By contrast, the updated version merely checks whether the bit for
the i-th revision is set, without verifying that all other bits are
cleared.

Or am I misreading the patch?

Thanks.
