Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC2434AB17
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972071; cv=none; b=pLFD5tUdwTQFTTXfGeIXfgMOS/MIz4mp9fIMN5If8pXb+CADSQsnrXXQ52DZYpk0wosdeUPEkeFG1h/B3MvpBDkoV9cLElc78Xu3IYLHepdjcZCL00mMICMRgSGLy/o8cYSOWChYU2B6CXLcsNESeWJXE6lRE9GzGvPuJPxKj3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972071; c=relaxed/simple;
	bh=shqy01g2qDbgqAFqbXnV1GqlZVT7yqfXLz9WGIQmjU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sUot4ggY1b5T2dIkfpUQDZQ7LwPci8VFKUsh46eZjYelvMSQvBOsR8efiQbqR5C1PsUszWZTl6dlUCxQ+HVWEXD5+f7sdp43K9rB7wMGf9rHxZCL7RUI3H4WTGij32PGhImUJ3zSnvUTNs3x3maTREUTWb0KNsDE6r6rIeREnv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=zJzCAFDt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j4VztzAe; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="zJzCAFDt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j4VztzAe"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B7941D001DF;
	Tue, 24 Feb 2026 17:27:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 24 Feb 2026 17:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771972069; x=1772058469; bh=vIM2z57lse
	3iT1W0EnF6iNWOefG1Ixi6iaRWblpbO7w=; b=zJzCAFDt6sM2wmuv46pAM5g3n4
	X63/bp7s6bgR8hxJrmiiY0IUUu9tHOy7j7wIIhaxMVm5gF1RqueHbFP8CoRcqglb
	r2f+KU9wK9mFh4B599RCw6i4e/VU5cbd4G+g0BixgdK2XyGlKlu+9WWleYOhT5x9
	Erbb5LzPA5i2/W/52XT3H+tDCedOhT7TmrOiUeP5Dgm7X2MvTBGa5N3P49kkBbGh
	17bCmVjXijH3qfoJxe0ltwO9QXmTikK4tmv9GG/QHaia/iVahMlgzODauJ2GicQK
	G1jT1q9ehW2xJLq2kiHvBFs+VR+FTHd/c3S1KJ52pTdusLUG3npGOvcZ/M7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771972069; x=1772058469; bh=vIM2z57lse3iT1W0EnF6iNWOefG1Ixi6iaR
	WblpbO7w=; b=j4VztzAeQFS/7Qxi13Oomp+khbKcnOk/NI6TSuosxvVNMmrznqL
	fPChEiH+nXM8ccyxI2Ep89eMz7X0o4SuJsFseSXJhZCXBSlehsFgFVpjswKgFN/3
	DtEOFrXrsBySKBdgkSf/DV+AsPJ1mojXRmGOS9w3ZR3HDGRnlAWBASpiqZdaCxFb
	Ko11tBwZVzTHZH1EOD8zqKhUr+bT2OdysIlWLSMRrX14npVTAEHL4eMKh12dtXIN
	LG1rOSlHQqFkhMuYnDNqoClzHuFPywHIGzjTH81iswRIircq8WOuHhHn6blcmf+U
	wF9Ezgqn5Ud4NaK+oJXQ3tFiO9OsIfYLV1w==
X-ME-Sender: <xms:5CWeaQGrcuvww42GCagTcILotkq97XYDtr0P-L68XgMESR1YlwBagg>
    <xme:5CWeaQytM3o4mdwpCixxrOTu2Ubgybb2aSLc5v_V7_xjKuJsKr4QdqyQ3pHk4aqe7
    FaC33-Z207TcD1ZlgOFPSBYdhYAMdYurZTm-FSf62hF1zhDdczHTA>
X-ME-Received: <xmr:5CWeaXh-B5lcUbVAo9N3nEqOFUVyDX1ozSEAGasEPcA29KX6dEPHo69ytUztQszSZpdAWcGlJwaSDjfvwKExCMQ8TtWalz-9DQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedufeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteeijefgieduheffhfetgeeggedtvdefieeiuddvudetkeetgeefteejjefg
    hfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhithgrnhhirgdrshhughhirghrthhosehrfihthh
    dqrggrtghhvghnrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:5CWeabwsO3NLqogwaHnAUJhLmUney_z-xovrwM9gsY2Bv2jf_Hw8gQ>
    <xmx:5CWeaaJvFOrJwJ99ifbPrsH2nZclXHUJ_pBv3Ig6y9RlT4R1hbVrfA>
    <xmx:5CWeaSSV6HbaUlGiH3pOVFx6lM69JvHFSClFuxQbaDdfBadCbBiSNw>
    <xmx:5CWeaSriCLqSpAhoUv4jyNeYaxiwXOpOCH0GIulmorHWoq4rqM0o9w>
    <xmx:5SWeaTnAldnCVBmW464bRjVNWmXe20EwcDx2q7uolWo6hZ4sIoukLnPx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:27:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Sugiarto, Titania" <titania.sugiarto@rwth-aachen.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feature that allows the user to merge only specific
 files/folders from another branch
In-Reply-To: <14775be9ed944bf684c3696e1a10f44d@rwth-aachen.de> (Titania
	Sugiarto's message of "Tue, 24 Feb 2026 13:44:26 +0000")
References: <532e9d58b905404fa625aa59104ce8f5@rwth-aachen.de>
	<14775be9ed944bf684c3696e1a10f44d@rwth-aachen.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Gnus-Delayed: Fri, 27 Feb 2026 10:39:49 -0800
Date: Tue, 24 Feb 2026 14:27:47 -0800
Message-ID: <xmqqa4wxepzw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Sugiarto, Titania" <titania.sugiarto@rwth-aachen.de> writes:

> I have a suggestion for Git, which includes a feature that allows
> the user to merge (I want to highlight merge here, not replace)
> specific files/folders from another branch.  I feel like a lot of
> users have spoken about this online but up until now, there hasn't
> been an update regarding such feature.

What happens when a branch does three different things, and you
merge that branch to the mainline but taking only changes for one of
these three things?  You get changes only to specific files merged,
which is what you seem to be talking about here.

You can do so with "git merge --no-commit", followed by selectively
reverting the working tree changes to the state recorded in HEAD
with either Git tools or your editor, and concluded by "git commit",
but anybody doing so must consider the implications for doing so.

We need to remember that a merge commit is this declaration:

   I inspected and understand what this side branch does and what we
   have done in the mainline, and came up with this tree state as
   the merge result.  It is my belief that this result suits the
   objective of the project better than either of these two branch
   tips I am merging together.

After you made such a declaration on the mainline branch, you made
everbody to agree that among three things the side branch did, two
of them that you did not take were bad idea and should be discarded
(anybody who do not subscribe to that idea can go elsewhere and feel
free to no longer work on the same mainline).

But what happens 3 months after you make such a merge somebody else
(and it could well be you) realize that they want one of the other
two remaining changes out of that same branch?  As you have already
made such a one-third merge, they cannot merge the same branch again
to resurrect the two other changes you have already discarded
earlier.

You'd need to find these discarded two other changes _somehow_ if
you need to resurrect them later, but how?

When a bug is reported on such a state after the merge, the author
of that side branch may remember that the bug is addressed by one of
these two changes you did not include in the merge, but if anybody
asks Git "is the branch that supposed to include the bugfix already
merged to the mainline?" they will get "Yes".  In other words, they
run "git log mainline..three-things-branch" and they will get an
empty result because you made that one-third merge.  The release
manager will scratch their head until they realize what you did,
picking only one of the three things the branch did, but recording
that as a merge with that branch that did three things.

Chaos.

> Might be worthwhile to consider?

So,... not really.

