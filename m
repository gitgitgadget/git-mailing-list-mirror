Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC99E4C226C
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214654; cv=none; b=c458Zq7qQAsGTph5l+4o1SMMuGBjB+ks6V+q5wrmPQP088JtV/+B4eD+fPN1ZQIIQ1SV3Sgo1uPsvnVtJOXPCubb5npeHDy1lBUzYUevUa+ymJt0HpGO0QzVf5Jk/DfGyZu3mNHtA4MoqFJW/2Eqlje9PJs+81xDf95zlUsp8Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214654; c=relaxed/simple;
	bh=Cpsb/5lslMcZAH6lcfD8334ELfU8MAA6w64qW9unXt0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N6XXYiBKdllAe530RHkcCv0TLKNHHfWQrXgyv0bxBzWxgoNw6TiE6hLdntsM06hP0CCb11vXnwXiRb+bLyEXzGfvaoppBx3vYHtTA/TSN8121kiibf2iYVhqPfLuWFH58ydQYdpcnx6xh3cEgD710jDvkSoku3FUHsmSwcRY7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AkjxUK4p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YGQlI4Hw; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AkjxUK4p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YGQlI4Hw"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 02CBCEC08D2
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 11:37:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 05 Oct 2026 11:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791214651; x=1791301051; bh=2QAshSuZO4
	yTF0XzN5npGLgn2uqTOmgfNMyOVExLP3o=; b=AkjxUK4pQv2E18t5Stxk6UELt4
	laCbN2mFDwI1Oidze6o/s2+6pPLjzUm6mbtFGQFLHTotyjst+8Eqisg+eNqcP8Ge
	jYv5b0mcVXj9u5fSMKG802UoPjFsojZ76udB6xopaJp1POV8KlGIYXmBv6C76+eU
	tTCp6hcelqS6iTJ2cBmYkjAWYT7muLUNZEf246CTW2VuYK9+TtFTMw1ctRVUXhBW
	71rnHa93RTWBvw/9gIcnTDSTv0g2IBhX7ocsKe4Mqsnrva/4bTp217mr6l08cLCZ
	gNa/GyCF0msn9I8Iqlsx07Myo1pLwchezN+tWBwXO+GGVfxsXH0X3MVWCq7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791214651; x=1791301051; bh=2QAshSuZO4yTF0XzN5npGLgn2uqTOmgfNMy
	OVExLP3o=; b=YGQlI4Hw4FwAHvTyKoC3/NhBYb5wYP5lXyTOIMoKa7Gu48aZ4Dc
	dvFY4rDSHkbq9q9Ct8OX7EzYcW4294iatAbGBZc4N/Gr77fUCsWm9etXqLiUIfLT
	O9vpOi6ByCuIimiigw2sXt5KPp/IoFzHDlNGUc6j/JcZ4zQFI0G/ARIh+32MfhN1
	kCevB2pSnRnsVbw6shnLnUXoZzP5a86G3qxKwv5nvz7ZU9qO2lwRWXVkCSaCC4bH
	JxBJoplcOmANLzAxpRUUY6KypuF6saqcuYH0mFPgPi2xkTcONT8gLTYq2PidZpMQ
	+BjtbBKsvqOg+4+DI4b9VQ5zbGKJQXJEcxg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791214651; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:LZo5VaeCS0BlRxrtyA4WwNv+glt+RpcjOXayjAp1RHutPgj
	haUDXCHP42N4AaFs46YNLV5aDbb93rbpqU+YGVtcHNP572AcHohSrmB9Dk4+sXWu
	SvhdLZJ13OBgInaMTKXUK3TAMYKLvSaLqNNbzt8uhHotbOHlgSXtCtBgj7ct1iJt
	eciARLU+G2L1I6HyN/p1S8/l0rmMNM6jJ8pwd/bfXmZoNK9Epa30BmFaNi3SqTan
	YQmpKFjjbtd9aoOqn7EsEWPaxjQm3syJiWpFKOXSQnrSYf27ZANAVYi4XyZXL1rY
	DYndB512zcXrHfdMdoU8bgwGjA0GkcrcEKTogcg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:QCNCC9bOgF1AxBs1wuBgTUqh2gQXMxtOluVxtw0SWb8=:Cpsb/5lslMcZAH6lcfD8334ELfU8MAA6w64qW9unXt0=;
X-ME-Sender: <xms:O8TDajg5wMApFhsiPnifqzIT1_CfvF6Y7vm4jZuHEryJ1UNnekF7BA>
    <xme:O8TDavGnSaMazKGZuaGYkeWOvHoGRGwE9gbBYDbU4tEvfXOhWeBKI1I8HmqZ325qv
    IwHa70BCC3uQkHjG07UJqMxxiDiBNhzK957VMQ3NIelBlobd6p8nZKq>
X-ME-Received: <xmr:O8TDapTF9xbSRl6l_0MI3V34MZhpiOSoQ5a4XzTU7nChxJigInFw_5dtY59hFw-q9is7G5JfdVYcNVxsiVXQRur4-IVzQUOteOwr>
X-ME-Proxy-Cause: dmFkZTF2QpfWXAJkbN+n5qBuuC1zVlNy9/Pp+yl8fCiOz3R+bHhfkCZFaPkfldhbkcKI7U
    XdFJWzBFyjYe6XmagQmG99MhzQbl94rqmNpaInI20kKW+g3SgAxU4v2aPhtgKMSaAOS1vH
    r4isZuLGm09sIAwXRv1d+g6ehPziv+UMzx5l8UnwMOWH5aCO7nVo7KjDYevTeeBpyJyQNw
    N1qnCNGZtLXCiAH+m5wONj01kx/45bsm51Z1HpGi6/kpNBDWw8sNeka2tKQrr5G7LLLYCK
    QHNJvkGIUfJAHVmDfxZ30qE3tcdXgagQVSEWYJ/cOtJ/4/WnXo7zJYibWAwXyZn1014RTR
    htvnqFKaW7PFD203YmexNfKfuSVEPQiUVVnx0qBX2/tEeJzC5LJPFSOO1ZMCNzC/y3utnt
    Pb8zDIC+crQ/gtNA+RQUD66pSjOYpWBGJbzTe9sd7yAncs1WNXyvuSNbRwiDcyxg81FziW
    5sD2L9jB2lJSY0/Yg8MGVNknatgULv5sBVapWK7+tWbv8qiTawZs5IFRvwj4GNfxSe6uNx
    YmQbJh9/ZkX1hVp6GLyxyvoWaoCPMkB5z6cULAugLHTM/DgmZHlnxjw5tXfrD8Rcaqoaxg
    VhXecjaptEMS18wmzBtkjmapiRaRPlZOcIwDWa6OGgW/FBINO+M4Zv4Wqjlw
X-ME-Proxy: <xmx:O8TDasw1W1RLldsohRqUnzdscntSx1EFOQDI4GPOhNXZTfHB_LliWg>
    <xmx:O8TDale-eYWBSucgPYirwBddEktqWqkmiz50hae7kaPqCxjcbR8qvg>
    <xmx:O8TDavMyxACef_sRMcecYkDj-cBpUH76xvB8yoiSIoNDO2IozO1GVA>
    <xmx:O8TDagtUF85ISM9oDin-FnvkXxBpTvN0gFqK8o00aNI-2T8k4R9jeg>
    <xmx:O8TDavnf51aIOn5RHIsr2vKp5H8LR9GUrajviQ-8IXyCbJHkjkpFs3h2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 11:37:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v5 0/5] Introduce 'uploadpack.lazyFetchTrusted'
In-Reply-To: <20261002082322.2682869-1-christian.couder@gmail.com> (Christian
	Couder's message of "Fri, 2 Oct 2026 10:23:17 +0200")
References: <20260928133846.2094261-1-christian.couder@gmail.com>
	<20261002082322.2682869-1-christian.couder@gmail.com>
Date: Mon, 05 Oct 2026 08:37:30 -0700
Message-ID: <xmqqo6d8ma4l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Changes since v4
> ================
>
> Thanks to Junio for reviewing previous versions of this series.
>
> Rebased on top of a018953688 (Git 2.56, 2026-09-27) to be on a stable
> base.
>
> There are no functional code changes compared to v4. Only code
> comments, documentation, tests and commit messages have changed, and
> those changes are relatively small.
>
>  - In patch 2/5, a NEEDSWORK code comment has been added to say that
>    we may want to warn in case of a missing path unless that path is
>    marked with an ":(optional)" prefix. Also the commit message
>    now mentions that NEEDSWORK code comment.


I was hoping to see more substantial reviews from others (compared
to my rather nitpicky review on v4), but nobody has bitten yet.  Shall
we declare that we have reached the point of diminishing returns and
mark the topic for 'next'?

Thanks.
