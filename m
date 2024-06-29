Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FD25660
	for <git@vger.kernel.org>; Sat, 29 Jun 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719671984; cv=none; b=PYeodpXsD+cU1vT6AZTg01FDqyvoosJaRVrRH6U/B8XzySs8kpwFVkd1L4wO/GLlNFjrSDAYioYadf/S1P1xabKv1Jg/EyR9zLtpCl//LVQ4Kaj3xxfSzcJUT9SfJwBdUDjLRI8xgVAoFDJqq5auEjgQiITY0X0Xmf1JyFH1mH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719671984; c=relaxed/simple;
	bh=xOPVFZGLcEf19PL1/7dSCZ7aTvFINV40T0Y9AZs1xS8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=t8s1djBQiGjbIQlYT1xKVmKtlx0664rD51EHieq6COJ5tdigbdFA6Gv7nMXoEHAIePvfbaRn1DCbd/nzG06Ba/8SVmVICobFv5FOzlTj3UwthSkFQOJ1r9hZ2nubr9CkbuM+J+xWoEI6d85m5z73mnUPFiUph5reUpFwxwa9s24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=ltX7v4jb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LtE3rABm; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="ltX7v4jb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LtE3rABm"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 01B3D1C0012F
	for <git@vger.kernel.org>; Sat, 29 Jun 2024 10:39:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sat, 29 Jun 2024 10:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1719671980; x=1719758380; bh=xOPVFZGLcE
	f19PL1/7dSCZ7aTvFINV40T0Y9AZs1xS8=; b=ltX7v4jbxORKWFLzA87t7e+FPu
	SvQ5O0CNrqzwDUyPNLWWi/nUyIXWHGfxTXaAjiYsP1u2G8alR56ZxZ07kLXPT/TE
	ftHUg61B0vecdn8h2TTmcuBpHxM99Hj9Ob1pdKI0laV1QrVw6PRIlIML4FyJpXw2
	Rjte6pvFMMHB6th2lQEPY+NOp1Ny3vb/RY0vfH4RTEAYZ+WSID2g08O6pPNhnFLP
	Z56IB1qkfKAW6o/vS0oulmP3arSkpFs1rFcVB5QiOk0k4O3Bx2YCaAj9JfjiAlNC
	rXpcDz2JWwCC/gYbeXk9wHW9DEy1aISteyCEEZEj98XWNVQzpsy0E9Ff1Z4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719671980; x=1719758380; bh=xOPVFZGLcEf19PL1/7dSCZ7aTvFI
	NV40T0Y9AZs1xS8=; b=LtE3rABme0wX0y0uTmVobYKMiISM1QCSdFBdQfEuw63Y
	Z0JiK8Bya/T17uNctrArHDPJeZvUscJmT0qzRG8MrRWsUayTMxSkXUCPrYEsn40R
	+fbmK/bVK1FaIO65K6qWo+a5Fo1oAl5mwotbXv/jgwUPNTnWdps92peFGE0p80rK
	ZyL1/3uVE0v7XZEEN1cxX70m4MOrjLD0GoZlniwnkLTnMzUnXe3roy97o6lkRHqW
	NtX669L8/m+3Idh2lkc0aN84FeiOC8rOF2S8jZs/ZJag1+ry1oeCMBcKlTwzXW1A
	rYeEi9EA1r47gdJCRTIS9uiOerwg6BgllGGNyhu//g==
X-ME-Sender: <xms:rByAZjj_YoHHungmKsiAMNH06RmLsuQwUtafRnCrUG6DpviVMb_X0A>
    <xme:rByAZgAXCShqhRLr6w6d3EMRj2cvXS0uYkRI2skMejxTns83llwe94NbYkt6DUCwe
    BrNNObSXgGpapBP_sI>
X-ME-Received: <xmr:rByAZjEj6WHD6ol_-C7LbGswJzg4LppzZhlEJJmB0J0-6RgjV4M6-uTI9HzrODUObdMeB1k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtdelgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephfgtgfgguffkfffvofesthhqmhdthh
    dtvdenucfhrhhomheplfhulhhirgcugfhvrghnshcuoehjuhhlihgrsehjvhhnshdrtggr
    qeenucggtffrrghtthgvrhhnpefgteegfefhudekvdejgedtkedtueffgffhjeffledvue
    duhfdvgeeuheefkeevleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehjuhhlihgrsehjvhhnshdrtggr
X-ME-Proxy: <xmx:rByAZgRu8VkNX-6YMYwppOW3vQ1F9oPoWWgdJmcUj6667e9DpW3YrA>
    <xmx:rByAZgw0l1TzCTx2x_EzQ4TGtEdCuGD5ht4GE63SYPZDRn8rT9yOCw>
    <xmx:rByAZm6NGsG2-2A-wLCspIyc_0dfnpzXSQuLL5_bER6CpnTzO6wUpw>
    <xmx:rByAZlydZEuC5tqmeyyxK1wcC9zJgzIr4I3itpLRGkalIiUloBUwDg>
    <xmx:rByAZtq1XgkuaVFYuYVlDgwgj2Bsq9NO34T9aUCAEmgZW8INHzn-LEHn>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Sat, 29 Jun 2024 10:39:40 -0400 (EDT)
From: Julia Evans <julia@jvns.ca>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Confusing treatment of "head" in worktree on case-insensitive FS
Message-Id: <A72DCB1B-8D81-4DD7-93AD-BF37E88E9D63@jvns.ca>
Date: Sat, 29 Jun 2024 10:39:29 -0400
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hello,

When I run `git rev-parse head` inside a worktree on a case insensitive =
filesystem,
the result is different from `git rev-parse HEAD`.

Steps to reproduce, on a case insensitive filesystem:

$ git init
$ git commit --allow-empty -m'test'
$ git worktree add /tmp/myworktree
$ cd /tmp/myworktree
$ git commit --allow-empty -m'test'
$ git rev-parse head
adf59ca8da0ee5c4eb455f87efecc6c79eaf030f
$ git rev-parse hEAd
adf59ca8da0ee5c4eb455f87efecc6c79eaf030f
$ git rev-parse HEAD
fbb28196d08d74aa61f65e5cee3cb11cc24c338a

This also happens when using any other command involving "head", like
`git show head`, `git diff head`, etc.

What did you expect to happen?

If `git rev-parse head` returns anything at all (of course on a =
case-sensitive
filesystem it just returns an error), I'd expect it to be the same as =
`git rev-parse HEAD`.

I accidentally got into the happen of using `git diff head` instead of =
`git
diff HEAD` on a case insensitive filesystem and was thrown off by this
when I ran into it.

What happened instead?

When in a worktree, `head` appears to get resolved to the value of =
`HEAD`
in `git rev-parse --git-common-dir`, while `HEAD` gets resolved to the
value of `HEAD` in the worktree.

[System Info]
git version:
git version 2.39.2 (Apple Git-143)
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 23.4.0 Darwin Kernel Version 23.4.0: Fri Mar 15 00:12:41 =
PDT 2024; root:xnu-10063.101.17~1/RELEASE_ARM64_T8103 arm64
compiler info: clang: 14.0.3 (clang-1403.0.22.14.1)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/bin/fish

