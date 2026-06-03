Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9C030148A
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513497; cv=none; b=LWL616mSYqvu9mAkrc8fh3xlABAm5deymZgPzJwBCDRG3xHsjQWGUjROE6VbnZ3MODd86M71gwQKorNxrX/OPEp6mYJxWlLRjhgXIo4p2MFDFteCTBayvl6ZXTdK4DGCKgbJUFxtet8os6EIdSmI/Is+1lo2I3ohO2w3fiJhzWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513497; c=relaxed/simple;
	bh=mwDfPAHpkukAhEuCBcpna3Q/lKLtRPRigQZd3K0RtwU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IdPHdKH9abLh0adY4SCnprt6CANt/vLTqkq6x13klYozWt8csFaIVN82ud+F/1ymb1Vbdu3kJli1jud5gMfu9W8hxpgYd7ErH0JDHBlzPNTQMFYZjh4ZqSpNDUirFVcsibyIwP1Abil04uIwvoqTon6JFmmXHpuwXMmi3b4VkM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VLeRXPRu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T6GI3c6/; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VLeRXPRu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T6GI3c6/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F2837A007A;
	Wed,  3 Jun 2026 15:04:54 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 03 Jun 2026 15:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780513494;
	 x=1780599894; bh=xbSg/ODAfAghtfSY28ID5p/D67Xt79A8+fDWlzM9p60=; b=
	VLeRXPRu1T/is8ck1jjeiZJGRwqeAyBzaJ8FRkkNQyEkSxXmVhaG+7/xGWGgmKUk
	/himSX5DXyoVR2IiuK/9YtY8ptOlP9L8oolv9pmeqMqnP1T4+M90ljGW15EqmeL/
	RFeTDsYpLhDuUWJ9KTN/hjv4Tl3NFPnU4ZZ6eygv505oznqNzLHxFoa+zvZzPUGH
	WEqvq8Wh11ujSO0UDyG3shDt/MGwc8JbAIIsL9EVz42AhxNDRAL40768E+ROF1bo
	6DcCG1wbHYvyTAvMqmbklBfM2Cnx0wdvDIBr09oYunPrhRb3YVopbeIzV6vBCmkZ
	qGsweKUSoAPz1nH2Pcvofg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780513494; x=
	1780599894; bh=xbSg/ODAfAghtfSY28ID5p/D67Xt79A8+fDWlzM9p60=; b=T
	6GI3c6/Fl2SkS20NJXH2wYMgln4QwGfu1ME0UDBnmSLZnm/cDD/YIoZaE98cF9gR
	vA3Bxu/GDRapQF38QZH0wthE5Go8XUJCk90epobyIp2tRVrrvPsWkLjvejB9nTQl
	/uPag2Q9dpvk2S3rHQc/2JbvYYZ5FbCNAQWSies+8c++w+cydacVXX558V6wROpZ
	7ellshqq6AhZ5Hcug3LC6eU6PREsriQuzbSQz8CJbVT2DS/mXsORdx33/Zi4Paoh
	K8Qw/ZS7VIB7LPvG5XKg+KrVJnZGYMfXGDZZ+8wE4y74WVhNkTor71WkzpE5qntM
	HYkhmkcW+hZdpYWKDn5Og==
X-ME-Sender: <xms:1nogav_bV-CfDQ8qSgc7rTH5iRwsAZRXnBpDFoXY6RuCGA0He9QJeSU>
    <xme:1nogamiZskHDUAVwSkLlWTM2OMIYfK3tKt1h2Z6s6KE_7FhVpxRWSYosN1KVdxRVf
    WKvmxYjWa9hp_1Nc_V5g7JXch6iaMXNQIDOv1pVjzBq4Wi5u1eG8g>
X-ME-Proxy-Cause: dmFkZTFd4mb1ZPxXDSLZ/shT1s/d0PCzzQBJOlh3p2AG/JFwpaoE9r5+UdQd+3cPVLFcDc
    NR8VNO5PVtripPGnqkI3sHlgYvHzVxdH9a2Wl2IwDu9N545ICCscg28rS95jbSadLPUmNI
    UrHqqDSvAE9tgcyIEASaqPTOMIUPOrcVw9DSX8TMCOIpSgoKFKyqBQ14XKJ8CXRajYbW2C
    Vjj7wROBepkkXAQV/atobn3sIoKUTvXvELgCDlrWXoZCP7R4UZNpIm2boK/UrvjRP3kaIU
    y20B8zUmgr5A2HlPM80rF4PvdrI78CucjpSPvhpzI9G2WNCZEF/66qVBJ6Cbi5B9tJ6ftq
    jRvDTwdxmFkd2rYlkDaEAZ/UpfbXfTHJwFKb74aV/2+moqalnqwOt9EgKs1b1k9tKLtbQi
    dghUgRU/7adZzrTL9nzj36OApeYT3l4ANr1N20kqIxEDfYL9DfAtuXDs5GWiODw/ATZDEO
    tzCRUuaWmq3loKfRgiaUpRG/oTi99uJl8UIYMKEgWqjEvtwL9JfFtMkqNl58rAybGHeV9x
    Qifx3FvQPAvEOsFBI+T4tIydeS440eoqapMhLVal0p72hC3uPVPdbWRGEc38zRV98AgjxP
    VdflF3jbwYDcRcJ3jDNP6hsp6gshBHG3S4T+pHz+mw78t7cZfs6wQE7mbjZg
X-ME-Proxy: <xmx:1nogajmz0rBtHWwYa1EbueBaTfc8VgBCPdQLmVxXnTSflrfFFd1iGw>
    <xmx:1nogakqTZxbTzw83i3ahJIF4Gct9Cr9xVCHLtw5gl6rR3EGoiSIV5w>
    <xmx:1nogakFo5zl8HtRoJFrl72-uLTGW6dSOEGQ0_GXrJxCMcfIEnmQvyQ>
    <xmx:1nogaowXtFcdBFAqRVxb3wIH8SpoR-WI1TRqrs416yVSfWOOzSyhlw>
    <xmx:1nogam4iD1UM0qwWh45YLzxL0tO94Nipii7jkX8ogBP0VI9XHi7IdDpR>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 047033020096; Wed,  3 Jun 2026 15:04:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AY_hQymev1gw
Date: Wed, 03 Jun 2026 21:04:33 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Pablo Sabater" <pabloosabaterr@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <4b4672de-17cc-426f-8498-6384b1ad0d06@app.fastmail.com>
In-Reply-To: <20260603-b4-pks-history-drop-v2-9-742cb5b5176d@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
 <20260603-b4-pks-history-drop-v2-9-742cb5b5176d@pks.im>
Subject: Re: [PATCH v2 9/9] builtin/history: implement "drop" subcommand
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026, at 18:14, Patrick Steinhardt wrote:
>[snip]
> ---
>  Documentation/git-history.adoc |  38 ++-
>  builtin/history.c              | 187 +++++++++++++++
>  t/meson.build                  |   1 +
>  t/t3454-history-drop.sh        | 513 ++++++++++++++++++++++++++++++++=
+++++++++
>  4 files changed, 738 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-history.adoc
> b/Documentation/git-history.adoc
> index 2ba8121795..4eac732fd2 100644
> --- a/Documentation/git-history.adoc
> +++ b/Documentation/git-history.adoc
> @@ -8,6 +8,7 @@ git-history - EXPERIMENTAL: Rewrite history
>  SYNOPSIS
>  --------
>  [synopsis]
> +git history drop <commit> [--dry-run] [--update-refs=3D(branches|head=
)]
> [--empty=3D(drop|keep|abort)]
>  git history fixup <commit> [--dry-run] [--update-refs=3D(branches|hea=
d)]
> [--reedit-message] [--empty=3D(drop|keep|abort)]
>  git history reword <commit> [--dry-run] [--update-refs=3D(branches|he=
ad)]
>  git history split <commit> [--dry-run] [--update-refs=3D(branches|hea=
d)]
> [--] [<pathspec>...]
> @@ -51,13 +52,28 @@ be stateful operations. The limitation can be
> lifted once (if) Git learns about
>  first-class conflicts.
>
>  When using `fixup` with `--empty=3Ddrop`, dropping the root commit is=
 not yet
> -supported.
> +supported. Likewise, `drop` cannot remove the root commit or a merge =
commit.
>
>  COMMANDS
>  --------
>
>  The following commands are available to rewrite history in different =
ways:
>
> +`drop <commit>`::
> +	Remove the specified commit from the history. All descendants of the
> +	commit are replayed directly onto its parent.
> ++
> +The root commit cannot be dropped as that may lead to edge cases wher=
e refs
> +end up with no commits anymore. Merge commits cannot be dropped eithe=
r; see
> +LIMITATIONS.

Should section names be =E2=80=9Cbare=E2=80=9D or quoted like "LIMITATIO=
NS"?
I don=E2=80=99t know.

Maybe add =E2=80=9Cabove=E2=80=9D since it=E2=80=99s a previous section.

> ++
> +If `HEAD` points at a commit that is to be rewritten, the index and w=
orking
>[snip]
> +Drop a commit
> +~~~~~~~~~~~~~
> +
> +----------
> +$ git log --oneline
> +abc1234 (HEAD -> main) third
> +def5678 second
> +ghi9012 first
> +
> +$ git history drop def5678

I know this is only the most simple example. And I might be dragging in
something beyond the scope of this example. But I recall one
demonstration on the first git-history(1) series which used a lot of
revision expressions and someone saying that they couldn=E2=80=99t imagi=
ne a
workflow where this would be more interactive than bringing up the
git-rebase(1) todo editor.

(I couldn=E2=80=99t find back to this right now.)

Although it is slower in terms of machine cycles, the keyboard instinct
for dropping a nearby commit might be to do `git rebase -i @~10`
(sufficiently high number) and navigating quickly in the configured
editor, deleting the line or using the keybind for `drop`. This example
which by implication brings up the log in order to paste the abbreviated
hash isn=E2=80=99t as ergonomic in comparison.

But using a revision expression like searching the subject with
`main^{/second}`, while not quicker probably, does distinguish itself
from git-rebase(1) by being a pretty fast ad hoc invocation that can be
done in one command without futzing with some weird sed(1) editor in
order to navigate to the `second` line and deleting it, or
something. And that=E2=80=99s a small win in isolation, but it segues mu=
ch more
naturally into letting you script, say, dropping the last commit that
starts with the subject `TEMP`.

Or maybe revision expressions is too much in this context?

> +
> +$ git log --oneline
>[snip]
> diff --git a/t/t3454-history-drop.sh b/t/t3454-history-drop.sh
> new file mode 100755
> index 0000000000..37d8413e7e
> --- /dev/null
> +++ b/t/t3454-history-drop.sh
> @@ -0,0 +1,513 @@
> +#!/bin/sh
> +
> +test_description=3D'tests for git-history drop subcommand'
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-log-graph.sh"
> +
> +expect_graph () {
> +	cat >expect &&
> +	lib_test_cmp_graph --format=3D%s "$@"
> +}
> +
> +expect_log () {
> +	git log --format=3D"%s" "$@" >actual &&
> +	cat >expect &&
> +	test_cmp expect actual
> +}
> +
> +test_expect_success 'errors on missing commit argument' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit initial &&
> +		test_must_fail git history drop 2>err &&
> +		test_grep "command expects a single revision" err

Why not `test_cmp` since it=E2=80=99s a fixed error?

Same for a few other tests like `errors on unknown revision`.

> +	)
> +'
>[snip]
> +test_expect_success 'errors with invalid --empty=3D value' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	test_commit -C repo initial &&
> +	test_commit -C repo second &&
> +	test_must_fail git -C repo history drop --empty=3Dbogus HEAD 2>err &&
> +	test_grep "unrecognized.*--empty.*bogus" err
> +'

Style related I guess. Most tests here use a subshell but this one uses
`git -C`? Why is that?

>[snip]
> +test_expect_success 'updates branches on other lines of descent' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit base &&
> +		test_commit target &&
> +		git branch theirs &&
> +		test_commit ours &&
> +		git switch theirs &&
> +		test_commit theirs &&
> +
> +		expect_graph --branches <<-\EOF &&
> +		* theirs
> +		| * ours
> +		|/
> +		* target
> +		* base
> +		EOF

Oh, `expect_graph` is a cool tool.

> +
> +		git history drop target &&
> +
> +		expect_graph --branches <<-\EOF
> +		* ours
> +		| * theirs
> +		|/
> +		* base
> +		EOF
> +	)
> +'
>[snip]
