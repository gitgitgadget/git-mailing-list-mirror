Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FF74825B2
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044678; cv=none; b=rrOgbLxdviLkpHEes42mXTrcBIeftMpP1UpmyrVrEcexdGsxtox+dDlS6ScyovR/ZZSi2z2yHoeK738IsJ/uU30Kgcdfxbe1ytRUKhcpyAJJWk6+co3Dq3yE6bXzyMC2TkYQRaMEubor+xSpSTARVXTFro+4sWgwHofZmaklKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044678; c=relaxed/simple;
	bh=A9dPsakkXd8Lt0o3Hw3gThK+y6fua+JB5qHNecJaUoE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OnzKaVCQSlPAmsr7kM3l4DC8F5mFySDbzZr++ekrrJ8+J9LRV492MXKzIwISMmbslHdjgwkRuBuBjilSEpzT8ZUY666qQUmFyipOumrPExiKPxnDyTAGVNv5r97rB5go/IDi6yYvv5JsmYp/lltTrm+68+E/O2wM5TKwv6gwDeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Km85ruVa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M64s+g4m; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Km85ruVa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M64s+g4m"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6476B14000AE;
	Thu, 10 Sep 2026 08:51:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 10 Sep 2026 08:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789044676; x=1789131076; bh=pI94///DJ1
	EmT1TjO+Aq82ROdtwlQiMpSaMvhZFrkGE=; b=Km85ruVaf9kb0HiQaIejKiDUUS
	BvP/Ot6bX7jw05IregO7JCdVvyuBYTvlKWdkUDuMBggpVkOS6mY6FL+otmPAb/fu
	4eHVrIFXD8JLvcVztADb5pkvMESDkZMUUc0gAiOVvwNwvFr72p+50dab22yjUS2C
	rbNXCPWPEETcVhnwskNyKgTq+OIawAfTyf7xVu39ybA+qfvvsycqumRGufBGmehG
	3FGgQA5kqpIkcvTPA4GRJFcSL9koGCqWpartcl0VMm6f1ZSKAMNjoGExJoasbaMx
	8PF9RmWIGyGIY8KpgBYdB3r2ljfOS+hu1IQPoQ8+0nENw8NW6W4Mr62SJhQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789044676; x=1789131076; bh=pI94///DJ1EmT1TjO+Aq82ROdtwlQiMpSaM
	vhZFrkGE=; b=M64s+g4mpTYt95IGb8I76QOsD1301qhdxbDHj5mvYdQ3W9m3xRV
	otvP/sItQeX+J1F5dL08JaBwWCLXEA7RCuFPkzZbUTRe/Ja6llLrFh1tgqMFgzmR
	PD85KGPZyz66IKEnHeLIP6Hua9Bp7fY8d9yf13jqKnAkQeIs2wK3Clc8bt/O9Exu
	fbq54r9M5Frvg3clugRD2AD+rJEt0wc37LcV3RzUQ0iTXOcp7wo1ZNJvFqyeVqXs
	JKVXVEGWxW/RiLy6RO70dBhVof4+GA7cQzkq+pXenIZPX5vYZcQ2KTEh9PTYAYRo
	Welc0us/nYSAAGV/4VubTXpHytAOzGmH65Q==
X-ME-Sender: <xms:xKeiaihGW-Jkbd9bd280VQWTqw4f1EpqdYkz94LUPcBImpziqNY3uw>
    <xme:xKeiap618dlSXji73D5GsoMORoL8h9y0dAC_R4hxfZ5kX-iynNxEJRPj-um8UFskH
    TRQo4IzYd9mC0hqkEraNJqW-ENl2J8Li6xT2-rMXmo7LhX96apP3Q>
X-ME-Received: <xmr:xKeiaibb0AmQLmWycQbGbXOX5DeRLiMSzrg7f6amq4HsV3_kwDP24HrYpoHo3XBcO7FgFBZ5h29ZSvCNx1fs83Re-AozTHnTusRl>
X-ME-Proxy-Cause: dmFkZTGAdFlFRa8UMtXDJeUFA77FuuXy92uK0F3XCwylZXFC4q2+h5LEHydRIQQqXvsnfp
    S4yc62NQG0bzWJCCiWrC7khs1nOG6/nTJWRGj6DNUrC41PtoKrJaajEzXJs+wJV/6/Zsxm
    cZhyxcXPjgEBiHi7pzAtye1kkxzj4jw6uLRggDE7kaJDPba5Gx5uevXMUE9qfBzN+VM61Q
    vq5Mwh5/hkvt3KPbN5KqMx0p4V5bRWtdLSlWMA/J5NkvuSLaRLluSnVhi2N127MTuoCk6A
    DqcikTrn7vu4/2dPiJJ1EBgo69HHtojfDaaoJaJNpLehj41XxP0PcvqDTNvfK4OXXrHuWF
    nSRxUCqrzeXQTGjDpoSpsqF03BDrxNooFkPb9nyXoocO56vXxlDEKDsxgN0LRxW/GGspUu
    CGLp9pIkSeeSWwVabvY+WwPLkK6Z0dKCrzn5+pcAphw1wdRtBpeiyfxevfbC2mxK5461cv
    wXxJKE1L6LUqKinWVdsn0ZT+0cgnCHa23bIigUUyPGQVvsUUWsY/ulhsjiuGzukUUb/Twe
    1TxbcC+9YddOIUDG5yVIvrV5u3YJTP/em0hMRjkia8hQkSJVI4oYIbKqQTCeTT9SCME+XC
    5F03SiD8+NHGaA52En/L7jrfLVzF4Sz+mIdqqFEpaH700oQyMzw1wVvQ7Ngw
X-ME-Proxy: <xmx:xKeiam6delNzsD51xHFPzttod7yd0YI_qdp9M0jF1zMGEgi1WEY-7g>
    <xmx:xKeiatCYI2-2rFcnrG0N778IUc_Hs8NN3wmqP1EdwHRapDW9vYf5cQ>
    <xmx:xKeiakdKL5GeO2vwUIJEYvFmdDLJuzmw5MgAA7xrJdHbCjwir28Jcw>
    <xmx:xKeiakKyi6_ykNHQm5ScgnRPMfchV_uM2jiQ9hm7p2WEPB1fJ137vA>
    <xmx:xKeialuZNUuj9zOWW_7BNRyND7Pkhk8xCOQgGvdkMa31jVGRbnFxUFFi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 08:51:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 00/13] Upstream some more Git for Windows' patches
In-Reply-To: <pull.2195.v4.git.1789020327.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Thu, 10 Sep 2026 06:05:14
	+0000")
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
Date: Thu, 10 Sep 2026 05:51:14 -0700
Message-ID: <xmqqbja5gth9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Originally, I noticed that these patches had not been upstreamed yet when
> rebasing a Git for Windows commit to enable Rust in Windows CI.
>
> Changes since v3:
>
>  * Reinstated the fly-by style fix as a separate commit.
>  * Added Helped-by trailers
>  * Moved and reworded a paragraph from the commit message of 08/12 to 12/12;
>    This should have been done as part of v2.

Having a reroll by the author makes my life easier ;-) Will replace,
and with J6t's earlier blessing, we can mark it for 'next'.

Thanks, both.
