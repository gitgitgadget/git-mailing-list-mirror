Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9121C5D7C
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678403; cv=none; b=PN4sbzAAwCrARPlSeo3xTDQGA3t0ESPK9uh29lnyw+SJp5rPoDUZUL692tsjypkBlrqVUTPSrtcRBG+J6CwqoNe47u4AvbSM86eRmAUKiWGh3sZF/yEXkVRwa9xFwS/Rkx9xynSQ0djXT+YIEy6Y2QXGy25nqmwrARXNEu7r1iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678403; c=relaxed/simple;
	bh=viw+l0sO/2gdDhbuMdC9XwP06jdgyp00Q9pdqjrP20E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pr4VeqO50nRY0ihDVf8iFxVyFes3auPu8tuAMm/9FL5GGqREWJYcUv+JX1Ia9uKBQPa4tvtk5R0+OFUs0dJBacU0aLg7N7dYtTlk/hyBE0KJTTZpIbEOOlkjFUnJ9lNZtj6v9jUH53tVPqUjz18BaN7bAaBWiBl+84yBOWOfQas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K35D1s5l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1sq/lLDv; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K35D1s5l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1sq/lLDv"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id CB02213833E1;
	Thu, 27 Feb 2025 12:46:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 27 Feb 2025 12:46:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1740678400; x=1740764800; bh=oHZPKP3qHXZe2qN42DoNNEvWsQ6AdnvB
	/ZHPrf4QLHs=; b=K35D1s5lruXgXI3wcpjTwxzj4BXO5AmIyqrQ2T7BA0RTro5O
	BUvkpbSwRHzCazGsj6CEGEnzvaSJ+c6RFtPCoGYMdbmf+YmFG2wmJU23xnF4bPpx
	qsVw1uwJMpI7TGYN9n/wMOyQKlERmZZr2jSQBYVlEmMS2R/fkr1jGi8OIGMn3xWH
	yRIea+XY2sccTEVwGwmofWx6+nEUVMg9AWia4aFJHIdhv/5vyiWTxJ/tL6NNlltD
	rdJkwqNs63asBmU3bNUb0zfAqQLCjZo+876gEAKazgp2FdvyLKfGnGl816hLa8Nc
	J2XFtbHRX80gqeCvQGawV4E4zW9IexEIBLOZxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740678400; x=
	1740764800; bh=oHZPKP3qHXZe2qN42DoNNEvWsQ6AdnvB/ZHPrf4QLHs=; b=1
	sq/lLDv73/YiAQnqcaIppGoJtnx4MZZ3IzS9NVCbhRTVLAHqobe6CoqU8AwKgjy2
	nBQmxFsdVw3R7QpytadnM73ttRPtBzpwRBQy4lxn93JtZD7lAeoRuLLrHMEO05Qo
	jVQCpGYMuc0h6flSo/WoAtv0XN3Bw8eGGVW54oHWd8OQfVyjxl8ukMRFaRY81sfW
	tFdsVI+QNLRfm+zXs3DnB1zVYJmdtBjTkmNDnHifxnRmgysrDbSMRdITUe8hwz5E
	GEd5CKSQl8zSBDEj0koGfaSsQkOSvn3Z6XjFPOJsADhLRg5zOp+vcgpithX8J8xu
	msD/BFTJjsqP69p7E0L2g==
X-ME-Sender: <xms:AKXAZzi4LkX1iZNa0QAoSIgi4UYu5yJo37wYdK19dHlUQmPY_a1BYA>
    <xme:AKXAZwDc_Bn4Ix2fgjCMBmHwb8A_u6eFzeExYw6rn9ZIQKRmaLh1NYdjQzNsCFKXE
    g2AX1-y6WlF3yqoqQ>
X-ME-Received: <xmr:AKXAZzEEsgWUB0gd0hCpXBa_mJ4044383YiY7tyFBu-bYbtWUAofpY_5vHc7RvIgzjjpbgMgIZkn8HHCHaQH3EboyJ3HidW8ZRD3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefhefhffegtdehueefueduffefffekgeegffek
    heettdevgeekkeeuhedttdfgheenucffohhmrghinhepthigthdrhhgvlhhpnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhes
    phhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    vghvrhgrihhphhhilhhiphhpvggslhgrihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprhhjuhhsthhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AKXAZwQ7n_yS08jUJr2TQ5PhqSBM6YRyqImQinirk0U5W41k42cVUQ>
    <xmx:AKXAZwx9xbpH2254UEud0mBcwf05X7OReY1iSbnyQ-METfcyG_BoVA>
    <xmx:AKXAZ26iZSRr3pD1RQbBRJSQIRCjqSbIDcDzB2lpSG9eq0aw6eMPTw>
    <xmx:AKXAZ1yOOmO1N5HoQjzA5TqgYNmlQy6QQCCXPn7M5ZEEhz-nHbOVUA>
    <xmx:AKXAZ_r85Hxr6KjEJtZCOgBK0CFSW4DIRRuQlIud96ZHm41wywSVz0Zp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 12:46:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
    Patrick Steinhardt <ps@pks.im>
Subject: gripe: bash completion broken for 'diff' from outside working tree
Date: Thu, 27 Feb 2025 09:46:38 -0800
Message-ID: <xmqqldtr8em9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I chose to CC those who have commits in our tree in the last year
among those who touched contrib/completion/git-completion.bash in
the past 3 years, hoping that they are much much more clueful than
I am in this script.

Let's say I have a checkout of our source files in $HOME/w/git.git
and have a few files modified:

    $ cd $HOME/w/git.git
    $ git diff --name-status
    M       COPYING
    M       Makefile

Going one level up, and trying to run various common commands shows
differing level of completion support.

    $ cd $HOME/w/
    $ ls git.git/CO<TAB>
    CODE_OF_CONDUCT.md  COPYING
    $ git -C git.git add CO<TAB>	# completes to 'COPYING'

This completes to COPYING even though CO is *not* a unique prefix
(as seen in the completion of "ls"), simply because the other
tracked file has no modification and there is no point in adding it.
The completion of "add" seems even nicer.  See.

    $ >git.git/CONTRIBUTING
    $ git -C git.git add CO<TAB>
    CONTRIBUTING  COPYING

It notices that an untracked file CONTRIBUTING could be added, so
includes it in the candidates.  I guess __git_complete_index_file
that is called at the end of _git_add is what has the whole smart
to do this?

"git status" is equally nice.

    $ git -C git.git status CO<TAB>
    CODE_OF_CONDUCT.md  CONTRIBUTING   COPYING

And It is benefiting from the same __git_complete_index_file at the
end of _git_status, I think.

But "git diff" is not.  Among these three commands, this is the one
I most often use (so expect to behave the best).

    $ git -C git.git diff CO<TAB>	# nothing.

A cursory look of __git_complete_revlist_file tells me that it does
not do anything special on the pathspec on the command line.  It
calls __git_complete_refs so it may be aware of other branches, to
wit:

    $ git -C git.git diff ne<TAB>	# completes to 'next'.

but does not care anything about the files.

When you are in the working tree, I think it is helped by the "list
of files relative to the cwd" default completion behaviour kicking
in (i.e. I get the same completion as "ls CO<TAB>").

    $ cd git.git && git diff CO<TAB>
    CODE_OF_CONDUCT.md  CONTRIBUTING   COPYING

I think this behaviour is serviceable; some may argue that omitting
CONTRIBUTING (which is not tracked yet) and CODE_OF_CONDUCT.md
(which has no changes) and directly completing to COPYING would be
nicer, but the users who want to run "git diff" want to know which
paths have modifications, which in turn means they do not know that
CODE_OF_CONDUCT.md has no changes, and may not even know that they
have not yet added CONTRIBUTING yet.  So I am inclined to say that
it is perfectly OK not to omit them.  On the other hand, if it is
easier to find paths out of the index, I am also fine if they are
omitted.

But outside the working tree with the "git -C <go-there> diff",
behaviour is even worse than the behaviour we get from the falling
back to the default.  It is completly broken, since the directory
listing the default behaviour chooses from is from the current
directory and not from the working tree specified by the "-C"
option.

I find this frustration at least twice a day, every day, when I have
do "git -C Meta diff whats-cooking.txt".

Help?
