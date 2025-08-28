Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABD72E1EE7
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370296; cv=none; b=MIGiViJdmG3r6AEIECSM4zpntVFn8TyNfrF9eta6qrD8gKvSxKgFdQuKzCgi8Fc81+T4OaS+VxzOfmN5+4N7TL3Ig6Ak/EGSe0AxchI2wkj68I1z2T6fbfucwbAyM/CMClJ7JWJ9Tpt9t3UMi8yfChWyOu4uvvW/8ftZBtXHdis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370296; c=relaxed/simple;
	bh=mJkQ62QhbovXMwmqxuv8+e1yWk+/UTmPCFGiOOqxmYE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YypRO/iyIA4RT6cC/ZNm0K6BvjnDOccVfK7AV7pNM1vpJisx1k1r2jbqrFCIwRJUPZvHryHFfVsHerIsyp2tb2DlAIT+DMxv17GbDlWAQJ97cgr57NUxOmKa8UedQ70WkY4SRIrQJeld3XTaSPSFU4UfsPf5mNZaTxMTjJUD22Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hv6gXDLT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hv6gXDLT"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso5592755e9.3
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 01:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756370293; x=1756975093; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgZXpD90SGA4EsE0m/Cv75qdcPX7JwFwLEee+0PbUL4=;
        b=hv6gXDLTkwjKVHHTiWOwshJnIRlF2SgObiDTin5A4YS2WAiyiIcqDFEoGZMqGXubg+
         HFjUitSnRgbtWY1vKEzKV6ByHjaFPbvlUfvtHKx60obZMy8xbkUK0vmYWSmJYZkVSe7n
         eE9B6AsyiFKkqnUEaqXVbVCN250bV55Ewpzov2v0OrYVnuj6L112HQ6s2auAwBU4l3MB
         DEKctlxovZN1ZsL11QGcXziExQDGemEmFV8Y8fAKi6mK8G+62tuuBhxq0GKvEuI4taqb
         7NvJGXtNCcbBKN2AJf73kMxmyQTHtJ+2jJ2x8KcWKIBQSOkPjG0D9z5it+xhuX6awS/X
         stfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756370293; x=1756975093;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgZXpD90SGA4EsE0m/Cv75qdcPX7JwFwLEee+0PbUL4=;
        b=unGymr7PCnqGQ6uXmmFwzMG0VJmGcUDdyN116zU8rDcHtKqinx3ZLKmfnLMO9fWmmA
         D3IbPuWw/ItVywcX7COdhJcP94VlYwQ+6SgaaFQioFP0cNIP/t9RWTlViwjUGJLeSFED
         Md99PSpO2X3PqcWKUeU4gKYjnXxgXdDABNd1K0C5J2HAtoruttRBeDKacA+uoG2fuXxQ
         fKwdQQi/5ns6MZhYJP/0UL7js+/NKD2UCAih24f+s7RgyWC+fHVOFPJVdngtd2wDr2UB
         g1ASJGCl7i/v874LDEmfjW7ht/ztUTLz+pxV6lZM9y6fyMjot2h3Gnkc/DRG2bKzVLOr
         WjNQ==
X-Gm-Message-State: AOJu0YxeERYrX2QhPBcqb2C8AMWxdXYohaYI0EndztqayQ93eTWvI+QO
	yt76GXe+aTKg9XWrzxxGSZQgqjhGQ4JbOeiDnEmHv+/UIjU9z3g9fpxkVicHoQ==
X-Gm-Gg: ASbGncus4VW8JqFowjwCqb4YAUshnI3LRoWxMSG/1BJFd+5dwXhIYvBrbjFc2TUxicn
	wfooRXOKFI22o385SFzZdaRx88hL2gmG5aYCHlUpaR3HUr2LX4PA8ucZoTX9UUha6AHDWg/M2c3
	tYZMEXg/fOO5hAXKBWl1QIU9znkRKXrRyYQtDtWSRqLHRQHrqluASIrikrF417wpyeLktnHnwJT
	dLtdYnJxN8JUJQwwBSdgPNXOHmDVlUykw7K/Ve94Goc75BriPI2RUNBslQHePEKoeImK7GnSGeW
	kvAoGTo+EgewJB9lbJDe3b1yia98faGFmBycLk1I9E8RFEA2wbErWizi5Tqe8XB21w2lcxdklKH
	LPMMqAVMNoTiB71gulJ9voRiczSI=
X-Google-Smtp-Source: AGHT+IE1BrGod9WermJ7H83+a5IQzL4hwwMzjDW2HZ32gB4PordelFh+/4F4fcbkp9G2pKQYGMpRmg==
X-Received: by 2002:a05:600c:1d07:b0:459:d9a2:e952 with SMTP id 5b1f17b1804b1-45b5179f2f9mr153146435e9.1.1756370292633;
        Thu, 28 Aug 2025 01:38:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b797dd66dsm21927965e9.20.2025.08.28.01.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:38:11 -0700 (PDT)
Message-Id: <ec5dcdf9d00473417b1f0b676a485f01076ce075.1756370289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1958.v2.git.1756370289.gitgitgadget@gmail.com>
References: <pull.1958.git.1756228693233.gitgitgadget@gmail.com>
	<pull.1958.v2.git.1756370289.gitgitgadget@gmail.com>
From: "pcasaretto via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 08:38:07 +0000
Subject: [PATCH v2 1/2] range-diff: reorder options lexicographically
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
Cc: Paulo Casaretto <pcasaretto@gmail.com>,
    pcasaretto <paulo.casaretto@shopify.com>

From: pcasaretto <paulo.casaretto@shopify.com>

Reorder the command-line options in builtin/range-diff.c to be in
lexicographic order for better organization and readability. This is
a preparatory cleanup with no functional changes.

Signed-off-by: Paulo Casaretto <paulo.casaretto@shopify.com>
---
 builtin/range-diff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index a563abff5fee..283583a80d0b 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -33,17 +33,17 @@ int cmd_range_diff(int argc,
 		OPT_INTEGER(0, "creation-factor",
 			    &range_diff_opts.creation_factor,
 			    N_("percentage by which creation is weighted")),
+		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
+				  N_("style"), N_("passed to 'git log'"), 0),
+		OPT_BOOL(0, "left-only", &left_only,
+			 N_("only emit output related to the first range")),
 		OPT_BOOL(0, "no-dual-color", &simple_color,
 			    N_("use simple diff colors")),
 		OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
 				  N_("notes"), N_("passed to 'git log'"),
 				  PARSE_OPT_OPTARG),
-		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
-				  N_("style"), N_("passed to 'git log'"), 0),
 		OPT_PASSTHRU_ARGV(0, "remerge-diff", &diff_merges_arg, NULL,
 				  N_("passed to 'git log'"), PARSE_OPT_NOARG),
-		OPT_BOOL(0, "left-only", &left_only,
-			 N_("only emit output related to the first range")),
 		OPT_BOOL(0, "right-only", &right_only,
 			 N_("only emit output related to the second range")),
 		OPT_END()
-- 
gitgitgadget

