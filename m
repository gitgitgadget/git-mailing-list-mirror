Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6944CEE45
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961097; cv=none; b=JXDMFMES+miRVh+q5ExnSziOrHyz0sWpFrTWS2UZ92yNtKkh70Avdny6mu+tAVhgmlCzI2ghjjw5s+MLohMewpC6e3wdIuhsikO+rABkWd0ErhRszS6Qp08keiDnW3R26UlDnQEMyhk5lBciKpD1VLKQe+C+3RDdKSARylOYudk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961097; c=relaxed/simple;
	bh=5rUml1nATYguWIh/uX1RNJYNwQ/L2uTy9fTE+rOFSfo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WWKDoOIIAcpEiNVUnngTrVRmc7ZcYR9f2SJ/MflWPhdBf8v+JjgeeQScTriBk50q878F61QX9c1felOgo5yzr0u6gTwE2wmaOjoDF92adcWiPxl/Dg/KU9TlbVFMU+G0xDGaC28HwgXPcA9kiZd8/4kDuZt0thNjzI3Mp7+IyhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g6Jx7D8m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kPQf3qjr; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g6Jx7D8m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kPQf3qjr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B1C631D000E1
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 13:11:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 02 Oct 2026 13:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790961085; x=1791047485; bh=PlR5DWtyuq
	uCjS6/ZUocjshbybnCoz58BtDZR0njQOw=; b=g6Jx7D8meQYZYPaCaPsjugvRLG
	oRb8C+LYQcGTpT1c4NMncuwxnd+FD4IJvSO4lJbmfJQIFKuIRp9dBt/BD8bdss81
	cExQ+r2CUPhsIQDLlslZBGySstSrBvZ8ZJ0UauizMkjqMtgKGjAX9DV4Lnnig/f5
	SFMwiA6t2xJ8Oswgejp9JHebtTeKK+V9rND41jSNZxsvxm0zRGGXVSLioJ1DHhi2
	AqMjqWk75mFI9ctwgCpe691eKD/kzy/PHaF7ARpu1VI657ch6uiM7HkWRf+BZWjQ
	wQnQPbAYDt12NU37EyowO5nLF6mtdSM2DlXfl8ESjZ+L6qne3dioznKBZB+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790961085; x=1791047485; bh=PlR5DWtyuquCjS6/ZUocjshbybnCoz58BtD
	ZR0njQOw=; b=kPQf3qjr3O64llVCrExUAxBbj+wbxoIciNeeha/r8k6BgVJSAW+
	LwrW40awiH2WBkP+ccELfetQrYrJhjFKV6DAR2uoqRolkO9K/XLhIkY5IikIE4B2
	YciijwUg4iuFMSsPVcvDD4/XzjfsMHgx5Nfz2ieRUwcl3wZbwVjrKmmTDQKlJvaK
	+PWm3NVBEgklskKBFGRkeyEgVOKSQk64fpDtaqHThtmcq0CXVuTRj1wnma4+OZ74
	HnnjzLMnKM1Lr1M6NXIC9FMQyFzv3TSO26SrE10EwUE6H9p5cCmMMgMU+pgdASqp
	lBQxPmgLSI9J56upmhTKYK/pHM2ON1nKnZg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790961085; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:rtabNhABKxrdwm1/Fl3cAveSo3zkPO52AzhfiimjiElRunv
	JpSfE2ppD2f7T8MCGE+wHcbOc24Bybqm3EXuAW3ZVNp4jB92zEUdgZJK/2dXTwpu
	wCKpiZDqePj0sotIYLAnJ3ClcBfA5nQHncG2w7XwdaXsgaHahOw5i6pYx9rF1Cwt
	dwoGHVpBQmqkZIgp8Mqa70QWqsi4YzGg57EPaTilAac3o6qx9I4pQHG6B+RwyB9a
	wezOj6aKWwyxJFEOmtw/rdkytK0bkT252d70e7IVJdgkPkKRlThNN2ksOKo0/ru7
	OG4EyzvRQhb0atDj0QrIfrVvAiyPxfsCLZ1EQ0A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:3o3ztdonL5Jpd/C7BVFeWCeZNO2e3kuU8dcnMK0ZU4o=:5rUml1nATYguWIh/uX1RNJYNwQ/L2uTy9fTE+rOFSfo=;
X-ME-Sender: <xms:veW_alnBVXPPS5OQ-Gx6yE5PkKgCW07mwyIqbiZnOap711muC7n4HA>
    <xme:veW_an0JdPaB-SaAavCosLALaokNZfY25_76VZVLjUW8hEw8lXqZgpBCwv7hoW6mz
    yGtQJJtTbl9SOW5epmj0b6Q6RVg2TnGNs2HHaM76cGGpRg4yKFchY0>
X-ME-Received: <xmr:veW_agpmFMNEWwnJsW4f31vLbxQRX7HaG572DcvcuEF5Xi59EkEJQSdyQLJ0-CQWiQfB56GWIr972wRa9l3sysy_XgTkufKA_R6w>
X-ME-Proxy-Cause: dmFkZTEOB2WcK5CCa5IdmXWJJy6eYcW+PFNWL9rKTBxRrStnydWbcuSnOy03nWI6kzwQW1
    VzMyQvnL63MpbvBSs4dXrP/ABkwHEc9l57aIMBu36m/ug0SugQhKQquRUIDq1rXqcUUp7E
    lfEfF8oVEvqPbTOCnY3Y9nz8FBMpDmmR8WjnqAMfBxjvh/LuVLnL9qxQGr1VjRK7nU5eq5
    oII1dBcR/ZHeqjnoV/45pDAfs4NSMyINCmO1nJsYxafu9aA7UZ3s6rjs5IDjRlWoZCHjYg
    1fKsBBTtNa1r4/2loNMmR+QVo0zpuntU5vS6B0Uedwf03XXMeHGgDDIb8s5DjCPoQLgotl
    PJElKoqRG+kIvaeNLZj2YvwEOET8rCJDrBlZjTZWSszT5qLmKTuQotFGNe2ocF4WGsxnJa
    /EorS3FxEvCUSrlSXbwJjeh1U0aSOsfUFqjUS5nJdZ2nioIVTxlJd4Asj9lKzOy9geNsWY
    0lWzJDKuKqmAgWvZTQB8vVf/pEL+P8XAfVDxf84tmjPDgmVKpOepIWUvq0UYU8rhjY7WTA
    npdTLQgeBxuWVcjFJGUhBJ0lFRpZQnffGwvf28/LM/KVwxC06exIrffPBURsqlTdPHlKw7
    sAvME0YATQqCqiLuGi2eakK0O3USwAdY4iBYHuxgAFHj8TWfB+sm3+MJhKOQ
X-ME-Proxy: <xmx:veW_akd8tPnIlOJ9fEH9sqdUYTXtFqS1qX2YQ1Mu4Y5M52FdiknqwQ>
    <xmx:veW_avrpNUoCcwCj2Q2-R3ZvhkUCdRQ3TUWMpckrYdfhHvyS5WcBzw>
    <xmx:veW_alGJOdb3IC_rVPn4qaNLm6ET7lwkQTBiMUowbyh8HYcOK8HSsA>
    <xmx:veW_avtQdUQ_KDjmsIMgLyFdLmA1oGpRsv9-ts4df3gt2LZ890E7-w>
    <xmx:veW_asK8pRzSfOvrKwbU9bM4Y6xDSvpJtjTO1WD2ipTXrrHqKE6dxxPF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 13:11:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged default to every upstream
In-Reply-To: <pull.2428.git.git.1790960147943.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Fri, 02 Oct 2026 16:55:47
	+0000")
References: <pull.2428.git.git.1790960147943.gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 10:11:23 -0700
Message-ID: <xmqq8q4gxc1w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Cleaning up every branch whose work has landed upstream required
> typing '*/*' as the pattern.

This description and what the code actually does contradict with
each other, I wonder?

> Let a bare "git branch --delete-merged" consider every upstream. As
> with "--merged" without a commit, this applies only when the option
> comes last, so "git branch --dry-run --delete-merged" previews the
> cleanup.

There are many options ('--merged', '--no-merged', '--contains',
'--no-contains', '--unset-upstream', '--edit-description') that
default to the current branch, which is a very natural thing within
the context of git.  Is defaulting to '**' is a good comparison to
them?  I dunno.

> +			.defval = (intptr_t) "**",
> +		},
