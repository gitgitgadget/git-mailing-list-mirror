Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB231547F2
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764545; cv=none; b=Mw47hEALuRbzETPmBCivAFpc4jWoiaOeNcv3JgO2DvAkwf2YITPd4dDYRuk23RsvN4CF3v7iG9v2uMQ6GZ9IqWN/hiceMC0UMEHC13kHKlKge+LDkLAEKl1lrVH0hPeC7WxvPWo437WThq7F+AJBYUz3IrfEXKTuzGXEnNr43Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764545; c=relaxed/simple;
	bh=S/K0k8pa0NOKOQdU12rVEz3t5yq0HH5oCU/H1Xfrp3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m7ojEkY5WE7wTfrBMtt3uumf9RnHlQm+mWRcwds0Hq7DInqaCU01eK1YLiz6ITBGNySw61G0ETFWm+VygUZchgMPVYZh96o0qbapboAL08H6ER2CLPMTytMMaHWGPIeGU5L8LKnoKWiQkbSgy0G5uxe5Nhr77eoMirYtK5dZb0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iTTvf+RV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qtiLq5ay; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iTTvf+RV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qtiLq5ay"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3FE8425401AB;
	Wed,  5 Feb 2025 09:09:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 05 Feb 2025 09:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738764542; x=1738850942; bh=zjrL48gXva
	KcjRxa9+RiPg3gnFyq4iqoJlG5wy3HtTU=; b=iTTvf+RVgMayATGr7HZkC9Y/OB
	JdGoSftR2y4XotM87O11Np7+krO+NmHuwn6wmy05ak9EUT8XO37Rwca72rDKZ7RH
	dPgzJy580gXf6fbnzctXR0c6Jzi2xnYvtpe/zthU2qV5gT4AIk/YeQV+X5f1LaqM
	7tUUjRTDbU/QFIfniiOEEAg4Y0CNJDqVIjMyc9L+D2ilZ2W3TvVYMr/oPkT1lM8h
	lumkayx0FJgo0L1CJA19QAaQ6RbyzDr8X1B/c5zVh6uZ6RotdDl+k03rbwJ5Wlum
	dizalaTBO8KosiCnejsq4Yg1Erg+Kp2rt8vzKifpswGpoFZVpIvTmXnaj7+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738764542; x=1738850942; bh=zjrL48gXvaKcjRxa9+RiPg3gnFyq4iqoJlG
	5wy3HtTU=; b=qtiLq5ayIuAHM3ioE39imyqOXE2uooMQdkR8wOnG85hczy7w9+n
	IHa8J1J/h/0qpEFv6GnUspVxo0HcCGl7sIgZLzUJTpOiorsAX2nm162VJaSXds4F
	BOJ8cYUE6PIcvzaMx3WcXadLUJ8xJ9EljPyssGzcOqNQQCyFgeOdtwUmzyGhRp22
	THcBbfpS09SM6GQm0O6+UM13M4oN4yPHt6hmwtzrZsp3p3csWmV6neJNHVk8sldh
	CHHPQonNX1jLzC+5biZWMTiaqhyA8xpipAAW82gRZFUc85Vg7G8wqJPxCXk+35yG
	/f5jTBz+HKp1RRPFUrfFd7hZt5pMhjBvNPg==
X-ME-Sender: <xms:_XCjZyDCI0I-YGt-1tagOuLwlM6dQkZcyPR6sr9hXXkkdrY7YAYs-g>
    <xme:_XCjZ8iDGEcHpnS3ETy1m2LaSku6FyydYCF4kTo4pTboRTmp-lhpYSVo-rRWOhBvo
    Nvc5YnzUPlbSafSVw>
X-ME-Received: <xmr:_XCjZ1kkli8DGuXJBwHOh2DI4-pMlzLae-fU9E3TeGvSiTPi8qepptWJJYsQl-RdT-QKsHFZZWBXiAiaNea3gWssplIh3XNz-jZs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmshhutghh
    rghnvghksehsuhhsvgdruggvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:_XCjZwzchBy-Ot24Y41AgHT0MAQOx6k9MXTnF9gWLN2kcvnRMrA5Ew>
    <xmx:_XCjZ3Q9mAEcAaidqwVJl99KFaz_hVEygLpYPUSLdtR2fvikL9PJjw>
    <xmx:_XCjZ7b-3jTLE0ZWf0LMhDudLtUimSSDy58YxWULlghzZRwB7LBUfA>
    <xmx:_XCjZwSJL_Ja39697ec_wx7JSiTRdyu3aNxuQq_em3qfxQPmMVLZiQ>
    <xmx:_nCjZwSQSucXNr3QI19YsmuZr9uJoQhWcfgZozw12rlfW5RiaOvQcIUV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Feb 2025 09:09:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,
  Patrick Steinhardt <ps@pks.im>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 0/7] Enable doing a shallow clone of a specific git
 revision
In-Reply-To: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com> (Toon
	Claes's message of "Tue, 04 Feb 2025 22:33:59 +0100")
References: <20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com>
	<20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
Date: Wed, 05 Feb 2025 06:09:00 -0800
Message-ID: <xmqqtt98pjpf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> The goal of this series is to add an option `--revision` to
> git-clone(1).
>
> This series starts with a handful of preparatory refactoring commits
> that make it more straight-forward to add this new option. In the last
> commit we're actually adding the feature.
>
> This series sets an example on how I think we can further refactor
> builtin/clone.c to increase the maintainability of the code.
>
> ---
> Changes in v5:
> - Add separate commit to introduce die_for_incompatible_opt2()
> - Small tweaks in documentation about `--[no-]tags` and `--revision`.
> - Better explain the refactoring of wanted_peer_refs() in the commit
>   message.
> - Change type from `int` to `size_t` in wanted_peer_refs().
> - Use lookup_commit_or_die() instead lookup_commit_reference() to avoid
>   checking the result ourself.
> - Add a few code comments to explain some things.
> - Stylish cleanups like removal of unneeded empty lines, commented out
>   test-code and remarks.
> - Link to v4: https://lore.kernel.org/r/20250131-toon-clone-refs-v4-0-2a4ff851498f@iotcl.com

Looking good.  Queued.
