Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288AB7D3EC
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721335662; cv=none; b=h5YZq20c4bTFYMSmhWOAyNbCCYs6m/jEzo7z5Mc9Q6T14sUq0P/b5KVfHSHms3sq+YaDlzkRrnu5la5RC9M9crjrkQrJMQxMgfOXy8E5nb27Zh1owt45txQYUlwMz05CeLTmtp4qV/3gW5UDR06SzX0qymfIplMTogP9JH3aSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721335662; c=relaxed/simple;
	bh=yqVfI41st8D1/C6aDtmc0UAtKYvqNjInMVEx5P4of5Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sy12UTYdgcO2IZlmEzB5CJObU6e52TeZSGD1VinIjiSkJoyi349u4722V7WIaW6kY5PkYGIADRGmaiAAI+FIzw/0uRezzxHkqa4+jOrty7MCp8Kc0b2rUu9lscDJMlSh8+iBj9lO0A3YZxyHKxXxc5LmnZtQOXLu9MJ6sDdrcIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqhFx7jK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqhFx7jK"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266182a9d7so5762085e9.0
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 13:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721335659; x=1721940459; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/m9TiGzgShFQhvUcfWJpce8pX+9RWL5b+gs+1WMj5xM=;
        b=KqhFx7jKwNmweg5RnwpKHmgUlwkrpTw0iPbpxaGDf5fkKtgNDjw0O0hZzHbc7e5/Hl
         1yYJM6vWYBlhnfcjwd00f4lQ2y21MntK147mYoUOS6SCDZwWqNHQ+MfEc5VzWxvB2+LZ
         V7DbSX1M++fLACiHsdBtGWqvlU9mDXgOv/lGxLlS+keao85H+3Fjn9KfuSu79YYTLFd9
         3ibIsdKkf1mhjPvQdsonPlzHrLtfnez5iXV/jaq/NZ/DsQWHWG+QP1gRy0SfRNT48yA8
         sKXqTWohXpTkobxcx/FZLNGi6KY1fK1uYXuG2jEmEOEaDgWIOjA7UleQcNkciH102k3Q
         m+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721335659; x=1721940459;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/m9TiGzgShFQhvUcfWJpce8pX+9RWL5b+gs+1WMj5xM=;
        b=DsKhGCrcdh8mytD3L24zp9VAPFHOcSC3u65s175RfMPFRJQsR4UzXeTOTLcF2/1+aU
         P9o8OSj2lwyf1b4I1F5VyE/6qVvGYKy4JPomQ06vAy5QEguYGyBQp35sD9dA0UhS0mGh
         xbaXNIgDcOhI46uetQ7RvoO/pVXm3DyHRN+7+n66w7ljS1TQo00gYR7HSubOOv1ypWy+
         NOri1M27M1LtOPA5l3Yl0JSAFE8U6aR12mhOjafcxxrpVUTU3JuzhXCp2Z6LAtlJZWDl
         I2DuKZDYLwZqsB3v2VigZ/TosbdpcMuHo6oLOV3h+vL99Pk2vV2bN3l3WoM3IbwVUqHc
         RyQg==
X-Gm-Message-State: AOJu0YxMMSW2PpUBdd4t3ztY7Tutf+nbgb3X48MeqDJQXckoX4bCektD
	8D+26oS9vJgDI+Xc2Tvy4wjU/2xVNvCgf8kPEXzIu5dKLf/oJ3ezmHkm5Q==
X-Google-Smtp-Source: AGHT+IG8FryCVxwEAt81CQRo5bATrOZutHF6rTkURoL/FPN1m1Psdn+0feyVk+QttU1+FfsBfj5qaw==
X-Received: by 2002:a05:600c:3b03:b0:426:5ee3:728b with SMTP id 5b1f17b1804b1-427c371a813mr45410435e9.13.1721335658804;
        Thu, 18 Jul 2024 13:47:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368727f1ce1sm506823f8f.58.2024.07.18.13.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:47:38 -0700 (PDT)
Message-Id: <pull.1747.v2.git.git.1721335657.gitgitgadget@gmail.com>
In-Reply-To: <pull.1747.git.git.1721246266.gitgitgadget@gmail.com>
References: <pull.1747.git.git.1721246266.gitgitgadget@gmail.com>
From: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jul 2024 20:47:35 +0000
Subject: [PATCH v2 0/2] git-svn: use svn:global-ignores when creating .gitignores
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
Cc: Alex Galvin <agalvin@comqi.com>

Git-SVN does not currently use the svn:global-ignores property added in
Subversion 1.8 when showing or creating .gitignore files. This causes
Git-SVN to track files that are ignored by this directive in Subversion.

The following patches add svn:global-ignores to the list of public svn
properties, and update git svn show-ignore and git svn create-ignore to use
this attribute (as well as svn:ignore).

Alex Galvin (2):
  git-svn: add public property `svn:global-ignores`
  git-svn: use `svn:global-ignores` to create .gitignore

 git-svn.perl    | 45 +++++++++++++++++++++++++++++++--------------
 perl/Git/SVN.pm |  2 +-
 2 files changed, 32 insertions(+), 15 deletions(-)


base-commit: c2b3f2b3cdbf5ad9feb978dd367d77561a1271f7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1747%2Fav-gal%2Fgit-svn-global-ignores-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1747/av-gal/git-svn-global-ignores-v2
Pull-Request: https://github.com/git/git/pull/1747

Range-diff vs v1:

 1:  27bee8de47b ! 1:  002750ea47a git-svn: add public property `svn:global-ignores`
     @@ Metadata
       ## Commit message ##
          git-svn: add public property `svn:global-ignores`
      
     +    Subversion 1.8 added a new property `svn:global-ignores`. It
     +    contains a list of patterns used to determine what files should
     +    be ignored. If Git-SVN is going to ignore these files as well, it
     +    is important that we do not skip over directories that have this
     +    property set.
     +
          Signed-off-by: Alex Galvin <agalvin@comqi.com>
      
       ## perl/Git/SVN.pm ##
 2:  10e240202f7 ! 2:  7735afb32af git-svn: use `svn:global-ignores` to create .gitignore
     @@ Metadata
       ## Commit message ##
          git-svn: use `svn:global-ignores` to create .gitignore
      
     +    `svn:global-ignores` contains a list of file patterns that should
     +    not be tracked in version control. The syntax of these patterns is
     +    the same as `svn:ignore`. Their semantics differ: patterns in
     +    `svn:global-ignores` apply to all paths under the directory where
     +    they apply, while `svn:ignore` only applies to the directory's
     +    immediate children.
     +
          Signed-off-by: Alex Galvin <agalvin@comqi.com>
      
       ## git-svn.perl ##

-- 
gitgitgadget
