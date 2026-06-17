Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98A33ADB2
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781723710; cv=none; b=KgojVMY4SW2Gl6Mut2O/GArKHcnIkdQAyASWlmvs8HNnQKaebW5KQMNhhK7+X4p+s6q0BkgqQdX/C3W4iR/SPG8IFS/z3pyEwpr/GuELbQ7N+zeIM+JTRA43AljPg+CKUuGPZKi5YD0tS5hpI5i98YUwwih+dgMyGYtWdZzNIgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781723710; c=relaxed/simple;
	bh=pl2GORRAm7GAjYWWW4jzXQPoRBjPGMH6BjnQrgALmlI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MAUrEynqQd+p1IQWfe2acBNvPBTL1YLoyL3hH8f0YIq+lo3ODkSAwCuh0P9rme3KkMYLyqT/xs3iAElu0Pm0lgqu4Oe6G6mVmJ4gXnquX3PwOgREgLwaZq+J886kjGrJ21DkXJ8qF9dUpr7AFw3eLePXuE0yNVrg8N52bRkApCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KqvFQA56; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hiH0OkWX; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KqvFQA56";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hiH0OkWX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C82F7A0159;
	Wed, 17 Jun 2026 15:15:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 17 Jun 2026 15:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781723706; x=1781810106; bh=wrxYBHqU6N
	s1t+w9de3sRQkbG6QZ5sINyVpaGfr3NV4=; b=KqvFQA56wOsTuxvIzU/DYoqv44
	Wd1P6jEIxI9awRCleUA3YmXOhjP61itEGLUGYBVrzdRc4zdjWQ6ogALQZbWvR60m
	h1qgjjLXuhvmBGgIMqj9E9cADE946r0zmWs+FMpSX+biElG/JtQ59fUiD0pU2TaF
	6TEfViSFEtvxUrx7srfahBK4REpw62P9pS1MlCb/f21VuometiRFdaz4WEAeDLyK
	TqyEaQVvpEtzCcWoQJoJTbOYAi6RsVZJcfuSHAhCxA684/fC9BMvtewADcPVCoNH
	XtzuH4uilqGHfO6jZb80Z510y5pPttISAKeOd1YpRirqXntoa6dyYGxxSU/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781723706; x=1781810106; bh=wrxYBHqU6Ns1t+w9de3sRQkbG6QZ5sINyVp
	aGfr3NV4=; b=hiH0OkWXY3AbBeNjrOPuDeIl/jwbfNfmzthzS/shlJDE0v0ZzPK
	7AKxJf+fIlIcXrzmk1/JDsyTgTt84rSQqvgwk+7wmHFjOuRl6IzyQpP+H84JWwZl
	vTKlk9nKj+s0bWPOAtRmzlyVAE60/ymykXn0/CkDe8k+duSM9FOy7Tf5M+azk046
	NB+cVItjF8BNWQUCnazx7Ucr4etlf+vE8H8bsz6oniQxiA3ZHB9TbnqLB27Cob1E
	vi/AK78GNUOuqMVfm/TowYa4K5aaopuvyZdCW7HxBOF38P3UXfeluEwXR3BfLweX
	lttoLx4BgZPRiJ6AazHJbL9079nJqmacj6A==
X-ME-Sender: <xms:OfIyauSuQBLr8m8es1QHnyfjywfnfRX_BWjzpGSFq8aXusU7a-thNg>
    <xme:OfIyaosEaOKrYZdXMKzGGPi00IR_8z7Y8LWZcTN9rGyBoiI8Jvap5saHrgthoXmyc
    5AlUU4pcBcn20t9vz3e4W_2OMA_riYyr0n62xf-utNlisoOwaZX9w>
X-ME-Received: <xmr:OfIyagEBAxZC6NwgAp2__gj68lckY76slnjrgc9k0RcprO0PqsNy3TLO_G0RZ5ooOoUj2L41tRbWiE-8W9Scsq-UoOSZc8qBPTj1>
X-ME-Proxy-Cause: dmFkZTGBWp29+vrLWYxboR1moS1B5ejrH6PELAQBZnno/+suzeXPtqQOdE3VPlaFjcNpSl
    DFf7Vh3fYPNxTz6WJFxFwRfdqAqTvCpMjmRoN7iutM9Ci3uWUztGQkwxLyC3RlNW8+XHSJ
    /0hRr1dxXFQa9Itn4YqZ2V0kC33cSsM1wEThYtNL5xzj/9CoqIsWof2jaLe2tFkE24qvoC
    0PNnzuWogRr3cOcnnqBtZMkBNmZekNbqD58NPPIv61Ngej9/wTXcD9qezw63IluZrWo3hg
    PymnXIIyWKJxjTvytr0jK/F8EaXxuwReoFWk1J1sYi1V3QhD2LYcUm4iDQydAs/S2/Qekf
    K4/JSrLTKc10DfV6ymNwu6vYiEr0AoFaRO3xafsm4WT7uWcKeB//NaWaoWYTbfBKjrnFjX
    4lytAhc3J4pZ0fPELqDtIOn5hK2lB2Ysyh7ypneoDYi2w/t2A3FJUwjYk4zSb5y4OIQUjc
    X/jKg0cTzBh4FVlvTekUmQrvPBrPVtNAWvbwbU2Tl53HqlAhOI0VII5lz2H6X5Rc0zESFP
    GBatTA1scVyyqONGeomeiXcVV5kX5dvPEIy8+Zu9DVvGHyQsOAAlxIRpi72WIFJtfz2aKx
    oR4oCcHgXpuunQRUJQvBMwoo/z/kXeoml6ABXFvup7rjDS3BHITzFCgNjJzQ
X-ME-Proxy: <xmx:OfIyapwJvO6nPCcE0FrEh6x05iosEYzUjm-Hjbll1PoJSekhcSa5-w>
    <xmx:OfIyaq07iYPrTEvaEtMmknJ3v1Qo56EjdTnCFW_gaWwJw6PO37PGhQ>
    <xmx:OfIyapq9U86-z9ZfZJchbDKJ69bFqGeYsOvym9ycIGmfBL7NGUSFTA>
    <xmx:OfIyanVPnt8TNdYVi2Ha5tq37pXzYM_87-8wlqAWjASvjMrMFXBHUg>
    <xmx:OvIyat4tBA3dSgQytkXa5rqi_M6uPKZ22fXw4qAtNG9axm6n5_gBUWdf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 15:15:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>,  "D.
 Ben Knoble" <ben.knoble@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Marc Branchaud <marcnarc@gmail.com>,
  Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v13 0/2] checkout: --track=fetch
In-Reply-To: <pull.2281.v13.git.git.1779565714.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sat, 23 May 2026 19:48:32
	+0000")
References: <pull.2281.v12.git.git.1779358803652.gitgitgadget@gmail.com>
	<pull.2281.v13.git.git.1779565714.gitgitgadget@gmail.com>
Date: Wed, 17 Jun 2026 12:15:00 -0700
Message-ID: <xmqqmrwtuggb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * Create a preparatory commit that exposes find_tracking_remote_for_ref()
>    and advise_ambiguous_fetch_refspec() from branch.c, so checkout can reuse
>    the same lookup git branch --track uses.
>  * Use advise_ambiguous_fetch_refspec() for the "multiple remotes match"
>    case, so the wording matches git branch --track.
>
> Harald Nordgren (2):
>   branch: expose helpers for finding the remote owning a tracking ref
>   checkout: extend --track with a "fetch" mode to refresh start-point
>
>  Documentation/git-checkout.adoc |  17 +-
>  Documentation/git-switch.adoc   |   5 +-
>  branch.c                        |  96 ++++++-----
>  branch.h                        |  16 ++
>  builtin/checkout.c              | 139 +++++++++++++++-
>  t/t7201-co.sh                   | 276 ++++++++++++++++++++++++++++++++
>  6 files changed, 498 insertions(+), 51 deletions(-)

I was scanning "What's cooking" and this topic was the oldest one
among the ones marked as "Needs review".  Nobody seems to have
commented on this iteration.

I am still not convinced that it is a good idea to allow "checkout"
to go to the network and muck with remote-tracking branches.  The
remote-tracking branches are meant to give us solid reference
points, and such an on-demand update to move them (which by itself
is not bad) and then use the updated result without first seeing
what it contains (which is the part I disagree with) cannot lead us
to a good place. I suspect that the feature encourages a bad
workflow to our end-users.

Having said all that, the changes since v12, in response to earlier
review comments to avoid duplicating the remote lookup and ambiguity
advice logic, look well executed in this round.  This also ensures
consistent error messages and behavior between 'git branch --track'
and 'git checkout --track=fetch'.

IOW, I find the mechanical implementation fairly solid.  I am not
sure if we are implementing a good thing, though.

One small thing about [1/2];

diff --git a/branch.h b/branch.h
index 3dc6e2a0ff..0aafa1673f 100644
--- a/branch.h
+++ b/branch.h
@@ -1,9 +1,25 @@
 #ifndef BRANCH_H
 #define BRANCH_H
 
+#include "refspec.h"
+#include "string-list.h"
+
 struct repository;
 struct strbuf;
 
+struct tracking {
+	struct refspec_item spec;
+	struct string_list *srcs;
+	const char *remote;
+	int matches;
+};
+
+void find_tracking_remote_for_ref(struct tracking *tracking,
+				  struct string_list *ambiguous_remotes);
+
+void advise_ambiguous_fetch_refspec(const char *dst,
+				    const struct string_list *ambiguous_remotes);
+

As we are not embedding any "string_list" instance into any of our
struct (we only have a pointer to a struct), unlike the way we embed
"struct refspec_item" that requires us to include "refspec.h", we do
not need to include "string-list.h".  Instead, we only need to
declare "struct string_list", just like we declare repository and
strbuf.

diff --git i/branch.h w/branch.h
index 0aafa1673f..c2e6725491 100644
--- i/branch.h
+++ w/branch.h
@@ -2,8 +2,8 @@
 #define BRANCH_H
 
 #include "refspec.h"
-#include "string-list.h"
 
+struct string_list;
 struct repository;
 struct strbuf;
 
