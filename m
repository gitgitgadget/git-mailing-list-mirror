Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5929425B081
	for <git@vger.kernel.org>; Thu, 21 May 2026 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368325; cv=none; b=oYyIv3z/dVHOghc/M1vUB3jL81WHb53cb7lEoRIZwA8cJYpt8mjukOAFYYhIje673cyrZnwbDNTguRfrN3m7t8PTNHCag8J1WjVolYUTZNw2iCAhRccA0cfpw19tHwFyyC8sDO5eTqXSfNrQ+mi9eDLxeMSnkiNGUbAwxkUcvE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368325; c=relaxed/simple;
	bh=+s/fX0SL+pU+svejTgao4s6fEKvCnIW/C8n9WLICgK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=htHuia1d4bl11ONzIr8yYg/NaiUOzqh0nMK3gOAzWYhEBfWNJ0RQjvuJL3vq0hPr357ksohvVAcPW0hCAbkY7nOjpffh4jraYyGLxeCPHvaWva19rsKgxc+UpIdc+jAHYlPdh9NtgYAym3uD+7Qs8Uc4FN00V6qTjTlfcO/0Eyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jI9NvdH4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gTE89xJP; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jI9NvdH4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gTE89xJP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 221221D00106;
	Thu, 21 May 2026 08:58:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 21 May 2026 08:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779368321; x=1779454721; bh=2UVZqY7fGh
	CTDKcrQeukb9s+3aD1PgmnwmuyQxe5rXA=; b=jI9NvdH44cZoypA7BJg0kBpLnN
	7rWjYSWBMzfViYf02pXXQc/E6VqtQEsXIk/ml3ThPxeW6eZj1b2ybtAKbsSUW6VR
	CicIDeSEvy7RNJtqsd3KDoE/SCXsHuZ+iAGbIVZitfyJvhXT6kc1QjW73K5bfwil
	NeCzpAXYMpYX61eew/Txd/baB9BW1WMW9/TxAdNuAsG4A2OiK1Ym1xdB+jTZPz+9
	RQwKvG8jAkKdDSdVoZyRBw238CePi1G6mxcrCcTAFhDX9Kya+hcqEurJOMsexDOE
	77YSDnoSoSFk3fIj3MTBV6UOQ/ynV6tyzXPTekbT65HBFZFLkCIf3sbNkJYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779368321; x=1779454721; bh=2UVZqY7fGhCTDKcrQeukb9s+3aD1Pgmnwmu
	yQxe5rXA=; b=gTE89xJPrRrD5JAI2Q4DwiNm62TCPChfYf4d/7GyWSGGDdzYZaM
	BwOMXCRixBX7Qw+MKGgKxpLresH12XSlFHvCYoQEUJZmAKIrKrrT45RSaVI/US1a
	lB+MdGG/iOXrqS4bacADAOiypP7bp+AMkFENZngAfMKEv26d2AmgCYeA4MNjwj0Y
	Lt8qGa6Lw/NiwZFdjR19wLyNkytJZ/Tsl6MYAZe0zpH7intZzOUXIizT+2Cyj6xc
	w0CNDXNZm0PkXSqWdnmRJsJiSocrRXI8LGJymw9x9kQdRx4pjHrOGOLeA/VMq0sG
	ly+/KMYcvvNuK7YkD+QBMS/gJI1a/6aRopg==
X-ME-Sender: <xms:gQEPakYMje6Sg7S8ScppcqxBIyw-rAf0epVtArgYp1ZxjrYpe27Y4Q>
    <xme:gQEPakXTKV3ZB_BufeeUtjxJ6sfnQgZRJehxKmFR2_hTgTO72gInqsfgDCJyozAZ_
    Lf_YfDGlklyJFsTDttow_lg8oo1OuUh7PAC8xUTAKvTW6grHc2VXQ>
X-ME-Received: <xmr:gQEPajMiu1kvBaTrY6NkQjwusbsNlgH3GTq4eoIcUNScl5wVSkjPplSjGcgp-9SCxEzzPqb2qF6Mb75QpbXihac6mjN6OoQhtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprh
    grmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegs
    vghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmrghr
    tghnrghrtgesghhmrghilhdrtghomhdprhgtphhtthhopehhrghrrghlughnohhrughgrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:gQEPauYXDSi0O0QBB-RlJWsKaAyBqvAB4Kc2WAAUA8vpqF6FbeC0Hg>
    <xmx:gQEPai_NGhak6Boc3ljW3fMqhinSQfPyYNuFjLh20DM6MGyR0TEYKg>
    <xmx:gQEPavR94d4EAeuvta-sb4i2vESM-X5qL2kLfzNC125lMgOCRcuIeQ>
    <xmx:gQEPascRwqUeFBZYUjrzjUUHrU4rgwj4tKvsSrQnU97XWTiBF2amyA>
    <xmx:gQEPavgj3pBiyxRKXSmQ8wRxsSp86nFqyKDXHxRKdkuaWG50horj44hC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 08:58:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>,  "D.
 Ben Knoble" <ben.knoble@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Marc Branchaud <marcnarc@gmail.com>,
  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v11] checkout: extend --track with a "fetch" mode to
 refresh start-point
In-Reply-To: <b8932b27-8006-4b43-b7e5-1fac0fbf42c7@gmail.com> (Phillip Wood's
	message of "Thu, 21 May 2026 10:49:13 +0100")
References: <pull.2281.v10.git.git.1779091483321.gitgitgadget@gmail.com>
	<pull.2281.v11.git.git.1779177508772.gitgitgadget@gmail.com>
	<xmqq1pf77kml.fsf@gitster.g>
	<b8932b27-8006-4b43-b7e5-1fac0fbf42c7@gmail.com>
Date: Thu, 21 May 2026 21:58:39 +0900
Message-ID: <xmqqtss02a2o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> One.  Have you considered the case where the remote-tracking refs
>> are overlapping, e.g., where "origin" and "upstream" point at
>> different URLs but they both store in "refs/remotes/upstream/*"?
>> Perhaps their URLs may textually be different but are pointing
>> logically at the same place (e.g., one ssh:// the other https:// for
>> example).
>> 
>> What should happen?  What does happen after you apply this patch?
>
> It would be worth looking at what "git checkout --track" does in that 
> case and seeing if we can share the code.

It always is a good idea to think how we can share code for
different purposes to solve a new problem, but in this particular
one, I am not sure if "git checkout -t -b topic upstream/main"
codepath has much to offer to solve what the new "before the
checkout, update from the remote" feature wants to do.  To the
former, it does not matter how refs/remotes/upstream/* are updated
and by fetching which remote at all.  The only thing it cares about
is to leave the record that this new "topic" branch works with
refs/remotes/upstrea/main.  But the latter needs to be able to
compute which remote it should fetch from.  It is a problem that
existing code had no need to solve.

