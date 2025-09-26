Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298C615278E
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758925449; cv=none; b=cPhiXFHjxrWuLWXbwlAv9gHe9UdfJIhHqt8lyfd5EZIGKE2OUy5YkkBjCoHa9dpU3GZIKVdXus8r+J7gBlvZhn3mXABax32c4UXma/aHLi/GXq6KWmOtc5n91IQEVgwHUxXKL/84f0mkv1u5KMjhSwiMId7U5IwC1mmhpEBX6BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758925449; c=relaxed/simple;
	bh=7tRJ8UkD5b7mwuaIU+ECDPponrQZhyTYVOERYT87UYE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fkVnFvRjbrEv1BY0c9/q+YLEd5OCJDBiiMo8vrelfwQeZovfBAS53nShnOWD9hnOLaSkhzpUeQOeSTc/i0xiHdFmqKhxiFFthlXzD4qcctzn6/t5TywT7QI9w77N71u3WnNU+WRVnbEFErbSokFKy4+23Wm5eaSTjcMdqRMdvbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DcFE/0h5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ST1FoTmo; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DcFE/0h5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ST1FoTmo"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 638A57A009C;
	Fri, 26 Sep 2025 18:24:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 26 Sep 2025 18:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1758925446; x=1759011846; bh=kdwso9fm/qHBy0BVVyKGbmcYQhyMk88Y
	MAt21f908vk=; b=DcFE/0h5IKA0EDX8e8YM3SIeOdh1mr9XVE4PfdfvKV1ISpy5
	1+7vVAaVFE8L0/D2Y9yOyVQSX9VUgrGgTTZEXC3kwmf+5oN+j73J7mg7RMbZETrQ
	4h/hFb7Jgz6/A5MRqLjuBFr7YhI01qxq2AUyTHcLLDgGrpOyUvCIA7M6/NJn6X55
	/Bq8SpecFq3ClwPJagtBv41DMJmxryUhjdLNopvugk9T9vkqTD9aNA+yxEZvoLqx
	NeNiNb7Qnq8fnaNk/ZEvv6gscmEwpQjeoq5WOVKjzCgfQBwwFySJ4pGVoRL+eAji
	i4ox9IqkBKQWqulw/eJvWfUJLZewVDI4l3ImRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1758925446; x=
	1759011846; bh=kdwso9fm/qHBy0BVVyKGbmcYQhyMk88YMAt21f908vk=; b=S
	T1FoTmoVUnMsvTGmEAG9WhOv/UNk66xSlYxw6jwTWDD8iE4IgpW4xAhBjZsKhx2P
	+k6pFf1+57QAnttSJmK0fdaqixycb2ohvEvYPSOO2Xd6CAFS+Tfb3/8pssBqXkSB
	kQut7EbxLjpVtLP9Ih0giiyLiFvq9xjzBTAwUc5LUZ9Mxr4GV2jEpBFvxaf1Yrs5
	Cgc9pEa4GEpY8aqdIK5fuXzkB+YCnCh15lpwvIP+qg/kSPDKNWplSyvXThw4XaK/
	d2k+OeZNNjVVSPwHZ6D4OQu8Moq0X8axtF7+wVSFj2nkd0DHw8wd8L/g++vUvWW7
	FcIq1wb5k5HS19pCi7L8w==
X-ME-Sender: <xms:hhLXaAaAWbgBTsb5Kv1Qctb8jovQis8bJNh9bqoKFTB6_vjTiK_VxA>
    <xme:hhLXaBaGPPlFRDKZr_lhdpRBbXN5hbafwucQspsP6MXDMCTDVivTJbbVNKUnbDihu
    kcsXB6Mc-0tYKQblDmK6iDDzjvZ7_bPNgG5G0cpd0Sk_w8yyICYKg>
X-ME-Received: <xmr:hhLXaInRzWNKZZuJVkUmY3hDSJ5Y75nj08Bd93hXS8yATj2fFx74_snvmBKls7d1-RIAHtPvOUv2fLzy1EZ4bqQHJrGKOP6utAJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejtdehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkfgfgggtsehttdertddtredtne
    cuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohig
    rdgtohhmqeenucggtffrrghtthgvrhhnpeetheekueegueeuhffgjefhgeelvdeffffgff
    dtveeggeekfeekvdelffekvdfhieenucffohhmrghinhepphhhrghsvgdrtghspdgvrghr
    lhhivghrrdhrshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hhLXaFyWCYnAhUB3ssDOcyY-TJxIvbl3QYKWUMorD89TXtNSOpTwkA>
    <xmx:hhLXaOMqwkQjyU2-m3EUPkDFML8PRZOJ086rYO7WHvHg5IwBCN7VVg>
    <xmx:hhLXaBQgELp18kry9ep6oz1E4udP9sZZL8_RA_uAhtI_JTMWGTtc-Q>
    <xmx:hhLXaEZTtHshVDBYMGbGbc9wUa8qNXXYNaXfxyWbyMyUNbw2Yjo1hw>
    <xmx:hhLXaDwJ_co-1I0yqq_woYOmJu55vNl2ZdM9Lp1UqivBzKjMrNzMHnkc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Sep 2025 18:24:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [RFC] How to accellerate the patch flow (or should we?)
Date: Fri, 26 Sep 2025 15:24:04 -0700
Message-ID: <xmqqldm0am4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

A typical lifecycle of a patch series sent to the list ought to be
as follows:

 1. You write a solution, describe the problem and solution in a
    patch series, send it to the list.

 2. People notice, take interest in, and comment on these patches.

 3. After #2 above, you may find it necessary to produce an updated
    version.  Go back to #1.

 4. While the above cycle is running, the maintainer may queue it in
    'seen', for two purposes.  (1) not to lose sight and forget
    about the change.  (2) to catch potential conflicts and overlaps
    with other in-flight topics to keep their interaction manageable.

 5. The maintainer notices that the discussion has reached a
    conclusion that the patch series is in a good shape, and merges
    it to 'next'.

 6. If a problem is found while the topic is in 'next', the topic
    may be marked as 'on hold' until an incremental solution to the
    problem is created.  This step may repeat while the topic is in
    'next'.  If the problem, which hasn't been noticed before #5
    happend, turns out to be so severe, the topic may have to be
    ejected out of 'next' for fresh restart.

 7. If 7 calendar days passes since the topic was merged to 'next'
    (or any incremental fixes are also added and merged to 'next')
    without any further finding of more problems, the topic gets
    merged to 'master'.  We often call this 'graduating'.

 8. Any further updates (enhancements and bugfixes) to the already
    graduated topic goes through the same cycle as a new and
    independent topic, starting from #1.

The time taken during the 1..3 cycle and number of iterations to get
right cannot be really shrunk without making our developers work
harder and there are only 24 hours in a day.  And I do not think we
can realistically "make our developers work hader", as everybody's
priority is different.

The time taken during 7. is pretty much fixed and unless we are
willing to sacrifice the quality of the end result, cannot
reasonably be shortened (note that this is based on the assumption
that "find any remaining bugs while it is in 'next' before it hits
'master'" philosophy is working, but we have never run experiments
to shorten this to say 3 days to see if we see more bugs on 'master'
yet).

But I wonder if 5. can be accellerated without sacrificing the
quality of the end result, every time I send out a "ping" e-mail to
old discussion thread, with "The discussion seems to have petered
out at this point.  Is everybody happy?"  Either I could have sent
such "ping"s earlier, or reviewers who were involved in the review
could have given a positive "oh, this looks good. let's declare a
victory" sooner.  Of course, from the point of view of distributing
the load and making the process as parallelized as possible, the
latter is more preferrable.

Let's take a handful of topics that graduated to 'master' on
2025-09-23 and examine how much they spent in each phase.

  * cs/subtree-squash-split-fix: The topic took 3 iterations (v1:
    2025-08-24, v2: 2025-09-05, v3: 2025-09-10).

  After <dd71ebee-8629-43c3-aa2a-40124400f262@gmail.com> gave an Ack,
  the topic was picked up to 'seen' on 2025-09-11, and then 42063163
  (Merge branch 'cs/subtree-squash-split-fix' into next, 2025-09-15)
  merged it to 'next'.  We probably could have merged it to 'next' a
  few days earlier.

  * rs/get-oid-with-flags-cleanup: a single iteration (2025-09-10)

  The topic was picked up to 'seen' on the same day,
  <aMevTM6YESMDdWPh@pks.im> gave an ack on 2025-09-15, triggering
  its merge to 'next' on the same day at ff8d1faa (Merge branch
  'rs/get-oid-with-flags-cleanup' into next, 2025-09-15).  I think
  this is an example of the process working perfectly for an
  uncontroversially good small change.

  * jk/add-i-color: 2 iterations (v1: 2025-08-21, v2: 2025-09-08).

  The first iteration was sent on 2025-08-21 after a bug report filed
  on the previous day.  After a few review exchanges starting
  2025-09-03, the second iteration sent on 2025-09-08 was acked on the
  next day.  The topic was merged on 2025-09-15, after spending a week
  in 'seen' outside 'next'.  I do not recall the details, but perhaps
  it was during relatively busy period, or there were topics that
  touched overlapping areas, or something?  Or perhaps maintainer
  fatigue?

  * cc/promisor-remote-capability: 8 iterations (v1: 2025-04-14,
    v2: 2025-04-29, v3: 2025-05-19, v4: 2025-06-11, v5: 2025-06-25,
    v6: 2025-07-21, v7: 2025-07-31, v8: 2025-09-08).

  Past round 4 or so we started seeing fewer reviews if any.  The
  topic has lived almost since its inception in 'seen' until the last
  round was merged to 'next' at 367d83c0 (Merge branch
  'cc/promisor-remote-capability' into next, 2025-09-15).  Again, this
  last round wasted 7 days in 'seen' without any activity, which I
  wonder if we could have somehow avoided?

Opinions and ideas to help topics not to waste too much time waiting
for step 5. is very much appreciated.  The most radical idea I can
think if is to introduce two more "maintainers" and any two of them
can vote to merge a topic in 'seen' to 'next' without waiting for
the other maintainer, but there may be simpler approaches that do
not require huge workflow changes.

Thanks.
