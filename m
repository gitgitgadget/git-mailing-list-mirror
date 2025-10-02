Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C584501A
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427051; cv=none; b=L8uWVnt/pNVgV/Aeiu6qZhn/+VJiDwWHbumbbxofs7E3cuNhVACy4gGOLcA+Md/07WQ1GefXyDFHGm8kuWlpb2ppxObqtGFc5M/Z9KCh02yV+Smmw57auAGBRaXvTkd97V0RqMobx7MOAgVZk/GeDxNeyUbF5aieXKbwk48ZDio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427051; c=relaxed/simple;
	bh=5gm1IieC+R+UGZEQTckl0T9ZV6e/9/1U5X4Uk6yvoso=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V0oAGc26pNsVcsohw3kk54APIZqv0nvyBfXUHUjN3SDPjT6bYbNcwLL7hFMVBvkYfOHRspHEE3iYWk4L3CSLg4LCq2lUKLcAgTk6st3aPvzK4wvK04eCik3u4OL+NjulYxyT5Wg7FBY7BvkvgAfGoiGFiAuhqzsGVlIvlxT2wWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ecA7V4XP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JCo1e3nN; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ecA7V4XP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JCo1e3nN"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 58DB67A0096;
	Thu,  2 Oct 2025 13:44:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 02 Oct 2025 13:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759427048; x=1759513448; bh=JNurvijAu9
	8SwBuRUHoax57LxAfMkPFQo7a12y6U83c=; b=ecA7V4XPA+vsbQn9zGj6Os4hjr
	cczMia71Fo9/sRB5tPXJiPnpAXbYFIkl34IQFOnZf3JecdlSvRBfh0njHr32Z/h4
	h5/gxFyhadksxpeSxkzINOE7una6m8pnlWmsn7JFtzkF2K/GQQ28lc1tQCNNYF8p
	8o7Sz/iEicQcMTCA2VR6VNKcsbDKgv+MMAcGEwi/ERBqVb/C9b74tH7VthlZurGM
	+A1UkuKFXA7vilp3XCnbgSiNq+5jlCG50F2WkYgAGxnxH6fQZfQYGfNhqAjlvnti
	CKATUZujK4PAWiqWwBj0N4fIDve//hefhbsJmtXK026aUWFjzqVrzL/OxxXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759427048; x=1759513448; bh=JNurvijAu98SwBuRUHoax57LxAfMkPFQo7a
	12y6U83c=; b=JCo1e3nN5VqeMeuaT29wlrKMouQJNCeEYEXZ4gfulNiL/2fd3dj
	qlDHfrgS06WPqhUM2/Zujo5inW0kEre64xwxj1s1ssSB9Dcqp7YGUHK5wOE9QK52
	Zwb5DVejQqlYi+Odbq8G4BGlGmsC8lcJ9J9bDxEgGuBQ6qetowHFon0yOY+VFlq0
	xyHm4mkxDMlnt9/RMjTdvu0TTZR2sBxr7oFySiHD9FlbqdyXkjW6LapIc+9sxlwC
	3R8mWranSly3zvMYmmC4ShMg2abaRbxB45PB/CrtCXRR6MXsK62tZ4pJZA7dUm/W
	l+Ah/v0+BEnn2fpVY+/LuSGr9w6d+n9guRg==
X-ME-Sender: <xms:57neaIUoGKvf4bZgFh-_Eg7p3BwfMCn_UoQIDCNY70zq2vVeM5Hn_w>
    <xme:57neaLq5tcywadcic4TT5wSvAzsv5lIWyL15H6njjSGMfu7j0_jT84baf0AvvI52j
    Ed3NhSwbDCFhuPWnBBn78iJz8ovbkjq3KI2BEiUNdGf46wSK0E_Ig>
X-ME-Received: <xmr:57neaCnuQYUhrqQTfDsYJ3QdZ18Z5qcjgIh-Jh5KnLIlZAJdxJ58OjDSBI3OA-76IjZSIvi4V5TS06_XkyYhI-Qrkzx7mEJwF9PQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhsuh
    gthhgrnhgvkhesshhushgvrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehjrghsohhnud
    dutghhohgtrgesphhrohhtohhnrdhmvgdprhgtphhtthhopehjtghusghitgesjhgtuhgs
    ihgtrdhplhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:57neaD1bwIktAKHioMInm8vO8RR60PhZv0o9_qK7VbVsF2XTZFlRug>
    <xmx:57neaHQ1WqNOzTm1JGw9zn2J7Q6zYs9UlKgb82efouyhiUYhzs12dg>
    <xmx:57neaEz4Flk2pVTMIXsDo--eF8xU4ODLp3gDQT4pKib9sRN7AtD8aQ>
    <xmx:57neaPBQr-KQv5Z3TqWPNsUeLVgi4OSDIwyCH2CRWy9uddjllOD8Eg>
    <xmx:6LneaEtVW7g1tZFAprqz43RdWmQT409TXmg1zgg6VQsoVgEr33_oCbz4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 13:44:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michal Suchanek <msuchanek@suse.de>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Sergey
 Organov <sorganov@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Jason
 Cho <jason11choca@proton.me>,  "Jakub T. Jankiewicz" <jcubic@jcubic.pl>
Subject: Re: [PATCH 1/2] doc: git-worktree: Link to examples
In-Reply-To: <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
	(Michal Suchanek's message of "Thu, 2 Oct 2025 17:51:34 +0200")
References: <xmqqseg1xwc1.fsf@gitster.g>
	<a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
Date: Thu, 02 Oct 2025 10:44:06 -0700
Message-ID: <xmqqo6qpw655.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Michal Suchanek <msuchanek@suse.de> writes:

> Also add advice to put new worktrees outside of existing ones.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  Documentation/git-worktree.adoc | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
> index 389e669ac0..ec31863aec 100644
> --- a/Documentation/git-worktree.adoc
> +++ b/Documentation/git-worktree.adoc
> @@ -79,6 +79,9 @@ with a matching name, treat as equivalent to:
>  $ git worktree add --track -b <branch> <path> <remote>/<branch>
>  ------------
>  +
> +For best results it is advised to specify <path> outside of the repository and
> +existing worktrees - see <<EXAMPLES>>
> ++

I am wondering if we cram more information in "For best results", by
adding the "otherwise...".  Here is my (failed) attempt.

    Use <path> outside of your working tree and existing worktrees
    (see <<EXAMPLES>>); otherwise your new worktree will appear as
    an untracked directory.

I say "failed" as the above phrasing makes it sound as if that
untracked-ness is the only downside, and also by omitting "advised",
it makes it sound as if there is no upside (other than inertia) in
doing so.

So, I'll (atleast tentatively) queue yours as-is.

>  If the branch exists in multiple remotes and one of them is named by
>  the `checkout.defaultRemote` configuration variable, we'll use that
>  one for the purposes of disambiguation, even if the `<branch>` isn't
> @@ -502,8 +505,8 @@ locked "reason\nwhy is locked"
>  ...
>  ------------
>  
> -EXAMPLES
> ---------
> +[[EXAMPLES]]EXAMPLES
> +--------------------

cf. https://lore.kernel.org/git/5044672.31r3eYUQgx@cayenne/

IOW, we probably should write this more like ...

        +[[EXAMPLES]]
         EXAMPLES
         --------

Thanks.
