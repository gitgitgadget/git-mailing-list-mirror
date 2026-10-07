Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48434435515
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362444; cv=none; b=K1CuXQkcTVHeNCQGZ1EAf26qzCp68F1tZbuMaL0R96yqgUY4GTtDD4ZaYxtQ83CQd9xvw1+RQaZlbKJypHQAHul8RzMdyFYVQQ1hEbqpz4btaJG12RA/v5rrtIaMWbnL767u8reJwklugvY3US5Lve3xK+aMdbbetKv+D89kM8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362444; c=relaxed/simple;
	bh=e3pNEx/Js4SpLGMfYuaDXl5iIvEmhHIcRvKpAHxGksY=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=TkDq6uofvD/1v687Eg+jajxoFQydKCGaLcHv4OIFvu5yWywRx7se28VlFJ6b3t/VW20ClIiFqg3KSGDestxlCfyMoJNjZ6ld55JyUONOZhVySmLpxZBNIyTAa6XTbB2pirtmrXIJaKNi3WE5BFb49YBlB/To+7r2JChkGZBCeLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dicarlo.email; spf=pass smtp.mailfrom=dicarlo.email; dkim=pass (2048-bit key) header.d=dicarlo.email header.i=@dicarlo.email header.b=RfEjRATF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y2G9CgLt; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dicarlo.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dicarlo.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dicarlo.email header.i=@dicarlo.email header.b="RfEjRATF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y2G9CgLt"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B2401D00157
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 04:40:40 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-01.internal (MEProxy); Wed, 07 Oct 2026 04:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dicarlo.email;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1791362439; x=1791448839; bh=ta
	tk6Y5NNnxqAT3DXjVeYBDq9a0wJPXMZI85YNBH748=; b=RfEjRATF5y4z+gs14J
	cd4AiaUw1mQ6dLWgx1Cg4c9svu6V6iwhy6ec8QXrGgZRdySfKD2InQpMr9xriGTQ
	7+2F6Y5pGKulZN3iJDC3gl/h0aaHUr0PWJy7ZnJgRRsYj1d5ti2jmIYpmZd1HWjm
	f0Ipn8zD1pUNAjQCIgYOHGwImOkLE0JJHfUWusM48wxV/m6uctN9vJ1K4i0Z4/jZ
	uZa1VomIY0fngIvF7FW21I3G/KS2JfIKz86frq6OwRWn+eMLP5e/9qP5ximTfv56
	BQFgxeRnNGnm5AX6bwJAOTfAhNQHDN4tasHMs013CLPCK4rsHMoGEJjn5Jr4sxPP
	Driw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791362439; x=1791448839; bh=tatk6Y5NNnxqAT3DXjVeYBDq9a0wJPXMZI8
	5YNBH748=; b=y2G9CgLtujRotqjVP5eeE+XLDvOMwG9cwfgvODTCmxkurTtTceS
	nZvdICw93zCV8bKMhhyRrqUgk7pJ83wwM7MVaIIB2kaPBYR8OGps4wfxCuj2ivjQ
	hj5pNPUNyFCIVcnRDQc9RxspRkS6/5xy0KNGtGCAJBSm1Q+a1jgUp9ANb4FxhdYo
	r+HXee4znykks2JlIGSM+OWc7lKP8ncwMq4A2jrAi9vP5q+e0+0zm3kyj9kdqYdY
	kWM6NmtRe83MfZ41i3Hs1RtvQrXHvvSOzu2iyfkLwdE/rYNvtw/FsiSEDjVQxbIc
	/4JQHv3b1ZBvr0o8azycKDq3CWu5j20KWvg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=dicarlo.email a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791362439; d=dicarlo.email;
	mf=PGx1Y2FAZGljYXJsby5lbWFpbD4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:cncokKbD02HB48JQO3KYmWcmWg+iCSM0fgQcGklnT2zofFi
	w+jrnFMTP98GpXsTm2teYNxzQ5KI44/Q4x37LgfApyleWIqxkkwHj4m1c9J7hS6n
	jfrf8Y6Cx2CMQ6Ob/sBZe+Eji2vbKk7kLEsndjR7xNfvg4lA1OyMLaSwzQw/PJRt
	uGANv5ULpFBUQmjCgRLyQh+RcnMN5VeGg596XjJQiqRdDqZ51ZADLTSAK6mIyP7M
	+qT04R8KmM9k3zO9Vb+BDepMvn+LZ/6XjkXVSi0NhvQu4oUGd41IOwKFeVixnTHF
	ZZahZvOGBtINhB7n7umudJaT18xaXqM2yZ+7WIA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:SwRc2Nq9uhjD8jElHaUYlEswLp458lW19nB/khKiRGA=:e3pNEx/Js4SpLGMfYuaDXl5iIvEmhHIcRvKpAHxGksY=;
X-ME-Sender: <xms:hgXGamAEKNrx8oyzB_RChbXQFi7UJ0WPoE1sejFdIewiUyg5-4QchA>
    <xme:hgXGarXwBvvtcWOMl8wV2iYOfuY0MjusQf2S00k-WlE7hPZxiwIqHRi6R30QXtBsv
    MtHl94NxxK4qUq_WP6RDqAI0Wn736Rk1TpM18YIxQz9qdsmQJom-G26>
X-ME-Proxy-Cause: dmFkZTEwK4Xv0hsV45wHhu7npil+d2dgCrgYzZLhRHymgXHxAbRXJTgjhFohk6/uSMAM3F
    YvsRObF7/j8vwB+6ZpbLADqivnAMuHDnH289+ktcc/vTBmX0b8fQ1KKRNgTT0e+l8L+VJ2
    K2sIPzmpcJTkbT3SBBvb4MfK7dyRsCoNVPocub8HjPScGDqAoOgBhByMZAi2Mvrxbew09V
    IAPnuUgG0/BSknuV2xr8WNeM9IScv4u3WOZl4qc6KORyBakzY+vaEcENYElN8P2VxgZMuV
    dLXvyHGQbjNiwkfu6EnxLZdtAHXSBShaTqzXI4fLEq5+DbgpgtpVtprZgJXg6Wncxt8DNi
    oxMKRPE1tSFBhIY0CmJLJPCthb2whLKXLdYFUcP3NMWdfZ/2Je4HgI95L/GK594tGxQu0I
    0Dc2mPsg1QPMdiBI/Oks4nsIJOQSmYnxdRyOf9K4l8rHeV9aa+7jECI8LV99LaxAsWdO8t
    H59KL0n29ZHNhUUYA059OHTivxgW4M+ps6DM2JvX/QJyMoMi20fHNQcF03VTvI0pWhJyFU
    v08HRB2JPfdcR19tC4KJWMcj1+w/l4aqogZ3R7vgWmiznu1v9h7QZxDF+mnyTG6OXmkJqB
    CZB1zXsVbOMCBRinSMnAeEoB0jqmQfQ5ApiuP5Aip1vXb0BvZbHxj99nynCg
X-ME-Proxy: <xmx:hgXGajS4fS8biql6zvcB8m7pUjQ_nlD8mv9p_Mq_8W7RyzeUeYL1qg>
    <xmx:hgXGakuna3xswD-qHIzbVs2pn3FTW9eOWPbBJMXeP9H-q_wBpfX7XA>
    <xmx:hgXGaluSbJahSpHJJGF3A6QVW1ZcmWuCh9k-tJi9AxY_S7plfUhwfg>
    <xmx:hgXGaqz_Ri_-SafF3IuZDkRNcaRvynq9p3j7GdLgyQZBC_DkNAnj7w>
    <xmx:hwXGalmveQD_rNw_alMfl4SYKqntccMPEJ44Pv9pWewzbdrAkAmVlyJj>
Feedback-ID: i3269492f:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4729FF8008E; Wed,  7 Oct 2026 04:40:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Oct 2026 10:40:13 +0200
From: "Luca Di Carlo" <luca@dicarlo.email>
To: git@vger.kernel.org
Message-Id: <e30c5b13-5ca3-43d1-a87a-d807b71bad7b@app.fastmail.com>
Subject: git non-intrusive clone
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey everyone,
I am reading more and more blog posts about job interviews that require the people to git clone a malicious repo with commands executed using git hooks. 
I wonder if we could have a 
`git clone --non-intrusive ...` 
That would disable all git settings set within the repo. 
Maybe by adding a `.nogitconfig` file or something, so that the developers remember that because of this file, he cannot push or fetch, or use any `.git/` defined stuff. 

I hope this is the right channel, sorry if it's not. 

Thank you for all your work,
Kind regards
Luca

Cordialement
Luca Di Carlo 
