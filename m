Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C6C2572
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734483021; cv=none; b=IzIm2djwhFby3wJOQUkiXAzemrl7KdNxp4j2QDu81DtzPGFDuMg/EQOg1E2QZcPZDBkpMDlCYoId/JQvFUI+NZTCPfq1Me1L+jojCwWkANgrTTqfWaSjzi2ybtcg2HJyrWdw/Rqc5c7A44kOhOLUhva9mR0o5WXGWghBBs0/5RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734483021; c=relaxed/simple;
	bh=SjUxPAGwY698+vN6XRoX+mpba2Jb6eXpRcviUGGPDsw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oPxt0DK7AplZYAhxXumP9FrL3qn89buuVckFdC86iPDXLJ7j8w5yGY0I4is4ucWLMBF2wiaMrxMak2UBg86mjzTqQWFIeUQ7BCIJDeGoY0Se8XFbH6vrn/h4h7o+4ts88oPUDnJx9/BRY8aMun0q48V0k1/ehU/PovSTSzhQIDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZmDl5pN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZmDl5pN"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-432d86a3085so39546065e9.2
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 16:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734483017; x=1735087817; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2mMaMJQPLo/5n+7+HVxHK3Su1lOnbvc7+UjiSdmuc8=;
        b=IZmDl5pNoCxF1nJCRBKaps7i2gnm8SSC3jt5bcZ0HsfVVfGd+4tbKLp66ZwrHXT/Aw
         gHFizgLCLvwruxCcXx2sbYnesqugxv2/UXgSEMD+PpJ1LCJMABXVVbLWIGsLtOifS97P
         wbTmqeta93MlELTlG3JH01w6h+kYJzYKlENpZEsg1b2718tKJ6ohkkHN3bLhm5yciR4/
         b8X1tmt4d+w/6ifimXwQihPcOMHoqakxgKO5HzIRLdjo5fPcNVKD1KMhUkaU0UZs4Kfo
         CgIBHgQ+yOB4DfFQ03mJ/VP6Bd/waO/pLUuN/L8gOKHbzknTu156GQAOsi9tG5pVlUIa
         mjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734483017; x=1735087817;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2mMaMJQPLo/5n+7+HVxHK3Su1lOnbvc7+UjiSdmuc8=;
        b=BWNzQgnuMAx0PD1jyXi6AeCv24sjPpv7C2l9/xoOsaCOl+JyHRb4060jk++wMslaFU
         kfQyCuZ2ZdOst7gJk+NvUZpbm2ThwjDQbJ0jzBYNvwV5Gi045YUJ0Y8QAsMBCYeVzB5J
         j9RPnVO4YPZx+TJoKQ2g/zuaQ4+hamB+3OG4Xw/hs1c/DeQmlQ+5lFYoRBnJ75UpuYMt
         YZzoIVdD8/k74dlvjrL6qo527p2ak+IwDqwa40gyAT7G0uEgMKNZ8UJY6aaD+d5c+oBK
         f7gbry7Z8YY33hr8LJCgiRtmtqZUNwYCs7B9Gr7W5xCNgnHeuR2lSEVyY5hK8wcVh51N
         PyMA==
X-Gm-Message-State: AOJu0YzVAfXo61KeP2XZXgu/Z8v8BGyfJdz6TEzZke9ISPWiMuY/Xxmx
	H6j8FWap1FKwSpm14tlwlVa3hirC/wP7LOlY2s30KcR9Sj0ys3ZPnrxiQw==
X-Gm-Gg: ASbGncs+bfkHK+PnqNenX5tSG99lrr7dOVIEG13b8FbZJFqdCtzd3gq4eMRfW27Zjfn
	fgZ9aO7GOi8U389MEFRI1VftQZZvI/JhT2ct2RGdJbLP6je8hKAQAQ7DDgwztWx2/gKaC2+veJn
	KKIkapGgzTJHOw+hli0fFS2Rn1Facqe0Ib1iFcUqakP94/h36pi8J6CMV/B1RH/evGK+O4ycIcq
	FCbI9Kvh51q/f4mFMJ2FWRqQ1qfBWQZYkxuci5r/QJnvewPY/n6U6S/eg==
X-Google-Smtp-Source: AGHT+IFXGisfroF3uNClqA6MKkCYeVZuZPDmCYdyQZyWsZGPVFYN5SnFsPHZ54lASni/Ju84eGSRIw==
X-Received: by 2002:a05:600c:4709:b0:434:a1d3:a331 with SMTP id 5b1f17b1804b1-436553f69d3mr4450095e9.22.1734483017466;
        Tue, 17 Dec 2024 16:50:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b1646esm2801655e9.26.2024.12.17.16.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:50:17 -0800 (PST)
Message-Id: <pull.1432.v3.git.git.1734483016515.gitgitgadget@gmail.com>
In-Reply-To: <pull.1432.v2.git.git.1734482334390.gitgitgadget@gmail.com>
References: <pull.1432.v2.git.git.1734482334390.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 00:50:16 +0000
Subject: [PATCH v3] git: replace greater-than and less-than checks with one
 not equal check
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
Cc: AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

(version < 2 || version > 2) looks silly
considering this is an integer.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: replace chain of greater-than and less-than checks with one not
    equal check
    
    (version < 2 || version > 2) looks silly considering this is an integer.
    
    Signed-off-by: Seija Kijin doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1432%2FAreaZR%2Fversion-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1432/AreaZR/version-v3
Pull-Request: https://github.com/git/git/pull/1432

Range-diff vs v2:

 1:  07e0d614c21 ! 1:  322d04519d5 git: replace two checks with one not equal check
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    git: replace two checks with one not equal check
     +    git: replace greater-than and less-than checks with one not equal check
      
          (version < 2 || version > 2) looks silly
          considering this is an integer.


 builtin/show-index.c | 2 +-
 packfile.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index f164c01bbea..5fb71a1c425 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -44,7 +44,7 @@ int cmd_show_index(int argc,
 		die("unable to read header");
 	if (top_index[0] == htonl(PACK_IDX_SIGNATURE)) {
 		version = ntohl(top_index[1]);
-		if (version < 2 || version > 2)
+		if (version != 2)
 			die("unknown index version");
 		if (fread(top_index, 256 * 4, 1, stdin) != 1)
 			die("unable to read index");
diff --git a/packfile.c b/packfile.c
index 9c4bd81a8c7..de0662b2353 100644
--- a/packfile.c
+++ b/packfile.c
@@ -114,7 +114,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 
 	if (hdr->idx_signature == htonl(PACK_IDX_SIGNATURE)) {
 		version = ntohl(hdr->idx_version);
-		if (version < 2 || version > 2)
+		if (version != 2)
 			return error("index file %s is version %"PRIu32
 				     " and is not supported by this binary"
 				     " (try upgrading GIT to a newer version)",

base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
-- 
gitgitgadget
