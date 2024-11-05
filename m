Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5B8BA53
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730766984; cv=none; b=h3UAPd+Ga8/kDTybeTL6bLjT0vdRBG45W85YzxPwbn1ocoMNA3jWbyatSVQoSMzj+/B7qmm9FOvlxRbc0Yswbqglbsya3SYOrZhhLQYFougbtB2VEFiHyzBnoklsfgGJgpNhe7U6VcJZsTzY9Ty82r3NoELTBL/zeUXvBFWQGN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730766984; c=relaxed/simple;
	bh=d9cZ7V+aA4ytXZQ0rELT1WuiAZ+elBcwkx1Z45Fdpc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Krz6sYJzxBDCvqdf8epTkwxnAlIhbu5aEUF446/HvxKnJJgYmtSoROuMoAQtBvJoXb5HKor2+TiPKSAAay61eU6qp9hHSCN2EFNZue+VEnCWzHpslv37KEXNHVM+xa+VEVua44UBgBItJy68JklE+IuJEVDPLiGBI4vSp2eFj0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d4kkLxWL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gtseptk9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d4kkLxWL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gtseptk9"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 31C0F13802C1;
	Mon,  4 Nov 2024 19:36:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 04 Nov 2024 19:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730766982; x=1730853382; bh=YIwqQDnGAo
	XvOOAUK2PwQWgUkZaLblJH+M3YxhOKO9s=; b=d4kkLxWLVkH4ug3mHvlB9AybEG
	POf2tQo6nEYq/ZC0KS7Eb3g/Pl7iVxJJTaM5OD6gGa68EQr2BSXvWLYfF/YATKX6
	gipYFg17GDYDc5Je2m64/+/6tk0vqHz6nkH4lqg7ZowAb+BjkLnOpHJ+pArq4y1o
	mz1dGAjQzVR1FBCNpwuoOURz7va0n8HB4cqfy1NYb/Ag7illbPXRuT6vQx/dhOrZ
	NXCFUHOAYwJGEQHxq1AtoKxhbnizDVWsKvdjIjvQ57XkOsxyECsNJIgZgpDd9g2U
	ZH6Nmun8KVIxNvawn55ee96TF7h/YZsIgSQxpEZIZRILRQXzH9WSKscdLDGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730766982; x=1730853382; bh=YIwqQDnGAoXvOOAUK2PwQWgUkZaLblJH+M3
	YxhOKO9s=; b=gtseptk9vY780oWFFyznRYA2Q92+jdv8chZLoSXWfOrthc8oo2U
	Y9rb9BVHDlOxTQUKggy8FkywGcgh55SBbegMRWL2WywFbCoIx/5xMAkwDbwSFVZe
	xqVs1iFLIPp7vm1wqyW438IFOts3HXvp6eXJ9VEsz2HLbP8rE+m+o0rk5OSxymhX
	2FQsnPofTkpxH/+MoUSOMcF2DXPikZu70xFhG3NoFlhlETTFkozfBTSleSMnbRWp
	wmvUVnBE8Dqo+oRUVXxT8GFpXZ7dHGZHAQGrYyuQYWC7qil6+7OL/MJKUfGtKgJw
	h5jyThQ3AtY0nREQaIzcWiTrXXrvEzFb55w==
X-ME-Sender: <xms:hWgpZ7tuSzGowyQ7Q2rMTjWRnVgssd0DMfWETb7hHbUw-_MHLqt8yA>
    <xme:hWgpZ8dD9Ehlmmg-FQhyeG1BzlXO6ePdSIW6xLV-926JHpcYtIcI7TSLEBpniHJuO
    Lfqm6HUkNVKy5_4LA>
X-ME-Received: <xmr:hWgpZ-z9uYlAFKls4Od5MrvQEJY-R9Gno_5kRPZwytjDqg0huWhCRjpcOTJc3YyHGGWmXIkbM3XRbDsyPk2M32alO2qGd86cJN3E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehirghgohdqlhhithhosegtlhgvsgdrihhopdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:hWgpZ6ORxsBZRzXMtU2xeFrR7KjDWg0KAYKQvf8Z9y9mTrifABaxkQ>
    <xmx:hWgpZ7847FOzU8kvy5-syzszj4gVh6gyuJwE5pC72gPSwXhvmYZUaA>
    <xmx:hWgpZ6VfimkrNODpX8OpNG0vYT8-Zb8897NRVqkY-OIn3o9nf5zn4Q>
    <xmx:hWgpZ8eIkvYd043vENrQFamSJBCGQKqKelnbrpgU_a7-pJbfSrdMAw>
    <xmx:hmgpZ-Y0v797HaW18-jTrLp5wtLNDSI2LFDO5N0JkAtxWoHe13q6hkTs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 19:36:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Iago-lito <iago-lito@cleb.io>
Cc: git@vger.kernel.org
Subject: Re: `git apply -p` doesn't remove source prefix in 'rename' diff
 entries.
In-Reply-To: <d67e133c-f287-4009-9244-eaeffd84daeb@cleb.io>
	(iago-lito@cleb.io's message of "Mon, 4 Nov 2024 21:35:47 +0100")
References: <3af246eb-3473-4964-9aed-ecff62b215b7@cleb.io>
	<xmqq4j4r4enh.fsf@gitster.g>
	<d67e133c-f287-4009-9244-eaeffd84daeb@cleb.io>
Date: Mon, 04 Nov 2024 16:36:20 -0800
Message-ID: <xmqqjzdiv7nf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Iago-lito <iago-lito@cleb.io> writes:

> Hello @Junio, and thank you for feedback :)
>
> If I understand correctly, you are suggesting that `git diff`/`git
> apply` are behaving correctly here, but they might not be the right
> tool for the job?

No.  

"git diff --no-index" is giving "wrong" information in the
rename/copy extended diff headers, but regular "git diff" is
perfectly fine.  Also "git apply" is perfectly fine.

And the "wrong"-ness above is in the eyes of beholder, in the sense
that the original folks who coaxed "these two directories are not
controlled by Git, but unlike GNU diff, "git diff" has a few nice
bells and whistles, so instead of adding these properly to GNU diff,
abuse "git diff" to add a mode where two directories are compared"
probably did not view that "git diff --no-index X Y" must be
equivalent to committing the contents of X first and then Y next,
and then doing "git show" on the resulting history.

I do not know why being different and showing X and Y as part of the
paths reported on the "rename from" etc. extended diff headers could
sometimes be useful, but they must have had some use cases I am not
seeing offhand.

So in order to lift this "wrong"-ness, you'd probably want an option
to the "no-index" mode of the "git diff" (in "diff-no-index.c") to
omit the leading directory name (i.e. X/ and Y/) from these
rename/copy extended diff headers.  Then your toy example would work
when the "git diff --no-index --fixed-rename-copy-path-info" is used.
