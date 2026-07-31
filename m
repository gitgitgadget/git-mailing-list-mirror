Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8D942642D
	for <git@vger.kernel.org>; Fri, 31 Jul 2026 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513410; cv=none; b=R7IoWIfXy8dDFiffl9NZeJvpnnH36lRSUFkq/kbTLODwuogvlcOsx13TOutI24bYxfyKeckqBzkf+31iPD9PWmRSGPMGIyrPdnOQ7FjaEEQZTNIAsJzKzxbbDzuDqYTrHc2yiMNA0A+HIPyICz5QoZY3ywmfxzPEC0pIfUXOGko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513410; c=relaxed/simple;
	bh=GZrE8OIiE82CYYBB/YFtde3+4EhhtVHRAwlZz1U21Ds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rr68TJ4TX8CPhxqoileADXBtnfyVCxov3mNbSD0thEYaqXbWsxKKyE7SeqXnyPz/L703OUAHljRVdxOc1mauOZw58wDw/yRgkmOk72Lqp4ExMw/LRQi5421F3uy1/dm50lZfwzpHZsJ8fMoJhp6nVns+ESljJVI/JrphjYbFNp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aEeJLWuE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lqP+tYJ/; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aEeJLWuE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lqP+tYJ/"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 49B86EC009E;
	Fri, 31 Jul 2026 11:56:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 31 Jul 2026 11:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785513408; x=1785599808; bh=JVja704tbM
	xd9STD0O2waBB4p1QunjqEGh6Y/ETj67I=; b=aEeJLWuENNFgFEHUTnwemTqd3i
	X+5hiAbmBfxbyJuIkujblUiJ9W4FYMngNgVYhRjZ9FCYwVxDfGs5hCaNbZqwyA6a
	oZhuXxOfzVV0OFLgnLlZKUYf6ApkiNG55nNCd6PAuS0LPzlTFb1jcOs55xYjn1C6
	D1TIUgIzk9pfp2+aYsFSLODf/letlu01Y9cUSTAVngNd32587xc16m7J9cz0+xxh
	QGEuCG0SEpLaIwDpJybfSpNnJiDqcPOdYcDBvR0Dtwx4tIRsMRLnPKdPwzsR+kMY
	Qdyubg5mLuWABOuO+Ri9bTOUDk51vVwywZKp0QEfZXunrGngmJgDSSboOeGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785513408; x=1785599808; bh=JVja704tbMxd9STD0O2waBB4p1QunjqEGh6
	Y/ETj67I=; b=lqP+tYJ/i8Dlcshe2BjFu11M/3pO3svLdZQeghDeFZbG9753ydf
	2DMhpy7Wln5/nlsuD1FPJLPlWQlBsEDp2DKnZWCDFqGewneeq69Jj+eU3Rztkr2b
	rhta1BStanJRm5Cig+/HGOzIgxjl7lMZ929Sp8auNxqShYNdVZN6B0hlCQtVfN85
	21wee1laMPPUKbKBAxCPGgsJSNm7KGt8FjLH/AYVdJMP7tMiTW6b4yi1LGSUvw8u
	ySVuUqFziAAwK3oHK8CrJeitPXEvJCUein86O9RE94I5gLLSiOCegDHrkJWjoklr
	1uJMtTow8V2ZlrNM88OYVKpRTQelgm4FG9g==
X-ME-Sender: <xms:wMVsahZ0M9sGhCBV6X1Ad-ptF0Jm5acPFuhpB6dJwtNTOz8EMuYiKQ>
    <xme:wMVsavbxqgqYO1l24B718LQahGTp8JPR76v0Uijsdfp8RWo13ZY8WXk_591gFJVRv
    aRwlHJ_HA_8EsiWwyFJ2AmnaFIMwzLrglGUhtCGiQO6X1B8yl4hRA>
X-ME-Received: <xmr:wMVsao8X3vA9zMZHl4mg1nIhTllmHdvgczjjkeO4afCgFnEGk33BC8g8NqnpCl7HhdJmhTRNZSbFODlRSVtOe4C5yywcMcvzmw>
X-ME-Proxy-Cause: dmFkZTFZsxZNeQ2CQvsZLEjc1Zo0d0LSgFOzcoX4x7pXiT8s/vnxY/d5djPkMeGP/h+dtE
    hNBR9QbO3Ej1MlJsFhQUgxEJrvaWtFd9jZ11HUmFCdMkcYVekmrzEshoazKOlXT3lzJdPn
    oZ7gDA2OsVAZIOUwlrFd8laVjm7eGUSltHTHpcJoVSHFnPg8bk6znYfcNyCDKF1UCm8vsL
    tIQKnJSLtzSrdCUzVx1cZUUziF1fur5k6Mi8GPsGUhZNvuBx6YHFDSqE/scwQHpXipASSP
    Tdt6ICTOB95mQ0POQ2w8LQTO3szkTi61r2qQlHLOwJuxst3vpdLFr/VliSmOBNLYvDHVis
    q2IfGYHdyqgEpISH5qa4cCdjUR4rqoFE8zaN2gEjRmYdAyBigO0JfxOMyMsNQUe0+85jEo
    CALWoU3cMfsVNxpNgvXQY2WZoRGsXJP8h4k6pAnBeJONMjH+Izu4KBh9QpzTRGDtfz7m9+
    Ix6um6+pIX4q5sO9J3KCUDGo5wRcEnDOZj7DmLR2q8zl+WyUmKEtZHqpIXS2cD9dnMMiep
    QQxYfgHxKr34EJ0Grs3CLaVJ+0YGcTDnL7NkmUlVhOhaeRHyNysGlw1w7JvS5RL4awTTiR
    BRBinvJtvZJ96eXSliwZQYFE4mFVwQcWzyJsj5EHJ7EwvwCh8peSPjodhIdw
X-ME-Proxy: <xmx:wMVsauiPrqpoVSaAt_TtkntXvuXIyVelzi4u5xFzZSsZWeMng9_rgg>
    <xmx:wMVsaofrvggqHlg7x6uNfRauYPvQPePZhyeu-ym_kGnc9SeZ0s98kw>
    <xmx:wMVsalrg78GABYyJ5_yFJNx8no57U5C__TEm3ZFF1WPZYuLl1rDlZw>
    <xmx:wMVsatB1ln2CkTPbnmIj1p5w_cFIUST7YEX9BydlfBK0LuC7_ssULQ>
    <xmx:wMVsaoemRTYxJLsx8AphX7WGazt6POamSGCvurQJd0KFCT79bgOGvWiK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 11:56:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] sparse-index: avoid crash on intent-to-add entry
 outside the cone
In-Reply-To: <e4cce4e2-4287-4e1a-8833-d37ee48ff7d6@gmail.com> (Derrick
	Stolee's message of "Fri, 31 Jul 2026 09:23:41 -0400")
References: <pull.2167.git.1783345853272.gitgitgadget@gmail.com>
	<xmqq33x1o465.fsf@gitster.g>
	<e4cce4e2-4287-4e1a-8833-d37ee48ff7d6@gmail.com>
Date: Fri, 31 Jul 2026 08:56:46 -0700
Message-ID: <xmqqtspfcfup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

>> OK.  That is an easy and safe cop-out that is much better than segfaulting.
>> 
>> Shall we mark the topic for 'next'?
> Thanks for taking a look. yes, this should be a pretty safe change that
> can merge.

Thanks.
