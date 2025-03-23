Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A88136E
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742758690; cv=none; b=RMOlY0+TPmc+oB0eXZjyp8KSt2iFxKk5/4LiMcVcr0cq/NkBlhc1oTsBqWP41wfMiFI/+6qGK8u4rImpBWoWYx/1O2uyPiqEyd3myEPtSpJNm/kx0zLoIMziWEjqAipcihBDktFazDc8Jo9zZ9AB2nxSjNaBYPwVg4oQSm+cfJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742758690; c=relaxed/simple;
	bh=hFGDMTgIwYqWQigspKvaBkNdiJR3u/TnIgzKZ/pLCDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gnlJPlrgWjFjWFc4lMKp1G52Lz19D7f6e2MxwGsORSVuSna0NWzI9vPauZBxdJZ/+e/JecRvVCnUKNKL48Vwpq1mINHc7CEIngsQ6YxNRZu00Bv+Gnq2x0gqhD343wgt1xnYyzyHAoSGMYZJ3KN7FpiqXGh3erjJvmacIrymjd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oLBoSWM6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VLqzItag; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oLBoSWM6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VLqzItag"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 20AB311400E5;
	Sun, 23 Mar 2025 15:38:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sun, 23 Mar 2025 15:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742758685; x=1742845085; bh=pfGckPC9So
	RugDMQloZUCgEH3dO788G5AZ5qFl70Qqg=; b=oLBoSWM61W0u+UJCh84CJp4S+0
	WZit3J5ojUdVrCxPHle+yrfzsM7Mcr8AxujR53LKDDbBxaW134SOca8viyDdHbKE
	Y0KNBlUa2YQbaG6bHqMVWjCLGxAsxwjf5YcK+pstgxA20S4J4C+PNSh+RzzF35SH
	9rl5wFoSVogVShDX8s77s9FskG2SRgAPViOWo4pwS+9gXjSkPZmYGdw5ciU86NJJ
	N60jebscN/tITYM6ZMwdoirdaa755ame2Ie0puB6xc++se9QlTVYdrq4V6kZ1EmA
	rRxlgTNWVX1gxm5vPut4MHZx3vwWqmkA/oNOVL008jSLIoOPDde67B6LQg8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742758685; x=1742845085; bh=pfGckPC9SoRugDMQloZUCgEH3dO788G5AZ5
	qFl70Qqg=; b=VLqzItagOVqCI5VPio6oFLB1Mgl3S0hg2K9FM0mU6BUJvBZz3Ph
	D/aakhQB+ipMlAk6yDpshoI3aHDHu0sKYQf2wEwXL9LmkSUtX8+mbamHLc/HeTji
	qv4aNYKddpcz0HYUuV+At68HPrehvbJhhw4FGV5ieeOYOTfVuHlSK+nK7BoprAsQ
	aky7cmNYBus9abWbl9vRj9bzImOATWuY1vi3a4hKmijXKKPgfBHpn1TMx3HjM5af
	iOEYfkN7+RgD2Yy2qSLKzdZtoCO6ErbBI9ZEepzPQkLQcSziusmt6qygtuznhlGW
	y/rBmIy/WUPzSRgMmwg3gBSrlulHFArvJzg==
X-ME-Sender: <xms:HWPgZ_1v6sUJQziqZJyqipSAiauKYUjZspUq0Qdmn1w1NVkbgfLKsA>
    <xme:HWPgZ-EYodAw7NeRIsNPsDgdj5q3tD-ItFmMQdhEUa4xxDFxRhv5_hoOvUm23aGnP
    AsTJiY4qz1SDnne8Q>
X-ME-Received: <xmr:HWPgZ_4VvpVaD5Au76SI2M7_IMkDCbJO0EKsSXeGutXKnTMqPCnzvNoMpJEQQYe0I9irr7YPfY_9wVQpY4-KHnbk8diaWSpqIzt_3Fs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheejjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegrlhgrnhesnhhorhgs
    rghuvghrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HWPgZ039vFjQy-qNg79CVJhN_tJpXlsCFa7sxr_kATZyHNOfjOdVYQ>
    <xmx:HWPgZyHMShk6VK_8HMBXADvc7tUzbocgL311gERC7qD1rSo7VV9VLA>
    <xmx:HWPgZ18skUVcJ5aSQjPgO5CVX60nYc9c3FSdAk3V74Ns3dHIiTheGA>
    <xmx:HWPgZ_nP3shetoDX3GUfK8iZhxLL85_az690oioMBQOQhaWrbjsHVQ>
    <xmx:HWPgZ12ddtP0NzAdARTIZoI2kiTQXvEsuPwF7Zav8tGwCECL2EYVDUtX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Mar 2025 15:38:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood123@gmail.com,
  alan@norbauer.com
Subject: Re: [PATCH v2 0/3] clone: suppress unexpected advice message during
 clone
In-Reply-To: <20250321231639.180762-1-jltobler@gmail.com> (Justin Tobler's
	message of "Fri, 21 Mar 2025 18:16:36 -0500")
References: <20250320014646.2899791-1-jltobler@gmail.com>
	<20250321231639.180762-1-jltobler@gmail.com>
Date: Sun, 23 Mar 2025 12:38:03 -0700
Message-ID: <xmqqtt7jr10k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> It has been reported[1] that starting in Git v2.45.0, cloning from a bundle
> results in the default branch name advice message always being displayed
> when it was previously not. It can be reproduced by the following:
>
>         git init bundle-repo &&
>         git -C bundle-repo --allow-empty -m init &&

Presumably this is "commit --allow-empty -m init" in the bundle-repo
repository?

>         git -C bundle-repo bundle create ../repo.bundle --all &&
>         git clone repo.bundle bundle-clone
>
> This issue bisects to 199f44cb2ead (builtin/clone: allow remote helpers
> ...
> This series addresses the issue by adapting `guess_remote_head()` to
> support configuring the underlying `git_default_branch_name()`, which
> has since been renamed to `repo_default_branch_name()`, to be quiet and
> suppress the advice message.

Nicely analyzed and described.

> Changes since V1:
>
>         - Instead of adding an additional boolean to
>           `guess_remote_head()` to suppress the advice message, the
>           function is adapted to accepts flags that accoplish the same
>           thing.
>
>         - Added a test to validate that the advice message is not being
>           printed.
>
>         - While we are here, added another patch to allow the default
>           branch name advice message to be suppressrd by the
>           `--no-advice` option.
>
> Thanks,
> -Justin

>
> [1]: <7EC98E2F-144D-4974-94F6-FC24B443651D@norbauer.com>
>
> Justin Tobler (3):
>   remote: allow `guess_remote_head()` to suppress advice
>   builtin/clone: suppress unexpected default branch advice
>   advice: allow disabling default branch name advice
>
>  advice.c                |  1 +
>  advice.h                |  1 +
>  builtin/clone.c         |  3 ++-
>  builtin/fetch.c         |  2 +-
>  builtin/remote.c        |  2 +-
>  refs.c                  |  3 ++-
>  remote.c                | 10 ++++++----
>  remote.h                | 11 +++++++----
>  t/t0001-init.sh         |  8 ++++++++
>  t/t5607-clone-bundle.sh | 12 ++++++++++++
>  10 files changed, 41 insertions(+), 12 deletions(-)
>
>
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
