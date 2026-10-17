Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F493D88EC
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792237574; cv=none; b=AzAVSaYxz6wCfp/6s7P8PDXEB1OGWp5+H1rDdyQqHq5swk6AJeCjmjpKgNGaoTTlHew8Ed+RQVAVw/NZZ08z6MvjGqAcLb4femU8FcOTGqEvj1nLL+k+LAzB9jp30uvhCyqqVc+Rt3OGT4JnPWlmgEzpSsokrqyNQ8bdk7uo/IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792237574; c=relaxed/simple;
	bh=6xHQ1ccGKF3rA3DKvwJvafmv9682N3Rk5wN5ht9w8FY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hnBZRpeFFzVEA0UQ755RzI97cJ6fcHn06QXZoW96WPKPTx2Av7Si7/cvRptjAHTL3Netr9+8HWu8VLHEgDFX4v9IcGH3n7s06ZwB3i+lmmFOlsPb2NN/mOBqdT07yDgpZ0QzuG7iQGdN90OMWKcDGR235i1+Y8YmUrrIV2cRWhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SWcV3H4Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AOEej7Ak; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SWcV3H4Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AOEej7Ak"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 0A9001D00060
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 07:46:10 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sat, 17 Oct 2026 07:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792237567;
	 x=1792323967; bh=6xHQ1ccGKF3rA3DKvwJvafmv9682N3Rk5wN5ht9w8FY=; b=
	SWcV3H4QMxMY6dQbeXeIowTZ0haF51xPwr2LihOAveYVCd/I9IuY4MSDGHe58hdd
	1k7ML/XaLoILadiTRONn6mhfedMcsgAzsuead2VoZR24UZlnTll1lOEbR6YpT63p
	SlcTckyFtpTHsysdYtbFxeefkN8l03ks+vnUKtdiKSGSvHZujwpMiKkpBQM2HlG2
	kcpqSjyoaN48O8sIAZmFerjBML3Dlha1IzYpt3/Rgt72pdSACRlFHpnzRK5j1gQt
	pojIP5/4d0pR9utfzePXZMhwMFuV+lCZ0f1AMJlHLHZ61T5MLiPcUd7x/fL02fsw
	M9GgyrP/DvuCElFwZEvYVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792237567; x=
	1792323967; bh=6xHQ1ccGKF3rA3DKvwJvafmv9682N3Rk5wN5ht9w8FY=; b=A
	OEej7AkfJjNIERSDomdqpI4INnyUxvDRj1ku55IAfF4wDPI+uE96tkTDgb25Tryh
	CPNeuoms5L6mfg7TyZK9Utn+A45WZISLaLAFtxKFuJAoW336eUV2D+hg8uQscbWK
	gIhRdnJjQ+GArchf7zRE79PzLQeFiBEASboLlJtE/2O1hG+SOgayEjdU6Pe7V/Oc
	6PDwoeFIfrHlN7exPpeoznJ4Cto6YR+RbB8WcLxLKewRoZNPaXw2zH2SogWr/47D
	RS7HlLxGvgSuFQq8dnO8Cys2OgGNt31WxMKLShxZiTj1usJFGOdCLyKxICDnXQsv
	05Cz8kfz6n3RU8n41mEZg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792237567; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:oeMDxmKutXFdXA+Unk6lIaJcsUjKcMI6qTbpv6dAVC+r1uE
	h60rrLI8m7DhmuRTejuisWnAk9L28gJOmcy3924fpgZ2OHPwhC7hF1qU+ma/ojpu
	RnLKzom3BMkwTGET9OgicVWJmLxi3HQD4LlmbMPwreiSbbcosPTyvcfue6wfe3we
	LmcBxohsJiCOy7P6gcC+KI/Jxp3k44VHwE0Vnttle8XtuCYSsRJg3GwTvxqOEgR9
	+y8ETFKwd4yIE+8PPJbPwouY/4lba3CVXIsM7fBssS4ATOMMAKGHpSnvB39OgWlr
	+xU9Tejf2dWmtamBPq5Yq/koX/yp/TZxrYhJs/Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:i4VAYycPJx9PUwyHFh1mCvDf2LJKi7bPSTMikXd4Z5w=:6xHQ1ccGKF3rA3DKvwJvafmv9682N3Rk5wN5ht9w8FY=;
X-ME-Sender: <xms:_V_TauJbxMK1mWkWLi6B3rvXfNaE06er6cRPdWJUqUhD-0POYKcnzVQ>
    <xme:_V_Tag__DuSA_I9wEho8C18jXco5zyWmVQUaXrrQy-mKcizDrSjMBBNJwpMmoOJJZ
    6amopJck7c1LsbZDPCmf9rFn9SJr-Nw6pJyJLPo-6Ob9KPebJ0tZD0>
X-ME-Proxy-Cause: dmFkZTE6+VY+6gF+8fRHEqeuXQihvZVeWunekgMccNLW69fXc6ooq+PSHHEjO4mTs5gXYS
    iIG2ICQAiBTJwPx7dEtBi2+rAmoezY/2AxYnRr2C2gI6mJHFXKES3FN1bSncyPmS+3ZI2/
    YIItLC9LMTjE+SEq8CoLBLDS14nYdjrdlL3uTn0ye/+AHfjKlgFk1MCrtvkKkDW4bnvNQK
    QAq9r+TuttdH9HU0ES0ZEM9d+5L/MK0dijTChjrLJgqx30jgOc5IQmzcc8XN1uFmxAHlTq
    wnKjGcNNRYjITMoybs2xPa3o7gZYqoXbc4w0DYzBk6n7BUK3Qd6vBWLAbzG8As0eRYC0r6
    hraogYj2prNiak5sCvU/Uz1jscc29qGZ+f3uGdYvcYkGcQkQSn17z9r8T6Ich6RwLmVWp/
    daW/vqFTR7pdipumt71akee3NMMzshAm0/hi1tzjfu5AM+bqdwepRHbXxzQ3YVXJZUwH8N
    bwp/2m6SUp4lNxHQEHTxV0x9H0XPxEFwijH4WbpjaIF6tLVJsNygW1Ekq7D6Suc/BY/lHO
    MEkLWnhCyKr93MT945q80SR/25GN3XEi6laF6fvFYWCJeAB6c6tTpVT8m2dUoD/ZpisMhu
    2N7VUonQPYUJ0jnh78YL2+8Wn1AdSGjPieRHHACmO2I8NYRRuHOF9ogsMIjw
X-ME-Proxy: <xmx:_l_TagPBlvM7JQcZZxgzOPaFMVgFJsOqwGhP_5Rxz0gModtCXYrwXQ>
    <xmx:_l_TaocK_jZrki4AJskmL9xK00TUr0udpWfqNhNJ6buK4UvRnngwGw>
    <xmx:_l_TanWCKaPlTPRIkYzNSLlb1b_MJgA2dwVJ9o9g2fN8qtj1q7vDJw>
    <xmx:_l_TaogDuoFa8z1BmKbib7_0KIF_B3cXYu68fc7yN_w0fPlJCy8MWw>
    <xmx:_1_TakhksKVENBsGVLrLHVw9biFyok9Gx1OSTjNmTLA6yfkxr22Z0Vnc>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 571D222C00A3; Sat, 17 Oct 2026 07:46:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 17 Oct 2026 13:45:45 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: kerylefondji7@gmail.com, "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, christiancouder@gmail.com,
 "Siddharth Asthana" <siddharthasthana31@gmail.com>
Message-Id: <d109cff5-2257-42e4-a399-a99a2ab7ff43@app.fastmail.com>
In-Reply-To: <20261017112518.4548-1-kerylefondji7@gmail.com>
References: <1a146af667a8bcd4> <20261017112518.4548-1-kerylefondji7@gmail.com>
Subject: Re: [Outreachy][PATCH v2] builtin/var: refactor to use parse-options API
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026, at 13:25, kerylefondji7@gmail.com wrote:
> From: kerylefondji <kerylefondji7@gmail.com>

The author part should generally be=20
your real name FYI. See SubmittingsPatches
about name or =E2=80=9Creal name=E2=80=9D.

>
> Migrate option handling in 'git var' to the parse-options API.
> This update also aligns variable resolution with current Git configura=
tion
> and attribute handling.
>
> Signed-off-by: Keryle Blondeau Fondji Tamekong <keryle@DESKTOP-0SUCFI3>

This looks like a real name. But the email is
not real. It should be the gmail one from
the author part.


> ---
> [snip]
