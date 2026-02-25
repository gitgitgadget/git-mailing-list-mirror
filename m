Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64771F8723
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978887; cv=none; b=L3YeW8A8XnR5VPrGbscb6stWFQKI3tcpJfldEnkAoqtknNb/O9jYPMFJ1r4q9Ay2XKPFI4Utl68V/A+TN2I/5LnyX5Po9dZBmI7sV2nqo/VM87grO+vxIUAcl3eKCnh9oeUKm8+VE/OEBRcdZ1s+9rSCAJ6PngBAXH6GKj0RABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978887; c=relaxed/simple;
	bh=uRiaTdjrfnSAxesQJ1K3P2DjzQ90dMi25DigcQwOKrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/vfTIbSLyq2I5zhsvWa8ZUoYdWDSH8d9NSem4Sxj9/O5rHMD82tr5PdMy2p1FTviU2OQOEz1s6fOCnoTyrkiXmU2cCJbWvTn/InlmKNja8LpjTJPPIuJd4rufcwI3W0gh7MqvJimo8Myw2K2W7IaHshWJd0Wj+y3UZv0+BXzfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=iaBEUtPd; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="iaBEUtPd"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb38e6d164so755560385a.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771978884; x=1772583684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uib9vKsIiwp/sfDN0kkoJHfJRexmVWd4InGX0A4D/3s=;
        b=iaBEUtPdyh+YoAh9qxWu2iVWZuQwGVY5C70TcyWnQbo9I+BaZHwRBW++LbXKakmGsI
         yTN0r8f9+wYGS8ibLLYThyolCDKI895iE+6KohotXc06MzhgKCo9+Zr4o1AW4QM9ifxs
         Uh2/kxpKP3yGEiNKNe4hLSXtrK3Gw0P9PNs4LmMn7DOatobbI1Sv/t9uYn3sPJbAq10M
         /hf6xToutkKKXcSxtmHA+29zTYxeagz0L/EZPSBpEgv1RO62DGKr57V1Br6SST35q1cW
         dOf8SLsoiCUPs8jmzgwK9TsOQtUJFTqn56+Fk17rgdxgFevaPSLeEs/H04KSnsCPU2ks
         7CJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978885; x=1772583685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uib9vKsIiwp/sfDN0kkoJHfJRexmVWd4InGX0A4D/3s=;
        b=JPfAMp6zcnoQ8K6fGirvT3C+yt24PNWul0ik7UUYJQlUwJW/I0eXAQZBJIZGbZc5WC
         UUy6G5GczP3Ed6wzs6K2r1cJLxPzG1Ur5mYpwGuRf38AHro8eV7UW4rtG+MxKw4qY5qu
         dxWXQLYj6l7ipzl/AIPEkV+4IzwZtqA289WclhozPTcQXaAFAbGGfK5+dKWtQzhbuhJH
         JMPwwV3MJoS9aeZZSnlYPwYrPtKX8F+6DWI7bGlsKLVJCTUHr2GjLuqTW+BGvte2lapp
         wWL/wP65NlHu4jxUDeJKPgicOsZHS+ysB3iuxpeym7rm0eDFqd+IuU+K6jHwcxBD6PDg
         Hxyg==
X-Gm-Message-State: AOJu0YwG8H/rK6R1fRMNEdMsHBATFY0UIIHFQA9TVGrRDDORUnBg//zw
	3svEocyHlOhYKifJymFBstjKPfRmApuv2aGw0DJQVkYQNQBLWcgMWu8H4Nkudnc30Q2UoL5zmMO
	H0f2P3NNzpg==
X-Gm-Gg: ATEYQzwQ+BGNHMy+ROqWMX+K4D8sqzwlFRvZL9zIIYKYWlz39wV65hIQAzO7isccXe4
	UfaagMRgXbLl7ktcnpm1AGnn/Qgj7EP9fIscMXI7aV1iRl3O6z5if/lLYWI7GkeDBMIRLqavqrj
	Ja2y5EQbS8N9oLekpH5zsZY1roVN9n9mg9A468ePO81l1ATGSvEqWPCJrOkbU+fzK3hBBEIZ4Kh
	JMG0Of4PMGay2pzxgQh1MsW+vyhuCh9W3Wf6TiN67SY27sVtwDhTTiBJ5HX1q54GIOckcPCS1L3
	CbU5c3J7L7gJWmVVf4gMhLZ2XE8U6/63m77cpwjrJ16E/JxfQbgYrjcTKWHNrVtxPvCPymCpjLH
	yk+OBN+soKF18XzVZwJPI6vRzaAc57ciYuldFZ06h9IwuAXzM7PREe1qTVLpkIC1HFMTnOQKWth
	28UKBR8l5kIAEFhBiw+cF7nhIhtYtyEBcdeziBw0WiOIKRo/P3C4SS+JTL0HIcatpNhih45+LnN
	cjSsq2vVedeyDRJ+oceq1L9I8fifA==
X-Received: by 2002:a05:620a:410b:b0:8cb:72b2:2a14 with SMTP id af79cd13be357-8cbb578dd13mr81562485a.16.1771978884583;
        Tue, 24 Feb 2026 16:21:24 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899a71b28d0sm31232676d6.49.2026.02.24.16.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:21:24 -0800 (PST)
Date: Tue, 24 Feb 2026 19:21:21 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 06/14] repack: track the ODB source via existing_packs
Message-ID: <df37959d2933d84ec61b9ba570c87f9e5213c735.1771978829.git.me@ttaylorr.com>
References: <cover.1771978829.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771978829.git.me@ttaylorr.com>
Message-ID: <20260225002121.O9j0uW5Efqnp6Y-ol0TU0RCERm45gKDREAYVZGPe6sw@z>

Store the ODB source in the `existing_packs` struct and use that in
place of the raw `repo->objects->sources` access within `cmd_repack()`.

The source used is still assigned from the first source in the list, so
there are no functional changes in this commit. The changes instead
serve two purposes (one immediate, one not):

 - The incremental MIDX-based repacking machinery will need to know what
   source is being used to read the existing MIDX/chain from that source
   (should one exist).

 - In the future, if "git repack" is taught how to operate on other
   object sources, this field will serve as the authoritative value for
   that source.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 5 ++---
 repack.c         | 2 ++
 repack.h         | 1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index f6bb04bef72..44a95b56f23 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -402,7 +402,7 @@ int cmd_repack(int argc,
 		 * midx_has_unknown_packs() will make the decision for
 		 * us.
 		 */
-		if (!get_multi_pack_index(repo->objects->sources))
+		if (!get_multi_pack_index(existing.source))
 			midx_must_contain_cruft = 1;
 	}
 
@@ -549,8 +549,7 @@ int cmd_repack(int argc,
 		unsigned flags = 0;
 		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL, 0))
 			flags |= MIDX_WRITE_INCREMENTAL;
-		write_midx_file(repo->objects->sources,
-				NULL, NULL, flags);
+		write_midx_file(existing.source, NULL, NULL, flags);
 	}
 
 cleanup:
diff --git a/repack.c b/repack.c
index 596841027af..2ee6b51420a 100644
--- a/repack.c
+++ b/repack.c
@@ -154,6 +154,8 @@ void existing_packs_collect(struct existing_packs *existing,
 			string_list_append(&existing->non_kept_packs, buf.buf);
 	}
 
+	existing->source = existing->repo->objects->sources;
+
 	string_list_sort(&existing->kept_packs);
 	string_list_sort(&existing->non_kept_packs);
 	string_list_sort(&existing->cruft_packs);
diff --git a/repack.h b/repack.h
index bc9f2e1a5de..c0e9f0ca647 100644
--- a/repack.h
+++ b/repack.h
@@ -56,6 +56,7 @@ struct packed_git;
 
 struct existing_packs {
 	struct repository *repo;
+	struct odb_source *source;
 	struct string_list kept_packs;
 	struct string_list non_kept_packs;
 	struct string_list cruft_packs;
-- 
2.53.0.185.g29bc4dff628

