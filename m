Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFF68BEC
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736385151; cv=none; b=fEMzUbTHVI5hIo5xYqEEdEqKcZVBW9dBXJXlVWhzKg8B8IIrmbT4EH418oB/eeM8s+ZUsUYlpSZ75aDlUCyd3EgdQZmlWSv7TINwyfkXBW9OqIfbWFDx2xgeURjYuDYJd7tm4pAMbvJtSe7+XuxjOEwK+7YdTXbwiDwRUi8mKDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736385151; c=relaxed/simple;
	bh=hTqZuQ1ztoXiCGTJjjKeN/aKjbK025Yhlf4Ix3svD+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G0zS/fRlBdvGb6JlrxKw49aEya7ckjiOgC7lVThrXjvHe5/Kzf49avab37qvpxUv99NXk08fP/ZRMszZ/MMMimcrAWID5Mk+qtwdyJl5dg7H0BXCOQ0dULVGhwz3V3sUat4/gCtKFmDiXI0APJsOHVBx9IPoA+gX7CcxGzPlUjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NM0JOL7d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iE0f1QWj; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NM0JOL7d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iE0f1QWj"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 19CFB1140242;
	Wed,  8 Jan 2025 20:12:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Wed, 08 Jan 2025 20:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736385148; x=1736471548; bh=+QThZ0KTWy
	8pFpslTMJ0/hkzU6tNnqzyEggsTcKc8os=; b=NM0JOL7dDrhk9/UpdZ+UJv+dbW
	nkeEFXX85wQRxjW/tttF+QyDviAVguKJFLrN7Yq+HkhVU/aHbVWiPvF2JtbYdXx5
	2gY2j2H+5p2vI9sL++i/3mQQ8uJVNNCktjvvgp9hb3a3A1nfGTTzgTeo3bZyEddb
	Un5H/jV5BtWVd8z4X2gARlOcuTS9PmKNL2h6ReutHwemsH0UpfvjIiW17LzlLANd
	u6/zEntX39P60AdSw6rlMmQT16NyLDaAMh8bPLOdXYb/vfbgK+/G6Vvvew2mwWDJ
	8VAN/gszx/eeFZEyArrxEo+JWPt0m3rj2gIUgTUZc7ebhrV8BCYjdO1THgYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736385148; x=1736471548; bh=+QThZ0KTWy8pFpslTMJ0/hkzU6tNnqzyEgg
	sTcKc8os=; b=iE0f1QWjf2vFq1NtVNJ7g9+DXM6G3KKNJH5pObeiKOd8QGUmP8P
	K44+I9iWKXfuDoF2xwrGRW9VHD2H15pGWaa5D6+w9/YJIg1qNjFopxtONq6zXNuM
	eVFX2koAGVWXNJRvmKbOk4caoo5Y+noM6J/6mz4jawrS1opVMgE0BSjMR1EHSW0T
	TIlixOcsBWHMerBby1btko/YB8MBzvkd0I72IXwq+72HRBG66xfc8IZrOemjYvOz
	AtRdh7iLfJGN8Ak/wyuTsJ10g7xyxhcCY/y24J+h2wfP4uxy5A6F4yCsVV6G8aNl
	FyEAzOu9m9n42Cy8aLGtgiIEvD3JQO6P5bg==
X-ME-Sender: <xms:eyJ_Z-H1AhFOYv-r-6Vb2e41OgfABxiYIYw6Q0X-nQQv3jZ1iUac5g>
    <xme:eyJ_Z_XyjPiNUZeeJtTBqX5v6vDsgT-Py9PfcDScKLDBiIewQhVD2C10EfLSZzdyd
    0GuuD8yznxA5fEHaw>
X-ME-Received: <xmr:eyJ_Z4Loh93tq1oYnVvKUnrwwBC4PWdIOmIa2nCNc4XQnxNSHkHZM9P-oQ7AtfTTUKU-28gWQpeqoLnuMen4qBk68jiEIxl9Tk95>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeghedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehstghhrggtohhnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:eyJ_Z4E3fsbP4TF3IK9K2hTF4i5psL_zM_lA-zKEncoUcoCLKyOh8Q>
    <xmx:eyJ_Z0VMyy6p_3dJqcB7dxJ-APuaaGoezGS6bbGxVtQYFr9-Rwvhug>
    <xmx:eyJ_Z7MTmDlK003pWmTKk5fcC75AK6rQF4z_y2KoEqCnRAms7UV8YQ>
    <xmx:eyJ_Z73GFP1nH0QxGsFVRC-biwXk34Zgh8FULALI7TFHTDHCwS9G3A>
    <xmx:fCJ_ZyyQX_j-tFjma2JjXLi-hKSyGXHx-s0XG15Q3D64lIQ2kVYwvWbX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 20:12:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Scott Chacon <schacon@gmail.com>
Subject: Re: [PATCH] help: interpret help.autocorrect=1 as "immediate"
 rather than 0.1s
In-Reply-To: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com> (Scott
	Chacon via GitGitGadget's message of "Wed, 08 Jan 2025 19:31:46
	+0000")
References: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>
Date: Wed, 08 Jan 2025 17:12:26 -0800
Message-ID: <xmqq34hsn62t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch simply interprets a "1" value as the same as the "immedate"
> autocorrect setting, which makes it skip the 0.1s and simply say that it's
> running the command, which is almost certainly what everyone setting it to
> that value is actually trying to do.

It is a cute hack, but special casing a string that is a single
letter "1" in a value that can take a number smells somewhat bad to
me X-<.  If we were redoing this from the start, we would probably
pick a better name for the variable (with "delay" somewhere in the
name), but that is water under the bridge.

I however wonder if we should allow people to have their cake and
eat it too.  It currently says it is *not* a boolean, and manually
interpret "never" and other things, ...

		if (!value)
>  			return config_error_nonbool(var);
>  		if (!strcmp(value, "never")) {
>  			cfg->autocorrect = AUTOCORRECT_NEVER;
> -		} else if (!strcmp(value, "immediate")) {
> +		} else if (!strcmp(value, "immediate") || !strcmp(value, "1")) {
>  			cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
>  		} else if (!strcmp(value, "prompt")) {
>  			cfg->autocorrect = AUTOCORRECT_PROMPT;

... but would it be simpler if we made it an extended boolean, i.e.

    true, yes, on, 1  -> same as "immediate"
    false, no, off, 0 -> same as "never"
    immediate         -> same as what we currently do
    never             -> same as what we currently do
    prompt            -> same as what we currently do
    number            -> same as what we currently do

It would kill many birds with a stone (e.g., help.autocorrect=no
does not work in the current system as anybody would expect, but it
would with the "this is an extended boolean" approach).

I dunno.

Thanks.

