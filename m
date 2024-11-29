Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0970B14D428
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732912144; cv=none; b=tq2tbXPGKzXxmvRb5n5mhXIcUreHpeeo0OKMCE1c46kEsgnhOpVV+8KGNQhXzImCoi6l7gTveTxKXkzAfuq2Y8hjjiXRW+BSMM68BzUqfXSXY3f3KzkhEWqfgztV+yxQryljh/58DIGnsFkW9Vs37lp9PAT7q0hCPNSFAR8UsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732912144; c=relaxed/simple;
	bh=7CKydbuLquZZAmOVYwYCpQ9/TKebTva0z5JCCjrlZrc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=I+EJ4eKQKnVttXvKETHSvPPlft9nW9rXO0ZtJbu0S1Mpvbw2mdXDxP2g1muOTCbUuPlgTxeh9y7FpKSAIU2+FPHcszKEZJjOwESCAsNK5I8JWJBhRRvwF+0WyD4Z9e3jDBbecCOXWwFvObgisCzD6UbYnLxiOwbQT7lKSFaA9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Jh1RGs0C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AzZsTnFr; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Jh1RGs0C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AzZsTnFr"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 06EB6138015F;
	Fri, 29 Nov 2024 15:29:01 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Fri, 29 Nov 2024 15:29:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732912141;
	 x=1732998541; bh=QzmJ7B5EL5+1X0li6BrSJp3Rsc7THtwxHLWoYQJNmDU=; b=
	Jh1RGs0CE5pe+19jOPV+6q3gHz6uiFJPohUTE23MJNGLu3cTnnftpkUwcEjjCxgn
	ZMVWaCzYDTXHoOaY5s672wR+5SVGg0PSQ4lrRGKTXPdHfiCQ3cAYiOgao4MBLyKJ
	EC1jEo7GRpuwmHzI/uiS71SZHiIDcit228aDjVNvf5lUUK/HniR1bOuzX3SRNyh6
	lDmpas+d5HfJ9nuI7iNTQXYWHiBA2edV9tSQ2+8ylCQ4RU00VObdHOs3drifr3/T
	UM5htqncN9k3ZooJjXo9afRSaEV45QK9SXO8leUh/n1J5E64k9cixb3HsRz98JMY
	onbE9abGAgq/4IBhxlShEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1732912141; x=1732998541; bh=Q
	zmJ7B5EL5+1X0li6BrSJp3Rsc7THtwxHLWoYQJNmDU=; b=AzZsTnFri8VSL8kHC
	cZgIGNnB6x2iOMPWaU/xMCqdUrW+XWLh4Z+yvMict0glLlys/QFOdhdJEl+gk8Uk
	T+svaCh/nIsEnDJZZZEUxlz6RvqQ4obBSWCF6wWL/vZFDXxF1ctJWZaebAFjOf6K
	X9e5V+AMVMrIQr35A6+nQKCuPd//bVzsTISMo6vWwpyBt4D8maJdouii9F9zhQo5
	0amL47X/5UT8WhrlOvb5bpC2kIygjaDp5PDJoC8T/YeFWx0F8A6NBBq6wesmY1Pa
	ZByzzQIYwPaYY+uLRoeu67fOMz8nBkle1w6RZGC3NO8l9BBV7lUrRHhj19GY3owf
	FHMNg==
X-ME-Sender: <xms:DCRKZ3nDGev008RsrdScNRxxf-y7AfVDnqn-og274Rh-Kgff-ei8KlU>
    <xme:DCRKZ60MGanY4W5Od1doX_cEkHWZjI1AXxUzhQflHpfOHQGIzjDVOvxmv7NR7Xvie
    nEdqrXFw2XHj7babw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheefgddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
    ucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrght
    thgvrhhnpeffieeftefgheekgeeitedujefgveehvdevieelfeeiiedttedtgfduhfejie
    fggfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrhhishhmrghnsehsuhhsvgdruggvpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DCRKZ9or6i1AV9n_I2kP-nve96CizfjBdmBpy0ctoec8CpqLPBwawA>
    <xmx:DCRKZ_nz9a13J91-tmJ04Qdvnmrllb-YncMKl_n3a7u9_gkrjpsiig>
    <xmx:DCRKZ11buh6k7ELoujykMngQfN213W2gK7JovHpxVGokeVXyxZobAw>
    <xmx:DCRKZ-sQEeQIjtMSw7RK8mZVrAc-LHrkUedcT5-ItSkCU0HN-PxacA>
    <xmx:DCRKZ28lkDQabnmy_RcaIhA67kRtHgI094gQrnG4GcNNB-FlBPULozaI>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6BDCC780068; Fri, 29 Nov 2024 15:29:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 29 Nov 2024 21:26:33 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Gabriel Krisman Bertazi" <krisman@suse.de>, git@vger.kernel.org
Message-Id: <2ffaeffe-1f05-4100-8ee8-3c87437297bd@app.fastmail.com>
In-Reply-To: <87jzclal3s.fsf@mailhost.krisman.be>
References: <87jzclal3s.fsf@mailhost.krisman.be>
Subject: Re: [BUG] Inconsistent output of git-show
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Nov 29, 2024, at 20:36, Gabriel Krisman Bertazi wrote:
> Hi,
>
> 1.  git show --oneline --no-patch
> 7af08b57bcb9 (HEAD, origin/master, linus/master) Merge tag 'trace-v6.1=
3-2' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
>
> 2.  git show --oneline --no-patch | cat 7af08b57bcb9 Merge tag 'trace-=
v6.13-2' of  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-t=
race
>
> (--oneline doesn't matter here. Just making the output concise)
>
> The branch information in parenthesis vanished just because of the she=
ll
> redirection.  That makes quickly writing shell one-liners very annoyin=
g.

The narrow fix (of course your point is more general):

    git show --no-patch --oneline --decorate=3Dshort | cat

Or set that with `log.decorate` (the default is `auto`, hence this
isatty behavior).

> Sure, I can go figure a proper git invocation to get me that
> information. But we're all hardwired to use basic shell commands, and
> sometimes all I need is a quick grep and not learn a program-specific
> way of filtering.

As a list lurker I get the impression that the proper way is to use
plumbing commands for scripting.[1]  That=E2=80=99s the philosophy at le=
ast.
In practice I=E2=80=99m not that good at that:

=E2=80=A2 git-log: replace with git-rev-list
=E2=80=A2 git-diff: replace with git-diff-tree
=E2=80=A2 git-merge: replace with git-merge-tree
=E2=80=A2 git-commit: replace with git-commit-tree

But I=E2=80=99m far from good enough with all the various tools in the s=
uite.
So a git-show here and there will be used.  By me at least.

I also get the impression that this philosophy hasn=E2=80=99t necessaril=
y worked
out in practice, at least not culturally.

The resources on the Web are also not great for this purpose.  Because
when I search for Git Plumbing I don=E2=80=99t find scripting resources;=
 I find
a bunch of articles about How To Implement Git With Plumbing.  As if the
tools were meant to make Git In A Weekend.  That and a handful of
StackOverflow answers that say =E2=80=9Cwell these bunch of commands mar=
ked
=E2=80=9Cplumbing=E2=80=9D exist.=E2=80=9D

Turning to the documentation I haven=E2=80=99t (in my casual experience)=
 seen
much connection being made between the porcelain and the plumbing.
There are some hints in git-rev-list like

    rev-list is an essential Git command, since it provides the ability =
to
    build and traverse commit ancestry graphs. For this reason, it has a=
 lot
    of different options that enable it to be used by commands as differ=
ent
    as git bisect and git repack.

It seems natural to start a script with porcelain commands.  Then rewrite
it in terms of plumbing commands as it matures from a one-off script to
something you just want to call and not fiddle/evolve any further.  But =
in
ten years I haven=E2=80=99t naturally stumbled upon such a guide (I=E2=80=
=99ve only been
somewhat actively looking lately).

Just my two cents.

> So, could we make the output consistent regardless of redirection,
> i.e. What You See Is What You Pipe?  Whoever requires a specific format
> for a script should be the ones using --format.
>
> I've got v2.47.0 and I admit to not have tested later versions.
>
> Thanks,
>
> --
> Gabriel Krisman Bertazi

=E2=80=A0 1: See (from a quick search):

    https://lore.kernel.org/git/xmqqy16ematj.fsf@gitster.g/

    > The other question is why advice is being shown in the first place=
. In
    > theory, all one should ever use in scripted usecases are plumbing =
tools.
    > And as plumbing tools are explicitly not designed for users, they =
should
    > never show advice in the first place. I guess chances are high tho=
ugh
    > that the scripts in question used porcelain. That is also understa=
ndable
    > though: our plumbing tools are often not as powerful as the porcel=
ain
    > ones, which has been lamented on the mailing list several times.

    From: https://lore.kernel.org/git/ZsbYYo3pLUAmBU0e@tanuki/

    > The usual answer is "these tools should be using the low-level
    > plumbing commands like diff-files, diff-index, and diff-tree", so I
    > am not worried about it too much myself, and the above is purely t=
he
    > devil's advocate comment.

    From: https://lore.kernel.org/git/xmqqedcszhty.fsf@gitster.g/

--=20
Kristoffer Haugsbakk
