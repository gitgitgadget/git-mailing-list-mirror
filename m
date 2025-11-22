Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB274964F
	for <git@vger.kernel.org>; Sat, 22 Nov 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763832992; cv=none; b=T1L6RyEpbdNMZNmQIGPt4mrLeiwjZnzdOV0OVfZatbMQHCdtSNDxOmOtGlyqKGYu6bW3gtYdvQO1e1fTPrFp4WKGHcNzOy7dIpBpVfKwp111fW89EryswW1mU3+2eAJKq1iikz09T5aS2q93DTo7OrOzFaulAFF4UTBoX3vI4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763832992; c=relaxed/simple;
	bh=/K26iCbzofIcgGHn5j2JMdci2qz0Yktf/I+LpHWWuGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QJzwYhHzLcz4Q7CRVU4MK/Wc4O8gPTOd4tsw/XUn9MCcCH3UuiRdjIZBIgAjbW5FWzcUta8XLlJW7nJgzPg0d4g5yphVJ/GPMU5DYeYgiI9i7cFFJ6uiwUjAAgvWGLwysoS/U70g35cUZrsnrNHo0mCLMbvExFEFdVB19K3jzpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XGRARlKK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ONTCPfut; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XGRARlKK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ONTCPfut"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0459D1D00149;
	Sat, 22 Nov 2025 12:36:28 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 22 Nov 2025 12:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1763832988;
	 x=1763919388; bh=XZhlzZkJuByaWcV3IVMAYf54PDEOqltPDbOg5o89TDQ=; b=
	XGRARlKKqV2rcBAtT1IAv/E63ANR5fj1eW3l9mguK9Lo8Aq/Qr5vmL5D2AoQr5c2
	LEa3L6bpZGnAAZnVPkUNd5LUcUNlSOkMByS99PkXQA4kLjTOL1if8r4CF9pRGe77
	bnjzzSp6xLZoImMaf5/e3UzwPUlIJUJwMJQ/h8Ph/1sj3TfSBAksDtsqdfwUIaMu
	T3WvFvvMdkUe4XG+ZFc1BvwBTIGjozAyn6CWKUWqBpGUNPtDAoc2aisy7gYiosQ9
	1HMewo6bUtu0lSxeWiC8flzt0VJuZycC05uwNeCYUWrUI3gL0WJrl3G3+YQimWP6
	8AmnSU6w3VXn+2DgJ3rc5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763832988; x=
	1763919388; bh=XZhlzZkJuByaWcV3IVMAYf54PDEOqltPDbOg5o89TDQ=; b=O
	NTCPfut7KUKyQ9Bz9P5/g57/7SUh1ufhibouNJoygygcNpD+4iwRnFgj493G1eX3
	qUVKAQhVS5fFoBhfMi1tKeU36zVA8PwPu50e5/1b8Uzfvo15ETcTuDEBsq9UqOhg
	2MKbU28lJqUg6FJOpmJx1O+O3nVVRvETTmBi75Ix+jN+O0CbJch2ELiixbcII3jd
	KfnWcHQc3J9tLW6myYCinsCZYq0vVS80CwgLs8Wd8BNnuKWmXEL9z+qeV1f5xsh7
	vWT1aplUvBzwieHHhsCirReSwbvHg61Y6RkmgVhbHvfZCNyKK8OU71dVd+w7xBnu
	VPV8S/ZR+RO3CX0xTsR9w==
X-ME-Sender: <xms:nPQhaaRmY7CnjwrtAoP4FyO36wiheae2m1rbPUEs4RB9L7i-nHeiHA>
    <xme:nPQhaWzM6KKccwuwZAAvbhyc7oKbIJJQLV4my4y4OAc9GrElsNYKEHPORWTGaCpnb
    ryMRLSZsnkdyyYakzJ1jlVGG3XEzQtPhzReGjkupK8CvsE2QdXIjQ>
X-ME-Received: <xmr:nPQhac0fQg7-ZwpwNWD2i7GfFRmJ3ItR-N0mOqXmdzQlZEm_jOBRVw4bK1QuuS0ACVak3rRt_AO1R4yBzG7nmERSLvDK-vqAu7OD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeefgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeggefhudefkeegueeigfejhfejvdejvedtheeguedukefgieelfeeuteej
    ieeuleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghmohgpphhoghgrtghnihhkse
    htqddvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nPQhaU7G1WpPjhRO7bcCcRVpQp-G-y4jIJlihAzgphLMfbhG8YZcAQ>
    <xmx:nPQhafW4WK5SxTU1cPCNhr7Hgt4_URM4ZhehlwhS-6QFkCcSJsqUXQ>
    <xmx:nPQhaTAsZTgxZlbJFZ_1fkZjWniBWo4glJ7O0-8q5DbD5hDYeazLog>
    <xmx:nPQhae4D8syx_K-KRvmgMc1fJ6Q9rrDrHOyWeJT8-dsPM0gaYNt08w>
    <xmx:nPQhaT2bSLgU8r0_Xp_LoE-ZE9YeL1KDJ2ep2dBS9Kh2IZj2xCBzOP3F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Nov 2025 12:36:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Samo_Poga=C4=8Dnik_via_GitGitGadget?= <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Samo =?utf-8?Q?Poga=C4=8Dnik?=
 <samo_pogacnik@t-2.net>
Subject: Re: [PATCH] Fixed --shallow-since generating descendant borders
In-Reply-To: <pull.2107.git.git.1763807914242.gitgitgadget@gmail.com> ("Samo
	=?utf-8?Q?Poga=C4=8Dnik?= via GitGitGadget"'s message of "Sat, 22 Nov 2025
 10:38:34
	+0000")
References: <pull.2107.git.git.1763807914242.gitgitgadget@gmail.com>
Date: Sat, 22 Nov 2025 09:36:26 -0800
Message-ID: <xmqqo6ou2cmd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Samo Pogačnik via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH] Fixed --shallow-since generating descendant borders

A patch title wants maximum information density, and "Fixed" is a
vague verb in that context, as it does not tell what existing
behaviour was wrong or what is the right alternative behaviour.

As "git log --oneline --no-merges" can show, our patches typically
begins with the area the change pertains to plus a colon.  "git log
--oneline shallow.c" (which is the file this patch touches) shows a
handful ones that are prefixed with "shallow:".

What to write after the "<area>:" prefix for this patch, I am not
sure, as the body of the proposed log message does not discuss the
bad effect of the suboptimal or wrong (I cannot even tell which one
from the proposed log message) behaviour.

> From: =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
>
> When shallow cloning based on a date, it happens that a list
> of commits is received, where some of the list border commits
> actually descend one from another. In such cases borders need
> to be expanded by additional parents and excluding the child
> as border.

Missing from the above description are

 - received by whom?

 - the reason why they want such a list is to do what?

 - when there are multiple borders that can be "expanded", and if
   you leave it unexpanded (i.e., the behaviour of the current code)
   what happens and why is it bad?  Is it breaking bad (e.g., clone
   would be aborted, the resulting cloned repository does not pass
   fsck), or is it suboptimal bad (e.g., we told the command that we
   do not want commits older than date X, but we end up having more
   commits)?

 - what is the cost of computing the "expansion", relative to the
   above "badness"?  Fixing a breaking bad behaviour can of course
   afford to spend more cycles than a suboptimal bad behaviour.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to somebody editing the codebase to "make it so",
   instead of saying "This commit does X".

in this order.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2107%2Fspog%2Ffix-shallow-since-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2107/spog/fix-shallow-since-v1
> Pull-Request: https://github.com/git/git/pull/2107
>
>  shallow.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)

We'd want to protect this change from other people accidentally
breaking it in the future, and the best practice we have is to write
a test to observe end-user visible behaviour.  The whole helper
function being touched by the patch came in the 27-patch series
merged at a460ea4a (Merge branch 'nd/shallow-deepen', 2016-10-10),
and it seems to have added to t5500-fetch-pack.sh to cover the
"--shallow-since" feature.  Perhaps this should add a few tests to
demonstrate existing "breakage" (i.e., a "test_expect_success" test
that would fail without the change in the patch to shallow.c we see
below, and would succeed when the patch to shallow.c is applied).

Thanks.
