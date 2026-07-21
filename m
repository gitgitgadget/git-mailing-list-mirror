Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869EF390CBF
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624311; cv=none; b=WcCkZ03sC09AqnEeg1itJ+fPWqUKJiE+iVowKdl+zZwPm6Wep8wTx0IwNlRiTAWmtC2Gven+3v6D7+R5GbNGwdxZXT1sgIuJMi7eZ8t4P4Fjz2rO8amy7Pajf/JJuGV7ftiu9TvXPOPgTIh5188AlwZoE1aJuo76JRQ3C3liAT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624311; c=relaxed/simple;
	bh=lmrVIQc1JN1X6YqEmBY+VyKP/TT4ddkuTmN90OPOHpA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=p2sFKi/uiW2VSpt4tde4uNGulFFWAKUuWPusj1RkTcaleHUEXw4TDpGWR+YPjr9EMWFrl/eDQAjpczuGQzWfXYydJ0Z3otp4Hh7FOWXkruqjalNjhKb9rAV9KuEjAYWWk/W4Q1t1wFwej1dX/A56+QGZsktXUN3i+Q7jU8z/mVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pt4Ua/lp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pt4Ua/lp"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so6139694b3a.3
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 01:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784624310; x=1785229110; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X17ZpV3aGC64jgZBZQtfRHlV/TEsBgO93FVkD73UJ64=;
        b=pt4Ua/lpKrk3cNafhEdOzwDUq9EvjVTpn1JLWJKAR0Hxvl1LeVoEv2Z7OjLQudR9u5
         lPPtvaoS1l5v6piaKQ+2YKxO/ENVDrruWMYnlGurMHmeUymSO6YVMqK28chrkXiWEgQa
         JVxjl+ip0Md4Ipxp7rgNx5MYb6ls3cdu5ZMv7HJWrTGu3VIJzcN3i79zs0G1wPuyJ9bY
         1nzohBXhATc3m4sy7bdqpnVqOr2t/TLtTxRw8F8ALrBL4CCq6ejoUGyW0vF4YV5r/64B
         rIoVqsiC2hv0v0/DVL0KpQeA5UajTm6XlJhQ23vEdyMQdjWLuUhfUHGQkS/m9cyc6wh2
         2+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784624310; x=1785229110;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X17ZpV3aGC64jgZBZQtfRHlV/TEsBgO93FVkD73UJ64=;
        b=TsXgr0j4gDp3UYYYOHJKsky209jd2RDYSFqrqmrvp0Y6mQcbhqQ3JAEF7BqRR4R8gG
         UrBfiIiWZ+g19zRPZ28/7Z2E1FjxGJlqP3effDdZJSWsWAAXpfc/J24+WiDux5oHlzDI
         IQC5v6HLaAAqK/4syTr7oVtTcJcQ6+Hk566eYE6igvafwhde80G8/JmypiM146c4u/nj
         q8sBSSGiuSuhPAu4CmX0Rafa+HBfSGYiqGHsy45vlHmxDmltHnBe1Dlr1WPgnn1pi5+d
         fw+6ZspLEe3tbwMLRkXkun+txc6of5xbFq/sqAW+UKBjgx11VKel9E6U033EknNo6GxS
         RxxA==
X-Gm-Message-State: AOJu0Ywwg0yuJsZTPdJvFCK4j2bfUHt6y96uOV/QlF35hhWDKdxNYxTt
	Qfx6vSKDKQ9H+8xBao9M2i9pT/hDKO2yshGBCuuLSRHqsbXIMfUC1Leyp+cm0w==
X-Gm-Gg: AR+sD113hyUS5/kcr26PI/KRI3FQtL/cU32W+jfQ8RuD/9IG32ixvFH4dWaT5Gr/V8I
	sc4Q3vKvCY5YoWvsPa3rAKJn4eaAaz53Mge3cNt+zoI3Cg8wPMnAi8Pz6MKiJGAidbssLxGNyRF
	YZ33yxDAZ+7qF2buQjTLyTNMrQDwqRYBMgZ9juUu5VwCVch+jIA3VbRDvJyFS2+h2zFZwslYDCX
	WWXy6ChkKH77Cqj62itOV/3pWlNKdeqWO3AS18CtSYK3y53T3s/uF/+8+O3fEfjgoG08ffYlOpc
	Hh1N9GDrrClNLyJJeAV2rAO1uQpfhjlWtt9Si6KzClSP3lnp0riSFoaJLhc0vNR/bdiPbtgq3Ge
	HqvsdKOPsHl7DNuAWW+/dfSCf6/C8UfywI90UdEDheEvOvUHA7rBVmGxZlaKMn7IKYCffs9EqDc
	d5UYXG7qc=
X-Received: by 2002:a05:6a00:4211:b0:847:7fd5:aaaa with SMTP id d2e1a72fcca58-84c292a0eeamr17424127b3a.17.1784624309795;
        Tue, 21 Jul 2026 01:58:29 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.152.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2ad87f83sm7037639b3a.3.2026.07.21.01.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 01:58:29 -0700 (PDT)
Message-Id: <b1ac49de87c2a8b88aa2aed60b18847734fa906e.1784624306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2358.v2.git.git.1784624306.gitgitgadget@gmail.com>
References: <pull.2358.git.git.1784538618.gitgitgadget@gmail.com>
	<pull.2358.v2.git.git.1784624306.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 Jul 2026 08:58:25 +0000
Subject: [PATCH v2 1/2] remote: pass repository to push tracking helper
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

The next commit needs tracking_for_push_dest() to inspect the
repository's configured remotes. Pass the repository through the
existing callers and mark the new parameter as unused.

No change in behavior.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 remote.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index b17648d6ef..0dc36956c3 100644
--- a/remote.c
+++ b/remote.c
@@ -1887,7 +1887,8 @@ const char *branch_get_upstream(struct branch *branch, struct strbuf *err)
 	return branch->merge[0]->dst;
 }
 
-static char *tracking_for_push_dest(struct remote *remote,
+static char *tracking_for_push_dest(struct repository *repo UNUSED,
+				    struct remote *remote,
 				    const char *refname,
 				    struct strbuf *err)
 {
@@ -1925,13 +1926,13 @@ static char *branch_get_push_1(struct repository *repo,
 					 _("push refspecs for '%s' do not include '%s'"),
 					 remote->name, branch->name);
 
-		ret = tracking_for_push_dest(remote, dst, err);
+		ret = tracking_for_push_dest(repo, remote, dst, err);
 		free(dst);
 		return ret;
 	}
 
 	if (remote->mirror)
-		return tracking_for_push_dest(remote, branch->refname, err);
+		return tracking_for_push_dest(repo, remote, branch->refname, err);
 
 	switch (push_default) {
 	case PUSH_DEFAULT_NOTHING:
@@ -1939,7 +1940,7 @@ static char *branch_get_push_1(struct repository *repo,
 
 	case PUSH_DEFAULT_MATCHING:
 	case PUSH_DEFAULT_CURRENT:
-		return tracking_for_push_dest(remote, branch->refname, err);
+		return tracking_for_push_dest(repo, remote, branch->refname, err);
 
 	case PUSH_DEFAULT_UPSTREAM:
 		return xstrdup_or_null(branch_get_upstream(branch, err));
@@ -1953,7 +1954,7 @@ static char *branch_get_push_1(struct repository *repo,
 			up = branch_get_upstream(branch, err);
 			if (!up)
 				return NULL;
-			cur = tracking_for_push_dest(remote, branch->refname, err);
+			cur = tracking_for_push_dest(repo, remote, branch->refname, err);
 			if (!cur)
 				return NULL;
 			if (strcmp(cur, up)) {
-- 
gitgitgadget

