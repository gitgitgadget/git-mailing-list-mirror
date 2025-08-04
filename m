Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB81B532F
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754270992; cv=none; b=aZKfzWykdMLtdfvZdJjEj6JW1Mde9IjWIjLrudKnrc7P9sJiUSdqi83wYX38OVhQzVl+7Blv6i2LlacnboGhdAlzbX0/PLNq9xdISyDOS5ZaKlWKe871aGf8OkOkk4oJylSKG9tAuto4B3viqNzXje0qZuYDrXvp22JDD8maZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754270992; c=relaxed/simple;
	bh=iLjDKPIMmslPv4n4VaDr5urDw66ABpeoRcXQQRhYCb8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J+QqMN78yeHXnPmHiJuz9rIFoqQGpJZv0qk5hThUd/uHKfTDVY9V5TipZKUsMruHNbLdfOB20As0nZnMWVr/ZCSBSqAgr49xsSAWaQEdk/f1gtz0S/ka5Jfg4tqGEgcIlIjw7FpnczEAyU3OtO41s98SQoEpeLVsLdPkhEN/QAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hQX6jLJ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cKSfpRnM; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hQX6jLJ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cKSfpRnM"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E1D151D000A8;
	Sun,  3 Aug 2025 21:29:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 03 Aug 2025 21:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754270988;
	 x=1754357388; bh=VbHlL07Iv0q47GeGsk34c0G6V6X1VrpeadE+KGPyFBg=; b=
	hQX6jLJ0wBi2mfG+Ibdq7y93WCENHX2kpgcX+yd6aIyOkGkDu7z0LmCvfTUkYRNE
	PwZHGJnxS5+Y2G47qPl4Phchb0BXp17/J6Lk5ndtUmUmbdw/GsbD6emALcgQtbOX
	y/DGIWEX6lqxNd3hi1WuZEuc1N9wlSpZDOSmh+kAO7MGv/+Y682HJbnjyAgNwrgo
	XOY3eTMAGZYE9sgGO3yM9vMYo8xo2LkPVCn24yGbUvAiNyPHQcZJmLyX2LJoeTy5
	bWF6OJDONGmcbPENXqMJtat42rPtXEXgDNlqlcPHwrSQk+iDDoB7bZph2BLbbYfe
	2EhLBhDJzRgT5z9SCpXMJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754270988; x=
	1754357388; bh=VbHlL07Iv0q47GeGsk34c0G6V6X1VrpeadE+KGPyFBg=; b=c
	KSfpRnMqg6yYT5FvC6PLvFH+H2O8XrFG2lU5v9ZShY7bG/6E2Cyn4y7g++X/yceI
	pVr8Q4wYFewViuwpT6qRISiEzcAA7TgCNb8Dxx7phukj+lLhF5j3AJGCUhmkNwSr
	tkcR9A5guz54rxIAx/zboRAvS24OozY70f7TCX5l0+MIo8t0TyFhZhhSNiD+yoLf
	Xrds6PJiWBDcJ2gm99dmpg8YwPDJCYKYtV6H3i7Bx+QiNG9D5Gfo79Qq0E8GSwng
	pJGRFWzhYnTzXIN1wMvDRQyMMwmHIdlLyL7gZb18h/oU5TCrQIwb3KiplbZ6wOLh
	k1jhjDxjKBXW9Ll+FPyUg==
X-ME-Sender: <xms:DA2QaAqPnvKJ_7z4tTJ-5AbZ9DOAdvFuMye1CwsHG6zZeJv3iazcVw>
    <xme:DA2QaBPxJ7kCkNUX9aFrYcCmXN0TjXidkOb7Es17AlbHLYI-pNYzfJiec6fIxBxtv
    y4y3O1R6k8gNORelw>
X-ME-Received: <xmr:DA2QaBzFPEk9NWr01dHUcnzUMV8cHTDWsS3MVE7SZp8eV7AIoCaO-L6s2YVd5MZ-M5p1-ONm8KDy4p7mD9cRpaO1ohMRA7QFg72YSh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddutddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtveeileekveevgffhueehudetjeeiiedtleffhfeufeettdelkeejhfek
    vdefkeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinh
    guvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:DA2QaKtKCHN3fDTqqb1mKwnnyqEeJKsJIkJTmgehUdSffhqAcv97rw>
    <xmx:DA2QaK6619s2KNzrtj-emDMx6F-hWhFSGnIDM0FqiPt5rrVSy71G1A>
    <xmx:DA2QaJTj5fDoWeRUoI5yucys1N_u9pqiKkYnhr-5eqs48zguh7lXzw>
    <xmx:DA2QaJrE9VsGUYvk_XwF4j-C3Fm6U6Wa6do1Mt2ag_7VF_v5R_M0EQ>
    <xmx:DA2QaNG676nc8NZ6ski8yfknhlhol3UIF9q2IX-H-h5guqHncWgRulPT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 21:29:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/4] mingw: rename and open fixes
In-Reply-To: <pull.1948.git.1754256318.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Sun, 03 Aug 2025 21:25:14
	+0000")
References: <pull.1948.git.1754256318.gitgitgadget@gmail.com>
Date: Sun, 03 Aug 2025 18:29:47 -0700
Message-ID: <xmqqbjoveuwk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The recent change of mingw_rename() to use POSIX semantics had quite a bit
> of fall-out, breaking in pre-Windows 11 setups that use ReFS, and in a
> different way on Windows Server 2016.
>
> While at it, this patch series also upstreams two related patches that
> matured in Git for Windows for long enough already.

Thanks.  What a great timing, just before the -rc0 preview release
;-)

Will apply directly to 'master'.




> Johannes Schindelin (3):
>   mingw: drop Windows 7-specific work-around
>   mingw_rename: support ReFS on Windows 2022
>   mingw: support Windows Server 2016 again
>
> Matthias Aßhauer (1):
>   mingw_open_existing: handle directories better
>
>  Documentation/config/core.adoc |  6 ---
>  compat/mingw.c                 | 93 +++++++++-------------------------
>  2 files changed, 23 insertions(+), 76 deletions(-)
>
>
> base-commit: 866e6a391f466baeeb98bc585845ea638322c04b
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1948%2Fdscho%2Fmingw-rename-and-open-fixes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1948/dscho/mingw-rename-and-open-fixes-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1948
