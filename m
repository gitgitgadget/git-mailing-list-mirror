Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A922F5218A2
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876810; cv=none; b=CM4kkQ/mgRd5dAJpnjKHfp7aJvpJRrxhmqSBb2fktum8cjIN0ZbeeCSH6WsxxZDPNNDVOen2XaWQ6vL+3QzA2dnm7r92oMOOKpD36ak90gDZwrBKsDr5eyuN6qLszxObQPuwIMG1qYvw6bX/mIfxgoSa70qPZ16NpHfoWfZ3OaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876810; c=relaxed/simple;
	bh=PsUQqvp8mqbShWkGwK32Zv2FHRH6ipmPPVGm4NUjioE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qWH5BvZVlHqUy+FRkZawAzG8fB8ThKIuYvt4mNKzJ5qiPO8sd9hYCH4t9sx7dafwDOONlW0OoN8e2XqlPR8PoLNvVCd2MvqJefePedLqy/1AXcjp4Ct6d29kdY4eWV9RqB7sLhKVrKPOSDdMdrH0NJtyc2h/fHoVhhnSmIQzhW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a0/+kRkC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cxmVLTDK; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a0/+kRkC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cxmVLTDK"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 878691400100
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 13:46:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 01 Oct 2026 13:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790876804; x=1790963204; bh=T5F7h1kvNX
	fQMLjnALyNUq5vrY6EVUBWuaaNUTVHRJY=; b=a0/+kRkCJ3D+DLkqS2Nq3vg/G1
	jeHxuBYLRPZGutKKPh7P8erdF/RQKfDu10ZRHMkI8c1Ojl6AfFDtR69ezFn82PIt
	Py1uJkfDhiSM/5qULqdW43BMWgZKAokxKIiXT86p88xzsyjDG3YWIp1vh07QuUpC
	oNw7G9daT6CKKoqTwbV8/hGmFa6EmrJpekuPZPu0ukvLjHeb12s0Uxywng1WIFHx
	G9rFOv9vSvaMJTa8e0WhjEmr6VCbyJj9BXnTQ63PbWNLAj5xmOxYp9UswHi75QRI
	wyJVWlCdgsjGT01L4CERieQ6lP7IXh5A4SfUbjq6vGor56VfO4fo2kXtPNcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790876804; x=1790963204; bh=T5F7h1kvNXfQMLjnALyNUq5vrY6EVUBWuaa
	NUTVHRJY=; b=cxmVLTDKjlltiERvS1SaCoUCdDk6CiPdD9JrOpolDYly5TW7QGs
	32lbm3sewjeEphMLMBJ1Lb78nVQrR25Ar50Tj44Nc9PL4O9U+HwuW1OWfQESgPl5
	rFFSREow2MUlm21+zhpi6KBmNxzAWtEHxBayY2fanoQP9pFk9goRz0StOx+SZxXK
	zvKErOlBbGRptCaPvAXO4UB0jR2X2dWnokCQqaalww/kzTjnDOQgs3sUOIMpyXOK
	EvLtQGZlalipSDwwzm6ZNdvW3yKAI/nJdZ5jXq8Gn5i55LfjlLtE/M9fGna7QLlf
	2+cOMX/jNQt9A7fDmsPY4n7UE/9q75LvHhQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790876804; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:doQ9Wt38svdiCG7tyDgKaKt58UK2iRnX9BjqMEw3bpawaes
	FHaxu/7trC44BcGoGdUj4vvKZYoqPXCZ4GNtepJe+9ALYjLfPg7E9VDIqPsfGqoX
	bNO+ssgyEhjM8kwHzCW9Z0dUyR2HZh8SiP9eBgij6IEKrJXdSq1iv8DHyfxpOgFN
	aKSc1jL2F0LttT/D+uXUHUceKzP5X76VxC9L6btMx2vlqx9x0y7YFC+RI1iXizWA
	5J2o41Wu0gW1Bh6tbjPbmesZbulPlMa3zfdmqUWelxt9PoI3uGVwgGK51LAMmBIo
	/L23eq5DmHqlHmZgF9/w+rzpOd7fJfBGZUTr2zg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:6+Dul4GgSsKN5owQrb/1wl3h4K4pWlBh3az4TRSEYGA=:PsUQqvp8mqbShWkGwK32Zv2FHRH6ipmPPVGm4NUjioE=;
X-ME-Sender: <xms:hJy-ahm0jyS4MvtnYdL9Sk1g7KcrcaGT15szVlKPfUhUEbbnNGNS1A>
    <xme:hJy-akQc3BPCfHeALICDRwSzjDs4ND9bVXu3-vtN35C93uM_j0BD1qStWUETNGliF
    DMmE6WNvggJyYG3lVOVZtxQZBBw0OR_xCJyDpcG7icn7OQt6SOXWkvx>
X-ME-Received: <xmr:hJy-alApS3Ela5yLm6WakJ3c3HzVAS43I_x5zOGnypF78a4VJe3CWX6uPyb2JeQLE04xPjqfCfoNQgTp3KUBSq3o9V9FBi5osQ43>
X-ME-Proxy-Cause: dmFkZTFWe/awTcRXSwn3fw9X69ae+l/5rKEn7k6mefIj9xdfpzsX3wePindE5CdbIxLYmM
    ZrGnFpL2T8+kBjZ6dXnfonOFHPTeB+JljtBtMzCLx0Ov+r3UXib3OzVRPKbL4bP73MMA/Q
    P6BowY4IYJlElWtBE9y1NXaUIDnff7T0mZ0bw6XaxFsSqHlII6D8BbyMBR5YujcW+koSZj
    O3L8NszQ9b2nmxWN66+H4PgJo72AQfx6Jvzz3YcjEUawSybapuR8hYLaJbawoS7MaM/FlV
    xwNUwyAOoLPe6U6QOzSnpR1a9hVefJsFJu5/N50vDxADa0K2U+EEKfrAlPzd44x21w28nO
    WoUop13syxlK5cAzn4N6UDIJCzLxj3iGIDD6BzERonY75byKxiTj/Z1F/h09LxNN/gzHBV
    rMHjyNU0VlOLLQQkVS3UNqthQ+qs0DBmoZiDfBU922FPHLmkmp/nvOiE0mznAJZ4PPSbxL
    Tf27XGT1qtm35FY1fIO1oNu7CsfaixYATL4WtJILFnvG3Yjfc/eiaHQE6pE+FKLjBYPqf0
    21PSOM4ITg+GSmxAL6XLb1YoJ4AeiLvvRd/YnfFSgencGFb8xHLPreiPP+5W1jQgSN9IZV
    cv7/le0aAPQQ1GAnD3CInsFikWOOq3K/Xu1DYuJ0DbdH2WHP+eeCTIwatjZg
X-ME-Proxy: <xmx:hJy-arT6qCJH_M_oRjgL7Myqq0AKcCk1KQZ-WDxWYzsCp1U44ZU1LQ>
    <xmx:hJy-ajrygTOTZ_aKeCBbU2H5UxSmGJa5efdhKWlZ52H3qdDHDasyXw>
    <xmx:hJy-aty__VHhlEKHTLpYgLZBP26zF9xzfgiLLr-h21gsNe2kNRFIaQ>
    <xmx:hJy-aoJiDfjPFl10MjwmPk5eOEIWxV4v43Co0vXi8ZdkTtkZE6GCLA>
    <xmx:hJy-akb8TqsBGI5YkeFE6nrUFgYjaegfj0iWd0LoZ_Wy-Iq19TjnpDr0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 13:46:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] builtin/refs: introduce subcommand groups
In-Reply-To: <20261001-b4-pks-parse-options-subcommand-groups-v1-3-01eb2f4a4c32@pks.im>
	(Patrick Steinhardt's message of "Thu, 01 Oct 2026 12:13:30 +0200")
References: <20261001-b4-pks-parse-options-subcommand-groups-v1-0-01eb2f4a4c32@pks.im>
	<20261001-b4-pks-parse-options-subcommand-groups-v1-3-01eb2f4a4c32@pks.im>
Date: Thu, 01 Oct 2026 10:46:43 -0700
Message-ID: <xmqq8q4h5n5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The git-refs(1) command nowadays has a bunch of different subcommands,
> which makes it hard to figure out what's what at a glance. Now that the
> parse-options subsystem supports grouping subcommands though we can do
> better. The commands roughly fall into the following categories:
>
>   - Operations that span across the whole reference database.
>
>   - Operations that read references.
>
>   - Operations that write references.
>
> Introduce these groups accordingly, which results in the following help
> output:
>
>   Reference database
>       migrate               migrate the reference database to a different format
>       verify                verify the consistency of the reference database
>       optimize              optimize the reference database
>
>   Reading references
>       list                  list references
>       exists                check whether a reference exists
>
>   Writing references
>       create                create a new reference
>       delete                delete a reference
>       update                update an existing reference
>       rename                rename a reference

Nice.
