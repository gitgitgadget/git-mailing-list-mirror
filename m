Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF25E2DA779
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752077293; cv=none; b=VuezyRH3X6LNso6euzbfYD254YkOzJyOid35HDxDUTPRB41g7eagTmWgr28yWm5+HzC0dHO9RNFmU58ofeUaKUJyMlYda7st/6BC8V3bkmFCcKFzetJw77sfRtMCQU4HtpD7CfecbyP6yHY9vVyCS8LsCxJyvqc4BTc+SMY7FnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752077293; c=relaxed/simple;
	bh=EynJ/CLMrMbFwTzC2WDD2aQ/qI5WFwp6EJhXtrkTUTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0H/cFcCJPS+/LUEzmFCkVM/E5YjGeEwGOSXgtW64MhMyh4EePgH00kkxofWU0hvqThKYTmTkAOemLgRnOb0oWI4J3YLMAg0vq3xa3ylrIAd+OSbh7q0jmMxHqhR6GsiTgt3LzpVkduUuPIMK3TvjGeXx3KfHPmaiBxaR6zFJG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eBKDR57t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ibOTNCEQ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eBKDR57t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ibOTNCEQ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D4A5F7A0318;
	Wed,  9 Jul 2025 12:08:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 09 Jul 2025 12:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752077289; x=1752163689; bh=3dUTwtwhDX
	VKACqfrgqyhd7PeV+leQ9NuaUTMBL3LuE=; b=eBKDR57tA7tbVNiyabaReEVVxY
	OTBbmGpMnr9sqSyc7HVtKbMy6ZFwn7kEDyqUD9xt0GBPyDXgTee+3czvEefVLQZy
	vL1gRs4iE3sVfC/npmDcqVYkNQHgJxw8o2l/m38n4FK9IrdyLsr3fBuHiwbWFZsD
	DmCAoTNpk8nqLF1gqRxF4L+xxAVXSZpYNAQS+ZXWhwp073SqQn84ChMsWCQGc6Tm
	zN1bFY6Ce2SX+SxHnrID+0TDb6Mx1VrMTtg9V861anc/KmX2dTXrekZta71RQWFB
	wvb1l900L5bew8j4AW5pXwfRO0/CGnPF3Ihq7MhT7L0luJZfxkO41trtleKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752077289; x=1752163689; bh=3dUTwtwhDXVKACqfrgqyhd7PeV+leQ9NuaU
	TMBL3LuE=; b=ibOTNCEQlCoag6P/dtrhVU6x+Z/DJpu7BAKlOFOrl1QgL5IXffD
	fHF8SZ+KHTTFqWlmxUGI+h5k5vi51vkirsdhgClydrwN3MB+SGclSxB6pZQu0AeS
	egxXgaUtdwrSG5OWUspP4PT4s3Wft+HcPiWvWqIq5ZxVoGZTaCPQQyf7Ws7ZVVWS
	h54ttaed+qTHhE6kfLD3YXHMHE6xsYRqtfmmtBZZu9pms2tqrD5144UW431VwicS
	eDyOCvufG9omFGeuNMNmKvqyhuv1g4yS4LddHQm82HOwgt+symN22KkUHIPh11ve
	TOwkBpjCpOaSbPJaW9as3T9yeqF2NjROglg==
X-ME-Sender: <xms:6ZNuaBZxTXeekZgCUPONBKcTrCd0ePog67oqMahINCWm_ghc0mSJSg>
    <xme:6ZNuaLryWOhOqGNU9aiaJMV6HJG0n7Najp-Uo3tHoGl9KzjXPMk5oWYUYqunDgqvX
    3SjUJ4sqtDCsLTpeg>
X-ME-Received: <xmr:6ZNuaNb4NNCUAUFsqz-Co4lD4D_t7usdG4hRBZMDvLv3tX2EXziSE4XdZNn0LQzEVDmc5LEqHSTspWSTgqtN5LdIM_Xr8244HVcqldg31nXXps6HoZ53>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkedttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvohguugcukghu
    lhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    fgveefveeihfehhefhgeethfdvffehfeehueelheeiffeuvddvuefhveffiefgueenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpoh
    gsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:6ZNuaLSyx6HSQarolAnr2tQbTtH056JU_jlYEXE8n3n6E3ZLOOc2bA>
    <xmx:6ZNuaM5PFi34V4ivHRJM5eO5qgzAODuXczPwtm2Mr1CCsMihndeVvg>
    <xmx:6ZNuaIwY7uFW0a7pYn5DRijtnud0rGvvCNb-CPiuK6Y8Ub75wSjdWA>
    <xmx:6ZNuaDT8rIgTWCEUX1hJYbOHxoqunRk_NU83_D-7bJ3B8NxQfa1uAA>
    <xmx:6ZNuaMRTuKsNJ1PAjTPEKTPYs1t3cDozXrpaAYKU0tWaEujEbn49TfXJ>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 12:08:09 -0400 (EDT)
Date: Wed, 9 Jul 2025 12:08:07 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t: avoid git config syntax from newer releases
Message-ID: <aG6T5ylikwrGEEo2@teonanacatl.net>
References: <aG1_eqSpH46UddZJ@teonanacatl.net>
 <20250708210529.1214574-1-tmz@pobox.com>
 <iuravzuqoqagie37is72e773zufuxcedwnc4i6ehhklpszg25t@bzu66havljcq>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iuravzuqoqagie37is72e773zufuxcedwnc4i6ehhklpszg25t@bzu66havljcq>

Justin Tobler wrote:
> On 25/07/08 05:05PM, Todd Zullinger wrote:
>> In a recent security release, 05e9cd64ee (config: quote values
>> containing CR character, 2025-05-19) added calls to `git config get`,
>> `git config set`, and `git config unset` which are not present on the
>> maint-2.43 branch.
>> 
>> These subcommands were added in the following commits, released in
>> git-2.46.0:
>> 
>>   4e51389000 (builtin/config: introduce "get" subcommand, 2024-05-06),
>>   00bbdde141 (builtin/config: introduce "set" subcommand, 2024-05-06),
>>   95ea69c67b (builtin/config: introduce "unset" subcommand, 2024-05-06)
>> 
>> Revert to the previous `git config` syntax for older maintenance
>> branches.
> 
> Thanks for raising this fix! Apologies, it slipped my mind that the
> config subsommands wouldn't be available on older versions.

No worries.  Thanks for working on these CVE fixes!

I thought that the CI might catch those failures, but I
imagine they slipped past others as easily as some other
failures slipped past me last night.

There are unrelated test failures on those older maint
branches which make noticing any new test failures less
likely.  Even more so when you're working on a security
issue and there is less time and fewer eyes on some of the
less important details. :)

I looked at a couple of the failed jobs at the time and they
were unrelated to the tests I'd changed.  I incorrectly
presumed that was the reason for all of the failures.

A few (linux-leaks (ubuntu-latest), linux-reftable-leaks
(ubuntu-latest) failed t7450.50 (submodule must not checkout
into different directory) with:

  + printf sub\r
  + git -C repo mv sub sub
  Aborted (core dumped)
  error: last command exited with $?=134
  + rm -rf sub repo bad-clone
  + exit 134
  + eval_ret=134
  + :
  not ok 50 - submodule must not checkout into different directory

I don't know if that is worth looking at, given the age of
these maint branches.

While I was poking though, here are the other failures from
the maint-2.45 branch runs at GitHub:

Several jobs (linux-musl (alpine), osx-gcc (macos-13))
failed in imap-send.c and http.c, with:

    call to '_curl_easy_setopt_err_long' declared with
    attribute warning: curl_easy_setopt expects a long
    argument [-Werror=attribute-warning]

I think this has been fixed in later releases.  It rings a
tiny bell, anyway.

The 'pedantic (fedora)' and 'win build' jobs both failed
with:

  Error: object-file.c:58:9: initializer-string for array of
  'unsigned char' truncates NUL terminator but destination
  lacks 'nonstring' attribute (33 chars into 32 available)
  [-Werror=unterminated-string-initialization]
     58 |         "\x47\x3a\x0f\x4c\x3b\xe8\xa9\x36\x81\xa2" \
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  object-file.c:80:17: note: in expansion of macro 'EMPTY_BLOB_SHA256_BIN_LITERAL'
     80 |         .hash = EMPTY_BLOB_SHA256_BIN_LITERAL,
        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

which I presume is also fixed in later releases and may not
be worth fixing on these old maintenance branches.

> The changes here look good to me. :)

Thanks for the extra eyes.

-- 
Todd
