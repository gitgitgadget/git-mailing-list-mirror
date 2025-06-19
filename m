Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2BE8633F
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750354323; cv=none; b=LHzNxj80uor0rtsorqE6duqPVwPcx3T2tUJ8Z+FFyVmjO/Danu6S6u0S5GLYl3pS+23ufcZPrlgQU4HF5+WFRuR14JvHp7SynZiVvpgZlthcCovdpLdgHzkABIWwNGB18ZHfUEjmpNH/hW2qcXlkQYYNi3qitRZfenG9Qs46CHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750354323; c=relaxed/simple;
	bh=Cqn5Wee5sqrZTzbFPzb1exCtC1c5fSRaUSP4NZTlmgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aUZd/1iC+vZofw9B+OmLKG0bycuRl3E2yP0kggDJE49vAI+leS4IP0NtB4XRIrxyney+g9Vnz+UhdFfy0kpVTzaWqoMGZ6JAhfHBiENAqxzyPdWIgEYmZV00O7Jb9hzyAtYeJgLXZhf0xzQSl67kPCRB9oEmm5NSsy5g+KEcdY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pcWfZr9A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PVFxNW9f; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pcWfZr9A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PVFxNW9f"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 6507711400E1;
	Thu, 19 Jun 2025 13:32:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 19 Jun 2025 13:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750354320; x=1750440720; bh=k3fjCjU7fF
	dr8xK7IWcetgTxJGDyUnw6atm+O1taNQM=; b=pcWfZr9As+S7+/YByimDUQGG08
	yA8NOuq9ZkzejOjXipCWdj47Ow6tHc7hHYvzt8OXaDCXOBSv7jxhwzpAiUDpeGYd
	LpN52wEpHHRl5P07KvFqAys2W7Q9U+H/+X0zxh+ruAFsSqyGbXDvG/Z8++dCIZlF
	mksPNd1OFFfC6KQ6H4EY4LqVO93UmgVwa6Bik1kbPg0Osykv+zTRD+O3CjHhkGeK
	s3lSPVBQkbKIrozfedArpNUP0wsoLDUhkfaWllcc3q68QHZhPHPkm2EVeHOopin5
	49+fNwjHJgtcisqsDp2lu9vWiLOAUyy4kxdTeC4kJGRmFZjIrnn1HhYiL0Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750354320; x=1750440720; bh=k3fjCjU7fFdr8xK7IWcetgTxJGDyUnw6atm
	+O1taNQM=; b=PVFxNW9fchtyJ9pJSqYV0W0aCqucOk3IFI2BqGlRGswF88C9xUg
	ldjkWD8DnCc449wh9VtT7JndCQjETVQu+/k5UmnxUCKmSjQVHfX6wyjmiX0bQs/u
	qgBnwVaWF7dPfYwgMMkci1fmXJoEZCdaAcShRi+ZenfEl6OYPXgmqqRptajPKqZX
	kTVuHkgucuUpu/g1H6/GOuwuu5NIED6rUrViRqsURN7KN73mIj6Kw6EwAi64bhzp
	UvcpK+DU+r6GTURlUQ+i073d+FtPDZRRdiJ0rstusagaRopOxb1c7XDEpM/Ru6ss
	wQfJ48D6MnyqOXssnJm/U0Ue2SdSujOS5IA==
X-ME-Sender: <xms:j0lUaLTRq11XfzdXHTRw-rQPMBhqCz7rHdKhN4TPiNLkNFkLBQnVqQ>
    <xme:j0lUaMwddvL7saE08S0m6UP7wNsY8ERCTk9c1C7CbHbu50m6eU60Z5AsLREXzD2Xt
    vplyX2fU-BiWluG6g>
X-ME-Received: <xmr:j0lUaA1QgLJUGM_L51iH5Qnf7CirnaXuYMDFr66yLuK7GsrSYIEegHeej-cB_v7uOPsJGqYxGF5mCCnkJd2C9PPT90QO60mS4ldl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeiudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghgsihhrtghhmhgvihgvrhestghonhhnrghmrghrrgdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:j0lUaLAvbZ8TRkZqjBZboiHCgrkJt0miB3E3SNvjrYruWqzcn-Ry5w>
    <xmx:kElUaEgy2cy5lHYkvsLM2HMMi4HpNkiqNcU1hE8drK5ivABBN_lJvg>
    <xmx:kElUaPq07aazfw4jbXYNYPhZ3nkr2jOsoMjIFFSI0myxRfDl-_ju9w>
    <xmx:kElUaPg75Ljgi_vZ6cnVIfCndUkOKFVy1sy4a-78HxdR5MaLbhfTkg>
    <xmx:kElUaF0i_Qm6SwGqY1EgmIDwQLAGf_d_j-PHyub0bIVYs0jPNN11Ntzq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jun 2025 13:31:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Grant Birchmeier <gbirchmeier@connamara.com>
Cc: git@vger.kernel.org
Subject: Re: bug report: I was allowed to "git checkout -b" while mid-rebase
In-Reply-To: <CAMq4opPBGT0Rv25DnEMHPjA=W_Ut2BDsN0KmxD2_xGTJa9erJQ@mail.gmail.com>
	(Grant Birchmeier's message of "Wed, 18 Jun 2025 19:12:01 -0500")
References: <CAMq4opPBGT0Rv25DnEMHPjA=W_Ut2BDsN0KmxD2_xGTJa9erJQ@mail.gmail.com>
Date: Thu, 19 Jun 2025 10:31:58 -0700
Message-ID: <xmqq34bvab8x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Grant Birchmeier <gbirchmeier@connamara.com> writes:

> *What did you expect to happen? (Expected behavior)*
>
> I would expect an error message and a refusal to execute the `git checkout
> -b` command.

I am not sure if it is such a good idea, though.

I just did a short experiment:

 * randomly work and end up with many commits on 'master'; they are
   about two independent topics A and B, so I want to separate them out.

 * "git rebase -i master" and edit the todo list to group the
   commits into two sets, the commits about the topic A comes first
   and then the commits about the topic B on top.

 * Arrange that before processing the first commit for topic B, the
   control is given back to the end user.  If the last commit of the
   topic A stops due to conflict, that is fine.  Or an explicit
   "break" inserted into the todo list would work well.

 * When topic A's commits are replayed on top of 'master', do "git
   branch A" and then "git checkout -b B master".  The history
   recorded on branch A is now about the development of topic A on
   top of master, without a trace of any topic B.

 * "git rebase --continue" and I ended up on branch B, which
   recorded the development of topic B on top of master, without a
   trace of any topic A.

and it seems to work as expected as a handy way to clean up a mixed
bag into separate topic branches.
