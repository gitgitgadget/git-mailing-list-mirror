Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A42E2036E9
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783867824; cv=none; b=f93Srg7aLgKw5uOrYS4IxYsDSa/Onshy+wLmAYBHhHMxE/CiKq6gfPCnWbVgAyy3VmDhlCZcoqihpOc7BhEimWXrbRmUzAjU5I59CjVSKDw1VWsYn1xL3xw77t0Mj7GdEuFzG8BfivbU/PFL1J9NWJF7aiShfw1buXwPSHHLy3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783867824; c=relaxed/simple;
	bh=TWDuv9CVw3P672zXo0ZDv1t1xEQpeU4Y62DnYyrzjrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3P3mDgQuR+AJEnJYsciTBahlxghFyt0rt4CQANZOLBzsWCDeCtlc4XwJBYTzTxMeXVlanECh+H4PseD//8Lj69EubdPjcaXCHAGmjFyn3b3qBHZ7Q95OJT7v8GYIpNgQwTTM57pzLctrImZ74M6OsA8N4lTzBVN2Gm7+KZ/MsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=KPPLf659; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="KPPLf659"
Date: Sun, 12 Jul 2026 22:49:58 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1783867819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcbnIc7tSL5awXO05DUGbtGTzFFCUV2x+cqifMYmqLw=;
	b=KPPLf659bNLmxhPksAwMJas1gldDEK1W16byVjkXYUzC86JfeRRUq37DR89jVsBULu2+wu
	WA9ge3bQaEv+mtFreMpnNtQDt0t5TdFcqSU55pMlbU76aZl0WUAj4DwPTtv51zzeTPdWwg
	AmGLXuj0D9OUkDZmgRpudFGO9Fr9bfSvaTY6oQyoiPIzM/xVP9+bG7sPX5NUo7ZjiMR4/I
	nCYBqck98Oxv2IJpWjbDs94XB9dkQEB3frctCG8LMANZ3jV/mNom62IXBW6nzOxu1TrGcN
	y3JUSHPXwLCp0BWnzuzxIl8eDdojkmfm7v+ij/HSga4yPpDpsnSSIVcueqsmSQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] SubmittingPatches: clarify expected structure of
 commit log message
Message-ID: <alOplirhJxIkpDYh@wyuan.org>
References: <20260711192650.2417665-1-gitster@pobox.com>
 <20260711192650.2417665-2-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711192650.2417665-2-gitster@pobox.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Jul 11, 2026 at 12:26:45PM -0700, Junio C Hamano wrote:
> The current text on log message has lots of justification and
> rationale before telling contributors what exactly is expected of
> them.

Nit: s/message/messages/ ?

> Simplify the rationale section and jump straight to what to write
> and how.

> [...]

> +Reviewers will evaluate your commit message for clarity and structure.
> +A well-structured commit message typically follows a three-part flow:
> +**Observation**, **Solution**, and **Command**.
>  
> -. justifies the way the change solves the problem, i.e. why the
> -  result with the change is better.
> -
> -. alternate solutions considered but discarded, if any.
> +[[meaningful-message]]
> +==== Structure of a Commit Message
>  
> -. records the resolution of design or viability concerns raised by the
> -  community during the review, if any, ensuring the historical record
> -  explains why the chosen approach was accepted over alternatives.
> +0. **Title**:
> +   The first line of the commit log message is the title that lets
> +   readers of `git log --oneline` quickly understand what area the
> +   commit touches and what problem it addresses.
>  
> +1. **Observation (The Status Quo)**:
> +   Explain the problem you are trying to solve.  Describe what is
> +   wrong with the current code *without* your change.
> ++
>  [[present-tense]]
> -The problem statement that describes the status quo is written in the
> -present tense.  Write "The code does X when it is given input Y",
> -instead of "The code used to do Y when given input X".  You do not
> -have to say "Currently"---the status quo in the problem statement is
> -about the code _without_ your change, by project convention.
> -
> -[[imperative-mood]]
> -Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> -instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> -to do frotz", as if you are giving orders to the codebase to change
> -its behavior.  Try to make sure your explanation can be understood
> -without external resources. Instead of giving a URL to a mailing list
> -archive, summarize the relevant points of the discussion.
> +Write this problem statement in the **present tense** (e.g., "The
> +code does X when given input Y", not "The code used to do Y").  The
> +status quo in the problem statement is always about the code without
> +your change, by project convention.  Do not use words like
> +"Currently" to describe this state.
> +
> +2. **Solution (The Approach)**:
> +   Justify the way your change solves the problem.  Explain why the
> +   proposed approach is better and mention any alternate solutions
> +   considered and discarded.
> ++
> +If your change only addresses a subset of a larger problem (e.g.,
> +handles directories but not files because of characteristic Y),
> +explain this limitation.  This helps future developers understand the
> +boundaries of your work and whether it can be safely extended.
> ++
> +If the change resolves design or viability concerns raised by the
> +community during prior review rounds, ensure the message records the
> +resolution, explaining why the chosen approach was accepted over
> +alternatives.
> +
> +3. **Command (The Instruction)**:
> +   [[imperative-mood]]
> +   Command the codebase to change.  Write this in the **imperative
> +   mood** (e.g., "make xyzzy do frotz" instead of "This patch makes
> +   xyzzy do..." or "I changed xyzzy..."), as if you are giving orders
> +   to the codebase to change its behavior.

Stopped and confused for a moment. I am not sure that "Command" belongs
alongside "Observation" and "Solution" as a third part of the message.
Sometimes the command still describes the solution. In other words,
Solution and Command seem not to be logically completely separable.

> +#### Formatting and Style Guidelines

Perhaps using "====" here would be in harmony with the existing content.

> +* **The Subject Line (First Line)**:
> +  * Keep it short (50 characters is the soft limit).
> +  * Skip the full stop at the end.
> +  * Prefix the subject with the modified area followed by a colon
> +    and a space (e.g., "area: subject").  The area is typically a
> +    filename or identifier (e.g., `doc:`, `transport:`, `t5601:`).
> +    Run `git log --no-merges` on target files to see conventions.
> +  * [[summary-section]]
> +    Do not capitalize the first word after the "area:" prefix unless
> +    there is a specific reason (e.g., `HEAD` is always in caps).
> +    E.g., use "doc: clarify...", not "doc: Clarify...".
> +
> +* **The Body**:
> +  * Explain the *why* rather than repeating the *what* of the diff.
> +  * Try to make the explanation self-contained.  Avoid relying on
> +    external URLs (like mailing list archives) as the sole
> +    explanation; summarize the relevant points of the discussion
> +    instead.
> +  * Wrap lines to 68-72 columns.

MyFirstContribution:
  This commit message is intentionally formatted to 72 columns per line

Should we update both?

btw I don't know which editors/projects have the default setting of 68.
Is it Emacs?

Thanks.
