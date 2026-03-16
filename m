Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E51632C8
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681416; cv=none; b=qear3EJMgGAZ1JUS7LkosCu5fnlbqq7pkYkEeXJ81r0USKTFAjJOPY781Bb7CIa0CS4D5eqgcpBIZ6ykAdM6/MjS05Y5n14cywrscvUGIhr9axfDRnxg5N+qPTmF/Th2lj6Q/+newVX8ZpL5UQXysmUo3ZDqbGH3hrX8vYtZjm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681416; c=relaxed/simple;
	bh=hOe3gCyXkzQluB+0jqtG6HIS8KIitmcLbkncRCkk96Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oZRFLixT+FKKTk5/Z8iiQASKkjwJ4CjQhmcy97RvUTzFIzP2bVoQMLfe/CDzqeHCA7EXAUjD9PPdqnDNBnGwLNf6BiDyeTLKjxJYLTMiP8rt1zBkHxoKYIafwZletJ6X/z/E4KXLDfmEjRUceiG0OMWtJOguP1nmW0e57tJy3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lOGin89q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=13xTLIhW; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lOGin89q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="13xTLIhW"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EDAA91400219;
	Mon, 16 Mar 2026 13:16:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 16 Mar 2026 13:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773681414; x=1773767814; bh=BhfD1hytne
	JrmM672xWzmJzfuHrSvVF/zsXYc7orXQA=; b=lOGin89q1qeCW4EuK4hRPHyFqY
	UkcnUTY+5TJzjLey7kQIpBZ2CJ3iniMrgB+i22qPvUky1dqJPRbnwJa6e2VkjmK4
	4xjX3jgKJ1yDpTFgaZeHmU4qdhr58d1rE5PQjboo/HBa8tfmyHHZ1V+5Hx2s3jPL
	U/eve8Ie9WaaY5nVS8S9eYlwX0ic8R89B3/ER99v/2lbgQWOblOgO0K6TItrTVtm
	yGnJmwJnPDfzmnLOpwZ6U6VI4Knw/3aZXxOW7fRpSIiQ9fbwF+7owPAdWwqaXb6Y
	OxSYSg2Kq1G1drkHI00FNpCfBRsaX7OR0ZkwyW70UYYrlXUx2jhKNNNDjmZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773681414; x=1773767814; bh=BhfD1hytneJrmM672xWzmJzfuHrSvVF/zsX
	Yc7orXQA=; b=13xTLIhWPFVAwrVaswZ0q5ECptvflQBcHVMACoaUkf6a/RNJLhH
	2tZg5bU8YAS3A8xIcctN8TyOTUYbf4JnyTgHw0skyf5IrhUrpYxEavMldj4QNCuJ
	cEKmO2/w5lbnlbFjOTU9JxWfiKtM+P0S1/e2pfDeuVwV5zqX/pKVxOD5QPwHW6dC
	yQy8r5OK83P4P3c0eJ8Nyzd4UZ1SfWF5Rqknh9dgVlgTiryU2GTYdLwAdFAPeJBM
	Ka/TluWPpVjdZZGm1DAC2oLi8uVc9DTEgq+JVdS0OkXq4pwgp+9afw+8QiAMg1nn
	OlpSGks0EaEiCCjYqiPtOATESGhW4klxW5w==
X-ME-Sender: <xms:Bju4aTeBvASYsUNTIoO2aU_eP8AU-vlubPoafkRbFxDMGSc1Vq6lRQ>
    <xme:Bju4aQMvPZSgj1HE4kcfgJHc9q3tszDLCvowkWcEB9sinbSjhUh6hY1be1dwm_au6
    D-hlGzIYcw0oWxxakbdIb-2PBOWZJ9u0FQkv51cAd_dtKY3nWSf>
X-ME-Received: <xmr:Bju4aRjE93SKypsx7LL-sqcSO4gtiKZXZVTgTN6BSxu9ELtXHVdF6i9VDJFG63J_qINkiDZsg34SEe5ubCHoHBKg5QbsRom4BQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhuihhllhgruhhmvgesrggsshholh
    huthdqshgvnhhsihhnghdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:Bju4aT0c7Na1Qwo-HE3L6IiB2JcjvlGsa_NDGQ6YvOFiaiyoZ2-Wsg>
    <xmx:Bju4abgJZD90sGIS-tsUhowPHYlYdcsXiwRUMpGeXFYuFhRQcWF0NA>
    <xmx:Bju4aTfBibK6FyMcvo46tbT68ReRjiYDExf3YwQEuqiQykMu7fhdTg>
    <xmx:Bju4aenB3SBYPqqG9Pl0kHnKqU6io53sWOphidTa5rnqFHt49qXfvA>
    <xmx:Bju4adNw7p-1Dq95ra8wVLQmDVAzBfiVbe6CT8dleW_HciA7kCHH0lUH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 13:16:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Guillaume Jacob via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Guillaume Jacob <guillaume@absolut-sensing.com>
Subject: Re: [PATCH] doc: fix git grep args order in Quick Reference
In-Reply-To: <pull.2069.git.1773670536808.gitgitgadget@gmail.com> (Guillaume
	Jacob via GitGitGadget's message of "Mon, 16 Mar 2026 14:15:36 +0000")
References: <pull.2069.git.1773670536808.gitgitgadget@gmail.com>
Date: Mon, 16 Mar 2026 10:16:52 -0700
Message-ID: <xmqqikavpud7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Guillaume Jacob via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Guillaume Jacob <guillaume@absolut-sensing.com>
>
> The example provided has its arguments in the wrong order. The revision
> should follow the pattern, and not the other way around.

Well written.  The patch title also comforms our convention.

>
> Signed-off-by: Guillaume Jacob <guillaume@absolut-sensing.com>
> ---

Signed off correctly with the same identity as in-body From: line.
The patch contents also is reasonable.

Will queue.  Thanks.


>     doc: fix git grep args order in Quick Reference
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2069%2Fguillaume-jcb%2Fdoc-fix-args-order-in-quick-ref-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2069/guillaume-jcb/doc-fix-args-order-in-quick-ref-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2069
>
>  Documentation/user-manual.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/user-manual.adoc b/Documentation/user-manual.adoc
> index 7696987117..64009baf37 100644
> --- a/Documentation/user-manual.adoc
> +++ b/Documentation/user-manual.adoc
> @@ -4466,7 +4466,7 @@ $ git show		    # most recent commit
>  $ git diff v2.6.15..v2.6.16 # diff between two tagged versions
>  $ git diff v2.6.15..HEAD    # diff with current head
>  $ git grep "foo()"	    # search working directory for "foo()"
> -$ git grep v2.6.15 "foo()"  # search old tree for "foo()"
> +$ git grep "foo()" v2.6.15  # search old tree for "foo()"
>  $ git show v2.6.15:a.txt    # look at old version of a.txt
>  -----------------------------------------------
>  
>
> base-commit: dc6ecd5354dca88d51b6d6562777fc8fc10d77e1
