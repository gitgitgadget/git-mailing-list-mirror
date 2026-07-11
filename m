Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37881175A98
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783779338; cv=none; b=MJbXJg0VKJrZqdm/9out35ca998SBRheNLyyqRqIaA5TyAv8/UyZHV0Ac9YaMd6IqM4JP3/fHb4r9pg/MlScrFmYK8fffxuPr2RMEx+0VmZ6+jyvmxGE3oUlFuVvWl4zB0to+Aq4SurTvL6r4kr6wJL9hRT0fNWqfFISdc4rI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783779338; c=relaxed/simple;
	bh=1HYstmwpWgnq8Es4YKgHjLDpji+bY8Gv9gpSysP6XK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmGgToisZgfM9Y+l7toOsTEmjwAxWyP13hyQDe1Y8wHsX8j3nJHZvjieXwtO/Qf+oMf2OWbCKn290lZEI9SMHJZjIsWofWqXy+dMc7laOefy9wIFY9VKueQwiCTSBZNDOrNgPjPqi7ciOYdeKf7CpW8j3+D73xwh9EbtA+HbO5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=hfSg90PB; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="hfSg90PB"
Date: Sat, 11 Jul 2026 16:15:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1783779334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YBlJkwNrYvhkdqkKFOFAjKcS/1BtSc2jyUKR1hoZLnI=;
	b=hfSg90PBJw5rhiUaLIh45/CRQybTVEWoKIC2K64oCFptVwSOvKFDunxXV90z8gI5nYeHFD
	OWlURm3J256VGP9u6Z0tTt6V98rXttcp2Sp18ESPQAQPhM7vLWovNsfuu9JVGaHXEe7AES
	6TlbvBY34wAH16fFsApmDc7M7IJgpN2FsbfGGpZEm7Lm7SYQaT0WV8ZduTCNO2VhPlh32S
	ohMICb5lDt6Hww8eLu0HVRGDU1jfClR3R/SfQqIZbcrt81sr7eg5+de83TCHi108dH/c4Q
	lGO3VTIRNXSSpfscbGJjsVK6hGxwcD6gadzxNsi6EjnzapveRw0FVOPophn8+Q==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, ayu.chandekar@gmail.com, 
	chandrapratap3519@gmail.com, christian.couder@gmail.com, gitster@pobox.com, 
	jltobler@gmail.com, karthik.188@gmail.com, krka@spotify.com, peff@peff.net, 
	phillip.wood@dunelm.org.uk, siddharthasthana31@gmail.com, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v9 0/4] graph: indent visual roots in graph
Message-ID: <alJOgYmAfGg37hsB@exploit>
References: <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
 <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
X-Spamd-Bar: -

On Sat, Jul 11, 2026 at 03:37:49PM +0200, Pablo Sabater wrote:
> When rendering a graph, if the history contains multiple "visual roots",
> actual roots or commits that look like roots (i.e. have their parents
> filtered out) can end up being vertically adjacent to unrelated commits,
> falsely appearing to be related.
> 
> A fix for this issue was already attempted [1] a while ago.
> 
> This series adds indentation to the visual root commits, so they cannot be
> vertically adjacent anymore making it easier to identify them.
> 
> Before indentation:
> 
> 	* A
> 	* B1
> 	* B2
> 	* C1
> 	* C2
> 
> After indentation:
> 
> 	  * A
> 	* B1
> 	 \
> 	  * B2
> 	* C1
> 	* C2
> 
> Indents the visual root commits that have still commits to show after
> them, and if they have children it connects them with an edge at a new
> row.
> 
> If there are multiple visual roots adjacent in history, the indentation
> starts with the second one, avoiding redundant indentation of the first
> one and cascades after the second.
> 
> 	* A
> 	  * B
> 	    * C
> 	* D1
> 	* D2
> 
> This series first commit is a cleanup that brings a common function
> from t4215 and t6016 to a graph functions file which they both use, so
> the new test file for indentation, t4218, can use it as well.
> 
> GitHub CI: https://github.com/pabloosabaterr/git/actions/runs/29154333559
> 
> [1]: https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/
> 
> V8 DIFF:
> 
> - Checking if the parents of a commit are NULL is not enough to know if
>   the commit is a visual root due to options that filter the commit
>   parents but they do not remove them (--author, --grep, etc).
>   At graph_is_visual_root_candidate(), iterate the parents and call
>   graph_is_interesting() for each of them to know whether they will be
>   shown or not.
> - Add a --author and a --grep test.
> 
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> 
> ---
> Pablo Sabater (4):
>       lib-log-graph: move check_graph function
>       revision: add next_commit_to_show()
>       graph: add a 2 commit buffer for lookahead
>       graph: indent visual root in graph
> 
>  graph.c                                    | 295 +++++++++++++++++
>  graph.h                                    |  17 +
>  revision.c                                 |  48 ++-
>  t/lib-log-graph.sh                         |   5 +
>  t/meson.build                              |   1 +
>  t/t4215-log-skewed-merges.sh               |  33 +-
>  t/t4218-log-graph-indentation.sh           | 514 +++++++++++++++++++++++++++++
>  t/t6016-rev-list-graph-simplify-history.sh |  25 +-
>  8 files changed, 893 insertions(+), 45 deletions(-)

Sorry, I know I'm a bit late to the discussion regarding the design,
but, could we maybe have two different code paths for printing graphs?
Having the old one as a default and this new one only when we're using
--oneline (well, --format=reference would benefit too)? As it is now if
I have multiple one-patch series in sequence the entries are
unnecessarily indented.

Thanks
