Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913953D902A
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069312; cv=none; b=GO+dphm4ZBUmO26//qWkupE1RY0UdiB1XTlYi2Z6zbpAjSfsanxXpNHG4X98n+CR8HhKjzjl2/kdfquM5yCAc2U5c5RZqUaAqhLcEh55Tbas03fCbnV2OmPR9xWxAOnYRYN4RZUUoMNS7GW7jPBjb+TrDEp9dXsuWgIE/dRtx+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069312; c=relaxed/simple;
	bh=A+u35DcxzIQiyB6PNgs94fRzqeKEjmRCrKSh1ACGYOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nb0ONWxSGnAlPM/08Fx3JmGzAGU+UxDVziIiqgusDNTH5IItyJXec8VKawPsGpulduc18XkFxqxnW04dLu0mwMTMf6gwNnXoWq0UjZZAO0gW/nn4LkSt4if9nRGJSJKrHIX6Sq71C0Bdw5FsmyUo12BiMPF559s2a3bp13vtN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NUGEXJMz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JUOQLe5K; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NUGEXJMz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JUOQLe5K"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id C3334EC04F0;
	Mon,  9 Mar 2026 11:15:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 09 Mar 2026 11:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773069310; x=1773155710; bh=PXdZGR+M1f
	y8dk784tipZSEu8gygwb+Ngr1idSK+Cr8=; b=NUGEXJMzLPw6zt1uUhZ4EQGGYq
	XBooeZtltFBxT2JLAf/xRPcnDkN1IiHuMEr5BtemP7LvKXlLefRgnfCx9GaHYVF8
	hIqdEkuDZW4fk4kIwgQEx+hvrspr91Cijv+IX8+FL2sNXoTmSD+W+pMShE2LHGlZ
	zTOEpy2TdDCeZiY5wDztdWbkn4v6yrVygpYysMMLy1E2mg0uzAVGzjRD6ehGt5YT
	1JCFjTd+Jf6jQu2M2n4YB8gaPGF4UypWivMPImeaNOnE2TadST7E1yrJJOtZ/5oF
	jNQLROug1cjmAyafUWP4ocz0b2ypaNK/NvaL8YhbGErDY/rwO+ySP7i7+w3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773069310; x=1773155710; bh=PXdZGR+M1fy8dk784tipZSEu8gygwb+Ngr1
	idSK+Cr8=; b=JUOQLe5KscPJUakPySO6jEuGv2GNOQ79ydCnaRRlePjB34dOHIq
	fdr/lYKfaJIF9P9U51PZetHwCVg2RwrBtdVnO2qiBzebv0lD1GqwuUj3YdHBodVw
	G1ugFUpWbHObhXQLyPA0kiW42HZYsfcOhE+HKVxJpfbwAjHrRpGudgmHsjHzLgWH
	FRANfjkjsbJ0v6DtoJ8wEQnDToD1ddeXAPfcUbNMvsxqctUjr0wKEnC1tJait+Ho
	mjVMjBRy83NDWVuMLIG+h5w5LHSXxzXLkg4v0vbxBNeScnBojWQfvjKLXz1tvzoM
	Fb/fUZVzgyA44eNX6dHPcEe9YCwe3b3GTog==
X-ME-Sender: <xms:_uOuaRIkNSNq6_19MNFk1HvIptfawBDGsKdzVARKlE9wv-Qr3PzYTw>
    <xme:_uOuaUl_ckog1ghC-7Qc_toDIVXUYZ_KD9dZU91WjMO84ei-S62dTKG_Hc_fAV-Ga
    L2rjUcpQA0NpyBFR4wbOfZYi-xGa0_0blnNCxs1CimFkI07kKbc>
X-ME-Received: <xmr:_uOuaXHQ5WohX0eKhZuw0esh3kc_28lHcTuQU2hx-QS2r5JWcVAoHwKVx-KFo1ae-2ftJZYhT7CM2I4W4bxb961jypP2IjZHJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeekgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfhhlohhstghhsehnuhhtrghnihigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_uOuacHJFQzCN5_ApiuvR6Iz7dZ-B0Jd4-P-bkORMyoRGBNQ4aXOsg>
    <xmx:_uOuacPI137grG9SZ7664xaABmkLmxJXIowewng-lnvdtuX1PVSa0w>
    <xmx:_uOuaTEulRgWw1oVInXTdbZHhVUpfHjmzqIp3NnvrfaUX8DVOiVexg>
    <xmx:_uOuabO6AwB60Is1uahVHX2fI9gYRY-QNWyDGx2tNDfgYpKT9o1N-A>
    <xmx:_uOuabKDR6GwtlABRbN5Z7Q0uiiEMqU2AzB3NSKCddes-L6Y8FQOScF7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 11:15:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Florian Schmidt <flosch@nutanix.com>
Cc: git@vger.kernel.org
Subject: Re: Option for "git submodule foreach" to also run on the parent git?
In-Reply-To: <032a7767-2350-4312-a7b1-75080519c72a@nutanix.com> (Florian
	Schmidt's message of "Mon, 9 Mar 2026 12:52:04 +0000")
References: <032a7767-2350-4312-a7b1-75080519c72a@nutanix.com>
Date: Mon, 09 Mar 2026 08:15:08 -0700
Message-ID: <xmqqsea9591f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Florian Schmidt <flosch@nutanix.com> writes:

> would there be an appetite for a new option to "git submodule foreach" 
> to run the foreach command on the parent git repo as well?

Not from me.  After all, the top-level superproject is not a
submodule from the point of view of the tree, is it?  If it were
"git submodule-and-superproject foreach", then perhaps, but at that
point, wouldn't it be simpler to explain what you are doing as

    do-this . ;# do it here
    git submodule foreach do-this ;# do it there all over

instead?
