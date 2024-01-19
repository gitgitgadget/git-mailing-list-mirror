Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679CE53815
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705674432; cv=none; b=PmqIIx3QDW3wCbvTOqfLc5ojcYA1IJ/7nX615e7ooafc0o5bDCHNmJD2ICTteMncGBsqukK+WaOz3IZvYUMvuAuuiC2q+ORDf7wyRCZxCKeY6Hvj4Rqvw+4/1dT+ghgZ8dCsGGX5ki9Aabb5gzW7yo9C1zVGqheaQ+TeimmNaPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705674432; c=relaxed/simple;
	bh=kwm9DntFPe2kKovbX5xVcI6VHG+8Ik8SXNrOP5M7iF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j185g4QnEQDEee9Boi0jTzbVFk9IqLawRV9RTKBUiSbBmmV2PZj/s8FeDBBGXP7GRFXpdPuPNCHfP9c2nl9iuuoCuWdzyItsgJMhqi6IX4XQ/5J3aYGlsjvIwKCtEH6EoGIHD33Y6CG8tnDQYON5pycj1fKOKlOaDYmV0xRtEGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqAYofHs; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqAYofHs"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a070af87eso779693a12.3
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 06:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705674429; x=1706279229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Jun3QQa1XYGBUywPprR1ps1htbnuwuq0MStTK4Rkbg=;
        b=NqAYofHs6CGV/ZZyv4vU2viyXIlgRYYE9LcFWGcWh3bCRo4t6li5/oRemVl3TaCV+K
         b17NpkeIIG60ikFTN9ytKevSRA01QJX74+6jCY1ahQn6JL9BOsL7vr6QpuU+DYI1dqz+
         iG8I4PERgW8avKSLd4rPMJGYZ4QG9Z+BYOvPVVdb8kOnX8/h3plL7tatO2S7zOFWzEd6
         NM8MuldDVIHWlJEfpmPOK0FUScMI8/MFPSgnlUlhfilYJ1SYCi48wPfZxOotgvDILPfw
         RKKuMP5TmjrO7i0o1VpDXJVcx9EUHy6OhF7zfzQw1WGLWz1S2VgodZuoxIDMJRVNzzNQ
         6Bdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705674429; x=1706279229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Jun3QQa1XYGBUywPprR1ps1htbnuwuq0MStTK4Rkbg=;
        b=BMZ+EuYv/A3oqYJc8crzEJJg8j8S5eMnnsCoh+naq3tNMu2kM+gUTJQIodufSTqEPT
         Ri7t11iu5FuaNcw6uTSDnIU+xuvNLrEl59QRkctZ1hMlgIkr5T+Qeh0TD+ajcJgG4XoW
         8arBTFcc9AI47qOryH1XuaBkvfPPw+PGWNq7Ov82ZA+vQW/JkfI6pzBQ5dKlAU/WVt9+
         3CQvo0Rpcv0Jb+uRhBCV6Mfc2SSYGwp7mIJwDz3vUwp92kopQswqd7DK7TQyGa16jrii
         zJ3E0rB6nANHHBfISZJbtm7fvJjXPWAAA1xrgGJLWpsPBX9s6frrO4Wrac8EurzYzQy/
         XELA==
X-Gm-Message-State: AOJu0YzgdzugA5hKhucP+fGWWCVH4El0WpnUcpI/3BhuwzeHbT10MEuX
	/7rJYIWo6N+ghOFBSwAcTjexYn1s5ETH1iGh18XtRPbejWKNsbiGsbHv87WN
X-Google-Smtp-Source: AGHT+IHaUc1y5FW5H1G59eZBwx0FUft7AlGCOyInWSnChgKdObGgcTek1qyEyvkANfKujEuxuzI8KQ==
X-Received: by 2002:a17:906:3614:b0:a2a:2498:93c5 with SMTP id q20-20020a170906361400b00a2a249893c5mr1442291ejb.73.1705674428917;
        Fri, 19 Jan 2024 06:27:08 -0800 (PST)
Received: from localhost.localdomain (h-213.61.124.196.host.de.colt.net. [213.61.124.196])
        by smtp.gmail.com with ESMTPSA id t13-20020a17090616cd00b00a2ea45637desm3843494ejd.112.2024.01.19.06.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 06:27:08 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 1/5] refs: expose `is_pseudoref_syntax()`
Date: Fri, 19 Jan 2024 15:27:01 +0100
Message-ID: <20240119142705.139374-2-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119142705.139374-1-karthik.188@gmail.com>
References: <20240119142705.139374-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `is_pseudoref_syntax()` function is static, since it is only used
within `refs.c`. In the following commit, we will use this function to
provide an utility to add pseudorefs to the loose refs cache. So let's
expose this function via `refs.h`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c | 2 +-
 refs.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 2f58a3460a..5999605230 100644
--- a/refs.c
+++ b/refs.c
@@ -827,7 +827,7 @@ int is_per_worktree_ref(const char *refname)
 	       starts_with(refname, "refs/rewritten/");
 }
 
-static int is_pseudoref_syntax(const char *refname)
+int is_pseudoref_syntax(const char *refname)
 {
 	const char *c;
 
diff --git a/refs.h b/refs.h
index ff113bb12a..f1bbad83fb 100644
--- a/refs.h
+++ b/refs.h
@@ -846,6 +846,12 @@ const char **hidden_refs_to_excludes(const struct strvec *hide_refs);
 /* Is this a per-worktree ref living in the refs/ namespace? */
 int is_per_worktree_ref(const char *refname);
 
+/*
+ * Check whether a refname matches the pseudoref syntax. This is a surface
+ * level check and can present false positives.
+ */
+int is_pseudoref_syntax(const char *refname);
+
 /* Describes how a refname relates to worktrees */
 enum ref_worktree_type {
 	REF_WORKTREE_CURRENT, /* implicitly per worktree, eg. HEAD or
-- 
2.43.GIT

