Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EB02DFF04
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773268284; cv=none; b=SN7WW+UdpS9zowfL4ILfVrscM7c4ozdNE2SNqTBHml4JKiVuP9EHiiiYmbrVmq5Uvyl0M0N4fawdApLW4o5lyxT1FLfS4Rznux+piH76yYn6gYNZAwG+qkRTNlnn3oxqMe57T9R1IxHWs3VGEvUZoPv5kfctAlShz+WyKwhDVZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773268284; c=relaxed/simple;
	bh=isdeXYc8FBwQuzwPPWLxJH6v8jGcHWLa/IivoWRF8ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b3JhJl3cSvcL0VgHGDm4oYPlluwd0lpUaMdnzx7Zir4mImAHhRtIgfRC7z6fsFg747WGtBFhnrAgTNJq1XEstllfINkD6CzI+/Ec9dy/RG3Az2WfoHmddVkgVP87zjDgpVcn9kQ2ENZ9P2oH/0peMRt+4hfdOKrTQG1kw+yFKWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=gQfu9j/W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AeDZl2U+; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="gQfu9j/W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AeDZl2U+"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 926BF1D00026;
	Wed, 11 Mar 2026 18:31:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 11 Mar 2026 18:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1773268281; x=1773354681; bh=09
	7VF1J/JkQ59FixlbdoSqkr8o2CLtnxQ/U/VEoet+c=; b=gQfu9j/WVq1dEF0ZNv
	vwf/blh671nklH9cEZhcUOK7K9vETIkJHpTsUJ2xOUg/RZrHio5LAhejKrXk/4BV
	nPSNHJpK+lHtfllNrfGvs55i+GkR0NyPaHfrADwOiV0prYwEaDq6S9kcSRcg2E7l
	7z+MUCiIuzGXM5HM5mRs6qifWthUWVNQH9aaZ33iDkmK/9BNM0TRMdMu9EPXvtsL
	Cn9Bos7bD9Izi79MJIdUVLAorToZWCuhPEfvp4d84JHZp73Zkj0pv4Jep9t/d/lm
	76P5CHkqvrHn2AThV1G/zrTT+NxaCVDqPnWJT8VBSxN98ct1WNwuDkhk/s5g5DVP
	jJpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1773268281; x=1773354681; bh=097VF1J/JkQ59FixlbdoSqkr8o2C
	LtnxQ/U/VEoet+c=; b=AeDZl2U+5R5719T1wccFixJ95Owq3YIjc99FXTaGzCQL
	5wYggNO2SxHHw4kuHQl1mEx5/QWc+KXGdP7QD0kt4kJEd78tXu6GfjG0qziKTx/W
	JDuUFIsniFsdt7s04G/478NJZvgyMck4RtjsrAIIrRDObBUyGgBOuVayPTsEEoml
	oycT2V7GcJtDlkrc1N1xUfx0xMAzn6u4FUghyGQrU41O9VqtuWBed6b/h/7GNamp
	j6ocy+SgpaOySbXiiMZ9cwjYUuxvqLBKpJd2wZY/S8Jf9DK6qxO/NFvIs7WAw9GF
	dfKq3BqxYC8e71m1GL13dp6QEG0lAFNcakeaKmP5Wg==
X-ME-Sender: <xms:Oe2xaUq8t8hWl2Mu3a_C-pQqioFSqpfI7HjGQaZh-g6Q8aCrFG1kjJs>
    <xme:Oe2xaSGfb_vxXZxs9J4-obIx-hIJHmLQg_Ub8sDC-skAMt8KyA9_HwDyFQQIhLyZF
    x6AnHut6scCU-xg9nwYNcyiRfwOc-Yl1aVXeOJvZdr_jAA4hbq_>
X-ME-Received: <xmr:Oe2xaWlvaNyfbDM4XZDyD_wjmZ-kutMAxkX5MHpt8lVfjfI0smni2yPQ8sm9z9ttZs0b2b7C4goX6tv7VIJVeHuiy4Zzoqewp6xCqqEdSsv9lWHyEtJa1bJxDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeehuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffogggtgfesthekredtredtjeen
    ucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmnecuggftrfgrthhtvghrnheptefgkeejffdufeefffegkeevgfevvdegffeujeej
    leegudfhtdffieekleefhffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggv
    sehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrh
    gvvgdrfhhr
X-ME-Proxy: <xmx:Oe2xaVlJJlhgLTD4DCWwYs5p2A0a2l_l0pvKQnGbEpLG1BpGF9nLJQ>
    <xmx:Oe2xaXusoCTLsU9JxHr_uyMxg3rlLvyiO-14N5nboDfBtKUsvx0bNg>
    <xmx:Oe2xaYlzVakyP3J7sjnhZ3Plq4RoqMIKt-v27vcIs-avVr9KUcYXOw>
    <xmx:Oe2xaStRTp0zjQSC2KsHD6bEKbUfFuDvbQOhWTGiIbfBvvykxIIULQ>
    <xmx:Oe2xaaund8HDl03hePY7gCVAP19oWjBPYPw8nIq1ho_XpWBHwfAWSCuV>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 18:31:19 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 0/3] doc: interpret-trailers: convert to synopsis and update options
Date: Wed, 11 Mar 2026 23:31:03 +0100
Message-ID: <CV_doc_interpret-tr_synopsis.48a@msgid.xyz>
X-Mailer: git-send-email 2.53.0.32.gf6228eaf9cc
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: doc-interpret-trailers-1

Topic summary: Convert to synopsis style and update options.

[3/1] doc: interpret-trailers: convert to synopsis style
[3/2] doc: interpret-trailers: normalize and fill out options
[3/3] doc: config: convert trailers section to synopsis style

 Documentation/config/trailer.adoc         | 121 +++++++--------
 Documentation/git-interpret-trailers.adoc | 170 ++++++++++++----------
 2 files changed, 156 insertions(+), 135 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.53.0.32.gf6228eaf9cc

