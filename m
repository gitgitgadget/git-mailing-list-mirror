Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA19F4F5E18
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791292; cv=none; b=g59wttHoQ7Cn8NOPwr8ArPeo5+HTGw3YDZDobKB0WxOiYJGgqLgdMK/EYrsAUPST7AsYpcWayQQF6EBxsb8TdnOz0DLZ6ZEhq6gU/zqvBegCkBDwG74mqglqGtHLGdp6XR/CjAWx/5hyhAyUSt6pVQYrytaCl9XqA1f2VuYVRbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791292; c=relaxed/simple;
	bh=8/7pj/9Qb8Wvbe4i5s8nhCMRL5Wz5Yy9d1SUV/Aw8m4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MSazNG8hLKsxCE0GYdeGM0LSePckc95OK9WBW5xhZ0ISiOIe23/BjyP6sI/3TgDbLOw0+Ri6wlvwT9HedAgk7EI+2VZwNxG8pbKCrQW7UuF2cB/i6UjF/24OR0GRZUcWxW9I7KCc1Z6ld7acBVjgnRifu3w+QrOV7xz8JsioKV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AHxRzWQz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F3T9lTHF; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AHxRzWQz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F3T9lTHF"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D4E351400139;
	Wed, 30 Sep 2026 14:01:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 30 Sep 2026 14:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790791289; x=1790877689; bh=8/7pj/9Qb8
	Wvbe4i5s8nhCMRL5Wz5Yy9d1SUV/Aw8m4=; b=AHxRzWQzIdSTjot66DAvo/JWji
	Mgk7WVcLT8qu1HGs+AX6U3WPdgWpgVcKETAKrZtGAMu77iqU/Tr9XbqfrQLrhFC6
	FMCBiInvs1e8AXgnNUdXEQwiI8HXHyTiL9ME5Wlu70pmtE15JWjo325ZTa0bA0dE
	SXwLkJB3gL4doI1IHrPZ7Tt1zvHLirU+pn94foI6XdItDP4eyMQsqyYSUfwAvVej
	4YiepssyCkIao1m/bC782Nt0F1a0qUHNxFh5vwhnb8kfn+XX/9cDBAJCTVWyhNrp
	8fQC7yxtACpzvcOUiGUbvMU3T7Ab4eeouJP9GjchGWROreUB/BjBM5JBZxYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790791289; x=1790877689; bh=8/7pj/9Qb8Wvbe4i5s8nhCMRL5Wz5Yy9d1S
	UV/Aw8m4=; b=F3T9lTHFu+JiH/mUYL3rqh0C4WJLvpgLho4aRqrHggeCa/GU6mS
	T479RFTucLZdwRvuxhIhohxUhEG9ebSCam7+3FxepodjPQYhLzBYfNj6SzWYQPu5
	S4y+NteDKwXNFCzjVXdU+ypzqIGNIbnFG9XG/lBzbun2VhDBoMBDrMImzFhX9lZt
	QQw77Fe9Q1Lu41mpnMhbiF6XzXmwfVVXMgZOQSUcmn6QNb/LJ5ZXjD+Qax6jfsNw
	rbTp78wQ4DrCiiPtgYNBz6+5Du7pvl5ubpes7MWyBS/knhxbxi4AsZPVilSC0cG0
	d9schnp+noakxRBBJ3Upeht4sUbqkqJIvYA==
X-ME-Sender: <xms:eU69arPyy35CyvuEB-Bn9UlV5D_EHH4tEzcOALi5Wmj9n2CUsniXRA>
    <xme:eU69as_oFZOCDewT5rhpHyloR9TxTqDPrVV6p9_gX2xU3rcdVM6ZNnmsJe4-_P0-t
    rIxPCZkLv6SrDS0M4Pzo4AbEQaY1m5x6ENSDhDpXgL3We_dePxBvV0Z>
X-ME-Received: <xmr:eU69avQnPN6R_QOWWXsPJQsOjYGxxk4bRJw56ptaxbL5VnuGB7AUsa1D8f8tIC8cMOIyyEGyFSJ6tc_m5BgSk1hjZZojn7ehQ1Bz>
X-ME-Proxy-Cause: dmFkZTG27U4k26L75Z/8hAZxfRJ8Ob8/DvNDFNO4hj5yin/9wkzD3LT8MtIs+Cjk7KUkp9
    Ov+W13V0pv6WR8VOMU3X4HKk4IURHXOkN1Gk5Pssvbe87yqw1gcYec6a17mDvCAqajntbq
    s8chkWto+ANZ8TzG56olJu1Lg/CNKeVchQUPRidmQgMMDBX0ER0vsJC2s2pyTBz8EfJ+CJ
    s9nKpq0WWArm5H6IM/l7Q7MYxB5ln8OXhdywwM0MFBxSZIdo95LGriQcw4qbaYuzDCb3fC
    5IdfoOWyh67koDY5u9mlWZgeY3GlgEgqriRMowNDTYrQB+oWmVsy7rllCosxVCYxsLuir9
    EUQHiPJb1q//oxoCfL20ej9HFK9Z3MhGK/gRpE9/GA8sWgNBB5XVhskFGRR1FP6zpIUfDD
    8BQXsjsDWn2zRCmQ3DIAXZ4jMVbSeFnRYQB8Q1Zzaw9TDu71PQWGV0AMJslpQIEiNNVUWv
    Sq17Uf7qcHZdebCtUBnyxp/GNoG1/pBQGpCe45KIB/J9Nm4MHp1IvAxsifqTW3Pv9KyHFa
    WEDVPWnxCoPKBchbiEuT8XMnlfQQfKOSqJxLrLD1g9jEb6dnfH4CO0hPN4iMRLMhYkC3Jj
    Bkt9L5y6HdN7UgJoEM5dlZtjK8QGx1v2JHnn3mrJSEjki9tHvMoShDwvrc5g
X-ME-Proxy: <xmx:eU69aulIkvFJxNdXfZfMQYuDNfJqhGIl_JieCcjPz7pwrkIYFurSlA>
    <xmx:eU69avSW1zrISIydOWENvgLd1sWy2aWKvrozlUP2fr-02XIyjIla5A>
    <xmx:eU69asPL8M4uYzL52FNLq5z9WpuHAbWV7vf_Rw04NpSYLZKUemGFlw>
    <xmx:eU69aoUHR-1NEmehW5OOXr94qDEgYgbHD1yvp8b0Vcql4kO8FPUcPA>
    <xmx:eU69arPySAom4mp9DN0KZnBAWWe9RmSbt3sG_X7qAUdyfDziUZxMZq-p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 14:01:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 7/5] merge-ll: report an error when reading external
 merge results fails
In-Reply-To: <20260929214943.GA1735259@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 29 Sep 2026 17:49:43 -0400")
References: <20260929204157.GA1733321@coredump.intra.peff.net>
	<20260929204421.GB1734030@coredump.intra.peff.net>
	<xmqqv77neowx.fsf@gitster.g>
	<20260929214943.GA1735259@coredump.intra.peff.net>
Date: Wed, 30 Sep 2026 11:01:28 -0700
Message-ID: <xmqq8q4ibouf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Here's a resend of that final patch (not just a squash, because the
> commit message mentioned the chmod).

Makes sense.

These 6/5 and 7/5 are probably better squashed into 5/5 than left as
"oops that was bad, so here is a preliminary clean-up to make the
fix easier (6/5), and here is the fix of the fifth step (7/5)", no?
