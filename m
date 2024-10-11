Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425711C7B6A
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 04:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728622770; cv=none; b=nR3CkDwcg711DWpvGWbSBH1q2Gt3a/g/X8NTbh2nplqkmS8uJQIgI1nEFCoYeeq7VpIU0bv1m6+FdUlh6tOD/e5B90RzrDEUGTbbSmLKfNma8VBPf3NGEfruaozo2zMCR8p6OnUEHcsvufVT4q0BSBNXr2wvozwLjIsdNwrrGUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728622770; c=relaxed/simple;
	bh=8PfaB0880GrRVti0bXkjO0vfkzgS6gkzOMXJoSbX414=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nJqHUxiVuC6g0IO/9w6B6aJgYN92c90LmM6TE23sPQcZWSNK5lObrD49FenIiqaCDTqyFAy3xKWHdxWgn2O9szhF7iZIx2uvz5wgumWVHgpMC/hp7CBHe4D60wUhgtW8a3gAaG13son11cjJNXOY2bne7zA1sfP2DrxRCAFy0iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=LwfB7Rh3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mE0RTXqE; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="LwfB7Rh3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mE0RTXqE"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2DEFC2540095;
	Fri, 11 Oct 2024 00:59:27 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Fri, 11 Oct 2024 00:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728622767;
	 x=1728709167; bh=CzSzBMavJFL6GLjWhiEMfYMoGUShzhWg09VxxJ64LoQ=; b=
	LwfB7Rh39Yze6/t00yOqo7AYBLBWdGp3V/8oQdU0hY5C6qOXficTK3z+nIkojaPL
	TwqThVzfUlEZsRyQQCC23H5hy2aqozQQUKE4MCAJ5F6AoVJlPuI1IFFAsADZMioV
	oFUDdqp3ks6lncu8v0nhQRKHpePYTCRZns3NY/3Ync/jNKdAYXr2rFWMd9FLURWE
	+2QpN1Cc56ua+9Qmfo7Qg0BXE+qOXHVN7TUo/IXPec6li/ioMncbKVgrcbwSHpM2
	aXNrcS7BZiy1j0mg3FK/mUTxxWV+GT5dKaDeuEx1sR/k9R0awS08xYJQho8x60bD
	nGTBle7EvUYnt2+Rd/b0Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728622767; x=
	1728709167; bh=CzSzBMavJFL6GLjWhiEMfYMoGUShzhWg09VxxJ64LoQ=; b=m
	E0RTXqEHoxqC6efZlGgY0FEqZRmLRtSXzclKPlTKeyNyr4C2Avv5XTvw9UbrC6CI
	Z7NmWUUTx43eQlD2Zb1KzmP6QZf2JLFUiC/GVRzomeiAOEgUhsTBay3y2ftoz4td
	N2hdWsMa/RaY2HHT46uey1qQG58SbaE9An1R0KE+/u+WFxucTjniCifqIvylTyBS
	dgCtf8poXPUbwY1eskGy4U7VAJMwSJymhf9ebK1EeB2dbnlBPnf+eC7xMUoit7iA
	GUD/PJmL4VVbsD4f1vJUxY/YUSswbQH8dGS8AaBObw7w/Sv9KMd6XUN8ixNDuO8k
	tbfRUUQQX1cn7k7nE9XAg==
X-ME-Sender: <xms:rrAIZ4VHcvqDui8lxiUZUjBqAQxy0DdvzMcRaPlhOxfbDLKE1qnaBg>
    <xme:rrAIZ8kNfNt6j6GvT1jasDqmbg18tgU54pMUv-dYIkvobD4AIpRO1cfnR0ibyfETd
    Mie3c_JOFku7HZ5xC4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftfgvsggvtggtrgcuvfhurhhnvghrfdcuoehrsghtsehfrghsthhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepleeikeduieelleelfedtjeefueehvedt
    udfhheegteehieeufefhleffgfdujeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgsthesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtugifhhhithgvfe
    esphhmrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rrAIZ8bM4OIpJoyr0kq-rQgs7f6XTge2t-RJC7eDfsNJyuS8orFYmA>
    <xmx:rrAIZ3WAHFE3Q1wwTMIlU5a9O88gtNxSEomPplgn3iLUNQhvftUqUQ>
    <xmx:rrAIZymUq0KNGHTWAOMrAm7QevXZFv0-8GqqrpAFvy2aXs-HHhtREg>
    <xmx:rrAIZ8eH3S7wMCDuwsbqvHHDehvjiBzNhuAitTKpn7nJOPDkCCJM6A>
    <xmx:r7AIZ2tFtX9DsPtEddWCkjCiwwMtIavOuzmv2IJFUBqtP7xDg4SeeJBm>
Feedback-ID: i445c46d3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BEF692220071; Fri, 11 Oct 2024 00:59:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Oct 2024 21:59:06 -0700
From: "Rebecca Turner" <rbt@fastmail.com>
To: "Caleb White" <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Message-Id: <444a412d-bf4c-4bbe-8250-18d8bc86fd21@app.fastmail.com>
In-Reply-To: <D4SO70M9Z1QI.1AC4QF9ZG8T4L@pm.me>
References: <D4SO70M9Z1QI.1AC4QF9ZG8T4L@pm.me>
Subject: Re: `git worktree list` when bare repository is named `.git`
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> The actual bare repository can be the directory, in a .git directory,
> or in any other directory (as long as it has a .git file that points
> to the actual bare repository). The directory will still be considered=
 a
> bare repository.

Perhaps your example got scrambled, but I can't quite reproduce it:

$ mkdir -p repo/.bare
$ cd repo/.bare
$ git init --bare
Initialized empty Git repository in /private/tmp/repo/.bare/
$ git worktree list
/private/tmp/repo/.bare  (bare)
$ cd ..
$ git worktree list
fatal: not a git repository (or any of the parent directories): .git
$ echo 'gitdir: .bare' >.git
$ git worktree list
/private/tmp/repo/.bare  (bare)

It seems like the $GIT_DIR is shown in the worktree list here, and when =
I add
a `.git` file pointing to `.bare` manually, that doesn't get listed. (Wh=
ich I
suppose makes sense, because it's not a `git-worktree(1)` worktree, but =
still
seems a little bit odd?)

> For the purposes of `git worktree list`, the `.git` suffix **should no=
t** be
> shown. You should never try to use `git worktree list` to get the actu=
al path
> of the repository, the docs give the following warning:
>
>     See gitrepository-layout[5] for more information. The rule of thum=
b is do
>     not make any assumption about whether a path belongs to $GIT_DIR or
>     $GIT_COMMON_DIR when you need to directly access something inside =
$GIT_DIR.
>     Use git rev-parse --git-path to get the final path.

I understood this note to be talking about paths _within_ the `$GIT_DIR`=
 or
`$GIT_COMMON_DIR` itself; I see no reason why `git worktree list` wouldn=
't list
a bare repository _consistently_ as either the `$GIT_DIR` or the parent =
of the
`$GIT_DIR`.

What I'd like to do is get the path of the worktree so that I can move i=
t. `git
worktree list` gives me this information _except_ for bare repositories =
in
directories named `.git`. I'm happy to have a special case for this, but=
 I'd
like to understand the principle here.

Maybe I'm just not supposed to name a bare repository `.git`? The
`gitrepository-layout(5)` page does seem to imply this is mutually exclu=
sive
with bare repositories:

> A Git repository comes in two different flavours:
>
> =E2=80=A2    a .git directory at the root of the working tree;
>
> =E2=80=A2    a <project>.git directory that is a bare repository (i.e.=
 without its
>      own working tree), that is typically used for exchanging historie=
s with
>      others by pushing into it and fetching from it.

Thanks for your help!
