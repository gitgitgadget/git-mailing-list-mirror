Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2EA283145
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754204001; cv=none; b=jq1osSIKbrDhgtBRGzlr91OSBIJAyKZEC2T4fDzoDBX1qNR0RkaR4wtdzhmbyMqrh5EZoqHYaYIV9Lod3KSGXIB5hBnRn6jBoNHX1L6yYUIraOq1UZBBvqpvAZoj8roTNgGo/3FXi8HTun1taDuK+qDI7YN6WrEqbhAyZIGloac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754204001; c=relaxed/simple;
	bh=/H5LLNYAL6d4lm5ZDuVzdI10sWZJeaWE5829qZa5JUY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfIx+V+1L1js+XTLwXa1+K1y+K0TQQTGc+N/YM95JoxwjscllHa+qHYX+XNm37/G3iQAfFMHnvIZgIFrAdbvKv2PzUP4dHb5E+WIVPNC7DtuIgMjJB21S7XqVA8QUeqMkcJ8IckhQxaYEeQZ50nrO0p+oeHODm3aO1rd7D6yX6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HjTQdvB+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ge+0Ph3W; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HjTQdvB+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ge+0Ph3W"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D9CD51400350;
	Sun,  3 Aug 2025 02:53:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 03 Aug 2025 02:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203998; x=
	1754290398; bh=z3gEoBaw6FweMR6/J/5AW+3WTLPisDU1Oe/bwU9zNWw=; b=H
	jTQdvB+PPsNZzE8TnuTyvjtREJww0wD/yqMnJvLlVgFUFcLdEza0VqdXlDXFMLav
	40Nb82xkXDf0lAHgMJPPbgnyYlEGfuLZDl9w+hOFCI8vUQhnLQFgPvRzX2flIOmr
	ndcVut/qs5z7s3pEIF7j0qzoev6uSdGE+AzMtE+w4obw96j+dfbT3wgOYzDnys5c
	wy/VTT+0s4kWl3NDib7w9FA7ygmpJnsDWvF3Ew+QKhgpRbT3e5q9uEArjdN9OczM
	8Oy1jBCTciPzo7HtKawpGdK9W3l5Q9ALNo1VJOPaHp7lIbCBoZpxISUP3Kar1oaU
	6tPEgbRP+WUn9nSgUonig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203998; x=1754290398; bh=z3gEoBaw6FweMR6/J/5AW+3WTLPi
	sDU1Oe/bwU9zNWw=; b=ge+0Ph3WaHskKqG31E23EThYgUJIq1++XQE2DaPt51Qt
	zsj9qKIImMsukHb3cyXvlyy6vDOBujfzJFyIeezSUwq7N06bDNlMQsyabF/mYOSk
	4uEHsYyqFFa7Ax/P6Z5xmjFoph6Y+8vmPBkYj5ISod93mtC8w154yTsFVyhhdZ8l
	IUW6f5WXjX+CM8Ye5WxUrMgQV/R4cZWH1ts+khp/HplVzXL4hXEXk9mBkBc3aAhq
	/irGAXe6YqSlnLcBqRcpCad69yhKdAUWvXBnGUkAOC0W6Lkkl7gH9WaULRHSoUwN
	2/ZCA+CjTyc8bkQjZ5oZH6Xo+ALNYbKGi2YXD1Cm3A==
X-ME-Sender: <xms:XgePaEnPXROb5RcawNtTeyNGuHWWE8ifwMkvzq6cI2I8zJorcFMSbg>
    <xme:XgePaEDOwSAbA6SfN_B3vInBYmyOSWZ1SrntLZZQLRU5sV9REbrBNfTv8aV-k2fHI
    T36hZoGcOHhI-0QFw>
X-ME-Received: <xmr:XgePaEearNx3TOWK_E5G0OA_LgUeiHKlYSbdSacW2EHRaqdXPDn6vX4YeyOFUr5k960_oZZ6uK0OGgWHOBzpqrYuG1jLf6uZyqzrsGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepieenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:XgePaPL3U70TJZPNnrGdAXqCDLfhQCkf8Pxa-Oi8kQa5TIf4oBudQA>
    <xmx:XgePaHfpMxoE1M-IfMz5MgIlzms577Gh498_xM98G62hxPjj1rgBjA>
    <xmx:XgePaG0EJBO2mVsdEBeBMYg5zWvpLzkfkQ6fLoL01mu10GC4O132gg>
    <xmx:XgePaAjInc7tpkXjEUJuKaaj979zk5KdJ9DlbOvGmrH0WG7jY9aEOw>
    <xmx:XgePaHIjvaQKaXYPxrw5b-hejHL2-aGqh3Alh4tMmhN7Ng9xezFZCcvO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:53:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 10/12] sub-process: do not use strbuf_split*()
Date: Sat,  2 Aug 2025 23:53:02 -0700
Message-ID: <20250803065304.3325286-11-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g69dfdd50af
In-Reply-To: <20250803065304.3325286-1-gitster@pobox.com>
References: <20250801220423.1230969-1-gitster@pobox.com>
 <20250803065304.3325286-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code to read status from subprocess reads one packet line and
tries to find "status=<foo>".  It is way overkill to split the line
into an array of two strbufs to extract <foo>.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sub-process.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/sub-process.c b/sub-process.c
index 1daf5a9752..83bf0a0e82 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -30,23 +30,20 @@ struct subprocess_entry *subprocess_find_entry(struct hashmap *hashmap, const ch
 
 int subprocess_read_status(int fd, struct strbuf *status)
 {
-	struct strbuf **pair;
-	char *line;
 	int len;
 
 	for (;;) {
+		char *line;
+		const char *value;
+
 		len = packet_read_line_gently(fd, NULL, &line);
 		if ((len < 0) || !line)
 			break;
-		pair = strbuf_split_str(line, '=', 2);
-		if (pair[0] && pair[0]->len && pair[1]) {
+		if (skip_prefix(line, "status=", &value)) {
 			/* the last "status=<foo>" line wins */
-			if (!strcmp(pair[0]->buf, "status=")) {
-				strbuf_reset(status);
-				strbuf_addbuf(status, pair[1]);
-			}
+			strbuf_reset(status);
+			strbuf_addstr(status, value);
 		}
-		strbuf_list_free(pair);
 	}
 
 	return (len < 0) ? len : 0;
-- 
2.50.1-633-g69dfdd50af

