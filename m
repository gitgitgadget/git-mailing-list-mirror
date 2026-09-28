Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9CE36A341
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581262; cv=none; b=raOLBgESuqz0iIedmjmpFmxgcLeCZwCo0xy0GOucQrrn8dwAgukVXvDoNH5/XtDB4SZXAykqvGuuXyfBbxXfuJIBW3Gjyghtes55Pv+osUsrf4v3pgZnIuw22QRX5WB4J4qvGXsYgQJXzLULkCxdZJ44aC5ttnzMudMOBRJk5MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581262; c=relaxed/simple;
	bh=e6dgcVTYslKcQOqOSsWFHxxkv+Slz7mpBBNDsqRcUco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbc0tkmRzAdBj7IrmOPIOmiPyE85qap0ThDfSyNIJdcUI6m9HyR0k/26bkLkVDec+m/SUgbJiKK5cQomCsHPK1vmribjEzWnsHeDBz4b4cdCl3BosX8wVqfHF179ztmrToa8qV2wXDbqCCFiLm8RREmkTv1ejfA2WbckkygQ7X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P6iTty8p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rx5uGMHi; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P6iTty8p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rx5uGMHi"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CD610EC00DB;
	Mon, 28 Sep 2026 03:40:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 28 Sep 2026 03:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790581259; x=1790667659; bh=e6dgcVTYsl
	KcQOqOSsWFHxxkv+Slz7mpBBNDsqRcUco=; b=P6iTty8ppvaS4xurHVnx2YQZ7L
	KO1VkowdxbQJgOG1skIYBQo6xpmIM4X8Xgz8dWlL0f/8M7fP2T9z1mZ9R3Wu2lYi
	N0iCvUJzGoE1HDgYY6ZcW4/k6523gA/cTpwKu2CWphDd8sXOWqh2ihIOgcuw4qXI
	KRzXAuHrCifN4ZCrZEsX+Zcu767u69aHjzVMrj+12z1pzWdYuKF55GzrpQzI5+V5
	l1CxnsVx1qbdsM5xA8BQxW76GbRt5tmYqHa2GCBSpBXS9Sx0e/u7M80SHpWJ1uOu
	vfSLH27UqKgYyGphx14nDppMD6Fwos1ago6FSJnaO7DiTUQM2JhuPgAgvkFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790581259; x=1790667659; bh=e6dgcVTYslKcQOqOSsWFHxxkv+Slz7mpBBN
	DsqRcUco=; b=rx5uGMHi/2PKAStasJdg+tkwh+p/oFtQaxmss9iM6OMAIpUuB01
	1yUY176yu9jj4EYV1pm45tCag3GWLMryFYC9uE36aN1ryycaLimGeq86FCuSQM+W
	+YYaegah7FSE9VHbxMijYbssQ5RPms15r5bZ7n7//JCp5mrg+Cf+ua8KRPyv76oo
	iEXUvTOXDw4cuy9+3LjmRC1MLRmxr5w3gC4e1MLlDhiRtnlezFnWqkSpFzZ0mKZ5
	imPt151ZYdo6SY3BRNTW9tgp8+pbpyvjb3+ujdwgqbz3lEvG3H0Y/E4tpkashiPM
	9e6H/xypgqcioRj1+sS0TC9IGg7s2YOTwsA==
X-ME-Sender: <xms:Cxq6apwG8G_1ze-wYy-kQ5l0jDBkPYHBojsRdJhOZmeqtjah68QWQg>
    <xme:Cxq6agvwxGDsagRLq565NHUZ_TapVEg0Bs32yKZlTa3ITyKms68Tepnht6hsGj3iH
    EEGSZ8FZ85xzFcFrQcurpKmAG2A5I2eZHpR9n6uT7M2trtBSzAMAg>
X-ME-Received: <xmr:Cxq6agsfJiyu3WlAz7IG-NTdAz8e7McMZwoEKFaoSQhRgi2kGyiChg>
X-ME-Proxy-Cause: dmFkZTF18Nu8MynLTfWRuIgBBp3PDXSVgWe5I0LHkCnnem5TUrFpJ6QceCCqOZF5ywBJyA
    nSjU7DUHzpHrmjzT/7OqDpovU6PRpNgy7ZF0gM7Zf07CzULd6XfCjI73sfTuz8Q6RXWDWc
    bVG9QGX+omBoHdsKbHPMP1/gFIY0JZB8o2vqEtPp2ZBxN0n35duYyAOfTeTvvgLjOZzyF1
    BZAJNL1Q/eauCbCxiVgcCXhRR+VNehV5KKn0HC993zEh1J5uhKmJ7b7sC2SbViSLOgQ4Vt
    lifdK8eEfZvhe0QoGaEiTT45sqpgNLp1F7HBx551VnmmPyueRXdY9q9CWVeuw51js70nrt
    eD/ljQjFQcpFfaK5lxys2WtPY3hsGNBloPGF0/Q7OtoGBFlT5u5yBdtPCOUA+ke/EaJBJp
    w0CMWWRMWOeQg4U7Zx+LQX574H2nGEoG3irOk8zHd5v9tpvlURhFOimIwZmuwrV8USUaNx
    rgiC83+fQrXdQmMxccnDUeGHW6Dqu/uP/T1AxLQikWSYE2e4PWFlZ3lt8vAfdAITP/ydDt
    kbdzOP3MsNwhdri/dbsLQDN2iO5w6sg9R1jd8mTNncSu5v8NaEEF0Dhn1rfFrGQ9uQp+ed
    WfrbZw1CtPv7hb7/LFyBalU3lbdYVBxOBXbGlmVsGJPOZZu6TgHv9WSLbVTQ
X-ME-Proxy: <xmx:Cxq6alOdDR070OMjCiuTD1a-rs0NGn1hypu6Z3RGI2dRAFf0quaShQ>
    <xmx:Cxq6au0JCgeCOvPJNpDAveqF66f0SdOYW9RCac6F__XeESKZz51pTw>
    <xmx:Cxq6ahOpPrserNmUAnFKwCoAU3OSkL_lG5R2-6mHi86SdKFfWgXYgw>
    <xmx:Cxq6au0Y7MpHGo96OdASylVnFQHYUlG7BVixnN_lwk9DDDWwcoFLtA>
    <xmx:Cxq6ao0_aLIeFfEywO8vNKh3Z_Bpok2Ly6U-Zr3slICP_7Y9GwNbdOtQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 03:40:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71796eb7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 07:40:57 +0000 (UTC)
Date: Mon, 28 Sep 2026 09:40:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Souma <git@5ouma.me>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 1/2] replay: allow callers to sign commits
Message-ID: <aroaBm1G2OjO2TiB@pks.im>
References: <20260703145037.69832-1-git@5ouma.me>
 <20260912160045.36064-2-git@5ouma.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912160045.36064-2-git@5ouma.me>

On Sun, Sep 13, 2026 at 01:00:44AM +0900, Souma wrote:
> Add a signing-key option to replay_revisions_options and pass it to
> commit_tree_extended() when creating replayed commits.

This is mostly sufficient. One bit of information that could be useful
to the reviewer is that the infra is not used anywhere yet. But that
does not warrant a reroll, as the patch looks good to me otherwise.

Patrick
