Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7976931771E
	for <git@vger.kernel.org>; Fri,  7 Nov 2025 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531040; cv=none; b=PK6xkeyNwVY1JS1ubeGYnSC3bPNASjSrDsWTvHEmt2F8XD+jG8XdXcahD/7556s9lmb1lKQILVYNBNK2bU0TWFLppqXhJqR/8il5iVSkqr9OqcR8aF5wSOHwx5yJKHQoKL8YNBeRzQmIK9Ycqraqw93zh5RdOcA3qrUE4dxveKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531040; c=relaxed/simple;
	bh=xH/P4SYJMqMrM5J5fYLYUyp2tqEnP/Wp4xXxkgudhTs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FSClsV4+l2SjhfIBOFdHN/mWCB404FEJ62idPgoqaPy7lAuBLp1YavMcqYptD/Aco/KbWdSI+f4OjNiKwmstnvUYkYnOdVadfqS/WQ73CAbZVkKPBvrNYNmaXR/EIjJFhxaq23djiJcl0FYaLgMkzhS9gTJ3QkHLIeLfScRwoOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ckAxMUYt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vq470c57; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ckAxMUYt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vq470c57"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A15281D00039;
	Fri,  7 Nov 2025 10:57:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 07 Nov 2025 10:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762531037; x=1762617437; bh=I7WbG8HVle
	8oMhNIl6lgswpdI7EWwEAOLzlXvpe7Gto=; b=ckAxMUYtMV9lI9G2VDZubj76A5
	AvtBcyFiST0RJkEdwDF5uN/13HVMbDQM7bnOHxMeJsFDq9FdKS7erNU6CnM4Y4O0
	LQvXfS0e7GnqaKilAOKgDGwvGjrsSqWP1GEOA2W/ESGwe8y5wqzcN/NIWMOBrjXc
	GLR6ki+DlVTDnsqI7Oxbk9DFgvrsj5oR5ieE6P2GNLmftbpsdcpijY90o7vCcWvS
	4RAfE4u+mq92WMAXUmlthGF2VYOuGKxwJyQLt712qiua2k7pd/b54lIge/OhKZqW
	VSxOB/3AtgvG8GrWEDUXI9/ChGlx5Nnvnnq0I8isg7Ba3NDn+Y4E1CwThwaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762531037; x=1762617437; bh=I7WbG8HVle8oMhNIl6lgswpdI7EWwEAOLzl
	Xvpe7Gto=; b=Vq470c57O/XCjHxJ+xPt1Q2WWT6iy0JTIjcmMk4/rfR5P84MGVj
	uonO9uTbXq2uG5RqAZz5ARz+4lLVfS1s+61dMt4hKCpQ/UkeHfpcivWEQpVIyxho
	AJsLZiUD9e1Q1RDrlwuxU4F0qzriXiPGsY9Ht0ogPBru8L+KWP6seGTjSHLR14hE
	kqPNfiuHN4oXlBWlmiRwsxay0L4F+s1v/3seND/3MKWOIQNUZ/DreLWSPWr0uPIp
	spG03CBqvzxStCH3cP/7HC8EOuodQaNcIhPTRr6tAGRbbQB0v+BBSdgUrvkq8kJJ
	O1yjnKiAN2buFMdKHKnyFkD24xX8Phgq+OQ==
X-ME-Sender: <xms:3BYOaevK3-dFcJ23bbY6q8mOQ0vSk8sjnJa3dXlv6cnHWvYAuSOo5g>
    <xme:3BYOab7i_-2zgopwSZs5mYCniT1O65iE5Dxd1JnH6Ec1aG6h1pteDl0Fr9sNus-1W
    LZiU6t2TwbdLE4FfvMCHTZHlwX7ZDi1y07cMwgfU6aw9rGMtFx2Qg>
X-ME-Received: <xmr:3BYOaaOuv-pN70G0g8FglCVdNPBPNn1g-bmS5YW7yrGUeWqfl8H8JdPay7Z9wG9ubb2CI52tAqSor9M51wyZci1f9XbnIR_4brrl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduledttdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopegrnhhtohhnihhnseguvghlphgvuhgthhdrvghupdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3BYOaZucPelhMPWdxRICi9CVqPzE9DRtYq5Ms2cdVJdR-BtGhYRR1g>
    <xmx:3RYOadYOAwIAfLYtMtbnndJBSG1qi5a8U5k_r7U5Y291_OpfbcWhwA>
    <xmx:3RYOabwL8umf-f2naVwQyYrcUOD3iGgMOz83Qw2twXxSnaJUlLq-Bg>
    <xmx:3RYOaVjrt-pVc0jphcpixq0YThC7aQoQ9eHzoXju4tSvtZHX4YDhdw>
    <xmx:3RYOaaxEgqrbXamAXOcMql7E4xLtY-t8xWh5cijR2kuz6ldhQY_T0riG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Nov 2025 10:57:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Antonin Delpeuch <antonin@delpeuch.eu>
Subject: Re: [PATCH v5 2/2] blame: make diff algorithm configurable
In-Reply-To: <60015bbadaf90f40b3b56d2e32b9f48818cb8675.1762468914.git.gitgitgadget@gmail.com>
	(Antonin Delpeuch via GitGitGadget's message of "Thu, 06 Nov 2025
	22:41:54 +0000")
References: <pull.2075.v4.git.git.1762034252.gitgitgadget@gmail.com>
	<pull.2075.v5.git.git.1762468914.gitgitgadget@gmail.com>
	<60015bbadaf90f40b3b56d2e32b9f48818cb8675.1762468914.git.gitgitgadget@gmail.com>
Date: Fri, 07 Nov 2025 07:57:15 -0800
Message-ID: <xmqqbjldhm3o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Antonin Delpeuch via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Antonin Delpeuch <antonin@delpeuch.eu>
>
> The diff algorithm used in 'git-blame(1)' is set to 'myers',
> without the possibility to change it aside from the `--minimal` option.
>
> There has been long-standing interest in changing the default diff
> algorithm to "histogram", and Git 3.0 was floated as a possible occasion
> for taking some steps towards that:
>
> https://lore.kernel.org/git/xmqqed873vgn.fsf@gitster.g/
>
> As a preparation for this move, it is worth making sure that the diff
> algorithm is configurable where useful.
>
> Make it configurable in the `git-blame(1)` command by introducing the
> `--diff-algorithm` option and make honor the `diff.algorithm` config
> variable. Keep Myers diff as the default.
>
> Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
> ---

This step does not have anything surprising in it, knowing what the
previous iteration contained.  Looking good.

Other than that many redirections into a file are written with a
space between redirection operator and its target, i.e.

    command > output &&

that should be, according to the coding guidelines, written like

    command >output &&

that is.

> +test_expect_success 'blame respects the order of diff options' '
> +	cat >expected <<-\EOF &&
> +...
> +	EOF
> +
> +	git blame file.txt --minimal --diff-algorithm myers > output &&
> +	sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" output > actual &&
> +	test_cmp expected actual
> +'

Thanks.
