Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BC72770A
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750056; cv=none; b=TTCV/XDDdwD8OxMd4LhOBxDfHR0qKA25mP7/ZW2Ijoupip4WhkACI22a4QEDz/nyaGVyBBAqN91ZO7J427bHis5UrRcKuMufn7VoSiojDhxBrjGtoUNujsk6BmgJT6Ux59G7jkPUqL2U85i6XHpAo3Wj9TT+gKnjs0YLoAJDbXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750056; c=relaxed/simple;
	bh=z29wub8aI/+6Kg5mRcFiihdA7Yc57JsOLFlxBuELYBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cYQM9uRLXaHDx7e0XqIJH/+l5WgZe08teI0vPIiRo8L64LJU4K/kYYojK5++DhS5gFd5MC+TCRHLv7RItzMHdEmSV5xS2y3/0rLHn1ScpHwCm0JIrvxushDlAkKcJzxqWtLyox5/Tw1lEBFYHTyuyiDfXTRzHkQPQAau9qGEj+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L7WnxdrI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NJIsRke/; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L7WnxdrI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NJIsRke/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 248C21D001C1;
	Tue, 10 Feb 2026 14:00:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 10 Feb 2026 14:00:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770750052; x=1770836452; bh=HbJJ0Fhgn8
	Z0/MbbjlB7fdlsyTmzNgMXLSjZ4gQlL7c=; b=L7WnxdrIF1z0dCA5JKn62WWaCY
	FasjnKSZSGD7kBcrseaYkJbEc+PuZRGjqKtwIFxCiLmrxD6ePnBRQukZ86gYQNCe
	8wUbMl0EZ+hsmywHuuuYwOJlmKrYpAHXjuF6lyZgraHVhsjGsi/ozla1PAx4yQpm
	uWRksXEDeAXW85QWma1cOnV1/WsFO/eODfhhfkWmG9b5fwVCLCroBXFdXEu3uAgB
	oRke0r8I9+Ym+wru7bpJH7Jgj/c5Vhttd6JrkVCI+eE2qNfAQrqotGXCWfz1DL8O
	Ei3IiwVDMJkkLe2IqXsYqae+cjj1YsE82s+WCDodYGntOp8K6GGzUk7gaZKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770750052; x=1770836452; bh=HbJJ0Fhgn8Z0/MbbjlB7fdlsyTmzNgMXLSj
	Z4gQlL7c=; b=NJIsRke/doiHndw6MA+dw2sOqguSoahLOCHsKhdtXZdr7C4+TX1
	GxambsFN/Mdy8VDII2hhKH8pTfOLhonqmX3hV1QcAQYDPrh2jrb5qLOWILvM+Xsg
	oNJLODbuGvU3+pRCQ1Jv3PuumpUbWULaxF9MQYJyWpDDKJITxazgvdjKhzK2bpXw
	HNYrGM0DY7d8G9TxXMoNftLRqINntbJuHphaysUSr+oQ1Q16JMvfSzA2Pk938aIO
	s4BZNVSGSpSVgKq06msNQo4/vMIF5YwF2LjY3pPjb1oB1KI3c2XoHaJYA9SrdyHV
	DY0fR6Cg59CgsfuKjv0JSd+NZYRKg56REUQ==
X-ME-Sender: <xms:ZICLadNSSBJ1fdtI7ykvsUSlLbNbBdkwiK_eCGUvlyG3JbbwvhdvUA>
    <xme:ZICLaW-W53rLNY_NnTYytBpP8iQynJuRGmeL2XS71j5-AiSGMVfs7j0J5ZCaOegpp
    ZAXZv8sOsNV7kGmqgJ8lmeYoCyb-hGKJtslQbrYxArZPLhDyy1l2g>
X-ME-Received: <xmr:ZICLaRTVAMSaAKOiNSsPnXinZ5hoOjGYfIEBzxescJVb3Py9fCQzDmSdi0nQfzaTir0UedvOPW0vPTkvAOLXc09SZVcAoO-uBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegthhgrnhgurhgrkhhrsehpmhdrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:ZICLaYm_WtN_0RDHEISLsopCjRkZuXjClwVNa0oluQmmmK8AhZSxIg>
    <xmx:ZICLaRTZRZPeGS4u2xdSbOomKFh0t9_vEgAtZPTMBRlvxsAoO2rO_A>
    <xmx:ZICLaWOzyzowe-wg4TvGV7xxcuU-CYkuhcwl1wCIHYYYR-2fla1Lhg>
    <xmx:ZICLaaVmFc028Ex3GXdb5r6TD1mIrrKzwxRFnkbzD1vgLrApth2lpA>
    <xmx:ZICLaZSAgI-V3-PkrpMC8hKX52gNwujq1_A4TXcItsDzRK1HV-2q-T39>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 14:00:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Kethi-Reddy via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chandra Kethi-Reddy <chandrakr@pm.me>
Subject: Re: [PATCH] add: support pre-add hook
In-Reply-To: <xmqqldh0zcpa.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	10 Feb 2026 10:16:17 -0800")
References: <pull.2045.git.1770737573475.gitgitgadget@gmail.com>
	<xmqqldh0zcpa.fsf@gitster.g>
Date: Tue, 10 Feb 2026 11:00:50 -0800
Message-ID: <xmqq8qd0zan1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> The hook takes no clue from anything derived from the command line,
> not even the pathspec (or list of individual paths computed using
> the pathspec by the command) or the mode of operation like '-u' or
> '--renormalize'.  I am not sure how effective a decision the invoked
> hook can make to approve or deny in this lack of information.

And I do not necessarily suggest passing the pathspec arguments or
command line options that the "git add" command received from its
caller down to the hook, which will force hook authors to emulate
what "git add" would do to these arguments and options, and they
will certainly get it wrong.

I wonder if we can split write_locked_index() into two so that
writing out the in-core index to the temporary/lockfile can happen
separately from the call to commit_locked_index().  If we can do so,
then the following would become a viable and better implementation
of this new feature to run the "pre-add" hook:

 * Determine if we will need to run this "pre-add" hook, at the
   location in the code you addded the run_hooks_opt() invocation,
   but do *NOT* run any hook there yet.

 * Instead, create a temporary copy of the index file if the above
   says "Yes, we are going to run the hook".

 * Let the code path to update the in-core index, i.e., letting
   everythning up to the "finish:" label to run normally.

 * Perform the first-half of the write_locked_index(), writing the
   new index contents into the lockfile, but stopping before
   committing it to the final name.

 * If we are running the hook, run it with two arguments, the name
   of the temporary copy of the original index we created earlier,
   and the name of this lockfile that has the proposed contents of
   the index if the hook allowed "git add" to proceed.

 * If we ran the hook and hook succeeded, or if we did not have to
   run the hook at all, then commit the lockfile.  Otherwise abort
   the "git add" command and rollback_lock_file().

 * Remove the temporary file we created earlier (if any).

Your hooks can "GIT_INDEX_FILE=$1 git diff --cached --name-only" to
find out which paths already had changes added before this
invocation of "git add", and similarly using $2 get the list of
paths that will add further changes with this invocation.  The
latter set of paths you can inspect to see if you like the
additional changes brought in, perhaps like

    #!/bin/sh
    paths=$(GIT_INDEX_FILE=$2 git diff --cached --name-only)
    GIT_INDEX_FILE=$1 git diff $paths >patch.txt

    if grep "^+.*secret" patch.txt
    then
        echo "do not divulge company secret!" >&2
	exit 1
    fi

or something.
