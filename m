Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DD68493
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888989; cv=none; b=uBLk8ISWXRMpBv6FB3gFthzU3QiQX9wyqIB6uV8KQZRAztF2PYEL8PPaElIoccf5Cu8/0bV0AfLXbDPe34qCzqdaAnbxvt6GENFdbwAlosTkTfeTajkIqQ5Q+CCf0PuIm+zImtlDzRIfXO64YGTivUytPScGt23FxZ2RE5Zye0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888989; c=relaxed/simple;
	bh=cZYHBdhwcEtAqfUO9nL0dC9WG9fHgAtJlebteeO8VU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=upAW8fUDqgv9jvx0ICV8wI75b0SS9GB4JbCSMuVIilejqGDHhffLUfeKmsLqg+a955i7cQV+usKkbIJQUcFyhgO681UAe0ZeYeDB6bGl6n7ogDJc806VKsAfHHXnjBBc8f/HajC3JxZ2MHdEJtWYZEpzaT61cVUgzPg54L68TjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nxl8WWhU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V0dS++wG; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nxl8WWhU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V0dS++wG"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BED0E1380831;
	Tue, 14 Jan 2025 16:09:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 14 Jan 2025 16:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736888985; x=1736975385; bh=KdZQmxGQPv
	cas4WhoXt+wk59JB3YpmhVQvVq4muZTU8=; b=Nxl8WWhU/JOhjgv1RWdUPcDo0u
	XHNvbUtfbAmSrJ878eYO84vqyazS6OVweZD39aQT6s+6iTTwyl0t0vKYxEpH5SCh
	jvWNkce5qnIvVJevvYvgVFn0Mbs7XvPQPSxAWyKrSTporf6geCyF1p79a+lBUAu1
	7jNqEXhhWo7OAvoEECBA8C3+libKqCtTiy7hZrPhOs1rgZXe4atHu3MhqTBoujzP
	oREflQZd/TIIRfWCx/WvtayoKKgVWnuuE+jXLuANlAYE5RyCoFDxtVnW8r0pmQpP
	38hlJn+9WmdBq4+ep/biN5iuf7uCC/1VHXMiH0qVE6VpxKrrngxzRElulVkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736888985; x=1736975385; bh=KdZQmxGQPvcas4WhoXt+wk59JB3YpmhVQvV
	q4muZTU8=; b=V0dS++wGZPiQNJY80zLYjr+rt4RcWdArSCIaRX9vEikxw3uWnPo
	bfCcm3Tnc5re8VjbHxJO/WN9N6hCxFvSQAFJWQAe8qCISyJDYCTBcJk6xcFmMv0L
	4uCmeZOw7tKl/fLk4m+S9DEs6axCsKW/tSgD6YeGpHKenk6KUmPASJZnFR/ICMYT
	TjXxqRWXoMmwezjk8a3F05yUETiAyqPDZuNiXPC4fUEo+TQlxzo/QEm1AvJtGvGX
	CFonjhoiTGcy9fJtjaXfPFzE67Yt75zAzuK4KW9JashJLdCwlOgL1Nw6XTYX/U/F
	48VfPX1aJAmfqmTyzcS5s721Osq2U7+h94Q==
X-ME-Sender: <xms:mdKGZx5KwwantlsnbA_fbnnidfiwqGN64S4ODCrp5rtdu7Xh0XD3IA>
    <xme:mdKGZ-6eW_Vjojyj2bygX9RRBh8-jCOySQWw2NAToPJJJ-w0rvzWI89xN-veEroDp
    i2AaQV6oqrWkkV3lg>
X-ME-Received: <xmr:mdKGZ4fXlKc96QsD2xwADe-_TK93rNVrRUht8ASbOv7oo85Ph8PwkuqmP_Q_e5_wZLKlZmJa0aY1Yl5Z51rAfpVZ0SchAGHlNwcr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mdKGZ6J6Wht1Rps2ajk76Qx6HtnhYX-LyJNdz3iy0fuWs_vPraxIwQ>
    <xmx:mdKGZ1KHT7UBIJJXaHdDjoIyjklss2rqlbBJrDDfoHIqYLCtKu-ByQ>
    <xmx:mdKGZzzm7gLmsCZaB4Az4hboANxk9Lxk2MPWHfkUdl7AElv4qewd1g>
    <xmx:mdKGZxKBf5xjsBe8JShjRElHGgM9xakSe7uN8q3P6VMZhM6f4ilOyA>
    <xmx:mdKGZyFgJYjUYhAcB3wK1gNv4C8z87mcEkLtGQnJhUOBeLtyquHhhY8h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 16:09:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 00/10] compat/zlib: allow use of zlib-ng as backend
In-Reply-To: <xmqqjzax2nqw.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	14 Jan 2025 11:34:31 -0800")
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
	<20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
	<xmqqjzax2nqw.fsf@gitster.g>
Date: Tue, 14 Jan 2025 13:09:43 -0800
Message-ID: <xmqqa5bt2jc8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Changes in v2:
>>   - Wire up zlib-ng in our Makefile.
>>   - Exercise zlib-ng via CI by adapting our "linux-musl" job to use
>>     Meson and installing zlib-ng.
>>   - Link to v1: https://lore.kernel.org/r/20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im
>>
>> The series is built on top of fbe8d3079d (Git 2.48, 2025-01-10) with
>> ps/meson-weak-sha1-build at 6a0ee54f9a (meson: provide a summary of
>> configured backends, 2024-12-30) merged into it.
>
> I think you are now also textually depending on the fuzzer thing due
> to touching meson_options.txt and ci/run-build-and-tests.sh with a
> later step.
>
>>  -:  ---------- >  9:  7ae8f413d4 ci: switch linux-musl to use Meson
>>  -:  ---------- > 10:  2dd1b49e4f ci: make "linux-musl" job use zlib-ng
>
> I will see what other things I can find.

Yup.  The patch series for some reason still does not seem to apply
cleanly ([09/10] ci/run-build-and-tests.sh somehow seems to be
troublesome), but it was easy to wiggle it in when the base was
prepared with these two topics merged on top of 'master':

    4610af08e7 ci: make "linux-musl" job use zlib-ng
    b2ddd0b33e ci: switch linux-musl to use Meson
    5118183ef4 compat/zlib: allow use of zlib-ng as backend
    08bf6b2062 git-zlib: cast away potential constness of `next_in` pointer
    ebf98412e3 compat/zlib: provide stubs for `deflateSetHeader()`
    29829e5714 compat/zlib: provide `deflateBound()` shim centrally
    8f19b26bbe git-compat-util: move include of "compat/zlib.h" into "git-zlib.h"
    8aab230253 compat: introduce new "zlib.h" header
    1ce001beaa git-compat-util: drop `z_const` define
    b9d4bd5467 compat: drop `uncompress2()` compatibility shim
    db620fad21 Merge branch 'ps/build-meson-fixes' into ps/zlib-ng
    64156589d9 Merge branch 'ps/meson-weak-sha1-build' into ps/zlib-ng

I think the reason is because the other topic that touches the fuzz
thing we see in the context of [09/10] is not ps/build-meson-fixes
but something else that is before "--fatal-meson-warnings" was
added.

One request.  You seem to have started using --full-index when
generating the patches.  It is extremely annoying when a patch needs
to be mucked with an editor to inspect why it does not apply and to
tweak it to make it apply.  40-hex does not help at all if the base
commit is not conveyed correctly, as the recipient will not have the
necessary blob objects _anyway_.  And 40-hex is unnecessarily long
in order to protect the recipient who uses "--3way" from using a
wrong blob in a fake ancestor tree.  Please stop.

Thanks.
