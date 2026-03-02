Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057C247D93C
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772479994; cv=none; b=ZHZf6zn54Eu5yoicKtxPmN8LlMAELh7UQ/O8vDplPOVgZvsUe55QT7HAOX1vy+XAci+fPLy3lhWv++lhH9sOT3g7zyACRtk9HEWtFjBtq3ILNc0wZlhC43ilhT9IZxe7VjLYExKSc/2d645PTNAn0jkUdhC2D7aBMi065uzJ7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772479994; c=relaxed/simple;
	bh=xmVGd4o7Auitx1NHQmSdM+kJvDrunR7AbCsDJEd2a4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hwPVtTsxI6vFpAZxcWrZPvgsNrWniS6Z4fV3aS0WXZllBbyjkbDPzyBWHXoLMOvdymM4tdb+rJX07nRiE/SLYQc2JbkrpTHmgmOA+5A0ykwrC2gSmx2CCbS1BmoHXAZJ3Sy+QcycTzlmYa2uFWYbbAXBAdtz6AtATguZlDV7jOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F7HVi4mY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XHxmChSA; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F7HVi4mY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XHxmChSA"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1F98C1400167;
	Mon,  2 Mar 2026 14:33:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 02 Mar 2026 14:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772479992; x=1772566392; bh=cKjJutsIRH
	Xu2rz7ghpAP1csV4zYbTlXZTjSiLr41ac=; b=F7HVi4mY5Z9FJXAqyGqUNbt8js
	bXIAkwtDrhplJQjqglEL7wdLdmsJW3I6FiJ9gdi88z5ZiDIMiKPl0UlH+ABmD30C
	g5i1oMYTx+iihhzPdM7UsrLUs43riyOL68MeJHfD2y5aMwtsWx71KdNld92xnU07
	nRWVUqZOcEOIXTcdj0RVgoxmEzx2yHpblfov9L3eFPNUNedRn9GvnhbjfT/k65Z6
	HgmxTWfKUQBY4x0g4jhKCag/ysvze6yszxAVY+tGHkU0YEaxVMbmDft8FOgInD5J
	rg9vg7/cBmXNP8Jzcn+EIIW0zecb9YSAG7xPZLRXgI0v6wc6g9xlqeuMcg6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772479992; x=1772566392; bh=cKjJutsIRHXu2rz7ghpAP1csV4zYbTlXZTj
	SiLr41ac=; b=XHxmChSAyMcuYfUri1WyCRovfCOjgcJcjAfdEdkM/JsdTQbHriZ
	TfgdU4ju6+QigcWRDn64rEZJz8xZqWRC+wutRde4oq+orKEc2YxvOU4YBrmjTa+s
	SJgwzpL5XZwlaPCprzMjNzbTJOZ4jqYy0aJfhNsSvfio1VJIXrTg6KPdU0PxThgZ
	oIoykq1nbtbzh8IrJik3eSOUsc20VdgRn2snAdLpeKAtTcuXkVA6IeUd5O+jGoR6
	6yDw/kD/SR+hpjMT+gAdMjz2LbX00L+irxEVEjPkENISiISn6EkN5/uLRZSSKx4O
	bT30iw8UFImJtkNDVjBo++3TNe+5Ix4t86w==
X-ME-Sender: <xms:9-WladZIJAEXsGSKULnE3aIK73wqY2VdPU5hN2uNXvMs1SqDQCA2fQ>
    <xme:9-WlaWpL-c0bFkAR1Ml0BIGwm7gIOcfDBROXBOUPtJjzjxNZnUmsgGWJpsbOpiohx
    DponDFlyf78PdFx3bXGmV-TNtZ0wdXTL7Fo9CGKZTQzDoOKF8Xz>
X-ME-Received: <xmr:9-WlaSM04gkrpeB-rJ6UlRGaFoRC2U7fnshk8vqyeBXIPtn-6EwuidLlTDQPKgxyhLCazgESZcv4gAdpltZtTg2ySgO9EBKz7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhes
    ghhmgidruggvpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopegurghnihgvlhesuggusg
    gvtghkrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9-WlaRoTG2kxay7luYFu1uNRKSKfmjUT8JMxpOUek7okMnNhO9v4rA>
    <xmx:9-WlaXdSXYPzc6p6IOKWuFayhQRmzVj_WgOFFYnSdygnWD8Ake6pIg>
    <xmx:9-WlaXRm1FCRD39ZKW51xxmwHFR0M4Hunn6w3PTl54qT3qbOfGr2RA>
    <xmx:9-WlaQYzRr1utS_UaSehLRNbHddVccmnB-ZYS0tw-vof7qEPLiYsYg>
    <xmx:-OWlaQenktvRAxBLD-OlSHtNX1g941V9uC4QtS4fpeTb6WR-xm8Mgz2E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 14:33:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Cc: "Daniel D. Beck via GitGitGadget" <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
  "Daniel D.
 Beck" <daniel@ddbeck.com>
Subject: Re: [PATCH] doc: fetch: document `--jobs=0` behavior
In-Reply-To: <25715312-b6a0-0cdd-d62c-3a4a840b0244@gmx.de> (Johannes
	Schindelin's message of "Mon, 2 Mar 2026 13:35:03 +0100 (CET)")
References: <pull.2047.git.1771443159369.gitgitgadget@gmail.com>
	<aZb2acEvAtNmt-4j@pks.im> <xmqq4inc5zlt.fsf@gitster.g>
	<aZggm7R-4VohiCYm@pks.im>
	<25715312-b6a0-0cdd-d62c-3a4a840b0244@gmx.de>
Date: Mon, 02 Mar 2026 11:33:10 -0800
Message-ID: <xmqqo6l6yqkp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Dscho, do you remember by chance why you decided to not be more specific
>> here?
>
> Unfortunately not.
>
> So I went on reconstructing the lay of the land back when d54dea77dba
> (fetch: let --jobs=<n> parallelize --multiple, too, 2019-10-05) landed.
> With that commit, the `max_children` variable (which `--jobs=0` would set
> to 0) would be passed via `fetch_multiple()` [*1*] or
> `fetch_populated_submodules()` [*2*] to `run_processes_parallel_tr2()`,
> which would pass it through to `run_processes_parallel()` as the first
> parameter (called `n`) [*3*]. That function would pass that variable to
> `pp_init()` first thing [*4*], which would fall back to `online_cpus()` if
> it saw a value smaller than 1 [*5*].
>
> So: The "reasonable default" is the number of CPUs, or more correctly, of
> CPU cores. It does seem, though, that that was considered common knowledge
> at the time, given e.g. v2.40.0's release notes saying [*6*]:
>
>   "git fetch --jobs=0" used to hit a BUG(), which has been corrected
>   to use the available CPUs.

The belief that "available CPU cores is a reasonable default" turns
out to be older than that.

Back in the days we didn't thread iterations of the same topic
properly, so visiting the discussion thread and trying to find older
iterations of the same topic was a nightmare, but I think I found
where the phrasing came from:

https://lore.kernel.org/git/1446074504-6014-6-git-send-email-sbeller@google.com/

This is a step in the second iteration of fetching submodules in
parallel topic from 28 Oct 2015, where "some reasonable default"
appears.  I think it was done in response to a review comment on its
earlier iteration which was:

https://lore.kernel.org/git/xmqqio5sni1j.fsf@gitster.mtv.corp.google.com/

Later the work resulted in a028a193 (fetching submodules: respect
`submodule.fetchJobs` config option, 2016-02-29).

https://lore.kernel.org/git/1456798040-30129-4-git-send-email-sbeller@google.com/

The variable fetch.parallel did not exist until d54dea77 (fetch: let
--jobs=<n> parallelize --multiple, too, 2019-10-05) copied the
famous "some reasonable default" phrasing to its documentation.
