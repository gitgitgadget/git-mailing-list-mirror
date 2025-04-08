Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F932116F4
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 06:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744093347; cv=none; b=UysctDPcwMXcDWGia8aODaMVJno8Cow83+19CVXL8Yzit5XvpOqAqp36PpJ0l+mIdv5ezhZaA22bugr6lOe+G0xPQd/fgCMlvky/ntz3RoVij5NumEr/Vw/2QeTLSCm06BonTS/zqYKMSWQV2LPJ3Yu7idRY2GE9PdrujVvYbEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744093347; c=relaxed/simple;
	bh=VVTe2KyBSI86Smn85Cb6eKwKrXbkqsdA4NgKMrwi8JI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=mNVu21s6hRxMgf4hnBJIrrJdSyUgS1Cq3iuHmm8iK/sXkhyuuJqhOQSRGSxZGmYdJ6VLI/jbyWNXtW4/BzhaUxGdkjNA/qhRlC+2xT38xTwQ0X/qHKeELw/jOJAmxC+4+QExttUB6Uy/kgA7rF37+1zxWI7QBvO/ttWe36J0yyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T6I3hnUw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n1QP40yi; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T6I3hnUw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n1QP40yi"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 26C581380113;
	Tue,  8 Apr 2025 02:22:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 08 Apr 2025 02:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744093343;
	 x=1744179743; bh=/Yi9LBD9pd5630BwsvWb+V5inDBUaNJmrzWuZH7O14I=; b=
	T6I3hnUw0BRo/Sztw5EfNUZ0P4JR9kNCp5fGCPNfF3H7Qz8odTigZG2VdyZr3f4G
	MPKL39XUrbQ+V2wuCZ4Fcyh1nA3VC7EArhWHW4OfBti1W/tIfD4wFON0PLUtc5h6
	S4T+4oZA5WD/rkXTp1w12Nn6keaXsfBlfDUVpV1Vc3Y4C4KWbW384a1h7viKz09I
	1bq8anHKj+dVoRp6kIanKQyWaQi4blG1b9RAbjZJ055sN0brlbOzSsMrz1HKMpr6
	TW6Z4nHyTo6V6iZKuPAlj6EV4dp2NQ53Qh/sGYyVNmxV43AFLadR4JWzDkCs05CW
	2JcD9VzBbm5UON9cBUr8yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744093343; x=
	1744179743; bh=/Yi9LBD9pd5630BwsvWb+V5inDBUaNJmrzWuZH7O14I=; b=n
	1QP40yi30pppREYuzDSrmBcHAIMWvMMiAkrjx8ba2bY2mVTWlhp7F5AskatEJm0f
	hMbHtEfPiqk9SFuXN5XQsoZv7cKip8SZPlXZZO34xIwOo2rjdcTegXHQA7NNq4y+
	zIq+xtZ5f7UAWIlzgWuO5a2/gqZqAASgh7KF0ccrGAhAiY9Kz74iPDH2RmSnkbSM
	mJimtvXXGYDtvJWv7xovjIgurAHrToR3q40g/Y7MngytzWU9ldUCWIQHVALNfu8C
	L3uVXv8o372/YZ2vYmy7vZFZxBWJlMb6AY4U04wOjvQ3aHgG5zUSaTlkQcE6lfaz
	Iy85ZbLEmdCzI3Ih311WQ==
X-ME-Sender: <xms:nsD0Z2tNfYeyeIlbOmVBUe8VtQ_tGs-G4xYAbmP0p9WR0vgz4AKgdg>
    <xme:nsD0Z7c0grSSHzXZCtm7uvz8h-TvpQ68Om6ex8f7SIUqJ8VWALjD858WythCKxMJ5
    AG4OK9-MWvlZEserQ>
X-ME-Received: <xmr:nsD0Zxw04Rj52XuibpdRRCrIvP_WrWC2eOM5sXA4d-YQA62SbxjCPMV_mS39BfzLUKTNZkge9dqmDS7gCKU97bIrQapi5QesygSgf5rNVCOO2adGHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvges
    ghhmrghilhdrtghomhdprhgtphhtthhopedvtddvheesuhigphdruggvpdhrtghpthhtoh
    eprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:nsD0ZxPEZ4PvSpwN1cFlZlEhU32-3w3r_uILpQRKpPL3Be98i0IR7w>
    <xmx:nsD0Z29SH6WSX_Oxlc89FGQxI8XS6YwsLcGui_ERz8_J8Ng5XCZEjg>
    <xmx:nsD0Z5VvoDMGOS7Sqsb-lCmXzxiWB0nIVDo4kk_Tg2SPqpum6pEHBw>
    <xmx:nsD0Z_fxiKWMKvsFave5-1-HhrJ8t8aWP_dJ-Gw4PfuodbNNmtUK7w>
    <xmx:n8D0Z0JfT4PeU3_uPulkmeZpF-engE9FVkZ4c8ZYX04q17OgJhQRUHQl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 02:22:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7f783a95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 8 Apr 2025 06:22:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/6] builtin/maintenance: introduce "reflog-expire" task
Date: Tue, 08 Apr 2025 08:22:11 +0200
Message-Id: <20250408-pks-maintenance-reflog-expire-v2-0-1ad8634798b7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJPA9GcC/42NSw6DMAxEr4K8rqvYgvSz6j0qFhF1wWoJUYIQF
 crdm3KCLt/M6M0GSaJKgmu1QZRFk06+AB8q6Abne0F9FAY23Bhmi+GVcHTqZ/HOd4JRnu+pR1m
 DRkFLnaWazKkhB8URSq3r7r+3hQdN8xQ/+91Cv/Rf80Jo0BGb2p2pvjR8K/ujjtDmnL/1VaYmx
 wAAAA==
X-Change-ID: 20250226-pks-maintenance-reflog-expire-61c61410751a
In-Reply-To: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
To: git@vger.kernel.org
Cc: Markus Gerstel <2025@uxp.de>, Junio C Hamano <gitster@pobox.com>, 
 Derrick Stolee <stolee@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>
X-Mailer: b4 0.14.2

Hi,

this patch series introduces a new "reflog-expire" task to
git-maintenance(1). This task is designed to plug a gap when the "gc"
task is disabled, as there is no way to expire reflog entries in that
case.

This patch series has been inspired by the discussion at [1]. I consider
it to be another step into the direction of replacing git-gc(1) and
allowing for more flexible maintenance strategies overall. Next steps
could be:

  1. Enable the "reflog-expire" task by default when using the
     "incremental" strategy. and then we might eventually switch over
     the

  2. Use "incremental" strategy when "features.experimental" is enabled.

  3. Switch over the default strategy to "incremental" after a couple of
     releases.

Changes in v2:
  - Two commit message typos.
  - Link to v1: https://lore.kernel.org/r/20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im

Thanks!

Patrick

[1]: <e650f4e4-e267-4f1f-bb3a-c71b1fe0b276@uxp.de>

---
Patrick Steinhardt (6):
      reflog: rename `cmd_reflog_expire_cb` to `reflog_expire_options`
      builtin/reflog: stop storing default reflog expiry dates globally
      builtin/reflog: stop storing per-reflog expiry dates globally
      builtin/reflog: make functions regarding `reflog_expire_options` public
      builtin/gc: split out function to expire reflog entries
      builtin/maintenance: introduce "reflog-expire" task

 Documentation/config/maintenance.adoc |   9 ++
 Documentation/git-maintenance.adoc    |   4 +
 builtin/gc.c                          |  72 +++++++++++++---
 builtin/reflog.c                      | 153 ++++------------------------------
 reflog.c                              | 137 ++++++++++++++++++++++++++----
 reflog.h                              |  35 +++++++-
 t/t7900-maintenance.sh                |  18 ++++
 7 files changed, 263 insertions(+), 165 deletions(-)

Range-diff versus v1:

1:  62ed4d1dcb6 = 1:  92d20e9403b reflog: rename `cmd_reflog_expire_cb` to `reflog_expire_options`
2:  c9da014e85c ! 2:  5625b7472f8 builtin/reflog: stop storing default reflog expiry dates globally
    @@ Commit message
     
           - The currently active set of expiry dates for a given reference.
     
    -    While the last item is stored in `struct reflog_expiry_options`, the
    +    While the last item is stored in `struct reflog_expire_options`, the
         other items aren't, which makes it hard to reuse the structure in other
         places.
     
3:  bd06fee3d23 ! 3:  146080fe970 builtin/reflog: stop storing per-reflog expiry dates globally
    @@ Commit message
     
         As described in the preceding commit, the per-reflog expiry dates are
         stored in a global pair of variables. Refactor the code so that they are
    -    contained in `sturct reflog_expire_options` to make the structure useful
    +    contained in `struct reflog_expire_options` to make the structure useful
         in other contexts.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
4:  90ec3a8ffc8 = 4:  0f40bf3f45a builtin/reflog: make functions regarding `reflog_expire_options` public
5:  17d0e940266 = 5:  3072a421957 builtin/gc: split out function to expire reflog entries
6:  5799eb30843 = 6:  ca81a7e5686 builtin/maintenance: introduce "reflog-expire" task

---
base-commit: 5a526e5e18ddb9a7dfc5a2967d21d6154df64a4f
change-id: 20250226-pks-maintenance-reflog-expire-61c61410751a

