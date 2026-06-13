Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E744282F01
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781368748; cv=none; b=HaHuVXXxVOGaQKdSYW+tgVthf2n3NqzAP1ObhDFiSl5vY4dmM8AIZxXLHvxqf6kG6WEARA2LtsOSRreQHi1qHRbQhdE+pTcE81eI086TgURVDQ630iy8HpwIK5CN4FZPIeD/oQcu4OjVYPKflivOEWXxOK7P16OxxKrIrYgrcjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781368748; c=relaxed/simple;
	bh=hRGlEwMjn/G6a04pzOxncTt6AmPvgmKJUr37Z/uVh5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D5aVwwfhhmS7jr+/J+x5lqmOUvlkB5E8WbKmqQtgQudys9HzBr8qHm/u0LLxSGLoVu5uZF2B4FweW5O4v5gSPPl6qvBpOs+p/3X9aFRVSoGngvrdbAHkK3xBez5kt9EUqRbFdQvM6Gk9gAYYUJ94t063dFlhQxzTvMHzfXeHQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Jk0FEdOI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gDebgFCS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Jk0FEdOI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gDebgFCS"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 61938EC00AC;
	Sat, 13 Jun 2026 12:39:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sat, 13 Jun 2026 12:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781368745; x=1781455145; bh=bpwwoWupXf
	GBmoEQVtC4iX3KUYtZWXrtUTxsy/nCsKs=; b=Jk0FEdOImnUHyvBRyFQEuf9ra9
	dYxD7wutWjZWLJk0iBCV8upkZuskaGXr3mVUJPnvhG6h9YaYmSyzyD/M3x6jOUUg
	nP2zk1RdYYSgbRXzTiu91Tzr1E3GIfwdqwnvY/12ysGKeBw+69ZEmzWMJ4gJlehP
	+FiEKtB6SJZkSZkxBL2R+og7kTb81DXzCE5qAQRB8XGr0UfcWzx1uJurPEwCFxou
	ATjxB4Ft3TNpeCes5AeA7px4lmInU2ur4t+dJeSyt9aMD6gRyXJq3h2rY1oC6tZ+
	92FcMxut3HJLq4MyZKQgeKEA9hwaX+Jj3UWti+gNbXFDe4mAiR4lwB824kOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781368745; x=1781455145; bh=bpwwoWupXfGBmoEQVtC4iX3KUYtZWXrtUTx
	sy/nCsKs=; b=gDebgFCSsIUQsePxV+KBSNG8koNi1qvK4AKhBG597tT1XJsavD/
	4H49fAGOktgZHDaKAErtpfDZ9wPg8apvYMzXfwdMmBrQ/6iDFtbiWBM2Xl31CRym
	GlNwLbOhSvzJiUYlPlY1dMnioNku2MyZLyWRuy6+L9PQw6IYrWCpljJyHKrDtFky
	0Z51Rhzcul/SrisS+FETXyHNN1WyLUyg5yAjHFvTF2g8dzqupJo+xoh+ID2XQmTh
	LJLftwifgxC7tFBfPgKTw6Oc+y0t+hVYUw0arbBmBmoCUEIPFdDCx9BSZwWiZabT
	ZKS73433me1pS8yI/ZBuWwZFvAJADlLjbZg==
X-ME-Sender: <xms:qIctaiytn2ZAEpgeLcbyzKH4LW8YcbLFa1i2gIOEnCN-lefssv3fDw>
    <xme:qIctau-x0YKCzm14q0F0LDEp4apxcKR4Qh2JpCoNG3LsIRXuw9nx8aED2DfHojcSn
    UB2xdb6DLFImpRiE-aqv6NRlQBLAE3KS7D8YwNhe6-jAHzXvn5qmg>
X-ME-Received: <xmr:qIctaihRLqu24-aq22ZqCaDPE63ZEloON5qgqO6StCg3jiEQiDagQSRP7HWClQ74QTD7XimOcaFZLQtKRKIHFKaPyycRT56j33cb>
X-ME-Proxy-Cause: dmFkZTEu2q4n05bPx0RbOOyqspRvImvZwdgyOhB9KjR6VNTYRnXq9Zxdz1D9pmmYr+bTd3
    DE/kRaRub9zVBIheoDqAQCgZOl3Mrhyx1+n+zG3PHLdHjBZA8EdyzPEB3e09m1NChBOhRN
    aH3vyxm6Ha5Z/kDAnkNhV2J6YzJf2SfyeX0Mwg5lSDXqVuWsE7WVFUmYjHa979cAcnT3dD
    tGIS7ToXXJrBPn3cCB/D5mejFt9TOoei9m0Eak9PYBdiQ9MqZ60db1zW1plWt3egGy7lLR
    xNnBz0px9xteVsIaxfcU6nSfbud6NwXa/cNREAJfJmYFboFumdlBTj+t9pjua5N8YXepWH
    /hykFyHdZDvYlfH2CHmgk2W40I6WEsPXy5gz1+ym39xE3Z34RhbjWz6caduMLp+zj+kETw
    3Xv0n9T1RV67homQJx56cZoJImkNRahdkZZ9mzOajpjvMQ4e1TkzURs+FBaKChFrndiaIq
    2BiTVBlzVXn9r6pmURERd39f3NxHiBaM18HfEis+LEEZhb6ssnsdMgR8MqLGd8QBrR9KzU
    RelmKrv+2KBBs54Ev2EmV5ZabHi4jnPdUvx4VukCxmSWgMhlPz1jit1FdaS8Ki7Hm3cS+/
    25LJdOchD6iIPGjCYVN9NHImNbuRoVOiLDmSy3d0WcXNcj2BncS3WFgcKqow
X-ME-Proxy: <xmx:qIctatHdz1KgZUSQPnKAuqycBGqE-jvqk6VwRHgkTvQUgUMOqyxaAg>
    <xmx:qIctap-TUTJRcOoxJg2p1-vVu0UtBlVbuiwCarw73KAXQdjq28UGLQ>
    <xmx:qIctasyvWT73j_ih-BTfgKL6aZ9w_d-o19jX_KuruDdUs-Ow0crtGA>
    <xmx:qIctatPfvatJ7Lvj4MKHWfCNni2HwYbJ6ERgp6xDu5Nb2oU1ZlckkA>
    <xmx:qYctarx2wjhIWWIZ6eKQ-p5Ay3wRv6UZEgn80c-3s48Xcm18W8J5hpLg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Jun 2026 12:39:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Dominik Loidolt <dominik.loidolt@univie.ac.at>
Cc: git@vger.kernel.org,  ps@pks.im,  asedeno@MIT.EDU,  asedeno@google.com,
  avarab@gmail.com
Subject: Re: [PATCH v4 0/3] compat/posix.h: enable UNUSED warning messages
 for Clang
In-Reply-To: <20260613122711.38662-1-dominik.loidolt@univie.ac.at> (Dominik
	Loidolt's message of "Sat, 13 Jun 2026 14:27:08 +0200")
References: <20260608124419.38905-1-dominik.loidolt@univie.ac.at>
	<20260613122711.38662-1-dominik.loidolt@univie.ac.at>
Date: Sat, 13 Jun 2026 09:39:03 -0700
Message-ID: <xmqqse6qe6oo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dominik Loidolt <dominik.loidolt@univie.ac.at> writes:

> This series enables the intended UNUSED warning message with Clang by
> adding a dedicated Clang version check. It also cleans up the nearby
> GIT_GNUC_PREREQ() and UNUSED macros.
>
> Changes since v3:
> - split style-only cleanups into their own patch
> - fix the UNUSED preprocessor indentation style
> - simplify the GIT_GNUC_PREREQ() comparison commit message
> - keep the Clang-specific note in the patch that adds GIT_CLANG_PREREQ()
>
> Thanks,
>  Dominik
>
> Dominik Loidolt (3):
>   compat/posix.h: enable UNUSED warning messages for Clang
>   compat/posix.h: clean up GIT_GNUC_PREREQ() and UNUSED
>   compat/posix.h: simplify GIT_GNUC_PREREQ() comparison

Looking good and all the points Patrick raised during the review of
the previous round seem to have been addressed nicely.

Will replace.  Shall we mark it for 'next' now?

Thanks.
