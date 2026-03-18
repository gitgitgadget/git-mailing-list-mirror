Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C9515FA81
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871046; cv=none; b=JGTxzPwPoHPfREXKzHQg4r1u6OpJjmQX1DXcT3DwzYSsFEeD9PnnyWC4wzGemq7/3IzP4+DhDf6gb9YXLcVQU3BJifrWQoaJ6AuXyJFz/NG2rSCm4bVhDfcrZDhBXG8QxCQQx6QeZCoKd1u29siIWnQgtmRzLP9FVbUE9jKCaPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871046; c=relaxed/simple;
	bh=9JofYNVgaEWwo4TQkfErdNYjAiXVg87LNkJ6HGB30dI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f70RqWZDZxh6g+0RQ0cN6pS9d1kQ9gFxXAv+d9ZBCydvf3P2jhL8vMpjnht4XeDXom6uHgEXjAX35wMIkkzik3pnonAAfdEdrXeb4zlJut8BhvH1o10LnaRXioH1Yv6rQzwnYC+UvUqdI9v+kAKHi/GmFIMQPuRF7R2qRgNIrpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RhmKAtbM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=upd2L+bB; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RhmKAtbM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="upd2L+bB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E41387A0176;
	Wed, 18 Mar 2026 17:57:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 18 Mar 2026 17:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773871043;
	 x=1773957443; bh=Ub+9QbQ6o99X5ehAPGGQlIYbBVb9HxQhy4f9Rt05ChQ=; b=
	RhmKAtbMzUUT7rzmp/aSR73DbOCw6RIuPHzFanElg62qt32Lg4Q0t8j7VCmAmYPB
	eHandTObkSliINKdhYPRmGSQcNeC0G3xipy6HBAOIHjjd2EydHzYjuNPMgjHYEqw
	NWInFuHZbQOglkjiAcId79PnfT+f6GJXhmAEsmrTXNN3/4HHOwM/Z99SRYvvsKbK
	Y/y6veN/TjwZrUdbC6nIwI0nqmAugfzvAowQX6f7XFuwMmvsHonASY7EHLap/R9T
	a9mLIDXwWvOf5GQ4KBLi2j9BbiJE7u60y+Ol2tbsHWgh+iPTXaKiR8Xqo9xdwmdf
	s5O6/G3AefYG1aG0KTRybA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773871043; x=
	1773957443; bh=Ub+9QbQ6o99X5ehAPGGQlIYbBVb9HxQhy4f9Rt05ChQ=; b=u
	pd2L+bBwpqzlX7TJyxH9TaWa4CcpOYIuKUUX9FwK9+Adllh/Y3GMKNa5fFUJQVST
	HdNPBjUwOJqdDwUItiZkCG59c6MKvjOmLqLMkR9dSCkIltV8z0IW89a0JbB14bUS
	vvwTNuLFNbOh+Gy3XohPs98TJEk2l8PO4sGnrc4c5ZDD9VtMRkCOVasl34Zeol7y
	Tx1LziFVKyJoYqzdjUsTLhG13JfrvONUuQZvnRbfx2RvF2vweVxfngWrAKSHgy2V
	jIHfGr6Inf1xBmbkjLv8FxRzWx3HUH2B4/Nfd5/53TfSSJH6X34cdXnXM1A7l165
	aFGsrO7DevMH2WhD5ZczQ==
X-ME-Sender: <xms:wx-7aWBA6_a6w1OFRhxMfu-50TkgiDAa67RXynby3x8vSHTfHChC8A>
    <xme:wx-7aSytThWqLbApqO_OiPX1PseiIocU2PHGq7ZqUjzHlESXGPCY8zZnJR3KD97K1
    6lLqDxyd3gcmEfKr5gNurDZM8CixKBCFLH2fLB-3TlaEdpBUNAKDfo>
X-ME-Received: <xmr:wx-7ab0f6XmWXGjk7zBpmqXEzNJxypZupAacSgVXhR7B_QWrYNs5pEWoQd09a8eL6os11m2yIUmBWJSfhFEhEmURbzZ1rAAtDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wx-7aay_sRGSpVo4fbu8OiGZl7m0ed1lgj53-srIAtxwIv9-b1yENQ>
    <xmx:wx-7aaH4J12xY5eDlz0ilVC3L54Z2qaARvDHH7XEb4Cz39KNtyuKkw>
    <xmx:wx-7aVbiHrhvOPkPdEZy4elL2020N69ZjbSPQ4ye9BpqvDyveuSTWg>
    <xmx:wx-7aUD-odP-AA3pruMYu7hYeD6RGuz-6x_mWH3HgOYl-FUsDP_Z2A>
    <xmx:wx-7aZYIoOd1PSRcDJ-4iuAnWFbh_CVv2N9ZAtPSb4RQ1NUxKNmu70ds>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 17:57:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  me@ttaylorr.com,
  phillip.wood123@gmail.com,  ps@pks.im
Subject: Re: [RFC PATCH v2 0/2] push: add support for pushing to remote groups
In-Reply-To: <20260318204028.1010487-1-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Thu, 19 Mar 2026 02:10:26 +0530")
References: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
	<20260318204028.1010487-1-usmanakinyemi202@gmail.com>
Date: Wed, 18 Mar 2026 14:57:21 -0700
Message-ID: <xmqq7br8pzr2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> This RFC series adds support for `git push` to accept a remote group
> name (as configured via `remotes.<name>` in config) in addition to a
> single remote name, mirroring the behaviour that `git fetch` has
> supported for some time.
>
> A user with multiple remotes configured as a group can now do:
>
>     git push all-remotes
>
> instead of pushing to each remote individually, in the same way that:
>
>     git fetch all-remotes
>
> already works.
>
> The series is split into two patches:
>
>   - Patch 1 moves `get_remote_group`, `add_remote_or_group`, and the
>     `remote_group_data` struct out of builtin/fetch.c and into
>     remote.c/remote.h, making them part of the public remote API.
>
>   - Patch 2 extends builtin/push.c to use the newly public
>     `add_remote_or_group()` to resolve the repository argument as
>     either a single remote or a group, and pushes to each member of
>     the group in turn.
>
> RFC notes and open questions:

>   - The current implementation pushes to group members sequentially.
>   - push.default = simple interacts poorly with group pushes when the
>   - force-with-lease semantics across a group push are currently

I am indifferent; comments from others very much welcomed.

>
>   - I will also add the tests and documentations in the next iterations

Hmm, is this still valid?

> Changes in v2:
>   - Remove UNUSED from the declaration in remote.h (patch 1).
>   - Drop the persistent `remote` variable from cmd_push entirely
>     (patch 2). Following Junio's suggestion, the default remote
>     case now folds into remote_group so the single-remote and
>     group cases are handled by a single unified loop. There is
>     no longer any structural difference between pushing to one
>     remote and pushing to a group — a singleton is just a group
>     of one.
>   - Move the --mirror+refspec and --all+refspec conflict checks
>     inside the loop so they are evaluated per remote.
>   - Add a URL/path fallback so that direct path arguments like
>       git push /tmp/foo.git
>     continue to work correctly after the remote resolution
>     change.
>   - Add a test script t5528-push-group.sh covering the new
>     group push behaviour.

I think you added 5566 instead of 5528 (the latter of which is
already used by another test).

>   - Update Documentation/git-push.adoc: DESCRIPTION, the
>     <repository> argument description, and a new REMOTE GROUPS
>     section documenting the defining principle that
>       git push <options> all-remotes <args>
>     is exactly equivalent to running git push <options> r$i <args>
>     for each member remote independently.
>
>
> Usman Akinyemi (2):
>   remote: move remote group resolution to remote.c
>   push: support pushing to a remote group
>
>  Documentation/git-push.adoc |  76 +++++++++++++++++++---
>  builtin/fetch.c             |  42 ------------
>  builtin/push.c              | 124 ++++++++++++++++++++++++++----------
>  remote.c                    |  37 +++++++++++
>  remote.h                    |  12 ++++
>  t/meson.build               |   1 +
>  t/t5566-push-group.sh       |  95 +++++++++++++++++++++++++++
>  7 files changed, 303 insertions(+), 84 deletions(-)
>  create mode 100755 t/t5566-push-group.sh
