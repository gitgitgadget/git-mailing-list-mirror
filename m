Received: from mail.hyperscal.ing (mail.hyperscal.ing [206.189.5.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AD32E3717
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 03:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.5.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751773108; cv=none; b=DpDFujtdkXidG5LySQKUeodYEjU02i5cZt+7bJcYtbxj1q6HXCcpkK6AttU4EFH4V+Ce54Z3r/zJNFY9XuTL9c4jQcvF+Q7SnfJ6bWoh19Ov4owy+MjEaPZOw12vGYNoyR3Zap2srAfLESpm9SCaFtpxHOY0KuRb5ECms2omKuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751773108; c=relaxed/simple;
	bh=fPs4zKY9sSEZX6sMYfT3Jq4WQzJJTI4NLSAeP+r+Qs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tk7pNnS9fQUX6hRti6DxvwGrKoq54LI0GnHZ8KK+90NWNncP5zBnkubVaWRNPXH0evJdWgsBI418pLTZKzh3eHKNezrACPLB77lm/SsSaAXospasMpzScSPbiVrXz8cO2phjNnFBI+W2JvcTkvhFdMcqb1t+6IiCIJk3MTHuCMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ryz.dev; spf=pass smtp.mailfrom=ryz.dev; dkim=pass (2048-bit key) header.d=ryz.dev header.i=@ryz.dev header.b=B7DQquge; dkim=permerror (0-bit key) header.d=ryz.dev header.i=@ryz.dev header.b=z6c3AxAs; arc=none smtp.client-ip=206.189.5.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ryz.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ryz.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ryz.dev header.i=@ryz.dev header.b="B7DQquge";
	dkim=permerror (0-bit key) header.d=ryz.dev header.i=@ryz.dev header.b="z6c3AxAs"
DKIM-Signature: v=1; a=rsa-sha256; s=202503r; d=ryz.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1751772975; bh=0tx/p+GFPUFs2a0d1fJDIwO
	Vy4tfodkU7UHrvPPdKDY=; b=B7DQqugeKZPEb6uWQqPR8KcsaV0gTkBthoONsTO+2J08AaoOnX
	LeiViqpW/XGG3KxTcJB/y1ugqypBdoFpAzNw2IT+Xf21msTqEgcYGlYWeJO400RnsHe4gMw6Bzg
	r6tvzrMc9eP+QnyZIbHZx7sA8Kq1kbN7fsGGJ8d73ZIZ3KHo+Mq8bWRX4jFuXAdY2EFpBHhaWD4
	nuasFgg474pSA4IMEWv6vEcIujqJOHLTQoFJffU4nxbZUazr1zZGKFx6sx6FBo4zVjuXnv+vSVY
	B6D1lSVC7scTvSZS0/hD1meBT+ZkR2HOD6DBPnmdh1ZYRT/5YK90vEOKtG5CN1bYsiw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202503e; d=ryz.dev; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1751772975; bh=0tx/p+GFPUFs2a0d1fJDIwO
	Vy4tfodkU7UHrvPPdKDY=; b=z6c3AxAsTlpZN80PkTDseu4amADUfMLTdEMkmq5TU6TnxKg6lc
	RoAYy7zcw1rrnM0jlBu3hgRs7ztkzc9FewCQ==;
Message-ID: <f9a6c8a1-bdbe-4892-bb71-39a6307a5452@ryz.dev>
Date: Sat, 5 Jul 2025 22:36:14 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: "git stash create" ignores "message" argument
To: =?UTF-8?Q?Jos=C3=A9_Miguel_Armijo_Fidalgo?= <jm.armijo.f@gmail.com>,
 git@vger.kernel.org
References: <CAKMuBmSeFh63212_GhBHfOTbW5VaqvQjo7jz4aowm8bntCXkVw@mail.gmail.com>
Content-Language: en-US
From: Darren Rambaud <d.gitscm@ryz.dev>
In-Reply-To: <CAKMuBmSeFh63212_GhBHfOTbW5VaqvQjo7jz4aowm8bntCXkVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

You won't see the custom message in `git stash list`, you will see it in 
`git log` while in detached HEAD state.

$ git stash create "changes to readme"
0a28354847baf90f2c7377a262f35e62c461a95e
$ git stash store 0a28354847baf90f2c7377a262f35e62c461a95e
$ git checkout 0a28354847baf90f2c7377a262f35e62c461a95e
$ git log
commit 0a28354847baf90f2c7377a262f35e62c461a95e (HEAD)
Merge: 323920c 46c4b6a
Author: git stash <git@stash>
Date:   Sat Jul 5 22:18:58 2025 -0500

     On main: changes to readme

commit 46c4b6a5d22df525da70c1bbfc6d3a36c4ba25e3
Author: git stash <git@stash>
Date:   Sat Jul 5 22:18:58 2025 -0500

     index on main: 323920c docs: add readme
...

Darren

On 2025-07-05 20:28, José Miguel Armijo Fidalgo wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>      $ git stash create "example message"
>      1e9b483d1f9477de5c99a708f4aa512ba
>      $ git stash store 1e9b483d1f9477de5c99a708f4aa512ba
>      $ git stash list
> 
> What did you expect to happen? (Expected behavior)
>       stash@{0}: example message
> 
> What happened instead? (Actual behavior)
>       stash@{0}: Created via "git stash store".
> 
> What's different between what you expected and what actually happened?
>      The documentation does not explain what the message "argument" is used for.
>      I would have expected that the message would be used by the store command.
> 
> Anything else you want to add:
>      If the message argument is not used at all, I would expect to
> remove the argument, or
>      alternatively, that the documentation explains why the argument
> exists and what it does/doesn't do.
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> [System Info]
> git version:
> git version 2.50.0
> cpu: arm64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> libcurl: 8.7.1
> zlib: 1.2.12
> SHA-1: SHA1_DC
> SHA-256: SHA256_BLK
> uname: Darwin 24.5.0 Darwin Kernel Version 24.5.0: Tue Apr 22 19:54:33
> PDT 2025; root:xnu-11417.121.6~2/RELEASE_ARM64_T8122 arm64
> compiler info: clang: 17.0.0 (clang-1700.0.13.3)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh

