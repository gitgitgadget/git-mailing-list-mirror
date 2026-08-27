Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3769147D468
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841523; cv=none; b=IEL5QNoHTLUTEW/micMLO1Z6uGXi6rVYksJliu9PotVBmPFIinIp0ubeNWLzK8FPUJD5UBPEASJ+n2nsmm+V4RL2Vgf6sou5UMDjcB/8SguJ7jtrI6yb0gn5mXXAzQBTJfIV/H/ZSwIJDaityTHEZRpKJ5DBDit2Q15w3ZvW7FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841523; c=relaxed/simple;
	bh=Gz7d9qYdFkjHctEHd1APtdr1l6IrOZldxJm6j8pLnZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q2ZgoISKKB7m/u7eFXrntCr/8bNSWLxoLRBf/vdKbRlL8Bf09OTJzbLJmwFoX1cM6tlIMS7MVMUlmZBLffNaLOUy3gAPK/vWjfeViIltNq+LKuhPhihu4QS42D8PIpKEfKOMOGfSruXXtydPqArfNkbtwUVLljEsSulcteNuuco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GEMPcKcu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EdgSUTne; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GEMPcKcu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EdgSUTne"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 27128EC0204;
	Thu, 27 Aug 2026 10:38:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 27 Aug 2026 10:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787841508;
	 x=1787927908; bh=KD+E35JV/vDoYnPtFtapc7Fuc52IDrojY2a6pwpUFdI=; b=
	GEMPcKcuusqI/pzloADOOiCHdstF1SpuUeCnBoWGlPA6vgNRVTHCE/5bK3TFGItI
	aTtrq88LU6bo4HIhd/lLMuRY7+OY7PROKv55Y5/zzmROTboIzZSrmk0ObRf2CGqA
	wplKBMBp0CTHIlMVjwj2s4inbB2tHhSUC88Fzj96JLuD3AYsUDmwhL1uC/pa/Wxf
	7ahYPLJuSTw4/FMMYt3tKGQG+uw+vSSQxJIxlpGPG3Q3dp51o5z66/4dqalleM//
	KxnNrzjNEFEbE3JLWFw9afWf77lLxxkAuvBkhzUC+8ZLwrZkgwy5RRS6yV2NXoGM
	40Gwl05KA7ksT6VyFSsuAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787841508; x=
	1787927908; bh=KD+E35JV/vDoYnPtFtapc7Fuc52IDrojY2a6pwpUFdI=; b=E
	dgSUTneoekrfHtvocUK8hHa6EPHsmWSp//Wu+YjOfk3XefBQvI/p+lRWYpnvhvrU
	t7DEjjHb3EvP7AUPu3uRodHKhF60HTPDJn9xt65A/+1XbMsyEAF38xpUwuW7cB3F
	VRSP0yHIuvI22r17a0ldGNC5wDKztFpCZ5NsGoWAIKFeUGMb13GD8Q3nImVA813q
	ZUYVEAO8MUE0Mp1NLIhzgMlRY8XKwBmZjmLeYB6p/JCMm7rKi9wvl1RXaUT4IqW7
	/xHMuTKbizlUxAd3/4vvfpeZe+wDU/6C/kH1kw8VtXDt6cANvV343iQO1obSiWj9
	10yJD/tlr1tcLvYj/vjMA==
X-ME-Sender: <xms:5EuQamXLTxFSCbU9b5--BLmuGBE9lYeD2Y8EA4s5DPNypiIdlChj4Q>
    <xme:5EuQapc-_0FRIwaEobX_mUlI0nwYrPD-KWc-ChJIXWoArJ4MTOgkfMft_8-dzPTU8
    mpOpL7sUZVWRGSBv4HfXm7Vz0n80Xu_YK0TKchYzlX650cNSvNc1nw>
X-ME-Received: <xmr:5EuQaivjL7Q6WEljliuF4ORwBxhBpEaUcmPn0NUN2w_NlQPlQoLiKo5_1VIZUpn2Es3NOOkcV2pgt0FY37kIZgKMhGNwfrLBLg>
X-ME-Proxy-Cause: dmFkZTGZM5vVVOzkPWYv2RKEjoSzk4rIgcEigucZtT4JLB8o5m49fext52BBWzJIz/fyFw
    8KOvCc3cSzWXoYVHw15uxzj7e9JQAw0+OAnCDgWGSXOPiVo/S1fAJZ4lnzRkHUIKc+8/lT
    3IhHBQadOKfWGigOyzrOf+t+t+bqkSfH36ZkdauHhzWTIwiGCUakPz6jaRrRtmkU427o5G
    I+/IVAfRaFjkyRLbPqBna/0M0eq2Fv5w96hRmP9FsYPmLTwRh81Hx2WOOkg7qn3zRDCbC5
    +eE/9EqR79tOyi0RQD/bLup9l2h/rVIFT0L499c/5ra3mMwsxSQ4cgqRurvGXQlNVuv0j7
    1kViUNsZAEySwueZ2r5DEKKZt0Tul9f6kmoRM1EMqAlUxrl1RvKIr1g8RLsJDkduDoFIeF
    9bsMnfWBAOW5LcW9Vdtb5Kc9ECpqkoeNisbCN/Y/9XJfPeTg7AM3wZJEGid881qJbgz+Am
    /yJMNqV4pxok4wpve/Upl732Vn/uFJ8D9F9EQt1cZPZZ9yQGCE8RE2hLoRQt3etN8KpIQd
    ew0zhYuSp+zQRhbgFb58SX98UyQJW5bJVBwK20t/LIHW3AX4nKWfmOikgHyaiVvq8E5V2e
    BNylpOe2i6vSTnTTvfqVbnrTW4YxIyQRNqmOs9jCEiFSst4eFvJUx6R01GCQ
X-ME-Proxy: <xmx:5EuQao-Fwfkjcp4E24wB9FXWWY3ZHy70WsuxQFUUh-G7eSNcMPUN-g>
    <xmx:5EuQat0UTox5etjwjbBPlvJNFcsvGzXi9VtWcjOSWUiiYWCPdJf48g>
    <xmx:5EuQatDJtclPEXs7cm7AHUUnLX0J2M1rByZJGoXb5PDChRaHBNqVBA>
    <xmx:5EuQapcVsfd1-ODkXG2Mc1xfw8xZkg8bXFnfX2swLngqMHNxIqL1DA>
    <xmx:5EuQaoPQ-SbekCICCK2T5-6Oc9oxHjnvHpjsQeQl7XBy9CPKELz-5AUq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 10:38:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,  "Michael Montalbo" <mmontalbo@gmail.com>,  "Elijah
 Newren" <newren@gmail.com>
Subject: Re: [PATCH v2] you_still_use_that(): reword the instructions
In-Reply-To: <cd741511-b457-4464-aab0-56d8554bf763@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 27 Aug 2026 08:49:27 +0200")
References: <xmqqo6epj6is.fsf@gitster.g> <xmqqjypchixe.fsf@gitster.g>
	<cd741511-b457-4464-aab0-56d8554bf763@app.fastmail.com>
Date: Thu, 27 Aug 2026 07:38:26 -0700
Message-ID: <xmqqqzjjbpct.fsf@gitster.g>
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

> What I like the most about this patch/change is that it is more
> assertive and less wordy, e.g. just “If you need a replacement”
> not a long ceremonial sentence “If you still use this command, ...”.

Yes, that was exactly what I aimed for.  Thanks.
