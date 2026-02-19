Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32E32F5A12
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771529665; cv=none; b=G36e2mDHtKd5Z3GcwmputHJ+5FW+LnCSDzlN5UnQ0ftHRe5iu1QUxtZi97kzJ5N5ZaaQlRN9VOxtGP4JUCPNgZS4G+jj9sL9NoTdSgybhMTNp57/CjIMfn2lf1/bVOiXMYJD0cyPTwVFipEf3Em+9IEaM69lfLffc2L0T1o+V/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771529665; c=relaxed/simple;
	bh=z5vpxjxiSIqTfyEPGrK6OeBM4Qdd3b0Tf9qV+RBYBmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g2ZQmP1e6S0JcD493RpqTR8bH6epdRDb5/MdHG1PDkV6pmUOJcByh1i1Wi2rdXWOBRbb/eUxso6wxPgloIv45l4YpVr2uXNuvGK4gk9x+t+ERTgI5d+/qD4lWVCiQr8WrLJloVIQA3mFQn8daJyUvqUsNnn7a5X2G6Vof8VN0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UJNZfqf1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W3meuQAd; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UJNZfqf1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W3meuQAd"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1F8B51400169;
	Thu, 19 Feb 2026 14:34:23 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Thu, 19 Feb 2026 14:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771529663; x=1771616063; bh=oVdmDpemqo
	aP31+9ZVJa6wThpzy+K2b5MTDYomMoOLQ=; b=UJNZfqf1INNxaCjrW9uO2WVJM7
	RImbFfrycj2SbLZKJGtCv+94PEL+wYoGHTUMOplg3tSMAKkbQ71vNN3m4xTNHUbO
	4x13YHvxNkObUHkLhR/e+ZQIIBkB8bTBhaQQJjU6CipCMY9oLEf9zm7omNFW3ZK3
	UWamtHAbAsxY/7JxFsJr9CbxZETbb38WouNBlQvSez9JYf9NUCqdMrN6RvjPB34w
	yfGl+YV3/1X+6zUsisIzpeYywy2wo0XgwobEPMRiGt0JSwyLfxylxJfZc4wFYVdh
	KEUEiRmVcbBD0Rk/Y9y4tO8FbgCItJdGrRwPy6AnJ5REC4C28iJCbmk5JJqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771529663; x=1771616063; bh=oVdmDpemqoaP31+9ZVJa6wThpzy+K2b5MTD
	YomMoOLQ=; b=W3meuQAdlo0IzJ1l7Fa56QDe3JaptZn5S6psvxEYnto4Y4apFVd
	pYp/bDcVCN26N5Y53oZye+bcdYWLVw6U4e1pXwggRA/rkg3fV0sayGR0QiLgdGQg
	uwiT/dg0ldDFsIfu2WuNceSu1O/hcRNSSDyp8CZbvvaZ4QYe4m8d5npycgKEcUV0
	raGuVcjt+kOvGoWFv9fQcX6Rj2fyy0NiQO/pEVhmc7Ti77p77qK+OY97IbQ6hOoW
	t02ZErohDpa3YTv6UrqFqSUOuC/2glmpyCmixnal2S9SBMPJjl2Mqpwlg9aTIniQ
	JoVCZIt39F3xjNejh7jpkR8JC/TXKjaa4gg==
X-ME-Sender: <xms:v2WXaYvHXrE52BVqo7JVgO_NUB2LOg10-SVtE7g-N1acVkU147u_CA>
    <xme:v2WXaZIZNyLDnLbBrQpfltM-bilg5iRtu2fZV1Qrg7CvZKQSzIp8ydqNfGa1OX2MR
    wEyxFd10bt1EUlJHVVVupyT9KilsTpvqjIZsWEP1fRpWXLG68Kyzw>
X-ME-Received: <xmr:v2WXadlpyomNZ_DqPAedVhsZu5NuvIao7aRCC4r63vfnRsso769MgSvO8vY6lYbS_J71XH1TOlgs6Ocs2kFPI-_KfiXEauIQPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeifeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepshhhrhgvhigrnhhshhhprghlihifrghltghmshhmnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:v2WXaSJ3QSwaa-06WKWV_IOC3u4nrZpHgjabyTKT7BzQV_KU_XynDA>
    <xmx:v2WXaa4Utl5CE3jSgPwuh5YjXcPv3D7nqzLK5hOcpVO98cmTahw5_A>
    <xmx:v2WXae1As23YKhzj4-gQO_DWZr6pFv8-YhE8xWu6P_jjyD6qL6DMdQ>
    <xmx:v2WXaYcJLDBtv-i0XiJyjMnjywoHR-5q28aMh6VgMoftLjvPOMQgww>
    <xmx:v2WXaXbfacWjvwEiDovSNYEC9ha7qdrq8JqRy6KWER2TTtGqfIhbQZ4f>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 14:34:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Shreyansh Paliwal
 <shreyanshpaliwalcmsmn@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 2/2] path: remove repository argument from
 worktree_git_path()
In-Reply-To: <db9d519cbda44c46986e127e820b5b7b0ba31206.1771511192.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 19 Feb 2026 14:26:33 +0000")
References: <cover.1771258688.git.phillip.wood@dunelm.org.uk>
	<cover.1771511192.git.phillip.wood@dunelm.org.uk>
	<db9d519cbda44c46986e127e820b5b7b0ba31206.1771511192.git.phillip.wood@dunelm.org.uk>
Date: Thu, 19 Feb 2026 11:34:21 -0800
Message-ID: <xmqqqzqg4jeq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> worktree_git_path() takes a struct repository and a struct worktree
> which also contains a struct repository. The repository argument
> was added by a973f60dc7c (path: stop relying on `the_repository` in
> `worktree_git_path()`, 2024-08-13) and exists because the worktree
> argument is optional. Having two ways of passing a repository is
> a potential foot-gun as if the the worktree argument is present the
> repository argument must match the worktree's repository member. Since
> the last commit there are no callers that pass a NULL worktree so lets
> remove the repository argument. This removes the potential confusion
> and lets us delete a number of uses of "the_repository".
>
> worktree_git_path() has the following callers:
>
>  - builtin/worktree.c:validate_no_submodules() which is called from
>    check_clean_worktree() and move_worktree(), both of which supply
>    a non-NULL worktree.
>
>  - builtin/fsck.c:cmd_fsck() which loops over all worktrees.
>
>  - revision.c:add_index_objects_to_pending() which loops over all
>    worktrees.
>
>  - worktree.c:worktree_lock_reason() which dereferences wt before
>    calling worktree_git_path().
>
>  - wt-status.c:wt_status_check_bisect() and wt_status_check_rebase()
>    which are always called with a non-NULL worktree after the last
>    commit.
>
>  - wt-status.c:git_branch() which is only called by
>    wt_status_check_bisect() and wt_status_check_rebase().
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/fsck.c     |  2 +-
>  builtin/worktree.c |  4 ++--
>  path.c             |  9 ++++-----
>  path.h             |  8 +++-----
>  revision.c         |  2 +-
>  worktree.c         |  2 +-
>  wt-status.c        | 14 +++++++-------
>  7 files changed, 19 insertions(+), 22 deletions(-)

Thank you for working on this clean-up.  Very well reasoned.
