Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB01CAA65
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740007149; cv=none; b=QxAz/PP1EoTuZymJTs63FSxw+Jia8KaIk09q7+97lZMd0z9QEghzb6OiM3NeSqurSw68XaBNCfnKJgJQkueFPehDNGFk3E4or2Y2/sFlLGmh0tWmyvfaeUTQKmTVIg10O3T2Pf08kvWLF46nSG0CEZ8yi9cBtLAnuEHs7iXkShs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740007149; c=relaxed/simple;
	bh=0Sfh32DrAXQFs0KMrh06BSIV8jRQ85g+6kEFvSfiKns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E4+dh/sF5ttgqIDj7hxHf+8f/0CcK81R7CSI2LHBjxAvrTjVOMyJbG5epK5mIFICHVXIaNjRhswZiD9biWKWBiVJKgmfiLVX4vW9Y0+k41SRP5w8H9OHkCKfo1+lPk2RWWpRSqxRH3mPhh+Ne1nSItlGmngDUNugd9dUXfcJ95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bISGPs2D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eohTvmWG; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bISGPs2D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eohTvmWG"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id E32E613808B5;
	Wed, 19 Feb 2025 18:19:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 19 Feb 2025 18:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1740007145; x=1740093545; bh=Uv5cF4U/aq
	VuINttwD7s3988bvb3Ea78q8uLfQP/t4M=; b=bISGPs2DLbJT30ywmoay+nIvZP
	YAyK1KGmQ9Ng7vKEkH+IjGpYGLlx/Zj/kUH4sAmsgFamn6UG+Vmaod+BOYT4c6Nl
	dNeyNIOS3zBAgVo/GUkqt4YUrM7GyIn0xFKGtsG8TJTjjnti+t5yqW+KhkCOxjUU
	en6BZmtqZY+/60Ef4GlONQuLXEm1OuuKDCMZlZodS34oa9D6tYdJsuxQGivFZhtk
	FVTMBF5XMVFLVxWHy1TgvMR7gal0xizIM0UAVS3D1lsof1GrjIBFbD0fVy7DeMZ3
	MlfLR8JMNfbudq7pp8NyfQ/IFNHyX8AuDm7oW1mCNRK7iKPXkBRmGAB2jjRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740007145; x=1740093545; bh=Uv5cF4U/aqVuINttwD7s3988bvb3Ea78q8u
	LfQP/t4M=; b=eohTvmWGICuaj7mciCVpXn3ZquXD8MrWsaaswhKHmAZR7TZw23i
	6oVq9oFAdrQt5FO8Lrk0xGVbnSOgG7y/7TemYqbkcK24eBBtlpDvcRdtRcaQBXqK
	q8RfsY4pumORZL51fEBpyWWJ4dILcTYtIKcDnIIX6Rj5hRXzfzW9O3ixKt5++iow
	4Wi5Ds/3oGmyJvxHrznM+OWP9TnMRez4kXsFiRBKbae5xl5YYI5AkdS3dOX/b5lt
	232umSJAt/q4XxGpp6SiiUZPtxBRa8Sf/KZFbw5yNkyXGaMx9fxnzzhsV0UX0Bjz
	a+qwd8Cf9PhflAyIW+boCPrjBa1VLbvVlDg==
X-ME-Sender: <xms:6Wa2Z14fCBDmRbLjid2RiXA_d3TA0WsvXvV_XVf6XV42xtcq0rpMwg>
    <xme:6Wa2Zy7rQdZlzAlJxLT3CvuKbOrgyHQ-LQEudQTYniMsxI0uIFnnfZXKxTSNn_yht
    iyL54D7BYAdoMHxUw>
X-ME-Received: <xmr:6Wa2Z8fOJB0vh2fBY09vPavXVrNLN52XI7WBkA6VwLhmDdVetE6FQ7V037v0SZ29XBchh0NV8SeklP4r0x46JCebdw0-GcOOteo3z7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiheehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6Wa2Z-JAyvA6CnOqr4qQMDtfk_o-KZt1pHS_Lu9FGX0ECvrueOIyPQ>
    <xmx:6Wa2Z5JwBEVTYlfuuwPdrTC11UoHbXn0Atl_4Bxntcbpz1hqr_PxTg>
    <xmx:6Wa2Z3y2hUOCif5GU-NSyP1VyGHh6F2mZBGYcwcJI8ABij2aUWrIEw>
    <xmx:6Wa2Z1KszxZdAARqmZewfw1RDeeqitjrH_-Gf439dLvKbapx135NEA>
    <xmx:6Wa2Z2GzlxeEv_c2ZpNJ5ggAKtVK93MP_iTl2Afu2Jtj7Y_z8XqHpaq8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 18:19:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v2 2/3] builtin: introduce diff-pairs command
In-Reply-To: <5uwp2vdm5tzv6n26fu77g4xys5ntjy2bj4hpgiuwpamxkij4zk@77jn55tynwse>
	(Justin Tobler's message of "Wed, 19 Feb 2025 16:19:44 -0600")
References: <20241213042312.2890841-1-jltobler@gmail.com>
	<20250212041825.2455031-1-jltobler@gmail.com>
	<20250212041825.2455031-3-jltobler@gmail.com>
	<xmqqldubumxf.fsf@gitster.g>
	<5uwp2vdm5tzv6n26fu77g4xys5ntjy2bj4hpgiuwpamxkij4zk@77jn55tynwse>
Date: Wed, 19 Feb 2025 15:19:03 -0800
Message-ID: <xmqq1pvtfrq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Thinking about this some more, I'm a bit unsure whether
> git-diff-pairs(1) should support "normal" `--raw` input. Furthermore, if
> we do want to support it, maybe it should be the default?
>
> From my perspective, ultimately I don't think there is much additional
> value provided by supporting multiple input options for
> git-diff-pairs(1) since the end result would be the same and its just an
> intermediate format. As I see it, the benefit of the NUL delimited raw
> diff ouput format is that it is a bit simpler to parse and likely a bit
> more efficient as it wouldn't have to deal with unquoting paths with
> special characters. The benefit of the "normal" raw format is probably
> that it is the more intuitive default option.
>
> I'm certainly interested in what folks think about this :)

FWIW, in our toolset, "-z" is not the default primarily because text
format were chosen to help debuggability, which used to really matter
in the early days.

> For abbreviated object IDs, supporting them would make the input format
> more flexible, but it would be simpler to just require the full OID be
> provided thus making the input format more explicit. My current thinking
> is to leave this unless others think it would be useful to support.

Abbreviated object names would only be at "might be nice to have"
level, I would think.  We are talking about tools-to-tools
communication after all.

> Regarding pathspec support, being that git-diff-pairs(1) operates solely
> on the provided set of file pairs produced via some other Git operation,
> I don't think further limiting would provide much additional value
> either. If we do want this though, I think support could be added in the
> future.

Another consideration is which side of the pipeline should take the
responsibility to invoke the diffcore machinery.  We certainly could
make it the job for the upstream/frontend, in which case diff-pairs
does not have to call into diffcore-rename, BUT it also means the
downstream/backend needs to be able to parse two paths (renamed from
and renamed to).  Or we could make it the job for the downstream,
and forbid the upstream/frontend from feeding renamed pairs (i.e.
any input with status letter R or C are invalid), in which case
diff-pairs can choose to invoke rename detection or not by paying
attention to the -M option and invoking diffcore_rename() itself
(which should be at no-cost from coding point of view, as it should
be just the matter of calling diffcore_std()).

> The tree objects in the input are not expanded. With `git diff-pairs
> --raw` these objects are just printed again. With the `--patch` option,
> they are just ommitted.

Instead of getting expanded into its subpaths?

>> This apparently does not apply to 'master' and the base at least
>> needs to contain 1f010d6b (doc: use .adoc extension for AsciiDoc
>> files, 2025-01-20).  Please clearly mark the series as such in the
>> cover letter if the series is not built on top of recent 'master'
>> (or 'maint' if it is a series to fix breakage, but it does not apply
>> to this series).
>
> Will do

No longer needed, as the tip of 'master' now lives in the .adoc
world.  Hurrah!

