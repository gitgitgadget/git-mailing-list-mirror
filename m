Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6D542DFF5
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783952118; cv=none; b=NJeekUklXvOe6Nsb/yFjXAxj3dezgISFqfGb5pyoz/9lOieFavxMzwOx/6urPG9vIO5V4t4MdvA57YLYxLUNi7AWG2anUNNeD5WZNMN3UEQlMsVQlpetzt0c1JMplhjKrY0f6Rk50rxd1zpYms9N2ZIcw3fYQxnkL0lVPyOMaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783952118; c=relaxed/simple;
	bh=LRk2QkX2Lc+o/XCjVy6UxCHDWCh1eUbzBMVfOLCZcI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5/h+uoJPLqhQJZgg2svQXCJs0f6+bQ1ETT+Jp/4zmZ8jqM+6DE2G85fLSr0rLnPrHkDgEMa6+j1DBZ1Zqg9RW3r4hrCdjVB6eQi4SKKsiRk/CpuJVL8Oy0XXEzRjDDG1sX9ieGlCTdQTAFuJACrUt8mpsqdK19YCb3p9JVXzjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=LLL5BR6p; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="LLL5BR6p"
Date: Mon, 13 Jul 2026 22:14:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1783952113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96TvLL308qsqUxCAASuujH1nRBCcogAefeNl1qgczWg=;
	b=LLL5BR6pfKq+ljlrAlTCtKiCi+9FbB7AfhH28KdQtRhX+m5opLsfiWj3+YPZ8kS4SA7hVp
	Y3ysRIsJC7hSSl/cv4Sqn8ZlFEmQrucJX29+bZrSzMjzlzGjpEjleFOaSS2btJ9FcQBac8
	wLMPp7ODHtspbW4IGGG+lS/pvchpKImT/HBbDo/FjeJfDbfWzco9rHjKWW+ql8TUk4GSks
	XQ+Q1qQMmr8T2V0OoRbv5jvZhbCRMexObQ3L9z9RsF7omCigzKGuHcBCggwVg8s2XfgF1D
	PHxAGcnb8aIeA0M1ETxDQZM5K/8uWgJm0olZpArZwrM42mZNgPh/dCDKu9ip5w==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/6] SubmittingPatches: clarify expected structure of
 commit log message
Message-ID: <alTy306FaTAe2E8w@wyuan.org>
References: <20260711192650.2417665-1-gitster@pobox.com>
 <20260711192650.2417665-2-gitster@pobox.com>
 <CAC2QwmL05MbVS=jtk7ARj6jJUT461Ws7BcYqUAUrywvDDXjJqg@mail.gmail.com>
 <xmqqcxwr3g7r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcxwr3g7r.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT

On Sun, Jul 12, 2026 at 05:07:04PM -0700, Junio C Hamano wrote:
> Michael Montalbo <mmontalbo@gmail.com> writes:
> 
> > I think collapsing the "Formatting and Style Guidelines" section with
> > the above would be clearer than having a separate section.
> 
> Thanks for pointing it out; I tend to agree.
> 
> Before rerolling the series in entirety, here is what I have in my
> editor buffer right now, after attempting to move the formatting and
> styles into the main description.
> 
> I haven't checked if the formatting works as AsciiDoc yet, though.
> 
> --- >8 ---
> [[meaningful-message]]
> ==== Structure of a Commit Message
> 
> 1. Title:
>    The first line of the commit log message is the title that lets
>    readers of `git log --oneline` quickly understand what area the
>    commit touches and what problem it addresses.
> 
>    - Keep it short (50 characters is the soft limit).
>    - Skip the full stop at the end.
>    - Prefix the subject with the modified area followed by a colon
>      and a space (e.g., "area: subject").  The area is typically a
>      filename or identifier (e.g., `doc:`, `transport:`, `t5601:`).
>      Run `git log --no-merges` on target files to see conventions.
>    - Do not capitalize the first word after the "area:" prefix
>      unless there is a specific reason (e.g., `HEAD` is always in
>      uppercase).  For example, use "doc: clarify...", not "doc:
>      Clarify...".
> 
> 2. Body:
>    A well-structured commit message body typically follows a
>    three-part flow: Observation, Solution Design, and
>    Implementation.
> 
>    - Leave a blank line between the title and the body.
>    - Wrap lines in the body of the commit log message to around 70
>      columns.
>    - The body of the log message must be self-contained.  Do not
>      rely on external URLs (including mailing list archives) as the
>      sole explanation.  Summarize the relevant points of external
>      material so that readers can understand the change with the log
>      message alone.
> 
> [[present-tense]]
> 3. Observation (The Status Quo):
>    Explain the problem you are solving with your change by
>    describing what is wrong with the current code *without* your
>    change.
> 
>    - As this part is always about the current state by convention,
>      words like "currently" are unnecessary.
>    - Write this problem statement in the present tense (e.g., "The
>      code does X when given input Y", not "The code did X").
> 
> 4. Solution Design (The Approach):
>    Explain the approach you took, justify how it solves the problem,
>    and describe why you chose the particular design over other
>    alternatives.
> 
>    - Focus on describing _why_, not _how_ (e.g., "The code does X
>      when given input Y, but it should do Z _because_...").
>    - If your change only addresses a subset of a larger problem
>      (e.g., it handles directories but not files because ...),
>      explain this limitation.  This helps future developers
>      understand the boundaries of your work and whether it can be
>      safely extended.
>    - If your change resolves design or viability concerns raised by
>      the community during prior review rounds, ensure the message
>      records the resolution, explaining why the chosen approach was
>      accepted over alternatives.
> 
> [[imperative-mood]]
> 5. Implementation (The Execution):
>    Finally, describe how the changes are implemented.
> 
>    - Write this in the imperative mood (e.g., "Make xyzzy do frotz",
>      not "This patch makes xyzzy do..." or "I changed xyzzy..."), as
>      if you are instructing an agent to make changes to the
>      codebase.
>    - You do not have to repeat everything readers can discern from
>      the patch text.  Highlight the key points in your
>      implementation.

I think this might confuse readers. Now you place these points in
parallel:

 1. Title
 2. Body
 3. Observation (The Status Quo)
 4. Solution Design (The Approach)
 5. Implementation (The Execution)

But acatually you mean:

1. Title
2. Body
   The body typically follows three parts:
   a. Observation
   b. Solution Design
   c. Implementation

But I haven't written much about adoc, so I don't know its syntax and
how to write it.
