Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF85F21C9ED
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742599237; cv=none; b=FiWwgAW3oXJyH5DKqObAi369bOjgyu+Q+0zKrgj3rB3HK6YpHkDDUMoiypnHP78TWXPMrTlfYxHgrJ+UxA0qP7ZgArXj5+A6d4nEKtZld7ii1cx9OyNWCFNwzBCtMkh+whxjLHQamvGmQyVd2WLyGg0xIWRSiijEXe+NqVWvbGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742599237; c=relaxed/simple;
	bh=Y3vQmvn5xOd+9o+/2lmA3xPqe4MEyzHOD5ULKeGIm+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrvT5SkbOL2YImK1tjmSm2lMTa83xOErVRvoqOuE2gCTO/f4aXwNMmvc8fqDsg9Iesh9yuG+ucH57uS4VLeduMtRjruWeBDeEjmYd5meuqa8+iVb1aRxON1C2VVL3jtjD0+RtjRiLNJv4/E8/pf2/ULYKolconmo06It2nEI5gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gd+e4pVs; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd+e4pVs"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-601fcbff303so1193015eaf.3
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 16:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742599234; x=1743204034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrxUs4G0NW04sAu7dWieoazwet9JY9XLY3hcpI7TbG0=;
        b=Gd+e4pVschsxtanNEDtK0mZhmLs8L7g8+IFHpefb5lsLKZTBonRevwgAkOOrIzjdSy
         X6yfbRD6Hd4k2Sdnu9obwX0UOAk8rSwLWuG0kiiAckfA1s3fbB+7FmRxZix0v/wWiJmv
         mUiherUr9vZv7MjnETh+NVjjeqkSbVXX9WHMnOGWyBJxQi1Vu+FY3OKfJLG/mHOY4VkQ
         qylsfBnkUMoBa6R/ASfn8ruZidlUtvodPjTTP2En7Nf3E+wtWaWy5Es+4J5hrWqAY8dp
         3yANJvemvBX2TbYg77yP0NMXM7k/+4o+HebLrGNQaOv6gDkaWlvbCa02WjhsD6aCDCar
         TUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742599234; x=1743204034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrxUs4G0NW04sAu7dWieoazwet9JY9XLY3hcpI7TbG0=;
        b=OVGw729HB/3csk7qj93FLkIXEDlrP5gqDyOk8N8/YS46jnA67SvPNCpf+1b9yu5v8x
         /3uMHpfapfxNdPfTBOwVxhiF7IUg6QIdUDEMf+9LuteoCUWR8bK6l53mw/ipzu6oR2J+
         xyr1KamuPBrGnIORN3hkguuaRMlDK0hQWKl7tHM6rzW7ZhXPmIIhgEGUS8YbBr1HzTbR
         eBQuOSM3S+QhDdzocGQZFDGXxQMipEVu0gREL+cu1MlRvxhblilHkk1a8Tvdfz9uaAbO
         jimnvsz4ckDM6fKqvBPtk611O6sRfx1EaP7NOTPURpKrJ7A0Wqc7DoSNOKhzHmxzLyEu
         3TXA==
X-Gm-Message-State: AOJu0YxBiF8i9ErppM4wia8lk5/xD08Ou2NsMuFMLdGcvrr8hej2aFWx
	qPgv7vQ/cwoox1mZ/6a7O2m0YfQhkXOFVCliuV47Gl1z9+knjdkntMIVqA==
X-Gm-Gg: ASbGncuqmzm+hdmjM3Cll2xSPvZekKg/jut6+ThQwVzvkHevdcOO0+/yNYRYJmC1dzS
	KwILZaK4WHBNJCDKIeFu2yJP1V32u13Di65lKKIshMFUhE+5sxH3gLZjeXEtU3AEyfOwyp21n5n
	O0gJLkKDHeBz9cIVOKz1Fgyc8Hh0Cd/YVCBza0hpuiSME62Rdlug5GpAoVRwgZ6r5ztEV2f9Q9f
	p8Mhx4IxdF06T2fWm93CA+JDQVdBq1Kw+rud/9TR8/KgeerHg6JDkn9seNk2wU2FfpZFmiN+VDH
	exzRp3k3QSFJnz6EgH8GehlfqloRciPoUt8tyl4Ifh2TfJsk2PmC
X-Google-Smtp-Source: AGHT+IF4OpbV3Gzo+3BbTF5dxYSPiBaGLHjFukPGa/hC/0opdvU5iZSkKCtwWHkKq1cALoCW5FWr9w==
X-Received: by 2002:a05:6871:200c:b0:2c6:64da:5af1 with SMTP id 586e51a60fabf-2c7802022bdmr3442090fac.3.1742599234407;
        Fri, 21 Mar 2025 16:20:34 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f0ed8easm715097fac.46.2025.03.21.16.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 16:20:34 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood123@gmail.com,
	alan@norbauer.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/3] builtin/clone: suppress unexpected default branch advice
Date: Fri, 21 Mar 2025 18:16:38 -0500
Message-ID: <20250321231639.180762-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321231639.180762-1-jltobler@gmail.com>
References: <20250320014646.2899791-1-jltobler@gmail.com>
 <20250321231639.180762-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 199f44cb2ead (builtin/clone: allow remote helpers to detect repo,
2024-02-27), clones started partially initializing the refdb before
executing the remote helpers by creating a HEAD file and "refs/"
directory. This has resulted in some scenarios where git-clone(1) now
prints the default branch name advice message where it previously did
not.

A side-effect of the HEAD file already existing, is that computation of
the default branch name is handled later in execution. This matters
because prior to 97abaab5f6 (refs: drop `git_default_branch_name()`,
2024-05-17), the default branch value would be computed during its first
execution and cached. Subsequent invocations would simply return the
cached value. Since the next `git_default_branch_name()` call site,
which is invoked through `guess_remote_head()`, is not configured to
suppress the advice message, computing the default branch name results
in the advice message being printed.

Configure `guess_remote_head()` to suppress the advice message,
restoring the previous behavior.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/clone.c         |  3 ++-
 t/t5607-clone-bundle.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f14229abf4..a4008715ec 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1523,7 +1523,8 @@ int cmd_clone(int argc,
 	}
 
 	remote_head = find_ref_by_name(refs, "HEAD");
-	remote_head_points_at = guess_remote_head(remote_head, mapped_refs, 0);
+	remote_head_points_at = guess_remote_head(remote_head, mapped_refs,
+						  REMOTE_GUESS_HEAD_QUIET);
 
 	if (option_branch) {
 		our_head_points_at = find_remote_branch(mapped_refs, option_branch);
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 82e3621ec5..f526bb1c69 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -211,4 +211,16 @@ test_expect_success 'git bundle v3 rejects unknown capabilities' '
 	test_grep "unknown capability .unknown=silly." output
 '
 
+test_expect_success 'cloning bundle suppresses default branch name advice' '
+	test_when_finished "rm -rf bundle-repo clone-repo" &&
+
+	git init bundle-repo &&
+	git -C bundle-repo commit --allow-empty -m init &&
+	git -C bundle-repo bundle create repo.bundle --all &&
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+		git clone bundle-repo/repo.bundle clone-repo 2>err &&
+
+	test_grep ! "hint: " err
+'
+
 test_done
-- 
2.49.0

