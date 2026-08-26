Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6AB47142C
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787771687; cv=none; b=rlU3VINYI6U0yeS8aXlVFcvfXn3aaoFjUBnEeiCJZpyeh9vc4w0PI/XPJ8h+Vr/b4JjTYcMSrM5NxvA5yvWsZpfg7uFK8ipQERQN0lNOtq/rLMZJ68SED3qUlO42SrEAa66MdnaEUlW8J3laJMcHCiUxd+qAi0UjjRKKvw0qf74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787771687; c=relaxed/simple;
	bh=teOrOn/58Xm38HCC7jN3vFq/2AgMHqitrvzLewv39do=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=deCSwhYECLmhsw+SgDsN38+a/FhUepSIVbanYpwu9soFH+H+Zbdz3sU9/vanR0T5eHNfLA2foGmwUNVvF2x+pzdDPJBPongz6TnfGZ3HDvJCCmXU8QqWcmlOfzGvu9RubS5YkYVJsCiNE+hspSwYtKu/wJb/kFQRB6Ds23L+TmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bc6z1F9j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=anNgHUCU; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bc6z1F9j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="anNgHUCU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E788F7A0082;
	Wed, 26 Aug 2026 15:14:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 26 Aug 2026 15:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787771676; x=1787858076; bh=etF4Fe5zOm
	cpIZpbL4f2/hOqGzVWfCTrrVV+HG1HXzI=; b=bc6z1F9jB7wLRA5z7svuaeDyeM
	+TNnMFtKPGurKBOqhMq/DX2EuD2NxnEr/VtMx9FvdohCpSTyz1h4928BXD3d9Mbv
	ZHEOet7ik2osJC3J/RlwX94ojm5jGY0tQKUcS6C6iPFlnUCfZL20xpdE5Fwm5kF4
	j4tgY84ejflKYFUomrmfK2boryhUFxL4syxMkNm0N9fpFrdWbB3UWlVVzwAJycxR
	cnf4lt3I3SQumP7pIkSZcrPvoM5sXa/YVdEIFqsgjv8CApDq5wgn73OzAGAIAXrq
	yNpwcxyxXA8PMhntHmTUprRR+N51KHXBaFHCKnJXnuMNnIZjj06camorm8NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787771676; x=1787858076; bh=etF4Fe5zOmcpIZpbL4f2/hOqGzVWfCTrrVV
	+HG1HXzI=; b=anNgHUCUC2S0dPYI3R8vAkwoqGl1+I22KcPmefQZEbwtt4gGRV1
	lz2qco9gbG5z4d8dCAbhdzCrJ3ZWy2YbGR6slJcf2E/V3w2DSICQHiI6fYABC1NN
	+oVoDlfjO1diNSbBHeebHRUSVLOZe6RRCAjHiHRxMQ8kF02sFMYSMX6hLRKpmjuc
	7GVhF/ke8SSnPeyw9WlcC/ps+OjotDemyyAzh+2JUduvWHWQKIINrF0B2Y+AlJFL
	UQjljza57NNbCtw3GQVKLOsoqz8WqNI8iIH6oe0kxci8AJq6xyeG79KlgUTp88dn
	L2WhNfLTl8eVStjWoujCKRCxydChy0FlNsw==
X-ME-Sender: <xms:GzuPaoqwNzCNAxhDaCPhfO7Y6HusCa8wg1DqbKId6TMlZPWMQbo5lQ>
    <xme:GzuPasc0qtRt9KohAb29xNv5W4DuXouD_krID2-OxhQDF5XIrMEvSvy4dGWviZ1PQ
    3jB73mcYQb9uMQAfBQUXXefEg-qg3365aAIqBC-aFOc7YKjELTm>
X-ME-Received: <xmr:GzuPanp4mF5NEpwaSKfbUcs9Udbf199mYitsye1slyWJDvECUHoh19g3aTxLIuzaiz_Lg5M1vV7FNG2inVAjs0eBsv9nyS-rQw>
X-ME-Proxy-Cause: dmFkZTEepx/SugniHBBRbxoJeQ7eIB/ybWwhUxka1Ib/eRCZ02+qae5H5XuB7+ZPf3K3m3
    GGzqNi99JKQ+yjDOI/RMBqU9i3qoRO462CVaRYzng+PippzcBGX7kT68VmWRfkdolP/2sk
    +bLb2lOzRuFqgCFkCdrbMr+RAiECq8xvsAuXJWgz3CbKU79UXtlDmdLIwMSpcKamo3CJyE
    dvgmhxwOuxuXNornvwj1x1Wg4FwPkCLRMEVBZk+0WL4W628M2DIBVrqQhOXkA5HTG5dxQ8
    BO5FKah9c1LPqxl/DnbiVOG7HItUmx7qEX7w7n6geMGD2dsSRKwPsyWKLJrw+cG4l1oal1
    Z0kEpI/ZC8QtvGBwvrSy8PQPxO09Nc9KtGj1AVVJQijjRA3bRpp8bL6nbaCMbSyvfcClPz
    Zh9+ieJiSC2CTmQ2ySkAsMWmFu6+T4xpSQRn4RNKN98oqGTdIkcicPRBlWKfhtayS1pkvk
    FGL1xVN/Gjou8btR2g1eQSDPtlFio4L8Yz5Vom0VH5fZq7ZDc846PTPc4n/efVMOrhh5+r
    bTdkAtoExw620P1f7GoDopoG2cN1ntFQBmfVV2XN3JROUd7EBU4Gw73gu1uisVbwy7DPZj
    QtbAlxrVeztbSp/9lchya8ksS3hPiDDw2BT4yiiY41mvP0rhVbDvie4qx8mA
X-ME-Proxy: <xmx:GzuPatE1N256gpakPrcf0ct3NcBvwK-X_MYP5DhlUi5oqHi1LkDYeg>
    <xmx:GzuPanvDcuqoGpHuBoZEBCoOi6mPtoq6BqgU6fP2FLi83YIgK57EjQ>
    <xmx:GzuPavWjDuno-Zwc65b_2dHoy0s0mOZk5LqeJHRI3kno60h9eScIFg>
    <xmx:GzuPajGAeKEs901qKBFEnxw3BVw16CwRjXPQP7VDr9tdjuU73Mx_-g>
    <xmx:HDuPaqn7pzdIpY0ISS0yXHj0OQcs9LgiU3v3YrK5dYeiKpr6UPPykxRv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 15:14:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 0/2] checkout -m: refine autostash fallback
In-Reply-To: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sat, 25 Jul 2026 15:34:27
	+0000")
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
Date: Wed, 26 Aug 2026 12:14:33 -0700
Message-ID: <xmqqld9sg0di.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Avoiding checkout -m autostash retries when no tracked local changes exist
> and visually separating autostash conflict advice from the subsequent
> branch-switch message.
>
> Addresses #leftoverbits from here:
> https://lore.kernel.org/git/cfd09dbf-8d77-4464-8030-3a0ffb4aeae7@gmail.com/
>
> Harald Nordgren (2):
>   sequencer: teach autostash apply to report conflicts
>   checkout -m: refine autostash fallback
>
>  builtin/checkout.c | 18 ++++++++++++++----
>  builtin/commit.c   |  2 +-
>  builtin/merge.c    |  6 +++---
>  sequencer.c        | 29 +++++++++++++++++++----------
>  sequencer.h        |  3 ++-
>  t/t7201-co.sh      | 17 ++++++++++++++++-
>  6 files changed, 55 insertions(+), 20 deletions(-)
>
>
> base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2364%2FHaraldNordgren%2Fhn%2Fgit-checkout-m-leftoverbits-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2364/HaraldNordgren/hn/git-checkout-m-leftoverbits-v1
> Pull-Request: https://github.com/git/git/pull/2364

This topic unfortunately has seen no interests from others on the
list.  Asking Phillip for help, as the leftoverbits comment cited in
the cover letter is from him.

Thanks.




