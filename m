Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D87194A6C
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421733; cv=none; b=q+vWJ+1lC35/s47oKzQn9v8c+gK1RFrF9hawIncKzftQYCAYbWRH99Zfo41BVtBvzXbdPGiDJ7NSmyVxt/DQTL+O1Ds08WKfLtxpad7gw+n8QUZdU8PVwf4rNfLdXGM65vUBkDTb2OXtmMMCxLww6+t2KrfsZX2YWP+gWYQ2CpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421733; c=relaxed/simple;
	bh=hMi2le6mMS89OjFgWbRcSCzYIcZu+YUMPShs0fmyg2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGQ3TPGL8zNoH+kUNu/9PhvkgVkbm5mYmTIRB4+cebfTiSFo3jjFMHso8L6SonJMEMM9FG29tarbRY3zh4aPUDI//qn8IEQD0AAq7JcDp8EVgQkCXM96K+fDF4oTN33bCf9fAapIXlCZwdNFRlHWc3Yjuptz/j7ClBDRwhaCIAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LASJBm0q; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LASJBm0q"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-306bf444ba2so2418950a91.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747421731; x=1748026531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOhp9PxnWodf9VjvfeLAyvb8F5mdVEsh2EXAixIoipU=;
        b=LASJBm0q6Yhm1Z/HIW3E6vbUUotZztjxHKbKj/7r/ZiAuRds+3u0LSqMETb8vAgrvQ
         Jo0kKUQRMTUivKhoZybayW2wUAzMAdyua4xiY+cGAXZWxiOYc+80CUFffGlNVd+N0C9P
         GBYitGb5YEQS9lyX14s4MiRLC+hCSXfIxW+OId2yZhXdgm9jKZMkVQCMOR/GCMUYFEn9
         gi4jGWAUNZKB9fJGT89TgGq8abD3z5OkChCtI6vD589DjipEbd5pOV2kJRKHTAyP8qxi
         mmqDR5Vr7VVLXhOXy0+9dGzHZnGKPjxCdcI36pSYvsc91ljZCDNbU5tjp3/LF+5eEoPd
         +GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747421731; x=1748026531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOhp9PxnWodf9VjvfeLAyvb8F5mdVEsh2EXAixIoipU=;
        b=tbTzFJbacVgpUFXne4yDNgSROk1uE/ROM6np5XwxuSUmK+eLoq61BZvDCpO9JjcFxm
         j8GqsaUA9Xns9AJiAOYlKhb9JXZ6G9pQ05uSbif7qrN2vudx+5bSIYa4IwyPMYaY1AML
         6iVrkW2wxw0Xi5+sTl0dWPWdCbzzkIj0alzYvcPR5DloTzpQNL1mS9QsoDajpXqgdBs0
         PxPE+4km9A4eCQrHzyIsoToTcjr1968FMIQHd12pfTKGX9Nno/aRGUlXed5XBTu+hqzY
         /JJIoOM4nQqrZCyDMTslu1uRqV3klKzIlTXk2dij+/tHJHX69LHe1eMM9yij3dpqqSPP
         ZTJA==
X-Gm-Message-State: AOJu0YwPjhsq6MMCr8mHbUZUM7DEk0zv0HZCqVGcOcVSPvUlYlZhlqLR
	t/RHC/u9jlrbKdRrH6Gno+fYo7cHDr9LVTMHjNii6bdz38I21vVbCd/r
X-Gm-Gg: ASbGnctpfnjN/IKKXufucLdmDQfchfWI1wvs5Q8edosO0pNnEjyU/PzK1sTqJucGe9j
	6iqzP6lARpBckeARlmGIYLmSFD2GD6A/7pDXgkoadeDpg9DeodOL/vBIBfTFBfuuc1Rr+EVkhGl
	u93ohrYPJu7xQOW4nqS30euq9oSCeT6tx2RrjvFEvnpOZcf8v0XSdasfVyUSV5QkyfHINpXYoBd
	44pn/i2m1guOr7mtLMRzhhXyGvPU1zsOgD+1qRCTdZjDlTpIPawQor4Kq4AhWHhm+4JaHTPrZy3
	S09wvnhECI6daN+I9VRKmgaACbYBfYD9ngxKijsWPb1sk1FiImJ3SdSrrF6pkTiS/js=
X-Google-Smtp-Source: AGHT+IH2DDJ1N3AETQftPoVyyynUSjGTl0U2voaqwYffxlykIMoNv5Ql9Ppol4Eay5vRFcZtj0sz0A==
X-Received: by 2002:a17:90b:184d:b0:2ee:e317:69ab with SMTP id 98e67ed59e1d1-30e7d2fda18mr8511990a91.0.1747421731388;
        Fri, 16 May 2025 11:55:31 -0700 (PDT)
Received: from fedora.. ([2409:40f0:41:81bb:63e2:a167:6132:4460])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e3343a11csm5591224a91.20.2025.05.16.11.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:55:31 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: nasamuffin@google.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jayatheerthkulkarni2005@gmail.com
Subject: [PATCH v2 1/3] docs: remove unused mentoring mailing list reference
Date: Sat, 17 May 2025 00:25:14 +0530
Message-ID: <20250516185516.52311-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <aCeAIqwvEVOdrsMg@google.com>
References: <aCeAIqwvEVOdrsMg@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git-mentoring group is being removed because new contributors
now approach the main mailing list directly and
almost always receive responses.
To reflect current practices and avoid confusion,
references to the unused mentoring list have been removed.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index ca1d688c9b..ef190d8748 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -40,14 +40,6 @@ the list by sending an email to <git+subscribe@vger.kernel.org>
 The https://lore.kernel.org/git[archive] of this mailing list is
 available to view in a browser.
 
-==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
-
-This mailing list is targeted to new contributors and was created as a place to
-post questions and receive answers outside of the public eye of the main list.
-Veteran contributors who are especially interested in helping mentor newcomers
-are present on the list. In order to avoid search indexers, group membership is
-required to view messages; anyone can join and no approval is required.
-
 ==== https://web.libera.chat/#git-devel[#git-devel] on Libera Chat
 
 This IRC channel is for conversations between Git contributors. If someone is
-- 
2.49.GIT

