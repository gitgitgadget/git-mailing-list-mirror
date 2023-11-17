Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOp/6TNL"
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B686ED56
	for <git@vger.kernel.org>; Fri, 17 Nov 2023 05:15:19 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3316c6e299eso239760f8f.1
        for <git@vger.kernel.org>; Fri, 17 Nov 2023 05:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700226917; x=1700831717; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KS3NzRUtkzVotQ+FbYCyTN9ZkLd2FaNxwLPaMyKneLw=;
        b=SOp/6TNLMLE+FiYU4veRB0zRdzuGEyw9Hdi0sH9fY4aIF4u/u+4d+LTaIZuipqbOCD
         0LkEKzVpP6nx+hqhA9ZR5znCw+IZpEUnk4Q4OvBrPV5SAJy9zPn2j94UgDDhFvrsF6a6
         Ce693l6TuSIUsuDpy3iTwkdrut4HUtv6PcRKbzpV7Q5UHSdPvkWqbgSt1Vy9BCaMfcN/
         rGyGtRRiV+sK9no29dNmxqJTsLl3PI3D4o6Gc39kj5ek2ahphKBTiStSjSrVYUzc7qFK
         WUT9cQyF1+zkdon9ZRj3XdxChcFtgXN7uGh5zzNpcjfscvONiCyNL5vFbmiqfi+YqaMK
         S7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700226917; x=1700831717;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KS3NzRUtkzVotQ+FbYCyTN9ZkLd2FaNxwLPaMyKneLw=;
        b=CG9yKlzid+W4bXkA+5z6VloCrJTUfpAW2WwbxvS6jFFjBd+Tn+FXgDgxaM5wArLP3l
         8nb0jzkJcGPMfRLqlF0V5vzmIn6vN2mfdENBnzzCwzz7P54qeMrrRXngL88+tiRhzeJ7
         SfIhOOg9HczmeZ8KCrkHLmkJiSbu75uTcSXq+bRnrOs76seLhJS6SQdBKvPN6AnL2cJs
         XzCMH5I3PugqhfEyoaKEB8PDt4iup9C/xC4J14lfmlPeYe1N9jNjQHwvN550bmK9+k1/
         xacJ84zeKKZsAoz08KUyEC3KE89kEaYc8eleTFbBpKKgu9ua/jU8LXFJGZ9r5P0iZf4M
         2s0Q==
X-Gm-Message-State: AOJu0YwKWYlTBuyop6x+HCR9wT+uwbzuIXcECkSnZKNRd7yuG8fs9xfz
	1alN/bxP7mQsQu0kDFTBF2wEr44ISNs=
X-Google-Smtp-Source: AGHT+IF/Bpx8SzsQfcikeImOX8FM4hwcYzrrpR1HfTFAJomivQKeqWtjpvrfWd6AFsZtZ/Ciyex9Wg==
X-Received: by 2002:a5d:4e85:0:b0:32f:7967:aa4d with SMTP id e5-20020a5d4e85000000b0032f7967aa4dmr13809911wru.68.1700226917199;
        Fri, 17 Nov 2023 05:15:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d60cb000000b00331697bbcf5sm2103756wrt.94.2023.11.17.05.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 05:15:16 -0800 (PST)
Message-ID: <pull.1614.git.1700226915859.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 Nov 2023 13:15:15 +0000
Subject: [PATCH] Fix a typo in `each_file_in_pack_dir_fn()`'s declaration
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

One parameter is called `file_pach`. On the face of it, this looks as if
it was supposed to talk about a `path` instead of a `pach`.

However, looking at the way this callback is called, it gets fed the
`d_name` from a directory entry, which provides just the file name, not
the full path. Therefore, let's fix this by calling the parameter
`file_name` instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    packfile.h: fix a typo
    
    I stumbled over this typo yesterday. Nothing about this patch is urgent,
    of course, it can easily wait until v2.43.0 is released.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1614%2Fdscho%2Fpackfile.h-typo-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1614/dscho/packfile.h-typo-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1614

 packfile.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packfile.h b/packfile.h
index c3692308b8d..28c8fd3e39a 100644
--- a/packfile.h
+++ b/packfile.h
@@ -54,7 +54,7 @@ const char *pack_basename(struct packed_git *p);
 struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
 typedef void each_file_in_pack_dir_fn(const char *full_path, size_t full_path_len,
-				      const char *file_pach, void *data);
+				      const char *file_name, void *data);
 void for_each_file_in_pack_dir(const char *objdir,
 			       each_file_in_pack_dir_fn fn,
 			       void *data);

base-commit: cfb8a6e9a93adbe81efca66e6110c9b4d2e57169
-- 
gitgitgadget
