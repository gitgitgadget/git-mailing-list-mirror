Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020E355C29
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 03:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766031; cv=none; b=S7gH7QMLlGgRUmnVaYuOtBxFJisrN3q/perr9dISwK1MIPU5r8TZ0lVD267A78+IYyFuUaSQbRQS+aYkKoBnon1hXEMlfDzTzPjBut8/1ylVQhXhwoAf/p1xoD3fpkYJOVK2/81QDJqS5OGjRkxkpGX9/nJxkkJ2V52v1RvoyQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766031; c=relaxed/simple;
	bh=UAgyhOQGzBJ/PFokPNFjE6wxsZOfJ8xCvbo17oZqzQI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DVIlgHAq4G+Gg+Zx+g1kZiP8dpaooJa4c1AxacpMVPeJFv/vNQZWNZufjX6SVBBDxmnFhlhgfz2LM2cWrboBPl/42p0kkM0kFmJqI8jo7UiZ7+77mQiBknJYl6RpinOJgctRzwhmil5rcuUAccauHc5udwdUrqxJ/AiaKtfp1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZjxsKZM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZjxsKZM"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-354b722fe81so5415643f8f.3
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 20:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718766028; x=1719370828; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMgAN7pVzhAnDGXhIE3pMLyn76ebCvOVzTT6wi/4ab4=;
        b=QZjxsKZMBDwWxb2D+rRUzif3VdOxEK8EWCgv+FD+ZdlKY/TUlXLUD9Y+2gi1RZSGf1
         CZQx6wo61WeoYHZuzIJveunN+O22jHUG11FStaZ68biuGQ+49wCzHUwdTeR+N5Kle9+Q
         hKYrRbHZjEiX+McNArabzGBq5QK/UBAhhTLBtZ6/8vvltrxQzOOC80kQJkXGBthfGDma
         h3f4qk4zKbKy8mq8XcG+P6rh+vMEVDNQ5SUGPtMsx227P5p6K3xqYO20PFb5FketK6QS
         YH2eka4eZ/TIAVSPy0lDDEwSXyy6m6izA7ag3C7xy5YB7XzKIhfBHJdRcS4w74620W+z
         gJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718766028; x=1719370828;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMgAN7pVzhAnDGXhIE3pMLyn76ebCvOVzTT6wi/4ab4=;
        b=tZNZxwPNaDgSPc3WZVoA9L1o00gl/fC51FVsD9UhgqePMz2sW1BTfMIpCePtaJdv2u
         dnLBrKPtjd4GCGZpb/6pAC95NfL7wZdDCbzHg4BkJtrH70F8yNGkQs08q3BrUiY7Q7jy
         84WNikonNWaqDShvLcVv6Eet2FwzV9AJTdZG9XtFET147dZ2PMKhaAWkjFh6ZC+LzBpM
         coRHZlOPzVh6lkZtZnIrQQlHqyZI2nqvlXHdZRGFczDbvNA36M/va0HttDASmWT7/MXL
         1na4MwvECnerGsOahQpDOs9YtaTrV9LNz3kDVaK+sm4vxgj06726637GGJeAo0z0w6AD
         klog==
X-Gm-Message-State: AOJu0YzfLjJHRsRqDhxmb3rvL4c4I4zkZEymT85FDeSJOBaM2E+DENXX
	v1dW1ZqcFnnGtg+DhHJDNFeyCoBIqfDo1fgPhgmDGA2J0JpjPXskQ4pJjg==
X-Google-Smtp-Source: AGHT+IGuyKZtUnSbngiWFiobxqORtO/oussdwQopPtifBM9M9HZF7bHS8Pl6AirWjcKTnn9hVrXfkg==
X-Received: by 2002:a05:6000:b44:b0:35f:1e30:f69a with SMTP id ffacd0b85a97d-36317d758e1mr982312f8f.42.1718766027799;
        Tue, 18 Jun 2024 20:00:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-362c7c2dffdsm1948917f8f.35.2024.06.18.20.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 20:00:27 -0700 (PDT)
Message-Id: <750acae4dba009d7a2f2e10b3767fcecf3a4748c.1718766019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
	<pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 03:00:17 +0000
Subject: [PATCH v2 5/7] merge-ort: loosen commented requirements
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The comment above type_short_descriptions claimed that the order had to
match what was found in the conflict_info_and_types enum.  Since
type_short_descriptions uses designated initializers, the order should
not actually matter; I am guessing that positional initializers may have
been under consideration when that comment was added, but the comment
was not updated when designated initializers were chosen.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index d187c966c6a..d0b13463283 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -553,7 +553,7 @@ enum conflict_and_info_types {
  * Short description of conflict type, relied upon by external tools.
  *
  * We can add more entries, but DO NOT change any of these strings.  Also,
- * Order MUST match conflict_info_and_types.
+ * please ensure the order matches what is used in conflict_info_and_types.
  */
 static const char *type_short_descriptions[] = {
 	/*** "Simple" conflicts and informational messages ***/
-- 
gitgitgadget

