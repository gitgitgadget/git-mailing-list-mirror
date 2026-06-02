Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C83D2FEC
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780391439; cv=none; b=Ou74J9rW6zwDFc9mfmUqYswhDWCvoUFU0mw+zpwLpQwZEu+IkeRkqA+qd85IAkaJ2666DxSfP0RO7c0Y/Oj4xeQ9R+0lK3SrgKEQWLhaKUotNaKOTbmSbK+AGTVk7UFe0jtU7bLsc46z5XKTaQKX2foiO2ljV/v4DvJ4OkVopaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780391439; c=relaxed/simple;
	bh=DR6UVd1dl5oy8PDAkWrZ6jwLR2gSr9FVUPfsFu8ICPs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DxyKmsl8Ih8x41bnXyVYiojiImECmGQaQqRJ3lPnv1tIH5xq57zxqFjAj1B6Lb3HWjHbixEP5oMV2Vh+QjrjnR+oGGA42FzwNlMdusyNI9h81rc2hHodaatQTVfaS3Z/8bPMC2Zdc3uX5Eh6gsn3c2SKYie1yYh18sVod47llA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kFwQpFVZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LEH4O+TX; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kFwQpFVZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LEH4O+TX"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E7E7DEC06FF;
	Tue,  2 Jun 2026 05:10:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 02 Jun 2026 05:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780391436; x=1780477836; bh=JRznLrjyT8
	nX6ROnpT/kGsxO01YP1WpM5RIEKOhMFNs=; b=kFwQpFVZPDXwP6h8PgNico//DN
	MQOciY5rjktY1AyFKgAoP/Z0osx76nprgQypNZR/bgn+pO5KpW2Z1w+AtE0O9Ot3
	3m5zoerNA02n0wWS/sOlyiEj8VtiMvMZhK8+rRauT/e3p4zOxyx9SGeWn0csOJXD
	stfNQPfdwgHCBorlIz92jdqAkW9C77Kt7urDLhdBVEgu4CK9mgkeAsQpfCb3WRIs
	MJ4jT9eXXmcxEJMJdpARy7vrHYdpTyCAyf0GupK9mQ0axp+0tc4KQAT9tAbOnf2Y
	nYZEld0Ufrr6Qf+xILYsWSlBZhUHI/ujXGMuzLdo7J/1VAsU6X17AAQIFqAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780391436; x=1780477836; bh=JRznLrjyT8nX6ROnpT/kGsxO01YP1WpM5RI
	EKOhMFNs=; b=LEH4O+TXc+luGvC6OprGCzUd27ShlvNXr7LhJrZZBNWP/gTD/IU
	6i3BS+84otfGUi44+5/KWMNWFWfjM7dKUfr9qPMD7VfD2uNok/KEPTCIEsUNbGPx
	i8F42G0+RdMWy2odqc5ejICl0BJbOzTLRKNtPP7ypRbom7lRH/s/fFMuDeIpt8rY
	vM1wARmaBaRXyZTqKSVOHK3LHY1zHKQndc+ILW6l5h95z21knLYCmmX7aqarrLiu
	2YUdnYybKEkCtn+415v4/lxJpullCZPmuC/gZxL1w9wPlzttpjFLMCk+rpirYO0B
	AVsr86Sevro94I7jFTyqIZYD4+ibXqkNfmA==
X-ME-Sender: <xms:DJ4eaqvIEaKsMWdSiedNLS4_Dhk0bHb6LSoKGs_saofezZZ7yTDTHg>
    <xme:DJ4eam4KUvXi4HX5_heSqjqkvJWMX6cl3nhAFIgX3FUrTa8BCc-7WLJf_rsTyBCYz
    8LT-gEyWtiqq-rHMd5nl8UEDQQaLZ-JN4WgOFsmldT5g8k-Kv7e_g>
X-ME-Received: <xmr:DJ4eajJNM1-ZJA8-1B-i66t3RPeNlxIXsknSu0cG4jNjqK71XV0KtxBc8XneVUChoccjuUWjN65aTOtZXDgDLDIqStmUXkMciWES>
X-ME-Proxy-Cause: dmFkZTFPxWD2g8O5j35/dfa4sBmJgOCCAzI0Jx1A/imeQgfJi0tuTzPezPpEopjnhCmMdw
    aOUu1WHoTeXqMRAGPgnfEKwX56E/uVOsabnJIZlM7KDrl1P2CRWUsVxI8XM/5b0ygW+265
    LEHSBcEX1W4wtO7sc1rJpmG6b6fDHjX8GQf6EfTq3O6ptRp6+SrN/XSQ1iRbHGwWhAVftz
    z6fnM1pFL+o3HTttKYEn6HSQIgn5Rz03UFmjkPpJKKd+IL805p+JqGKrqpG5REEONrX9kW
    X6cM8R5LfPD3L2F/oePRHyhLvEsbtq5npINUPO8woXxGczlIGdnAqTd/lt6oezG/ZT1nM6
    ss48J5g03jv/zpVfj/wOXwSA4LKeHjhADeaoSVjRr8LFQdQUAXTavGkZitqTyZch9eHCCc
    SYOIchgDwYdpGRrqvEO88cuh1SYt2fR168nZdCNjXS1mol/14SJVKcuGmzq/arl4CuWLTx
    XiwF2n4oiqFFwRM5GHt2eBr5mzyCPfQ1b6ghtguk+0pvOsJ3A5sO+VgwK2gEwlWL7288JU
    sfYY0y3FZrL7D+SRPbXVCRYlakuDOlB+pVxFQBymUceC5KNef0h8YRQrUXlduqf8CMjG43
    1w8xuBxX5Z5WbU0DLkOG61dUZe62piVlr+4+vGHpuk4Ea7fgYL1+mRg9jEVA
X-ME-Proxy: <xmx:DJ4eau5NFQ8DjWeF7xq3ouwr35HJpAxNhYbSMwwKhjMjAyViPzeXEg>
    <xmx:DJ4eaux93zX84CdUCGpKTRiJWQWk9aQQPWAoXgOYfH83cTEGvh7rMg>
    <xmx:DJ4eaqYmbIO-S1YpBQwMgxRcsAQKhK1D4ChdmEDBYTTVduigs0fVSQ>
    <xmx:DJ4eaoSioCISnqDvZTn8wuE-lw6qemn3FV3c33_0INKQrKAHg-vZLw>
    <xmx:DJ4earmN0VtiyJlWj9wXcD3vM_3O8jd3DVUOnHKuU5Tmr6E2Oc3rIXF0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 05:10:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Luna Schwalbe <dev@luna.gl>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: document and test `@` prefix for raw timestamps
In-Reply-To: <2194e42a-5c41-44e1-ba36-1599cbd41415@luna.gl> (Luna Schwalbe's
	message of "Tue, 2 Jun 2026 10:15:15 +0200")
References: <20260601213944.645731-2-dev@luna.gl> <xmqqfr35zt6h.fsf@gitster.g>
	<2194e42a-5c41-44e1-ba36-1599cbd41415@luna.gl>
Date: Tue, 02 Jun 2026 18:10:35 +0900
Message-ID: <xmqqqzmpxq7o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Luna Schwalbe <dev@luna.gl> writes:

>  > Does this "additional paragraph" format correctly, instead of
>  > rendered as a literal block (typically typeset in typewriter font,
>  > monospace)?  Don't you need to do something like what is done for
>  > "ISO 8601::" that appears later in the same file?  I.e. lose the
>  > four-space indent and replace the blank line before it with a single
>  > '+' list continuation operator?
>
> Terribly sorry, you're right of course, I somehow forgot to actually 
> build and check the docs. Will send an updated patch right away.

No need to be sorry---we all make mistakes.

> As far as I can tell the rule is technically not necessary at all (apart 
> from some unusual approxidate interpretations like the `2000 +0000` 
> example, which I honestly think are more confusing than useful), seeing 
> that YYYYMMDD isn't a supported format anywhere.

Sounds good.  In any case, that is totally outside the scope of this
patch.

Thanks.
