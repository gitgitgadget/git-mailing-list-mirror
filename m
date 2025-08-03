Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4D2283686
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754204002; cv=none; b=rskn/IVhO8NjJ5xp6BfKz6r+V3mP+1Nm9E2N0mPUx0c4YBpoL3thQr4/R1XmlEC43CG5vZDKrALcuHoWcig+DWCSMeFo+WwUojWgu4G41QydJQ0Qcv2Hf5Yi5murcboyoLhO7ftOXXQB1Sq3iq4nSGkdIoG/kquHxJQ/0FcO+zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754204002; c=relaxed/simple;
	bh=zpSiz+Fg9mEHyDzGyb3B0QhOO/lIZK43BD1WB1t9cwI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdI08bgi69fPGbGNYdhgNWyzaUCpM5VnIB1VZx8w7ZL6h15SawlzCvU4YKN7othu9rN0I8cdteyvcY/MVCkcxeBkslVe0HxPhfZJrrIlV3KjfdbVUpDVgq2YxnUg9ARsHbQ0UaWSO18yxL4jTBifqFxri89QqrH+ZoMJtjXRkrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Exgauzqv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ebJzK5TO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Exgauzqv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ebJzK5TO"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 34059EC1275;
	Sun,  3 Aug 2025 02:53:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 03 Aug 2025 02:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754204000; x=
	1754290400; bh=yZBugOxVBskA918GdVHxTNLynFXxd/D9kpQ5MZMc8cg=; b=E
	xgauzqvFra22nWrPtpcP8vcULnNClMPucIsj8Vcq9jkxpyAXDW+qVWZ0y1up/zGA
	Aa0sIsf+u9OkGtxW/6kYrRU7nWKcDZXuudCw+Epeiu8wfSFtp+FIL3ZIqThybWVN
	p9a3pySIcWWVnc8VwtEG4seevnxJFsaXHV1zsbQv0PtSzHn1E5HABPbYGQPj91td
	0AojQ82kEg7PfC0cCIBywCIMKN1nfIEdRvgXwVMasaz7/srF6jW7r3rLF6a2dLwG
	ZJqcTuxDOcaOeVBO9daPN+3jE63giU2b0isVQtx7JQ6zCpe1ZzVbK+akJXWlfxp/
	TNHJ/k/5Mfou8s3Je79Ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754204000; x=1754290400; bh=yZBugOxVBskA918GdVHxTNLynFXx
	d/D9kpQ5MZMc8cg=; b=ebJzK5TOdDD6G+v/jjWDFvOFIyrqzCDok3tqLrcJV7eN
	ipP90BYbYL5es+cIHc+V6VvSTybk/u825xmFzKLJvbuSwqo/HyUqr3R2HnD2NOI6
	6IGsFbxC1PJ78gU/rcojDqA/iRYxJsSupkbn+D2EIyl57tbPQXik+/Bs8P0wttFa
	+FwdAdmmKhons9+NGwpDAp468dFGMqCgz5bvoNtDLqaYoqn/euarTZo53mkN/muc
	yFzKtqLhGsfIVeWqqayrI/ixyeWx+ufd/fDKA2newpR+p1DK7FK66vF61QPqCiwn
	UxMB6w4Dg2Q4xtJhD/7q6Gz11KApP/mtIb84a3/ZZw==
X-ME-Sender: <xms:YAePaCNJ46ySp4Zp1Voe5mbvct11_BgA6b4DYJnSUiAd9347yy1y7Q>
    <xme:YAePaBKMCMsTT5oaiTuR7qLzqam85_IBB64hClT_oBNzYOZLsu_i8d-_EMo8wWTYM
    zBydd9MAqkttj32aw>
X-ME-Received: <xmr:YAePaLEY7gQxqldvqxqrkb2xgRDlJyNoeVIW1TF9EUqeOZ6Q_kkDZaomtvj78dj1jFYKsFAMQauhfXTSOsfT2NIg--bsxlEnSWn0mwo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepgeenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:YAePaBQHgi6SUFR6xJZyLU2Ha48NGhgyV4SE0BZA0YeGUp2xnHayOA>
    <xmx:YAePaPHmwBurMo8FLfTiGAo_LSGa4uzqdmYD1NA6z1Qo7CbLnTExPA>
    <xmx:YAePaF-NX-A9BjkedsotVC_QHGY2c8O4UhL3s1Hn5kLQWWKL_5LLLw>
    <xmx:YAePaBKDGMmrICx9_SzQusOgOU9tQEQj527QXhQgPyuPBfYUt0UL3A>
    <xmx:YAePaEySVkEtVN7n1EX70F5etyijrmYMANrVlKPRM6GwoGZxuBiRaStO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:53:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 11/12] trace2: trim_trailing_newline followed by trim is a no-op
Date: Sat,  2 Aug 2025 23:53:03 -0700
Message-ID: <20250803065304.3325286-12-gitster@pobox.com>
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

strbuf_trim_trailing_newline() removes a LF or a CRLF from the tail
of a string.  If the code plans to call strbuf_trim() immediately
after doing so, the code is better off skipping the EOL trimming in
the first place.  After all, LF/CRLF at the end is a mere special
case of whitespaces at the end of the string, which will be removed
by strbuf_rtrim() anyway.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trace2/tr2_cfg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index 22a99a0682..2b7cfcd10c 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -39,7 +39,6 @@ static int tr2_cfg_load_patterns(void)
 
 		if (buf->len && buf->buf[buf->len - 1] == ',')
 			strbuf_setlen(buf, buf->len - 1);
-		strbuf_trim_trailing_newline(*s);
 		strbuf_trim(*s);
 	}
 
@@ -78,7 +77,6 @@ static int tr2_load_env_vars(void)
 
 		if (buf->len && buf->buf[buf->len - 1] == ',')
 			strbuf_setlen(buf, buf->len - 1);
-		strbuf_trim_trailing_newline(*s);
 		strbuf_trim(*s);
 	}
 
-- 
2.50.1-633-g69dfdd50af

