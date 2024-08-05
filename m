Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585015ECEC
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877813; cv=none; b=phv6/mQLbdTsN2qrtEaKPZ8QMNoXJtD8E7L3sA5IDiXh01m+jpEPcAt2kM8cVeRI0t9CVlKTFEvDN+Crk7Dw2f2yWuFWvDnjwGmtc/TxsDknu1MvzkqnHa0z4ikdWKmsAVfkGWxS3PX8X5i7s1ZwBVnDnCZCnmL4aVQVTSK98uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877813; c=relaxed/simple;
	bh=zWWFcK8RFOUbRbsIOzM2iyn5nAfHHhXhTTSR+zh3ELw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=da7nLWjlfQkyLqu0iR9zD99RhF9k1Tq9/vN9yGVVD738NtKsztRv2tty5R2W9POUCBqt8AiVTk4G31OWSYGk52zbGw44aWtb3X4kWs5tOqpB2nkrYq3Wsi8kD6BA+xQ3j/c/zhTgKxhnN+MzQyo0AOm0v5zidfTyyaj0khdK4NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+uAk4RH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+uAk4RH"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428101fa30aso73456415e9.3
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722877810; x=1723482610; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3Vm7RTkI+DIMvTV9SZKv9h44j1LiwZRgcrWeULEdC4=;
        b=V+uAk4RHPBOzh8pm2cpJyecP3GjfZ/GQssqOr0yuY5g2g457e1HpmCjstqwLCzZePY
         jDF+Up8jZQWCsBBEnsIX43+LAhW1MWPaZnhm5oWPPNIJNxSx2QP+cM3OaW75qCEbElgo
         GNPITWbvI1c4ZEHXeieTUqAfWbJBGkKGzpzWQ/s2Rr5YcaEa64xFzmc61FUWVCd2fYbU
         BLLli23FalUh4y7HmGN9oZHpUJsL2ADInVdIhT0DiD5f+23ye1JG3X+8LaM2rAMyj9HT
         6QYUTACbs1Z0Odmhg0reUYkT6caWAVz4hT0httu35ywF93rTMSJmlWhNcPow2Sg/xMUw
         To8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722877810; x=1723482610;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3Vm7RTkI+DIMvTV9SZKv9h44j1LiwZRgcrWeULEdC4=;
        b=TDYmUqzGPdSutTnZG1BANFn+kDUZJN0D9Vn+ltVnNYHmYciPu3B76mWXaW31M/fl/Y
         UtvMES1nCyJ/u3yOK2nP1Us/sZoidMzxrAjbmLFCbqsxs3+i+ULw5y9JoTrrhKoaU3B1
         bKh2doOJXWUQJQJ9MLxQtMkeX3uyhmPVVbVVpgeoBkt48MYiOVUfjbugMrlnfb0MGngK
         KoKJHkc5Wsve35axbf/chcJCGVs3JN1wjawx5eUiSQZCjiEC3NXvoaVxIv++pQONW31K
         yRCmv6c9cTkTwyMHJxhZWoGs8bCarzhJUSXPw3Q03kHyLtk13eDVgkknylnD4zWVMjFo
         tKUA==
X-Gm-Message-State: AOJu0YwWCFEUwaD/uD8F2UFZKZuS8Lh7zzXBBgKz+zZOe0pB5eqqX3LC
	EckTsPo8GjSamPUXGb9yTNZTbvcKXskJhx36A05Se4qvlsFmzI42Ybjulg==
X-Google-Smtp-Source: AGHT+IFfvhGLODrIHzmieYOCrMOwA8/33ifeXfz7B6yzDU4c4uxgmlAfqQKeottWDbAYanOgAbeBoQ==
X-Received: by 2002:a05:600c:3b0d:b0:428:387:79ac with SMTP id 5b1f17b1804b1-428e6aea8femr88647655e9.6.1722877809204;
        Mon, 05 Aug 2024 10:10:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6d6b935sm144962265e9.6.2024.08.05.10.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:10:08 -0700 (PDT)
Message-Id: <pull.1756.v3.git.git.1722877808.gitgitgadget@gmail.com>
In-Reply-To: <pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
References: <pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
From: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 Aug 2024 17:10:06 +0000
Subject: [PATCH v3 0/2] Small fixes for issues detected during internal CI runs
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Kyle Lippincott <spectral@google.com>

I'm attempting to get the git test suite running automatically during our
weekly import. I have this mostly working, including with Address Sanitizer
and Memory Sanitizer, but ran into a few issues:

 * several tests were failing due to strbuf_getcwd not clearing errno on
   success after it internally looped due to the path being >128 bytes. This
   is resolved in depth; though either one of the commits alone would
   resolve our issues:
   * modify locations that call strtoX and check for ERANGE to set errno =
     0; prior to calling the conversion function. This is the typical way
     that these functions are invoked, and may indicate that we want
     compatibility helpers in git-compat-util.h to ensure that this happens
     correctly (and add these functions to the banned list).
   * have strbuf_getcwd set errno = 0; prior to a successful exit. This
     isn't very common for most functions in the codebase, but some other
     examples of this were found.
 * t6421-merge-partial-clone.sh had >10% flakiness. This is due to our build
   system using paths that contain a 64-hex-char hash, which had a 12.5%
   chance of containing the substring d0.

Kyle Lippincott (2):
  set errno=0 before strtoX calls
  t6421: fix test to work when repo dir contains d0

 builtin/get-tar-commit-id.c    |  1 +
 ref-filter.c                   |  1 +
 t/helper/test-json-writer.c    |  2 ++
 t/helper/test-trace2.c         |  1 +
 t/t6421-merge-partial-clone.sh | 15 +++++++++------
 5 files changed, 14 insertions(+), 6 deletions(-)


base-commit: e559c4bf1a306cf5814418d318cc0fea070da3c7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1756%2Fspectral54%2Fstrbuf_getcwd-clear-errno-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1756/spectral54/strbuf_getcwd-clear-errno-v3
Pull-Request: https://github.com/git/git/pull/1756

Range-diff vs v2:

 1:  4dbd0bec40a = 1:  4dbd0bec40a set errno=0 before strtoX calls
 2:  0ed09e9abb8 < -:  ----------- strbuf: set errno to 0 after strbuf_getcwd
 3:  818dc9e6b3e = 2:  96984c4a15e t6421: fix test to work when repo dir contains d0

-- 
gitgitgadget
