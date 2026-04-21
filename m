Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40E51C701F
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776731183; cv=none; b=Zmck838HPgyQAFmn42Mdax11hgVii17K7+DMb4gvQyiNysgXPJCGaAHQxpxXJw91+8rRLtB5F2ztOfzF1Xcs/A9WyyDrLmv5Se7z5pZ6n/3K0vwEr9UJNibw67eoeArgh7nD40kKCymZk+hWVCRM/W5hO86HdzmBR9ZDzS7zR2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776731183; c=relaxed/simple;
	bh=tCntjicGkzCIEfqEApBlMwlGSyQipQ05uvtQC4bkyFk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dw8AXrSvpbJlPbBTzYjaHQyq28++9H+Qj8HIfPUyzoBo5o2aDUbf+cVgPbbSVKr70WINmWU7PEYxOo5bEQeMC5vBOkfoLDsbcLNBX6VBeKOXVbzOimBRM0WDU1/knTfxhOgFhIrQvRQAG8AC/KxzuMMqQj+AfX1auJ1tjqVfoK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+zW+Jgq; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+zW+Jgq"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8eb5ad01402so159356085a.2
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 17:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776731179; x=1777335979; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n6I0u+HRI3v6guwV6ovxIEI/TED1NdGKWo0n+27bwo=;
        b=o+zW+JgqMRnR7gcA/KYfJOhx8bDTPOjoSH8NgvzAQ4ah3JxpVYRXEvnHNkcZ/hRUNU
         1aN1nrX8uZ9AWP0VnPUjJnPBJbG0Qb7e6xR+p0lHnGRHLvZj/fFJIG/wb2aPMuHT1RjK
         F/hG3zvXvewfy6LyUHup+FlC6UC1cKLjCJWBjeP29dmk3ksJXac9zZSygjiLWdyG9v14
         A2e0Dm9+odtnohzNFFIxT/qFKn/UiIn89bS7LWNqmia1vbUOyNWP3wBnyJTJMXU0HJVS
         k9jHmlvpuCCQUgQ5JnSqNRpe6WgOTgrfKcsoaJ+tcpAm9tT8KrJnSW1ZcAYFWjq4Ci7Q
         PpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776731179; x=1777335979;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4n6I0u+HRI3v6guwV6ovxIEI/TED1NdGKWo0n+27bwo=;
        b=pZcX9PuRnC57KFFYSWXZoTvUizYCPSHYqJV9USK2J61rxaejVFiCQViyRlh/cfPDOG
         CmTCmOrYv87fTJhz78fzos8AmB30hSRIZ/5l0pyI1+89AM3paXpu547rY6DKBVoYDCvD
         Tgqt4IOqurObgFMN/sS/tYTJBC+FZLAqCHm+p8GUiwIrt44YdanPSHw28jGsS5LBKchL
         jJOpujyTP5djJ94oJ0szIDxDc3/cLBVyR32306XfKZjTZKDvCag2HkRxEqq/j1PN0fuC
         hAMP6d5+WiUlElOxOw4Jan/IKcrCLlRf0Kzmh/XKPDJyLu3FUYE6STM9RpGPKEHaEj6+
         xIwQ==
X-Gm-Message-State: AOJu0YxuF9w5qA1ckpH80OgGYzFp3CmyGDJCsoYNH+6bwHePvjzCDUSR
	XwbcRjT4roW+EM44aR+v6vg4bQxU63cgyT8/+UNuCS1W19De6wR/qobb95w9zQ==
X-Gm-Gg: AeBDiesJNcAUV1nzRYZIYkzjd5L7M1JRd0VzfVC9S8YM6frMB5YKxn+ZjjsBmI1QxLn
	P/S/q/4Gx2NDfwuo+iKPlm2LBmN+sgCPPXR1vufCaJM9WybzUeQgwjZZqosIj/586kBqaWFxpU7
	6axHdN6kx/DvtiCwzmKSXmOG30zVdr1/mWPy3NIQSY8SMe5UngqzZhOWMOaDhsdnfaLhGZ3vylx
	MwaqciXJ2ByNBiI7TXj9/SW/VWJiUTsgvVYtFE+gTbl3VWZ5qZps7Z0E6GkFS8UslIPwox29JOf
	QpUeUtZLe6RTJLKyqW66B54eAgCyZVlwYiUpskN5TN8206GDAJc3lUpfoWZMZKEqSBzd0YCbxrx
	yr2Hlsdb6v2DAMKNQHOO5aEZdKkuyHeL28p71qarDVG2nrS0Sn3/HkRhtyHUtKNJ5AkdtJ3WdrC
	pnN2TqFVN89KqXd9JKyegZOGFb3LQcWntq4pLv
X-Received: by 2002:a05:620a:4455:b0:8ea:addd:8954 with SMTP id af79cd13be357-8eaaddd8df1mr1000049585a.24.1776731179464;
        Mon, 20 Apr 2026 17:26:19 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.117.99])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64cc559sm941991185a.13.2026.04.20.17.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 17:26:17 -0700 (PDT)
Message-Id: <949b5d8e3f3aefd9497a7b85d860259b9d5db418.1776731171.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 Apr 2026 00:26:08 +0000
Subject: [PATCH 2/5] merge-ort: drop unnecessary show_all_errors from
 collect_merge_info()
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

collect_merge_info() has set info.show_all_errors = 1 since
d2bc1994f363 (merge-ort: implement a very basic collect_merge_info(),
2020-12-13).  This setting was copied from unpack-trees.c where it
controls batching of error messages for porcelain display, but
merge-ort has no such error-batching logic and never needed it.

With show_all_errors set, traverse_trees() captures a negative callback
return but continues processing remaining entries rather than stopping
immediately.  Removing the setting restores the default behavior where
a negative return from collect_merge_info_callback() breaks out of the
traversal loop right away, allowing a future commit to exit early when
a corrupt tree is detected.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 4b8e32209d..74e9636020 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -1740,7 +1740,6 @@ static int collect_merge_info(struct merge_options *opt,
 	setup_traverse_info(&info, opt->priv->toplevel_dir);
 	info.fn = collect_merge_info_callback;
 	info.data = opt;
-	info.show_all_errors = 1;
 
 	if (repo_parse_tree(opt->repo, merge_base) < 0 ||
 	    repo_parse_tree(opt->repo, side1) < 0 ||
-- 
gitgitgadget

