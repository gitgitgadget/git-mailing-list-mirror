Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBF7158862
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732868728; cv=none; b=hCzH25vg73fR/jZ3GhEEemT9plcNawlDjeDHSLKw771AkShv71Z51Xl8THFF6oSZgButuCD1UOh9GefLHnorADuar5vm5mAWb04GOhWSfEAuadEhl3j4rD9l4aqBm2m9hYTL6871mWovfa+wUpyQ9EiSFZlXwaRiSC+3wg8LIX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732868728; c=relaxed/simple;
	bh=BP9NuuItEBhT9KVBlsQVr51bs0lMHqnGqlpJq/9mbrc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=BiO+WpldHdh570xd/LDsQz3AXhRPh38aTSgbIutrOOqIgADh+FkwjJ5wxb+PzPe4i4MbCmg2e44PpZ8StZ4CTHJrBzDPzHBK/XzQMKa8ygPXcMGvywMRb3ingA50X3EhHsGfIaWlVjfiBUXu8F1OosyR+zzWdu5XltdT2DCJJ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmwDEdXI; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmwDEdXI"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa51d32fa69so226069766b.2
        for <git@vger.kernel.org>; Fri, 29 Nov 2024 00:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732868724; x=1733473524; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fzbJZiXmQBJRQB6ASVynQWvqtnreUToaiFVimm7EjTo=;
        b=fmwDEdXIzmbhkJdITvoABWSwOMWn0JAoLa9e0tGq8jRx+yr+x93odH3G7shydAHisN
         iFsnVf5L0Yjby2iu018bZqV9LeRWcOnxqJVKAVMYELpP05txjJlCbw5BoCH64e0BR9WL
         cwOp8t5gFS32q0tj4HU7yalfeMZ5Jocjvl+FcA6yAaImA/f86YUNr8gs+rA+xGsq0Rn5
         zWumvkhNxY+D9BOlLFR/3dSjRuSrCW5Dwb7AF/vB7oD9FzxRZsCj0XaXG4gk20Ce6yFS
         YdmxG6g6SYhueQQJBdH8r6YGlBi2AOdwdzgNmqfTqZe2IDetE2jbBLu1aTfSS2JzVfBb
         9VGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732868724; x=1733473524;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzbJZiXmQBJRQB6ASVynQWvqtnreUToaiFVimm7EjTo=;
        b=DSv0IWLsKkOFE5LSneDPB+SzO4tfR8+LuHaGz7K4I8UccrO9aEBYqtpedRe/srZNC2
         hhaI6f3GUFXTHWr7pSOjtngXwTIUUX18+Le21d9cPYaLBrVy4LSKZeqk54wKQHH3i8sA
         iBRyVLMYBLULqQJLIfwA2OYXpXZ7wVrP9Y6qPxVpRYkPNeTBeIiKX5cbUvDkvVsRVkuf
         AW0cUKWD6duyuyBJinazmcbbTuQdLMClSWjJyJv01sbC1/shKPx601SgVf/2lr+HiEMe
         6195aa8k9NhQhULf4yxUeM+Q+h1f/l4Df30LP/yta6aLf3cQaVLoEUehlGJWpumfStQU
         PW7Q==
X-Gm-Message-State: AOJu0Ywu6/UZBIaeBkqDq3Abgy/1E12/gqE8j9EkOMGL7V7ow++nDBJm
	lTV01HMcq6eptlsuHjjUoBaw1h4OXyu7vAhTDyToVD7RnMHKNTXaDB2E7w==
X-Gm-Gg: ASbGncvYk6BGLRn7VcPO2eYgU5lbEZ01DPEti3zf4w95SmWLfaA2NX8FzIyhK64rL6c
	TQgMWDcLu98IYdzVE20ML04Zv+Tw5SvCRYGq3VLzis2/6gR/dGrbNP7AYwDRmq2PcfIMrJ8OlKf
	s59JeCEWEMPThZ6vF+mIIC+IoiOoSc+GBOSz/8k7sPyCIP6XS/d3p1DpAjMRio2D2D0jBZBlbDw
	qZNpbVMD5h4n+jkhgOFpUhbru7O9ZEPDxVEpZNagVqePMdT40w=
X-Google-Smtp-Source: AGHT+IE/a353v+ZZZOijpBpk9JjMqVUwAu8Rv0fUM3Y/97T/L4ujv0gZAMWtfP7F+VM4E7OVOJm0ZA==
X-Received: by 2002:a17:906:31cf:b0:aa5:1ef5:261f with SMTP id a640c23a62f3a-aa580f0de2dmr832118866b.15.1732868724236;
        Fri, 29 Nov 2024 00:25:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c141esm149483266b.32.2024.11.29.00.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 00:25:23 -0800 (PST)
Message-Id: <pull.1833.git.git.1732868723157.gitgitgadget@gmail.com>
From: "Jiaxin Zhu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Nov 2024 08:25:22 +0000
Subject: [PATCH] Makefile: add the missing period in the 'SHA-1
 implementations' comment
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Taylor Blau <me@ttaylorr.com>,
    Jiaxin Zhu <zhujiaxinabc@gmail.com>,
    jxzhu <zhujiaxinabc@gmail.com>

From: jxzhu <zhujiaxinabc@gmail.com>

Signed-off-by: Jiaxin Zhu <zhujiaxinabc@gmail.com>
---
    Makefile: add the missing period in the 'SHA-1 implementations' comment

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1833%2Fjxshin%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1833/jxshin/master-v1
Pull-Request: https://github.com/git/git/pull/1833

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d06c9a8ffa7..a1fe141f7e0 100644
--- a/Makefile
+++ b/Makefile
@@ -527,7 +527,7 @@ include shared.mak
 #
 # If don't enable any of the *_SHA1 settings in this section, Git will
 # default to its built-in sha1collisiondetection library, which is a
-# collision-detecting sha1 This is slower, but may detect attempted
+# collision-detecting sha1. This is slower, but may detect attempted
 # collision attacks.
 #
 # ==== Options for the sha1collisiondetection library ====

base-commit: 04eaff62f286226f501dd21f069e0e257aee11a6
-- 
gitgitgadget
