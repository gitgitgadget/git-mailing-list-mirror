Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272BA26F478
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 16:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978274; cv=none; b=pvn5XhJXD2AQwdPXHZSwGMS5U2P1dfbALhYMq25X4Im+fMA5ph5Qsl7ImlMqTel+hEJZQ55qm800zpQ4aOqknQ4TCElmaaDTvxtiXKkIi/hmZh9s9KGe18nxl2uSTremVXcZdOmwzoQfi9xDssjBzhhJTfq+vPqwnZeQXX+psTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978274; c=relaxed/simple;
	bh=BS6L//Gzk/AO55gymfDNQ6ihYk1IhlRzMDkC40t0D+M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=M0FvCyl+fmHZdSYpvTIjQLwqz6Jjxgkkc4e7qAopPWLoKFYlCvQNcg3Zfq6lWtAuceFOUPvywLrjrW+ANUgTRYZk5Izxc5Eh+7PEQv4j7txoJG5mQAk2SlgW/H/S8f39wIoXiEjNInYd723LCqNaxAZY2nOu9CB0Q01HiaI/bZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=KHeDvK6a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AayNfTTF; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KHeDvK6a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AayNfTTF"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F0197A011C;
	Mon, 20 Oct 2025 12:37:51 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 20 Oct 2025 12:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760978270;
	 x=1761064670; bh=4N6M3OpJaAf4Dz2nAD7NsWSbJpi/wtwxdf21yozWC+E=; b=
	KHeDvK6agrIrfGRhGO2EW5iBl7xIkwuHYsNfJZtE7wuvPCxmlpjwT0MguzSSApvq
	lEk5OVUeZ2g8ceDk58BPfX9AkJRj9j0gTw1dMp/FNYf/WlCmjv19NfCLV+IjAHZv
	xGp2wnjuLq0+YcmQYFu1BUuRHBEZQiQAqoDxax45CGwllQnxz25IU3fWjTEKw/4k
	GshO3slMX8HfGFznliPLHeHLzVMazsL7PjUCYPPEvzIaYInP+01zoCv62b62ngB0
	M0gSVTQVfBaJPlj0GLJKx5gX56+R237z+Smh6hYBcxOC51dhwDr9/Clu436H9wnS
	0PkT8mzBRlzWsyqY+BX1mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760978270; x=
	1761064670; bh=4N6M3OpJaAf4Dz2nAD7NsWSbJpi/wtwxdf21yozWC+E=; b=A
	ayNfTTFk72BaFdrv0q6ANk8XusDzsOOHI8qBzOxYpuQwbAcBbd8BHocPLNEQXSbK
	MuDU9CVKIvARBCChSv2h0Gbs65+fSt6CPKVri2NrkT0WxQIFY62Kcy9f/oAeBNXn
	4m+qjNJV+HzYlH3w1iLK6auQClcBgE5rTaIoo8ngThVApDQ+8hN8MpKuSJA4t0ey
	+Wb7LUV3B/QW7y8BZs003AAz6u0SXuh+x69qgkg7CRSZ/Y/mtPl2mpM03xfaKqrY
	UgkrP+7fv+OklY5Kli5B6gPHsk8OiCmuuY79pg92sequk8Tx5v4iB44Ppa5onk/c
	fDCx79ozoIrJ/ovV6F+8Q==
X-ME-Sender: <xms:XmX2aIALMxBZQEizHoPQUsi4Ty8eCQcXZ181buR_mFv-mE8w6_BseqQ>
    <xme:XmX2aFW5nzeecDdXuInW8LHTDr6LHVGFBwjAfOG531MYXZ0wDwcasYPoagvHeanNI
    gxJtkB5MB6s8bRwo6f-iTJriZqOa8pxHWEVe6677UJthyJf9Gv-aQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprh
    gtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepphhssehpkhhsrdhi
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XmX2aNHz9OqmnixsEwezGDfwtsGwO57xyx1_4pdM7NF57sUNpIZTRQ>
    <xmx:XmX2aD3ApqVXMnbyL3P405AXneBY39xsJg1Mg3kuZRn-qvYq3CLasw>
    <xmx:XmX2aPNkCKwL5VufGzL45wxdkom_KYi-uotgQXo2-Hr_BTgOBeb2TA>
    <xmx:XmX2aC6nRZgWrj1K90PBf3V9a5XDalCX8I7EMvoZNkPl79VkIu44mQ>
    <xmx:XmX2aJbkLl6Mt_ltDsBXIpHscWPu3jiwAoy1zMvmTCafzbCYnwZ8I9WG>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 65D391EA0062; Mon, 20 Oct 2025 12:37:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Asrm_GTbWIKg
Date: Mon, 20 Oct 2025 18:37:30 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, "Patrick Steinhardt" <ps@pks.im>,
 "Julia Evans" <julia@jvns.ca>
Message-Id: <c1c456b5-aca7-4b24-a4a2-558405214f24@app.fastmail.com>
In-Reply-To: <pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
References: <pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
 <pull.1981.v3.git.1760476346040.gitgitgadget@gmail.com>
Subject: Re: [PATCH v3] doc: add a explanation of Git's data model
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025, at 23:12, Julia Evans via GitGitGadget wrote:
> From: Julia Evans <julia@jvns.ca>
>
> Git very often uses the terms "object", "reference", or "index" in its
> documentation.
>
> However, it's hard to find a clear explanation of these terms and how
> they relate to each other in the documentation. The closest candidates
> currently are:
>[snip]

For some reason I get an error with `Documentation/doc-diff` when run
against 446c8a72 (Merge branch 'je/doc-data-model' into seen,
2025-10-16).  Here I=E2=80=99m comparing with `master`.

    $ ./doc-diff 4253630c6f07a4bdcc9aa62a50e26a4d466219d1 446c8a72be6cf1=
b6121e643590a9acacfc21c5fb
    Previous HEAD position was b20e48e0232 doc: add a explanation of Git=
's data model
    HEAD is now at 446c8a72be6 Merge branch 'je/doc-data-model' into seen
    make: Entering directory '<git repo>/Documentation/tmp-doc-diff/work=
tree'
    install -d -m 755 '<git repo>/Documentation/tmp-doc-diff/installed/4=
46c8a72be6cf1b6121e643590a9acacfc21c5fb+/home/kristoffer/share/man/man3'
    (cd perl/build/man/man3 && tar cf - .) | \
    (cd '<git repo>/Documentation/tmp-doc-diff/installed/446c8a72be6cf1b=
6121e643590a9acacfc21c5fb+/home/kristoffer/share/man/man3' && umask 022 =
&& tar xof -)
    make -C Documentation install-man
    make[1]: Entering directory '<git repo>/Documentation/tmp-doc-diff/w=
orktree/Documentation'
        GEN cmd-list.made
        GEN doc.dep
        GEN asciidoc.conf
        ASCIIDOC git-add.xml
        ASCIIDOC git-config.xml
        ASCIIDOC git-diff-tree.xml
        ASCIIDOC git-fast-import.xml
        ASCIIDOC git-fetch.xml
        ASCIIDOC git-fsck.xml
        ASCIIDOC git-log.xml
        ASCIIDOC git-merge-tree.xml
        ASCIIDOC git-patch-id.xml
        ASCIIDOC git-pull.xml
        ASCIIDOC git-push.xml
        ASCIIDOC git-replay.xml
        ASCIIDOC git-repo.xml
        ASCIIDOC git-rev-list.xml
        ASCIIDOC git-rev-parse.xml
        ASCIIDOC git-shortlog.xml
        ASCIIDOC git-show.xml
        ASCIIDOC git-sparse-checkout.xml
        ASCIIDOC git-stash.xml
        ASCIIDOC git-tag.xml
        ASCIIDOC git-worktree.xml
        ASCIIDOC git.xml
        ASCIIDOC gitformat-loose.xml
        ASCIIDOC gitformat-pack.xml
        ASCIIDOC gitcli.xml
        ASCIIDOC gitcredentials.xml
        XMLTO gitdatamodel.7
        XMLTO git-add.1
        XMLTO git-diff-tree.1
        XMLTO git-fast-import.1
        XMLTO git-fetch.1
        XMLTO git-fsck.1
    xmlto: <git repo>/Documentation/tmp-doc-diff/worktree/Documentation/=
gitdatamodel.xml does not validate (status 3)
    xmlto: Fix document syntax or use --skip-validation option
    <git repo>/Documentation/tmp-doc-diff/worktree/Documentation/gitdata=
model.xml:71: element link: validity error : IDREF attribute linkend ref=
erences an unknown ID "tree"
    <git repo>/Documentation/tmp-doc-diff/worktree/Documentation/gitdata=
model.xml:96: element link: validity error : IDREF attribute linkend ref=
erences an unknown ID "tree"
    <git repo>/Documentation/tmp-doc-diff/worktree/Documentation/gitdata=
model.xml:397: element link: validity error : IDREF attribute linkend re=
ferences an unknown ID "tree"
    Document <git repo>/Documentation/tmp-doc-diff/worktree/Documentatio=
n/gitdatamodel.xml does not validate
    make[1]: *** [Makefile:380: gitdatamodel.7] Error 13
    make[1]: *** Waiting for unfinished jobs....
    make[1]: Leaving directory '<git repo>/Documentation/tmp-doc-diff/wo=
rktree/Documentation'
    make: *** [Makefile:3676: install-man] Error 2
    make: Leaving directory '<git repo>/Documentation/tmp-doc-diff/workt=
ree'

The syntax looks correct.  So I don=E2=80=99t know what is wrong.  `make=
 html`
works *and* makes the link.

At first look it might be to do with the anchor on a definition list but
I tried removing the anchors and expected to get an error for `blob`
next.  But that didn=E2=80=99t happen.

In short I don=E2=80=99t see what is special about `tree`.
