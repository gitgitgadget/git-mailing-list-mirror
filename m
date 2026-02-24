Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF0C2DEA68
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959593; cv=none; b=CsKsAi9wUmbAmTpu4lSMlNy2ttZl/FhvUTW4haMRsjNDPRQ7cHI+wo9+AXXKzrZDhXdxBnHZOWAhlujSmEF91sBVEUUjo3Qas22C0jz5bSyB2uXNxo79wo89NZCzC6nqKGdVYeRL9RK+nYhzsNdPrjRUUjt8Fl5iC4kjU2U9hRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959593; c=relaxed/simple;
	bh=ofolXJMCwU5eeBlqixPB/jBvL8rBHQQtNBnPP+mwAy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsKaevvkXVf19AKK9+sl4yA/ueiPS0oLZ3GT6nb0nMk4F+rtwpwDk4AR/3dABoZMB58o9wUgF2GfW14ndYY9w9GBn7vy3OPUnaifUteZ5GzI8p609W3s+TAS+Ba3O7ja1eZ2rNobp0qNVCqhkFSnYqgD0SdZB00sF3UKhOukdZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=pxnBE/Jv; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="pxnBE/Jv"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c6f21c2d81so575507785a.2
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 10:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771959591; x=1772564391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zaUkI90H8AwQYhlNwZLpJ6URtKrxpfWmPFmi0UjlHhc=;
        b=pxnBE/Jvsz/gJbftcPxlr+wfNkGRcFynyFwqfn4DkgnUv6nM3/Epw0JPwjlkmSvjma
         8IwTVyLQDvHFxm9QSbtp/3b2h6OdAdPUS6UgbIGMZWBvioATwD2zfYGsnvZpatnTmrPi
         cZ/HuGM8RhgOyZq+zUtVwzRVlJmtuS9jLHU/udU4+rhbjU9cWHmP2dCgw9Utcy+S9uRf
         Ogcie3ELc4HYqmQg2E0uh1moOt9JS5EtJFZUEHclcCNSaQCztwgKRFmlKNBTJ95IJeb8
         Vy0a6QFrP3vsr3q1p6bCoH5wTry42IQcsguDvBmkHSt4P2ZIv7/noMPrzO/cQuTmazQh
         o9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959591; x=1772564391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaUkI90H8AwQYhlNwZLpJ6URtKrxpfWmPFmi0UjlHhc=;
        b=kP0IHQY6xiolzKKrgKG0vLEgXzQ/uLuPFQzpmUwAzV1/MtpjZNRQdb75wFWtFewvt4
         FhCJrIjKASKGcJQ51AiQs+LSbcq+Zqzg1sAQUDHuCVsI5JmOnjCrf0DmVeyLwX35FndQ
         rhn/uUef1d/yi2yc85LnW7BMRy+FW8VDHYi0tk+RB9pf09uKMjgdaxFPuJoMn5VQGE5M
         t3kLnJjorJ+Rgt02JfbEkFBIfDWTzTXLP3wCxYzJFmZ84gQvn/NYzOsI30+egPV2NSoG
         QDo0JJzBY2/fA5uixhWqQ7y5pydm6gg/NYmGhhxZajvt04Hc4bCN1Bmhu5zgUoU+RUKL
         dXmQ==
X-Gm-Message-State: AOJu0YyF2uAo9NWt+fBIKzy4Xt6sBysj5wMir4HTk4P0cFxeCe64SMBN
	mpkQyDOBn30ZV96q7TB0YwzhQn+InIDuXfcO0s5HdJ0S/lAcUnf5D39fDghw/8wJL/GwATx1AWv
	Ks5Wsu9+u1g==
X-Gm-Gg: AZuq6aJgWp4UUcVjhxk3xqlMZN1nbhQgw5kwMrXjb4sO+w27a2XcccVW4xiNiuZq4L9
	abMmZRhyrVo+SZTN9KGVFU5t2cWQ/JfXXCSQvMecyLueCigU07IE7YurNWLYKOLG4epgcmMaCEe
	wkL62cxDHSEn7EkRvS9u4pTIH9SpCgd5vu8X8ceRLeIJ1H2/d7XEUVKObJGbiyIfxNLxcLKsuqN
	9bQWVh4blBnvqALOh8xuYbma/Rt+5Phrz9cuyI40cCALe5ggMsZrdbRvXxdANwqH607b1RnkgPj
	yrGjLWeTqUjNf85iJLGRHKDlXXljMF4T2ynSVcWISx/4QQAnmZh9rvzSLqrKNGNGrvHuGPjpzW8
	P3KFbP1m8hUSykmE/YixS793uS2grBqZ29/849aRn+9qRh8onaA8tb4OjZIirF26aiqPfsEv+E2
	EzJbfbXVtIzsl4ebkCcNK1DAH2uevG2be34GxwIxNkSE3NF6AVumMgsVY0aHFi/emo/Y2NovTAB
	0Ajx6oj13eT6yTCSAlZOze484BNFw==
X-Received: by 2002:a05:620a:258f:b0:8c7:1119:2994 with SMTP id af79cd13be357-8cb8ca81ff3mr1565911085a.64.1771959590691;
        Tue, 24 Feb 2026 10:59:50 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d120020sm1043361385a.45.2026.02.24.10.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:59:50 -0800 (PST)
Date: Tue, 24 Feb 2026 13:59:48 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/17] builtin/multi-pack-index.c: make '--progress' a
 common option
Message-ID: <016420264d2490d9fc5c6147ba889cdf60fd0395.1771959555.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1771959555.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771959555.git.me@ttaylorr.com>

All multi-pack-index sub-commands (write, verify, repack, and expire)
support a '--progress' command-line option, despite not listing it as
one of the common options in `common_opts`.

As a result each sub-command declares its own `OPT_BIT()` for a
"--progress" command-line option. Centralize this within the
`common_opts` to avoid re-declaring it in each sub-command.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc |  2 ++
 builtin/multi-pack-index.c              | 10 ++--------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index 2f642697e9e..a4550e28bed 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -18,6 +18,8 @@ Write or verify a multi-pack-index (MIDX) file.
 OPTIONS
 -------
 
+The following command-line options are applicable to all sub-commands:
+
 --object-dir=<dir>::
 	Use given directory for the location of Git objects. We check
 	`<dir>/packs/multi-pack-index` for the current MIDX file, and
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 5f364aa816b..ca98d4c3ba3 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -84,6 +84,8 @@ static struct option common_opts[] = {
 	  N_("directory"),
 	  N_("object directory containing set of packfile and pack-index pairs"),
 	  parse_object_dir),
+	OPT_BIT(0, "progress", &opts.flags, N_("force progress reporting"),
+		MIDX_PROGRESS),
 	OPT_END(),
 };
 
@@ -138,8 +140,6 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 			   N_("pack for reuse when computing a multi-pack bitmap")),
 		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
-		OPT_BIT(0, "progress", &opts.flags,
-			N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_BIT(0, "incremental", &opts.flags,
 			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
@@ -200,8 +200,6 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv,
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_verify_options[] = {
-		OPT_BIT(0, "progress", &opts.flags,
-			N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_END(),
 	};
 	struct odb_source *source;
@@ -231,8 +229,6 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv,
 {
 	struct option *options;
 	static struct option builtin_multi_pack_index_expire_options[] = {
-		OPT_BIT(0, "progress", &opts.flags,
-			N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_END(),
 	};
 	struct odb_source *source;
@@ -264,8 +260,6 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv,
 	static struct option builtin_multi_pack_index_repack_options[] = {
 		OPT_UNSIGNED(0, "batch-size", &opts.batch_size,
 		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
-		OPT_BIT(0, "progress", &opts.flags,
-		  N_("force progress reporting"), MIDX_PROGRESS),
 		OPT_END(),
 	};
 	struct odb_source *source;
-- 
2.53.0.171.gde83996e422

