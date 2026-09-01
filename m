Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F9C420898
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283968; cv=none; b=Pk2SfSRgn/kAm+BypDzN+yq0QJtHoRb6cy5hA7DySSKLd3Vbxq2e88i9uz3PQYu43RTl88tZ15gc68YWkuz11TwYpdOL5PcB1Ng/iwpaax2vfvdADJFu70pkmEY+XlgimA1pBRIt0dcWyVufsFLJ1LRMH4CH9aGlBlwYY19Y3iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283968; c=relaxed/simple;
	bh=D0Tlu0KcNYm3SK+mIQGSxZUGYN4L79PJ96NPfbZqoCo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DBFt59yksLpNi1mTuZCS66+UcUOBVQAuWYh49OypUHW2LDhnAQiENqPBrJCMGMWaAc6TXvWuyQFlFP0rWLN+u+rRCD/KDR5ntTDVAAsGuoy6/BrbSEW9i+geoHsYxR+tBhOnSEjoqyNcxCVM2DYCZH7jEidaFvCQkLShWjWwa5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j4Ob0GsI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i3EcPn/s; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j4Ob0GsI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i3EcPn/s"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1BB631D00116;
	Tue,  1 Sep 2026 13:32:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 01 Sep 2026 13:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1788283965;
	 x=1788370365; bh=WguX5Z9b3z3H5r62+J7w0+yabkkzSqslCs1VEvtaUw0=; b=
	j4Ob0GsIAhpJZxUsIqf8aIHaV4mitUkmpZlt3Ax4BBSv/wQ8EufNtaeKlvBok6iT
	G8SbXMwqHzku56YS9EZnhwYFgktLflq3SZ8qGqFbbCVc0IQkvsJGJaLuct4MnakZ
	UkHOYfiHWWQPcGuxxjZleAorYcwrUGCEDWrPCdIdNiMoe9Tif6iCsWJntoiUPRJI
	1DKkMcv2D7Ye+kuZ9xrjwMOfA43d5aScXRvzJB3nMFF5ODYEP8p1qX4Rgmg8CD0h
	45XVvsxV9cnYSLxJzQshTzz4g9Ny3QzaeMDLtrdySC2dsbHhj91ldhLTuHaANjt1
	bj8AH/U/0Fedu8x9jZARyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788283965; x=
	1788370365; bh=WguX5Z9b3z3H5r62+J7w0+yabkkzSqslCs1VEvtaUw0=; b=i
	3EcPn/s8rC3Iarst5t7zLhM3kRWGP1xUTCMoSpfbkMPSVee6UjFK49Fkf0iVu9qd
	gDV2bpgFfSYeliuSCIb5Q2XG8zwpBKGneY8Yb8gtDbhaommCqfxWiN0Lm6UPgGUm
	oTZknWvIgnFv6fc6Drjl7aOCYKURQAVsr/0RDmbdrPGQYKgb2kz1CzRGqdeYzrei
	HmKUZqLuCcw/DmWXx5UENSHqdLqTWGNcg3wy+a3oqiB0nu1XgJIld2jBVrqQpk9m
	D/eAnIn1rtK7h4UnbRAmPfsPRTcxi9VczXFsprTJwxW5lZNvRsTEN0SNEXE8U6Ea
	ucR1YAJBWqyYqKWVA+oNw==
X-ME-Sender: <xms:PQyXauxo-CtUM34td_U0pVNodmCD115VcvlpQ_nkBG9MR8IwBFmBTw>
    <xme:PQyXasi4ZkecFulj0w468BDspp4PYAflDOk2jW34AJezmdz0CEiDv1lJWX2AOA6KG
    EmHkuo2fUGdX147UHL50KvNECzUfQvh8IHI-RbtQ7xlNr4TGWAFANE>
X-ME-Received: <xmr:PQyXaik5ZGQ3qUNJXJdoHUvTltTGPd2DXggKwDng2qyLSpEse8q3LJc7M0BOHMLKBx_fdW6Uqm9qGWvktUQ9o6Wh0OlJ5FMVWw>
X-ME-Proxy-Cause: dmFkZTFCgLo3ZI5o8jiK14yOrb7mDJlnkDAV+H0TSH0ktwHGTrnaAofuikXHXWBabAPMmw
    jUL47TtRRtNyVnKppde4gPfyMc+ar5bGMZwN4Kaw44LeMnO0hzucWL1zrMUGVAHT8xq/qF
    U1chkrcY3fuYaspO0WKlnHnl957GXWr4ix5YPdANY/53zy4T4cQr5PuDmCP32MIiFGG+Ii
    HD7XhbsZMtgChoS3k5FtmSWX0qO5opMF6KzrpZph/g3DbKWFDkZOvOHii9zH5lyuxnrv8w
    /nS3IYHAuVK7+2G27S/2tMZy+ac5ZIWtRaY3+OQjPmYiJdaLDPVXRZvDU0HuDWBnrYEzgC
    MCtObD9Vbj45Lk+8cMjpViV9U7PmNFvSmHbWFVk226WPYmJAOrCiW2YhAnem9Nk9zxIF2k
    BuFcVIBhbARXvNTbyhlnGYG3lNesEs/LKdIEawIDvZQ0uODHmcTA3fyCC2mWK/jXMw2KsJ
    3YQIofLcR3Lzf+Izrg+5wkMPyWkltH30BF4XlxJ5gsSjR+3T+R+DP0HuWV4/ajFWxOyc7i
    wLTFiuJPUb7+ThK+/ed4eGC0tECTUDhFSiiDVTr84ASUkKqJONHEVfKFe/7oMI1+vsHAK4
    N+qei+XDvP9WKQim5O0dxqfha3OqJUKOpLYXbFhT41shYd60hlOpaeMWc0MQ
X-ME-Proxy: <xmx:PQyXaqiagpjLwIBVQEDJWdVIncrSXseYznuU4fdKKJKCYJImhLGUiQ>
    <xmx:PQyXau2dI9EqGatuSmuUnMAdJhtDZHlJQdi563G_ckMuCfWLBP_Nyg>
    <xmx:PQyXarKL1nq54zEoUbYR4xhxAQ0k4Lm-zW0GjsHflZ4YGYgEEUYFVg>
    <xmx:PQyXamzCzaZzJ0P00yEwgIDwdgpFrPS9Pa3c1kICBThBQ7dxUoh35w>
    <xmx:PQyXamOhE1fwiSd5uqnPfaefaBH60H1wJMtRKYrJaZd75PH-6ydwdq9r>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 13:32:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Todd Zullinger
 <tmz@pobox.com>,  Olamide Caleb Bello <belkid98@gmail.com>,  Tian Yuchen
 <cat@malon.dev>
Subject: Re: [PATCH v6 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
In-Reply-To: <CALnO6CBKWpmTZW+Z74JsTQvr864vFsvwvRJeKAu3LfXZJK-1Yg@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 1 Sep 2026 08:38:45 -0400")
References: <cover.1787231825.git.ben.knoble@gmail.com>
	<cover.1788206466.git.ben.knoble@gmail.com>
	<0a611f614041b165140da7f2546c058178cdbfce.1788206466.git.ben.knoble@gmail.com>
	<xmqq4ig9vbb8.fsf@gitster.g>
	<CALnO6CBKWpmTZW+Z74JsTQvr864vFsvwvRJeKAu3LfXZJK-1Yg@mail.gmail.com>
Date: Tue, 01 Sep 2026 10:32:44 -0700
Message-ID: <xmqqpkywswqr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Tue, Sep 1, 2026 at 12:35 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>>
>> > +core.useNanosec::
>> > +     If true, use nanosecond precision for ctime and mtime
>> > +     comparisions between the index and the working tree (if Git
>>
>> comparisions?
>>
>> > +     was compiled to respect this option).
>> > +     This is unsafe on some platforms;
>> > +     see link:technical/racy-git.html[Racy Git]. False by default.
>
> Ouch, good eyes. Obviously should be "comparisons"---I've amended
> locally but will hold onto the new version for a bit.
>
> As this topic is not in next yet, I presume that sending a new version
> with the typofix is the correct thing to do. I'll wait a while today
> to see if any other comments trickle in.

Yeah, and in the meantime I'll locallly amend what I have.  If we do
not hear any other issues in a few days perhaps we can do without
the final reroll that way.

Thanks.
