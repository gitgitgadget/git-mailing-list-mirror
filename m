Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171302C234E
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789023208; cv=none; b=jdr15+T5uOMC8TuVfEeUNewfFJ+0OVRJ/OHQNdg13A3UFBkpVXwkKZacPrafUgeCxeP5W7D4Ziw7w8IXKAq/P9r6tK5AYe5v09yQp/uFSuA5yYWsne8Kv8qATfZ6Jt06hMDW6HDL4vRmsCvO8OLhPTfWuHYg8MDcFkskUwmF/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789023208; c=relaxed/simple;
	bh=ODRLCCi25NebE3gaRAlvYF+AhOJeeo+eNRG7tuNve/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:
	 In-Reply-To:References:To:Cc; b=Dcvq5UScujDQdE/bJ6AoB+S9OI2hsgbdGbx2P3uLa1nMPsCreVbifw+iPykLX6BXbbopuh6qdo+aCu8rtwFHrMZvEHkn5ikIft1qqt2dLqIPOUFjwshBqXsI0xYc4hscikALhXp0XMQzoHh+0Qq6a6L2IsbU5tKFq1hobrzAwMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=D3orWOta; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="D3orWOta"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so6720894a91.2
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 23:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1789023206; x=1789628006; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VGHpbYjD7aWcb10NJjOqSWx8VKgc+CxvAYFe0IJiyLs=;
        b=D3orWOtaUt5Ke8kQvp7r04R6Tc/Nav1alFXMqgKKEih1ESszlwrjhi6HIYA/iJ/Lmu
         AyLAXxRsE9YTp7V8mDwDysj45P0vDg80h+AzuWxOtqwm3XbtnAof9tfnjCpxfH1TSgR8
         tg0gemE/xnyI5ZXEUl1WHzf5uKz1x9AZCh+9gkT1YunOAN+kjAJXPTvUCaYicXFC4I86
         QKdntCE9lMFg+2qaY2VGCEbhZlXMQK72N2qU5tjHGZkgJ6H3E3T5M8nZeEsTSypBjHHC
         9E3NX+nVh/YHdbsFrAHLFzNdA5iOtTx97EJd6QeeTW+eX/BFVamiaF7Qo4mrtMxiYUOX
         M4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789023206; x=1789628006;
        h=cc:to:references:in-reply-to:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VGHpbYjD7aWcb10NJjOqSWx8VKgc+CxvAYFe0IJiyLs=;
        b=WmdA6BxK4S8gcUse7aAGBX/ZydJtFBpKGhvenJOwj7DJSFw6GrpjQSEIzm9xBr9MLG
         fsZZ3GOj5Q4sipCow9RJj9geqinBw09Cvrv/3xwtoJuUPB3QZMlF773G+VQ1/yaCfZTc
         w2N+dsKjQ4WSAAqC5awqJRRzShqHtLItAtL33sQo+JfSDT0v7wgQwypw9RkfBEgrtJUi
         bcEu9iNUePLnJStBi2boOLToVdzUbfuPISONGALs2oV0WtCxnDM8+H9Y6ClcQX5VyMFG
         GXsfrivsZsPk1+qzqwVJ9i8OnM9D3dkhE4g9ofIB+bVpNEYRfouWcSdgtBMSycv2ki7I
         e6ew==
X-Gm-Message-State: AFuF++mFawuMH+qOOYgZJb/QLcj6tKZ5oT7xvZy3cv08Rh5F+7eqiedp
	ytHa9MhFq19e9FJHsoPKKYL4k05sTW9e4VzLo7RpCl9Y34EFLwBEQvBZfsH/9yQ3zc0=
X-Gm-Gg: AYBFou3j59Yskyj4OR/FfA53yR7YnzXJavmQHrKMPYO47CukdJZomDlSWl9Q50+kd2r
	uKYeozyca/vxGZM7BQjQv0nc+zJsGhlS7Mc7YpKSJHR+wbvLbGHdGnwNebxQczY/BgSJyLYEiEn
	rbepzBIiv6ah/Fsl7CQual91j4Ja+lLTYd7wwbI75pWIA9mEVQHiaqlYNKb+YkFdgtQOcVKZ8vL
	7KAAyA1rzYEq6cmomUWSVi/DytEN7bRea7A4iYRup2/ws202AYYNVI4aDuGCeMrU9qFwMhMK6VL
	tfPcww8InnyiEiE7NqzSFMRvs4pyQLxGdzOTHiow6kzztkvZPfqQV9JG2Hh0ESlAAcubRdhXcpv
	LNbAAVFhjLk7w/oCgmCmLnqCMd7CZVA2oD72/NwGgxr4cC3tnRG0j1ZDv1sm8PVzDOtmbC/ljfD
	2AH9sFnSPWhu/7yXehvfvs1ZKg+0D58hyeD5Ucc3EMp2UaIEZM+j1WAJRhQRBAwnYPlAB1wr2A3
	c3Uk5uVXwHXjNn/hNp6QfeHi1vTEQ==
X-Received: by 2002:a17:90b:2f46:b0:398:9c39:520f with SMTP id 98e67ed59e1d1-39b261e763dmr61384300a91.15.1789023206395;
        Wed, 09 Sep 2026 23:53:26 -0700 (PDT)
Received: from brighamcampbell.com ([2601:680:c200:5c88::1fa4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435648esm60094986c88.5.2026.09.09.23.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:53:25 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Date: Thu, 10 Sep 2026 00:52:31 -0600
Subject: [PATCH v2] doc: fix conjoined maintenance strategies in
 git-config(1)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-maintenance-doc-bullet-fix-v2-1-3ed1c75e24b2@brighamcampbell.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NSw6DIBRFt2IY9zWA0WpH3UfjgM9TaRAMoGlj3
 HvRbqDDc3NzzkYiBoOR3IuNBFxNNN5l4JeCqFG4AcHozIRTXtOW3mASxiV0wikE7RXIxVpM0Js
 36LJivCr7RrSMZMEcMM+n/Nn9OC7yhSodxuMxmph8+Jz1lR2/v0IrAwZa0UZLrJlo+EMGM4xiU
 mKaJVp7VX4i3b7vX0rqIivgAAAA
X-Change-ID: 20260907-maintenance-doc-bullet-fix-d351253f8a91
In-Reply-To: <20260907-maintenance-doc-bullet-fix-v1-1-dc08dbe61a82@brighamcampbell.com>
References: <20260907-maintenance-doc-bullet-fix-v1-1-dc08dbe61a82@brighamcampbell.com>
To: git@vger.kernel.org
Cc: Brigham Campbell <me@brighamcampbell.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1869;
 i=me@brighamcampbell.com; h=from:subject:message-id;
 bh=ODRLCCi25NebE3gaRAlvYF+AhOJeeo+eNRG7tuNve/E=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ9ai4CeS4tnaBTJalcy/H1yLnsXeI23Ma3Nn9wK/loqL/
 a2viyw6SlkYxLgYZMUUWVRuzVK/ONn60cEI/gkwc1iZQIYwcHEKwET2nWdkuKhtYhpwPtrOf/Y+
 n85IQ86tbbulmTSkNGY9Mb4wN7pai+Gf9un+gCmf9b+kZ81Z7c+SeO1S7k+2SuH4M3t1/I5aG4m
 yAAA=
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

Fix conjoined bullet items for the maintenance strategies in
git-config(1). Reportedly, asciidoctor renders this document correctly
both before and after this patch. asciidoc renders it correctly only
_after_ this patch.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
I wouldn't normally spin a v2 this quickly, but Jun specifically asked
for v2 on a thread on the "what's cooking" news.

Patrick, Kristoffer, if this revision is to your liking, I'd appreciate
an Acked-by from either of you. If not, please let me know what to
change for v3.

Changes in v2:
- Tweak commit message wording
- Link to v1: https://patch.msgid.link/20260907-maintenance-doc-bullet-fix-v1-1-dc08dbe61a82@brighamcampbell.com

Cc: git@vger.kernel.org
To: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
---
 Documentation/config/maintenance.adoc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/config/maintenance.adoc b/Documentation/config/maintenance.adoc
index da8be9f812..c778ab09ac 100644
--- a/Documentation/config/maintenance.adoc
+++ b/Documentation/config/maintenance.adoc
@@ -41,6 +41,7 @@ The possible strategies are:
 This repacking strategy is a full replacement for the `gc` strategy and is
 recommended for large repositories. This is the default strategy for manual
 maintenance.
++
 * `incremental`: This setting optimizes for performing small maintenance
   activities that do not delete any data. This does not schedule the `gc`
   task, but runs the `prefetch` and `commit-graph` tasks hourly, the

---
base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
change-id: 20260907-maintenance-doc-bullet-fix-d351253f8a91

Thanks!
-- 
Brigham Campbell
https://brighamcampbell.com

