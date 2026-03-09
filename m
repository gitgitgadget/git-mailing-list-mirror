Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378C22D4DC
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017697; cv=pass; b=rZWt3FFic7Lh4Zwn/CXDJ6jsByVT1qOKMsl6rsKz+hwXg2Ge1WAx0RUMWxJINZFj2VlvhY6fiRpYRzjogolLVe6+wko5kzUhYvgkZv6zcDBMdyK5LbZzjWjg0ndflfLKsMPkhlbcDntMYMWbWLvh6omSbQxGBClOtsmC/uyErxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017697; c=relaxed/simple;
	bh=oCsJX01J8xRpkAtZ6QxZ0N6yJ1+fd5KHTsvA7lSrDps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJAg1SJM54k1NihwLHLoiTDysVzVGPalUL+iwricSd+k/v9t4e0PU7yZtZqSdEfAlVdbJofvTzdQ0OtSRjJrdB4Y2bVIxeMSvzUasIAi5+NxEJN1jMLU2uUh44dRoHzkmuPIKtfWkjrICMx5S5f8LIEEhXRPiqLlNvwIt/BcBvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=IV9wG6ih; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="IV9wG6ih"
ARC-Seal: i=1; a=rsa-sha256; t=1773017685; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z6ZhEm0KkLoc26qQ1xdVBO4iBJ/ZVI/ZWKIUv63KJISsPOh7kQb7G9GXHULCvHLzC/hiTmtxsw/HPnVF+Xg/Dmm93Whpx190z3ztHbn05K6o1zH0FUPlOdcO7mnZrJQROruvAiqZy1jCiBOJGKqzSizfHwDKnES05/nERy2jZbg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773017685; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iNdMJ59Ar2KNpwMPp2OPegkzQOQt+ezDVxR1jph5auU=; 
	b=AOsUi6vxocF+jJZD6anJbapmIRspGy10HcCo5nEB/W+9lFUVX/D3x7mKZeYwST3tw2053/cZqWB8vnDyQ4lVbe0Pr2K/aUNxyWbCcumlIYtUAnmkZG+v0l+skVBhmBcsARqv+fEt266zQMGXnFJoWX4xQo45GuCQXuMkc5QCuNk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773017685;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=iNdMJ59Ar2KNpwMPp2OPegkzQOQt+ezDVxR1jph5auU=;
	b=IV9wG6iheN7zhO1acy1EPhlma1EBIEvwWMGVaZyRZKMaDyOBbK0AoAk9xyJoSSBv
	zQY7urDFWlA9fASWMjLbEIeq66FuIgoCeERzihrbCJHugYGVmC0LwlkdGr2Ijlw7uDp
	Uj8UhlDwe1VEhMcAoVyXEEltCHkCRbX1yAS6GyIU=
Received: by mx.zohomail.com with SMTPS id 1773017683101633.0080154574981;
	Sun, 8 Mar 2026 17:54:43 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 04/10] hook: detect & emit two more bugs
Date: Mon,  9 Mar 2026 02:54:10 +0200
Message-ID: <20260309005416.2760030-5-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Trigger a bug when an unknown hook type is encountered while
setting up hook execution.

Also issue a bug if a configured hook is enabled without a cmd.

Mostly useful for defensive coding.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 hook.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hook.c b/hook.c
index bc1c45b16d..b8ed4d79e2 100644
--- a/hook.c
+++ b/hook.c
@@ -408,7 +408,11 @@ static int pick_next_hook(struct child_process *cp,
 	} else if (h->kind == HOOK_CONFIGURED) {
 		/* to enable oneliners, let config-specified hooks run in shell. */
 		cp->use_shell = true;
+		if (!h->u.configured.command)
+			BUG("non-disabled HOOK_CONFIGURED hook has no command");
 		strvec_push(&cp->args, h->u.configured.command);
+	} else {
+		BUG("unknown hook kind");
 	}
 
 	if (!cp->args.nr)
-- 
2.52.0.732.gb351b5166d.dirty

