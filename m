Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BD241128
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034719; cv=none; b=B08xXPs3JCxPDwEdPOgDMy4l/ZQ+3Z+3FRFK6bo28K4CrPzn9vc5Uy9OUQP12WvOzM2K7EGlcBnRk/rRxkly737wx6ibV7jYCuBdSs/C5i1yXV2Da+zKRP4bq+oBudbD1suB6gv6PkYtsaTv4CH0/By0TQQhJCQnGuGSoeK8HxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034719; c=relaxed/simple;
	bh=zEuJtkQ9TPdFkFos5FACSEvxOoJx1om/kOnkV71JE+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYKp5w0BAVcYoWAZYMwLSAXd/kIhebgfQ5+hJJiyVynTqMECobi5mqgMP/7zLcJuIBYCkLBp6So4ScH+mpbdexi7cAvVHuuciudRFOWMetBGyYLt9qEC7fLucyihEgzopayZDMt5L3bgMcjqk2zfDXhQUTYJiiWmp7tvAwV8NLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pu3SrZQT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XbpTqZnq; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pu3SrZQT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XbpTqZnq"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 482031382C5C;
	Mon,  3 Mar 2025 15:45:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 03 Mar 2025 15:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034717; x=
	1741121117; bh=Dx3bTQVQylFrwshc2ditdV0GN1nAQ9i2AF8dvvHjuxs=; b=p
	u3SrZQTf219WbADY+4l6hRQWvL9qf8KToYVK5FyCHqlTjm5RIIs0NybNloJxkBBA
	MHpPknb+YXPI7dHEN8woNEJEeo7khTAOSlJC0S0T9MGtZvdFgH2vHmVXN7d4eCNu
	jRxvrjPlIB9/RYN5zk3YwUlZ00oY3m9ZpCdKfTgBwb3MdbQnwyD4g1Ijk3gIL3m6
	opFgO94fD+bKxe7COHwaLrbAncBkyEzqvbU2ax3mdBlVe/8voo1Gl85cGeYP5cqp
	t7CdcCuC/utjpXw+x2t5YNShGe+GhOZm4Yvz4Vd+ZGWZ9OZ800m6+TewkQsQhWMc
	XXznC2EoY5LaWj9kc62fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034717; x=1741121117; bh=D
	x3bTQVQylFrwshc2ditdV0GN1nAQ9i2AF8dvvHjuxs=; b=XbpTqZnqx2kWlTY4z
	Av5so/+Dwwzt7Ni7WIcJrbrHQbpOc4XrOkirW3V0WaS25+I7RCwz1ralrKgNiedF
	uRauSoWEUvfAywcA60Mto3tCmdBd2wJyHYmXphcJRWu96sipn+q/gBRVxuT5ysS5
	kpVCwDJDK/UB3eNgn+Gut5JDOnelqICEWWHkHPZ4SKkLUOv5lxlQKau26Luh6HY1
	hpopp5eG1/BoS5Cq7gRhkLYadFWs+omWZEa++gUIEZM0uQfSaYS77xhI5Ed34fwK
	/ZWIS5YQ1YAsXaya/5wP2+wSJDYMpA/nXKKjmc6w7inBncpmO3XSRTFpoDEmxw3s
	jxbfw==
X-ME-Sender: <xms:3RTGZ8W7v_9NB0g7BgI6CwjuH8NZnuJ2FpfxPqUaqdd5v2XB8aD79Q>
    <xme:3RTGZwkN6F5qnZzwS_3AwQh9TJq_wsAaU4oj-UZZ8APIuFe7gFybL8Y84GoRxSuVK
    v6g69ktj5Wb5brwCQ>
X-ME-Received: <xmr:3RTGZwb7L66GUcqUOsDS8YOmadehE5mF5JytFqXhOY09-ami0Jiui6GmqDJbcj0nSwpJcRJ190D00eCUtUjSA-Cv_7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpeeinecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:3RTGZ7WxYCgmcpeESSx0dOmsHkACw43pIAO_Qp_ik6UtZcDGIq-WUA>
    <xmx:3RTGZ2kM9BWJTUxsK6UqQuzb1c7voQnV3Qv-NsMstrrgVH4A6dZbUg>
    <xmx:3RTGZwc7wpupIyJ33pYRIt3V_wcBeeheeNfSnepgQVVl4qhH1wPQAw>
    <xmx:3RTGZ4H9zMGkXmhfgyh6HE071Cm_8d9SUOAZ3boZQF2g4hBrJQm8yA>
    <xmx:3RTGZ4haXn2pj6x9l9YfAEGExSTyfG5EtDl1mO9sRuBsjWzFi9h50z-q>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:16 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 34/34] xdiff: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:32 -0500
Message-ID: <20250303204443.360595-35-tmz@pobox.com>
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
 xdiff/xdiff.h     | 2 +-
 xdiff/xpatience.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index bb56b23f34..2cecde5afe 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -85,7 +85,7 @@ typedef struct s_xpparam {
 	regex_t **ignore_regex;
 	size_t ignore_regex_nr;
 
-	/* See Documentation/diff-options.txt. */
+	/* See Documentation/diff-options.adoc. */
 	char **anchors;
 	size_t anchors_nr;
 } xpparam_t;
diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 82f663004e..77dc411d19 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -64,7 +64,7 @@ struct hashmap {
 
 		/*
 		 * If 1, this entry can serve as an anchor. See
-		 * Documentation/diff-options.txt for more information.
+		 * Documentation/diff-options.adoc for more information.
 		 */
 		unsigned anchor : 1;
 	} *entries, *first, *last;
-- 
2.49.0.rc0

