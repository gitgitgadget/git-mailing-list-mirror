Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E0E4E73A0
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556119; cv=none; b=JPHO8Lmhq4/LGoPQFnQ4FqoWeOGLQV6VM4J1S3noc4qa6OjdkZwTkXagg2ht/sWgIklnyNPLbUfF6BK6+APvZqCtCeBsuMq1f6wog8xwdL3apLo2Ywk0y4doJKTNPx7s0Tcz0oZPw539av9wRoXAlf7dMYFB1zeUOrPxey1aXyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556119; c=relaxed/simple;
	bh=CW4DlNiYPh+Ars/MIELyuuJoFmzLq8N4iSsjWql8yjM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Y/crFJC7fi53CiDBLw8v2TC0+uZEg8YWkMaWnTzU247JzZZKHdgglbkjnVcjkwzqJZp91AWH1fk0tnJJhRVsCZq6JSSaTIhj+BN3/J8GuqUqnhK9Dpj7WSjtgjhCSXvti6B27yaOJ0kxFGoD4K7OhWQF0C9cAM+UsaqrsgmEL4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=SLJO/aYH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aV8Hv3Xe; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="SLJO/aYH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aV8Hv3Xe"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C277A14000FF
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 10:28:36 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Fri, 09 Oct 2026 10:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791556114;
	 x=1791642514; bh=5pDv6NWCPGB7qy7C5rv0xjPiboj6s+8uCZrjnLqD/nM=; b=
	SLJO/aYH3glIR//k0+JOidSyVEi3/Z5fvSOkNifX35l6dxA64CQbv4fjQjfkd5aM
	TX/8EdYvFsIKwLF5TA5Efn/2PwZAYtMYbzXkcKsLsZYhiiDQrhFNIgYjRy+cDVuN
	/ocgRJwBzv6QH20tU0tj0bXr+8CoSKIYm3tooWUv7MZbJbpIbA5lvhip8trA93yu
	V07O9bqB0qIQDXY3zOASTJxDjefTo2JqcP+EXZ3+Qy2WG7N0fAb0Veb7eX7CfGN/
	tvg+b00j3pJJ03mDmIMDDezYNYqFgDZ9yB6Cdn+8lhhJUbIY96+DHW2a/nXdICrm
	FxxmPODpdT/sEp/sCvAKmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791556114; x=
	1791642514; bh=5pDv6NWCPGB7qy7C5rv0xjPiboj6s+8uCZrjnLqD/nM=; b=a
	V8Hv3XevDD4Hl7C76t3jkc9boWR3ipPOvqBULVW9lnk3D2zQJxGF9dbdG/6vJz3v
	L4NUq9mOxPnji8FRR+6U2D0XtBAV2xt7kcgKZ5Tu29SLHox86IfYn8sb2njQ6kJE
	rUS/CeszEUA6p6Lfr6vx1jz/BeHg0XOSa26owp/QPKDjFWnwefqYSUBwyK+4exwv
	cQP+3LGer0eeBjjenpkz4zVanQ1fo1E9p45vZ+9Xfsr4fEe378RflU1CeQoQtASU
	D+qhiauCwgQGwTE3+j9Cxwu4qhlDo48eScBH9DzJ4QrjtM+42IdMUsWSgIhOAWyA
	vqzObIUhUEMcLdpeXNgig==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791556114; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:XWf3hqMyjZOY+ur88Yj2cSfhLSZxdditI+BMJFs7zKMQYvp
	EAi1Fk6eCWyVZ6UlJUYns72nQ7G5mgIE4zu8K5xTBeoZ/upv+owSM8tsmK1VRAHV
	Hw0bxI5ecW6BCt9R0S7yA+x2IiyJeoEDhnfKM/7YsFpi+RDH5IQTCQw4NGHLS1b1
	uBhbMPnqPHcutGfGIPAyZgvIsho6EzTiDsL807qVmaOdsReHP7pzvm4eMh4R86SL
	B7N10UFHzhcOTawVLykYdlCTUx28Qvveisznpfn23YLRzbI3C0gqhWPgEsXqit9R
	BfxWhxBZ7HIRAa3CB6sOAJozbnlnxa4nDUhQC+g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:L1DPo5mdC6egWAYTPAqWb1moDnxFyw3icq/1F3gdcl8=:CW4DlNiYPh+Ars/MIELyuuJoFmzLq8N4iSsjWql8yjM=;
X-ME-Sender: <xms:D_rIaohuZLZLS6pSm-h2Qh5TQXcE3oA7PA-VR-xyXoQpacOOiAcC6lE>
    <xme:D_rIar0TAJXcckbpvaRauZrDa0EULxV3F37t_QTP1BfuAQs3yahMM3Pjr2PMMEF0-
    l0iuYQeuJFA2dSWsKNaS3l4C8hKsvn87BNVZMJnVif6hS4CdtSE77A>
X-ME-Proxy-Cause: dmFkZTEV97T6NKLkBxnjfLsmOtgLr3RZDLi1SXYh8irtUwYPRzFAUkNkcH2DxPSuUMxh4L
    RNX5MpA67Mcu+zm4LtcaplnosUYXN9ajcm+NW7WG+k1O4gDE8bpha0z74T4qgJ1PecqbQu
    rKN2TtWg507t09d3bkJgR6a+DcixUbHb1SeVbBdpkLhRbnZIsTVoHh0uGSHba9Xrtji6e+
    FDxyBSxoP89ytFXQwB49ZW/4rfjfpFQfD7GKWJ/UskerF3jF89mbEXpMZZHAmTQjIxqaDW
    JMstMPvtq+InOEVHg8wZ1W7uw2BEV62y73FJocVgGAisAtM7bOcrt82LTygoLgjjeO3iAx
    DIDS2maKGwf4tblFPGZ1noBPmCJYjvEIrMc0g/wIRxMu+o+WiJxAij4IuqLlTMBzAfVm4H
    FjY8DiyeTroBqAc7TqF+yAsOJhGDXVtavcmiekoVdmTgbJedoG5lufFNLoFwfOb1Pln325
    Xef+SAC1WmnUia0YjKiiXde30WgxGfTv65bR0rV1haeGDlKl8swkvFMe8TAROJOfeHaGEv
    5E5OOcsAO4e0KvrZkD0QED7GeUBH4/yQJn2CzDAYkQqXioUIdZpZwSLsMW52fWl4ofMyTY
    xzMF5lnXKEq6sJ7Xz4F0GLS3xPcTTfznOm5lAV4fd0Lusj21QixFhqgebZQg
X-ME-Proxy: <xmx:EPrIahmmUT21PAGtmN9DH_Xf9zwZDQZxVKYZHf0lDn4E-mlQ1Rdjuw>
    <xmx:EPrIauVYq8lZKsjDuViABEnaXsJQhYDH9Bt4TUwYWv2qx7LQPpcv4g>
    <xmx:EPrIantUBI660beWhYsUu3fW6lYGYQwRu3vu01AERf2CKIkoICPcmw>
    <xmx:EPrIahbUHusdJmHPbclSEWYpBmH7vYELk-MgBCE9LsLoPK8lYYzqYA>
    <xmx:EvrIat5APtG_clj7ieN80G4capbBkI6X034-btIdrLzu50dVtXE_tMHc>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 9550422C0098; Fri,  9 Oct 2026 10:28:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Akcdmtpgqgjk
Date: Fri, 09 Oct 2026 16:28:11 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org, "The GitGitGitGitGadget" <gitgitgadget@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>, "Julia Evans" <julia@jvns.ca>
Message-Id: <3e26cf00-ce81-486a-a6a6-720d22b8f118@app.fastmail.com>
In-Reply-To: <pull.2249.v2.git.1791551486318.gitgitgadget@gmail.com>
References: <pull.2249.git.1791291762665.gitgitgadget@gmail.com>
 <pull.2249.v2.git.1791551486318.gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] status: suggest `git merge --continue`, not `git commit`
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026, at 15:11, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
>
> During a merge conflict, we suggest using --continue to continue the
> merge for rebase, revert, and cherry-pick.
>
> Change the `git merge` advice to be consistent.
> Commit 367ff694281ce569edd8f6e444fc770f92f5d215 says that
>[snip]
> Signed-off-by: Julia Evans <julia@jvns.ca>
>[snip]
>     Changes in v2:
>
>      * Use git show -s --format=3Dreference to format the reference in=
 the
>        commit message (thanks to Phillip)

But this isn=E2=80=99t changed?

You can use this `commit --amend` snippet to change it. It worked for me
at least.

    cat >rewrite-msg.sh <<-\EOF
    #!/bin/sh

    file=3D"$1"
    git format-rev --stdin-mode=3Dtext --format=3Dreference <"$file" \
        | par g0 \
        | sponge "$file"
    EOF
    chmod +x rewrite-msg.sh
    GIT_EDITOR=3D./rewrite-msg.sh git commit --amend


>      * change to "conclude the merge" (thanks to Phillip)
>
>[snip]
