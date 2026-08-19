Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D207D26A1AC
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123044; cv=none; b=tO66eFSVQiNKAZAPrZnuvUptwnykratJXq2SK++E+nWs2TVQfS+O9jTdC9keEdfLgoHJZdK1XfNWS6+XOpNOQ1aJIVq6QWWcTBIoQkZx+IGfz8ZhOhyfzejfVyVZl6wrHgUb7uyUsdCJv5SwY4JM0ajBQ1L1NYkF/gQJ2Gxj4dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123044; c=relaxed/simple;
	bh=6HnEGtFs4Kx+XV+P6xznIbupHgB7kgWWzmuW61afUZ4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WQ6nugG7FOurFV2nboEeWdifEWjVq988lNCU83MNyGW2GEV89hy455FWkGReSw3JJMgR2U3te+DisXTyh30bzwBYHMCLecwD2xD8tBVRu/V5LMpoMcAty6ti+NfXRlWXqD2+TKO1IYU2pPRVtBZX1Ky5VADoebglr2DdrOhKjw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=n96zVTTz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lZsba3EP; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="n96zVTTz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lZsba3EP"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9DD96140014C;
	Wed, 19 Aug 2026 03:04:00 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 19 Aug 2026 03:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787123039;
	 x=1787209439; bh=NLD+mVqLzPjaBrcWD+LVumO+ppWzc/1cQ7f5bKToRuw=; b=
	n96zVTTz8mXJokV+nHIybAog7DJMZS5sYQjfTwJNmdCSySn88ROeA7N2BvYA0zpE
	X5JaQnFX0x2PLd3fpl+tY3Aa8XQN7agMncU22Ro8cbccd4FcsOivFUXs2232Cf0s
	HHBF7KdZvU/s8VfK2pHHDsG2q+GX3Lmm2DmELscUJ/p8IIgLJsVt4dWug0u9BoMV
	vbynh9irnyedzjUqUOxuPHXNzCgv7QSWtEU10/nkTkTCXFjiy3/C0R5CF74FR9zo
	9LOZM4qdOWExXHzL7g3QQYpwwH0FnLYJAgbIJJyavF9J83B1WL0lMgCFCotYK2NG
	Give4t4bHNA6FHdOm9YAhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787123039; x=1787209439; bh=N
	LD+mVqLzPjaBrcWD+LVumO+ppWzc/1cQ7f5bKToRuw=; b=lZsba3EPZED4m5+2s
	ozzAv4ejABMnLX48LqYHK2gueynNJr245/UCyR6gs70xxX03ImhjeN8V9Opm9asL
	catKvU2WUqOTtqUWnd8BIqcufbxVsyAKLFO8wkEuw+5s6wDfSzAnJGNsbsjxmtNo
	gnreMat7X5hcoDmP5VZ8bXw850ycd7tJSNeYWbf2NxW6uY0/5EMkQSCtVUKAKNu/
	3n0QG/ouGOpthUVIqPqQIW+n71VvjU+9/+Nm/tiCLr+/eqd0NDxlV/y35tvVpMe+
	c52iV7d5LVh0SywGF3XA6cfYV/Af5d38NB5Fn1+uFh4tB7DhCyyWVQu9F5DHFVRh
	rMRBg==
X-ME-Sender: <xms:XVWFar170iBwOJxI92jP0F3Php1RZpLRN4RL3j20q7IjakPmRGih53I>
    <xme:XVWFak5Rleibe0usVnvPdzzbt8ATo6WkA3qEFjBrEBtqzPUY3cX99j7MOyyC0Zpjh
    XRKNBdL-RCN9-Ki1jaWuok9_k8JnqTmLvH2jNQ1u-HQk1jv8SoYSa4>
X-ME-Proxy-Cause: dmFkZTE4h+sXtWejQ8SgUF1wFGzLsJLCG1zXt/4Jfcwes3ecPoi5WaHszA/tVYsLGFH1OR
    2sKAMACVMlttfGjyXDgC8dvPUXPR9MJbOrEDmPPVQd+npQv9U5x23KLd6KekjVzjdwK0im
    JcRJxdYT/7E8fHLroTgXyJVSGKpGroD7X9hxp/BRaqPDURALzB3nK1uG9oYPGi/8MnYh0c
    2TQ6YOV+88z1o+V0eeORz7YxEtD1/616Y4yXOk7VW8nmfvS5IDoAbt2Nld4nQiOFCApp3Y
    nafsvmwegc03Nkcs3wL9yLYv+/CE1lXFrOI3MqUpAuWD7OaAdREjPDXnBlnMxXeaFN7LcB
    i+JxdkAYTq/WnIS3kpAz0xplhXNThZWjzSoTzCTCAJTsmg3QjzGUdo456KKW2ln8ORl/HS
    gUgTNrlSkBBMGFWRtGxXPAoPnkq1kAtHc5KmWKDBDRwJesV0y0POkh63lH6sj9lX7oWBSY
    8GM3McxV0M2Z96qgWmyR8rrHmJYcYYZS2lNpVI6LItZAayjQtkpNFCK+ycFqwNR2G9V3lX
    jn6xW563nSmzjkTZsD8jSOGCuxjkWcAF3VXPBkN4apjsz7MDJnGgBHwH7ARL9sVE0W5KnA
    IhPS8f07JmCf5x+b4PkVpHp1hApx+e2q7n0jJCDz4VXc2lPgbLxpCPT6patg
X-ME-Proxy: <xmx:XlWFaihMV-ckonWVOdZen3pPkWHcM7H_3VRjIbeV5mEX4qsXzpErwA>
    <xmx:XlWFag-mUftDqV6dLOmYcYmcbDupnAXbUpMBi4UjnzAVSBgRm1r3Mw>
    <xmx:XlWFahqsj15YnG_Kvdim9WyKwTmZifA33pHbez9WHgefLwwB32nAlw>
    <xmx:XlWFan-OWylNQoWUQWq-PNw79mCTJwduZswsefoPt7CoYF9ZTiq0ng>
    <xmx:X1WFahp_soqnwVSH-PTlgBwLYaXZvhc6B4S5cN5zB9JBYsGMkDwzHbM2>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 4D30822C0078; Wed, 19 Aug 2026 03:03:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaoCnH5Gck7B
Date: Wed, 19 Aug 2026 09:03:36 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>, git@vger.kernel.org
Message-Id: <7dc975d2-324b-46a4-a389-9af96f4d5d57@app.fastmail.com>
In-Reply-To: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
Subject: Re: [PATCH] hook: introduce the report hook for git-receive-pack(1)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026, at 09:55, Karthik Nayak wrote:
> When running 'git-receive-pack(1)', there is currently no way for the
> server to intercept and modify the status report before it is sent back
> to the client. This is useful for servers with custom logic that need
> to transform or gate the report based on the outcome of external logic
> post reference updates.
>
> Introduce a new 'report' hook which receives the pkt-line encoded
> status report on stdin and whose stdout replaces the report sent to the
> client. A non-zero exit status causes `receive-pack` to die and the
> client to treat the push as failed.
>
> Similar to the 'proc-receive' hook, this does not use the config-based
> hook infrastructure. That infrastructure is designed for parallelizable
> notification hooks. As this hook is a bidirectional filter, it would
> require significant modifications to that infrastructure and this hook
> cannot be parallelized anyway.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> To give some context, we at GitLab are building a custom MVCC around
> Git. Each git-push would initialize a new version which is then
> committed as the default post some operations. These operations take
> place after the reference transaction and based on the output status of
> those operations, we want to propagate the status to the user. There
> currently exists no good mechanism to do so.
>
> Having a report hook which allows us to modify the report being
> propagated to the user, allows us to modify the report based on the
> status of our MVCC commit phase.

Personally I think understanding concrete things is easier than
understanding general things. And discussing the concrete case in the
commit message would help with that as well as provide the context for
git-log(1) rather than just the people who have read these emails.

> ---
>  Documentation/githooks.adoc |  23 ++++++
>  builtin/receive-pack.c      |  41 +++++++++++
>  t/meson.build               |   1 +
>  t/t5412-report-hook.sh      | 176 +++++++++++++++++++++++++++++++++++=
+++++++++
>  4 files changed, 241 insertions(+)

Should the git-receive-pack(1) doc be updated to mention that this hook
exists? I don=E2=80=99t understand the setup here. The existing
git-receive-pack(1) doc has sections for these hooks:

=E2=80=A2 `update`
=E2=80=A2 `pre-receive`
=E2=80=A2 `post-receive`
=E2=80=A2 `post-update`

But not these:

=E2=80=A2 `push-to-checkout`
=E2=80=A2 `proc-receive`

(referenced against githooks(5))

>
> diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
> index ed045940d1..7e6643ad89 100644
> --- a/Documentation/githooks.adoc
> +++ b/Documentation/githooks.adoc
> @@ -527,6 +527,29 @@ The exit status of the hook is ignored for any
> state except for the
>  status will cause the transaction to be aborted. The hook will not be
>  called with "aborted" state in that case.
>
> +report
> +~~~~~~
> +
> +This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
> +`git push` and updates reference(s) in its repository. It executes on
> +the remote repository once after all refs have been updated, but befo=
re
> +the status report is sent back to the client.
> +
> +The hook receives the pkt-line encoded status report on standard input

Another naive question (I have never used any of this). Should this link
to some gitprotocol-X(5) after `pkt-line` in order to have a link that
explains what it is? I don=E2=80=99t see any mention of `pkt-line` on
git-receive-pack(1) or a mention of a gitprotocol-X(5).

> +and its standard output replaces the report sent to the client. Any
> +output written to standard error is forwarded to the client over the
> +sideband channel and will appear as `remote:` lines on the client's
> +terminal. To reject individual ref updates, rewrite the corresponding
> +`ok` lines to `ng` lines in the output report (with an explanatory
> +error string) and exit zero; standard error can accompany this to
> +provide a human-readable explanation. A non-zero exit status causes
> +`receive-pack` to die.
> +
> +Note that by the time this hook runs, all ref updates have already be=
en
> +applied to the repository. A non-zero exit causes the client to see t=
he
> +push as failed, but does *not* roll back any ref changes that were
> +already committed server-side.

To my naive eyes this description looks good and without any obvious
errors (typos ;) ).

> +
>  push-to-checkout
>  ~~~~~~~~~~~~~~~~
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>[snip]
> @@ -2592,6 +2630,9 @@ static void report_v2(struct command *commands,
> const char *unpack_status)
>  	}
>  	packet_buf_flush(&buf);
>
> +	if (run_report_hook(&buf))
> +		die("report hook failed");

Okay, it seems typical for this command to use regular strings (not
translated) for errors. Which makes sense given the application. There
does seem to be translated error strings but one example is =E2=80=9Cref=
using to
update current branch=E2=80=9D, which seems to be more of a non-bare, en=
d-user
error than a server error.

> +
>  	if (use_sideband)
>  		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
>  	else
>[snip]
> diff --git a/t/t5412-report-hook.sh b/t/t5412-report-hook.sh
>[snip]
> +test_expect_success "no report hook, push succeeds" '
> +	test_when_finished "rm -rf upstream" &&
> +	test_when_finished "git -C workbench remote remove origin" &&

This teardown routine is common to all the tests. Is it better style
here to write it out compared to using a helper function (test code is
different from =E2=80=9Cnormal=E2=80=9D code)?

> +	git init --bare upstream &&
>[snip]
