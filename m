Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B016221721
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782003690; cv=none; b=EhhZEnIV1xu5UBGEPhb6V1wOhoCjWFC5CGC5DO//3oHNDyxPFHKzx1i2EetmZUwpkBO5uyWb3R8sKSgcpGzxiQXzKwfPL2vt5eI5OFYujFDkNI5gL1tqMMWcyXxcPCqc/6ETXuvjhZ4v6h5HJa9ezXiSCmXFK0PjsgcZrdTljOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782003690; c=relaxed/simple;
	bh=yVN0WYDlZnILd9lfFNgG0cyzrRRAX0jVxhp8ZFJOe8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PhLrlusjev3dWEuSx6ZyLxxCFx92S49LLPvKncnMEwcfyxDKQf8Yl0n91xQoC7R+es6SGhAHG5SCeZbObh3hPlTQvA/YCwwlaHpf6GqVhwf7WYled6WE3tFO810gcx7rZuGdSoE2xo7UQOYnuUcGe5GW9YDpkAWe0mN9W2Ohr70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N/fgvws7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NKz2HoFT; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N/fgvws7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NKz2HoFT"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id A0D55EC008D;
	Sat, 20 Jun 2026 21:01:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Sat, 20 Jun 2026 21:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782003687; x=1782090087; bh=uKKs2DfrTg
	nsUQjqZAytYAchEPQO3dT2w9wMAHCn60Y=; b=N/fgvws7R4OHPdUyUhe/RDh15r
	ZqEtxLUGv97MLZhmx728i10OiNsycBT0xAwVnLZLZp/Ae/E/pERhR8inVxlHSF1Z
	rRGG1FpYETmBtSMAt7gE4eJIHsxPyxyCxHyOTLq41A8dAqgQmGS5OjDXqkFGMA1g
	64e+BpgEO38S2khKljpmA+4VMkA0tsMeNluOMjuyn7f3t5bguiOfSb232VhbSVYl
	mKCwfy5H8VoyxL7ct5anQ0QKgsDaRqAaggWWqvWPU97/xuL52pzfxvEK0ITPrvpJ
	wtOu1CHxhyul3/u4NQ0PVZH+RN3sn2MJupIZT0/Z60rzanMJ2Z5dsQ+f+YeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782003687; x=1782090087; bh=uKKs2DfrTgnsUQjqZAytYAchEPQO3dT2w9w
	MAHCn60Y=; b=NKz2HoFTARf2H4T0oXXkKk6U9zLkdZeNoNcj+AKrZlg98qnnDPt
	fk2tYlkTR9QhPQdewW1N5ZqDajxeL9K3PjgypwEMkMi2Rp8sY7fb5HQgDo0xqV99
	HSz6FUt14S6ngJR+XxOlcRqu3GFmiCzaMvLtLLAjTXFtRS/vMXv1sBFtJyu2V152
	xLX+3m2O04IcVhp3yWMnQmVmb4xR9Ctq441CXhL2ixqDEeto1XM3DDIhAZDIbeJ6
	AOZGZXFT30nqX0xTFvtwMdojRXv/UsPToVuXeuEg/wHDVf1So734/NVlXivNsIgu
	oMt+DC0W07IbJVzhRSckLbSltRoMAP8igQw==
X-ME-Sender: <xms:5jc3aswnq8F7PC7g7XgPLJubWOAG8pnR07BOA6viVDEJcWe_laHPNA>
    <xme:5jc3akEOZhu_iCBjb-xZ7Yc50duRL0jsX-3R180874VDzCxutMYjEEhpV0PfZKehO
    VKhoLan0QfQpYi3UXOHsvXL8mLNaaQoiUlqXPka1ElcBEnq0Dpf6yo>
X-ME-Received: <xmr:5jc3anbXey_zsABQKAJCNV7bqzbmvKfJpFt9-PH8AnMNSVQAFeieVt72KheTKzu0R08LuZPfoFBV8KAhdJnZRk4kXCzp2UcMsDruFaE>
X-ME-Proxy-Cause: dmFkZTEzoDPZKUx9I2H8jhYQVni9e/M0etYI90XU0DgdCoGGO2mBtzZEX7mjGurrfKL30O
    Khj1/py+eYx0bNDtborO2bpJYAE8lF5nFGzmKy6Lrn0wyrcGI0oFyPFcaoKa2cfFvkWQsE
    LlrtpbgjJUP7cpQ8mJ80el+GkS1wnM0hioxUlQWKyjYocbymvbUB6WNFsM+ItZy2qDpie1
    qPNF062zTT+5/2LrKBAyF8n87gkU+Pb5yjeu0M0ZUQaUrrNiQFda9TgTPf9AGbYW1mEtiJ
    ZcCesZivPZ7Q4FKtQcHNz9s/ypCpe/37zvbUQVKWVPb9z6zVyy2uN3ZhYgJ/zQFUyg+2qz
    Y+igKOJaGSormjbgbRAalhR/cLSS54lfeDMvikt/Blstq+ZjQSRgYKSTkcLTjeUt36QDnX
    VhJGLfQ63VIYxi2IxPGmvYfYSX72djpJFVbzFa3mlL/et95x9v0EAuNhwkI970OupDysYb
    uys4oiayycIZug7+7J7ovWU5Y6mobpvhMEmBCcqb0BOx50xWCk6uSGTRJqC1ZTP8YcLRBB
    U4Gvf3GOdsZkcp6Jl2zZiCndKRhVxCKC9hZsOMMwlPgTMPZ9Qms/qDKUOY2clHxcQwGS9/
    UknHL79qN9UpkRXB2/QklS4/Qjw6g2cwiPFwR524gnRvmbSLR5Hm7vDQEBaw
X-ME-Proxy: <xmx:5jc3auAc8eOnbO7hK8Vf9g-YTFhkWEoOZVa2hJIByLAPxiT0F0FTug>
    <xmx:5jc3anmGgxpnAkaBRyLubmaNue_IcATGyNkVzNl-lhE6DO-ndk20kg>
    <xmx:5jc3any16e05wStNyIh232-JCrCer4FmtxOKvnYvWmLf-8ahe8YRNA>
    <xmx:5jc3apTLyJChtcYOLiqRraMXDAxFH0IfPqAWT43iFM_lHf1_wRl69w>
    <xmx:5zc3am1o54S5bkmRz1IjwNlEKDra18_IXmUPnw6hl4u1LYi50HjsBYwA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jun 2026 21:01:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,  Patrick
 Steinhardt <ps@pks.im>,  Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
In-Reply-To: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
	(D. Ben Knoble's message of "Sat, 20 Jun 2026 12:00:24 -0400")
References: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
Date: Sat, 20 Jun 2026 18:01:25 -0700
Message-ID: <xmqq5x3cg10a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> Autotools-style builds permit enabling USE_NSEC for cases where that's
> desired; the equivalent knob is missing from meson-based builds.

With or without autoconf, Makefile based build can use USE_NSEC.  It
is a welcome addition to the other side of thw world.  I do not know
if 'meson setup -Dnanosec=true' is a name that is easy to discover,
though.

Will queue.  Thanks.
