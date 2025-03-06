Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B975926A1DA
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283983; cv=none; b=uHNQBSLRRkQTTbyOmgQLCYT1miVtxeex9ehKfmCiMU8440d0bGp3E2PiSNRsZkofZSsLbmQ7wdA78r5okl9kypoLQYXWR9roBhnpz7VVxwN7ebRyMz16f5mtaF+x1w1IkrcG8LD8MeS7xD595nbB99NsUWfSH1IjCopkqlokA6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283983; c=relaxed/simple;
	bh=rKBT32E7lwh6M7SN8Vq4bVXQjd1x3oDT3YTJ10cY7yg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S8MP/2OMfvKuRbzjzd4QD8LRl8O2BlS+pKoYfUs2cAf80UOJnzLVltSDBrx5chvoyiPt1TpzATPh+sASLCYwFDHV0JcLyinUkcKDMEWkFcRyWuthUMmHtsmQUymqdN0wwYTz69hbUPgUpfRmRGgRNEtrQtl3EdaagrMBGkFPjBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Kq3uqt8B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YQUWx96M; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kq3uqt8B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YQUWx96M"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B5E0D138273B;
	Thu,  6 Mar 2025 12:59:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 06 Mar 2025 12:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741283980; x=1741370380; bh=rKBT32E7lw
	h6M7SN8Vq4bVXQjd1x3oDT3YTJ10cY7yg=; b=Kq3uqt8B1lBR1ZDSvo0bbLlEzS
	24qxjieS2a6psFJlK7BgxaEcXpRwW1PNmBoCESQg9CuooDAQn+HyMe/3m4D+hnvh
	EdKeT+5g8cvm0jtzobUJLqcbb/8q3c2EFc/TlOuvDyeQEKnZdI7/jiTE9vHo2E1O
	MCPcL5jahM+BvPsYcfAPxgoh/4VfrRWqF82sqnDtouxpQToTrrbu5k+cGh8fiGF3
	21AJfq/td7dTZcYHLxnOS+oyg2yj5qWU3pPmKQxpFC1DUZ6kDRB/mtJEG7pGI0/Z
	zZ1JsGinvl5453f+wOXUh3GJVILqNUN9a5LsSUUkdCj3IIpwJGwT3HBYLpsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741283980; x=1741370380; bh=rKBT32E7lwh6M7SN8Vq4bVXQjd1x3oDT3YT
	J10cY7yg=; b=YQUWx96MlvNUqH+8fYyxYx3ep8mQrb5NXDpibhTJkvSArxeXL1c
	3oib2eBNvemB4EePc2aqOksfQG8xE2oWkPiOW4KI5VPJ+YYVbRnusnc0DK/TWsBi
	qXGYP5RpBmgpE68tFOLNIFTxFTdo2hW72EqR7S70Q5Uw6vlJdtZechO8IpeqQEbg
	NSsV0t+0XWK7ULdDagZRA4j3Ljzn3Bwx9ZZ5iV9f0K0XbgAyWP3H2ebCWYPAsIR+
	SePZ+WROdh5uD/XJgIfbqCBwpMcmdDCa2bsIXq/1ZsR04F9Z6Qg1drzLmxW6Mv1L
	aQgv90EjygUR4kcK0M0N4lpmI56UEeAJvWA==
X-ME-Sender: <xms:jOLJZxzzrA3gtWs8xCVABvEi7HM5d7jOxzBTMY50ZHk4_PSaO0SaFw>
    <xme:jOLJZxTH1OLdsjFPtgcUuFN0gu2WPpTkVgfeBOfsrr8ASVKkLu4vW9qualkiRWNIA
    5g7_syAuaDAhJlK3A>
X-ME-Received: <xmr:jOLJZ7UTRZWd46h7_p-OMBy710taw0waL3IZ8tXDOuyv_Lx5Sp1BPG-s7ojiwWI4jfSBXe7aOou-ySMbvgcHvJjQgNbzXxQuFHo2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdp
    rhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jOLJZzhu3QNnYY1VJc8hIX73bCR3ydXyi294KJe3q-NNgZbZM5SoLA>
    <xmx:jOLJZzACMv7XtwIQmClgm_QH9dZ31K-BJgKH0cXjsUchbm43ZLdKmg>
    <xmx:jOLJZ8KqaE6-JjrKENHaDx9FoaxK3Z_8PzoIuevAGNueFxJF30685g>
    <xmx:jOLJZyCScIUdNexsouchbXX2p_5oUiu5rKHrpPw2Wc3zuCFoAueMhg>
    <xmx:jOLJZ_uMisSZgpG0qp1qzZrnQsoJF2AFFqaGgr3ZBUG3o4ghJdK8mZY3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 12:59:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  johncai86@gmail.com,
  me@ttaylorr.com,  ps@pks.im,  shejialuo@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 6/8] builtin/ls-files: stop using `the_repository`
In-Reply-To: <20250306143629.1267358-7-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Thu, 6 Mar 2025 20:05:50 +0530")
References: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
	<20250306143629.1267358-1-usmanakinyemi202@gmail.com>
	<20250306143629.1267358-7-usmanakinyemi202@gmail.com>
Date: Thu, 06 Mar 2025 09:59:37 -0800
Message-ID: <xmqq4j06hwfq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Pass the repository available in the calling context to both
> `expand_objectsize()` and `show_ru_info()` to remove their
> dependency on the global `the_repository` variable.

Makes sense, and the changes look reasonable.
