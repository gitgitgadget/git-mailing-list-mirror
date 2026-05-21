Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F8D2E974D
	for <git@vger.kernel.org>; Thu, 21 May 2026 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386536; cv=none; b=RA5TCABmIPGL5hAo7saLPSH+OB/39oCiz6i8EUVaH6dXWxR5U6YygL6BBXLRtQNVxIUTqnoPvT8B1/CQb63m2cLxwD9WMkNUzoTyV3/4IakZO64qXW2O3Yzu0/dNNPId5M2Rv8KvjhN0pIyXgOaCzIenqLwi2aPk7XwqemWyQlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386536; c=relaxed/simple;
	bh=gUZPPeq5jWiXtOWVVUywxLfw09lsZ8VKH5lLwDYFnRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fBlWc/5MxAa2QO4zCwAZOsqXHSRV8IpsHXI3UzErn67z6o6LCvwQZYXXv5Ng4SDvKe1y+7g00+QtENm3nJ96xljHifs6hODQ7hvA4JGxZ8kJB/NxF3HBdojzWx3Nlfo1eJL8GfpKdEY71K+F68LN41gOv8U8z1dNDOm1xL2zh+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=eVymon7u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UcXM51tk; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="eVymon7u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UcXM51tk"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8D41F7A00A1;
	Thu, 21 May 2026 14:02:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 14:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1779386533; x=1779472933; bh=LJ
	AP4BHnfnIXR8YGdk/wPpxwbQt60qc/MqQUtrcQeVA=; b=eVymon7uxo/1UW8J51
	03/ICFze4UylPHfvSxln0lPwy7odVTPPsKugS1iWnoSwzQcyKw7o6iiGiXMepxL9
	IG0dfY6bcFC6fFw8LMMTH1kA5wNuQXHKf/XnNQX+vdcZh/1fENuZlkJCuVdwVd6H
	S8K5ZDD4IbBrFZfSMxlx7AvQqq46ZOaBiBwOYZj6R7XvJuiO5OEJv21QzRhxm/gM
	PsrtTT08PKK6NsHe9ki/A2t6XrIRjVSpwWLplnl10YiXKOXg5H1AYt6LbJrFtivI
	z9rjV+FWI57QFF/qwWrByxoMNzd0ZpJ3/8uQizNHvCwXBXFaNv/EFQhxaO2+wwNf
	kCeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1779386533; x=1779472933; bh=LJAP4BHnfnIXR8YGdk/wPpxwbQt6
	0qc/MqQUtrcQeVA=; b=UcXM51tkOtkEARLVKj53EhqMGr1jeLvqwL0umvHesGlP
	OrhYqhr5LOksfPKsYeJ+yEIqTlErUhXiNAFy6JBbN9/nk1653RLu2V5YOPG09tRC
	otEiJATey2mQ3KntOUfEYSsrkA5MfTpMsC/YiGgsh6dSE1Pt38vyuzt+zA6/mCbs
	irMSCgS5uhvWO2uZ+SaMqZK/ne6fmDLYIvwJvPppdmHORKqhaflSf0l692xH99Wj
	cfF+q1TjLGpPFcr9QA6TMzQ+bbq2ycX6m+8lL3CYrjdUkqzxeQZNHGF7ezxdmeYg
	8kuzx2Ng8vTePY3hyVnwZ/sf1W/NPwYkkED4A9Yv8w==
X-ME-Sender: <xms:pUgPasaFl5axS5pFFEHoyFO-0Ndh67rEvmwqE2UbIHmV4Nn_IW5Y4z8>
    <xme:pUgPau3QDfmxOjE-AezbYaq8LmAk1nFFScS_mu6soC6jSPTenDAm3Ew701kMfcBa3
    nMXgS1A_liKsfZQH2Tqx-xUB1ulWLQ0wuF5t7-tmO_is1TjZjDp0ys>
X-ME-Received: <xmr:pUgPakXrkMlVJHjU5sMyZ9iKfDL2jtyvfQ48CYfeBp6go7gTi_lXXuAdTUTekSKL9ve2Vny6BmKu9ocvKjTacY0RvR3KCnX1qcCH06c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeen
    ucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmnecuggftrfgrthhtvghrnheptefgkeejffdufeefffegkeevgfevvdegffeujeej
    leegudfhtdffieekleefhffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepshhiugguhhgrrhhthhgrsh
    hthhgrnhgrfedusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:pUgPagWueqjBODyhQ5S8J3d2g2RWlwKYxkNrB94SNhXU0YI2ldBE8g>
    <xmx:pUgParcRkiES54JqIRBtlD86e6dIegAsVfIQ-ZRf_W06uiNFEr_cyg>
    <xmx:pUgPahV2YZi2jSkRpg0p0h3CdKZB40fr8XNU_17hKWstVwZjj_v-RQ>
    <xmx:pUgPascuxfBOePP6l8SiCeGCDJlL9CMlICfLQqhRer7sPoU2R01LIA>
    <xmx:pUgPam0FRFk_ew1q1mug9K8YUxC7sc0eODH1pAvhRn4hOcPyraN_EXD3>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 14:02:11 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 0/4] doc: replay: fix config link
Date: Thu, 21 May 2026 20:01:57 +0200
Message-ID: <CV_doc_replay_config.709@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: kh/doc-replay-config

Topic summary: link to the config for git-replay(1) (one variable) in
git-replay(1) and git-config(1). Also improve the doc for that config
variable and `--ref-action`.

[1/4] doc: link to config for git-replay(1)
[2/4] doc: replay: simplify replay.refAction description
[3/4] doc: replay: use a nested definition list
[4/4] doc: replay: move “default” to the right-hand-side

 Documentation/config.adoc        |  2 ++
 Documentation/config/replay.adoc | 17 +++++++----------
 Documentation/git-replay.adoc    | 13 +++++++++----
 3 files changed, 18 insertions(+), 14 deletions(-)


base-commit: a89346e34a937f001e5d397ee62224e3e9852040
-- 
2.54.0.13.g9c7419e39f8

