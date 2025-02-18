Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438081E51ED
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905928; cv=none; b=ho/wLqTYy6f/lI2WbJuU287PDah2C8r91rCocGkh3ppn+fmF8MYAiKJVgTA37PvAq138i8tMPnBtmzNa+NIdBsXK+0TIiFGfCZrSWYqXUXw2USzfoSgphw3n1oXdiSLc4KKzsQUvyqcZIY9NG3MrLcRFyWPDkIsrQb5/uCaDWk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905928; c=relaxed/simple;
	bh=Yy5xPoqA4dEbzeqPRoS3jcS0diRvEQZIc+oRcTlwNlk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f9p1uywZbVVBOy9NYX1zIoh+5Nm05xIJ/JXcorjjpPuwUc0WsuFyyPY/u4il/7Py9hCY16mZ+7HehMMj4+s/wgqunBPZCtzOvxxROxIq3ImV/jh01/Pbe+1jheM110EpNbdx/HQJtMZ/WU2opVfLCRbzZKtgASRNhf0EiDTI8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GbV63704; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oncFDDcz; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GbV63704";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oncFDDcz"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A78A11401FB;
	Tue, 18 Feb 2025 14:12:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 18 Feb 2025 14:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739905925; x=1739992325; bh=8iD9AUNTnW
	R87A46wDiPIWJL3/UsqgnI9oczjqxtayw=; b=GbV63704ZzpqeOpLnC8Az5QYGc
	Sqnf1lgYHPRxGGINcFSFp9uJXi94KA6LTNI/lxUmYh7yB8C9yQDRVmvzsDu6UFDk
	m4jJo7kor2LufsjgEbkcdehmpZquZuJpmYA8/sNGbVi7ZzuUUcEQkjGgVhkEUCrz
	O8U9opA41AOcvUo/Lxv5IQsMq51Lcb6WkXHcLMAtBmr5qAjOpfhYMc2bkF2jev7o
	74uDKunrsX+g4b9213b5SE/T6kJKse7QLhecj43lpVWnl/cVKdpUgR0rSGNWY3cG
	BSj5nncBkf3ObKifnToH6wsFh2cFjQ9q2rt1Ly8WHjUE4ZF4OC3koviEs+HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739905925; x=1739992325; bh=8iD9AUNTnWR87A46wDiPIWJL3/UsqgnI9oc
	zjqxtayw=; b=oncFDDczf9WpfqSJj0J9IMunHmTZY7B2+ysTeZ7pzR0MJd4XNKm
	r3eNnLNN+fVcEKfZInayeH714HLKStHCqR687zRwn6WfKI+r/a/M6TK+o83r9Sss
	5NIJEcYNEVeuJrLLExZipKlZKvNeIuoeJzE+HN6uz0+QaNFAp7AY8ZkSP8+1M5nZ
	kh4CGGFOLu6U5qxoBNJ0EJxZDpP0O9ZwsF1H4LohYoUhUDsxTvKEP5ezhXjzOZ+8
	QFQqPrb2RS6ADpC2j6NhmiEwUkQDnBwSK73Dd8hDIUwrXnqXIkn7MiURdU3Tq+Qc
	86cdS3HhiTMcxHT3FdfCSulGLFnjAfBXM8Q==
X-ME-Sender: <xms:hNu0Z1vWobkbc0CFUrj8zxRYH-LF9ZMGf7OKzMur0TOXjWhL-SUtvw>
    <xme:hNu0Z-ciWD5_e9iXWJLQpilno0VFh_-_Kxd-5DlA4Das2wTkWLR6-4Kd98cOfVwiv
    PpWdw8QKZwuzK9v1Q>
X-ME-Received: <xmr:hNu0Z4y-NjE-kDvhlm80LnoTBi11h8-3f0jVfwQN9zRe8XkbpQ_rj8-vWoN6uHRU4Pm1vZDxQN7G4oTp9rl5-Lach90yNqNZ5kTMeoE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivdduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprdgurdholhhivh
    gvrhesmhgrvhhithdrohhrghdruhhkpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhith
    esmhgrvhhithdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:hNu0Z8NVdHls9_WJHfneNQYuXigITkxxoLkveGqmLbim8pu2RPXI4g>
    <xmx:hNu0Z196naFPob3YAxCIL_UkIAzP9nmdxUf5afNp7J_eHI8vZBB4fw>
    <xmx:hNu0Z8UQef54SeCYq206lOf9R4uRdxX8Vz1oObSzB6zvajuwiN-Fbw>
    <xmx:hNu0Z2ez1txoxoYFLga6XH8nGe6tP8RS24Pu4DQdXhvksMDdsMPf8w>
    <xmx:hdu0Z4lLMikXltKI_1WcgSRrQQ4saqMXbPHMmupWijIwl0C9MMlUKRNM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 14:12:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Peter Oliver <p.d.oliver@mavit.org.uk>
Cc: ps@pks.im,  git@vger.kernel.org,  Peter Oliver <git@mavit.org.uk>
Subject: Re: [PATCH v3 0/2] Fix Meson Perl version check
In-Reply-To: <20250218153043.63535-1-git@mavit.org.uk> (Peter Oliver's message
	of "Tue, 18 Feb 2025 15:30:41 +0000")
References: <Z5c4OzzHWOo30Hu6@pks.im>
	<20250218153043.63535-1-git@mavit.org.uk>
Date: Tue, 18 Feb 2025 11:12:03 -0800
Message-ID: <xmqq8qq3kqyk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Peter Oliver <p.d.oliver@mavit.org.uk> writes:

> Suggested comments added.
>
> Peter Oliver (2):
>   meson: bump minimum required Perl version to 5.26.0
>   meson: fix Perl version check for Meson versions before 1.7.0
>
>  meson.build | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

I wasn't involved in the review of the previous rounds (so it was a
bit of surprise for me to be listed on the To: line), but it seems
that Patrick and you polished these two together, so I'll see if I
can add Patrick's acked-by/reviewed-by while queuing by waiting for
the earth to turn one rotation.

Thanks.
