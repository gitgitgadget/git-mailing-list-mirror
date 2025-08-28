Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4A72C11E4
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756397543; cv=none; b=WX5jpIwyvJmGCvh8MyjvN0qoTdYpYZ15dLy7LJJn19JuT1ZeM64XEMOP65lbisIc1zsdU9E7+uoO+VSvQ1/3cRLQtFQa2qJvpx+C60RjcUetp9CAuBkZfLV+jw21qvhD8ApV0orYikpXu0NQn83rGqyFKD09Zqv939U3qJJsRZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756397543; c=relaxed/simple;
	bh=5+XLBH+/Szxw3QYD/SegV6jzoqzp1JALFaHheisjoM0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=kjsy9H8mQiL3DC3DEI3+ztYFfzQ++92u/BQ58fbKbnwRrkKHx8iVyzl889RnjOE8ox64pO8eXU7hQjiPjVUo8n0cwp9IPsy19qiVTdPT1mXEC/6tqiPedr2LtlSA169ENkR4Op1NIg4R6W4DKN3iAgTwMiMri3XsNIwe1G0Cb5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IllPINPF; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IllPINPF"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70df1b769e4so5195846d6.2
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 09:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756397541; x=1757002341; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bp4ElGK6RP77Uen8rMm55HR028QrXYt0ST2h0Q/cZjY=;
        b=IllPINPFZKtBvgQ6JZtqs5cHmLTEjmB0aeEjQecjx2Q3sZ/m2Mc38KfNixFT+SGQQG
         LWS9xWer1CNU1+31rni4N51Xcd8aU0ap4l5bcCgv1ziWwnNIRqLmz4BiX0lUYoga55BT
         NaBaR7XjuVx3w6Vg1TqIBGLcJyezxqM00qfrvjN8Gps2QGiOF7PVHaV63j2/kwJe6UPE
         HNuNxOhWrpmp83sQ5BMVKeMKluWjjqOjdtVpjwCdTFFflHsGTgX9nUr72HbB3t6G4Q8e
         Hs4r/MfsVkPj7ZVpteS7we798DsrfvYfZ11jlX8bCrsABawR0UTfodjQvo4hOZGAuX2v
         xk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756397541; x=1757002341;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bp4ElGK6RP77Uen8rMm55HR028QrXYt0ST2h0Q/cZjY=;
        b=UsDtob2oLSl4NHi3efOeVrTwUZfW2bgEgLIegAz1u2bNkyxu1nXmv8N5r4SzbhB7wL
         3/HVAbJckNFAGFIAW8Xk2PcrR8nSvUzQKgjgq8+N/yR5Ovljmmisn2qZ38aLVuyed7H5
         qsJiVI0NRiTazzZ9gnfObYQBKiIMDTWIi1pBJ4ak1cQos4dUzMl0mwnlV90oEKQALYZQ
         fBFmXTfmym06vim/FRzvphjiytM9Sk8IFc2MakJqo6tSX3zdAk9udGO848CMyrxnuxcf
         6NwEmWP6WLXVAFzBFF7KpQait87vaghV6BWNztQdzSk4+QRkSS6OkvMJ+0WSXE86X3G2
         xPnw==
X-Gm-Message-State: AOJu0Yzp7uuR2ze2SGLBt7mNuGzYFJ4hwMZPwpHx4B5OwYx5KMSVC7pR
	7Sb2Uk18ftVXWg//ifNsilu3mP/LjPNDbRlAflkJLrJZDWwig0BTOOexvgmwvt+X
X-Gm-Gg: ASbGncvxgIaE+v/SDZ//L4TSZao8n6D3F8JfmgjFZCQLnIUao09X/C2i0jN/gzH1Xtm
	REytj0NYshoF08Go5N44rkc1MXifUC0jgzKSVk+HqIEhSvl5KdHpth5nDVsZ5T2VOOVSCdToY2U
	GxD14NZBoKFQAkYETuh4G0YKYIpItFj+Ae9s8A+muBeh3hMIUzk1YIjcHtqHClTrpdj0AH1JQd+
	urr8yW4Ywwe7RcgtklH8ANN4JGwxWS5CxfW3tf67a4so9qWxzcei/bBqEjpz15rBvMRZUdkSDMR
	JpYzqBc27BUlbnpkAa8fKXk499DuaWR8VpbM95mHM14CyFQECcpj0B9yebfKN1+6oHim5KkdL2E
	FFHv2LLIVZ1LtrryK10/G69Cmaun/3hRkaU2E1HDr
X-Google-Smtp-Source: AGHT+IHh8exqxBifb3w8aRsUPLLydmvrrWe3n6sWiYOt07REfYs8vqooc1bDt43ZiHVYkrbsHOtOVQ==
X-Received: by 2002:a05:620a:698c:b0:7f5:9bf0:b45d with SMTP id af79cd13be357-7f59bf0b4cfmr1140012985a.36.1756397540526;
        Thu, 28 Aug 2025 09:12:20 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.237.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc0d67c51asm8537785a.5.2025.08.28.09.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:12:20 -0700 (PDT)
Message-Id: <pull.2035.git.git.1756397539285.gitgitgadget@gmail.com>
From: "haihuayang via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 16:12:19 +0000
Subject: [PATCH] update worktree in config.worktree if it exists
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
Cc: haihuayang <yanghh@gmail.com>,
    Haihua Yang <yanghh@gmail.com>

From: Haihua Yang <yanghh@gmail.com>

When updating submodule core.worktree configuration
- If config.worktree exists in the submodule's gitdir, write to that file
- Otherwise, write to the commondir/config file

Signed-off-by: Haihua Yang <yanghh@gmail.com>

Signed-off-by: Haihua Yang <yanghh@gmail.com>
---
    update worktree in config.worktree if it exists
    
    When updating submodule core.worktree configuration
    
     * If config.worktree exists in the submodule's gitdir, write to that
       file
     * Otherwise, write to the commondir/config file

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2035%2Fhaihuayang%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2035/haihuayang/master-v1
Pull-Request: https://github.com/git/git/pull/2035

 builtin/submodule--helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 07a1935cbe..231c70f12e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2519,7 +2519,12 @@ static int ensure_core_worktree(const char *path)
 		const char *rel_path;
 		struct strbuf sb = STRBUF_INIT;
 
-		cfg_file = repo_git_path(&subrepo, "config");
+		/* Use config.worktree if it exists, otherwise use config */
+		cfg_file = repo_git_path(&subrepo, "config.worktree");
+		if (access(cfg_file, F_OK) != 0) {
+			free(cfg_file);
+			cfg_file = repo_git_path(&subrepo, "config");
+		}
 
 		abs_path = absolute_pathdup(path);
 		rel_path = relative_path(abs_path, subrepo.gitdir, &sb);

base-commit: 1fa68948c3d76328236cac73d2adf33c905bd8e3
-- 
gitgitgadget
