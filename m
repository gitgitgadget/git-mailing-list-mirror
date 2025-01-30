Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9B1EE7DF
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738257952; cv=none; b=q4gKfHl75LZAACjED5W5XFrcl5lm9TfeiSaPxp3TtuoCxT1aVDV+9hDrf5JFX5stjrOhyg7S97RjPPXuEsf0lq3lgzuavFI0oUMzkBON+t7+DK4Ub88p0IhYE1NaBSqt3yYPzjsFLFt4C0l//V/pPaL6jitxPl4Io3Uk1uqiSsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738257952; c=relaxed/simple;
	bh=nIKIQnpXeO1Nv8IDZd13KFSbYkhlCnB0JTNCbVc/EZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tGe1ra9AhfGfKjEujaX+InzOLKa09wYQ7GDrpdxXb6JVkb0Tuxzp5mAPIBLz3F7LhecYfN8WoQ2m9NbK9iiTfVbHrP99ikt3t/1L/X6JkwuBhBS9zOVCN4G1ZsE6TceJC+sJZShr/9wYDBk1QXqfliicCiEdZ+AzNfLf9YEpjZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZtCG2yFK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wusfGepv; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZtCG2yFK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wusfGepv"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8372F2540126;
	Thu, 30 Jan 2025 12:25:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 30 Jan 2025 12:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738257948; x=1738344348; bh=gjov9aEDp1
	ZIHDyw64+8t/7UxmGlGw94hHUqMrC4icA=; b=ZtCG2yFKJO8dtFyqyTzZB4Nm3G
	BgvGMRwGdR3wgoM+XmGpNuedhYxacFISNAmJgWaU8H0fV0rhImwFohGzrRRM66cP
	HnZaDH617U+LJXPkYCdypjPr6pnL9xQt7nwK3EyQWJdtcLRD2d8aFqISoxH4IRV7
	PxX4cgTseikEisClg/TaSLeIKbcJCRmj2JAeD7o24N1LUl4zdEbiINLbehrARUIj
	g+VsIfpafWt7OfQdMCgwefR3cr/IH7NL9El7Y+CHgf+4nwsPjYpsr8ecx5OzC5wa
	FdEgQ6PYn/dPfD+5gBeB4HzOKywg7YXTYWvL0Tuq4ERetaMbG3ncXJrY+YCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738257948; x=1738344348; bh=gjov9aEDp1ZIHDyw64+8t/7UxmGlGw94hHU
	qMrC4icA=; b=wusfGepv3gfV9j8ptSq7ntzQD/v+fVfPB1uUFytKXnI0kKxezxf
	UYTJMivI2ZudofB/64Kfq4pBo2Q1xFdEtfu6fUZJ/bMPxrGgJLXA10uqZaecwLp9
	TB89XEEa488FFAk1h9lnauK00PKHPNj0HLLyq2++NSexj/waPY5uWO5Gq3ikmaX9
	hwjcYRKU9xZfDQRJ7xgy0WKlzJvFfeudVjwK1VQU6qEFe7OTpLO26oAlytQY9oIR
	yqUbL3rw2xQwIHgmPYrsgaR1D+XxEli5NMeNJOiUu65333CSfpCvBFQwVFA8CK5Z
	6EoyOQu/Ojo0B0mrOkXGFJp2vb84Ghgx97A==
X-ME-Sender: <xms:HLabZw_E1gxx45qx71o4YdNo6sFD_PdcNKLRIi7hBVop5QkijWdblA>
    <xme:HLabZ4sQYXN-XvK9H2i_AKcZV77jvfc5L4XRCBb7O7xbJDEZokPveEAIdp5JSxXug
    XZnHw2dy0tgpIHyVQ>
X-ME-Received: <xmr:HLabZ2BFtRbTb7YcF1cbyUaWDon0CIN6rw_KN6CeZhGSLwVIHBUqLp2s3wBdZibyhNTFgV-wcNe-pkVL_kHumj36j4XYdFeFWjEF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeekveet
    veevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdr
    nhgvthdprhgtphhtthhopehmihhkvgifvghlthgvvhhrvgguvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HLabZwc25gCdvYXqXl-s2OUJ7LHuST336gAp3eNxWbNKsbJ2qmDWYw>
    <xmx:HLabZ1MPR1MrfOeg6TrpUgO1YhHAFr0phqDokG09nIBpjwtpQ8psLA>
    <xmx:HLabZ6m0cOjeHfvtF7kuB4nE0fBI7IWxFp4Cqw0LAUkEePuCZQ0G3A>
    <xmx:HLabZ3tTtsYCd_KTGuKIN6H_sc87w0UJVgRL2FOiIZJqNGhFYYntSA>
    <xmx:HLabZ6q2Eqb-Wa5-utcaKcoCZp89oHtwlnKli4I_2ZewPr0JIvaIj0B6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 12:25:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Mike Weltevrede <mikeweltevrede@gmail.com>,  git@vger.kernel.org
Subject: Re: Feature idea: Git hook for pre-checkout
In-Reply-To: <Z5rhXrkbhINwFDXT@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 30 Jan 2025 02:18:06 +0000")
References: <CAAE-bwUQ+0ERbvC=SS=-R_K4H3p2su+=Ogf7BSkyq5J4GmmRYw@mail.gmail.com>
	<Z5rhXrkbhINwFDXT@tapette.crustytoothpaste.net>
Date: Thu, 30 Jan 2025 09:25:46 -0800
Message-ID: <xmqqy0ysfc2t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-01-29 at 10:49:15, Mike Weltevrede wrote:
>> Good morning,
>> 
>> I had an idea for a feature in Git. I am not sure if this is the
>> correct channel, but I could not find anything else. If not, could you
>> please let me know the best way to submit this?
>
> This is the appropriate place to make feature requests.

Yes, indeed.

> I don't think this is likely to be adopted.  We intentionally don't
> place a lot of restrictions on local actions, ...
> In addition, this change wouldn't really be very effective, ...
> `git push origin my-feature:refs/features/foo`.
> It also sounds like you're trying to implement a policy decision on the
> local system, which is the wrong place, as the Git FAQ outlines[0]:

Thanks for raising all good points.

Even though I am negative on adding a hook that does not satisify
any of the "5 valid reasons" [*], this one squarely satisifies (1).
But I fully agree with you that it is ineffective as a policy
enforcement mechanism, and a local hook should not be used as such.

Having said that, giving reminders locally and early to help users
avoid making mistakes that will be pointed out at the remote at
reception time via their pre-receive hook, only when the user does
"git push", can still be a good friction reducer.

So I am not opposed to an idea to have a mechanism that reminds the
users of project-specific naming convention of branches and files
(think: cross platform projects that have participants from case
insensitive filesystems) when they create such a thing anew locally,
especially the project would have a rejection mechanism when their
participants try to push their changes that adds such a thing.

Here, however, again I agree with you that a pre-checkout hook will
not be an effective mechanism to give that reminder.  The mechanism
must sit at the ref API layer in order to vet all ways of creating
(or renaming) a ref in order for to be effectively restrict branch
names.  For pathnames, the mechanism must sit at the cache API layer
to tell add_to_index() what names are problematic.

Thanks.


[Reference]

*1* There may be slightly updated versions of this in the archive, but
https://lore.kernel.org/git/7vbq7ibxhh.fsf@gitster.siamese.dyndns.org/
is one of them.
