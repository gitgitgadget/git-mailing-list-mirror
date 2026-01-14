Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275033B962
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420480; cv=none; b=AnRGBu9+VAoNTIKNMCPgwdic7Ta666/7MWuMqChtauT3ejzw4Kfv8suBdrJEyAkT0RnR1dGf5t9NpgnuKh6a55DOYjgZ9eF4b28XTXfNvP/TZGAlVbIXAfQ2Yggoigphw1fz9Afla7AC0m15x6xwvIDwf1MAnOMwAqD7tfzWmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420480; c=relaxed/simple;
	bh=RdC8JC1wI87M0IAHMVaO1Vgmy66pNYWoIh9pYYPYLnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQAoO9O6d34B7EVS1F8wuXFwzH+YlSMcaFBXf+8/4kSaUEzYQkMKPzx+bxjo6tErRQZf72TqGAfPSMkCrxJtMeHLxFxD1qOEeb1A8Sw/OEQHSTem4YukJWQxTKGSnpO67Zs95qVIjbeX5TUk+x2LboXLNHhmy99Z3K6uZrSMUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=GtZ5ZuDr; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="GtZ5ZuDr"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7926b269f03so1164217b3.2
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420475; x=1769025275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8temWtRpYY7dGpYl90GV9HmxJuaHTwppg17vuNOV1i8=;
        b=GtZ5ZuDrwqFkgHnhoQIkZxSz3ZGvtndfBhjjpUXVzrH+Z8bUJKvWiyZMmBvnCd0moQ
         qW2b2FKVBOHequFgPEL78648fPToWbYAVoUpNBPCQiyZhag0bY1p+/TaZI9qJT/AigRz
         sodsGoSb/W74ZZhux85WbpXvu/Wk8ga4tXdIYGmAaMaGzGLfpNcxicBuYyiH0p7JFkqX
         mYOf1Zwrb5CWY5Hv0V8EZ+Vz+qm6tjJIe1VdgoW3XEfJnDhZ/XMNguof4SzSO4mUO2Xl
         rpDoGLW25KPYW7V4EJxWjaiHtzEwx7Jhc2C1I5DICvhA9SLGzaIsxDh8a9SpUot68EoJ
         CXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420475; x=1769025275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8temWtRpYY7dGpYl90GV9HmxJuaHTwppg17vuNOV1i8=;
        b=gKiEYrefHloxqVgn06Tfw8EdYtPepq2uTe2kBMVxt0BuvyOxrIzV9/t8iWUrC+vpb4
         Y7KOlb3no3K7u8UccHLrzJcW5WHbQXzyD+7Feiop2EGPXOSNZQ5t2ffg+c2X5ev8DT0R
         ve4kOqU72sviPAjjmMGQMOaTo3xsGisctRidbG87S2MAAvIjlfRYWSJESe7ZX26m+dpw
         DY/JqEO8M9+XiAT0B4wmAFIUzYkYIyaF3sBapXlXjkE9r3BJVst/ExchqhfIlNUJDP5R
         AMTyjlZ1lyxYb7WZDffriyH4NX34NL9GFpzVjYCUUmC1gs8NKxr2ZvM+jLfIOqsebP8R
         tycw==
X-Gm-Message-State: AOJu0Yw0hqhYtdQMe+8nbhtnIqeNLVWSqlseE2ewiyq9RJScd2kl3gmZ
	dQZti/SEVSLRWAab6HFQGXhk3fjY5jyZGozn0cyYvvRk6ih3HV31ekrKje4wHBzSSg/DpPya6dH
	T7Lzf9ZD0kA==
X-Gm-Gg: AY/fxX7NzTITJab9hJIEIXk+naUBn4NRXq3+plPZvsqOIB7+l/wF9ah4o47Bt+vNbnS
	XwMc/lmM0iRnM8CO+zQ3kFFo9AjJEWPlxywKj37H0XI1wYkBC/I3AdLMjSv58beXGwWcVDBGDYw
	mO/ko6kh4hlIoP0K5Un9QGJkknUxEXn+NNvhbWtGA/zN6ktIRxC8ReCfEzynPl9xDe7GPfFbHcC
	1P1QlMsewFsh46TLCx0m8TmY9DNrysU/EPoV1Hgjd3UcuCzwU0JU87FcQguUFIg91jsYGzWGQl1
	pYxrFDPRl+W7UFdnDR+uoclsHKFHgZ+JUQqaNIyEUgIe+94CTQQT0I4n2Uj5pZv8QQNmSTp+7wx
	3RyHos1azWbzNymkqJVPWRe1O8O6sFuWo3EiyYnv+iGDSJh8s1ikaIinW84ZUkuv7whaSWDvj/J
	9nwqZ7YbkfmmmuFMs5wurBM2SuJHZycVXbsrulwBy9Vkb3F+VsMn9sEBTEcwX12sPNtjA2/s+8N
	0Un1+97k+rVFmqhucn/fnGH4mZs
X-Received: by 2002:a05:690c:f8d:b0:78f:a5c4:7914 with SMTP id 00721157ae682-793a19b7a04mr68227447b3.26.1768420474986;
        Wed, 14 Jan 2026 11:54:34 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa55881csm95167947b3.1.2026.01.14.11.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:54:34 -0800 (PST)
Date: Wed, 14 Jan 2026 14:54:33 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/18] git-multi-pack-index(1): align SYNOPSIS with 'git
 multi-pack-index -h'
Message-ID: <92e6d868a45444eda33a9ea3deedfab088bbc62e.1768420450.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1768420450.git.me@ttaylorr.com>

Since c39fffc1c90 (tests: start asserting that *.txt SYNOPSIS matches -h
output, 2022-10-13), the manual page for 'git multi-pack-index' has a
SYNOPSIS section which differs from 'git multi-pack-index -h'.

Correct this while also documenting additional options accepted by the
'write' sub-command.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc | 7 ++++++-
 builtin/multi-pack-index.c              | 5 +++--
 t/t0450/adoc-help-mismatches            | 1 -
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index a502819fc38..164cf1f2291 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -9,7 +9,12 @@ git-multi-pack-index - Write and verify multi-pack-indexes
 SYNOPSIS
 --------
 [verse]
-'git multi-pack-index' [--object-dir=<dir>] [--[no-]bitmap] <sub-command>
+'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
+		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
+		         [--refs-snapshot=<path>]
+'git multi-pack-index' [<options>] verify
+'git multi-pack-index' [<options>] expire
+'git multi-pack-index' [<options>] repack [--batch-size=<size>]
 
 DESCRIPTION
 -----------
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index ca98d4c3ba3..c0c6c1760c0 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -13,8 +13,9 @@
 #include "repository.h"
 
 #define BUILTIN_MIDX_WRITE_USAGE \
-	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]" \
-	   "[--refs-snapshot=<path>]")
+	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]\n" \
+	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
+	   "  [--refs-snapshot=<path>]")
 
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
index 8ee2d3f7c81..e8d6c13ccd0 100644
--- a/t/t0450/adoc-help-mismatches
+++ b/t/t0450/adoc-help-mismatches
@@ -33,7 +33,6 @@ merge
 merge-file
 merge-index
 merge-one-file
-multi-pack-index
 name-rev
 notes
 push
-- 
2.52.0.457.gb599f1ad4b0

