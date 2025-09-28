Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE6C2BE658
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097414; cv=none; b=BGrLi5eVvYCVm6swyHOFO2lmqSZbVeSd/PtzmAJ9FL+6/AydKKsIVYHJHRShVcGbsybvzzAZhjLspGZ+ZrPlJiCeGr77mSP9WMK+xE4/KwtfONUrbkH72Ry8+w1rIIjDkyH6XDqU/9ZkQxBsOjJVAO0mi9/2h9EPAc04WdzQ3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097414; c=relaxed/simple;
	bh=vEZkLqT3HStyHFRHHLiBu5Cj3ynoldGKPIEUeQXBaRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=km2UWY0rug3/d2znF63tMo8eHKpFG6vtRWHGHEShe3P4Yn8krG3zVpuESvm8qg7Fy/9MGT8no3dLj5KtURQxlEHlFrUA46aX/oevs8aK/+b9Xu2q1siEQilOQO05Amr9zsCF892Ny8PUYroSSbpoKcHocwec7ilDeEzYDWBM4KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=LW9KMq0n; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="LW9KMq0n"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d71bcab6fso41161447b3.0
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097412; x=1759702212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xbfrFvDy2BsLnzZCKrhqaU39B3D45Jz8W7AGyfiFkCk=;
        b=LW9KMq0njELY+3yNChpWEZ0o1VGwmz6eOIRFznWIRjfQkNPfvpcZq9/CXpiTpix+wu
         5ylIRqWJAPiT6b8QIXLdiU00bLXmG4ReX/97YWe7qGXHeDdI3YxVX8cmNPLxVrVmfF42
         nTl+AUana6vzoiveFiBRWXpiUkCoZPXngD0tN0lKqolu+zoxVTO9k+NR++eKC6oCv2GO
         +jlz+gfFzVIOU9jIQ+2bIW4ZY9hWfFzLQYAlUcLI35TInRXQBpUQdZgZdj430FshhOM9
         HQg+1zAq+iO3Wfa0mZNRgVZgITJONHSg37c+3olVa6a5avqtbayPmjDBHie8BUDIfOgX
         Ti7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097412; x=1759702212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbfrFvDy2BsLnzZCKrhqaU39B3D45Jz8W7AGyfiFkCk=;
        b=R5jrjsDxjQNI02RscCvAHjLW4rfUgUSXXUCt2yj46ltrtsH7KdXQrHSE+6nGfcj0+h
         cnFpTfb5nmtlMi2Pdvp/X6ZVYoqQSq2QVWqYMYOV7RRm3S2L4AD8ziTDts4/KDE3SNP5
         xF39ZiCa3KR/SpyjJ5EDPhBv8iriDPcdXpSbM1W1FdljvJg3RI43vcTgCpRXuexr6oF7
         ftaejMuzcRCazQJCBA3ykQFkBC+TD7u6GWEGUgMiFXM02sjA/W2+kT6z2YydnTTioCNg
         JpKwWhckTvT8qDlmgw+Z3/QzgvTk7HQv+IFzPSn+Ba1LxAidjmyMaLpAmNRVcKYL/V9P
         yJfg==
X-Gm-Message-State: AOJu0Yx04n6ziMb0IzTAYA+m4Fc/OxVVx++D0OQvPFFJwUdvtJU+RcvJ
	a2TAdNM4T3aC2vdkzLhhXHVMfAwIASe7R+0XX/qPei7Wdr8pby9lF3//jiQDlB6iCVBG/N7qqz+
	XOWxcSVYDXw==
X-Gm-Gg: ASbGncuOLZ9Uy3HaAp/viS3ubzP9h0TS3UcYG3MKesvfOn7yo2zPiVWgT3nOu24ZDa7
	HSiVrvQSFn82/gYrzhBCgOULXJ881g0QOl82LDsxEuese48S91qwrrBurAbAo1blBoOPP2PR1jj
	3iaqrYnCacjdyRJDLLS88b+kpaVKxPxdwzKqFJ0Qs3YUEfU6651Gg8mOlYsTW9ULcFJ0WdW/W4C
	4Lnj8Vql29UaNFPyFKLEEVcE5kxGgL98Xl4Hf1jInrhMRlf3lJ7nAeYpAirGPTFAMH41XHgrY4N
	dzh2MaZBPd42Zs+jxf8hWX6nAlM8RuYGB066Hx9aVeuAV1btcSCR+/COhwhoMMa6ZtpS2terqN7
	QS88wP3davmoO0mP3MGOjCEGEnf5Q61hHBX9W+4n67/+Q8A42xOMiAoo5vvmHp6CcNeE8v20NO6
	gdjCbLV21CyJ+V9BMsesVsxp+0sZn4wXKCyu6t
X-Google-Smtp-Source: AGHT+IH9a9Vnv4O8fOU4FqgdFywD+Qms8a8XHsetpGybn6cAq8OuSkEwcCIGmPjy4dCIwknba/r8eQ==
X-Received: by 2002:a0d:dc03:0:b0:71f:b944:ffd with SMTP id 00721157ae682-7640766c9b4mr131595847b3.48.1759097411782;
        Sun, 28 Sep 2025 15:10:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6361e77d824sm2571409d50.2.2025.09.28.15.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:10:11 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:10:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 43/49] repack: extract `write_pack_opts_is_local()`
Message-ID: <1fbe3d0d7f37840b2d9faf6f62e94abd6a664ded.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

Similar to the previous commit, the functions `write_cruft_pack()` and
`write_filtered_pack()` both compute a "local" variable via the exact
same mechanism:

    const char *scratch;
    int local = skip_prefix(opts->destination, opts->packdir, &scratch);

Not only does this cause us to repeat the same pair of lines, it also
introduces an unnecessary "scratch" variable that is common between both
functions.

Instead of repeating ourselves, let's extract that functionality into a
new function in the repack.h API called "write_pack_opts_is_local()".
That function takes a pointer to a "struct write_pack_opts" (which has
as fields both "destination" and "packdir"), and can encapsulate the
dangling "scratch" field.

Extract that function and make it visible within the repack.h API, and
use it within both `write_cruft_pack()` and `write_filtered_pack()`.

The remaining duplication (that is, that both `write_cruft_pack()` and
`write_filtered_pack()` still both call `write_pack_opts_is_local()`)
will be addressed in the following commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 6 ++----
 repack.c         | 6 ++++++
 repack.h         | 1 +
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 4d86920618..be8e6689fc 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -147,8 +147,7 @@ static int write_filtered_pack(struct write_pack_opts *opts,
 	FILE *in;
 	int ret;
 	const char *caret;
-	const char *scratch;
-	int local = skip_prefix(opts->destination, opts->packdir, &scratch);
+	int local = write_pack_opts_is_local(opts);
 	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
 
 	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
@@ -232,8 +231,7 @@ static int write_cruft_pack(struct write_pack_opts *opts,
 	struct string_list_item *item;
 	FILE *in;
 	int ret;
-	const char *scratch;
-	int local = skip_prefix(opts->destination, opts->packdir, &scratch);
+	int local = write_pack_opts_is_local(opts);
 	const char *pack_prefix = write_pack_opts_pack_prefix(opts);
 
 	prepare_pack_objects(&cmd, opts->po_args, opts->destination);
diff --git a/repack.c b/repack.c
index c4326a532d..7af297ae48 100644
--- a/repack.c
+++ b/repack.c
@@ -77,6 +77,12 @@ const char *write_pack_opts_pack_prefix(struct write_pack_opts *opts)
 	return pack_prefix;
 }
 
+int write_pack_opts_is_local(struct write_pack_opts *opts)
+{
+	const char *scratch;
+	return skip_prefix(opts->destination, opts->packdir, &scratch);
+}
+
 #define DELETE_PACK 1
 #define RETAIN_PACK 2
 
diff --git a/repack.h b/repack.h
index 46d2312fa9..16f2de2ea9 100644
--- a/repack.h
+++ b/repack.h
@@ -40,6 +40,7 @@ struct write_pack_opts {
 };
 
 const char *write_pack_opts_pack_prefix(struct write_pack_opts *opts);
+int write_pack_opts_is_local(struct write_pack_opts *opts);
 
 struct repository;
 struct packed_git;
-- 
2.51.0.243.g16eca91f2c0

