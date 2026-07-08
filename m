Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E183DE42B
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540458; cv=none; b=XN5Pyr4kG0sVNuVtg7qzXiKXWPeyF+Ybcho0sSwqK0SwXueHGJ9kSy3MOF90AYFBNkK8P8CwRYQjulE0P8tuYXmY4Jv0xC501/wEaYr1IVIaGS8uopTF8iBiKOOLn6OV36q3ZgEN9+oDIKXQU8pvJ6XvolUbZ1rMGfvQyn0ZEdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540458; c=relaxed/simple;
	bh=5p0mxEQ27C6JW0nVrHirtfyr1KwaIjhCEcrvdNKKe5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VNoXepaLlUuQfngcuEBxI8YBsPN4nYxSYmd2YdpMn4xNGNDzMhjnLRlpBTHa4sfLsKC9DttPw3xgZsVdM+E8rwq9xMjTEiLwzVJB9pdNvOxvPjc4xcLSXhpvjE1ne5Q2qwn51WcNcg8bKcpfBP/HqBzMsI2I7SUeA/hxdvJD1Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KupX4hgU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oAe8yzZ6; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KupX4hgU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oAe8yzZ6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 497D87A0129;
	Wed,  8 Jul 2026 15:54:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 08 Jul 2026 15:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783540454; x=1783626854; bh=//vK9Rcy1s
	d7SuAGLeFIf8/gKQbMbqbJpSdIHh+heVU=; b=KupX4hgU7sJW8lrngFEV+Yk9sc
	XqG+7h/ql8STGsyxF/77zYdxDoyvzOy5mvUL60l4ZsMczVeUFkD6pvLtIUzhrHY4
	bfCf4GGTQY2uBT3YAD8C4cJQwb418z8KiOo8vZnlEp/ZgObWcrZF9hwOk01+8OXz
	3Fq8YlHu/3lHxYyqg3h4Iy5ih7k8/g9R6RC68/fIcRTjtG1T9ziAtORpALxLaxak
	j+Jbv/KMrzJPu9i/WokioLm0CrzuUWSHRNuPDUcuiV53LBjNpvzP7Yuu65p7mfRW
	nDBjSkwXSSa1SCbLJ7GMoJJdyLH39oVW2RWab6MR3j232MSsHAAUoEhNpVAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783540454; x=1783626854; bh=//vK9Rcy1sd7SuAGLeFIf8/gKQbMbqbJpSd
	IHh+heVU=; b=oAe8yzZ6aqjVAt/T3aScBx/jzDFS7DkAebmbfOJEThE/4jwINoQ
	e45qFPOas9xRf6nB0iNvR1cRoyBRB9SxidiR99A1lU62YlHXIL8owctGI41g0jJV
	r746RlzwK7qHIUEK2Xcy8/AidZwg5WpmwCpb2lbqBvuoncS/KzD/6WOdheFD4p+U
	FLd4q70bkJsgfXBkRqjOYa6Fh29qlxiWiWIawH1H3ae7pO/9NfU8sgLX8d0Qsnzr
	UNKhCt7iYz9kmye2zTeN7yf4v+vIUBvP79Uwy8bsN9uxpfQP4aY5hdWvj4B42v+s
	J7aTxllP74D6DKOZNmoz+T6K594IKaNlhyQ==
X-ME-Sender: <xms:5qpOakPewhdc1-pjNDJe0kW7mpm2xks-vJ8NZiwwirXWhIGpScYA6A>
    <xme:5qpOah-Vm5SocqPTiSh0xbDV6Pz8aKS63_Su-KbHjV7kHL-jt2e-kfKpDcOOO16OT
    4lSOs4exBcSe0Fhyknz0ZymkvRjcC00qogmtL2rR3hMpGy0i8KL>
X-ME-Received: <xmr:5qpOagRmttaXfqgMxho_eU9zg7W6G4TOV3-EdxPfNy_Awo8Rm3AhM3AKlW8Rlut6BixGUf2QF-M24-K1k30klqxbXiLSWPYu7ij0cb8>
X-ME-Proxy-Cause: dmFkZTFb5lOHx1LUGMstQpZoPjvHRVsMhXoSu2neilFZ9cWlguYAzlrQeb4tS8f/1CAj1e
    uVqRAP/zg3b9PpZrLD+6qjkqOcQ7rXRn3KzdwIZZDEExW3rNuQOGsCqNHkPOqqg86iFvaN
    mo11garfEIDpPvHKZycBLYUzNh3De1lcpMGSBx+i+xz2Z14+W6diIVfU/eqgjGmuzl4q76
    MMK/dH+JXaiWLkAGN8m9V6nmyvxzdnE0onAYy6r130tyJZJQTZ+5omlQUbLRbd9yIUuYDc
    L6dq9yLOZt+V18wqxCe2ar3biOV8iXV9v7UZK75fxawPd+POfD6ftu7YENxpGlDEtlj6qw
    rp3S7f2FBcnl/MfhIOfg0V/P6SgYD+VPIOJ70mCeG6avkqpxOuw37OPhkcxRuHMMF6EOfg
    IDFSHX/KfaARjNnYCTyInCNmEoiAXhpNepP5Xj458f2stfnxUrxTKAlgb2V8AziJk3sDct
    nWIo5myvyYmURk4YPW7lS2T2bt5441tZJBWk1M5bmjKsKiM10oujIcHrPmIzbqkudhBsAw
    vBajmPoZd7SOzZlZ49hOwNLmsbcOVaLgXsdRJRY7Bb00UDh/LuiFnjrXKKuRH8sUbyMK38
    vIBXTJMzgcBlwYXQcg7amunBkgUe6Rrw2Y0dzV9Y1NxtQOT7YnojOfhFGUBw
X-ME-Proxy: <xmx:5qpOarkVIagklyPfPz7OdXq4phIjdZVIBmtrYDtO2y5r2JJLrUY86w>
    <xmx:5qpOaoSrZ3GRKd9stgBqu44IiAt7wCLxRZAprYdneRS2Y2X66_wV1w>
    <xmx:5qpOahPtglG5rlPZTIdt3KJJQXyQmzhSCwDNJa06Z6t3ibOSHKMsoA>
    <xmx:5qpOapUWLeWgYb8UMXXiNvSOEbexHzRRuum6aDpI5vs_WzZpLOMEvQ>
    <xmx:5qpOajy5j54U5LDAlmdKFU4fFDxVNYmpn5DFL5KZldi5sPhJ7D-iRckg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 15:54:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH 1/3] t/lib-httpd: fix apply-one-time-script race under
 concurrent requests
In-Reply-To: <9f48aa6d6ddea681b700f689f0509c4b30a7007d.1783479584.git.gitgitgadget@gmail.com>
	(Michael Montalbo via GitGitGadget's message of "Wed, 08 Jul 2026
	02:59:41 +0000")
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<9f48aa6d6ddea681b700f689f0509c4b30a7007d.1783479584.git.gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 12:54:12 -0700
Message-ID: <xmqqpl0xtfyz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Michael Montalbo <mmontalbo@gmail.com>
>
> apply-one-time-script.sh checks for the "one-time-script" marker, runs
> it, captures the git-http-backend response in the fixed-name files "out"
> and "out_modified", and removes the marker only after it has finished
> serving the modified response. Because the client receives the response
> body before that removal, it can start its next request while the marker
> still exists. Apache can then run this CGI for two requests at once: a
> partial fetch that receives a REF_DELTA against a missing promisor
> object lazily fetches that base while the first response is still in
> flight. The second request passes the marker check, the first request
> then removes the marker, and the second fails to exec the now-missing
> marker, emits no output, and the server answers HTTP 500:
>
>   fatal: ... The requested URL returned error: 500
>   fatal: could not fetch <oid> from promisor remote
>
> This has been seen as a flaky failure of t5616.47 on the macOS CI
> runners.

Thanks for this detailed write-up.  The analysis looks good.

> Claim the marker atomically with a rename, and only once the one-time
> script has succeeded and actually changed the response; give the scratch
> files per-request names. A request that loses the rename, or whose
> script fails or leaves the response unchanged, serves the unmodified
> body and keeps the marker for a later request. No path emits an empty
> body, so the HTTP 500 no longer occurs.

Hmph.  

> +#
> +# Apache can run this CGI for concurrent requests (for example a partial fetch
> +# that lazily fetches a missing object while the first response is still in
> +# flight), so the helper claims the marker atomically with a rename, and only
> +# once it has decided to modify the response. A request that loses the race
> +# finds the marker already gone and serves its response unchanged; no request
> +# is left emitting an empty body, which the server would report as HTTP 500.
> +# Scratch files are per-request ($$) so concurrent requests do not clobber each
> +# other.
> +
> +test -f one-time-script || exec "$GIT_EXEC_PATH/git-http-backend"
>  
> -	"$GIT_EXEC_PATH/git-http-backend" >out
> -	./one-time-script out >out_modified
> +LC_ALL=C
> +export LC_ALL

The original was somehow inconsistent in that it forced C locale
only when one-time-script munged the output, and otherwise the
backend was run in the original locale.  I am not sure if that
matters very much.

> +out=out.$$
> +modified=out-modified.$$
> +"$GIT_EXEC_PATH/git-http-backend" >"$out"
> +
> +if ./one-time-script "$out" 2>/dev/null >"$modified" &&
> +   ! cmp -s "$out" "$modified" &&
> +   mv one-time-script one-time-script.$$ 2>/dev/null
> +then
> +	cat "$modified"
>  else
> +	cat "$out"
>  fi

We may run the one-time script, find that it modified the payload,
and then another instance of us may start running before we can move
the one-time script away, so the second request can see "ah,
one-time-script is there, nobody has claimed it by renaming" and run
it again, no?  So this solution may shrink the race window but may
not completely eliminate it, unless we have some coordination among
ourselves, perhaps?

Ah, we assume running one-time-script itself multiple times is safe
and does not cause issues.  Our objective is to avoid returning
modified output twice.  So while the first instance of us
successfully renames one-time-script to one-time-script.$$ and emits
the modified result, even if the second instance raced and managed
to run the script again, it will fail to rename with "mv", and
discard the modified output, and instead show the unmodified output
generated by the backend.

OK.  It is a bit tricky.  It may help future readers if we said
something about this in the proposed log message (i.e., we consider
that it is perfectly fine to run one-time-script more than once; we
only want to avoid letting the second invocation's output used).

Thanks.
