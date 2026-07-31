Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC5C15ECCC
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523769; cv=none; b=b9jQOLaNgazHQBdDM+cCauAym1ZrKOe2QzcSC8C9M+uOKSBmHv6g+BPoYaKDK7nTldc39S03Rt0FrYDiuS9oKudv701MOZo4zQ855lzbUz3uySeRzwzVc4DvqSxoCP8GCVpe82S4zxx5UPyZATvH5SisxiT0HYd51innEuvyf5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523769; c=relaxed/simple;
	bh=qZ8dQ7gPElNhRj9qYJsNZJY99o/UZ03yXep77ZICUc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NQDKBBTHvxGLBBAaXZwkcr1EQuYngafw04GfTrRqPL3lCvY8Eo42gsozgS05mVuTvXlyXPO4k7l/YDDQXjxLgt7HbATeWM6Ve5mmyqLVIvbshNAy3vj+SGEaneLpp6mstxN3JScDkxhNxEc9XxDAstfkpHzYoMzOdYrWBnAnZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZZvDhlAl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vt59qxGm; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZZvDhlAl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vt59qxGm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3169014000DA;
	Fri, 31 Jul 2026 14:49:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 31 Jul 2026 14:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785523767; x=1785610167; bh=zh4zFgwVP+
	XyIxkClwTEoyVe6dJZwdxQ7H4GkysBcl8=; b=ZZvDhlAlhx+ejXilrkNMHpLX0s
	cHQC5x/fThQ+PQUJjgaCjx03fFr1Y0Z/yggZGu8aJYGCPZzki+CTjL4zjqQYSmuJ
	D+LGHb1V94HUWtftPzKOD4vxVbIA1Toa6YdXEXXmdisnforz/2G/RBdG00lc9JfQ
	mQB7MuAbj47FCfr9FYzWew3EpJwDk0qLX1Tw5NB/DPSExPrL7M0XSG+n+g7l0CF5
	nZA1ERnFrBYiK7qYP0KK370r1EjKgn+cAJGrm2/JqLP4pWjD8nsdX6logDzbVvjQ
	te9JH5IBSNjqF61AgecXdFqMHsw+aDZpgJP1aufhWpqt2MyIkh9f68ea48Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785523767; x=1785610167; bh=zh4zFgwVP+XyIxkClwTEoyVe6dJZwdxQ7H4
	GkysBcl8=; b=Vt59qxGmokvJiv7uf7W9YymNNqmVjY8PHW9ewQeWzTaWlk2m5i4
	1+4iVfOTuribZeP7ss4drN2TevmpPl/RRFcImFM/tPqepigdjiYoLCjNFcIAYnCh
	hfcgAfuyXZ1pIQH0SF8X+/6pd+ambq/ez/oBneG734fh/mjqW5qFvKMix90/qGca
	E1vxYHCgpCT2UouHbgEIhNOTeqjcy4Fkl+E5PFuMmnE+fcGdwQ+y3u8O/ZGG13sM
	M0P2MDirDrkim7P0eajp0IoK0cXLeHn2OVUg/kTxWeyV2SXNoiQdOp/bXJYnZ5Vz
	n/Itjk4CAGcZ+LTMbJWim8LoGnUCDQUCdtA==
X-ME-Sender: <xms:N-5sapMLzxuD-FlSO3PZ4Db1HAqxk0Pr-KdseTj7FJgHn7Iw7JHayQ>
    <xme:N-5sai_AQGS4itMVNcoREAiYBfDzLzIhjVGud0EW5eAdwRrOAup6GLpTIJ-J6_-8n
    84yF8pSkMSe4xrXu_ucumIi3-LA18GAL4gsOgeJN-85RkmhMMqPwgE>
X-ME-Received: <xmr:N-5satQbejeTJBUNiceP9cPVanMqtY2eYxQ-4CQiMMxXNES1Gi7zoOWnUXQzDDDRn4-zfXe34Sw5VOdj_O0MNwODAkLELB2Z9g>
X-ME-Proxy-Cause: dmFkZTEfiJN8vriTk9rc6gv2k24s3XDT8y0TeFHVizRFQfZeoHSQQ+5FIsKKwwDg4KkzYF
    eao+N9dXtTd3i8w/9YVVenYWXYXuAOt3DFmFYXgipOwDuY+Tlz/ieFn8+0o1Ati2DFyq48
    RC6FLWoooiTX+mdhSVT3ZS+att76ySd65CEjzg5dZS/6ZNbwItxWnJQsEDUBvMPusSZ9qJ
    IuLOK27tOJKOI9mWyUw2Io2OLaPl5ZRFp1Krim9aVugSSv6kkuOc0yJ+CDEoH2yTRAXtTY
    mKKr7eREs0R8JjUHgErW2o9OoHyoaGenTPGnXsiVZzVDct/l6O0ntOQKIbdJkxrWsQ/FdJ
    YIj4ImIVwwyYqVu/TaQlNPYXaX+DJGaMciWs7nhCRGCz7zTVUkUlxP/fvIjxOTCDSyoTbq
    bBMRSWrrN1zIl16H/hPLFqzV8ODFhyNhv+k+VUm2BfAhfM/ysUKvsYe416qf92OOe4GKob
    z1ozcQThhjeDbXKwT+rqfRMOEHXG0bCLoHPZnZiCiiayWA+wtFGBo94I3uE0gWviZEdSTi
    Yg1oJy/8WNmrxGXnIaE+lG21EdOxTfthCJz45fI8pyecXhdVYmd1i6CWz7bRHsxqEtA4qk
    dhYOjLHgq+bRBtSXy3wHb3/jRe77eBQcy/IKWN6Iv3ckrpBgp4szAXe+7uyQ
X-ME-Proxy: <xmx:N-5saklfjqz-PlSH_Vxr9atrTRRb8uZTJXwBEnc2oJsryYcwhALxzA>
    <xmx:N-5satRdxzStXNxb8GckeuaVWMfav1Bz1f4_-x_9xSwmxLuV9Q1q9w>
    <xmx:N-5saiO5NT1a_Sz4Q9njw1Yw02e827cg85iZH6oPs_Zhp6ZC15AtYw>
    <xmx:N-5samVZZOLzaA3Zl6HpfZadfYz2vjzobFuDufPeDoEh0jmRNPaW9Q>
    <xmx:N-5sapi23EB31TURjBU39-9QoDJFQ4GLIkpiuEybL7Bkf8yoennJ71vl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 14:49:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Thomas Nemeth <tnemeth@free.fr>,  git@vger.kernel.org
Subject: Re: Git trailing blank lines feature configuration
In-Reply-To: <d5ec69c8-e441-4134-a6bb-665fc06db187@kdbg.org> (Johannes Sixt's
	message of "Fri, 31 Jul 2026 13:08:49 +0200")
References: <6022080.DvuYhMxLoT@cixi>
	<d5ec69c8-e441-4134-a6bb-665fc06db187@kdbg.org>
Date: Fri, 31 Jul 2026 11:49:25 -0700
Message-ID: <xmqq33wzc7uy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 31.07.26 um 12:19 schrieb Thomas Nemeth:
>>     I have the habit to keep 1 blank line at the end of my files. To me,
>>     it eases the EOF modifications (selecting code blocks, pasting them)
>>     in vim.
>
> (Call this is [x].)
>
>>     Would it be possible to have a configuration option to avoid warnings
>>     (because I see that as a warning) about trailing blank lines ?
> Hearing the first time that an extra blank line at EOF is necessary or
> useful. Would the correct question then perhaps be: how do you all
> handle [x] without an extra blank line at EOF?
>
> That said, are you looking to disable blank-at-eof from core.whitespace?
> Collect all "enabled by default" except this one from [*].
>
> [*]
> https://git-scm.com/docs/git-config#Documentation/git-config.txt-corewhitespace
>
> -- Hannes

Ah, if "I want a configuration that does not complain when it sees
any number (including zero) of blank lines" is what is asked for,
then yes, 'blank-at-eof' would be sufficient.  

I misread the request as "I want it to complain if there is not
exactly one blank line at the end" (i.e., zero blank lines will be
flagged as not vi-friendly and two or more blank lines will be
flagged as excess blank lines at the end).  That is not something
'blank-at-eof' would help you achieve.
