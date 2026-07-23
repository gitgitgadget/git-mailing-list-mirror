Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABE7391E52
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 23:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784850509; cv=none; b=eZ7LH8GYnJkCydQfJg/tFHl7kwJJmEuzbjIx4NqcpWtRNZl0sZU71nHnmAYwbmnaBaSLMRWz7yvZLFTlRbSUTWa3HwM8RgBEwS357wj2Ojhs47DbgdNCxtmNQpyG1DnpsVWsS+g0HVTj6j2s/xDKtuwbv4guZ1HcKyGlckStVxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784850509; c=relaxed/simple;
	bh=CCCtVzizIJKW0chAsMMhHpg4gA7JqdUxxww7+kIHX74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TSUPkvV9zgE9Fxi/zUIO7aAsngzhe9vTDjnQvpAOhvc6DdaPEfZA+wcMuS3t6+Wa788X+vSbmtRgjsLO2HWSSbM8eCkkNnfFr+Wa+r2PjkADz9svoFUK4w7eAqAPeSPV9ST0oCCjFDikQwshOrW7bTbsoYo9+Z6SwsDQTp27Yyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kx5SJmzv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hAG+pAOv; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kx5SJmzv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hAG+pAOv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C2F21D0000F;
	Thu, 23 Jul 2026 19:48:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 23 Jul 2026 19:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784850506;
	 x=1784936906; bh=M9pJiOshdlWDs4VX2qXfxTHOI1DgSgPnrrJTbddM3BI=; b=
	kx5SJmzvhqvKG+bOEXPn3q7QAbDrlhlQnB48Bg/ysqNEEfFQFmhHMS7vMApO17Mj
	w8KoLGFJIN7trfZ7bbNgAsZxcmPD2rTSOtQIEfnkWlbgiEXGEltFpAklOlLhaBeK
	SVCVUqffo6Pspfv8acgX1lxu1xyUpIYx3w9uMce7kOF3SRc1y3uUleE7EVES8FdH
	LY6iknkW6J65P7GxgFrslh4ydEXRyfzCSEL1h4oLoKuZEayaKwbq94pOtUnpm82f
	/cf3TUP7nQJUzu5IMoMundJKtecoOpuSyIA3nr2JrAxbr1NsiW8MUQhpHX8t3bYl
	qs0jt9c3gX2h/zcEPW50DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784850506; x=
	1784936906; bh=M9pJiOshdlWDs4VX2qXfxTHOI1DgSgPnrrJTbddM3BI=; b=h
	AG+pAOvl2hijuVGml9wPnmvoWCXwGUFZjgQLyGddpX8N72bWMy87lUdmsQLukZdo
	OemLuedz22neI+zZFVlQgGl0PotBas0h0kYf04U0XfCjUUT38hjyDXGaeQFfttBm
	npo7+VU29PY2w9/Vlth3sz4QwzIptgD7pOSCUflHT47TmOpfVBJbiKZaHD8g7mwc
	0bxhKRBrE9yYZxhoc+7jGoIqJOdGGmdoBEKHZnRC0wnA0LV6B8oTbA+0rJuubrM/
	Jcxfgl5k76tatTJgwuaueKkVWe+Mn6GacTYW46SJ91Ctxhf24B0hcuTinh16JQGl
	nOc/N4Vtslcjfc/dq2s9g==
X-ME-Sender: <xms:SqhiapnB-poOq9bvBp8JK9wrwNmWqRASN1mRZ8HySxOh8pyHKlB7zg>
    <xme:SqhianHojWzCMCCGSUf85IUq8vTp07D0o1XXGrjYsJN36TlE2W9T_MtUmg23Hc9jn
    LMZDiwaCAuHDwcJwyR2LQOywNQwyl62ccklOgX0F6fT7GkAxl4bgDA>
X-ME-Received: <xmr:Sqhiah5asein7IZuxO737_iX8csjnHHRmsUEJf8eprOapiy-AZzwC2t05E4DkJP7Xq3AX-OGC-dIANN8CiufmEj9FYcOJsWgfA>
X-ME-Proxy-Cause: dmFkZTF5hHvCmYvq9VaEUB5nQNdt5MPPahR8bPFPytDaZ+7wWspIpWii9SNBdZyS/OJYHV
    hAs5cJEMvabXbiIw9TxAdbUcIjU/2sGFcdQGSxBaGGMwz/F5NUmV5Vw+uD6OLb/2zyls4j
    9F3RZwXlFpTnNGoNsVe4+4LDBtRuSJs3RoYaa48X6/IsvqVfupPD6BdkAHgdqbJE5JkeIf
    JWmJAPkdmS69m6z89imx9g4kmkADYmS1FvLvliF+oXp+5cyoFvlZaJztat8Nl7JBvvJ3jO
    xxkhfxM/4Lq6jSQJT6NV8bFrzRPrlXLLF1zYOqMeWIuy+xJ+38Ot+mW3n6AfQUQyUC7rR1
    4omywEtWZXhRqnFTkbLtXb+fuCkASy5JeuBr79yALSYWLMTxyOx8W6kRhEHmcco5kKepbk
    iw1roGpYPb0G+jhIjlwCc5bSZ22AL02/zR4xmG6WAz3MRB9gnflxM8J059n/uDl4cilvZU
    lzK77E4KjPSOYNoS4l1XoA+DXy0X53qOpF2OAt53JW/d3/DBdQG3HXDMHq+Ka7VNW1La2A
    41k3D9sgdccoJQtYH/ivkJbqbhsfYHHuJ6/AnUP7yec2F/qg5dM+nHWKQpB5SbzgBDVu/B
    kGb1sikQNTPUk7wlONe/MPBDnd5Qye+dGHHjLBGethKw1WyetVC5Q5XQszxQ
X-ME-Proxy: <xmx:SqhiavnA0RA6nWzsLrqiRFEuRMY9wHYHMTQT8eMFUqpgEFbJzhqr4Q>
    <xmx:Sqhiamq077eRntwx8IQYkyz8s7C7MJQ7r42uVGWsTBi9V2tR4Gi_cQ>
    <xmx:SqhiautsLD21QH8ycAY5fSEL5yTSHd1fMi4LIES7U7BOW3uq_0thCA>
    <xmx:SqhiarHdQ5y9qwG-CdbVNDNPYZhuBRrAyQSw3bDM3fJPxTDK5V57CQ>
    <xmx:SqhiahQ493EwXkQc9lKGSzT2vls865sbXPeVSXQKiTpIKhTlnc43D-MV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 19:48:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,  "Christian Couder" <christian.couder@gmail.com>,
  jackmanb@google.com,  "Linus Arver" <linus@ucla.edu>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 00/11] doc: interpret-trailers: explain key format
In-Reply-To: <729baf6b-53ea-4e8d-95ab-5935667e66c2@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Wed, 17 Jun 2026 21:45:31 +0200")
References: <CV_doc_int-tr_key_format.533@msgid.xyz>
	<V3_CV_doc_int-tr_key_format.8a3@msgid.xyz>
	<xmqqcxxyt4op.fsf@gitster.g>
	<729baf6b-53ea-4e8d-95ab-5935667e66c2@app.fastmail.com>
Date: Thu, 23 Jul 2026 16:48:25 -0700
Message-ID: <xmqqzezhb73q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

I was reviewing the draft of the What's Cooking report and noticed  
that this topic is among a handful of stalled efforts going nowhere.

>> If you want to stress that a line with only whitespaces on it does
>> not count as a blank line for the purpose of this paragraph, you can
>> consistently say "an empty line" withotu saying "a blank line", and
>> you do not need to have "(specifically an empty lline)" there.
>
> Okay, I’ll make it shorter.
>
> It felt too long for a simple concept indeed.
> ...

And it has been more than a month since we discussed this topic the
last time.  Will we see an update anytime soon?  If not, let me
mark the topic to be discarded in my draft of the whats-cooking
report.


