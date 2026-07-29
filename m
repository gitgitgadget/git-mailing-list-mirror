Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C5A48EBF7
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332622; cv=none; b=bIX23/Rz/gIJuXVZUJMU7nycIaO6DV5uudlrxvPgrrUmw1OedWfIlavrbqueym2rqCvIyh9eZWKFEb+nsy35rjdelwzKq5dOAk8BfKyhxAwsjNgKjujlZbuYzVUT82eNYnvMhAlSSaC6b5MPijhhZ2ElBaT8IL886CHb9GPL1rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332622; c=relaxed/simple;
	bh=6wlmiiNHYk2gr+ldwt5KoUE8hReSmnaz4BdrPcJJ/Vc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EDR8r76hNbPxpSQDWkKQ/KthMuClMivqM/g97R374H/eRxiO6PNiSscpu63t0mCtJfJZZ/ECLaITVN+GDB3DSNdHRfR1AtJSZdNaKumoLk4634tuUHNmN6GOCA5SatuHos43+LNH+etM4aq/aithcldMHtX4jFEk4Rqkp6kG4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=x5ICQ5uI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HpvgsKEq; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="x5ICQ5uI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HpvgsKEq"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 794DE7A0068;
	Wed, 29 Jul 2026 09:43:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 29 Jul 2026 09:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785332619;
	 x=1785419019; bh=2jBBHbanUKS0qFS8T9SKqfx7rWajmgnu6uw4H9lDKKk=; b=
	x5ICQ5uIOMe9CvUPd1Vazmv9MQa9vhqzo2xdkb9CO5xxXeYo2csuidLjh+FtVnb/
	BiPTeQsQmmEhU1C5RPiZ2BW6gtLBXhbi+o85xDtkFW10kKmzVPTiq4YiZnz+jCqD
	VVPnlq0KmooawWmV2JURCWyrAIq9qCbDorpYomBSo8Y++WYRquKBYqMVZvEC5NPe
	wSnELPS4i59KDhjA2w/6rNj/IXzns5FoIONpiNhm+4U4kGWZsSUW0pmAhd/bCMB4
	9RzHbxoRzc9NnBIb3DIzrGLypqGgWXQ0PZ2X2VWGA/1sL/sLgjwNqlm1kj6xcr1D
	KFpDxL6ZzO8NrTU4UJashQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785332619; x=
	1785419019; bh=2jBBHbanUKS0qFS8T9SKqfx7rWajmgnu6uw4H9lDKKk=; b=H
	pvgsKEqOC7cU/upRRvkNz1U3JPe3rjWKhtbB1HagKnqYsq9mQC4YHZCgXfEYEPZc
	NCoMMIKcrVkSK5hU4tRUOZcZ+qKSh1T9Ak9pG/uE4R2nc4x96TqjRh25z1nGjsJK
	n3IT4aoWn0gmJTimU84nFaOTGk9De4Cj8D3jBnZF2Y26F4mBu8sLbw12v+LnjTFL
	XJW60ObQdOiMOmGALpRU3BUUmVgaww/mU2yf8LflAmP7LURwRz7RZR/7qAvmzwkx
	6DdUZZyjpTPPamQmvk5j+sAKMVjM2a6PvqSd/vsdxJk/Q08QM/zIgwj6CCIY1zxS
	AEEbMXB2OoNl+Y001j9MQ==
X-ME-Sender: <xms:iwNqamuLmL-ghl_xzveUBff5F9lShaReilF_2O_HQcdYGVSij0bFaw>
    <xme:iwNqai52q6NRclbI7QyAKr5_Vp31OjRSGCSz8lIu0C80ryL2WBYMNObLyr7SQXDJ2
    QYIZS8Peom7JRFVvOhaXzzBk0R-uqrq7bfZ9SztJUipvSO3Fns1bcA>
X-ME-Received: <xmr:iwNqavKtFMcle1opOIOfHaxXrpL8LGWU7tHeOnk0LMUtQAeFXVgQVq5q-5PAE36mc-PXgbDSeZCN1MQBhZzzjLFdaLN-iyyVkg>
X-ME-Proxy-Cause: dmFkZTFg81esTbk2BTis+1AiFHO+N2ORyHvT/yw1I9TOAPjMBmlHrAsJ2b+9hvp0JWqwp7
    Ivya3ax5l9/lrWV4hyMicrggN//XmsZ3a0PA1FFmpd09jUSVVb5OU6E0CEVSrRyrzZKChT
    aoe2Dkm8XwWQ7cdzN4FGG5FA+KJSbJ6+3tsm2R9XrSRGLaH0lBz/o1QDlcDiTBZPlZXPy6
    vcjx6tRLoo9TqCUGHNKZpQddBStGm+AJpiu2ROyPi1dEm/TocxpsocXiaEQqzBy1vN7Bru
    SwMHeTpYPCQehbloChvJP5w1LZ2cEOVoytFP1PNT0rKJ7Fn/85iUF8fapbVPbvf46slueB
    Wt7DXdGcT0yP4GfLdysBsAoqiZttTbTqXddcAzFSVIF9tz5JE7GD5fb4JuzXro+BMf7UJx
    RKbn086O5jnVQI/oAHsFoPHFayQb92s4NbI8l9wTMjDNB6yGlwnasxOG9/u4pib5Vnw6Qu
    pLjHQCQDK+/64gATBSCRT4o/7VHe0C19J+pFHnkWlghGC0grNGpvr61Hs+LcqilcrSTS1a
    KbCyGUNNscPZY9y+9V2NieGLYjnDYihKMoSaKQFYpytmOuxLIasCG7u21ryZ2ZZZ3BBZNB
    LK67GY0mYjZ5PAUWQUBmppVuMUZKDQFbfzGWI/HFSEotI3ip24USjhRq2BbA
X-ME-Proxy: <xmx:iwNqaq7_93c4ApLl2J1a__HOyQ5R7v3XsCU07PAkGu6OF2JV-7opCQ>
    <xmx:iwNqaqysF-c3PysQx1d-DLai8L2AGAnsioF7Ny5VFj2qpNO0UMrf1A>
    <xmx:iwNqamaOWAsafZVNupGZ9HPZsRJh2X4ndgQ_9XWe7w6L2HWvm740-w>
    <xmx:iwNqakRPf4zQi1ECSl5_pThtEZA4EOZQ_cIPj5n8i8VAM_YRkYxYOA>
    <xmx:iwNqau5li4OW3-DAuDMhndEUmIXELhvKJAS2b159vO6EG5em9MoxHbpk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 09:43:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] add: introduce '--resolved' option
In-Reply-To: <CAC2Qwm+AmeDubDrkLmu8Rz9rtO3697gokwF2=2c5PgP--hZT2w@mail.gmail.com>
	(Michael Montalbo's message of "Tue, 28 Jul 2026 20:28:11 -0700")
References: <20260728215219.753678-1-gitster@pobox.com>
	<20260728215219.753678-4-gitster@pobox.com>
	<CAC2Qwm+AmeDubDrkLmu8Rz9rtO3697gokwF2=2c5PgP--hZT2w@mail.gmail.com>
Date: Wed, 29 Jul 2026 06:43:37 -0700
Message-ID: <xmqqcxw5c3na.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Michael Montalbo <mmontalbo@gmail.com> writes:

> On Tue, Jul 28, 2026 at 2:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> -       if (addremove && take_worktree_changes)
>> -               die(_("options '%s' and '%s' cannot be used together"), "-A", "-u");
>> +       die_for_incompatible_opt3(take_worktree_changes, "-u/--update",
>> +                                 0 <= addremove_explicit, "-A/--all",
>> +                                 add_resolved, "--resolved");
>>
>
> Should this be "0 < addremove_explicit"?

Thanks for noticing.  '0 <=' is absolutely bogus.

I wonder if we should simply write 'addremove', as this part of the
change is about rewriting the open-coded die_for_incompatible_opt2()
in the original and using die_for_incompatible_opt3() to add a third
option.


>> diff --git a/t/t2207-add-resolved.sh b/t/t2207-add-resolved.sh
>> new file mode 100755
>> index 0000000000..f88e3f413e
>> --- /dev/null
>> +++ b/t/t2207-add-resolved.sh
>
> Does this new test file need a t/meson.build entry?

Yeah, it shows that I rarely exercise meson build.

Thanks.
