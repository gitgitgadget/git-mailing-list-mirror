Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB624206E
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724625; cv=none; b=M+cXhx62gTbQ7DVCMAKqqLj+KNWn4hyVy/e2Sy3oR230E1Gdxsk57yvfCOWAxsi5n9ajPo56VH480g+x9tj7uwPAAu+uR/xiograsxpWY8XGpbtFSGtKL2vs+6En+4w4fUF7cHovWcyKbTu85P///mZxQoCcb71HjYzjr66s5WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724625; c=relaxed/simple;
	bh=2K6+mdqyU9mdJxyNyGH/GGYSDgcSkvtaaiCr8ZVB/YI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bTW90Cui3CVRSuZ22Zw7Al4gw2PUvhvYhkQyVw96TImKiFEVoljpsHj6z7gt/+PTX2NG6hoFVaWO5zY1tnr/+8ROynnySXn2GWZmXNlspaucphkCKZq9AxOv+NRaAUmIzaX2gHHsGL7uDi8l1D/RbmALrjgi6TA6MM3Pvo+o2dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D+7P0ZGI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zh278nuI; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D+7P0ZGI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zh278nuI"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id BFD8F1380868;
	Mon, 30 Sep 2024 15:30:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 30 Sep 2024 15:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727724622; x=1727811022; bh=w7B6PaImDc
	nh33qN5wfZ3obFWnPNBpGN5hRAshqw+c8=; b=D+7P0ZGI9l8oW4buus6JsRWnKd
	/wHJl1uz9s5sOqzvGT/32uG5oDEXmc7TAiPDMHKXKhKKzllYuafXkxwyZO+50++I
	dGHS1F4MrL3lD5qZUVqwiZmVXjCqW6w0NrWPqM2Mpaaqo9BgCNc0HpWQo/h6+pA9
	KboSzjzRog3dw0P9tzA0K3T8XlUFLr61QuQwKUY18SG1z/mymjg7L/S+3flx5Rlk
	5sWL22l5TXrx/O93NvOnWv+YT2xcjHJcRkl7GYpVghimB0Xbxoug+h0KwBNgBz0F
	I+zTyNQwz7/3CYPv7PeXM1kx1KXbRCUubF6j3/JP/IjrGtynFUAl+a+bf9Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727724622; x=1727811022; bh=w7B6PaImDcnh33qN5wfZ3obFWnPN
	BpGN5hRAshqw+c8=; b=Zh278nuIbtAfNbAmp6IArsHB0cxaNSEKPa27aW6Q8WLq
	K9z0QXxHUIEWDXZWNXSKbWXFknK1g9jtKBWX6cXE6WskpRjZZmOsd068eaE+m+kM
	5IFfnEUu5XzrNCaOchxzJ39zz/wwFJo5vUJwI6NQhba3a9dh79IKWVVq0Eee358+
	ClC/GWrrE/40TX09o+TE7efP5+IvnlSfIrm6ufOVLp6PP7fOEbGTMqXkli4DuOCk
	RycdPFvmaPV+LxAbfB+q62QK5dohBMZqYgoXg9vhPOgryposUZ+VF1yR5dOQsqtx
	M3EiZ5kG546lhtJYRYfoXb5Z7+Bx7s6NtPBFVvq89Q==
X-ME-Sender: <xms:Tvz6Zqc7x-k-Fm2-XgkK7XhOD0jVyhy3F9YVv6q9MIn782vqCXUpqQ>
    <xme:Tvz6ZkOMVqFcxtIlTf58Bspz5p-hZzCVFYonMKs_bhcf3jh-zeq0cLXEJCG0NMDzl
    EapE_JPSnlOunuJMg>
X-ME-Received: <xmr:Tvz6ZrhCAtPBcG-8fOzgGiDoMKWlnMGy8nWLlExboIF-Aav2r6C1cvxcbuWW0bK8rWPON3hpS1v_W4pHmP36LnaMrtP72JQiOEWYz6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Tvz6Zn8kazaOKoAWpH_DOVdfffnrtb1cQ5hHY0o5OfdDe9D3z1rziA>
    <xmx:Tvz6ZmtowHFuhMCvwanwwTjD2QAYfHsdCHn-XreIbk_78mLo46ocoA>
    <xmx:Tvz6ZuEzR9qZ3soUwmugsxG5hFjlnQHZ2JW7mmVlXa3ghJWY1Oc8BA>
    <xmx:Tvz6ZlPO9kwlxKfHF7UWYr-nGtkXq1C48mhArKajLUusoPAqd20qMA>
    <xmx:Tvz6ZqLUk4AgjGHD4IxVsVbPIUfg3P8jcIx1KRQ783ESe3rncziZ5Kwq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 15:30:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: Linking topic merges to mailing list threads
In-Reply-To: <CAJoAoZ=4ARuH3aHGe5yC_Xcnou_c396q_ZienYPY7YnEzZcyEg@mail.gmail.com>
	(Emily Shaffer's message of "Mon, 30 Sep 2024 09:21:11 -0700")
References: <CAJoAoZ=4ARuH3aHGe5yC_Xcnou_c396q_ZienYPY7YnEzZcyEg@mail.gmail.com>
Date: Mon, 30 Sep 2024 12:30:21 -0700
Message-ID: <xmqqv7yd548i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Emily Shaffer <nasamuffin@google.com> writes:

> We've been wanting to gather metrics on Git's code review process -
> how long it takes from first contact on list to merge, how many
> iterations are needed, time between iterations, etc. One missing link
> is the actual merge time in `next` and `master` - a human can infer
> the link between the patch and the mailing list thread, but it's more
> challenging for a script to do it.
>
> Would it be possible to modify the maintainer workflow ...

I suspect that there is no need for any workflow change, as all the
necessary information should be available from public sources.

The first-parent chain from 'next' (or 'master' for that matter)
already record when they got merged.  From there, C^1..C^2 are
the commit objects that were merged.  notes/amlog knows where
they came from (i.e. their Message-Id).  From lore/public-inbox
you can find out how the iterations of topics went, as long as
the topics are threaded properly (and if not, that would not be
fixable with any maintainer workflow changes), just like how b4 can
figure all of that out.

Ahh, nothing officially documents amlog and that is what you are
missing.  It would be very nice if somebody, preferrably somebody
other than I, after trying the "maintainer workflow" by pretending
to be a maintainer for a day or two with the new info revealed here,
updates the Documentation/howto/maintain-git.txt file with the
information below.

The script post-appplypatch found in the todo branch is made
available as .git/hooks/post-applypatch so that "git am" knows to
run it after creating a commit out of an e-mailed patch.  It
populates a mapping from commit object name to "Message-Id" of
individual patch.

"git rebase" knows how to propagate this across rebases because
I have

    [notes] rewriteref = refs/notes/amlog

in the .git/config (which means I have to use rebase not cherry-pick
even when I am touching a single patch, as cherry-pick does not
preserve notes by design).

Now I think you should have everything, together with what is
already in Documentation/howto/maintain-git.txt, piece them together
to illustrate the life of a patch series.

As I do not publish reflog for 'seen', you cannot do "when was the
topic got picked up to 'seen'?", but as far as I am concerned, it is
by design.  Being in 'seen' does not mean anything other than I
happened to have seen it, or saw that somebody indicate interest in
it.

Thanks.
