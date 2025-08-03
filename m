Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD932820B9
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203995; cv=none; b=rJ9rpalAdeJd1itFerZcbK9rxJF+ZbVHXpreWN1oFMR45pg+3q47NzyRw85P9k4GJ9MJpd4ICCk5Zt9urb/AZXzlQldoL1SSYZxPpja9pmz8H99Sx/HXL5Z1pzhlgViLoFXxDca+iARNam38UwJxVJfM03bWUT6XVPXpsJqohR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203995; c=relaxed/simple;
	bh=5ihIZ8NnY87Qc/gSJ46m3J0aTvFexNBd1ooiWD94cKA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esBfVsNRIji2YOqWx7SVTgBV4876pAFiEIWvAiFSxD3z4TqfJuG7ui+Cx3Kye4R1/szeQigMFWUd0rrIgjWKM+qRC5PdROKOuMzrQicsFMkAQesMOB0ZU/eB1Pe4kdFHIWFPbdXI2ONDrCIQ8KK6GnkyxZmEFA9Zgir7Q8y4fXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mddlrj+N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UEWrW3Hx; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mddlrj+N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UEWrW3Hx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7D92A140032D;
	Sun,  3 Aug 2025 02:53:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 03 Aug 2025 02:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203993; x=
	1754290393; bh=q5i3i9eXZT5rUc7kOn1093Kw6ZIEM1nJS9xPLbKGxuw=; b=M
	ddlrj+NOfg5O7GJzwwlQTF2y+tvF3Efhy4sfEgGINe4sAPRwhGUK0FEJ2T414MYp
	yp2WbIXzow4zV9YxxemAljQX4Xz6bl9jZ8zayXGtbo/pQk/AcHH9/VtY8jJtZszb
	iP4N9J6mFq+mhWlhKPlC7P6CFdor71ru0SFScvn/ur6s4w6Fuse5QQDpPZR6aP6f
	SpU0zPD9PeZ2o6POgx7r6ytJwLLhYJNarl+N42W7GM65OnlOasPaUsSDlgPQI7qt
	jDa6ykRDtDPLTD22THHiwnTND/I4Dxvdu2GVharUy10Fb8XHs4JGdOHXDVTlgIza
	dsT/F10O+fSk4hFOuhnPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203993; x=1754290393; bh=q5i3i9eXZT5rUc7kOn1093Kw6ZIE
	M1nJS9xPLbKGxuw=; b=UEWrW3HxwSJFneHdBC5n6K6zbE5yG2lfag5P8uY1tcka
	7IMKuwAdUzObwgO33nNHMweYXOt4L3w/9aiKWM3wmYvk5qJvS622cwPoBZkzThUe
	T19uo94i5SHCPRv/HnLP5y5B4tVCvZjVZLlXK64kp/EQPkvC8rhD5UpIAZrBpO5J
	3fOx6KQt9E1ZY2hO6hUX0AON6fQtkZbmXfVPpwAwzQQrM6V2eAHFEXZwtUHL7jRd
	NKdb/ej5Aej7ohjFfXrUJfKc6uZ40WU5qaNuaC4W+KgEmXozf7mpthCrb8gKHHXr
	uBZrwpF8E7gHsgJXjMuOaAvkthB8ZBjVv6LSn1ITrA==
X-ME-Sender: <xms:WQePaJNToY6coJlKWBNTHpScVcB8Jzlp1X6oue8qqjLkZQpOt22EnA>
    <xme:WQePaMKdk2UiFM7-woNN969rQyFtu1DKn6Drj52nLgmUdQrpp-zlbH5XBdlVQqi3J
    MXWERgTStT9KjkOAg>
X-ME-Received: <xmr:WQePaKHASLLd13n-ptbAP_SZR8wWUyAPVMy3ZxNqVupXkZpfVA7wU8vSXnN2U2oO3N9dbZlz3uw8y3o8Ptto7s0gZSEMgEE9hxYX0bY>
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
X-ME-Proxy: <xmx:WQePaEQoPWIWdl4qZU9VDuXNggqpnc8fZ97CM8rDwR9XSPPMccwCSQ>
    <xmx:WQePaGEof3rP2XBh7Vp7lIhb4I4rqCt3EeG58ojOPUXrNcbAl1eK2g>
    <xmx:WQePaA8KbJmFHtq-OAbG9F2y0iiEfG81iM_F_WRSKOfD0DsZ-9YKHg>
    <xmx:WQePaAK6r12iCfXId3HB4-v0Hz6zfNojQK_rFv0wsQmuXQaXWt8MpA>
    <xmx:WQePaLyUmuTTiN70ukIncNjT-KKn5gzGT6iPIBhPAGQdASo05ULV7GDA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:53:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 06/12] merge-tree: do not use strbuf_split*()
Date: Sat,  2 Aug 2025 23:52:58 -0700
Message-ID: <20250803065304.3325286-7-gitster@pobox.com>
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

When reading merge instructions from the standard input, the program
reads from the standard input, splits the line into tokens at
whitespace, and trims each of them before using.  We no longer need
to use strbuf just for trimming, as string_list_split*() family can
trim while splitting a string.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge-tree.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index cf8b06cadc..70235856d7 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -618,32 +618,34 @@ int cmd_merge_tree(int argc,
 			    "--merge-base", "--stdin");
 		line_termination = '\0';
 		while (strbuf_getline_lf(&buf, stdin) != EOF) {
-			struct strbuf **split;
+			struct string_list split = STRING_LIST_INIT_NODUP;
 			const char *input_merge_base = NULL;
 
-			split = strbuf_split(&buf, ' ');
-			if (!split[0] || !split[1])
+			string_list_split_in_place_f(&split, buf.buf, " ", -1,
+						     STRING_LIST_SPLIT_TRIM);
+
+			if (split.nr < 2)
 				die(_("malformed input line: '%s'."), buf.buf);
-			strbuf_rtrim(split[0]);
-			strbuf_rtrim(split[1]);
 
 			/* parse the merge-base */
-			if (!strcmp(split[1]->buf, "--")) {
-				input_merge_base = split[0]->buf;
+			if (!strcmp(split.items[1].string, "--")) {
+				input_merge_base = split.items[0].string;
 			}
 
-			if (input_merge_base && split[2] && split[3] && !split[4]) {
-				strbuf_rtrim(split[2]);
-				strbuf_rtrim(split[3]);
-				real_merge(&o, input_merge_base, split[2]->buf, split[3]->buf, prefix);
-			} else if (!input_merge_base && !split[2]) {
-				real_merge(&o, NULL, split[0]->buf, split[1]->buf, prefix);
+			if (input_merge_base && split.nr == 4) {
+				real_merge(&o, input_merge_base,
+					   split.items[2].string, split.items[3].string,
+					   prefix);
+			} else if (!input_merge_base && split.nr == 2) {
+				real_merge(&o, NULL,
+					   split.items[0].string, split.items[1].string,
+					   prefix);
 			} else {
 				die(_("malformed input line: '%s'."), buf.buf);
 			}
 			maybe_flush_or_die(stdout, "stdout");
 
-			strbuf_list_free(split);
+			string_list_clear(&split, 0);
 		}
 		strbuf_release(&buf);
 
-- 
2.50.1-633-g69dfdd50af

