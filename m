Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC95D47F771
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792012846; cv=none; b=Fdwi6pKyBiUBzdC7u79WR5uFhe5VqRRNeOnpmVgYorERIZ2XKIPi46DSiiZ6nWWVZCqJ0PpFEVnZ9UUpJnJazX36Hx9hZBtO1EhWR/UYYcPQr9Ua0T2e/qEi9YFrvi6sFAVI71xx5Mx3om2LgazpOd3+YDj+ZMWdO5njnj5AVCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792012846; c=relaxed/simple;
	bh=PyRc/KyDgnJrxFyd76PSRpGHCtanp2IIOLbmtOg7IgE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ckK1TdSzlwfxR/MDLsve6yaYgC7Q8qPLZOnkIHT+51+g+nK/JnSbAWTIAJ4F+RIk/xC4WDtkRUYqoyaSHlO9L2FqmPHSgWiQtNHN8FA3T8b0qHCxLJvYiGbugbzUjLudRPtfolKwTr4OVRToMUZjdpCN8u2IF/3FnFOsB8zo924=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEVeFW7V; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEVeFW7V"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91b83459526so39184786d6.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 14:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792012844; x=1792617644; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MTIYfxBv/0zKkgIT6woxe+FX0VFaukjCklSCHYMho8E=;
        b=MEVeFW7VVe2RhVgHpFqpmOuCHY9z+YJeGGlkzAtfVu4SzrlAgOqCNQXmnAkGLBfM6l
         btqoiGn8FhC1zPKh0BO8c7HmlpY1BJvOe2LyUDtcmrt9UOcv1c71KH8WHElOsdaupONL
         +6EJ3VIJzdloR0rYtW5EMiDw3VEXZrbOY0jVp7zDbT0rDGDtEMhE5MIoyP6WjjV9CNnn
         tHBQDX55166R0uduRRhtM2GmlWTEGaJ0Em6KC0cAeERS2o2O2hab7t0L/f5z4Gh7TIlM
         jN3rRXpk3fiJYsoFleDOyJ/6c5dDqQgBvyTgQ30yoj4SDhcMNx/FTkuBzV1CM2iof1E3
         TUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792012844; x=1792617644;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MTIYfxBv/0zKkgIT6woxe+FX0VFaukjCklSCHYMho8E=;
        b=Z5ti93po+AwSOAx+ZhKvkIRYIdb8XXQzM6NVmLbKOWnW5OB8vZ5ommU772x7hSwGh6
         x8POwFUG2+lCkLYuayL3eDLdrdwpq/O8PMRHnk0753efLPB5vdCSkxi1iBCaV9iyFgUb
         p7w1zJM2PUAzZ/7cFJqtBPjiCJ1KBN8NFgCBoot6a4uFHm+jsaG71CQ8di17JqNwvlsz
         oD9w0hI2NFyqfUxdM7cpHN7Lyzewo1AG+ns5f4jIwHAQHuMj6MtogpaNOO8X84ZA0NTT
         jIE49BIlUQFdwdifH2mVS0dJkEKlN93RiYNyMfHnteJodyOM1Vah2qjLzarRVSWK08m3
         baYA==
X-Gm-Message-State: AFq9FYIcTznS7TKX4wX+KaaaP5jeBLuMz9PDsljtg3Nz+GNrSrebnput
	cpp0P9ERBGITd+dU2g9Cf3AKNPLoEiquhUpilRC1LLiA6KB1Ytd6RWDGHgEAVURWKNI=
X-Gm-Gg: AYBFou3mChD6K4+UNXuAYm83Rdjt0eEE+h1217glQjMHq+BjN06eqmJC5zwcQsMnSZf
	orFcGiFoB/I7/yFC7kBdHH+kPFYRGf4ky/9N9Ro0zn3K9s5SGm8z1AJi7+ItwJg+zELZYj08vAE
	YPQA9/3X1bqGDKQz2MxB+20N1vDBpql1If7lJkx+2aEa51/5L9eBEFSSHr7eAzM0rdKw6k/si9v
	r4hGh6evagrvQGDmyxKyjOA9QKUSiBVZq3UAGailuGPoO9oGTVJFtKdzVXOIEWppCN2lwgD3HNz
	FCi/6DPaqwWVlF5dFzUqqyfEd8J0ICGQtYMRu7Y0aMVkI6IpCNMS+IS/npdsGe8AFLa+0qZbjsX
	v3WjbUQuzCKKSQI4OiroONpbiKJJ6JtrAUqJdOl3XRa4Lgn+upPEOOzqY6uuRR05hEZyFxiv2pJ
	S9b9Q6H+uYAOW2WiyoH0e3Eqetvo8BW0t61hXDnx08kQONqmlZS27TmO8YTj+SXdjxzeUbc665V
	Q==
X-Received: by 2002:a05:6214:2d43:b0:917:9338:6f16 with SMTP id 6a1803df08f44-91b67c1df63mr245528316d6.3.1792012843695;
        Wed, 14 Oct 2026 14:20:43 -0700 (PDT)
Received: from [127.0.0.1] ([20.220.125.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97be6583sm63014606d6.41.2026.10.14.14.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:20:43 -0700 (PDT)
Message-Id: <8c80b9ae05035b3bb864e17e08be9604447dd0e5.1792012836.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2225.v2.git.1792012836.gitgitgadget@gmail.com>
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
	<pull.2225.v2.git.1792012836.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 21:20:35 +0000
Subject: [PATCH v2 4/5] worktree repair: reduce .git file reads
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

Pass the loaded contents of the .git file to infer_backlink().

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 worktree.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/worktree.c b/worktree.c
index 3627dbc044..879941a977 100644
--- a/worktree.c
+++ b/worktree.c
@@ -806,27 +806,20 @@ static int is_main_worktree_path(struct repository *repo, const char *path)
  * Returns -1 on failure and strbuf.len on success.
  */
 static ssize_t infer_backlink(struct repository *repo,
-			      const char *gitfile,
+			      const char *dotgit_contents,
 			      struct strbuf *inferred)
 {
-	struct strbuf contents = STRBUF_INIT;
 	const char *id;
-	int err;
 
-	err = read_gitfile_raw(&contents, gitfile);
-	if (err)
-		goto error;
-	id = get_worktree_id(contents.buf);
+	id = get_worktree_id(dotgit_contents);
 	if (!*id)
 		goto error;
 	repo_common_path_replace(repo, inferred, "worktrees/%s", id);
 	if (!is_directory(inferred->buf))
 		goto error;
 
-	strbuf_release(&contents);
 	return inferred->len;
 error:
-	strbuf_release(&contents);
 	strbuf_reset(inferred); /* clear invalid path */
 	return -1;
 }
@@ -877,7 +870,7 @@ void repair_worktree_at_path(struct repository *repo,
 	}
 
 	dotgit_contents = contents.buf;
-	infer_backlink(repo, dotgit.buf, &inferred_backlink);
+	infer_backlink(repo, dotgit_contents, &inferred_backlink);
 	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
 
 	if (is_absolute_path(dotgit_contents)) {
-- 
gitgitgadget

