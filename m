Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973821CFFA
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362529; cv=none; b=BCbtBOVvx8Y2UbNKUfkhqvRuPhNpVGXZmHCS1nP7c5B6GiPsd45hAwrovousdSqtH9tZebtudbwyxxLivKd18Tydl/8J15MkT8uSVfV3manwD50CkwlOP0jkXa+lgX71o1PuPXnEFsu8YWHxb6RIUjauhAwhs3Pfx5xlhqzqgDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362529; c=relaxed/simple;
	bh=WAXsQ0J4FFPqz7CmMm5SKdUextXJTaC3nL195j1fLAQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lRiU51nv7+E1ACkohKq+etpIl7EOhzb/426o/gx6abQHz8LVwr4X3Y8RjADZdwjJlgZhPZ978Hezf1wEh4u3EEZ1yzDCqF5cjW3ibxLZNg+MgybzGVRJGFb0npmMBDVF94ZCAV4suTyO97Hr9n5jYzuEeorL5+RaLSAY2HJeHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgCKXxy4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgCKXxy4"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e058ca6806so3884940a12.3
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 07:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741362525; x=1741967325; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPTLdDJPEjOlD3Zz5xzNgaPFDkpvLBBwzGPAK6iywbY=;
        b=OgCKXxy4zP6ew7Uivj5ZEwyOMLcELY0OyI/2oCdZ+rV6i4pcecQe3zjU+2b0xexgLR
         pmLLYSId5nlO8ArpG5OQQ9N4YhLxON9ka6/wp5upuQxCJvDwbyVNT4fmm1BJ3thpgFVw
         rhGY0Z7tuPpXyne8Ge3OGXBuXsO8H3iQW8pmqGBG8/DXXlOKp3388KpNBIR5Q69Ve9AV
         qj14S9zaGsFBD24+3ciixxaGtqRr3cnbEY5SdJhadepN6x/K+mU3Z67xctaOuR8C3aPM
         Ddu/hxTwxR1xc1ezLO4GRacFEP0nf2QafUzRvndKFX+6T7+R8SzvyNA7m4qt2YAhiTG/
         Vhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741362525; x=1741967325;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPTLdDJPEjOlD3Zz5xzNgaPFDkpvLBBwzGPAK6iywbY=;
        b=PMLXClQmadBq14s8bIxLzMsxy/mCcWHDuV08WfLs25AhjGtXUm2jUpeYS4yJf0Muyz
         BwoCeR/PE6EGGZ5Sf/uCgwCw5+En01uejKoysOvtkHjN5nnrGQuYj9X3g1yrz3Mo2fvq
         p6rcrMK90YAt6WsnlPK+l1zvjcCNY1ZmDa0UA/Nzk1ymU3CF7PbtZjuuWByFSGh72bsh
         zYrAaGoHmXa0SMCK2DZ7WHuAr2hdkgierVhzU7n2yLj23hDtQiAdmydpFdjtRHaOAPpj
         3zc7M8uf3+pX+UEGj/eHrPz0O540gBNvpyBHrSdldfyoDksmAxQzxolNIQVLeleQS4v9
         jQ6g==
X-Gm-Message-State: AOJu0YxeD185uhWSD6o4zj6k9FPtT7FYmkcGPvmbCq7mnWzWdV1fLNas
	7mwOZcS21xh6nJ30TCmZz0pcqCBEDhmb8cOhW0qUbZ0Gqbtiimm13j1jyw==
X-Gm-Gg: ASbGncv5Oda865QgyGxqXaz7HQVoKPQsiMRKcr3nX6qB0q5x0YTLCv9LOjq/kVN4bJy
	91Y+lzGli3MJnS5z77V2t+QQ/Oi9gQqDJexWrNCjMooXAccQ69q5KCuhTxZBiVUeyhn5X1ceD90
	ICr/I2XFt5Ey/1sTT6HPhe+5U8Z8Msfo9L7EqwjN7E3ulxBclc1735VBaDY6JVZ+i82qdyTg/+F
	J1oQ4vjzODtXDdVaBo6IHbyTdkG7VqLmgdWTeYnD+Av6jvQnCYEawMcMA63BcWiYEPhTAJnhRmK
	groksrkgVIpT/HwmyHd+wme1EPy83+yBaMb69sNjulQdCA==
X-Google-Smtp-Source: AGHT+IEVV4aJu+9BdgJQTv/Iv1ZlzRw19/6BiGGHq4BMfb1fF9CFN2gMmDrg1KWzT6lXySIgnXRIAA==
X-Received: by 2002:a05:6402:40cf:b0:5e5:827d:bb1c with SMTP id 4fb4d7f45d1cf-5e5e24a5366mr3843501a12.25.1741362525441;
        Fri, 07 Mar 2025 07:48:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c733fcd2sm2696902a12.2.2025.03.07.07.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:48:45 -0800 (PST)
Message-Id: <c2a2be336e0ed7966b6ab0ef004f150537167b55.1741362522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 07 Mar 2025 15:48:42 +0000
Subject: [PATCH 3/3] merge-ort: support having merge verbosity be set to 0
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

Various callers such as am & checkout set the merge verbosity to 0 to
avoid having conflict messages printed.  While this could be achieved by
avoiding the wrappers from merge-ort-wrappers and instead passing 0 for
display_update_msgs to merge_switch_to_result(), for simplicity of
converting callers simply allow them to also achieve this with the
merge-ort-wrappers by setting verbosity to 0.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index a6960b6a1b4..8021083c112 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -799,6 +799,8 @@ static void path_msg(struct merge_options *opt,
 		return; /* Do not record mere hints in headers */
 	if (opt->priv->call_depth && opt->verbosity < 5)
 		return; /* Ignore messages from inner merges */
+	if (!opt->verbosity)
+		return;
 
 	/* Ensure path_conflicts (ptr to array of logical_conflict) allocated */
 	path_conflicts = strmap_get(&opt->priv->conflicts, primary_path);
-- 
gitgitgadget
