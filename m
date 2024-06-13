Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875021386DD
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718310316; cv=none; b=nyMCvMKWiBmBf251ktzt3sPNDeIDQfxLekRsU0S3GJrUbsPKZenNFum7czLzOQmzdyMclWpO7hIf7GeNKq4EmJCexPPTBDdzWWv7lTKsi6WkL7oHkEpOETIC7k0cIlnONRxYODdJrN9Q5cnn5mHgAM0N/4Gc78TbPWR1K+6i9OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718310316; c=relaxed/simple;
	bh=Kbu+OgFjaQd35bZDZ9rCMiDBvbVGdHR7B/qu6ymk3lk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lRD/D8DBrr/AotdCIlD/CH0hCk/eHjDFsZMvUrDImxWz6Ns1avs1oxNs2lwdeZCXevUP3MGKSYetvg+qtPLr+wqoy4U8UMUVDqMz66dOEd2FDQzf8P6LGT6W/G7FBhnGGi6SgWi6O6JwW7lyPEe4VPF0AGzfywnVmoV/olaFZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmBz+8Io; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmBz+8Io"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-421a1b834acso13203785e9.3
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 13:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718310312; x=1718915112; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVsU2Cl8ScZ/OmhDv+DolrqWnc9N2Y3WAlue34ePLFI=;
        b=dmBz+8IoPT6Zc5ep3QH7hPga9Gfd+Gyx9tHpgv1rRPgvUcbaRlkRmdWt7GhDJZs0ai
         MdQDz1VdF10/NjJdB+7W4rbkT4tKNx350/rJHEuCwz4FZhiHhHWbihADCv4EdzMfAztD
         Q73k/3NhrLo91i5PhCfLkbbRtp6esdZ33LLHUXTKh+djrTsdBQRDdBZH+RcSBQHB/Wh2
         hHkL15RJbxgMHnv8b4wzun0Bk/qCNAm0/qNv+YAUENdVGFyY7tOJyyVnBzoXUsLGCZuV
         DO26Fzj+J1oLlfhG0Q3zybwrIFmIfWLhLcOAY5x69ns42Hj31jDJWNaENYstMjQqTlmi
         H0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718310312; x=1718915112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVsU2Cl8ScZ/OmhDv+DolrqWnc9N2Y3WAlue34ePLFI=;
        b=O65xr5aHmXteSkRliX6WgVI86quTDd+eXvAC/vhtpoUrcl9/PKfvdiKzqM1/HBfKbr
         /GcTmFzCZUYdAdxeR24yKZQnvVwQxHUtMfWp3oEFgC+fkHkWYuXCFs7MmKXQwRS8htN1
         uhSCSHnDXvuKowv0pfa81AG+r7hv5zIgE5F/DtGQUhvYKG7mS52xf0m3bWGpkqrUY7lc
         utW81oYYy9+O8ZSs4C+MJaGGjDunh8zrWy1flXrVnwBv8ZYogBnUM5U2SfHBk/O32H7O
         NbHrh/uvAVU3wfGsOhnYTWe/xoNAIc1l1C0nhMOKfOCNWtHTXRtreo7d20lo12G2DfUp
         68fA==
X-Gm-Message-State: AOJu0Yww0Icmnha3dse3Qqz/2uIf6JEGugGa5u/3vt1FjQywAPqs7L6s
	smZ8axgUvN2Vje0YDbHREBfw89uU1LzF2+T23WE/Te0Lv+61BZzpDPwDjQ==
X-Google-Smtp-Source: AGHT+IGTvYtnqPuSqh02FmcmZwiUGsI6w7wNQiWa2AeS2uvuX9MThoQGkEVzbbOfIEILT1bsOyQ37A==
X-Received: by 2002:a05:600c:4f84:b0:422:7037:54d7 with SMTP id 5b1f17b1804b1-4230484fa59mr7126175e9.28.1718310312276;
        Thu, 13 Jun 2024 13:25:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9145sm73163875e9.22.2024.06.13.13.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:25:11 -0700 (PDT)
Message-Id: <23bb3386114f3bb08de285e3d11e1029ca03850a.1718310307.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Jun 2024 20:25:03 +0000
Subject: [PATCH 3/7] merge-ort: fix type of local 'clean' var in
 handle_content_merge()
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

handle_content_merge() returns an int.  Every caller of
handle_content_merge() expects an int.  However, we declare a local
variable 'clean' that we use for the return value to be unsigned.  To
make matters worse, we also assign 'clean' the return value of
merge_submodule() in one codepath, which is defined to return an int.
It seems that the only reason to have 'clean' be unsigned was to allow a
cutesy bit manipulation operation to be well-defined.  Fix the type of
the 'clean' local in handle_content_merge().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 6ca7b0f9be4..13b47d352fc 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2109,7 +2109,7 @@ static int handle_content_merge(struct merge_options *opt,
 	 * merges, which happens for example with rename/rename(2to1) and
 	 * rename/add conflicts.
 	 */
-	unsigned clean = 1;
+	int clean = 1;
 
 	/*
 	 * handle_content_merge() needs both files to be of the same type, i.e.
@@ -2184,7 +2184,8 @@ static int handle_content_merge(struct merge_options *opt,
 		free(result_buf.ptr);
 		if (ret)
 			return -1;
-		clean &= (merge_status == 0);
+		if (merge_status > 0)
+			clean = 0;
 		path_msg(opt, INFO_AUTO_MERGING, 1, path, NULL, NULL, NULL,
 			 _("Auto-merging %s"), path);
 	} else if (S_ISGITLINK(a->mode)) {
-- 
gitgitgadget

