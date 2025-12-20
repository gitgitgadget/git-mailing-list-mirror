Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F287C2F39C2
	for <git@vger.kernel.org>; Sat, 20 Dec 2025 05:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766209462; cv=none; b=jjRXWO96O7Jxs9IloJRHto+zcFrrWL/F/+/GbpcpKB/OGGuULBSIvB3VJDsC8uPG8h5DZwilC9Om2sXf4afNBNbyT1zCovibTSP1nCyMuDWEjG+IivVLxyfo1mQxDPR2JFuqhTcoYe4iIiwlpncXkN3PzJjfTbjsjKD164vogDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766209462; c=relaxed/simple;
	bh=07K17szsTDOLw8d9WGCb6ZQijnosU8w8qmH+Efs4K8w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FKeU34dxz4ybDNHMecMjMooewJRjhm12mtznz0XPwnt8fXeOQq3M8Hit4gsu6SIWZosbWMUcUO/pGwEmpfilVk9/XbHYwFn4TBgqSF1wwQqK5z2Wydq9nF8IpB1YfZMwn+uDhdhmIqhlD0+yDhCdqrFdii29DnBlpFE7YQwR7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iiWSeysS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eGrqVbUg; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iiWSeysS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eGrqVbUg"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 76A67EC00A6;
	Sat, 20 Dec 2025 00:44:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 20 Dec 2025 00:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1766209457;
	 x=1766295857; bh=vTWSQN+NR2LSRR8kSkCC0RoiE8uYx3lfLRX8TeqB5Oo=; b=
	iiWSeysSrSyYF24iSCU+6WfdHDBs+RbMxxf59jg9tMJDzrsllM1jHIk8niJX9vxD
	2C/gXPOjjlZ6bM44zTtuwJC9nuL1Br7nVaZCab+H1xoYDaaoC9/BEbQgsFTUC7M5
	XY4Se/ueuFUw/vfB4y7w1DyM3ZgnPuX2sBG4WmIOYeCOmVvMCmGfZ7br6CNTyd4S
	FtZ06hXwElbtO89BrEupUQtfBK/AD5Ht8yRClnlpUItr+s41xcjGpwqFVWAx0MxU
	DqNtXoCmVi44w7cEY7Qb5wIn3ZDIoAb92SZN1SfuEuJOxeh/ArAUSVTPkVbZswY9
	4M2HdEKBQ/nWB0ZF0FtyQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766209457; x=
	1766295857; bh=vTWSQN+NR2LSRR8kSkCC0RoiE8uYx3lfLRX8TeqB5Oo=; b=e
	GrqVbUghl11Yp205f2TFBUMswtj0FyGkwfQik7ZhFgr3HDap4gZ2lh6JwB7l5nZf
	n/zewo+mdzQ5j+ZmT2ky///hnGvWhE/psEaoqeOW68aP8QbYBR+bU90J0AZJcaKR
	H3uSih8FAFzCV+qKva87edPhOwDVqbkRU3OYfq6Vv/kcPrYQ+w71ndotsNMD4Ixt
	NyocKJkTSXr/aLwcXUqGT3b23is7AaQEEi38f5FNEZNRquL3aEtWtwo6XFDyJhzE
	c3yBXSBABXNHjCpamvfcxxC8tckCThS9pxwoOqlTmexMmMroAj2k9noFh/YrM0cv
	X9fVoI+ZR5fs6w+P/OJ6g==
X-ME-Sender: <xms:sTdGaTFAYQOF7YIwHGgG2CtjHUEgSodiXe00Fyf0TkJm7rnFM6Z8Zg>
    <xme:sTdGaXNBbZYC-bsy5MQQWsFFwJ9GV4lokABqA4jxlefb6J3-ZiysKa55XsDSG8AT9
    gl2oWi6AXKNt0imgWdxYoxJP-4IQ2Md9nKVBt7JgmmeBjU11CLo>
X-ME-Received: <xmr:sTdGadfCaOiaBuMYv8cBM-uR8D7gb9zB0gdGY-BK-_7v5ugh0tsOP27tw3bR7sAC84sq0Kr7bBHmOBjW2n1mnSa-7xcq80s2Xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehtdefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrmh
    drsghoshhtohgtkhesshhhohhpihhfhidrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:sTdGactJfalyJ4wFjLnspdhdC25AcO1kOlKUc69ba5Vn0vMal2C1Dw>
    <xmx:sTdGaWmK3gCJf5vKqtX3MEznO1OuA3dBga1RfQFiNtcrJavyyXspPA>
    <xmx:sTdGaWye4_m1gGiOjM4NtZgCzCIcPQWSjR8m-HdYnFPLUkcwOR7TxQ>
    <xmx:sTdGaQPECPDAY8DJJ1H1WkTSKFOmLZ1TpEyGKZEqHp8JOda46hnbHQ>
    <xmx:sTdGaVv5OP5xrIjx0XMY0-2-3sUP7NtYatLlBXOKooW3qTBrvJtPy1YH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Dec 2025 00:44:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Sam Bostock via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Sam Bostock <sam.bostock@shopify.com>
Subject: Re: [PATCH] worktree: clarify --expire applies to missing worktrees
In-Reply-To: <CAPig+cTC8ROsf-cOhUcxovUOcQ47As496SAm7FcEFnzGChhLww@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 19 Dec 2025 10:11:36 -0500")
References: <pull.2135.git.git.1766156407442.gitgitgadget@gmail.com>
	<CAPig+cTC8ROsf-cOhUcxovUOcQ47As496SAm7FcEFnzGChhLww@mail.gmail.com>
Date: Sat, 20 Dec 2025 14:44:15 +0900
Message-ID: <xmqq4iplvhao.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Dec 19, 2025 at 10:01 AM Sam Bostock via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> The `--expire` option for `git worktree list` and `git worktree prune`
>> only affects worktrees whose working directory path no longer exists.
>> The help text did not make this clear, and the documentation
>> inconsistently used "unused" for prune but "missing" for list.
>>
>> This updates the help text and documentation to consistently describe
>> these as "missing worktrees".
>>
>> Signed-off-by: Sam Bostock <sam@sambostock.ca>
>> ---
>
> This change makes sense to me; it certainly helps clarify the meaning.
> One or two comments (below)...
>
>> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
>> @@ -271,7 +271,7 @@ mismatch, even if the links are correct.
>>  `--expire <time>`::
>> -       With `prune`, only expire unused worktrees older than _<time>_.
>> +       With `prune`, only expire missing worktrees older than _<time>_.
>
> Rather than saying that this "expires", I wonder if it would be even
> clearer to say that it prunes or removes information about missing
> worktrees. Something like:
>
>     With `prune`, only prune missing worktrees if older than _<time>_.

Yup, and a very related tangent.

The entry for 'prune' itself reads like this:

        `prune`::
        Prune worktree information in `$GIT_DIR/worktrees`.

In general (see recent topics by Julia, for example), it is risky to
explain option DOSOMETHING in terms of the same verb dosomething.
It may serve as a memory aid, but at the same time, if the verb
dosomething is not in everyday lingo, can mean different things, or
we use it a bit differently from the common uses, explaining the
option using a more familiar verb may be helpful, especially to non
native audiences.

In the context of *removing* a worktree, there are potentially three
situations.

 (1) the user has both the working tree and the control info
     healthy, and they no longer needs it (i.e., "git worktree
     remove")

 (2) the user still has the working tree, but somehow lost the
     control info.  Git does not have a direct way to remove the
     working tree and we expect the user to do "rm -rf" the
     remaining working tree.

 (3) the user somehow has lost the working tree but the control info
     remains, and they want to remove the useless entry from "git
     worktree list".  This is what "git worktree prune" is about.

It would have been nice if we could arrange the situation (2) and
(3) to be impossible to get into, but running "rm -rf" on random
directories is not a privileged operation on most systems, so the
users can easily get into them, especially (3).  It would be very
nice if we can find a better wording than "Prune worktree info" to
explain the 'prune' operation.

I wonder if this would work better.

	`prune`::
		Remove worktree information in `$GIT_DIR/worktrees`
		only, without touching the working tree.  This is
		often needed when the working tree is lost (e.g.,
		the user manually removed it) and the worktree
		information has become dangling.

