Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FC41DED43
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781538; cv=none; b=WZr0KBljCG2lV13rXOKDq78R4hsiT76p8u51xGfT1UWScxJTBRtEzOcv2mpXo25IBy3uOazdEApIaeUsAnt56+tcIIvUkSZg8+C0BPplOq2h5fNC4U22Jj/Q69JHp84PcAFTscP+sTNF2VKyGlKF7hEM7QZO3sBdUUWMGuGUD18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781538; c=relaxed/simple;
	bh=7HskRK5s0N4Q72OxgFwTZXQb8G6aETsCwhWVdzfXdI4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ETgjoD8fr+olhVFZJqKdwErgMj7Ln/PkruweiYzJLwB/yduCXktbXBTVYTE3cb1iPa+d+DJ65FXFv2qG94L8QvBWW6ozt47Su8TybneI5rSpE1Oon6WStf0a6vYrTCzWysHXH15cPOX+xfiyAmUG8fTQneVSxrgfES5tOfUrNBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MGV0Yslm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GVQwfRuw; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MGV0Yslm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GVQwfRuw"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id AA38F114014F;
	Fri, 28 Feb 2025 17:25:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 28 Feb 2025 17:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740781535; x=1740867935; bh=iKoIN9vINA
	xIkAKSZQMxqcRBHrS9Pf1kW9TwY65V0ao=; b=MGV0YslmnyMBIoz++5kZf+zCyW
	BahdfCNxF6hnS0rZ2+v4qrhqwohApEHccaIaN9KatgueFu6ny42sZSbqI2nN2neQ
	sYwARTtcntyvWHyw5M95L/AUwtN5cYMV/J9JxbRcy/4+EOos342Mgb0xKlcKDUFb
	pg6R8FUMXsw6jaIcdOkC7ZFZTOAIViRwlvmjPezHr9JvTQ09neYfdywNvuIFms4/
	j4xkofe0WIPiPKPtE9SrnKnw9Zo2tC65h/kmGS2euvV0/JU5ouAxcPR6j/FxfwR0
	WZ/3UlNLOKGQDU10depiGJCzWyrNrtnLGorVqt7zhGjxC7wjBR5gvluQm88g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740781535; x=1740867935; bh=iKoIN9vINAxIkAKSZQMxqcRBHrS9Pf1kW9T
	wY65V0ao=; b=GVQwfRuwl/PGCE6cBi4Tty9at7I6F0S+Bx9tMM2l6DV4pGxtTWH
	SFcy/w34410HXiHafDJ1MGFeWZG7dummPV2wlPANtXlf1onQ3I2X1K/qZZpHbJE4
	0PXH9sUGxZlhU4vs2c1K5zX/C5971uHp4pM9U0rkhBIk/S6dPVGqu+gEjYKXS7Mj
	JMGDyd1dSmhTgqbIPzWnrJC/S+6bv9ttz5Von5+GSnBSfKgUJt4MihJOPBCR0LMF
	lrnuC47rMci+zArkmbkfEdVJ+XeB8fRQWry6yRzAUc1ZdY4E8DImBA2NSDLDOJhk
	5JACjkp7msAjfqMkkd7ntM/cf7fav6XU+ug==
X-ME-Sender: <xms:3zfCZ24FjCJtbI_Q_1NzyssgfsuIUXCNQX3SJDT8wFOsVwBNWuoQfQ>
    <xme:3zfCZ_4_3S89aq6_SnLMD-Jl6JVf0cQyHpDVjLpQ1Z4V2Wfw8U7Zp5aR3rBf5GbZC
    2ZevhVOp7Vs0e6OqA>
X-ME-Received: <xmr:3zfCZ1fLOmLSWgCO58BvK-YsR-ZPSZVJZSJkDapdp6Hzt67Xs9tggk4ACM7rxJ1U82Ja465FjKk48wbYhmtm00PxpPJDnVCuncCF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeludehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefhke
    duhefhlefgfffhgfeguefgfeektdegvdfgffdvvdegkeejfeelvdfhuddufeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgpdhgihhtqdhstghmrdgtohhmpdhgihhthhhusgdrtg
    homhdpghhithhfohhrfihinhguohifshdrohhrghdptghonhhtrhhisghuthhinhhgrdhm
    ugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3zfCZzIq0ND559DwsmAHiOfHKOpShPfBkcKo4Oy7w9Nbn5lJJunJaw>
    <xmx:3zfCZ6Kn5mwSJ1jpc_dkRzkRyjX1_bhflK6cWJqFcbnvnTI6LdKkow>
    <xmx:3zfCZ0yIDx8NULY0agKvZW6nzA-TTN6qrOJeZjB9Z8h2JXnwesLkNw>
    <xmx:3zfCZ-Lhvi6Fwy0ZyzVJx3w1cIJxbFOw4sQR2Fh2wBIfGfL48FeN-g>
    <xmx:3zfCZxVHDuErariVpBTY93EskgWUfvR9cFNOtQGwfj6t-uW_2VpBWNpk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 17:25:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [RFH] Issues and Contributions to friendly third-party projects
In-Reply-To: <xmqqcyfdhp0t.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	19 Feb 2025 08:34:26 -0800")
References: <xmqqcyfdhp0t.fsf@gitster.g>
Date: Fri, 28 Feb 2025 14:25:33 -0800
Message-ID: <xmqqwmd91zc2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> After seeing a issue report on git-scm.com (and remembering number
> of issues reported on friendly third-party projects on this list
> and getting redirected to elsewhere), it may probably make sense to
> document who they are, what they do, and how to contact them, in the
> same document that drove these contributors to this list in the
> first place.
>
> I am still not sure which of our document is the best place to do
> so, but no matter where it eventually goes, it would be better to
> first agree on 
>
>  - if doing so is a good idea to begin with (such a list in a
>    document will incur maintenance cost)
>
>  - who to include on such a list (the list will become useless if it
>    includes everything on earth that claims to be related to Git;
>    where do we draw the line?)
>
>  - how the list will be maintained (are we responsible to ping them?
>    will they update us to keep their entry from going stale?)
>
> As a discussion starter, here is what I added to the source to "A
> note from the maintainer" message I send out every once in a while
> (https://lore.kernel.org/git/xmqqr05a5wjv.fsf@gitster.g/ is the last
> one I sent out).
>
> Comments?  Corrections?  Opinions?
>
> Thanks.


Around here, no news is a bad news.  I'll rescind this update and
the next edition of maintainer's notes (planned to be sent out in
the middle of next month) will not list these updates.

>  MaintNotes | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/MaintNotes b/MaintNotes
> index 743e3b6..ebda282 100644
> --- a/MaintNotes
> +++ b/MaintNotes
> @@ -29,6 +29,13 @@ As an anti-spam measure, the mailing list software rejects messages
>  that are not text/plain and drops them on the floor.  If you are a
>  GMail user, you'd want to make sure "Plain text mode" is checked.
>  
> +The mailing list, while welcoming non code contributions like bug
> +reports, mostly discusses updating contents of the source tree to the
> +(core) Git software, including documentation "git help" gives.
> +Non-code contributions may have places other than the mailing list
> +that are more preferrable.  See the "other places" section near the
> +end.
> +
>  Before sending patches, please read Documentation/SubmittingPatches
>  and Documentation/CodingGuidelines to familiarize yourself with the
>  project convention.
> @@ -293,3 +300,36 @@ own authoritative repository and maintainers:
>  When sending proposed updates and fixes to these parts of the system,
>  please base your patches on these trees, not git.git (the former two
>  even have different directory structures).
> +
> +
> +* Other places.
> +
> +As the Git ecosystem has grown larger over the years, there are
> +documentation sites and third-party tools that have been created and
> +maintained by friendly third-parties.  Reporting issues with them to
> +the main mailing list is still welcomed by the list participants, but
> +most likely you will be asked to contact these third-parties directly.
> +
> + - git-scm website (https://www.git-scm.com/) is maintained directly
> +   on its GitHub repository and its issues are managed there.
> +
> +   https://github.com/git/git-scm.com/issues
> +   https://github.com/git/git-scm.com/?tab=readme-ov-file#contributing
> +
> + - Git for Windows (https://gitforwindows.org/) is a project that
> +   packages (core) Git software with some other goodies for the
> +   Windows platform.  They manage their own issues list and their
> +   changes are managed directly on GitHub via pull requests, focused
> +   primarily on Windows specific issues and their additions (like
> +   Windows installer).
> +
> +   https://github.com/git-for-windows/git/wiki/How-to-participate
> +   https://github.com/git-for-windows/git/issues
> +
> + - The online edition of ProGit Book hosted at git-scm.com/book/ is
> +   managed by the Pro Git book folks, and they maintain their work and
> +   issues at their GitHub repository.
> +
> +   https://github.com/progit/progit2/issues
> +   https://github.com/progit/progit2/blob/main/CONTRIBUTING.md
> +
