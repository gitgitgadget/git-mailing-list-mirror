Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728512BD5A3
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947734; cv=none; b=WRtmr33b5lOXGZBSF/emMtwOpFqJ0STYu0kiWEaUXYCwiQAUJvtBdxyaNH4fsPTXPNmNmD4LqglNiGzEj/sQrwW5t2gXUu2tfDafgWQkmlEaN0To6+D3ZBKv+xLYbJHYOmQKbZTVrIJwYisYoiMDSLmh0+j7n6rFEHjJfu0BMLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947734; c=relaxed/simple;
	bh=fksNhb6pMG0LuEvpXY2uf7SZTl5J9fMVxO3mUlh/xBA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u08q14YNExSA44IMISbh5haMMymr9uUbfzDRs9CpmLGAzx6pAGpWnwM1ssWd3lGmAY3abJhr9QHz9PUVf18V6wp2XFabOnsuI0w+37oO3F9Zxf1yAzNsZ9wl6FFW4lQur+MozpkhFboasdBBf8YCVn59OPLaBp12ey/xQdOeLws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hZVp3XXg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F2Hmpqgs; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hZVp3XXg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F2Hmpqgs"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B73731D00DFD;
	Thu, 31 Jul 2025 03:42:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 31 Jul 2025 03:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1753947731; x=
	1754034131; bh=RyJ8BlXFGuOzSY8VtBAGeifRWG43+PG3ohvw9ywWbow=; b=h
	ZVp3XXgcWQgfudeW3tsM9cBAiFWPEkh5Zy1GVMqhLtuK+enUKIfFseBwUEZiI+Uu
	T+1u8MFSu78QHtRsz3GgS4wt3CaLtf68TWWgzT83LP+A3ccQbPt37tMl+XBzzUTx
	A9i9ZEaUbkeRa9agoWEGkGebH7sCJnKSOKuMIwHoZ/DMSjpufj+GVL6U6yo2uXYw
	1iKbhpKMl5t8+O6AMKJWfwMSrYppA3YsBixszPKboYMKGWUjmGz12xE/kEws2szi
	bYK4ih2zLspXo283g+cWrow735/zru5bV2M1yppbI9ONlLsj96ChFHRKdzXZbPzv
	DB2Nt/FrgrEq/zrV6kOLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753947731; x=1754034131; bh=RyJ8BlXFGuOzSY8VtBAGeifRWG43
	+PG3ohvw9ywWbow=; b=F2HmpqgsrkogEG4x+1dh3XlskjodG8+nLzN/5xCeYZU5
	AINAzZHdmTa3uiQQUz5zme5ryScVAmvKuh0k3IQ+4yowKiFLquRWwyA11kpnTMWL
	lfBHUu7LJMTXAWdi/yujdX2+4mRFCZjigd64J2qpadYc2prEeLxhvagyHLrsJ7EL
	/xTPE0Wtt0vBL28yWhlCxxVhXsB2L0L9UKrW0ol3VhnzXoWr0JzDFz8JnfwlzRw3
	g3ikzrcJPm5K5hr4srxV2jP0WkqxJh8exJophguYlpR2V3NAOwPq/FLwFXLS5mpT
	1F7n1VBiNsV8wFe5RkFn9qMK9P/LSoqZog092vOLhw==
X-ME-Sender: <xms:Ux6LaMyfAYJqpOOZC9ZKA7rxBTGGMv0_JCu7OH-vE1D7C8ukAN3mSA>
    <xme:Ux6LaAdImzzyxzBkPhX5FxoriicEhMd3sKKCaOYDVlA5QvhQiF73874rO6oXXZNas
    3s5EJFshesw89mV8A>
X-ME-Received: <xmr:Ux6LaAI-IvHCpPYjD3YvRV-bZXT7bDnAC_clZhWZpaJHJO8VFcedWOXMERbDA9FyHmjHWauC_so734lqstQ6yD0O3ANs95XgTfbQmqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepfeenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:Ux6LaJGw6D6fe4VelareZcTS1hgvxheeTfvcO9nRDaL-7BdzyIcpTw>
    <xmx:Ux6LaCpf-fgg-TnJtY27Bze7asyvwaxHCjXwCrORgTH6z8-xau_boA>
    <xmx:Ux6LaKTz-Q_Ql6ibWaVlJXkwAEHq_U_vGDE1xezriIHwdzQMo92iwg>
    <xmx:Ux6LaHMMVOPxF1JwvXPFAlh_O4Hh7A_IhdQHlPHbTATgeuf24Ak_3w>
    <xmx:Ux6LaHVx2pi9CGcVf2T3WSbiLBaPXPY51ptXAkZFVi0-wsl95cSuKSnO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 03:42:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 9/9] sub-process: do not use strbuf_split*()
Date: Thu, 31 Jul 2025 00:41:54 -0700
Message-ID: <20250731074154.2835370-10-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-612-g4756c59422
In-Reply-To: <20250731074154.2835370-1-gitster@pobox.com>
References: <20250731074154.2835370-1-gitster@pobox.com>
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
 sub-process.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/sub-process.c b/sub-process.c
index 1daf5a9752..de3235c15a 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -5,6 +5,7 @@
 #include "sub-process.h"
 #include "sigchain.h"
 #include "pkt-line.h"
+#include "string-list.h"
 
 int cmd2process_cmp(const void *cmp_data UNUSED,
 		    const struct hashmap_entry *eptr,
@@ -30,23 +31,20 @@ struct subprocess_entry *subprocess_find_entry(struct hashmap *hashmap, const ch
 
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
2.50.1-612-g4756c59422

