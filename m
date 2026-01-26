Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BEB283FEA
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769443568; cv=none; b=lnztz+7ZkypxZHfDq6A9xNLu0U7wL0mf/v3bXQlRlH9Z/2/aNWk0wNyN9JDAJ9p/5V0hUGcxLb+ZuoSzk6NU9UmluuIEvELXG0OC9DHlZ1yV3JAiyVi4DCfKLYBQ9TnuOKRNZn3sLpDVD1tbu742LFhsEYgU7dY32c3ZTGywq6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769443568; c=relaxed/simple;
	bh=Mk3Pt5tuQBj8+xKR8Wpvsnsx9KkTd8z7ddpzpTg2mtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bEP9fwO4hjY5U8ZqTXRT9YbM0FYwDJQFnj1G8AKj/jdIKvw6s7FjWBKbnGo9MJdB2igwyy104ujEGci5kh6RHdnHdloKLCLt6jo+Luhc+fgIwj7JvitC1wb1EsowyCXlNMIqFMEOvJVhtRpeqds/rzUi38/ZmLPmQnx6ngkvMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YabWokmM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xbZj+qce; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YabWokmM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xbZj+qce"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C8621D00109;
	Mon, 26 Jan 2026 11:06:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 26 Jan 2026 11:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769443565; x=1769529965; bh=ai8LEUIAN6
	Zep7p7XHmvot/MIMg0f09l1WR4DySxi+g=; b=YabWokmMdcklNSzvynLZabqjBc
	03mci5Olxj1h/kQPDZmx65q7gy2YmLuZOLUy6zOk5Scw1KOzo47ij8wQATurVSpV
	ZLrmXxLBVZjf5wdUP9LX1MrVz97pzXA12vEf9pAlChcE9TkVnSJkJ9gmIreRKC/8
	Iq8VuZgn2pQTO0fJf46z8022FFwf6jPABB6QmizKa+u6XBp8eZUxFWPF6veXW4pc
	HnXOOUeulFMCCOuENtumFFwyVnUg9beMaw5o8ImCpaXa1QH9dvw7lWR1qUaZAFtZ
	DpFihhrJ9o7fV4axno0XdTsqfQDdsx+1hx2dLjVJ27RArfRCt756LMjXf4tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769443565; x=1769529965; bh=ai8LEUIAN6Zep7p7XHmvot/MIMg0f09l1WR
	4DySxi+g=; b=xbZj+qceuM/722nzzgEljeu9bTH4pL+quT6YaU5UIDKReou3kri
	Lxc5aP2dXVEraMlyUByKL8Jl7JkaZN0SAUNN6NGOmxcBocT8FFG3os2U1sskN/PZ
	LhhLiBJJ5obNMUp+mtTxCRyO4kNnAg5fwzdV1XmR8QT8cRfer8kWOLI4A71XOdf2
	vSqgjqXO7yu4NCruq3iRITJtXDf+lVUry1pAK0mD6dtp9/X7sR07ATdvqJ6cj2mj
	nIQkrUI6kHpGb6hsd6IwwCyhD6aUL2HvNaXfMTkfJu0ZnA+cwW6O+18IGu04BqmK
	FjUp45WYEyIuX7kyvfRXopuuaMiFuVMR9tg==
X-ME-Sender: <xms:7ZB3aQcWv7I519GblvVsw1JVjn4mJzjPNIkyPRMIYubMM-uI4ismoQ>
    <xme:7ZB3aZGRx0S508nUfbsVD2XEUOj-FuXLtoWhkE82szL1uP7Q--pjmzJloQzK9M7ee
    o9YJItBxsqa6_dH4LNM4hqODx0iOm4EIiX4r6eQysc5TL6sZktC1zM>
X-ME-Received: <xmr:7ZB3aZ3Tfygch5aQYULeQv4xlrZt_PI334MD_vw6IQ1Kk1VDFIGLHWj5HbZHEOivzSUenJXX8Blmuh54IiAlAbgzdKte5Z_3wo7z1Fo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    hohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7ZB3aRlS6daSpUpOAuxwvm3qFJtoANJqdDD6_pBQBZYcVDVm2jdPWQ>
    <xmx:7ZB3aZ8nPLP6bcLydcUupE85m2Tj15YhcOpwqxIh3tA2Cgvjuiz7vQ>
    <xmx:7ZB3aWoSxsiX_BZTx-JW5xsGi5o_r8tDOFmw-LQjEi6V4c2UoKRCqQ>
    <xmx:7ZB3aSlb0qzKx3j8Ve72FzBiXHjcUGNwt15MvCE7DqjB0ijU0is3sg>
    <xmx:7ZB3af_9T6OlwnPa2YMmaJGDtt8RQVE2XLWzt-grCYzPjMAw7bdLo-Zg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 11:06:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(*-leaks): skip the git-svn tests to save time
In-Reply-To: <82b656a5-e5c8-4056-8ec5-4bdab9ef7128@gmail.com> (Phillip Wood's
	message of "Mon, 26 Jan 2026 09:47:46 +0000")
References: <pull.2031.git.1768584676520.gitgitgadget@gmail.com>
	<b649f137-7140-4fb6-848a-b3408e54bbe5@gmail.com>
	<xmqqa4yc5brq.fsf@gitster.g>
	<79c29032-dc32-4030-95ad-dfbd50d9b6ab@gmail.com>
	<xmqq1pjk2sv2.fsf@gitster.g>
	<a29ce07a-9585-475e-bb3d-4742f2ec400a@gmail.com>
	<xmqqqzrggr39.fsf@gitster.g>
	<82b656a5-e5c8-4056-8ec5-4bdab9ef7128@gmail.com>
Date: Mon, 26 Jan 2026 08:06:03 -0800
Message-ID: <xmqqikcojr4k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think that unless the libsvn that linked against was built with 
> -fsanitize=leak we wouldn't find any leaks in it anyway. When I wrote my 
> original mail I was imagining C implementation that forked "svn" but 
> replaced the perl code with C that called the appropriate functions in 
> libgit rather than forking git.

It was the scenario I was assuming as well, but I simply forgot to
consider that we want to catch leaks in our "client" code (client
from the point of view of the libsvn library).

And you are right.  It can be done to check our leaks without being
able to touch libsvn to fix their leaks, even though we may have to
filter out noises from the leak checker if there are their leaks we
cannot plug.

> In that case I think there's an argument 
> for checking that our code does not leak. Anyway this is all rather 
> hypothetical as we're not likely to rewrite these scripts in C.

;-).
