Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB3136AF5
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160446; cv=none; b=GNbunkeGVJHTKe9w7014ZEHfwbUtr7wQoFjGTcFIf59BfBlgBgIkXUCKN+n7c9MyNrodyczmwuXhXHOqDPHaehn3ViRmt0qrwRSmh5VRhQRtIFJiyuTwi3EMtQT+3MXoh8hHegXHzS4ABHryTagGEhrC/dd60bQhtL4z7IuZw/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160446; c=relaxed/simple;
	bh=aG+zArsHGwmB13hUgKSqbI6hw6WP6OAPbtELXtk2SHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YCnnttDrtKPxmnEa3rz7devcv/KVJOGm6AZVyrrJw0+EviuJx6zrIspJtu9VBHiY8FlF8YXRDDsQuPQMi+MWJEBGHjA5WvnEfswU/mViVBMssQE3zvLfbIbMQ2xJAwHPJDtiTfiOfNqSh7R8OOrbRcHHJUaxyhQptUvusegU03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k3w0JuPH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1QownGhl; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k3w0JuPH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1QownGhl"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0670A25400F6;
	Fri, 21 Feb 2025 12:54:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 21 Feb 2025 12:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740160442; x=1740246842; bh=F00R+c6Eju
	2piBXdQAsUtzBCSbwugUITDVG+p4NcX1Q=; b=k3w0JuPHa0OQkBYWS1GZmzPw1b
	pny+DgMmktAJqz+uIKd0y2ahcssCY6NgZdeFbK4nUa2vY4BRtUOj1G04bj5NXr+P
	O0l3VgiHLa7w6RPK9XDdyLQFtKUBrWTW4kWDGwZVmUfwAM+wgmFoFIsYhm9UcsTY
	UjBVHoo6vs0HeU0AhSY0rPB3hAtoZxnM/qsrhl2+Jn/RBKgQYFSAMHmiM4s0WcCk
	AixZtFIY985KwTzod/o7kO8rRQeGpSomdI/7ScNO+yjsRq0ZBgDrDF1gZoaJ9OZK
	4lV+UU+EdD/SqiFt+tdezdp/AKuidzEQPAWIdGcvrBAafGFiRU13QTkN0eVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740160442; x=1740246842; bh=F00R+c6Eju2piBXdQAsUtzBCSbwugUITDVG
	+p4NcX1Q=; b=1QownGhl6STdk3VULEEh2bb4YPAbp7asJ4GD0dpso2g6IQUidcJ
	9KWyfq9Uw8j3Wpw/0UYtRX8ICFGGx95mYJHl4BpOVo1zjP5I4hFOCatdgD0NV9V2
	AEoavjHBSeUS5FKbRiQKTNu1awpxM503VZtuiYTaY4Xsu2IyI6DnXhk+fzTJyNmn
	134MHNiK6kWwLMLEi61CBAVVAdOjNsL2W/yMFMmQ/rurUUqdra9sRNm5e/1ukMQm
	+ttlxc9Om7OLxEht9EfivQi0eCq/dQIyB3lhKz1IM0Ikkc09xwcXIjG9xZhRL26w
	pe3LD4Bh9C1L8Q2XVjVFKxv01i+/08C9jBQ==
X-ME-Sender: <xms:ur24Z7uTbtkel4HHYljXVYla2hoGIlis3X8D4FKirsAEQsOGRZ4ahA>
    <xme:ur24Z8cEKY9CXZtOx3MPAFnWtKgwZbFG1RuMYLaMuTg4FF93qHAplYpXMzouFkXYt
    gYvJeCgJ8_8gLOo9w>
X-ME-Received: <xmr:ur24Z-wqlr-GpyD7IzcYvirHqS4eiZodoMQdJWdZX7mtPCJYdkOLnO527wrO0pZxdlEjvtj3S9YHewKYhAWwOGkSNeJleLMJI69Svq0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepthhoohhnse
    hiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ur24Z6O68_sds4Y93ynySlHtms8EAPQIms3QKXD_KE-9R1v28gYcPA>
    <xmx:ur24Z7-t_OTUTwihdSTFwaoKFHOAf2hnNVpWn05Vag8OLrLDQyjfsg>
    <xmx:ur24Z6UwqtKjFHskkbii7x16hvt7sXXj7Y2myi9hUEUHND6QF0oYQg>
    <xmx:ur24Z8eF5Ppf0ZbyXCo8RkaSkbrHJnyBaN6NJbGH7L28YxsQVrW9zQ>
    <xmx:ur24Z2mairYu0NyrGvhDQyOzz_CiK6_JsYjJdxQxSSfE1sR8Ntg6Jv9v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 12:54:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  toon@iotcl.com
Subject: Re: [PATCH v5] builtin/refs: add '--no-reflog' flag to drop reflogs
In-Reply-To: <20250221100423.91075-1-karthik.188@gmail.com> (Karthik Nayak's
	message of "Fri, 21 Feb 2025 11:04:23 +0100")
References: <20250207-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v1-1-7d40f3b4e30b@gmail.com>
	<20250221100423.91075-1-karthik.188@gmail.com>
Date: Fri, 21 Feb 2025 09:54:00 -0800
Message-ID: <xmqq8qpzb2vb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> The "git refs migrate" subcommand converts the backend used for ref
> storage. It always migrates reflog data as well as refs. Introduce an
> option to exclude reflogs from migration, allowing them to be discarded
> when they are unnecessary.
>
> This is particularly useful in server-side repositories, where reflogs
> are typically not expected. However, some repositories may still have
> them due to historical reasons, such as bugs, misconfigurations, or
> administrative decisions to enable reflogs for debugging. In such
> repositories, it would be optimal to drop reflogs during the migration.
>
> To address this, introduce the '--no-reflog' flag, which prevents reflog
> migration. When this flag is used, reflogs from the original reference
> backend are migrated. Since only the new reference backend remains in
> the repository, all previous reflogs are permanently discarded.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-refs.txt | 11 ++++++++---
>  builtin/refs.c             |  3 +++
>  refs.c                     |  8 +++++---
>  refs.h                     |  5 ++++-
>  t/t1460-refs-migrate.sh    | 28 ++++++++++++++++++++++++----
>  5 files changed, 44 insertions(+), 11 deletions(-)
>
> Changes in v5:
> - Add missing documentation and cleanup the commit message.
> - I also see that 'git-refs.txt' in master has been renamed to 'git-refs.adoc',
>   but I'm going to avoid rebasing on latest master, since the resolution is
>   quite simple here. Happy to do it if needed. 

It is a good rule of thumb to refrain from rebasing when in doubt.

Shall we declare victory and mark the topic for 'next' by now?

Thanks.
