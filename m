Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677292550CF
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 19:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988838; cv=none; b=a0cg5DgOzRG4JxVpMgS3mbqe2XATrBQsVpNlOq2rudb820Axu0DeMpIisibule3LLQGdGqhSdB+UxDdaKH0MBDcBJqMQgN4xqrzQ917Mn5TS8x7C2e/bpvWlNvGy/rbXEER3mnhSJzOMGu+CsL5/iXbWanjT8q80rb+uuwPBJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988838; c=relaxed/simple;
	bh=jta7OPTG4ZNa967uE0dBa1lndaCH40zwComTD9Kw068=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iE3gVVMrt3KjM3+WzHGPJW++pjG+lXzbotfkUVsVwyFjPLGTDmwI9Bw3N73ZZW5pg4ARgdvawL1I7D+5T0gogKnXIlfhyYxnqoZaG1s2gVS02F7Dw8WAg31wMjXN5/Q4j3SYdyQep4xdRVrXuXT+aq3MEPZqcuvUThr8zrhzy8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NB+QOhm7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F/lMqsYF; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NB+QOhm7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F/lMqsYF"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 79FB81400265;
	Thu, 31 Jul 2025 15:07:15 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 31 Jul 2025 15:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753988835;
	 x=1754075235; bh=Is9/1l36r0Mgez+PJzpqw4RRc8M8B1mr5dcnDiOUZ0k=; b=
	NB+QOhm7kDYdzqwlrsyVSKGpqSdT5OIsXa9q3du6vB3HSs0hWMvceZDh4wIeT39g
	H4Gr9aQU9rZHLLZJE4zJqLhsxfSENGZVIhLsKLxYH3GMIEW84nrgOfLH/ePKH0CY
	IxZPDg2wd0LW+1zxcC9OFyIFbW0G/LE1MI0Mg21I2ndmnE1UvdzWCJeoEAru5P+h
	wtx7JFAIY9I1WyVZnND3J7wI+5u6NlUBC2kDV1bTgXOD0BQ+quiDWBElJdqDf7GK
	j8nqV2wEzVm04SCVw71DzQRRg0OGI1evckJ1KG1XNGtqhK9beUFafLQikMUnnEus
	6nwY9NVyPswRskLt4DxTyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753988835; x=
	1754075235; bh=Is9/1l36r0Mgez+PJzpqw4RRc8M8B1mr5dcnDiOUZ0k=; b=F
	/lMqsYFTpYPFcth4BUlS+LUSmwZ57uHMfgG0NeLyMTkhTuC1t4oKcOg5Ob0ptF77
	5T9T7nYhaMVUVCoi3MBhXv3pxBRXaGM3f6iF+kJxInC7b/Tfp7+UPe4NLU6BnuJc
	qYnkjOsuJLc+mCCKcxLQZ6RJBFHoaaxsaulM1BzBK23UE6vYjfO67cab8yL20Xsl
	3YNq+5RjKEUkcl/Xf8A6CYTrcyEjy8nOBpkDGxzige3fJXyq1YqMItjBf+fHN+0S
	FhRAfvRJ54PIHiW52IqEPA1IK67kODHq1Nafp+2RqEdYCuGmkCMXpO5ogqgYfis8
	TAwOwQah5jUqXUxdfHoCA==
X-ME-Sender: <xms:476LaC4fwG6us_TmlUrZo2uymG7B5nqQcVeuAlmWNRAywX-bPa7IzA>
    <xme:476LaEX1-66Qrfg90xDSPN0LHab08PBXq3R0Gi5PhvIU1QWcgBscSnjRZlFzgn3n2
    0iOL8zelWtlUECJEg>
X-ME-Received: <xmr:476LaB7cLLVRrobfMGzBb7RuegS0RFXjyynrMOid_o0QBVdgKWQVC2tSkTO_rH4iVzwBt4MUL3xxa1Pu8LZB78gVe-MGEKtNp41ph2E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeggefhudefkeegueeigfejhfejvdejvedtheeguedukefgieelfeeuteej
    ieeuleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvqdhkqdhnuhhtsehhohhtmhgrih
    hlrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:476LaPp7-seNZLBXkinEimnOKNCpEWDTkErrbb8HPbk9bCwq2IAdlA>
    <xmx:476LaEmEsdZROn_uJ5P108_FzajXsoJxWQRkzhiyrZ3wOwih6r3ItQ>
    <xmx:476LaLNfwzU3BV48qq_CoxnqH2K3nVApjQsGKP0zNtJmXccHY5Xoag>
    <xmx:476LaIOV_N12rOy05YI9Wp0yFYTg6-BipZtNfqwo-xBKvc-mIRIXuA>
    <xmx:476LaN_EUA7P4bNXTx9EvShXVjd3ebtg4jCT-y-zC47-I7t1S7GMMEqB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 15:07:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Knut Harald Ryager via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Knut Harald Ryager <e-k-nut@hotmail.com>,
    Josh Steadmon <steadmon@google.com>,
    =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] docs: remove stray bracket from git-clone synopsis
In-Reply-To: <pull.2023.git.git.1753973177262.gitgitgadget@gmail.com> (Knut
	Harald Ryager via GitGitGadget's message of "Thu, 31 Jul 2025 14:46:17
	+0000")
References: <pull.2023.git.git.1753973177262.gitgitgadget@gmail.com>
Date: Thu, 31 Jul 2025 12:07:13 -0700
Message-ID: <xmqqh5ysqivy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Knut Harald Ryager via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: E-K-n <e-k-nut@hotmail.com>

This should be updated to match the name you use on your sign-off
below.

> The git-clone documentation contained an extra ‘]’ after
> `--also-filter-submodules]`.

It is correct to point out that the brackets are not matching, but I
think the one that you are removing a wrong one.

When f05da2b4 (clone, submodule: pass partial clone filters to
submodules, 2022-02-04) added an option --also-filter-submodules to
the command, it wanted to express that the option is only valid when
the "--filter=<filter-spec>" option is also given.  And it did its
update correctly:

-         [--filter=<filter>] [--] <repository>
+         [--filter=<filter> [--also-filter-submodules]] [--] <repository>
 
Later, 76880f05 (doc: git-clone: apply new documentation formatting
guidelines, 2024-03-29) introduced the extra closing bracket after
"--filter=<filter>" to make these two look as if they are unrelated
and independent, i.e.

    [--filter=<filter>] [--also-filter-submodules]]

So, I think the one immediately after "--filter=<filter>" is what
you want to remove, not the one after "--also-filter-submodules".

> This patch removes the duplicate ‘]’ so that the line reads:
>
>     [--also-filter-submodules] [--] <repository>
>
> instead of:
>
>     [--also-filter-submodules]] [--] <repository>

We do not say "this patch does X" in our proposed log message.
Instead, you tell somebody sitting on the keyboard to "Do X".

IOW, something like

    Remove the extra and incorrect closing bracket, so that the line
    reads:

        [--filter=<filter> [--also-filter-submodules]]

    instead of

        [--filter=<filter>] [--also-filter-submodules]]

is how we write this.

> Signed-off-by: Knut Harald Ryager <e-k-nut@hotmail.com>
> ---
>     Remove excess right bracket from git-clone docs
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2023%2FKnutRyager%2Fmaster-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2023/KnutRyager/master-v1
> Pull-Request: https://github.com/git/git/pull/2023
>
>  Documentation/git-clone.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
> index 222d558290e..851502552f2 100644
> --- a/Documentation/git-clone.adoc
> +++ b/Documentation/git-clone.adoc
> @@ -16,7 +16,7 @@ git clone [--template=<template-directory>]
>  	  [--depth <depth>] [--[no-]single-branch] [--[no-]tags]
>  	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
>  	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
> -	  [--filter=<filter-spec>] [--also-filter-submodules]] [--] <repository>
> +	  [--filter=<filter-spec>] [--also-filter-submodules] [--] <repository>
>  	  [<directory>]
>  
>  DESCRIPTION
>
> base-commit: e813a0200a7121b97fec535f0d0b460b0a33356c
