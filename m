Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F5A21C9F9
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770058358; cv=none; b=fO8uHheAZLROESFLfQhs7v7FWJ6UcEtxklVcenHYzkcXu8VXjx3bJ4Btqil+DVGs54ahAGV/wBJDQh7FDun/tzyBp5BXSM7wsnjxPu0Bze1d5Vp3QUBN/v6iXM3oqJWPnNkhh9RvNleG2m1FNk52UtyUCBNSa48dH+lZSKtttZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770058358; c=relaxed/simple;
	bh=i3+5yS1siv/n8MKp+guJYUJ4qqY2UpjK63GznTniQ44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dn+IZ+3UmxmuWji9WlV0nsKKM55u+0Is6xpENPc684MDl3MAak5IrsE+hENVUubFKiZ9Q1MOWdOeyNEn14yY9zRdqJm0nXL1vzgWmitRbqMHbBjSmeKOQ4mqqJRTwhLxuKubfSd8lz6kt2I051AG24lyJHGI3SDflkdsaayDBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ftDTgfji; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cf4wrPYm; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ftDTgfji";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cf4wrPYm"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 3DBFC1D0003C;
	Mon,  2 Feb 2026 13:52:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 02 Feb 2026 13:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770058356; x=1770144756; bh=ReFC2TfrHx
	eWfTQKAUsZfLTkVkoOCyDxJ6cd3cxnxF8=; b=ftDTgfjiD9AVxU0BygGtVU1zi/
	ARA2hcpL4gvIvhuTFAeF6+yCMP42tvSOVy/pkidSQFRKStAWM6HeVruTU7wy6Jmw
	nJh07QMh54r8oW8CYWs4CMli05D5Mw2F6htjd+ELkR3GIlLi0t5xJdrz5NliUGh3
	fTvURCUj2VzU2p4YnQ5iFBm4vfu+9Rz43Eu5Bi7B0ZgVT60b7jVDf3PDXYwGyNFG
	pIoa39TFMreXGxMqKBbUSx4ZMvmB9tdARMrFc4Q+zXbIsTkvQQT7CXpLz0+7YAHJ
	0PYTBw1cIfoMmKS3BPEA4CplTxNWcP6TJWfkwSZp8rE0jTdzpP3oVc1p/K2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770058356; x=1770144756; bh=ReFC2TfrHxeWfTQKAUsZfLTkVkoOCyDxJ6c
	d3cxnxF8=; b=cf4wrPYm0AuaoVcUqikfR8WzuNCjcSLbLv7nJlrI4pJN8lOT+4R
	HUUyb/Q84yhgkQ1ivzLhXXsXsjjZnl+C/hdEA6jGB6Zygmm43Pr71g0VcD2MwuCI
	gxttYx/g0G3jzxyWQGWGiSk3GaG148JdxQ2UjrXmQWp6qiiTewYNNoz5suvW65K3
	toIivjsQhLFaerFILFbhKVEoeDLPFz1qlGLOdTihK9ScArF4ynptGHPAHih/F67q
	fQ3tvSKpTQDFfbUyxfKOcIQvOmzdLksJQsc27ljnza7y4xYgVADnGnq4N4zOz2Vp
	LCoUhiNfCCYRlGibJ9VkuXL/FJZ9ZNX2x/w==
X-ME-Sender: <xms:c_KAaeu0IKJHmY5QvqrjfvU7YhyC04cARiXUvkL52hHtNGova5xsbw>
    <xme:c_KAaXJrjfTlX_9mkTe1ouZx-xigqnGjukde5_nV0rkIB54YCFpy-HxqTNmYsw7Gr
    ilJfYfCjgZlitReIcFCLqaPjLV9MMIkhObP9mL5YCwpKAKTO4URTw>
X-ME-Received: <xmr:c_KAaTmGmmAWPhncdeRbWLFrbehl2yuRvJ1kATOdbFIgFfQ85zJWD0ihP3mqh_y52zVcu2EUDu0L8pUNGTLlckL5xKZTg7tF3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifhhgrthhf
    ihgvlhgurdhgihhtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehglhgvnhgtsgiisehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhsse
    hpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:c_KAaQLM2wS9dKm84DWwJFPHMxPbpm41-wJkKGYQrTZDvwy1DpSHyw>
    <xmx:c_KAaQ54Lb8NakZ80DQBQswGJHBaZy11h4r-gWFZc7qDL0GtFVTZ7g>
    <xmx:c_KAac3QUKDxjlNhOgq_m9c9kN6DwQjE6f7AfxyevqzvMLvdPI7mgA>
    <xmx:c_KAaeeLBS-YFncbnz_r7id859_YHqSvY9XbrcNpzNwhNPYliX6vdQ>
    <xmx:dPKAabR5qklIB9gueKqSK5d3DykSZuyAPdZs4L0ZJwT389f7RK3DKqPa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 13:52:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: William Hatfield <whatfield.git@gmail.com>
Cc: git@vger.kernel.org,  glencbz@gmail.com,  avarab@gmail.com,  ps@pks.im
Subject: Re: [PATCH 0/5] submodule: add 'reversive' traversal options to
 foreach
In-Reply-To: <20260131214309.1899376-1-whatfield.git@gmail.com> (William
	Hatfield's message of "Sat, 31 Jan 2026 16:43:04 -0500")
References: <20260131214309.1899376-1-whatfield.git@gmail.com>
Date: Mon, 02 Feb 2026 10:52:34 -0800
Message-ID: <xmqqbji7yo3x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

William Hatfield <whatfield.git@gmail.com> writes:

> This series introduces robust post-order (dependency-ordered) traversal to
> `git submodule foreach` through three new flags: `--reverse-traversal`,
> `--append-superproject`, and the shorthand `--reversive`. These options allow
> users to process nested submodules before their parents and include the
> superproject in the operation, enabling reliable automation for
> dependency-ordered cleanup, builds, and deployment workflows.
>
> Highlights:
> - Implements all new traversal flags in both the C helper and shell script.
> - Provides a comprehensive test suite (t7425) that validates the new behaviors.
> - Updates documentation to describe the new options and their intended use.
>
> These changes make submodule automation more powerful and flexible for advanced
> and dependency-sensitive use cases.

A few comments on the overall structure and concepts.

 * We do not want to see tests in a commit separate from the commit
   that fixes.  The downside of such a layout of a series needs to
   be understood.  An earlier step of a series may introduce a line
   with "test_expect_failure" plus a short summary of what the piece
   fixes, followed by a large amount of code to show exactly what is
   being tested and expected outcome.  But when reading the step
   that comes later that fixes the issue, readers will only see
   changes from "test_expect_failure" to "test_expect success" with
   most of the test to remind them what the issue was hidden away
   from the view, in the post-context of patch hunk.  A commit that
   has both the fix and the test that describes the expectation is
   much easier to work with.

 * The name "--reverse-traversal" makes sense only to those who know
   what the normal traversal order is, but it is far from clear what
   the normal submodule traversal order is, because there is no
   "natural" order to traverse.  Any of the combination of "top
   down/bottom up" "width first/depth first" would make sense
   depending on the application.  If you are doing "bottom up", for
   example, please name it as such.

 * The name "--append-superproject" sounds strange.  It sounds as if
   you are appending the superproject to something else, but I
   suspect that is not what is happening; instead perhaps you are
   leaving the traversal of the superproject at the end, or
   something?

Thanks.
