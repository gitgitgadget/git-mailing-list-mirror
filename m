Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6D5BA34
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320179; cv=none; b=fxgk4HVvGO/gSlgZ6SaPdHrNvE3IdHHvsGA1C1aB28vWbsm6qoGhDCmN3zlVUDkHPC8qolR4PFINibp/sbF1jkEThgyt2LeUfn5XhkKdZaTaCLMoaquIk+vF9IUU2owbY6MajWOloVT2IT3VkHl+6RmPETc+Gxzy9qPW1Ww+P4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320179; c=relaxed/simple;
	bh=ygeqpZGNubZHE3xaleMGAFx0OnrAyiH0xOm8uZHtJns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPn+rQxE0yW0JJc0X//FXB/m93CouvicqOVZBtwP4WCdgAdh6ikDbM6YSexizP7FnL3s3jlUs5hwD7IEvzVkZczx9RdB5aOntSKltF0tUPr9llLC6a6tWbuKrM/O8qHZlvl72lzsLM8wG3+Uf4ogZl2U2f5xKO/xXg+sMk6Gy+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IUn+yjyb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=idDHzLLO; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IUn+yjyb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="idDHzLLO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 835987A00B9;
	Fri, 21 Aug 2026 09:49:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 21 Aug 2026 09:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787320177; x=1787406577; bh=gr8o2DHUOj
	SiLvyXUkDHbGUjaTmr3QkC2lqOknSm1h4=; b=IUn+yjyblMyO7RacMFioGLxU6N
	YTMppYnWON0RdidZJUW1sdvc/JoHvr/ARNt+PGI4/Rd0MIT/PdCAst3/6+zyGHMV
	yAGRUUqaRx6Rz3dok3m4vmXWIznUGqa4nM9cZJnNgx5dqWHzSS367+zQApxrx8hn
	0rl0FpBxHgYSF7mXun2B+FZLEbf7xc8bITylBsQXXdGB7jAVFEqtK6iIiF1XDvtO
	embwAZhoDBIguCTH9rXl2gh1aXTKQVIRhXSctICMcWfn4d5HLyzbt/884H328wis
	qOPISCZtmiYqHpqgrGbND/ilL7sZ4CDEqa0wpLlaAnF28yotzHlbh/fqs0FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787320177; x=1787406577; bh=gr8o2DHUOjSiLvyXUkDHbGUjaTmr3QkC2lq
	OknSm1h4=; b=idDHzLLOVaL6AbhNK5u9IJRUyM3ndvXhe3bRmgMCbBbpQQD6/YU
	f9u/ERxzG5lM3B1zz/X7It+H/OU0GMggwxpAWAJFrY93ZYtkeoU1ozC5qX9aXZMj
	xw1HWq5WLdC7B+Dpg+KdErvdSA9KEFQrTOzWzCDN1aEYuSkSLmrdTQQY1eVPlYCa
	N5zwHvVIyjFAtNIaddeqAA0CH8dVdhCqk5CtcSpEdPigaMeSZuSsFlTPDqmxx/Ug
	DPcJwvrOvIRCUmgayk897/D+3yor/UKyOows4uUv1/lpIINKgU/5CTgHloAgfDG3
	qbC+hlxojVrpnKsts18CIPV27smN0vlTnaw==
X-ME-Sender: <xms:cFeIamb1FgpfBSAzIoqqWxIO2MRew40KkZBDbQUSZO-dxtowCsbYww>
    <xme:cFeIaq5K6R8bh6YYoymynD-Yt_o60ysCZoBvUu7e_qBdmLDhYAijilEYmID34DQU3
    CGMslY0dn0xrr01xdwiNPzYHXzMNsaT6zNtBRpgA-MFqHwJeI-a8w>
X-ME-Received: <xmr:cFeIahDd6iAeAYZHlvoy7ooxe112dXT0TdcEA6QiZubELdh6AAe5_HYjrUBqxYKWepldcTUfi9reEyqyI5nk36pxoBm6pAn_My2ZUT9yWyeT>
X-ME-Proxy-Cause: dmFkZTFC89d8ZzWp+7vRmUTRl34x055OufMryefstDeLmOWe9gw/TjZ3GR3Y2QpV62M0t3
    EilG4xXQF757LuB682PQv7YDw/2QKGLSDgkYh5F8LSdIc+rZrY0RJVHRnrFP+YLDn8Px5z
    s/2pqhG3VKpXdQ/MKY8D6Peu65NwQDoNIohdxhRAHNqDY4oPzGG/iaTwHfyCAgNKXoSiiX
    tz/6D7mnGiRtua81DoZyuBOXOJvOv2g+eh5YFuG+glFS4+ylW2xTJKK475oY0Gye+jkADP
    FZh7F9bouCcCbEjKX0/ao91ngcOpLFRVKY1zWhXY6aGxjgjQxPcyowBGuQVDr8Z33ph2ik
    9zfXZ2uiIv7HpFvtvpQm3Mmksw1PcutXVlPItaj5jBkOEI5HpqRoHSv1FQN0uUfLEn+URU
    ZbDTSll5H7/mfmje9r5Veb61XHUzzUQfFmP1Qf57/COf+BNMzNXgsOhUs7L1p05r0hZqk1
    3YyKghZBhz6ypBS1R0oshC49Wnfuw5mKEXqPCt5lIZwMGcwus0O5TQ05suK8/5eldOVb/x
    w/uEhXYh0W5WURVvUT+Dvpb5Trn1pZxWXIa9MdDiTjTXAZko53BJ34hcFwmVQqj2WMkKVu
    0snnrX7zl6Uheucz0ZdElojh+D2ksU8c//wmI9V1UqO3jgeI2ImxS60zdG4g
X-ME-Proxy: <xmx:cFeIaofZWLX1PXjklpGR5TQcltdWRTZ_g_jXu7qlXNldbmRI9kIyMg>
    <xmx:cFeIaoIw8fqkGkijL_QI2f4pAVgarGPTl7PJqRBOqOd9ayTyO3LAiA>
    <xmx:cFeIar20j_WX1x1sm3c_FJFF0_QQf5z1lSF2PzixfbBqL_imy8645w>
    <xmx:cFeIaigdkXcKEKusf0pyUofOxtsJR4rIqAghEQ4RHi2JLK-M8guQaA>
    <xmx:cVeIapu8-CEZ2hEnN02Aa4jtAP3rDnPDt6M1r-sI_YAk6otg_qjv04-R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 09:49:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5b1a019c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Aug 2026 13:49:33 +0000 (UTC)
Date: Fri, 21 Aug 2026 15:49:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] hook: introduce the report hook for
 git-receive-pack(1)
Message-ID: <aohXatWhxCAUQTcq@pks.im>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
 <20260821-758-introduce-hook-v2-1-e90e2f7ac2cf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-758-introduce-hook-v2-1-e90e2f7ac2cf@gmail.com>

On Fri, Aug 21, 2026 at 03:34:58PM +0200, Karthik Nayak wrote:
[snip]
> - Exit 0: the hook's stdout is used as the report. The hook can
>   rewrite 'ok' lines to 'ng' lines to signal per-ref rejection to the
>   client while receive-pack itself exits cleanly. The client marks
>   rejected refs as '[remote rejected]' and exits with a non-zero
>   status if any ref is 'ng'.
> 
> - Non-zero exit: the hook's stdout is discarded, receive-pack calls
>   die(), and no report is sent to the client at all. The client
>   observes a sideband disconnect and reports 'the remote end hung up
>   unexpectedly', treating the entire push as failed.

I was thinking about this case a bit more. Should we maybe handle it
similarly to the pre-receive hook instead of dieing? If that hook fails
we basically update all references to "pre-receive hook declined",
whereas we could update all of them to "report hook failed". That might
make for a better user experience.

> diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
> index 0956086d61..e6cc0acaaf 100644
> --- a/Documentation/git-receive-pack.adoc
> +++ b/Documentation/git-receive-pack.adoc
> @@ -236,6 +236,21 @@ if the repository is packed and is served via a dumb transport.
>  exec git update-server-info
>  ----
>  
> +PROC-RECEIVE HOOK
> +-----------------
> +This hook is invoked by 'git-receive-pack' when it processes push
> +requests. It handles refs whose names match the patterns defined by
> +`receive.procReceiveRefs` and executes the actual ref updates. See
> +linkgit:githooks[5] for the full protocol description.

This feels like it should've been a separate commit.

> diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
> index ed045940d1..06c9e4b017 100644
> --- a/Documentation/githooks.adoc
> +++ b/Documentation/githooks.adoc
> @@ -527,6 +527,57 @@ The exit status of the hook is ignored for any state except for the
>  status will cause the transaction to be aborted. The hook will not be
>  called with "aborted" state in that case.
>  
> +report
> +~~~~~~
> +
> +This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
> +`git push` and updates references in its repository. It executes on
> +the repository once after all refs have been updated and after
> +`execute_commands()` has applied all accepted ref changes to the

Nit: I think we shouldn't talk about functions in our documentation, but
rather about behaviour. Functions are likely to change, and I don't
think we should expect our users to read our code.

> +repository, but before the pkt-line encoded status report is sent back
> +to the client.
> +
> +The hook receives the complete pkt-line encoded status report on
> +standard input. The report begins with an `unpack` line indicating
> +whether the object transfer succeeded (`unpack ok` or
> +`unpack <error>`), followed by one `ok <refname>` or
> +`ng <refname> <reason>` line per ref that was pushed, and is
> +terminated by a flush packet.
> +
> +The hook's standard output entirely replaces the report that is sent
> +to the client. The hook must write a valid pkt-line encoded report in
> +the same format it received. The hook's stdout is fully buffered by
> +`receive-pack` before any data is sent to the client, so the hook's
> +exit status is known before the client receives anything.
> +
> +There are two distinct ways the hook can affect the push outcome:
> +
> +* To reject individual ref updates while keeping `receive-pack` alive,
> +  rewrite the corresponding `ok <refname>` lines to
> +  `ng <refname> <reason>` lines in the output and exit with status 0.

It's `ng <refname>[ <reason>]`, right? I think the reason itself is
optional. We might also want to clarify whether there should be a
trailing newline or not.

Thanks!

Patrick
