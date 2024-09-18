Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572C66FCC
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 04:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726633946; cv=none; b=Vwp2yvYba2PRuRFkHNQTA3cNrjSIG129GNHrMjNuZN0KfAwFEpI7rNc8dPUv3C5uKlzPvus06xl8W2e5LDWuI8bgaheHA5J4RwCBmPzbf6KiPWld0tEWS0rrmbgvcX/EJUGiG/FvMdhe4s7Ots2GCxRwv8Z5hgLsdZ5pKAil3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726633946; c=relaxed/simple;
	bh=TNPRZimTxUpFJzWFW/h7R70bXzCTlDp66cWKVvaDOl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGWSLqDopSM0hEKuILdzFX0CsZiLbKkXkj3cB2je/TaHFwxDoJEIahBRZmBi7frhecq4lPDWbO+FK97gR6UjL9z83gqOLIyjMXKU8TVN99fjfeGD9MwrP3g1e4DTFDRrjbT3BbeBkVkQe/Wa0SFT64BW+cg1BMsRv6D4PvJKUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K5DVI/0g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i/6QWAzm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K5DVI/0g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i/6QWAzm"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C83D1380262;
	Wed, 18 Sep 2024 00:32:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 18 Sep 2024 00:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726633943; x=1726720343; bh=+3HaBBRR/A
	4mvy2BjSP+ImrZ0f20bAQBuiuZ8ocE0ZI=; b=K5DVI/0g90uXQ2qcggslDIdRFX
	RQBUiIeOJjRQsQEVeiQfJsWGWjVCrNyZE1k1TlhYK1zlKDJ14nSkll3lcG05ZKhg
	Mv1QXqspLWSvT/FqEa7agDm5Bo4migiuYT+YqjM1Bl50LNZZKKIAGdSMcQXwEc0u
	DCmOsMXSy9gU6SnUT5SowRZCIVvqhbM0qQkAmj9wNsnJkrvU2OWFRBca4sFV7qpd
	23J2F7TgEls6iiFqxzIv0Vp+3ErUzCj6KWggExD7YScPy665V+hsaTS0R7nXgMzh
	n2yl8JwVHhcqaavBJIt9ibEKasQ34cTqJdYDJXWpp5gP/QVuvlqFgQMB0nsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726633943; x=1726720343; bh=+3HaBBRR/A4mvy2BjSP+ImrZ0f20
	bAQBuiuZ8ocE0ZI=; b=i/6QWAzmj0diF85Ob+1p+EfqJulXdHTiXptKNnaSaI8I
	1V956xX8wuv94U51Tsw33vQi+rBJEyVplLfk8zhLNvhUmSLI8KYQi6U2NBC44o0h
	wmKcIhC/OTqxNcRGl1mOZ4RDabklDRDB+KXId6RqU8z+uZ+TwwptltNjROwFC7FB
	fN9C1LCjol8T2SKe0H8bhRc5Vh84eeFMxwgxol2mdRL+tam2qXO1jW8elZ7eOxFX
	YHtCl76IKLSstjf5xanseMuD6uDSyAW8W2Cjkn3FMnbU5ZxMDU/fichh6IXoL/LF
	bHIPa/kLpIIt7raExq+CUCCyTbJM8In7jCGQty8+Ow==
X-ME-Sender: <xms:11fqZidBghJM9kH8aq0Rq4ykn4quu_VGoo8wV2UsK1LHNoqJTqRN3A>
    <xme:11fqZsPj6BHMaUsf_PV_Uv7xAmomPyj0wWwQ-p4g2SM0gfLeYhk9dlG7bp4RRatqE
    PjKh5Cx9XJ4NjMQIQ>
X-ME-Received: <xmr:11fqZjiE7uUfpo0waG8qz4iPH7WJ0Ki3SW2kEK1gP14VSiA4d3ZOlmmOwwBTxCezqmASMHgXaxREnv6vQ02XnNaZYzgOvaPjOHRQzIPHuEZomxQ9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekkedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:11fqZv8H3OkbtUszz9ujtGxORZC5itq_8ZQlPv7pZky_FFLNmaqWrg>
    <xmx:11fqZutFNv_Cb0ufAlJinmiKwCu8CKfEA4_lT5YDm0i_OmScYI7ffA>
    <xmx:11fqZmGDdyx5wS1Sf1FMMgpI9kyQPFyWWClUPSP93pfVZ9APpVvmZA>
    <xmx:11fqZtOn9fwDkpORIYiEWriyNh1cVGRq6G1SMkyIvUwm92T1qubCMw>
    <xmx:11fqZiKUrhdIJyfYP_leDh8FyQByw-1pIcO1SlfTigSNKLLK32vGqImz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Sep 2024 00:32:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c3a2484a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Sep 2024 04:32:01 +0000 (UTC)
Date: Wed, 18 Sep 2024 06:32:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/3] reftable: graceful concurrent writes
Message-ID: <cover.1726633812.git.ps@pks.im>
References: <cover.1726578382.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726578382.git.ps@pks.im>

Hi,

this is the second patch series that makes graceful concurrent writes
work with the reftable backend.

There is only a single change compared to v1, namely a fix to the docs
to mention the right default timeout value.

Thanks!

Patrick

Patrick Steinhardt (3):
  refs/reftable: introduce "reftable.lockTimeout"
  reftable/stack: allow locking of outdated stacks
  refs/reftable: reload locked stack when preparing transaction

 Documentation/config/reftable.txt |  7 ++++
 refs/reftable-backend.c           |  9 ++++-
 reftable/reftable-stack.h         | 13 +++++-
 reftable/reftable-writer.h        |  8 ++++
 reftable/stack.c                  | 38 ++++++++++++------
 t/t0610-reftable-basics.sh        | 58 ++++++++++++++++++++++++++
 t/unit-tests/t-reftable-stack.c   | 67 ++++++++++++++++++++++++++++++-
 7 files changed, 181 insertions(+), 19 deletions(-)

Range-diff against v1:
1:  ca3eab99f7e ! 1:  700a35df125 refs/reftable: introduce "reftable.lockTimeout"
    @@ Documentation/config/reftable.txt: reftable.geometricFactor::
     +	Whenever the reftable backend appends a new table to the stack, it has
     +	to lock the central "tables.list" file before updating it. This config
     +	controls how long the process will wait to acquire the lock in case
    -+	another process has already acquired it. Default is 1000 (i.e., retry
    -+	for 1 second).
    ++	another process has already acquired it. Default is 100 (i.e., retry
    ++	for 100ms).
     
      ## refs/reftable-backend.c ##
     @@ refs/reftable-backend.c: static int reftable_be_config(const char *var, const char *value,
2:  cd65e6d57b0 = 2:  f4be0966e17 reftable/stack: allow locking of outdated stacks
3:  37ec3acbff0 = 3:  111b497ef17 refs/reftable: reload locked stack when preparing transaction
-- 
2.46.0.551.gc5ee8f2d1c.dirty

