Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4AA30AAD8
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227852; cv=none; b=ZJ+/OP+MYpOQVOxBCeDFIthvqNP4sYj6FDnzTn0cjEcgwuVmGmL+MSeNHJUNx3QrG9alz3WMF0NbRB09HP3tPnrn5KedXTTL8wI/kqO4tADRd0JI/kwnphz+lgZug7yHU6OuNEbpiU79+JXauLXXBVJSYlWTM4+7B5jkWJxUbFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227852; c=relaxed/simple;
	bh=n9GlKSG/5X9cIyL9wsL/S6Liv7VqrKELmwNnXHdrh5I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sGtgs5laWNnW2RlAKS7J+qFTt00ZlCazeQAtQCveh37w51Y8MQuhiF5/qF7wKa0fV/vs1233+dwMmdOw5PcUSL7q37vRKwbLpTliStBHR6jw6U43cHSbqztT2J0HwTZyoLI+XWPcReWe4ff5TvdOGVoZyotGT5EmBJCbBnRaZ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lSZvgQ6A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WN7m6k5U; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lSZvgQ6A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WN7m6k5U"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E4DEF7A0124
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 15:17:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 05 Oct 2026 15:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791227849; x=1791314249; bh=n9GlKSG/5X
	9cIyL9wsL/S6Liv7VqrKELmwNnXHdrh5I=; b=lSZvgQ6ApQftmuclbKWzWtq3Yz
	ZNdrv19/NlJ3YgiWygPBpcU0OS1EDxdeq4nYRw+99hJ85SvHQV2Dx4BajZyb2Ng+
	WKH8ArkcStAqpGZnWiO5+XD0gBI06721A0IHAiirhP9ZZp/weL2dAI4L/+FKyEvs
	14YWAW8IXvqCh3BWaI4ZzsDDdzqrQv0R8WocRi9ZrDhdqSXeRin+Jjd9UdcymEqx
	kJEHpo+31mHzBfc4b1uuyTGHNLQOUl+hAXmi+hZrxNGHl8Y7wzO+/kaYom0CBimn
	QZG3XgjDy2WiI8GoCtuIAZr39ItwmNLhxG2rcuLVCXKoI7HXOH3nXAPadhiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791227849; x=1791314249; bh=n9GlKSG/5X9cIyL9wsL/S6Liv7VqrKELmwN
	nXHdrh5I=; b=WN7m6k5UiW7Oc75+iFti035RlnDBlvhua79GcKRFqp98ICNow6h
	b5sFKBNspTuZssbi9SUJP/dVrVxhvok1Uy7GiShiHwawUFJDeanoR/RYPe3WGr6f
	u5DeyizHKJT7rn5WWsmQDM3gZwvmB29CJxPHAAnWjwc0rExOlF9G6uVHtkFxcN5D
	Yzw83Sm+BKPd9qWz9sx4anwyDZ9hrnAhh5vFpQNJUqSGEOJlC2JuiKTwCi0JjqtX
	/zR8jzmbc3nkon4Wb8eaURsdtigKDRvGIetOWFP46CJDsvffYQgoE98Mc71++XtN
	v3Bn2Aff5hE8SCXEWFKjglk/ppYs00QmxUw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791227849; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:CeJHQDf1XIQ+ZZwW7wAI1NQkEjO9g0+xx6DQRUl07lGLqFC
	8Sevf7KN0VXC6T2njwbS+fIkmZdtYBU4m6/nx6o9aBsKyN1QQdDXVPAl9WV87jj4
	NYYX2lBBIEbrDZ6bZwIgYqTR6bjf7T4VtDjW9JPJutamoyC/JnebIkIwJocalU47
	aEoRl5YfNMqaFB8mEpJnhgwRUfAOdcqFtSs1V+O0oG2gIce4dUidOCyrXr9jaGzU
	7pLiUvm7gvmxvttpQ20T1/VZscgOqCwlezHhVFHx3tEIlfF1Y0JRIJC8TSsv7OGA
	JEi3dX97gKv8qONUWn4EimUJgTto+lhsNXF58Zg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:WPT4gMB4sr9WC4na42q0r2qgpxpQeQ63zja3asWbn1I=:n9GlKSG/5X9cIyL9wsL/S6Liv7VqrKELmwNnXHdrh5I=;
X-ME-Sender: <xms:yffDagAmIaOlU94H6LC92KzCs50K3RaRyl3QV7ky9XIbOp3gJhcqew>
    <xme:yffDapYUbmBsM3RSD0n1vBgCGU3LYhOIFm944FygmUPTL8rHuO7JBlZmyp_v4wc2O
    JWu7uIns9ZHlpQ70zlOAPG6cDzYBpGUESgeesZqKGk2D5F-NgybPg>
X-ME-Received: <xmr:yffDar4auKYuUR-MhrjUGc5UxBiAb1nzQcUCE72Npcij-_ZznnKbAW34xSRys7FDUM_DfdbwJ-srNn4RW-No4OyEpYY_T9ehjefD>
X-ME-Proxy-Cause: dmFkZTFHC5pztMQ2YBfas31JXdlnq6U8qhOvPWE2x/47842GE5KeM/pJVB/Em12rbCHLW2
    RDq19lYRR2HbF4AgoqxozuKkx6jut07eopQvXhFgOiNUFjtYMXzr4MwhwW+NvlJszmxvbr
    1YXKEkyPD1lhAY/1LpjY8YMQZ8QefmQLBiTGDrg9vi1PzvUx4ebL0brWjvH4SGXpY0mk9R
    hz9Yz0sIBTCKaWMbu/RB+gEawNyAfnEnuMenLJMR5nQ/W5yDFK+B06Wqtcz2nxOV0u35fT
    /9/Imm6MW25fhhffQvRXu/1m4xqe3kXHar4O5jkKVcHtWW35/viOSwneFn7h8oNUkzasKn
    oSfkFmyyIrab0s9ArAuZ9xI7CyeUcWJXEcph4J+JNwhKbWlx4Pdzv5tLaxkDWbgPffvAty
    1DVbT+18dSamRRWMBmBXiF7UDr3fdqDc+UT8K8MmykvbxyRZmWiNxfyS8g0T3FfFSgodQX
    urt3A5WmVWf0fyoXPZnj1HjIXrpxyCkDsxpWMLHqNc1dHpQnmlZc+0ytRoL6w5CdajF1Oh
    c9dSHNUfNTnspUDGxYwQG8MV8xYkoAUEU8E8xcg3A4XbTCup1JGy95es4K5B6dGGN4rRur
    qFi/2aMeTzohkroB5BxVQiHsF/n4rEXS87UOkNxQsEub0XOx9SGj+gQ6F6Vg
X-ME-Proxy: <xmx:yffDaiZBM1XU7Eq0RNMdlOtS6fAVanfS7C_5uCFlV-KC_iwv62PExA>
    <xmx:yffDaiieeIvL-z6W1H9Jr9JNB3Xkb9ZpFg69mBF08zFcCptp1A_--w>
    <xmx:yffDar-gT0GxzFgjE2pDQnM0FTuPgRya3sjs1tbX6IkoQObuBme0dA>
    <xmx:yffDalpToIEOhQqmKplzI2hsQpG9_2Q4YNURBrQlC19g08qTZVla9g>
    <xmx:yffDajGZu2gAB-PCutfRe2SlLBRq79odqZXYzyy4fCFrGll37xfO5q1H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Oct 2026 15:17:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v2 1/2] Documentation: describe connectivity checking
In-Reply-To: <asNY7SfEohsOSf0J@pks.im> (Patrick Steinhardt's message of "Mon,
	5 Oct 2026 09:59:41 +0200")
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v2.git.1790600552.gitgitgadget@gmail.com>
	<97c11449aeae924436ba22a00a2545254e988a58.1790600552.git.gitgitgadget@gmail.com>
	<asNY7SfEohsOSf0J@pks.im>
Date: Mon, 05 Oct 2026 12:17:27 -0700
Message-ID: <xmqqece4j6t4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +Full connectivity check
>> +-----------------------
>> +
>> +`check_connected()` (see `connected.c`) normally performs the
>
> I'm always a bit hesitant to directly refer to code in our docs. We
> should either make this documentation part of "connected.c" directly, or
> we should not refer to code. Otherwise, chances that this documentation
> grows stale is very high.

This is totally outside the topic of documentation updates, but it
makes me wonder if we should pay attention to connectivity roots
other than refs (like index entries) that we use when we run fsck.
