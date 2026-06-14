Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43DB23ABA8
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 04:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781409939; cv=none; b=crVQtKtlEoXYqpWIozY1/KC9272TvtmZLIC/YC8gBQQQKeBs6CkbeNVy7PngwQcKeVNEU7oKVy5ZdVXltokKk6FB22Lk7k2JABTRGWRJc+CeTMxzHmwrwsUdndZLlcybyKdOKgEzGyU5iBoLfOUWI0NLHPIzrrZGtC3ie3hH/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781409939; c=relaxed/simple;
	bh=8E9Cw4y2rfLkgMX0RoBg+pkuP5Rn7w9RruCNQQrc0kY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LUajQg787DngMGUSqMcbbfhlPrEMVHhx2LxFWIjs4c1IJiOUaS1cekh9UmPJim498dl1yb06bCkkm0u9nVj6N6rMGvmalASBtlaVq/2tBTD2KXtSLU1fPn/qqazOaiAqJmRlK6kv5D/ofvC1wQv5Qi6ErbtDOMYzlRIaebxydfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dGZ0cUt0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S0zELVzQ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dGZ0cUt0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S0zELVzQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 931041D000E6;
	Sun, 14 Jun 2026 00:05:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 14 Jun 2026 00:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781409936; x=1781496336; bh=eGHL5i26GV
	lFubH1whaxdkbOhh4AwHAnen4GiFVlwKE=; b=dGZ0cUt0AiMcnmd3tvpSvYuQ6i
	1S9aEy11bneEKXjgB4c7Z1Hzh6BrkEG7tFmMni4CdeUAKbIddI5RUKk6w+wlmksO
	PwMm0P0aZHUwiV93BcyiDYB6alQ6Cv3Zl1vA7UcrzmZ1cfla03e70kFl7VSayDm+
	TE2rmZHwnQ/rarTVP334JVzMF6XQZaSawRheydsRttkpGm8mnnMsW4/mJUx++Gjt
	1wIPd0iQlgVRDl9UJndfblXg4bvs9tWERpjQ3Y0bjDBogjSHnKKKmepkbsK7fpir
	xYjgchEuNwrkyOErOYhP9n7HLURPZs4Z5cv2N/fh/CFw2aHSlObGaXb13Z/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781409936; x=1781496336; bh=eGHL5i26GVlFubH1whaxdkbOhh4AwHAnen4
	GiFVlwKE=; b=S0zELVzQ5V6jOPARl/TihNs/A16cXK50Tf3/nHpH9KlKF1gAZ8k
	S3DeQqGPFeaM5ZWwQRW+7p4W07LCet7PiR0uPijAuFs+nh8WKDV9jkn6Vg0yRU6c
	cLI8UrDynJsIJQaSf6vFELuUrxkDi6SE+/6+enhNAf630SvXSTHHTIjC/MbgpXj/
	jR6LUOXQl3J4rLJiu86eh5YfrkkjrBFsGJ17X8dnu4uADMrfLJK790wPN8VjPXps
	2j0dycscOq8zpwDNBCZ9cGRqegKdZSuJ8tsZzai+jMq0Gij2qFhOfke51FbELxo8
	qyebVWOs30x2dV7sJmRZY6oupuD0hMZ/D4w==
X-ME-Sender: <xms:jyguapsL7jjdjB10IiTKGBeSrco8TT2TnTEH5Ls7jFKVkP64CUMBCA>
    <xme:jyguan_JNn97ixpCfTsAU33tsn2cVXPEG-VZk3vvVTcWz7wxKryTtncaeJgauqyfp
    wUD1gkRVpReyj6ZlM_lEtp5trNjnxReBJADcs_6YZOSIatW6YCwvg>
X-ME-Received: <xmr:jyguar22bnH544oxLzj_VPb-i6TsbKXPuVzxRXBLKOaSyafkovfZNxtoso4mkOGPfQxaiC-hM7JsIUbHNLhSWezSaj9abh36WWLk>
X-ME-Proxy-Cause: dmFkZTG04dpUvYIYUnge6DT9xfJM9TGOq/oNquFEAyIbEpCOLN7KYLr4TgLQNzDm/f0E1U
    9MWMP19oWbPzOJzCCX2ql7OMDTNDUrZzIGpmC8zrI6xO1Fdzmz0CmgFf2zQoqwhXPheIiw
    3IoaoPZKEfLcM8tf0uPA8O3WHt9O8OxhiBqjDds1zcNkOoDAHN6wbqPiuvEVtC30k7QL1w
    bER8DEZ3ydP7xLqZ7NA0zxJMyXaTrhfOckEJB8dVOsxQz2Y+xKuPJeZ9lYk9oIad2o9k8R
    ufgcPAXovEbAL8iSZiH0Qd4xwfYFZwntEZH0JRX/z4ygbqSuoQG0/2johjoSl9W5BxUgnf
    3uBBoejAyBVEh3I9v7PJ4+w8KfAbcmgYiNMMrUo+dsiqyz7xln08GTQbM3MWX6+dnkgZNA
    JYDNLmEJnkOUW75NaDyco96NYKn8jZCXJ9VyE76rFrb4uBYCEzC7goHFbWptZvln66hNJ1
    CexgzU4YMQD4K7qIzkkSG1t7/h2Vl0UPGK+NG3FT2ba6Q99sqd1MKwMcP0unuEwLr49k47
    6bBFEMOVbJds9mKhfG8qmMAYH+dS0r4KtcTDBnH7ItQGGhAtxsyI41NygLFG72dXncbYjF
    cdBWJq2f8ee8dTG0OIs5f5hvhGBD+c/hAgWuAsXFllB7sok77tlKj/AMeoZQ
X-ME-Proxy: <xmx:jyguakiqJupY-zZeL3MnNp94z9xqRa1dTWTw0QherRW7r7mkfQI2Yw>
    <xmx:jyguajavPSxrq1mJMVQOEe9Pv8eIOCPO15nZa_BP_jHzWtFY7-Y-fg>
    <xmx:jyguaoU_Zhihs8O3nTCglzjfRZXmoCr4VCYxccCCn4fyyFUZ4kKH7w>
    <xmx:jyguajEppIoG4IyP7zk3nNlBGD-cyRy65oWC6MZiUS5mSApKuP7R0A>
    <xmx:kCgualBP45UedEhp-6-XhLZJKonZh3SBTJ8g5ccR9GjCZPxpuCAHKOR5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Jun 2026 00:05:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>, Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  ayu.chandekar@gmail.com,
  chandrapratap3519@gmail.com,  christian.couder@gmail.com,
  jltobler@gmail.com,  karthik.188@gmail.com,  peff@peff.net,
  phillip.wood@dunelm.org.uk,  siddharthasthana31@gmail.com
Subject: Re: [PATCH v5 2/2] graph: indent visual root in graph
In-Reply-To: <20260613-ps-pre-commit-indent-v5-2-8d308efea63d@gmail.com>
	(Pablo Sabater's message of "Sat, 13 Jun 2026 21:09:16 +0200")
References: <20260612-ps-pre-commit-indent-v4-0-e8492037ebae@gmail.com>
	<20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
	<20260613-ps-pre-commit-indent-v5-2-8d308efea63d@gmail.com>
Date: Sat, 13 Jun 2026 21:05:33 -0700
Message-ID: <xmqqo6hdepgy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

[jc: Taylor CC'ed for his expertise and opinion on the quoted part
that mucks with commit-graph files during the test]

> diff --git a/t/t4218-log-graph-indentation.sh b/t/t4218-log-graph-indentation.sh
> new file mode 100755
> index 0000000000..ccf15c0a52
> --- /dev/null
> +++ b/t/t4218-log-graph-indentation.sh
> @@ -0,0 +1,467 @@
> +#!/bin/sh
> ...
> +# disable commit-graph topo order to have the graph to render in different
> +# ways (used in --first-parent tests to have multiple visual roots while a
> +# column is active at the same time).
> +unset_commit_graph() {
> +	sane_unset GIT_TEST_COMMIT_GRAPH &&
> +	rm -f .git/objects/info/commit-graph &&
> +	rm -rf .git/objects/info/commit-graphs
> +}

I do not quite understand why having commit-graph makes the test
result unpredictable here, but wouldn't we have a more stable way
to disable use of commit-graph than going into filesystem and muck
with the implementation detail like the above?  

Thanks.


