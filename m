Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC217798F
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727733268; cv=none; b=C4nz0rG3Cm0dzM3d6JYNhkoqNVhF6DC7kJCfVrjfsTgG6SPXxsZU1XchLTdebXalT+q2D8ITxaLKWCMGR4U8D+n79ajs4BZbMxGd3hHW51oZzSH/MFPZbsidHyLrFSFV3saD9+MDqwF6E4Q6kxjQm6ekgVhhT7IWQno/piqIn5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727733268; c=relaxed/simple;
	bh=TLUHxlQmAKAUUxjD2bKLk55ox+itn0Rne087mpff+EI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eaZbxkAeuzUmLE7TiUd8vX/CzmKTKN2dFEO9ensABD4gKJZLjlelCur2K/haPnmpkmTnxAwcTInIc2Vf8JAWqeprnLYjjhNoyeR9bBJqkrVJRZ/H924m9IS420OucRCV9jYeMAi6JBa/vI9q/4f8Vh8r9HVTHBrebnrGrR+/pnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=v2L5rlVq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nINu8wvX; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="v2L5rlVq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nINu8wvX"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3843B138093B;
	Mon, 30 Sep 2024 17:54:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 30 Sep 2024 17:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727733265; x=1727819665; bh=awgjApRndY
	1eQHB4b+54VBQgmQPjrz4t+zO8KAn6B4A=; b=v2L5rlVqpjABSVjxxwlZ5ZgPEW
	Bf2o5aM7FtE7nVtw3USahbdWF4QKP3MVDV95M7rZb9jtjWDX3wLqTn+P90gPfOK6
	adPypSFSXrMYN0Vbvq0bUk60CmOGE0NyH1vtXOOr2awxxC4Gwdfc3Tre6xjVkGzP
	4f0EBvFdwlsKQHmuwQMGAip33dQVG54LXLAlxNMIXk4RF/GTGP9AxH0jhfMC49pu
	OLWhdEhMvR4Y16ZYRGdifwvQRNh1JTKhG/JP5h2hNSHzn+RGJ4JWXoYO+HYU0q2Y
	bNWRb3KRjhZvXyRPy9QorPwUttmm9hfS/86lP2LUbpICJuakcuy0sPpgTqng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727733265; x=1727819665; bh=awgjApRndY1eQHB4b+54VBQgmQPj
	rz4t+zO8KAn6B4A=; b=nINu8wvXhZoO6aNtcmKo3SzS7Vih2IdAJitQawnuII8M
	TD7LsDYgRTxo6Og5jW01o476+l44PMEzH7yVSldfYdsL6eQMis5h3UN/kc5Ic45C
	HNZj005hViqBbb5bgPji9cW+E+f3086Wci3dCTxNu4qBh5jvGD7jwHiXcj+tiH5b
	IyCYPsh20UhFiXn3BDoBPETC5aOc2oNF0mxK6+LNNd2uSmVjq00lJV4r8OWc60dZ
	E6uev9LoEFIhaFgjBG6+zNxDswi0MmmiVHaku4TetCqdRnmSK9Xu9E420VHUcRjO
	8ni6AN74bczeXPNOfp6iBNJ2Bd1pRXTXqBT/2iBUXQ==
X-ME-Sender: <xms:EB77ZiisUOIyrdmm0bqMYY6HRazfLxXX2Cp1sgeqnNTFQlJgs-X-LA>
    <xme:EB77ZjBZ24NJG815I1zCy75AOMyRsfLgySQE65tvRVO2SJzsvdkQk060661vHv283
    HHwsLI6GDs2P1Kwvg>
X-ME-Received: <xmr:EB77ZqFxJgbxItSn6y5fd3DebWZvGeLlcRGUQOk6ZTEZACghU3zQBJ1yKN2stM7ETR_2OxqtnH75eDaCb3G3dtv2GwnFY8OLrYJ5Gek>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduiedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepveellefhgfdugfetgfeuteegvdffvefgveet
    gfetheegkefhfeeuveeigffhgeeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephe
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkohhnshht
    rghnthhinheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ER77ZrRzxMvCiwCewwX7NLyWyVJAfQ8Kl92Uj4XG62G5jax7QfDVpA>
    <xmx:ER77Zvy_zEDkbFmO2IH_2V_UL5EGDgRniy4pEtDpXcaLV9DgDi5ALA>
    <xmx:ER77Zp7C4JAiHvHE9eXoYKOsBl2Hphxax_f3oKk1OCQdr91hukhxbg>
    <xmx:ER77Zsxi0n7bIFy5Fkn1fJDBFn5hR-D0yqYJTYcshaemSnrXqi4rNQ>
    <xmx:ER77ZqrWk0cFjXdXlGnQdTQ80rwA3-A2RUBxJ775ez-3yNSWZ57edM9E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 17:54:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Konstantin
 Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH] Documentation: mention the amlog in howto/maintain-git.txt
In-Reply-To: <a4b1da93e16d88323181f8f8444f01d96e09ef45.1727729100.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 30 Sep 2024 16:45:14 -0400")
References: <xmqqv7yd548i.fsf@gitster.g>
	<a4b1da93e16d88323181f8f8444f01d96e09ef45.1727729100.git.me@ttaylorr.com>
Date: Mon, 30 Sep 2024 14:54:23 -0700
Message-ID: <xmqq8qv84xkg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Part of the maintainer's job is to keep up-to-date and publish the
> 'amlog' which stores a mapping between a patch's 'Message-Id' e-mail
> header and the commit generated by applying said patch.
>
> But our Documentation/howto/maintain-git.txt does not mention the amlog,
> or the scripts which exist to help the maintainer keep the amlog
> up-to-date.
>
> (This bit me during the first integration round I did as interim
> maintainer[1] involved a lot of manual clean-up. More recently it has
> come up as part of a research effort to better understand a patch's
> lifecycle on the list[2].)
>
> Address this gap by briefly documenting the existence and purpose of the
> 'post-applypatch' hook in maintaining the amlog entries.
>
> [1]: https://lore.kernel.org/git/Y19dnb2M+yObnftj@nand.local/
> [2]: https://lore.kernel.org/git/CAJoAoZ=4ARuH3aHGe5yC_Xcnou_c396q_ZienYPY7YnEzZcyEg@mail.gmail.com/
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/howto/maintain-git.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

This addition to the procedure part of the documentation reads good.

We'd need a matching addition to "The Policy" part, to describe the
motivation separately.  The procedure exists only to realize what
the policy gives, and we need something to back up the expectation
"to update refs/notes/amlog" (i.e. because there is this policy).

Existig "policy" entries are only about how integration branches are
maintained and used, but notes/amlog are solely about the individual
patches, so we'd need an entirely new section there, I guess.

While at it, I notice that there is no mention on where these notes
are published (the configuration you added to the text is solely
about the local repository the maintainer uses).

I just added this change

 [remote "github2"]
         url = https://github.com/git/git
         fetch = +refs/heads/*:refs/remotes/github2/*
         pushurl = github.com:git/git.git
         push = refs/heads/maint:refs/heads/maint
         push = refs/heads/master:refs/heads/master
         push = refs/heads/next:refs/heads/next
         push = +refs/heads/seen:refs/heads/seen
+        push = +refs/notes/amlog

to github.com/git/git/ and other publishing repositories.  My
broken-out repository github.com/gitster/git/ have been pushed
with the mirror mode, so there needs no change, but others like
k.org repositories will start seeing this additional ref when I push
out today's integration results.

The "policy" part of the change may read like the following.

Thanks.

 Documentation/howto/maintain-git.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git c/Documentation/howto/maintain-git.txt w/Documentation/howto/maintain-git.txt
index da31332f11..9b72d435e6 100644
--- c/Documentation/howto/maintain-git.txt
+++ w/Documentation/howto/maintain-git.txt
@@ -35,6 +35,14 @@ The maintainer's Git time is spent on three activities.
 The Policy
 ----------
 
+Because most of the lines of code in Git are written by individual
+contributors, and contributions come in the form of e-mailed patches
+published on the mailing list, the project maintains a mapping from
+individual commits to the Message-Id of the e-mail that resulted in
+the commit, to help tracking the origin of the changes.  The notes
+in "refs/notes/amlog" are used for this purpose, and are published
+along with the broken-out branches to the maintainer's repository.
+
 The policy on Integration is informally mentioned in "A Note
 from the maintainer" message, which is periodically posted to
 the mailing list after each feature release is made:
