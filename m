Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0773D21B8F8
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 20:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056604; cv=none; b=m461ZzcWd487jHBWEWS53YL83jzXubZHgWIhNUfoQRBzIAb4W6yj/koDS3FKwT6Uvm2mtp50WJLH6zqN0KhwEvfxwbHneyzAwLzMrtRh8QncHyKwqfwHCYR3xyHGZ8a+3zvZcOTutH+E426G7je8d8uNQnmm0eunj2sPUtEtkCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056604; c=relaxed/simple;
	bh=VdcQ49ZFRhOd06rT4VWAK28GO4GAEiFPei92Csr+knY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dfWlALrkPjA0ahuJd0rVSjOLHSAfOM0U5IaxsJ46xa23H9z2PSe8tF/QwC/q2yJBnc49DeJj/YZk5+nbMcxNhl6B2HLRMYqm7tMj+xFWI5KjHwR8YbgZcODbviCDXE4ZIc3n8Eh4hSDSdkbJTyO5IojCpLfsJWs4wjUxnr0BQcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TAC6lGXc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KP+hdRi7; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TAC6lGXc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KP+hdRi7"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id E14FE11401A0;
	Mon,  7 Apr 2025 16:09:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 07 Apr 2025 16:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744056599; x=1744142999; bh=LbdRuVUCqo
	Uhrs1llqSQr/RR103IaQvT2BDbI/isk88=; b=TAC6lGXcTtSGmfneLcN+ikyj/1
	b5GAj6fpKZPpxeu5yQolDds3u5BedzHbX9kMBFGlqnoQ43PKFapFSkik3aLSdZy3
	OM5N244vAaxCLgbpdfj+VKbqj4vw+sb2STrzD3m6+GMCc31UAh9S6RMbFCqSjP6w
	7PCcHHrKwJxbVKXinlZ/94Yy6GgskGaNUaax9rU/zMzgVNBLxreEzvh+OKSyTE35
	FGfHSxzcOoq3r0NYuGLHdpxu/dv1WNhswqJ5c6K1/z3jVWp5AHGRcXRgfltFZa9E
	SL55BWalvxPGuhy3V+Qe7vZO+sK6dzbzlfHoTcaLC/JfLB+HbUZnMuEBlxmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744056599; x=1744142999; bh=LbdRuVUCqoUhrs1llqSQr/RR103IaQvT2BD
	bI/isk88=; b=KP+hdRi7q5YFQfnbapt6YFshyE18F1TScJwIBPXJSxCDA2ApWFq
	8Ib2e9/Gojtc/JRzqjxxu1/ZyfwT4vd/OIRqNeuVVh8/hxZCJuv2AysmwVL36Ji0
	YDVq6o4IiqD+Vz8s3fqXikBrZ4z+h+6wm2Fub+DSbOkjA6WnAuZzMuxXrKqgK6HW
	UfurwdSldzXB59QdBbJoZPxbKmafxAsZ36GMwJxqaBpYkmGl0RIEwJ4Gmqtn0mGO
	ic55nvOw9SZOC7Bl70iEm5BW3w/Y/fwcMDz1Eon5pB+/oIs2wq7w4CZMNbWDgg3r
	FKV72asXZJLsvNCcQMY3ERJDAuVZ+EItA3g==
X-ME-Sender: <xms:FzH0Zx-PQ_zKpU-8vYhGMhdKVuejtFDyeYe-QCuCNW7F3pSOjnbxQQ>
    <xme:FzH0Z1vm4zWSRAg60_qELsUjH03aVJ_ofkr5ENMnuGTmVaOoSfcXSl7GrpSzydqe9
    CXWG5jXvTPm-HlcRg>
X-ME-Received: <xmr:FzH0Z_AuQ_CfOe5sHiSbfk1mZKqbxfi3ts8ggEjLkbx9Qgr_13hg8bGgV9-6s58ZnJgXpzdWk8UJiDSngxs2HLqO_Fp8EqptY-Qi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdduudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FzH0Z1cI6lKY8G_hZwVSy_tg2aAXkZ4jrFCspuony58ln0BMXKE9IQ>
    <xmx:FzH0Z2N7m-_VQpZ-LaqcvrJ9FMhPPV7KHKyIa4zAnvejpVV_wWi6Kg>
    <xmx:FzH0Z3kXOdBo1HFByt_wZqbeTAgqS8rttjoQFujjZg8-V_LTRtuwKQ>
    <xmx:FzH0ZwtGj_fdXO5uSqEYetCzi2RU-W2UK4GtWoOEFDVZZiHnTklyNg>
    <xmx:FzH0Z_F_DLok447KVUvyxnR0SAgSLbCOPDpRDk6856zvVwSAAD7h7mO1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 16:09:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Elijah
 Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/8] Debug merge-recursive.[ch]
In-Reply-To: <pull.1898.v2.git.1743891374.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Sat, 05 Apr 2025 22:16:06
	+0000")
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
	<pull.1898.v2.git.1743891374.gitgitgadget@gmail.com>
Date: Mon, 07 Apr 2025 20:09:57 +0000
Message-ID: <xmqqiknfn36y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series does some preparation, then moves the code shared between
> merge-recursive and merge-ort from the former to the latter, and then debugs
> the remainder of merge-recursive.[ch].

Help unconfusing me.  When we have bugs in our code, the action we
take consists of two parts, i.e. first we find them, and then we fix
them.  To me, the verb "debug" refers only to the earlier half, and
never the latter.

But the code in the later part of this series is not only to find or
expose existing bugs, but also fixing them, right?

I've already named the topic with "debug" in its name while queuing
the original iteration of this series, as I was on vacation and did
not want to spend more than minimum braincycles on naming, but now I
am back, I sense that the use of the word, and the proposed log
message for 6/8, are overly suboptimal.  If you are referring to
fixing remaining bugs, "Debug the remainder of merge-recursive.[ch]"
is not how we usually describe our fixes.

I suspect that the overall sentiment behind this series is ...

        Such and such bugs existed in the older backend, but now the
        newer backend is used when the older one is asked, and the
        newer backend does not share these bugs, we can simply
        remove the buggy code specific to the older backend.

... but I find it somewhat disturbing to stay totally silent about
"such and such bugs existed" part.

Thanks.
