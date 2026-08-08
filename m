Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7A9342CB0
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786206756; cv=none; b=l35xPOjMFBV243sfMIlUB4OvYzCyT0HMk7C8ZGDrJNB8neHopbXgtMkDL93gV4+bGTEL3TpdWTe3Dh2qGglUqNL5uhxxQM2D/uty7nNEuDT3NkFoZVwN780DxULb0LZsgxeBZfcv8slB2a6UQU+TZCi3kwTpcWFr4p0tYQaq3Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786206756; c=relaxed/simple;
	bh=9o7dRmy/g5IusgmB7xuzzl+/3WGfUxeuyrKnJX7uwhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MbdoC0wqOm00v+5TG10w/2p01zs5u6B9dSf8TpKqXRx0XASq5hlR2FtPjcMSu7zXVM0c9ESoegBDKvZbdyt9k/h+yEXhGRlHJIc+0GYdvkcHt2gaYqKzijO35jUUdcE0g9CanEqBcJQMRRTaKTKssUysRZo9D5VFAVAF4Z3UKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YwmO8uJV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EnDRLqtU; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YwmO8uJV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EnDRLqtU"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 107397A0062;
	Sat,  8 Aug 2026 12:32:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 08 Aug 2026 12:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786206753; x=1786293153; bh=QiHmqlure2
	NQqR2eEkAXut+89H6OayO/n/dqM65zo88=; b=YwmO8uJVHtB77PSoX12vpT3RnP
	qpW08F1kbbifd0rCR2zNXiIR7vVHEFKNd9zCPoGXpSMAOxo6+Khd3eXuC1/ETI0B
	iHhvX6tKOtLdIJGIfVo67NPPeZKZJZvpQGLtcX7iFgBOBgyQFc7UtuYsctyWuuxf
	siAMoj9gI2lHFHQGV3vusT3bt/AOR9wvN22ik276g3IGt0Zmg8UeRylqmCK24HMf
	9bgq5WQjqUeesNWWIyvSs33yAmwdIxP4YNFHDPE2uVN0FeWYqvSzsHT6Ufyq5Lvx
	BRbXFjq60C7v27Ffs1RafF6h+cVg3zDUtKS6+IeJuqAPjQ+Df6OFH6U8fWog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786206753; x=1786293153; bh=QiHmqlure2NQqR2eEkAXut+89H6OayO/n/d
	qM65zo88=; b=EnDRLqtUL2IPCuMK6jQCeXeHCTzTcndkJw5Nf85TJzEI/lHHiRG
	nynkafiooUtzNHgTrU53uI2X9r1eJ4pKylA/vmp4fGHMi7EBa7f1udin9Gx0c6bP
	3ieJEAs9tzsIMUibo8e1W+aceRUReFvwrjjufpIu3itz2I5Pm/Bki7FpoNs+XCn4
	ccvfpiuFxKKHLKhlVynIzA0citLIOQJ+6bObBfCu/W/6ifLM2fPpL7E39LSN1gAa
	W+qIbZSTRRCnTLYWw9M6MIrrRAsjrKUnoPpHsH7uDoOwckN9Jw2czKqoKnasepzO
	RYqxrzqw5envJs+Bw9pYLrue8u8ayouq8nw==
X-ME-Sender: <xms:IVp3arI3ui9ZiKLqRh6lZG984b0qAkTTglszASEpzMmd3oaf6AJACw>
    <xme:IVp3amCJmG8Rh-B5u_L-zRoZ3uSzFD4FlPxG7J1LlmKmVh7Xc6UMjbOEHCIPnJoIr
    VYIFpvZMuF7OD6g-qF8M6WVM8vx7K7urGX4yxd4Ao0HnvTphObncA>
X-ME-Received: <xmr:IVp3asBQ8Rafo2-85R0i_-CFNR4SFwuKsKNk1X0wgQK7sglqLDoxcZWH0Gq_ON2HipC5yzZjVu5ag-DxTEkmOaymNhBAR1ZA-g>
X-ME-Proxy-Cause: dmFkZTEJyAZ8Ijh/NlDlRe6LdCT33LHgwu9hty2cM9GDi5svTQlqcaQtnUaKL1Mc3zgEbn
    Z7Yn29x/kFOfz/QXRI3eI1v6bXetcldWxBFuptQ5I5l9YxVlU5jANt7PWBMa8rWZcQu9ta
    ideSIQhSyLZfU2ncxdpUvgx+Zdckaxya115Tw4/QN3DpZjFXDNXpobrmCZWVBIzfFjxNZy
    hpJh1JF6ZD0Y/b/nsOJg5ePr8UXsmvZLvtomsuV+jl0d1HxVjJ+HVEjNR2XzitNo8oejKs
    KGZNnlL0nmfA7OUek21Gg6BN9KX10BsNolVI5A2aoB1oYzEZz/uurfImM1VWULQQ9BA8PA
    0eRbH15C3BpLuNxLz0fDR9HTA9P+0K8queNJW8xtFCtNqDTL3Lk+2nKGSFCrodj2F7WOuB
    rX7Pz2/MJUoykvYVSYfaXStRcO0LYw0nbdYDz+hFEcGcQep/wrjTbDHWnhZby/cf7vKVai
    WUE4wPOanlZHCy25JwbYE2erp1NfJO6PskJ7YizpY8meQ4lpju/KwHqhPGYX52FucRD771
    30CBG8CSMZ9ZJuqkvU6hJH9GaGUw52ITNivV4IfUc9UWbafAbYgUBt0OPDToTKPp8p4QWl
    QSjHlm94WU+bSLaNHjaN0+qN2OzbH2a2MeBv2BRMHtHxQZ6lAFlefT947phQ
X-ME-Proxy: <xmx:IVp3agAM7Qnl34owOIXfhW67_AaRt33menzcLoiv9VHsmfvvLfiMOQ>
    <xmx:IVp3avrYy3eZgqy_fSx9yEkZCy-382suymd-GrHxGFfQgeqxHkK3wg>
    <xmx:IVp3ailYMP3SkgiQWq2SiNHcX579XbgGumibVmdJzWLyYpz8vDB_1Q>
    <xmx:IVp3anynz2bqlflN6TEyGeqRZh19M8nRUIvVDeYn1hiwBlRoRmw2YQ>
    <xmx:IVp3apRT4ltcjy_tMTrgdybXtghoZ-jE0A9sxFQkXz9xFqPUsl_ITx_m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Aug 2026 12:32:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: mark <mlevedahl@gmail.com>,  Johannes Sixt via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 5/5] gitk: avoid constructing dialog titles from text
 pieces
In-Reply-To: <b1d397e1-ab2d-439e-ba45-0ade2c216afa@kdbg.org> (Johannes Sixt's
	message of "Sat, 8 Aug 2026 12:00:18 +0200")
References: <pull.2194.git.1785998419.gitgitgadget@gmail.com>
	<1e1bcfaf5bbe66fac364d5b7d3a7ebdc5f37531c.1785998419.git.gitgitgadget@gmail.com>
	<f25e5fe8-cf6a-4d87-9c46-bf5b7490434d@gmail.com>
	<b1d397e1-ab2d-439e-ba45-0ade2c216afa@kdbg.org>
Date: Sat, 08 Aug 2026 09:32:31 -0700
Message-ID: <xmqqecg8bmjk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> 	Diff: old lines background
> 	Background of old lines in diffs
>
> Sounds a bit clumsy.

Both lacking "color" is not a problem because it is easy to see that
this entire thing is about "color" from the context (like these
appear in "Color" menu or something)?

