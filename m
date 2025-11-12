Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A61E2F3638
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984992; cv=none; b=Ph2QGn2UQ8B5CK3gobGwNr86PgN5ujxujjEBD4Pxn4SI4TtCbFRSTF62R91gZsf5wx+Qv9m7gPLjpuCHM4RnV9uXRH4UFPpSjAutDOeV5X+fYoJx7CbOnt0WylD1d8F3fu/wgjbhZZYpVjX7HBUk07Rjvuz6ky1yCb69cUt0jvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984992; c=relaxed/simple;
	bh=KvUprD3+aYERue3ST7U8rpZVbWnGEpLm8NNO/f8DBOg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QS7lRU79nqsvQLoKOW5Bj5zZrDJsufspH5AjyaV/UNJ7nMglIDZicH4pKfn4sAF9c0vxP/ZVIw3osd8gqsw7ECn7lA3CCrGBGeZfnM6EHhwYQun99ER0hLabeth9XCN+n5Lo29TEpHhJgV2M6pfO9+YN3NI325YjSIWV9vCLO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G6tVG2k2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W/fH5QTt; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G6tVG2k2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W/fH5QTt"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D06FF7A0026;
	Wed, 12 Nov 2025 17:03:10 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 12 Nov 2025 17:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762984990; x=
	1763071390; bh=f5/mWa4PKZMSZh7nOxh8GkquCIF5xpA2T9s09c+iNFk=; b=G
	6tVG2k2ANcpMMW3WD8xhkywOgUukV9F/zMjyy+rcZnHmTlOXbc/wENf5FAH7N0Uq
	GHwmPIyzwTK6tHuyt6KPLfI8SafzTUvRKEo95Z8XHbya9+fwoJwvavLKbBHoc7vM
	Y9CWJUNYgm+S/Fhu+x0RvD/GdOblG0nn+7hPQr7RsgbrfpacJzf3uyX3NfN8Gxoe
	PWYdY2NWYeGkbqFzGSR6PlJZa/sudAaQXhX8o9BJCD0owuh6ZZhUhRyUNFqbiCWy
	gV4cLDd1+wgBi5BdcZCUcJF0yXOrFcg+R64O0HwHQmR5KYc1XmJq0I45mFtkbpDU
	vMojw7EFWHKpixkiUu8hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762984990; x=1763071390; bh=f5/mWa4PKZMSZh7nOxh8GkquCIF5
	xpA2T9s09c+iNFk=; b=W/fH5QTtp85Y6zjYKlpwK2wZydmCqlGVkfgffI+EZqQr
	nxy6qXwR60i5sacYRVGgVMj3FOrxI04SPON1FHOrCj4VzluOdoL2GHTfk3Ym12wJ
	Ga6iGOf6255Yzgw9iBcptv4DlHZ9xJTUl3ajSOcNL2Gq7i18oIaJ8O9aAk2CuQay
	gWd0NTnV8CxRPgI+pUfBLosCYpk8SZoKhwG8S+roZycQCCdTdtBWfxSMT1pf2ysI
	pwG+T8G5HVkMItBZY7jmxSGVQzBGiKm4iv3x5xdNSOgYssetU/1Ns+AaiGYR5g9/
	aqbCePGhygPj/C2MvAa/ADklSe9KlLDdBNXsOpPW4w==
X-ME-Sender: <xms:HgQVaU3WKrnYZFKCD2BV5FHVyZyMWqwu4W6zi_I6sIq8-0AE4Ry7eg>
    <xme:HgQVaVEMVoGiVygybFf_CsjAEXbCJlLW_Jl1qTq0NKPymeQUDIHoncs0zqZAJ1mg9
    fp78uGH0-_cPZvIK_jX4yshqdwTJd7-uGPWhsg8-qTAC5hcYDWEmA>
X-ME-Received: <xmr:HgQVaaj6qC18Vd7cOno5LtOt9JE9cvB59WaQBO5cDZsxICcgbt_Xtwty-vquRZQO6PKpRR4gzUM_4-viWY29y6ZllsSRoKYH9oSL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:HgQVaY_y3yxYIk__PFJHScnccU6IRchOjBYtR6oClV8TiCDFam321A>
    <xmx:HgQVaZo-4daT1d86gxWy4Ii80YL-RXE7mMJvbyxi-41ujD4b3kHlTw>
    <xmx:HgQVaf_utbsNgeSR8hOZMG9ANnFzcpM2rmDTjb3UxgqkgMMGB_N7OQ>
    <xmx:HgQVaVWP2LHjU0MP9qUG6mhE3PindwXYX3VY6NlhYHvza-JwIPzpQg>
    <xmx:HgQVaQMP8nS9W_QSMj1EZre1oE7WNkTWl5uP4MkUXjOPf-KjSUKox4aG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 17:03:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 06/12] diff: call emit_callback ecbdata everywhere
Date: Wed, 12 Nov 2025 14:02:52 -0800
Message-ID: <20251112220258.1009253-7-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc2-441-g030905368a
In-Reply-To: <20251112220258.1009253-1-gitster@pobox.com>
References: <20251111000451.2243195-1-gitster@pobox.com>
 <20251112220258.1009253-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Everybody else, except for emit_rewrite_lines(), calls the
emit_callback data ecbdata.  Make sure we call the same thing by
the same name for consistency.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 7ee8620429..44b86544b7 100644
--- a/diff.c
+++ b/diff.c
@@ -1780,7 +1780,7 @@ static void add_line_count(struct strbuf *out, int count)
 	}
 }
 
-static void emit_rewrite_lines(struct emit_callback *ecb,
+static void emit_rewrite_lines(struct emit_callback *ecbdata,
 			       int prefix, const char *data, int size)
 {
 	const char *endp = NULL;
@@ -1791,17 +1791,17 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		endp = memchr(data, '\n', size);
 		len = endp ? (endp - data + 1) : size;
 		if (prefix != '+') {
-			ecb->lno_in_preimage++;
-			emit_del_line(ecb, data, len);
+			ecbdata->lno_in_preimage++;
+			emit_del_line(ecbdata, data, len);
 		} else {
-			ecb->lno_in_postimage++;
-			emit_add_line(ecb, data, len);
+			ecbdata->lno_in_postimage++;
+			emit_add_line(ecbdata, data, len);
 		}
 		size -= len;
 		data += len;
 	}
 	if (!endp)
-		emit_diff_symbol(ecb->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0, 0);
+		emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0, 0);
 }
 
 static void emit_rewrite_diff(const char *name_a,
-- 
2.52.0-rc2-441-g030905368a

