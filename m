Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE284F55C6
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577360; cv=none; b=KTVYlf3bTKPwxg5YJjn131ArYWfidBeTedy3nZ9H5rc+rLXmuz0e1eg4X2uF+eyGAZOTTfcdF1A2jRO2c1hDNjp722uOf2tii4WX851SNM9ihbtx4dn4KuFse019m1+WNar3cKU6lw3mPvhFmwU4VTLxoDFQcnei/c5cZIeRmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577360; c=relaxed/simple;
	bh=VtBbl36/tP74UtJSxkB3/YmsXQvK/iLRl9viUK7wk0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dwi3mErk9oLqbb5WMf6kUITWbEeQtcUiwxC1BZ9HUkGxhewUjsXOVfP7KeFYYZR3tDHlGfFQKhjtLGr48cZ6TtghntBepE/gW4LWpFiPtyUEddIoNnuGqeXUxPqMXSi6CxdbixclX/8fVia92aQe/KheOzpmm7owpsRPtonqExw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NaBTNgvd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EiyBJANe; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NaBTNgvd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EiyBJANe"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D75527A0089
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 16:22:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 09 Oct 2026 16:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791577357; x=1791663757; bh=VtBbl36/tP
	74UtJSxkB3/YmsXQvK/iLRl9viUK7wk0s=; b=NaBTNgvdTDAmQZy+r70ivsT6sk
	RQgzxOd5vvCJ1Ts3rGL87uxhjBayFIW7kfufuBnrl6iQnNwQxlbG6kx0YoWTOT7U
	v9dv+YvuHm177puahbNnrHCcBxS6PlxRaW3wfErTvMLaV28etPBM05Y5GABaBelp
	roZ5i9E6Pd+rhKzIbKNJzoZWmBZFZepueufNNt8eLzMwN/NWy7fMfxMkdRmsQN1F
	QOJmwgiCWX5oXAUyetXRO6acJ81hKc7Z4Ykfws5zCaoeMG3nC4dbNm72Lx0yFrQ5
	8PDq3/PbhVYkN7YzZz5TVO8CQ4EXEzIERVdPesOqsIWjg6ch81gOO+QBG4mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791577357; x=1791663757; bh=VtBbl36/tP74UtJSxkB3/YmsXQvK/iLRl9v
	iUK7wk0s=; b=EiyBJANeJu5RwU2e43l09f/jhYOt+/lgWpjkuMV9uXwq8LtUbt0
	Ev4Qv6g4jNIU6sqckVpejED9xNHSsox0QtaCIjFNLMjARxPq9ltC70+knTidR0Sc
	6poLKNB8o0j8EIPb3W2AN1PjlLVfYQkJNWe1vXtHhfP0nVppTEuDK/iuBddjar+A
	ZdobXyOiOJX2lDtZYWGwGjXN2/DzB3Cky6av8rfp489X2NDnC4yZ2rouKmbO9+Od
	U5IKQ5k5rrNu5vZDr89ctF6j7KxwT7bKyoUym8IWZPKNZsP9KttUYdPwH+lOdwxv
	5oBuLTdwRvhts1vRM3rPA2fMFd7TnztIr0g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791577357; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Qc812LDhnED6KdGIUex9gBP8SrQw5yBILBzvfX6DV0FK4ts
	9V06XloKzoEGrNJZYQzi6STXOxnuphyTaFqlaV6D8iq8OUP9fWUWC5oBRwwnX8WT
	MC1k8H0sfyKslEK8SRxfJO4lUM3ytX9desDTQ9Ae1e0jgIpaFT3AHOSRTFgS3bgb
	3USq+bEqDBs99jYT9eSU3HOMp8aROrE32YGLcUYNQJxXVExsNh/NQaSRN1zkjXSD
	seL4UHKAKJfA+jicn9LBXAiT/XlMv7n/H+2Rivpct4sC9j0Sh3Ts+BRw2S+Mrj+b
	bAj6vNJfQ6U2NzQlhIQwRwis/iSHDSmDgnrg02w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:bHxMpRVsP1ctM5Z90WTN+6zK48MDIvf1dUxZEn+cmIo=:VtBbl36/tP74UtJSxkB3/YmsXQvK/iLRl9viUK7wk0s=;
X-ME-Sender: <xms:DU3JarAn494nLfPRZnVfiSe621pQjFZqJE7K1fHveini-3UceP7qMg>
    <xme:DU3JasETiqB2SekFcOggvuuzhzZTQUxMXWNw9yRBoF7gM9DwO127SOEKRihebBG9t
    7DFSiwPzRyr172Gh21Fvza5-2iq5VtiL2Uk8ACD8vximYdp12rV1kc>
X-ME-Received: <xmr:DU3JajLdldX2h2bPak2fm2_Mn1GQH6HW1tAlu9cHQHeyRSBho7hVoNGViodJER1XwlgJa2l58cbR3uASJA-jZLVtoLh-2DcbPxiC>
X-ME-Proxy-Cause: dmFkZTG31iWcuowPgVQYqWZ9H7gfM9U4vD2+e+gfovsa7By2h8cIoaBoeHKz1YcN+7qxKA
    u3zbiLyknCCHQz6N0a++++nsZC2yFf3KfMBpkSKDHfbne1Y4cTZAaJki6JKVw+WSysFblB
    5W6kQ7jJ4K99XXua7cva09FKNhMC9GKEBMdc/7r/Q21oELwqNWmjkVu/RW6JeR4xKxi3hb
    VFmu8qZ59QaxetK2N1M4bgs09cmPnMG+jftKqZsvcmJgYIwoDacfzh4ypE14WlqfjDWp9o
    6OxcWwA+gDrkuRBXx4x/JCHxhWyh/EjnNwaqTWBbybbBAS887+n12cHWgLC8T2jQYWpMS3
    +7hfpfm9eJF1X0DrofpAYnFRmOWcB3v56n52Ft75a6m5GEnttI/6nwIdKq1CyL2rT/ZSco
    trryY8Yg0gYg09FgYl47SP8XfwdnKkBwq/5jSIL/9AC+D8xxgoSFxaNGoKFl14apvkcNiX
    rT60+w6xKtprU9T/hFFVn4T21o+y5wonSfE5sOldY6G5KP6wJMvcRwZFRMP+anfx3wwXIH
    clnFB4xBg1t4/UQyobuMJWNyA7T8B/oTuyf9R27fr5lvbScFjZWP39Qgh/Xa78+WkuDC3Q
    QnllSieb0LbKUCD+2Zwyq/F4R+6bIxxxXak1BXTTlO3KlU1ZOcz+6v5Udsag
X-ME-Proxy: <xmx:DU3JaglQ44gg87fFNuGnsC_dSgUPKjdFV2qX4p57wQFRtwuIzprNMQ>
    <xmx:DU3JarR3k2euKCpv736MK4CcnL1LDb6kJoR0l3kjrBg5Ez6o99nuUQ>
    <xmx:DU3JaiLDMJGOF8O4VaDAV4iG53iqocW1HCa5MkPT5Lw4kLM8l-KqDw>
    <xmx:DU3JahCImBvaq6anTgL2ODj4GdApuhDiorWMcKyMkJgy2WHa4NcJ9w>
    <xmx:DU3Japv44Q-qekkUNCy9bVpXisVkM3wdYK74hO1sqmDgRIndGV8sqOiT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 16:22:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] ci: drop redundant linux-reftable job
In-Reply-To: <asiB25AareJgkKL5@pks.im> (Patrick Steinhardt's message of "Fri,
	9 Oct 2026 07:55:39 +0200")
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
	<20261008-pks-ci-housekeeping-v1-8-baf015c589c0@pks.im>
	<xmqqzewoys2h.fsf@gitster.g> <asiB25AareJgkKL5@pks.im>
Date: Fri, 09 Oct 2026 13:22:36 -0700
Message-ID: <xmqq7bjqoc8j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So how about arguing the other way round and making the job more useful?
> We don't have good test coverage of reftables with SHA256, so we could
> adapt the job to exercise that combination.

Yeah, instead of doing sha1 and leaks, doing sha1 and sha256 would
be much more useful ;-).
