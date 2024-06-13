Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0025A7A0
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718310317; cv=none; b=P6lntlpUixjcjWtAKiBPfPvx90H5P5Bjnoyvl5mu9Mjq1L20cJL4oxPjU/mGSGXtM1Q0qKLOXZ6+9Lfw0+jxUPdrYfh0AnwxbfDSLaZmZ3mMGCLX5lPfsqfs1BdHtLdUC+ZxVh7JOMK6YutK7CHqYpFb0I6i8VM/njKBiio48cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718310317; c=relaxed/simple;
	bh=2zY/9/1jVbokumYQGcSmhHIekk0b8EF1EiI8ifpR6zE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=HYjMi3aEp7zKrmX+S0MaWSFzLj6o4qdaTYwZLZzrBq7d6wbh7/Ma+94JIf+28pUD16qhCOmnKjxb/PJuj64h0UcTVH4yrFWXzW3ifjoURcQpHClgJKEM3SOTHb+9oJrcK/FoyyBgXlCir0Alx+dhO7Ug+zIu5wAyUJj6fOzoS98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8QzZdXh; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8QzZdXh"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35f0d6255bdso1361749f8f.1
        for <git@vger.kernel.org>; Thu, 13 Jun 2024 13:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718310310; x=1718915110; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZjnIkGAiuraa92hVOP2ykc8t6Q2XNMyBp+nA/rETzg=;
        b=m8QzZdXhTDObNBpeqNHH1zUY/S9RkVG2eqnETWeiZB94YuotNN8nZqx+uwgxKBbpuz
         ZeAFtK7n9rcTdszFrVZ/kL6p/epfi7t1d89LDqfC/RmcyP7M0Y6AryS77cx9jI2OCiMU
         jVdOJ2/yQYuGnvYMa3Ag6weMvnY0y/tDepElhvNoLLSiOgwxvan8puxFMCNzXaf96eh/
         pBLt3m6WU+/uasTSfH4h47LE7DoH/sEBuidmCJ2XB4ej/fSFfsawQf99PJfF+edPk8Ly
         vhZvU3Kt8NHfSvDUMGtmsSbdoQyNptJ6kgTwchze76mW2S6ypnKMy/o25/uMT69PkSMY
         xJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718310310; x=1718915110;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZjnIkGAiuraa92hVOP2ykc8t6Q2XNMyBp+nA/rETzg=;
        b=O8/5ONqMp+fKksFrrZCAm6iYIeztmgPXYBd/pmjRm08eQIjCSPvXQ+JkxCgMvz6Hbp
         Zk011vJvcUj5S9D8Zz1WcqNsa++U8vPX1oRoEyPhXH6Y2zbDX3cp+Dr8cX1jsXNM2Wgx
         cA2Ro5u/SrRMXZibqTVa47DpEUEeEhVX+05lH9D5NeteMj6wfLZ80W93kBRXDKL5kTTW
         uzSBwDs9ZEPnDKW8VL4kQ9TdyktoJOtcUfzxCZNdHlxaotbwLZvSUXii2zPA8TfUV/68
         gwGXf+35urXFvk44anQO0bZzTbeLZPpqZ4NbYX90Lth7yzMPphzJhjWVchm/rKZpHiJ6
         KN2g==
X-Gm-Message-State: AOJu0YwGg5Hsm4DHD/CHyUxQGJuiwMskpCixb3AFIi3aJCsUzHrI2FEU
	gv53rz38qM1UmRrJptzTaJ9XvMXUPEDJIVLAGR3OyFx6BFEmGEv3qE4QmQ==
X-Google-Smtp-Source: AGHT+IE9TpdCx5oK2yE7pCIbRQPnM4wVFiMvGDDv2/ot1cP9UWaBa8ULoHV4JPrf8OlYvm882FVm9g==
X-Received: by 2002:adf:ffc8:0:b0:360:7c64:111c with SMTP id ffacd0b85a97d-3607c6424fbmr144225f8f.43.1718310309290;
        Thu, 13 Jun 2024 13:25:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36076515a80sm2433028f8f.76.2024.06.13.13.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:25:08 -0700 (PDT)
Message-Id: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Jun 2024 20:25:00 +0000
Subject: [PATCH 0/7] Fix and improve some error codepaths in merge-ort
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
Cc: Elijah Newren <newren@gmail.com>

This series started as a just a fix for the abort hit in merge-ort when
custom merge drivers error out (see
https://lore.kernel.org/git/75F8BD12-7743-4863-B4C5-049FDEC4645E@gearset.com/).
However, while working on that, I found a few other issues around error
codepaths in merge-ort. So this series:

 * Patches 1-2: fix the reported abort problem
 * Patches 3-4: make code in handle_content_merges() easier to handle when
   we hit errors
 * Patch 5: fix a misleading comment
 * Patches 6-7: make error handling (immediate print vs. letting callers get
   the error information) more consistent

The last two patches change the behavior slightly for error codepaths, and
there's a question about whether we should show only the error messages that
caused an early termination of the merge, or if we should also show any
conflict messages for other paths that were handled before we hit the early
termination. These patches made a decision but feel free to take those last
two patches as more of an RFC.

Elijah Newren (7):
  merge-ort: extract handling of priv member into reusable function
  merge-ort: maintain expected invariant for priv member
  merge-ort: fix type of local 'clean' var in handle_content_merge()
  merge-ort: clearer propagation of failure-to-function from
    merge_submodule
  merge-ort: loosen commented requirements
  merge-ort: upon merge abort, only show messages causing the abort
  merge-ort: convert more error() cases to path_msg()

 merge-ort.c           | 167 +++++++++++++++++++++++++++++++-----------
 t/t6406-merge-attr.sh |  42 ++++++++++-
 2 files changed, 164 insertions(+), 45 deletions(-)


base-commit: 8d94cfb54504f2ec9edc7ca3eb5c29a3dd3675ae
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1748%2Fnewren%2Ffix-error-cases-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1748/newren/fix-error-cases-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1748
-- 
gitgitgadget
