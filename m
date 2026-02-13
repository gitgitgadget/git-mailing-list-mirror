Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871AA1A38F9
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771003838; cv=none; b=A02wmkQziSov39H+bnymYxeQgShKDEkRCt4yTjGam2+DGBTZzAV1o3nDiHplggi1aJcjHT4XT02JgTKv1sJCF8hQIdIZgNOz8uwKaRCiPlDsSCSUPjHrRny3COFoFUnHj1A5JfqbhN+JxMhOiudZPDqKVGFh31OYMEaznR8KLag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771003838; c=relaxed/simple;
	bh=Q0IQ5/iD5St/oC9sNNf0KR52fovcQ/NJgnZk7cNWzfk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=vGRvg0b9qe5eQacLdZfMXvDb7D/koairWKOidttG+yPUuCJjqhBBQWjibRgtiiAxGLKGKYEV4v+qd1266QTSVqD+9NiIwqdfGpyyIiqD/9LfhOkGMJNf2Ojoseo3enwr1OeMJoxxTy18rdYEF/oFjnPzgtaoCViUQ8tGkyRtE0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=EtiNSNQf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mOoWkBpX; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="EtiNSNQf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mOoWkBpX"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C8E821400040;
	Fri, 13 Feb 2026 12:30:35 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Fri, 13 Feb 2026 12:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771003835;
	 x=1771090235; bh=Qjpxuw9XanaKB3ReRx/kkz6rGGbY8V7j78k/ffM0w3o=; b=
	EtiNSNQfvam+JaIZz9jGeXaqNy0UrZf+/5OLay2yIb0aUx7xTwycnmxcHeWqASX0
	fIMRaPaSWwxL/IduBobIeA9fV49QGpzeuAfmB8MNAZjg6LUUN9UbmVbGt0W1T0d7
	1Mq+P2qCTpa357pn1HHjKwLB6PNLjoHTeAx/7DI5bPQDxUtiNkGRrc3lB4wGSPD/
	rQDXGlvNERGtfF8Dae/qkuut+eEIb8A6RDMWU2zgrMvTucd9gY4j5ICyzjMANEdx
	qZK8DiBb5z3WhjGBjl0qpVGMyOUZvpS3NQiDdQopooaTWp6/7uN3o/8bNLYGZVBz
	DY+Y0rMmBCornWGMaNFE0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771003835; x=
	1771090235; bh=Qjpxuw9XanaKB3ReRx/kkz6rGGbY8V7j78k/ffM0w3o=; b=m
	OoWkBpXLLUd0LDMo8/0YcfCYVXGEZhYeo5ORitHo+mG51EUR8+k3d8h9HgEi8uxw
	5kPESIavIyEZhoqxf5UswjFNNY23zxX2OewzfAfbLwT14+xy5PjQoiEXXYx/MHeY
	4xmuGihSw7ZUbSxBQt/61kmJyB22Yg+Uo7MsKdFYBh/9ayAkiq0qabN0ybu53Cqe
	snkHHOG0F3Td6kYeIVTMDD8MUsMhromano11FBDenpCfQJggsn7kR9H5+e8RjGbq
	V2w6dgT2haBz2+qhE+vBPNml+u9y7hcHXNE618SCjbA0I/ZYQwJze6OLMfwyvDMO
	annMUSPIZB6fh4NEc18Aw==
X-ME-Sender: <xms:u1-PaRD7oFnifC1FLmb-1GEwobDIR5reDl3Rg2z2aI5vzLTgdK5cdGM>
    <xme:u1-PaaUZavnToVpUWekRUrPkHTDs8-EbTjZKqQrxppPApv2dsNb4M6LQEdWnwYu8H
    6aLEIyn2dO3EWzsee0uQV6xMgUFy7FXhrRxIAsb5h30BR27N0Fbyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:u1-PabqH8CA_dmuCAtgj5TDM6tDeMdXNOFqvrlfnyx3glQd4F4QtxA>
    <xmx:u1-PaTf08mQcMOYiR-ce4kQ-P0rNLgwaTti8ew7JQPlRbZCCWSpvnQ>
    <xmx:u1-PaSqb0MQEeU8hSEam1s4mZXDqXLGb69sVfo5WPdKvi5CwcJy8sQ>
    <xmx:u1-PacEaiP2adSMj4dkieYV5OkAPcuG-h42RnbGPnWBjW_3PJg1KbQ>
    <xmx:u1-PaZP8EPtG05mkEl8vbCxc4wzNDR8xBHplIk_POWneGwyQ23EXwB3r>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9ADEF1EA006B; Fri, 13 Feb 2026 12:30:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1Ljo1cD_StZ
Date: Fri, 13 Feb 2026 18:30:10 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Message-Id: <315801b6-bc9e-42b4-8356-12fd8b83223c@app.fastmail.com>
In-Reply-To: <20260213-b4-pks-history-dry-run-v2-3-756ac376e9e5@pks.im>
References: <20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im>
 <20260213-b4-pks-history-dry-run-v2-3-756ac376e9e5@pks.im>
Subject: Re: [PATCH v2 3/5] builtin/history: replace "--ref-action=print" with
 "--dry-run"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026, at 10:12, Patrick Steinhardt wrote:
> The git-history(1) command has the ability to perform a dry-run
> that will not end up modifying any references. Instead, we'll only pri=
nt
> any ref updates that would happen as a consequence of performing the
> operation.
>
> This mode is somewhat hidden though behind the "--ref-action=3Dprint"
> option. This command line option has its origin in git-replay(1), where
> it's probably an okayish interface as this command is sitting more on
> the plumbing side of tools. But git-history(1) is a user-facing tool,
> and this way of achieving a dry-run is way too technical and thus not
> very discoverable.

It makes sense to use this command as a dry run and then pass the output
on to git-update-ref(1) for the wet run.

    git history --dry-run ... | git update-ref --stdin

Looks good.

>
> Besides usability issues, it also has another issue: the dry-run mode
> will always operate as if the user wanted to rewrite all branches. But
> in fact, the user also has the option to only update the HEAD referenc=
e,
> and they might want to perform a dry-run of such an operation, too. We
> could of course introduce "--ref-actoin=3Dprint-head", but that would

s/--ref-actoin/--ref-action/

> become even less ergonomic.
>
> Replace "--ref-action=3Dprint" with a new "--dry-run" toggle. This new
> toggle works with both "--ref-action=3D{head,branches}" and is way more
> discoverable.
>
> Add a test to verify that both "--ref-action=3D" values behave as
> expected.
>
> This patch is best viewed with "--ignore-space-change".
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>[snip]
> +`--ref-action=3D(branches|head)`::
>  	Control which references will be updated by the command, if any. With
>  	`branches`, all local branches that point to commits which are
>  	descendants of the original commit will be rewritten. With `head`, o=
nly
> -	the current `HEAD` reference will be rewritten. With `print`, all
> -	updates as they would be performed with `branches` are printed in a
> -	format that can be consumed by linkgit:git-update-ref[1].
> +	the current `HEAD` reference will be rewritten.

`HEAD` is mentioned here because it could be detached `HEAD`. So you
can=E2=80=99t just say the current branch.

=E2=80=9Cthe current `HEAD` reference=E2=80=9D seems a bit much. Is this=
 less precise?

     only `HEAD` is rewritten.

>
>  GIT
>  ---
>[snip]
