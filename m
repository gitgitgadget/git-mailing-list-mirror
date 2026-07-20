Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783802FD1A5
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591380; cv=none; b=NNp77IUxpNx5ZAeDIQmgLuTAkftxr+tzrQJEto/ISNn7PLuXdR9saPbaVcjcY2GaoBMgRr4br+sW8RBu0yUvPEN3GQu1afHlrXWwvWonaXgXdDEEYG75I6pdMKEvFni+EDZXEqIXEHrKqoD6lzDEeWcwVihO7waHWVgfJjgv0WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591380; c=relaxed/simple;
	bh=f11PHHEHFWKWYm+J3qt8R2j1bZP+JQHqO9bkmA2p7qc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kVJ1UIqC7Qe8bIoMCHqfG1WBSIcRMxFQzlumHnxBHn49C9hjmwBhnZxKRTa+LoyCqQlfogTO/vIncPqEBby6Oj/xHGRMiwGQ/ka154oi96Hu5q2yrR4Dls3keU60pULCI7Mqj7SlEzJi3MYpxT5cY4B6EadBDKuvpvSEWKUrJHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RSkSGvLF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nl+LZKQo; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RSkSGvLF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nl+LZKQo"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B0B731D000E3;
	Mon, 20 Jul 2026 19:49:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 20 Jul 2026 19:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784591377; x=1784677777; bh=f11PHHEHFW
	KWYm+J3qt8R2j1bZP+JQHqO9bkmA2p7qc=; b=RSkSGvLF7nn8NoBc7Ez2P+hAeg
	OFMmtwGoRVced8uPWtqrZgqhricvFEF1D5nh6z1Z/Vgc+7bxQjqEC3FKmnUV3Vdr
	ZZuv2sdY8FBBWURaViy6dnX+TPX6tR/9VRO6AhACyAqsYBLD3hK9zBGRXErN4Ka6
	9vcAAvSAzAuPIJzh3TSKfsmvzVyJM1nXhZG83Ts5iKvxJ6obuWqqsyqG8uWBWgYe
	0BMS6aC19hDO8rwu6s56HiQ3rRRPqOhFZ1sA+cnl9Cp1OPGdashoYqmWv3aXyNSB
	f9bq5KFNgBfZsFN+1iUdLx35KjLkapXHt+RiC5vYHD0pA1Z0x6X8rE/pmxFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784591377; x=1784677777; bh=f11PHHEHFWKWYm+J3qt8R2j1bZP+JQHqO9b
	kmA2p7qc=; b=Nl+LZKQoaebyRFpsk/oLyUdFajEJWxb2ph8ygGsXPp6JLfWtfwX
	6CC7NfmIq19G18682uvRrxdOg74xsFID2hTSCghm6Jvd5iYvMUgTEGDJUxwX0wKB
	ZE17ONK7n7QEa+2S3eDzEFLF0dkWGW70piy69A+ouW1hupupjTJIpYIYov3YYpRs
	l1kbTanoqC1M3cZr8iz3Qa5iLPuY2ufbnpGLeHnQ+1mD/A+OpQ02QZEf9gpf8nMZ
	m5zcLFOlTREGBWo4ldhVuWns8mKji/AuZHF/XnYx5WipZcyvoufUPyDFK7QAVhB4
	iXkFRITF3E6qnqCgfc/a06paUorRM2lQXJA==
X-ME-Sender: <xms:EbRealWfg_gyxma5_krwbk8ptWimt-dYSnPdaMZcEcSKG_B7O8TKTw>
    <xme:EbReasn1uwzVvc8gGW7FMTp3WA46lS8q_qEVBWazzYxdjtbAlVxdqMhjke88bJpCB
    n8umkVfT0z3vyCIeE9tA604sPjmkfS_ed0MNDpNeJ352rk3QwPPqg>
X-ME-Received: <xmr:EbReamZKEJx4oYP_TCv3a0vcxkAmfyqP-eK-TbSwVMegQCxMy27_vUT_hhiv5teaOATco3gcucV0Bmd1RTFUMhuYc2FRG8BqxQ>
X-ME-Proxy-Cause: dmFkZTGAjRn3iiXfJ9avWxb8i/L3JHAIJDzLYYkpIT/A6oD0AXz+sgGR4O8GdnVqO8oU/B
    iNG4nOVTY8SnYAit7/D3LY/wRUb9wFRfjqebfc1NK+ycwZlbVbkXo0q3qVl/qzn+V2gaJV
    rS5wDd9UM0J14yjqdjQ6piz/0ovm0geQ0S+lwz2GQStU1my0JEUYX2hIqq2u0NJWLZG27S
    0u4M+CHlgYLvaKcJtQsVyqV+trTk0TzB9Ite0wI8C9XNjH1apRPPcCHfGSkmbC8Zfnqc8q
    fdL2qUeWeekW9+XXX7t8ViVizDiClVDaAZl7WFF7lpmrdiOgRoTVC8k0cbWLiPb5emzdQX
    1+NrDL8TlzSrdiq8LE3vT2IzyMKHalvb3ofZw5nxXcmpjYRg2XWAot7Nvs+WeapHZhugva
    6DPIrBY0whhqlX18oVAur31Xt5biXx7xG6ifJDY/c3sPvmpFGB38sxE3N0mW/wjhmmmktN
    FutMgmRfs6+GFGNA642GUKvq5h3XagMKxa2425K++t3dSryWQRQWGTRjIVym2cTVhassFs
    KafqBuSmAyC73Bm3C91zw8VmsbiJHrO3G+fK1rlP/2mtPCK5WBlgUjCthkB/QusAZTlUJ8
    X8i9nW0xCglUtwF/jdaR+KE4jR3ZZu9gc8zKrsBE3ysoJuJSsePSIsZPVEHA
X-ME-Proxy: <xmx:EbReanNf7_i2AotN_zFGp32D5CC0yU_nrtVgem2q8lL5NnHUVQSCSA>
    <xmx:EbRearYr8nLyuLlpQCZOStzgCpsq5xdvpnvpZDRvMT2_zm_1qr-a6g>
    <xmx:EbReal1uwPKURO2p9GCwXG6RlSiYQ0S-hRkTBdjef0nDfXdXHCm_Bw>
    <xmx:EbReahefvSq0_QFSHzUoshQafpK-wutCM3BZiQA9BjJZJiiYcGvVBA>
    <xmx:EbReah4s7LtTYeSPgWhTsWW2NP7VYuzp1KL02v38AfxY2aUx3ysovPMO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 19:49:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 2/2] remote: resolve URL-valued push tracking remotes
In-Reply-To: <CAHwyqnV=ZbthekwTcmrK5twCOgNETW+0Z5uj=w3oKjUK6Hv47g@mail.gmail.com>
	(Harald Nordgren's message of "Mon, 20 Jul 2026 21:56:25 +0200")
References: <pull.2358.git.git.1784538618.gitgitgadget@gmail.com>
	<ff645b21591a4b365b30acaf67a295510889141c.1784538618.git.gitgitgadget@gmail.com>
	<xmqq4ihtcx8g.fsf@gitster.g>
	<CAHwyqnV=ZbthekwTcmrK5twCOgNETW+0Z5uj=w3oKjUK6Hv47g@mail.gmail.com>
Date: Mon, 20 Jul 2026 16:49:35 -0700
Message-ID: <xmqqmrvl9q7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Thanks for your continued support on all my topics!
>
> Yes, I should clarify in the commit message what the actual motivation
> is, which is for me to handle remote renames in a smoother way, since
> 'gh' renmames remotes when forking a repo which is messing with
> @{push} and compareBranches for 'git status'.


Yeah, it would be a good thing to do in an updated version.

Thanks.
