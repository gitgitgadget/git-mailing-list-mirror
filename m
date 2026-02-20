Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546633B97B
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582527; cv=none; b=eEKXBK330xh13eDF47aLACjRYLxQUUK//dzhwWLajcAJfBkRsWNW3nr9JtZauO7MYCtScFVWKdY3hvMlOzyyhxFacK8+7pOs8LwDammnHA+ylgzT3Sog//+5dC23k+T/wmWEP6k5o8xON1ucMHkP7NqkCfdmeXbS1pQMyULhk+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582527; c=relaxed/simple;
	bh=Ei9w1bx8mkMZ9w6krzx48MVgcJzYK79AJ/EhL1aNo9U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z1hWwJtiftFSwSqc2HxyPdwEM+HoWi/M0N7sXyPL7oOZYE3KwlWBmrDU/3LTljv/ayRVFX2eXSjl49fBSQIgU4TdABvD5U8qMDWKacx0uEADdtygLWq3I8+pZGVLMmuO3VkqymqZJ9B+FkVBSzBE6f6sDbxyVbqlfJQ4DHNDM58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tBJwJka3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ot6Gcv+8; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tBJwJka3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ot6Gcv+8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3978F1D001B0;
	Fri, 20 Feb 2026 05:15:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 20 Feb 2026 05:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1771582523; x=1771668923; bh=N64gU8N3HI
	lj9YdKdyFN9t3X8sqhXffHyb4DFpCUrCE=; b=tBJwJka3aOXMe9v12fRKuZu7Sy
	c1mOay44GdTdGt+kQrJWQUKFmJzdLuQg4KFTrh7AFgN+SYXpXlDebLDeR53HPcGm
	nlFZGcAAAJ9Ihiz1BnL91myxKRwBpfn9usugumQ41QDMCUkepEIyXd+l1KxAWERp
	RnWIM1aiBNriktxGoTi+oeAc2eJxWTlbHw/Hvd/du/yb4lS+yA0eQ/XHVGXOea4v
	4A+5htcBWaO1mBmlJxHO2JDSeU9NLIgISOB+nShvKfSHTNFQljGVYwcFAJoeIDId
	QLARH5WJvobubdxSa7/ZhPD6pV6Ih6lxvNxvUrcUKzUzu9oXaFm7zwr8Aj3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1771582523; x=1771668923; bh=N64gU8N3HIlj9YdKdyFN9t3X8sqh
	XffHyb4DFpCUrCE=; b=Ot6Gcv+8OtTLhXpVbmfgt8F0yxHArNp67bRn/uy0iVQ+
	6DpGtrjHQXVFmb3cS2gVRtU0ULbJ3Vr289tQSaZfpy0dAENQl/O6OtFC1Uhe7+ba
	RyqwotBFZy8yLmfpQ/Q1fAJ3/EyQA6D/zsOGb+Z253UqvQTBRyrtG/LB85u6DsP2
	yjXaqvoGK8NtY4m/9+uNX2GwnGan9oq5rUrRa2Ki4XlFI4Q6Bx0jDV8JeDGQeMMB
	TUXjB2dSjWZlHXNqK/fGy2MrT3aTxKD8eP2WC1yK3TkqX6h6Dy7pzlIyh9FhqXR+
	7T0VGxXiFDMUjqUyQfWbFR7YMPzFKGDHtmSR9IpCDw==
X-ME-Sender: <xms:OjSYaS6aEPnyCAEUQvzku2ptB-m7DfbQGyFOP6Om56xFDdah9l-1wQ>
    <xme:OjSYaTXx0K7NN46THykXJSI2OKiFYh1NIju3pef4Ojl_0dGtB5EavP1BVOv19_-KV
    8lD0xIxJ2Fvecx-wQL4qkXBc_ZQxZMgeSmPWABjTRIZQQAJeI4suA>
X-ME-Received: <xmr:OjSYae1ZBq80hju4YNu38Ga-xcMnyMqzrvEBq7qZEGuQ0JqpMRNdLBSEM1NHjNZfmzkPpI49qTYwrw-5aNU80WC0ev5_MWxUcW12SyxvgHvu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evueegkedtteeigeejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OjSYaY27xY_-p9ct75AqwIrV0qRLtgmxrjbqhR_pZGDUWD76Za-7-A>
    <xmx:OjSYaZ8ED3R9yOMmS9DMJekRWICQ_EH71nPNk4tFI8JAer6BkgX55A>
    <xmx:OjSYad1SsRfxKiz4DI6CQbtM6scdNm0EAp-o9FYiB7M6imTTUxKT_g>
    <xmx:OjSYae_fgd4Vg1GNQSJTjDsDMIoNRe_LNWspZSTEUaSgoIaMvyKWCw>
    <xmx:OzSYaezO0CtJSjkGPwjlLEBRCIqtbim62k335RF9zpVOSDNHNm1zBOgI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 05:15:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 27b040b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 10:15:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] builtin/maintenance: use "geometric" strategy by
 default
Date: Fri, 20 Feb 2026 11:15:04 +0100
Message-Id: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACg0mGkC/x3NywrCMBBG4Vcps3agCaVeXkVcjMmfOGjTkqSil
 L67weW3OWejgqwodOk2ynhr0Tk1mENH7iEpgtU3k+3t2Ftz4vvAy7PwJJoqkiQH9giyvipHzBN
 qVselZqmIXzbH4ODD2Q6jodZcMoJ+/r/rbd9/jKli1n8AAAA=
X-Change-ID: 20260218-b4-pks-maintenance-default-geometric-strategy-17fcedf92461
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

Hi,

this series converts our default strategy used by git-maintenance(1)
from "gc" to "geometric". The aim of this is twofold:

  - It completes the conversion to a more flexible infrastructure for
    repository maintenance. git-maintenance(1) is structured around
    tasks that can be toggled on/off as needed, and this is a lot easier
    to extend going forward.

  - We start to use a more efficient repacking strategy by default,
    which should especially help large repositories out there.

Out of these two, I think that the first point is actually the more
important one.

Unfortunately, a lot of our tests are racy or will fail with the new
strategy. This is mostly because the new strategy may decide to optimize
data structures in cases where the old strategy didn't, and because the
tasks we perform might be different. The majority of this patch series
thus adapts our tests accordingly. The actual change is a one-line
change in the final commit.

I was a bit torn initially whether or not I want to make the geometric
strategy the default right away, or whether we might first want to use
"feature.experimental" as an additional step. I'm quite happy to adapt
the series accordingly, but for the initial version I thought it might
invite more discussions if I pick the nuclear option :)

Of course, no matter how we do this, it is still possible to revert back
to the old strategy by setting "maintenance.strategy=gc".

Thanks!

Patrick

---
Patrick Steinhardt (8):
      t: fix races caused by background maintenance
      t: disable maintenance where we verify object database structure
      t34xx: don't expire reflogs where it matters
      t5400: explicitly use "gc" strategy
      t5510: explicitly use "gc" strategy
      t6500: explicitly use "gc" strategy
      t7900: prepare for switch of the default strategy
      builtin/maintenance: use "geometric" strategy by default

 builtin/gc.c                            | 2 +-
 run-command.c                           | 2 +-
 t/t0081-find-pack.sh                    | 1 +
 t/t3404-rebase-interactive.sh           | 2 ++
 t/t3406-rebase-message.sh               | 3 +++
 t/t3431-rebase-fork-point.sh            | 2 ++
 t/t3432-rebase-fast-forward.sh          | 2 ++
 t/t5316-pack-delta-depth.sh             | 1 +
 t/t5319-multi-pack-index.sh             | 1 +
 t/t5326-multi-pack-bitmaps.sh           | 3 ++-
 t/t5327-multi-pack-bitmaps-rev.sh       | 3 ++-
 t/t5331-pack-objects-stdin.sh           | 2 ++
 t/t5332-multi-pack-reuse.sh             | 1 +
 t/t5334-incremental-multi-pack-index.sh | 1 +
 t/t5400-send-pack.sh                    | 1 +
 t/t5500-fetch-pack.sh                   | 3 ++-
 t/t5510-fetch.sh                        | 1 +
 t/t5616-partial-clone.sh                | 7 ++++---
 t/t6500-gc.sh                           | 1 +
 t/t7700-repack.sh                       | 3 +++
 t/t7900-maintenance.sh                  | 7 ++++++-
 t/test-lib.sh                           | 4 ++++
 22 files changed, 44 insertions(+), 9 deletions(-)


---
base-commit: 73fd77805fc6406f31c36212846d9e2541d19321
change-id: 20260218-b4-pks-maintenance-default-geometric-strategy-17fcedf92461

