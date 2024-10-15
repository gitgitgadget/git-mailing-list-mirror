Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827C51F80C0
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019103; cv=none; b=gzZVwnfsuyTJ2qVnH13IjAJbZV0la37tCKW2LtkTYN8xDZ3FKeJFpH89HdS0bZhoXQxgc4EA0565WBaLTZOj8bNpvN79+n4CLN+hz6v8xMikr6bTfnKJCp5d5df9G+7zSWvfh6AAuvdnFhAXrSLafk7oy5/wVK4MSiQLjq2kJRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019103; c=relaxed/simple;
	bh=FeMYzUpbRpaocb0tXElv6kfsdLU+OzNXwHWbCMHomMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCMkyN2DrCdSBSf0K+GgCea+0RzPvVHEVdDuiGaDnmRwBkMZ8KSsGSQtA4U/3k4viaQBaND3bwXrX1dpk4C98p2xW9F4MRYrF8x78n9lxF3LIY0rBrU4xRt8Ug9WhYWhpSmAvf0/WkFcK0mdKaqC6BusBqfa6ZTgFHMENPk5LOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DliYIVVj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W8QO2OQt; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DliYIVVj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W8QO2OQt"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9083A1140174;
	Tue, 15 Oct 2024 15:05:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 15 Oct 2024 15:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729019100;
	 x=1729105500; bh=8QIstgB05ES8peD/DRguoGz5ZojjkL6h8uoXk3j+Pl8=; b=
	DliYIVVjuz/yP1K1QMIzyTyX3lihZ0V1tEJIMhJz2c2y/99U5E9b9OZnMu1QKgtX
	wwk2PDAf4GuFcxLPSQh+WUrz+i1EWhWXoCdrRHAciZ07Z4VgbMTrT0Ta6fk7Lscz
	AfAKa7GEL7ZmOsl0uMjyIupiaurD9GWR+kNaSA/zqU2Ox9rWU2UKEk+UQ2IZvib6
	gapsSPKAcb1626jdEw3wzpaRUvhrqyMUxIBHI36zNi9VHNGh2av8C+FBr9wRkxIW
	O1rgaSEbV1oKl4sYXmJdvybHHqbXSm3PQO838ZvTyCq0CmHAne75IBIJg5zNDqAF
	7Rxv6FFxjXt56zwkjoSUoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729019100; x=
	1729105500; bh=8QIstgB05ES8peD/DRguoGz5ZojjkL6h8uoXk3j+Pl8=; b=W
	8QO2OQt/0MzH0V1vfasy7yo8eosA1RSceJWlVBiSvkYhajPvScGLg4IukVPa8/zA
	BnGksvxS5yCdtw8k0xHbQjTJXqHp35u9PwN4Mv9IfJd5khR7SRIqG4PxaC5fgvzp
	nePRIU+bFkhz713kY6zCzaQ2VQy7IKzOpIkTcf9FdaDKwniZ3bWlOkJ7+3kWwqv1
	6qFHrSQszE6IQW9H3bk0jWNnZhk7xK/7K24urbi8tUYLHm8dipk5Olye8fQt7mFv
	kNuCE96iz6YfExL6zMSCW8Zf9d396mQjEvNcg5eiKK08mE4KApB8Js82qB8d04Wk
	AotOOLHMJHjmw1EZttNBg==
X-ME-Sender: <xms:27wOZ9TGLonP5apk_iaVnzYyTblC_O1ho_-LVQ-4uasmqU542oNrtZ0>
    <xme:27wOZ2w889okzMq3dhSeiw4gIb7KL-aKurctS1jUxP2OOWxY0eu7H1PYDcs82EeGn
    -OrVknI8CHH4SFtlg>
X-ME-Received: <xmr:27wOZy0ayhQK44kVX6DYzFg6PIFmKyHZVzEo_T3KVyZ3Cf6bjn_3BAD04Gc9s-rlsmt21Y4Xyn-2KCqHVuKHuzB7ArCV4NehJqRplJa_pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhgf
    eglefhjeekgfetleetjefhteeiheegfedtudduffegjefhkeetudeggffhkeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhgt
    vgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:27wOZ1D_8NnOLpiky73qifcvuY01CdIkSC62WWOQzg_gBtMNczkk1g>
    <xmx:27wOZ2hZAkvFh5mqZL_krx5DVGw-640eAcbW3-xP9jHx5qr2tmvsPg>
    <xmx:27wOZ5odGilA6MRa1NaOXuEPGJZJ_9wpGOi7nWGNgRFMSQen63Q2uQ>
    <xmx:27wOZxiITD9PPmn0xiFZLA3K3BBPlpoErTGkw7wEMhCiqWfx8dPK_A>
    <xmx:3LwOZxWJ63UkcxcZSIMcXUP3z8P0t9JAP-aimzeef8n4230xADIqV1Z8>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 15:04:58 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	bence@ferdinandy.com,
	karthik.188@gmail.com
Subject: [PATCH 0/6] doc: update-ref: amend old material and discuss symrefs
Date: Tue, 15 Oct 2024 21:03:09 +0200
Message-ID: <cover.1729017728.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.46.1.641.g54e7913fcb6
In-Reply-To: <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
References: <CAOLa=ZQJy1ZkQqBoWwJJvL0f+NCP=3SAfyeSNuztgApzNH1mGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Commit-Hash: 9e775a65eb3ff49ded231aeeeddd59ccdce3c8a8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

(See the previous email for the context)

This series removes or moves some old material in the update-ref doc and
improves the discussion of symrefs, opting for a high-level description
with some redundancy (see patch 5/6) in order to avoid a reported
mistake/confusion.

The end goal (after all patches are applied):

• First paragraph (in Description) describes the first form
• Second paragraph the second form
• Third paragraph mentions symrefs and explains why `--stdin` supports
  them
• A new section whither the symlink (FS) vs. symrefs (`ref: ` files… or
  strings nowadays with the different formats that refs can have?)
  discussion is moved
• Link update-ref to symbolic-ref and vice versa

Kristoffer Haugsbakk (6):
  doc: update-ref: drop “flag”
  doc: update-ref: remove safety paragraphs
  doc: update-ref: demote symlink to last section
  doc: update-ref: remove confusing paragraph
  doc: update-ref: discuss symbolic links
  doc: mutually link update-ref and symbolic-ref

 Documentation/git-symbolic-ref.txt |  4 +++
 Documentation/git-update-ref.txt   | 48 +++++++++++++-----------------
 2 files changed, 25 insertions(+), 27 deletions(-)


base-commit: ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f
-- 
2.46.1.641.g54e7913fcb6

