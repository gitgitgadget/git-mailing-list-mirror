Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B214160B8A
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 06:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059987; cv=none; b=AafDHMoQYe35X4fZZhiwYHmTgYCf+qYNt1NOHrah2T5C/HKNMHhlyq+ujWpa6xyizQzu5x7lBkrIlkgAZwZkKBgl0sfz88Aq3zMzjKAnm+UKwTc4IX7OP6Hko+uw407UV617dTT0dnnaRSHAXqjGO7UhiUyVugEtiDZKB+55iMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059987; c=relaxed/simple;
	bh=Ay9eev1JUJB+82twREGdCthYGXvuX2p6XVzEBrD/Yuk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=W6BbamN8qJtQYbRPEfSBfyO3Z6aLGj33zBqXiGyJeWInyNUPCrOFjqmtH2qx4cUzaNsUVBO/7YKCTmyl8bp+8UiQFZIypxPRoOTG66k+22q/ex91kexFKUklKTyf4YX6hdyteLAqaW2WYJv7DmIAJEVi85LKmnrWZQcpuhXluQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rwsh.org; spf=pass smtp.mailfrom=rwsh.org; dkim=pass (2048-bit key) header.d=rwsh.org header.i=@rwsh.org header.b=cLSlEE+y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zw4eKPOX; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rwsh.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rwsh.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rwsh.org header.i=@rwsh.org header.b="cLSlEE+y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zw4eKPOX"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F8B9138017C;
	Wed, 16 Oct 2024 02:26:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 16 Oct 2024 02:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rwsh.org; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1729059983; x=1729146383; bh=Ay9eev1JUJ
	B+82twREGdCthYGXvuX2p6XVzEBrD/Yuk=; b=cLSlEE+yKCmRJZYes5PSQkOOtR
	tmeqjqLQ7p2QJ1oj/8eLTpFebCp+mIe/Rol9vtpiegetuO49NuofBN7Bo9f3ReuN
	A//gtBLwte82kq4JDci174vxXHU9Jz9Wy7b7TTY2VAkw3vXQAMHfJwwifmHdzcG7
	SldC6RLITp5wlQ/0uz0l/GDb9PbSOXT+c6SuFYlB1VizpanNLLCrmaSTv4g9XERK
	VtLt+pafD+8tf0ct0kwwHJlk7PMFkoyDox+8BlLXTfAO69ZXmavvoZ/jUqQHTVEQ
	uV72lJ584443m57pB/dT2v4vk5bS/0coL9W0kTtwQCe2yxZ3/sNlRSuSU9cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729059983; x=1729146383; bh=Ay9eev1JUJB+82twREGdCthYGXvu
	X2p6XVzEBrD/Yuk=; b=Zw4eKPOX1BqD7i/uMshvTQ9K5K+XGZKj92Eu3t6gL3so
	yz3bHqrVmAcMrqMR7idm/6ieBhn12nh+X+nHwjZy+ma7rsXzjAe3Es6SNmGGHrfE
	ynAuWgT3FK4t8F1ND0Ui1KyHkgi7YQ2PdmOgsFVspX/DCW2Jvfek50oEtd2VW176
	EEPSHguX2zE3KWBUvWtCPQR0TozaqgOmUI2XZ5BN60n+n6ErvXeLP4KRaoVtRDvK
	Cnka5m/MDMokJ13KMYd89N7scO6P9OVLENUow+RZog4Q19UrvU1huqgJwoezK7u/
	Mq36q+0PngZiHKi53jqJkukrDKAZRZnv/5UHQe2AJg==
X-ME-Sender: <xms:j1wPZ9XQkK3LXWLM_CS-e5U-IPkKPOBaF4Yb5459xOzjnYDy-mifNA>
    <xme:j1wPZ9lkmoRvsnJvUIxpS6nbYTTV3etemqDxyYmooMGM14aGyF61tXhS_oRRkOLac
    2kx1jh-cx-jiAq17EA>
X-ME-Received: <xmr:j1wPZ5Y-xEmvtJl2nBVEK7pKCcicF_NaKlhPJ5C5e3Zzm321sz8neib1nlJXy2IJY8npDzYkU6ifnLPVFU6fjdNRbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukffogggtgfesthhqfedtredtvdenucfhrhhomhepufgrmhcupfgvfigsohhlugcuoehs
    rghmsehrfihshhdrohhrgheqnecuggftrfgrthhtvghrnhepleejveefleduffekheelge
    duveevfeehgeegleefledtheetteetvdelvddvfedvnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhesrhifshhhrdhorhhgpdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrmhdrnhgvfigsohhlugesghhush
    htohdrtghomh
X-ME-Proxy: <xmx:j1wPZwXW9MNa9t90sHy7GsbbtvNzSPOsEHIjYsAZguLWI8E__Zq0Vg>
    <xmx:j1wPZ3liZ0YmWS8R_lBsMe81zJUzIRU9Hn1C_NGT8caw458oViVUeQ>
    <xmx:j1wPZ9c_8BLZYgfJplGvrtL8VExFOK-jUVQz1TH0jmQ5MR-voq8q1w>
    <xmx:j1wPZxHqd6hR96ME4D_6RQBiseMsyIL7NxcoPwrrJu3GKeacemt1aQ>
    <xmx:j1wPZ8zlxGjMXwggTfdUbxgpbE1jnkJsgxOU12I3RBWj01LCeEX-bJ60>
Feedback-ID: ie52944fa:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 02:26:23 -0400 (EDT)
Date: Wed, 16 Oct 2024 02:26:13 -0400
From: Sam Newbold <sam@rwsh.org>
To: git@vger.kernel.org
Subject: core.hooksPath cannot revert to the default locally
Message-ID: <20241016022613.37813826@scaldcrow>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

=46rom my testing, reading the documentation and hunting through the
source code, it appears that if a system administrator sets the
--system core.hooksPath or a script over which you have limited control
sets the --global core.hooksPath, then there is no way for an
individual repository to configure --local core.hooksPath to get the
default behavior. The naive solution of setting core.hooksPath to be
.git/hooks breaks in the case of worktrees.

I would be happy to code a patch for this if I knew how it should be
configured. Obviously, no local setting for a config variable is meant
to inherit the global or system value. We can go all "set of the null
set" by making the empty string mean "revert to default". We could go
fancy "I know what you really mean" by interpreting ".git/hooks" (or
perhaps any path beginning with ".git") not literally in the case of
worktrees, but as relative to GIT_DIR. Or there could be another
setting set on a local repository to ignore global and system values of
core.hooksPath.

Thank you,
Sam Newbold
