Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01023A9B3
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034704; cv=none; b=RL9NI3CLvIGUTiCFN+f/SYdJo+zyBVr4bYEOLYslnRu9kqe5CYpbaAH62LKV3uTBpiK5Edb/etn1LRmLaz1OyJqwEShlNX34zRTNB+saBWjZnYiyLAauQJvgVURw3IngFQ36/LiSPaM0okd/0b6T5dHzbjSsaJrth15RwSR/jeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034704; c=relaxed/simple;
	bh=ONCYchRD/yMQgfOMIYL83mY9j/kCgZwCsQxCJJb7UJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5161yuj1yPw8oYfTIhnCibFlcieXUz5V2bRyUSPJ8LcZRYf8NH5QsXEnw3nQiIcgfsvD7bJd3kUTckjAKXyj1IeyI62r+NS8v5olAoXi8VSrjChxXVULTooSXBiZSaFyleUruY6P6tkAud0PyplacTb/Izr4PRJZeXRoZcfPfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IfmO6qad; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nwVA8YdN; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IfmO6qad";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nwVA8YdN"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 41F181140189;
	Mon,  3 Mar 2025 15:45:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 03 Mar 2025 15:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034702; x=
	1741121102; bh=UXf3wrvYLer95SWAXFvGCh7khCOwNgUO/Q+knl6EKxQ=; b=I
	fmO6qadWf48AytctP/K1c+Jky4bieZcx5iCqw8fW4IxUFV2XqplZfjltzcnJs9I+
	/T46IWjBOID61wGG72K2TGavkbuUfSwrmP9qKLhXte8jE21THxi50oifQl5FluM7
	gE6VqKAI0YcyctoDLLcEzzbnovs0E/5uIIghCKckg2HNqGCirR3qcUSxW0DfTDff
	Ykk8tXmZYyz17B1xr07ALcPn6eJDfqFZP45e9LBTdvglD3I/8excvQcvPdMWatId
	IfHLuXZKhCQtDY2OUiIv4JYB/WE2jS01hEYjkCjzSqWb+Ki/g+IkwRmo4brqvyN5
	t2nPNHC1yAzpesMPZRs4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034702; x=1741121102; bh=U
	Xf3wrvYLer95SWAXFvGCh7khCOwNgUO/Q+knl6EKxQ=; b=nwVA8YdNsVyUSO2/1
	FEK0xSMTbx5UAuTgExOOydNdjanY+X/L2b7vWeBnYBucCnW/uzmN59x9rg8NkdeW
	bed80XTxav7OOMW2t7PH6hrSs7t5h3cQ6Be0z21ivJH9rsGtUzpbdn4BQF/stgJX
	NVncUmH62dp/PLYT2mVNS6E7z/dpnLPFlVWfwnijXEZvLoJvcMr2VTH0g6UqIoUw
	ipufp++tdVAayqBE3LBUQsQFFgIrX/grZWUpqEOi/5QRYm2zqHnaRZPziz9KkXqb
	eBKmENSPb63oGFXjCKrAbCbkZBOnSyFaYw4e0NFNCjt8VLy+cy6YJ37pmwr/pFkF
	9LFGA==
X-ME-Sender: <xms:zhTGZ7nSN3bXGENrq0UwQucCl39Os8FPf1El9OYV5RKSqP9v-WD1qg>
    <xme:zhTGZ-0KmXV1WCet7JNakdQ91e04Hu2gMoPRPMuBK2WLiih__xyUkcYsZgIi5TKJj
    G6gczKNemxPhqBY1A>
X-ME-Received: <xmr:zhTGZxrt1iHnDYh-V6OgzfLwnX4Dy66gkvQrNBZfDJ5mbOJIvTKnzK1JFce5T4E47Nj1coL_WbpBb98jnr9G6sOhQpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeduhffgff
    eiveelteeukeeikeevhfduffdvgeefjeelvdfghfegtdeftdeljeeuueenucffohhmrghi
    nheprgguohgtrdgtrghllhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:zhTGZzm8Y-ZaXQHzI-NTcZlD_6q8vgLdss-lMdbaHsw1sFTCPbaXFg>
    <xmx:zhTGZ50eYuILMmfed-hxuFHQSZRW-RhohPLrqFTbyWfpvXkQZkloOQ>
    <xmx:zhTGZyuz6mo7hbRzP5OzQZWLAnmsz9_8JPBBbzpp0fbG9cOlTTcNaQ>
    <xmx:zhTGZ9V8KEsZYAGIM8V48SFRGj0CXRucRL-jVUhpm1owtEejdvGAVA>
    <xmx:zhTGZywzaA0OzPiusy3KzQsORQfxg4Xu2vTh4u4yFAqQD7thOH1-tinX>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:01 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 12/34] advice.h: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:10 -0500
Message-ID: <20250303204443.360595-13-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250303204443.360595-1-tmz@pobox.com>
References: <20250303204443.360595-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 advice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/advice.h b/advice.h
index cf2284ec43..d233cfc693 100644
--- a/advice.h
+++ b/advice.h
@@ -7,7 +7,7 @@ struct string_list;
  * To add a new advice, you need to:
  * Define a new advice_type.
  * Add a new entry to advice_setting array.
- * Add the new config variable to Documentation/config/advice.txt.
+ * Add the new config variable to Documentation/config/advice.adoc.
  * Call advise_if_enabled to print your advice.
  */
 enum advice_type {
-- 
2.49.0.rc0

