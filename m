Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973B37F8CC
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590170; cv=none; b=gL7c8YXim7H58op4WJ59O5pR5ITmc1FUbRDAnYRjSvS7tLsogI4DXwfs2Wh7YW2qdWo207a/ZJFGh6MzD+BI83QkDBz3ZuXFgfpE/HHW9LF9oIgc1icYXFeXf6IEtDNvjPXVi3oryCXYuzedp4GRO3StszW1ZT7J2hx1vB9yH9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590170; c=relaxed/simple;
	bh=xJocGTOJx1ooVuSXjqMR+t7OIeyRfHUiU/bRcseBxA8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Sbjn2dlY2kvd04l0JhAK8KgF2f5fwbBZclfMu1XaUp71mkWCuu3YtNSJ02mgt7se5VbMSBU6z1luJGL9IHd7vuZRkSZvxOtAqXpQpGt6h5NEJ0r5KrFu0fGbxgPx6bhCD+KHjvvkxe/IlwghANPdHciXNlfYl2Fp997zub/RdGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZFf0Lj4; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZFf0Lj4"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e65e18969so56007985a.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 02:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783590168; x=1784194968; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4bW/16SzkpOP+eGRpsqHcn7Ty8WSLnQ4Gnhjbpi1NzE=;
        b=KZFf0Lj4nzmwnpzG/MOtC7s8/5IMPxpAkmKiRYjdWTSms/VmGQlTnuig4xsBwIu0Tw
         0vR3PPtGpBWCR3YJD9+1IBoyv7hHkav/YKCJiGtWwJLT4t0yvkU62wTFdZPGXEuMspf2
         JINOtnHRPfwxHZiYGdcNwtAto6j38jhregvs9MO0kczvBWfaVdmVEfNn1FmZXCLOYanc
         a+SnpOEbjrLRXe20DDW3SgxmDhX7QefsnrUJss5aelcbriW5SGd9NJ86uAQ8cGa7Dn8S
         ewdcjv1KvSLrrRUd9RgtnymCqmrkjgWr6y5o5GTIsa+I2gidgh2qIoalmZwtJR6QJgKq
         1UAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590168; x=1784194968;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4bW/16SzkpOP+eGRpsqHcn7Ty8WSLnQ4Gnhjbpi1NzE=;
        b=FcRK34UBX7BuvDTzb2gAsIEyJUkdpqPK3028JCmK2ORKPx5n1/GZeX8qGkKBE5VagR
         c/LDIqoAC00kU/T9AQ5dLaKY989USsxxP0tF5vUIzFGX+FnyTgr5NeB0RUtx4ee5hKLK
         ZqVI9STTsD/7+tx2zgtYiqtkHorKvH5XuJlZHgf9wrNk10UUwK+9W3IJSbyEPMOMt/7D
         Zjn/sqM+voSy2P1Quq8gccHMPK3WfggnL0QLu/fjhihsTSfDmyVuht5gV2NzO5s+rWO/
         DL6dgiRhphNLJxYSTNgeboP0fuQKxUHWFuQ6WyindzwiZbhBsanjR0jxzObMf+19i1e4
         lpXg==
X-Gm-Message-State: AOJu0Yz3Yug/qNj7DHwLbF6zzqs6yvA4hFbOoSCUmnRb24lVhkgafCTw
	Npypb0BRts3M9MXRSX9pj3WpuUX9NZ02u8MVLbYJfWCAY5VXfd2dKuFN+/V4iCbc
X-Gm-Gg: AfdE7cky6XaqekWoDzO8DLZQjM7HYFe6Qs4+cP4jnXi3iBGJMMpPKAbWGO5LmQBSTVL
	uEiVbeVneSWzTcMvf702eQIYr3liN+owgClKBtrOianEJknJjRzE/NbYpXqoboh2AfVB3kCL0Rt
	W1HXgtwBMinTYzw4LHl/aIs3HKEkIiQTZ2L/VeyBe17OUbbxhVU4/zyvmnOgVFCUBd3fbbjHvXS
	LUiBTT2UwUm5k5cOBu6J90MHugHjy9J8VUqedhINttte6l0hySHX679iGB2RKQV660dSUjXvGDM
	CHsTOvRiEamaEhtdyq51T1xlUdApEGOUYbQUxMsItfh/35vKA4LD3IU0+wEzDage0tVUuaC3Bvv
	WgnVthGIIQxgBnPs2crCLeCIcP82SQz8b/4Ykv5s1dZXxlQCfMSyMRQ/fSacSVoFGcZc4Y877KR
	YjIn/6UNLbtc+i
X-Received: by 2002:a05:620a:40d1:b0:915:fc16:2ae0 with SMTP id af79cd13be357-92edac0d69fmr193192685a.25.1783590168432;
        Thu, 09 Jul 2026 02:42:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.84.47.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cfa470sm1637570285a.44.2026.07.09.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:42:47 -0700 (PDT)
Message-Id: <704137510808ade246c6f1463e88a8e3041e0f7d.1783590159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 09:42:33 +0000
Subject: [PATCH 06/11] bisect: handle NULL commit in `bisect_successful()`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `lookup_commit_reference_by_name()` is called to find the first bad
commit, the result is passed to `repo_format_commit_message()`
immediately, which dereferences commit without checking for NULL.

However, the commit could be NULL, even though in practice this is
unlikely because `bisect_successful()` is only called after a successful
bisect run has identified the bad commit, but the ref could still become
dangling due to a concurrent gc or repository corruption.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index e7c2d2f3bb..6ff600c856 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -663,6 +663,11 @@ static int bisect_successful(struct bisect_terms *terms)
 
 	refs_read_ref(get_main_ref_store(the_repository), bad_ref, &oid);
 	commit = lookup_commit_reference_by_name(bad_ref);
+	if (!commit) {
+		res = error(_("could not find commit for '%s'"), bad_ref);
+		free(bad_ref);
+		return res;
+	}
 	repo_format_commit_message(the_repository, commit, "%s", &commit_name,
 				   &pp);
 
-- 
gitgitgadget

