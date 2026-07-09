Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B5C3F39DF
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590176; cv=none; b=Az+vxDa2oeruwAYwK1k0y2qMTjvwaMrCUmbMteuQn5ngS6DJcVhdykb2240KbSzaEoNJyvApvIVlHFNcbVfuDC+t9T3WHL0/FOOq2lJVRKOL+W/UnhSGTeteGv+o2Yun+4NHkgf64DuZv7ayAmFNGy+0EwBlAI0FXIZqVV4Ch3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590176; c=relaxed/simple;
	bh=hEfWL/jPuMAnVmm3KkV/gxALN28ezoIwMrSFoVW89YQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dvxcxsFN0S++MIfdYKOv+APtlAJkDFND1f/DYEkYTBLVMvAm9Wdv7k8u3KNvfPoJ1Lm4qOS68rg/UZWhb77PlJViYuGD+EA3PXDVZH7p1HtDqvCR6Ry4VceQLsYA2RAPwoWv3WgbftcRGUr6z3HNt6QHJezgNhZQWJUBj5KSNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gca7EqJr; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gca7EqJr"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e57a753f9so123544585a.2
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 02:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783590174; x=1784194974; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rTmidw4cwETTEaCbJWuGHY9LN06BCGgOEygbm2MGEpU=;
        b=Gca7EqJrNlPoEXWPltHQjX0AtatOVjq0ElR3vObV/QA8iOp51uAb7HZVh+LunTIMwO
         3Wdip8Of5wf/UYfk6fqZQdaApmQf9AoM8Gslzr2JZOBiYHTjUF8ytUQkMN3Ry0529sJZ
         Btpn7xpjP4KYfFrFJhjmfUUAWDUWp2uTr3FLzRInwfu0Y1TS7KLSwnM8GsSzcDDTAzLh
         x+606Sd04toGsrjqoO6CqoZbPKRzf5McC3ueih2G3HT04I94eFkWvPkTigbaOfsSF9Cu
         wtGfmIRSVyVLoA7u8ZWMVktKtZrXnAuxNfgYfnmHfdEjV/xag7kM+/CODHhtvM9m3l3q
         asZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590174; x=1784194974;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rTmidw4cwETTEaCbJWuGHY9LN06BCGgOEygbm2MGEpU=;
        b=jxVhU3dmIOGMptLr4Z346DeD/OgnI0E2mp5gzh5Adm82F3NECjC8GWUqM7SBM0Z8kx
         R9Q1hqDb461SIzRx0zLPWSM+Y3/cF/TzbqkML9MBxcn9PtPbJoi3CnKjbpC7Z1yb5qp/
         YbE9OBxRXdknS4wnfY29A6Hx/rs0UVJ5F8sYPNfbrJRHwvRO2SNk0O1/KuMDQus75GvC
         lMyRDq4HOGrJjijmewvhl7Ng4ddlCfo0sm7dLSahJe3bSXf5g6Xz+hqtWghTe5bMGhz3
         03fbZrh4v4wfCy5qygLEo21GCD7qGkwFl/MPn8dInqiyRcewaUYrDAzFe5hl5Zx1kMyB
         bYlQ==
X-Gm-Message-State: AOJu0YwwM3Rrr2kFrn7k1TtWB44vUM6inJ1/KFODFLU8ecX9/qcukwC6
	vcPwrd3bMFBT/RC2V5cHiAqUdaqcqQ/U1M5EyxynOJty5irJpdRHUim5LsVxvBiJ
X-Gm-Gg: AfdE7cnrYynCpszUJf2YJyCu4/LTYjMSIVp9tX/pkTebn0OHzaa4WgUILDPEvLcTzWl
	xowyC7nIW4WFWTT6CyRb0VERRwBek8MdzPIhsFpCsAnoBhuw4RMWSAtwgKX8nBnIeoEt89GxPGt
	3WxtG8CP0XMIAF2K7GsSb889494W+nQsYGLWRv5/G7xAhXk7NRl618qWXp9D4poc0JF1WEDz3Gg
	ecjIcnq5cUqFS5L+zrXSGFx38zjhBJd6riiXT+Sk8fy5BteVBnqKPFPv9cT5yBYYxBZA9bi5c5k
	aIdUmyVbjb3Bl3pjih96xiklfWYUvfgj7ImilXnDpw2WIFoGinjCTYiwN1IYRGgoRFFsVMpwwu2
	yMvaLQAbDJ9YPojWIpsOQsZdrJCo8SaFwlKmWFRDri30jr1/nGH2QAzFp6D8lKssfTNHw9bUJuG
	fGrr79s+brqK+I
X-Received: by 2002:a05:620a:45ab:b0:92e:c117:9ea7 with SMTP id af79cd13be357-92ecf9047bdmr684053985a.85.1783590173842;
        Thu, 09 Jul 2026 02:42:53 -0700 (PDT)
Received: from [127.0.0.1] ([20.84.47.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ed55e3b6esm269225985a.31.2026.07.09.02.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:42:53 -0700 (PDT)
Message-Id: <9f3a23948475eaa382e9507543fe08d933a4a461.1783590159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 09:42:38 +0000
Subject: [PATCH 11/11] shallow: fix NULL dereference
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

After `write_one_shallow()` calls `lookup_commit()` to find the commit
object for a shallow graft entry, it then checks `if (!c || ...)`.
Inside that block, when the VERBOSE flag is set, it prints the OID being
removed, via `c->object.oid`. But `c` can be NULL (the first condition
in the `||` check).

This happens when a shallow graft entry references a commit object that
is not in the object store (e.g., after a partial fetch or in a
corrupted repository). In that case, `lookup_commit()` returns NULL
because the object cannot be found, the SEEN_ONLY check correctly
decides to remove this entry from .git/shallow, but the verbose message
crashes before the removal can complete.

Use `graft->oid` instead of `c->object.oid` for the message. The graft
entry's OID is the same value (it was used as the lookup key) and is
always available regardless of whether the commit object exists.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 shallow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/shallow.c b/shallow.c
index 07cae44ae5..3d2230351e 100644
--- a/shallow.c
+++ b/shallow.c
@@ -371,7 +371,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 		if (!c || !(c->object.flags & SEEN)) {
 			if (data->flags & VERBOSE)
 				printf("Removing %s from .git/shallow\n",
-				       oid_to_hex(&c->object.oid));
+				       oid_to_hex(&graft->oid));
 			return 0;
 		}
 	}
-- 
gitgitgadget
