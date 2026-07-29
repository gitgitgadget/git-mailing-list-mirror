Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726FF430CD4
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785361317; cv=none; b=KzjHrD9ijrN3GrXqW9vvyq/JmIeWj+96+8yAK55lQsjweRrHko7KQgPB3djcxmKMouHPFf8OUwsj7pOnKXThfdya6k3Jn7VbxnRebVsAl5+SHL3z7tTpETV5YMQ9YY9WYT2cquvRoYuhTSLa0lrsAgKryH029z+dZVMyqtXWqtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785361317; c=relaxed/simple;
	bh=GO2Lr61P6/cW/SAEyQAvUpb3MQteaR5VIkQ/QsJgZFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZEDYJAg3Adw6NUekwYNSE4dVwRj+UPFUBmUuMexmcvoRUrCC76X0Uv5A9MXFvow9xHdooMAWdNYv4wSIDQ+iQwJ4gsDw2cKLmcqeCelFe+kVgnQbVQnp03wtfa3Dh2hvPktvYj0Fm5uy1k3ZUs03XXwFKuwR3GLJ03QK70Ax0YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vJ5IeeqS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hPfIPE8I; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vJ5IeeqS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hPfIPE8I"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BCF3914004C9;
	Wed, 29 Jul 2026 17:41:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 29 Jul 2026 17:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785361313; x=1785447713; bh=usihe1QHrm
	0asu80pOE+B/vqycCXaICEvH/qZLrDkJ0=; b=vJ5IeeqSbTRXxulkFBdBmiSEIi
	rFS88KI6Qr6FHiemUqpZAaUlsJBvEvjW91ZFauvEbRbpf2087rp39HJ67NAR0re7
	9Dhf0e9CSUzc0bTE7z9ZF8ExlmEExHnGCUYSaMP67LdflmoYEmtAKLD7JIWJUSuB
	hP+HnTBI8rCrPVJ6pohguecHsJ4NRRj+EKqJ/h8QmMTQv9knO/T3lHOBWbR9insY
	mgne9S/LsLJlfo7QaUOQYtQXHKrTbOODoX8avbXmZ2P1ajSUJT30RpjGvxgDAY7d
	HHSYEkxBydzaJV379x0DKyojgYnjps50EqSVhkHqANz4xAEoqCJ3a13AD/6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785361313; x=1785447713; bh=usihe1QHrm0asu80pOE+B/vqycCXaICEvH/
	qZLrDkJ0=; b=hPfIPE8IHsRf9SGKEonaoXBmEckhUjLdyNTi09WMGSTjI3E6gvu
	/zz9/2sCMm5m5mKb4LxKgOMuMhljEXLsUuoF2XHEA+N31UNi52U4kP5g9IpjY3og
	RTKsEGTQv9eMYWWqd/lbl8Si/JODuDSrBoln1iVOEVOo6iFko/GDjWZYcdzTNoCE
	kgFeVlcFDoZVEChedCnUTgOjbqIgK0QqHlP991FxuF8bsVQ77vRSATCQUdwF2ExR
	ykuG8KjglXjKT9Sd95c7EWlr5LB75OxW9nGeLguq+ogoeOFYwyucRHOyqNzV5RqQ
	T24SLD+DdSSRvDAbXRLjlQ53pOca9AURIxQ==
X-ME-Sender: <xms:oXNqaiQM-sgroTQl5mGVkjs_hF-eoK_ow61rrGvFZA5RtX6p-CJQLA>
    <xme:oXNqaqVjQ9VrD8Gum1FZeuMZ-3JIPZgqjaw_3SwXqQ8ybcP5_lVH1et2-VKPWISmI
    DcnysFxTOtDz0H1yy0FAONzfv7bYN6sqCU8zF0NqOBRxdTNfgIjog>
X-ME-Received: <xmr:oXNqajeAcdLmbvzb_q-nUFc5bji-8OYB6g-oDaFugtSulJ9XbqN1UZG9d5-_9P2vyzTg_0U4QSS9VvJzH_bb5hZhEe-0yeMSXw>
X-ME-Proxy-Cause: dmFkZTFWjzwuZcGzaE8lNvFWc12Oxq+k1HPxiY5bwdBv+1ftD2C/WuCkvSml09Iy7KODAH
    aSHWOoZ6vaCEdW9Xeh3x0ge1rTBoS8/dyXezEagEd4V/BF5m9hYWPxpmVRb1Eoz4xgDWCC
    jHQxqnHUNxnWMa4oIspFnQNqEaOKgcICMqvHybIPfmJFbQiCeXVifjcFs8azFu8oIefwtU
    XyMAWJyXDepDOEm9I566U4BfA+t/2dWq3TCv/h2zFwzSAE+R3DCGe7tcWq9y9oYHKWg1a8
    ywwFvORns+dvs5czBHLqDkdhayclLPjtZCj/ytexgABdprGmtcLJcuLI2nd00Gel3Rw0Qd
    g1ypOYZSM+Po0/JKH/Pxd7ilLCG4vEtbiMbwS6RF/0Y6g+ytL01EcQgGNKTMsNyncTW7+I
    9ViaQOZ/KUjuHSSW9KXiEc3uOxAegrehkMf5JkxutkG17op/hX1CTRIy9jjQnayfSZSsDR
    aBW1TPDGC6qk89LoTMrmj6HJMRLwnzBQdRx6+ZJtelhCwp8llyoVRqQAiXO10dOOjdauuv
    f5JnKN1oIEz+M3hLUksxqnYhRsA11K+ssZZX7nMcM+w9wA0f4gDpte8Oylig+TevWMoeyx
    FlOFObkyqPNQFbmeLuZmsH0eKI2TpMvkYABIIg7IwJHl+GEdUTqdrv5pB8Fw
X-ME-Proxy: <xmx:oXNqauK2xYWJM5FGkJ-Gfq_rNleUxddbaH6KcvvgRXgJuWd_nwhNXg>
    <xmx:oXNqagwaVq1yMPi6uPEIWHx9EM9_99HGLCWk8FJh2mnV2IY-kSibbw>
    <xmx:oXNqakuVwaWPILqewNjQab5XSxu2h-_-7D6oxDdh2ACNVj_0PouTXw>
    <xmx:oXNqajDvuPOwkVW8ut-esz4EVuPyQ75LcfR7CZXHbSHesKd8xhG_Jw>
    <xmx:oXNqaq39tSgeJGseE0TiDZ0T0rwuE73mJu25ZVFJr_9MkF_-EKddQt6t>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 17:41:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  peff@peff.net,  ps@pks.im,
  karthik.188@gmail.com,  sandals@crustytoothpaste.net,  avarab@gmail.com
Subject: Re: [PATCH v6 0/6] packfile URIs: support concurrent downloads
In-Reply-To: <cover.1785111375.git.tnyman@openai.com> (Ted Nyman's message of
	"Sun, 26 Jul 2026 17:28:37 -0700")
References: <cover.1785047139.git.tnyman@openai.com>
	<cover.1785111375.git.tnyman@openai.com>
Date: Wed, 29 Jul 2026 14:41:51 -0700
Message-ID: <xmqqcxw5o4m8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ted Nyman <tnyman@openai.com> writes:

> Changes since v5:
>
> * Split the existing double-close fix, HTTP 416 handling, generic
>   concurrent-download fix, and Windows sharing fix into separate
>   patches.
> * Replace the FIFO-based concurrent HTTP 416 test with a standalone
>   completed-partial test. Besides simplifying the test, this covers the
>   non-concurrent interrupted-download case directly.
> * Keep the final production code unchanged.
>
> Each patch passes t5550-http-fetch-dumb.sh. The final series also passes
> t5702-protocol-v2.sh, and the overlapping-download test passes 240 runs
> with 12 parallel stress jobs.
>
> The v5 discussion is at:
>
> https://lore.kernel.org/git/cover.1785047139.git.tnyman@openai.com/

Is everybody happy with this new iteration?

The design of the re-download feature itself, as far as I
understand, was favourably accepted from the earliest iteration, and
now the CI breakages were corrected with the latest iteration of the
tests, so we should be in pretty good shape, I presume.

Thanks.


