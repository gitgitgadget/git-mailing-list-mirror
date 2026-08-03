Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81359257824
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772265; cv=none; b=eEr7fNC1AtGIAW/x2UAF2kt1eUMJXIhRXgwL2tUqqBOOyBWksL7vY9L3tSxKxN1Mq7NbeMJF1hTHwbbuu6kxVX5Qw0U76Ogojzz/a8ovpSd1xq5JyBY+zVRTPsDBOpLQ8KSMIF//z+KAZXBWUmJ1Zb9v1N+WC9VHSzXzKhVXNOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772265; c=relaxed/simple;
	bh=9xKfu7QGlvf2z+eBtxjXnajMG/D3NpggOwpE6N0OX68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kh7KtNiKu7ti3c21PqxtODOQGYk6EPUJPfg6d2cUzSiePVQ2xv33BX4lq44LzycYNlIVa2hokmIowltNI/d6wFFoZMAF8+s+dkRyl5IMSBqSM+HPbak3m6g4AOEgIGt9Wp6x4snj/N4uWUkcEBcvgSRgq+IDcPzz1PzBL/3Nhao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e0Jcr5wD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DvoQcw6n; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e0Jcr5wD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DvoQcw6n"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A068F7A002D;
	Mon,  3 Aug 2026 11:51:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 03 Aug 2026 11:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785772263; x=1785858663; bh=9xKfu7QGlv
	f2z+eBtxjXnajMG/D3NpggOwpE6N0OX68=; b=e0Jcr5wDl83XWjFclskvjk4xLb
	T9Lp3IgU3XCpXrPhptd6JxjCcbsqVI1/HsYkIueFjfmUuLABFKoztsUsP7kAvy/g
	oDpNQV7VxrqM/2kSRu7jruS3xmtrqzk5Bz6lQScGUFPoogtC6k9Rmzh/Koyhf9hk
	s9bP7RnALYU7R/j3f/TABwwFNm7ePAf+xWt1oYem6arx2lIBL+aeJD9TSMXoZZXA
	hhK0I1nWVGKNEGBbPHBgANdtigwLOqWEq+t9ONNpKfiFoi/NeG+Wh2SSpPvVUVfi
	MuouRrfrbsNKUsXkVyyKxObooEPIqu47Khqf1dbN9BuZOnei3YRwMk2K+42A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785772263; x=1785858663; bh=9xKfu7QGlvf2z+eBtxjXnajMG/D3NpggOwp
	E6N0OX68=; b=DvoQcw6nBeeTDTXB7q1V8VaR3ak+BsdTba4ECm1PUtMVyeVupdR
	kusX24oceNbYCf/c46FRqFXeQWFNEv2bcld4+h2ZJUNHMBGm+i62ONx91oeoN3oI
	9Cnouv5VbeySD4aGG3UdOqkwK4AbOlzvjAyl07i6ZlCtbDcGSPsMgvdD19D8sznw
	1H6MiRutoNigHsCAfNQmRM8M/xSJVq+8nwOc/qdq0lP/CCadi8k5lSDDeYwctIT5
	sh8yBf3wl0EfrDv+KhVaYvSRLeTwmJ7cGJvy7rhP/3IUnu8SO91zpOCTqxhN0r7N
	3weciinI6ppxs0MaQQFN4SNQl6GHhNc7buw==
X-ME-Sender: <xms:57hwav0DC5PwUZ1jwgsOjtAmEiWJIn8nwoMDeGrDZkzYDiuyA16DIw>
    <xme:57hwalj4U0YK-FU8Ruazpu8ofvbRzGF3b3ZMBmsgPvGfaPUUF3b2IgfKZggbZikoY
    HIXY5JdfGLmqKxZriRWeZAoFNz16nKX_WAx7vVdaUw2ykiHT1-E>
X-ME-Received: <xmr:57hwatTVfdhILkH5XVBD-ZVW8xV31J1aVftLFusDog38xRcFZfwDZEHDhonx80PNMn0R2n-qV1ks5RjFXJb8hEtD4htv5sIKmA>
X-ME-Proxy-Cause: dmFkZTEv+9RefPqFS0m4TumsN2436haFohDISPdMKMsvxZj2atMIWrmIUkxm0pQOo/1MWR
    qc9We4e6fNwRGPXWnCcRTWDp3FRNyP7XxZkIhq5gowoz00G306NVu/t/OgnzADuvllKTZp
    GZbTwrRZSo6BwwB5kV/XrzOc20o5TQR/spIL8injmD9s1dnoWYrj1Tr9E3ibGV4qHUeSAu
    aPGTj+RoOXWpNnDdBlHlXkjxNKjX+fJc3ocyoRRS9j3sPZlDq4CTPresRCUilIY5prrWz+
    +2yFDxCeBI2jAzWP++W/PL5VsTMYWiF9s9Nd5mws25A4kTKuClBMSTTIEFhPmy3bAbvBij
    fnN3EnhlVAHa8V/xTk57JM8Kvok82be4WCXu0yEIvXwGvWQqScTRvA59Gb27jBJTDtO2X7
    SmeSD7Nvb8vPkNTw46zIjkW3Cn0IZCmAEOSMPwTx6yBkFBGWWeh/XdWNRh7xMIMWMkhvYE
    ds2Zu+vsrvYrXvM++WYaEKINJV0uBWLH0YDtbKw++k9HpM8pb5XBbcEoubwqPAwg5VzJGa
    EusFAsxE/GnBJhXY5G0Jrd8zWrTu5HyDy55VooWfPNtKsPHpqKjYnaBEcdGQ9w+EyI9wHi
    M9YHknZR6v8uHPsGe2jwU7mBOfIRGGxcEPk5jN4LQBwzzRX7X0BPRzCZZKew
X-ME-Proxy: <xmx:57hwaugG6xvytH2XjxB9pmY4_cJxoN8GtbFwzKdT6Wr3KuhU5sGZSQ>
    <xmx:57hwal7chwMUqzIV-UB9t5BSJzTihrT2MjRRRZjAKapGQHcl-1abCA>
    <xmx:57hwajDJDkZgbqpIhH0Hucql0Umgte-q_c4trWL21vR32rzLZk1ZLA>
    <xmx:57hwakbTH6OZwHO9PEI9F_T8KZoWWuwliIQdPddyrJFwpNqNHhiCeA>
    <xmx:57hwalpyav03MqL8ZEP1oU_71qEfgqH4c_WddpqQRFQ8CSo6gJVi4Uf->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 11:51:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Hugo Osvaldo Barrera" <hugo@whynothugo.nl>
Cc: git@vger.kernel.org
Subject: Re: Git trims the last character of content from remotes
In-Reply-To: <2d3f5504-f5dd-4171-96e8-b5633b6a1f5e@app.fastmail.com> (Hugo
	Osvaldo Barrera's message of "Mon, 04 May 2026 19:01:50 +0200")
References: <2d3f5504-f5dd-4171-96e8-b5633b6a1f5e@app.fastmail.com>
Date: Mon, 03 Aug 2026 08:51:01 -0700
Message-ID: <xmqqldanyzh6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Hugo Osvaldo Barrera" <hugo@whynothugo.nl> writes:

> When piping to cat or to a file, this sequence is not printed, so the output is
> fine.
>
> Is this a bug?

Please tell us more, if you are running Git 2.55 (or newer) and
seeing the above behaviour.

It updated in 31e8fcabd8 (sideband: clear full line when printing
remote messages, 2026-05-10) and was shipped in Git 2.55 on
2026-06-29.
