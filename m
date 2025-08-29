Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5342765D7
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480973; cv=none; b=Xiv3IH7cgzVaTDBVtGkpqoFcTUgv1lMwqyBCyov1TEMC1P2fU7/DMpB9uXTa1xDNpFquKFjydM28ZP7WLgAnLS0KI0R9yoC9mWPlIEr61u21JXA5ipzz3V0vMQ/ZpVl0IPRvf3crp+Y4VVrAgUHRn+4+KeK/xHxf4rc5bJmDPOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480973; c=relaxed/simple;
	bh=fHG1fSDNj9pEk07Zwt/08ZM8l45/LPoz6cMbB8NgcTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1iGar3N1KFU5qgwcC0G1INUYGAYXw2Op3qJAF5pYn5iRS1w4f40hidRpIi+pURA+bUTC2V5JiLS8vTGnmP8U1W6j1VZquP8/jv3vt+37Q8bpVMf9pnCDDMeo1Uhbko+KLciM8YhUj4DS3SONpoxwPA+NQ3gc4lhCWcgxsXaIb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ajkQfjOv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e23OeDWk; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ajkQfjOv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e23OeDWk"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 92EBCEC0304;
	Fri, 29 Aug 2025 11:22:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 29 Aug 2025 11:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1756480970; x=
	1756567370; bh=BJ8pgPuYFh04N/uSN3OPxGh2IBHkwwZIOUCEKG+BeM8=; b=a
	jkQfjOvvrUegGVnkgc0fg3HROeVuhAZldq4ADzQ5NwDyCg6unp4Byg9H2Y738sfb
	YnLNqgOj9lKXMHLy5/AlKHt+cuphEHc3caU41DY+r19Gz4qiw3RTpKeO9VMAKdpd
	5zTDiH4jLPKh84plSvrr4zCX88IPOqbV1CKKAgS2QW6dhAP64Xqzb6qo9/xGroBj
	1/AymONs9q3BkKWKOdbU2+CYm0nhjRKG3EzB3qdiFbmwYbo5d+ZGReMhrwJCyrAV
	2n++WpKC7hORTb0zufw9dN11JDguvIhi1HWV8uictMQ63t1BrVMB7JfiTBM0RIbB
	txjcQB2qsqcqJuU8B+ifw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756480970; x=1756567370; bh=B
	J8pgPuYFh04N/uSN3OPxGh2IBHkwwZIOUCEKG+BeM8=; b=e23OeDWk5NrZ3nTSc
	KdVWLAQghE07AXpyxHADOo5zV4qYT6zSAHaew8U9mHcvUYx5wU6XRkQwPEYq9UOW
	Rzm2eeOXnHQdqvQdGVuvWumXMbF0GT6PuWS/n+C4iYNL28YRxYgsy6whKlbQyIVC
	yl2nZGkbGXR99s8VpXMCcz1yKrleutHH2yv6sropQGdNtxUh/2293bEzlgd83bBx
	AssSOpPi0Eh6jpcfNzNjng1oay9LlMKCU2uSVHCFIOu5FJWNPRfmnI6YD8wetIBm
	5fbocanWW/LRYhzA8cUXRCvkYQdl0N+JpQNJYxt5WD+SqTMK9tzcSSSw36umhjQt
	1DLdw==
X-ME-Sender: <xms:ysWxaPMVhJoPh-GFkX02JbMeq2kKGScyw3Q4nGImNawKCsLl0Y5Q9OM>
    <xme:ysWxaNOyd6Cou2Z-zEzv9xNQw25tWq1dw109yHo5b_DBcQKX3lImnbxormEFt3_sO
    G6z3BxUD7geed8xTw>
X-ME-Received: <xmr:ysWxaHs575rBSOJw_-eudwaINPaz7HGYGGIxBB8DyGML7CUQRRdm7pJjziZXqGzakjZbZji7knk8q2BNJw7jvfLSmwCaclYHtjaChNYkncywlU3irc684ankcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepfeehteekfedtieffvdejteeutefhuefgtefgtdevhefhveffuefftdehiedtfedu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdr
    nhgrmhgvpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:ysWxaPV2Rff2QSS8fN8mqANJnyhplhukadvnu9MOaoiS71GaFjy8fg>
    <xmx:ysWxaHtF4dvQ_BDHhhtuMgS5lkaGJ-Eb9vWP3a5rjPeZnlps5tCfrg>
    <xmx:ysWxaDUhjijhJuv_7PrCfMRSlWRJOpJtAkShiYT8wc8hOFdKfAmyJw>
    <xmx:ysWxaCmCZOyLoe4Ptn38lBBfqHKSxaAeW3LyyRfhzYrv-aH1hjvmvw>
    <xmx:ysWxaBdSUTK5KLi5ICTlac74MBWReL36kWez390btZkpWjR1JkKci3yi>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 11:22:49 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/4] BreakingChanges: remove claim about whatchanged reports
Date: Fri, 29 Aug 2025 17:21:06 +0200
Message-ID: <9196c3c7e33dbd7027096cf7c7bf342869ee2c57.1756480827.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1756480827.git.code@khaugsbakk.name>
References: <cover.1756311355.git.code@khaugsbakk.name> <cover.1756480827.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This was written in e836757e14b (whatschanged: list it in
BreakingChanges document, 2025-05-12) which was on the same
topic that added the `--i-still-use-this` requirement.[1]

Maybe it was a work-in-progress comment/status.

[1]: jc/you-still-use-whatchanged

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Footnote solely to avoid awkward paragraph wrapping...

 Documentation/BreakingChanges.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index f8d2eba061c..c4985163c3c 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -235,7 +235,7 @@ These features will be removed.
   equivalent `git log --raw`.  We have nominated the command for
   removal, have changed the command to refuse to work unless the
   `--i-still-use-this` option is given, and asked the users to report
-  when they do so.  So far there hasn't been a single complaint.
+  when they do so.
 +
 The command will be removed.
 
-- 
2.51.0.16.gcd94ab5bf81

