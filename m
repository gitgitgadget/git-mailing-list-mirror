Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2238D3F20FA
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283113; cv=none; b=frIDD/wtY+pk3CzhI2Trr6hrL4mGQSDc/R62CEpgY0Z2DsnQ32UCY6PF5hbSVcGoS1IhASVMJSIoZrZV0FWaVXLhBO+6wVjuB/9nb1n5XoCDLDRjsIsWZBJQUHJiUYh/h2jM4AC3YreWP+LZTBDGyXzLCtiU3TksRIgAeGdKNeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283113; c=relaxed/simple;
	bh=h/Jgv1rHPOht6C4eKDGyNfytuaGIVtDYDi7k7QkIrgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KImapX6lDADSooCKxLR91ZnKs6k6+cQGMz7tLQmE3Xpo/nCNrNqylMbMGV2BF+6WSRPR39I5Q3AuRDbWWhHlc2jAohefFTUtivmVjlXr24YxOd6NbFbMZQowXF0WsknB4t7b4wX6JGwgTLW+jdGZ9/u0Cup5snpZXsSsSr/nWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DB4DFdat; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SMOyyzSa; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DB4DFdat";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SMOyyzSa"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id F176D1D0010B;
	Fri, 12 Jun 2026 12:51:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 12 Jun 2026 12:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781283110;
	 x=1781369510; bh=ACTk7rlPh2KPSB7l/Yc3IL6MrcO7xifC6jNdypMDhLE=; b=
	DB4DFdatpN/F2ExqSQ7LlTwg3kspJOu2wcK+uHm2XkVgHTKRCbumfOQj1NtxAaEa
	RiuJ8ThZZWxiY1cIh4bzx1NOc0rJwr8Cm3S7KWOcxO06ZC0CUGYAUHX3nSfW00En
	XtdaVgVyfgLdCTp7VH0pvi7UJRUcTpj+CTm06y3Gg+xhLjaCmdL5e9p8OnUDVbjh
	wZLbfjaGAgGNEyWzvpNMggGUczzqUKO5pHOs1Z8b1jemxiLt4Pb77AyfPELDS4wU
	l4yya6EOaKbWzymhFIMhGMv4jnQ1I2i9zYvNIFo7Gx5zP6xq59RSrR+CUuR9fxfg
	W9xP0pNaFJgcbc9YHRseNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781283110; x=
	1781369510; bh=ACTk7rlPh2KPSB7l/Yc3IL6MrcO7xifC6jNdypMDhLE=; b=S
	MOyyzSaOa+KlkCGXGjf7RWRduejlSJ/0ZdCKcN5XntTd6W0qKe2t12s3nfA6wPBL
	Flrl8fmW4+lMi4xwhGZj4dy3PB9pgoM5Qe1QbhXaafuLBMk+nk2YMcsO1svn+8+/
	LPSpuYi+WoC4C4sdV/U85FN9y3GU1ipra5hob78efnvsFbyd2jKJcWKt2tZsxAlN
	QKG84LRFbTEj79n9XpI6uXNgvZEIokDMWM28JwITHAH1COyBcA1z03lvwWrF28gq
	+3fekjOF6Y8ZeAPvxFP0Ht5eajBMWOMR5Jczk+WF9h1JgNyLJGDpYA+dMEayZCKE
	TiOCOjbFwlKN1Gtoh4wmA==
X-ME-Sender: <xms:JjksasVom5cTCNyVpuvGSxvGKJ0bwERka3PdWhpPUL5RFOkA38DTXw>
    <xme:Jjksai2etpeI44geZTf5O6oSC8qpa6gmW-pMn-wnexOR3cjMUqAMbto7elfdA8Zt1
    dj8JFyopfz65VPJqi267r-y4ZXScS8L1s8nPOFjSZOIJsu-wVbG2g>
X-ME-Received: <xmr:JjksaiqjnW2nrX4-x9jOdqb0FzLJ6Is5VPCMHCEBR7-ogteM1CZrrIJM3RlFn7_H-Mj_cuD3HypeFXJncTx6mLx2pPVVHQe1n_pi>
X-ME-Proxy-Cause: dmFkZTFxX0xmHrRxiCZ/4iduiUh91i24ClaCbH4RMY3SVLfIaXqz5jIvtWquR2EsU3VvA6
    WC7g04WKDhKU5QFA+pMP1YiZlrFd/GJq0qUrY+LIJZAs9vHcHvisCUNTeXQm3t9OxvkaDP
    q0mqwtVNMiF99JyxaRXY39kUENCmO3Uy+5uYYif+GGYkFX7fEt5d9xzvYd+od8uhPjJvcV
    GFoMiziPipUHO1i9hcYeazptbBDHFYA3SEHNksukMjsOJaVomEq8aJ/uoUXmEugRrJ0PrF
    4kIT1utgrs2u6wV3LfnVaAU3na7MAyLFoV665ZPvufym+g4O4kT0hwlvnVcRmtyzfQwPcr
    CjrFx+UNLB/RKP9/QzFZ2c5OyirKqsI5cZN5fZrOgdjcfxB+RLm9pZUc9EtUZXh15arMqo
    Q39BVeR64DxoeVeenQh79St+Wg5LHRLC3pOnCF7A23k0C13B4A9M1UPLAtp4J/caqML8QG
    FLXfSIBz+R8eJ/xXe8uJxdnNRnXWOf0iakhxMJjgGq/zIU/WdpZLfk98rH4n7mes8ADCc3
    +y/5a7x3ECd81/IzjSJViyJg3U73T0KFvhzDoQwjzo2UkVaZp/2y81qX4kG7UCdg4yup3o
    hZ62YFJxuQW73NmqO0lvkvJYQ7bIn0Y7uHbtlx12+gnXfQaQIJNu8cb8GDdA
X-ME-Proxy: <xmx:JjksahWjHbJv4XQf6KYsGhzZ5XvtkV3XMbuECi38Nvu-LsiP0Xm2GA>
    <xmx:JjksalYiNExQ5zIkEqqoNIm1ngpX5shR32RNI9xX0xvpvz5ryok3nQ>
    <xmx:JjksamdCodZgKeRwfI_Vz6u_2llEPVUyRUGUdCgW8knrYFD54gsX1Q>
    <xmx:Jjksan0rIEG3cQ_sJIFiJ9Nc8S82uoYHQg3qTu_C58mkIfrDEh9__w>
    <xmx:JjksarBcUFFIJV4fputF29IDbzKfIYImuDHJDnK39Sp2jsNlV12y8xRo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 12:51:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Tian Yuchen <cat@malon.dev>,  git@vger.kernel.org,
  phillip.wood123@gmail.com,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v2 1/1] environment.c: move 'protect_hfs' and
 'protect_ntfs' into 'repo_config_values'
In-Reply-To: <CAP8UFD1UbsXu_7DK2keGLUO3Yh06-YHieZP+On-yjY3SmV2Xmg@mail.gmail.com>
	(Christian Couder's message of "Fri, 12 Jun 2026 09:22:23 +0200")
References: <20260606143412.15443-1-cat@malon.dev>
	<20260610124353.149874-1-cat@malon.dev>
	<20260610124353.149874-2-cat@malon.dev> <xmqqse6uwdnz.fsf@gitster.g>
	<CAP8UFD1UbsXu_7DK2keGLUO3Yh06-YHieZP+On-yjY3SmV2Xmg@mail.gmail.com>
Date: Fri, 12 Jun 2026 09:51:48 -0700
Message-ID: <xmqqik7nhfbv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Jun 10, 2026 at 6:41 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Tian Yuchen <cat@malon.dev> writes:
>>
>> > +int repo_protect_ntfs(struct repository *repo)
>> > +{
>> > +     return repo->gitdir ?
>> ...
>> Shall we declare victory and mark the topic for 'next' now?
>
> I would have preferred the commit subject to start with "environment:"
> rather than "environment.c:" but it's a small nit and maybe you can
> fix it while merging.

If I remember, perhaps I'll try.  But you know what happens when you
add more stuff that are not something only the maintainer can do on
my plate ;-)
