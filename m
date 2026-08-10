Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9DE390987
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786384346; cv=none; b=AeGm9phMHgJ55nKS0/HobFuJWAjd3gPWGhqGmKzNGRchIRkuff9YNTSzKUJf9NukoI8eKMZUAli8RTzZ79eXvt8l86YJzYdABQay0QVsH4xuBfwJnJvcy8J16shKE4v+e831/SlUpFqkCJ57odYlnvUfsLAQn9ARn5qcG0jed3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786384346; c=relaxed/simple;
	bh=4QXg1OKSSxYFnIlOGOqL9aT56rRXTQpHbtJEXcDYfUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pK6QN4ruzcELIkttSSu+lDqyYX7STHu0BDD+7sU3XoVO5c2ksSGbGeeEnUk3Ztlw3iE+M5LmI5ysYwQGb+uNKBQUQSEDHzzsYKxthN0vjl9DLHeTSK73Tvp5ABq9FKuFx5oTgiRguJ7jKjjQQy5EJQRfSxkhFTtam+P0eBqZitQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fgi3r+rR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ROYLyP0v; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fgi3r+rR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ROYLyP0v"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E6CC1D00116;
	Mon, 10 Aug 2026 13:52:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 10 Aug 2026 13:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786384342; x=1786470742; bh=4QXg1OKSSx
	YFnIlOGOqL9aT56rRXTQpHbtJEXcDYfUg=; b=fgi3r+rRAWAHrVQceNf/CJDLBY
	YwQpa2bBW3mQg7blJXO4HHkpmuDcMRsWWfpurK5dP90opSfx+yFEEeBRUrjkZm6U
	CX/CRIQHX4Gq2Fxe7St074Hin7FDHqNNFekE8KErbGwfWCt6f7dSDe59Lyk+SKzD
	sGHcGbm6iEEW6Cw7nUnTpNWZkuwzATvBnfQIEfCWfSqpCw5IBRuaAyXiZdW/miM8
	xG00RYB1dnmfOUyP++FaQwE1YPogj4Yl6YLLrh3LEqGzN9pyxS51SW0ygzaiQSCJ
	m5DDGv07oro4We5suMrVHyOUNMts5/wYKJ3mW9uE/qWh8SmzwCRpk2NOLNnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786384342; x=1786470742; bh=4QXg1OKSSxYFnIlOGOqL9aT56rRXTQpHbtJ
	EXcDYfUg=; b=ROYLyP0vgCNQG118G3JYbVAp/iFldv8Xxqgcys2G3NIHL9fzQGo
	GoZnH3hSI+0LxBEAv0KNyAOJ4vgrw9S+Mt4hMk2Lpcn9FU8D+UYVitEWy5PRnqCc
	g4kBbuaqdfw8muyaeRwedi5ZuyMG0Hy01TPInUC051iFBgBgVeWKVVUNqiS4Yvuz
	Fq9FaGBCkO95ixGwZc8mVbkOdk54pLH0VvbPWUkY8Rauq2WhrjSe0veBbs1aAEpk
	CCIuTAy6sAE7LQU8mLND5l+H/lmxaUNIOZQjuE0xZmi3bvED4f4eGTvfUB0qG3RG
	TvMrah9JOi231jKjZVyiFLAeFUe4CZYmYJA==
X-ME-Sender: <xms:1g96aiFOa9a34dh2838swTJ0rCUdXkYGiNvKVR8Q8AA1GwHCR_EJZg>
    <xme:1g96alnuG1eyjAVua0FQovYjb_cmhGyvW2tC9QX2hOFViy5okOEmvvOGRlcMlzQ8N
    yUdn1ItZgVfz_aczl0ujye5dIgaggav0NeUtrFMJlUq_skmt6jWXg>
X-ME-Received: <xmr:1g96auZNWAJP00ZuYog6W4v9WSR3F_-kNZdHyxolx1U1x3YRFhul6QKP54uJmlm4T8x_1Z5OkX0tyyqaGA2HPbDBGP-t-F_ykQ>
X-ME-Proxy-Cause: dmFkZTEvnbW4YSqD4QgSGB7s6aFmqt98KsKPGxOm4r+0u/3FnChjqX90+ytKFNXuzWmpIR
    IIq4CJjvrwYdA8DbMaXLKtb1ewZ0+WDVxE9ZriyplCB2JG72myR5m0QSVhHvrDoT9wJWud
    x38gUJpHl54otyGU2Jkij0STFAcslVrZsXd3UKFCpL+D4GeVfExBxnOObU9a7kqarCjRXG
    XUIZUY98hPoPybzex9/VYQls1dAmYX9zxYaa6TCPHk1TKEzF2UXqzVCgoomiNtZ08v+lJ2
    tWC3ahPlyGD3q5ytIH0ayVpLB/Jl4gD6/nGupk1W848NOuPvVZ+cHu1LKItrEF7SXotPNx
    4o9DQXxH1RbhPhwgK3LPG/c697CGj90Hu79Up3Rt4r4sEc5hv32LzYca5ZQaDjeG/Cre9C
    XIKtru9faWGLeq8XqkuHvVYqklEYxhgi2tGVNkXsCZzc8Mo1ZWahigwUr+f+Hx1mmZiihJ
    48ow4+dxRDakI20f2nSdoZH7yp9kSFW7BM2Cog8J60IIpF0YqCV2X9dWa0rEskL0XxJ32Z
    uvTLO9CyudiDn6pvqX9mcIIqq+SnFGfCEB2C4ag4F/DQkogryBsIkldMA1nOVQTIF+C8sf
    3hO8ftLSqvyqvYQtXz68nOrIPMI67+5Iq/iPHviJTuRBCr+nh8xMr4EVYrpw
X-ME-Proxy: <xmx:1g96aiE9TSi-QEyNo-zm92r1Hzf8cRGFHeW64OILjmW08D6tNgCM1w>
    <xmx:1g96anKB781jYTVhDkpiOEc_N4Fw6mjqxs_Fgvrs1Ft1S-u6VPCL_A>
    <xmx:1g96alPpq2CEdF3bhbA5XkFjDhmmONAgUoMSC4Qey3O7QpvRiKcnsg>
    <xmx:1g96avlFMSNHtS7DgDQjAqVhDLkJTh64TQ1FB5RtfH8DSDjjSa9L4A>
    <xmx:1g96atK8G_DIyr9rjsj5DvBP1xDFeOJX4MBQnsI1Fout2hTojaHgsM0r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 13:52:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  tnyman@openai.com,
  Taylor Blau <me@ttaylorr.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] ci: bump ubuntu image version for static-analysis job
In-Reply-To: <anlj3kdAfOh8OnNR@pks.im> (Patrick Steinhardt's message of "Mon,
	10 Aug 2026 07:38:38 +0200")
References: <20260726083254.GA3528497@coredump.intra.peff.net>
	<20260726083905.GB3529069@coredump.intra.peff.net>
	<anWyV9Q4Cmsa5AoT@pks.im> <xmqq8q6hgb2m.fsf@gitster.g>
	<anlj3kdAfOh8OnNR@pks.im>
Date: Mon, 10 Aug 2026 10:52:21 -0700
Message-ID: <xmqq7blx7tii.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Taking a step back, I do have to wonder whether the Cocci files have
> been adding any kind of value in the first place. I myself introduced
> some of them in contexts where I made sweeping changes to our APIs, so
> that any in-flight topics can be trivially adjusted via Coccinelle. But
> I very much doubt that anyone ever used those to adapt their in-flight
> patch series at all.
>
> So maybe we should just not do that anymore?

We still do catch when somebody writes "if (a == NULL)", no?
