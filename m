Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847F413D8A0
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 05:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733203913; cv=none; b=qYv55fVB/qUN9URjijVx3q8YXJGzIi7gnQX83wnppghQo7RxzLVDk6cUNB7J/rVfL8pi9rwoOSaEVg7cWj3xSVKlcskrkmyB9R4QP3eOxSD0V+27a1U17tvBRoH6IMMBmBy2+ZPT62E/dXkJXo/FVZjtR1ldI0C3rmLRHlSNb6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733203913; c=relaxed/simple;
	bh=rkOA+LSztcq3qRHrVDXNa30g1KBuWWKYEQcmkSKG66M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J26OIPaLEKkZz8OnIS2cz7dOnJ+KzUqbMQjjjxlCOr4uzqeLF7kjVqkoAcr3Afk8nHAGSTk6hriTS1DH4g1TsK792pRsYgWjjd7ULARQ90dJ//Nfm2ryShjF08uZbHviVeyYH5peyJKN/kLCVISWptjBxM8tN2O87iImHXDq7cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=C0tthDXu; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="C0tthDXu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1733203909; x=1733463109;
	bh=jxFgUQCnS0+BzxxoaROusvUpkXpJmJm+RM1Ght9BvMM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=C0tthDXuge8pSu8zP28eqPuQv5nlaPyvzPKnyyYMLcb7yyxiOOrLQiTO8MCg94oFj
	 spBk/ZTI1YS7Fc5Od6HwxGuFJr59eJ8ZVF3E4EUnGR8YAiIGFLZBIDudjJPqVammcv
	 cuK1O7qKTL9Hril9QoyRBYT4rSixOHnN/SJlU4Q98KyUnE4zOFUcQU4cLIxNd33OAf
	 J/2CylFLgGpQHwo4a2roo+/FV7Bl5vlEHbd0lSKpyi0cqmnDz3ev/ZgydXZxcL7xBg
	 ah3sgw8vj/5SGhwMIevjwauxJ5UT7Rey7BIezuAdehGutDQng2BmotXvHxAH063OYs
	 X0VoAZM5E+0Kg==
Date: Tue, 03 Dec 2024 05:31:46 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Caleb White <cdwhite3@pm.me>
Cc: rsbecker@nexbridge.com, 'Eric Sunshine' <sunshine@sunshineco.com>, 'shejialuo' <shejialuo@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Ensure unique worktree ids across repositories
Message-ID: <D61TI8S0M79X.1YEUCB7FI6CC@pm.me>
In-Reply-To: <xmqqiks1e5zs.fsf@gitster.g>
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me> <xmqqed2qkfn0.fsf@gitster.g> <Z02eKA8i51QyXgJ-@ArchLinux> <xmqqed2pioff.fsf@gitster.g> <CAPig+cQHW9=A5ejU5aZ+Wy0uOQsLU_uqUibeYzZs2PXK37Vpbw@mail.gmail.com> <xmqqo71tfsif.fsf@gitster.g> <025b01db4526$3b05ef00$b111cd00$@nexbridge.com> <xmqqiks1fqgl.fsf@gitster.g> <D61R68MFWDIU.12PI8AA8S3G86@pm.me> <xmqqiks1e5zs.fsf@gitster.g>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 38a2ba244313615329c41403d43657023cba1a54
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Dec 2, 2024 at 10:37 PM CST, Junio C Hamano wrote:
> Caleb White <cdwhite3@pm.me> writes:
>
>> You're correct in that the worktree ids are only relevant within the
>> context of a single repository. However, I've already demonstrated that
>> it's possible for a repository to "repair" (i.e., take over) a worktree
>> belonging to another repository if the ids match (inferred backlink).
>
> I know.  But isn't that a BUG in the code that "repair"s?  If a
> worktree had a name 'develop' that was OK in the context of
> repository X, and when you "repair" things so that it becomes one of
> the worktrees of a different repository Y, the "repair" operation is
> what MUST make sure that the worktree that used to be known as
> 'develop' to repository X does not interfere any existing worktrees
> that is attached to the repository Y.  If the repository Y already
> had a worktree called 'develop', the "repair" operation must make
> sure that the newly adopted worktree would get a different name.

No, this is incorrect---there should be no reason to "repair" a worktree
from another repository in the first place. That would be undefined
behavior and is indicative of a user mistake or unintentional repair
(e.g., it would make no sense for the php-src repository to repair
a worktree from this git repository). The repair operation is only
intended to be used with worktrees of the same repository.

> But then, the concern is exactly the same when you try to create a
> new worktree (no "repair" involved) in repository Y and try to give
> it a name 'develop', isn't it?  You have to make sure that there is
> no worktree that is called 'develop' in the repository Y before
> giving it the name.  Is it broken?  If not, what are we doing to
> make sure we won't give the name 'develop' to the new worktree?
> Certainly we do not use any hash or random number for that, so why
> does this new series need to use a random number?

We currently suffix an auto incrementing number in this use case, so=20
you can have two `develop` worktrees (located in different directories
of course), and one will have an id of `develop` and the other will have
an id of `develop1`.

Best,

