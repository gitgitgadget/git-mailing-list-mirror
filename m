Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDFF17588
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724356237; cv=none; b=NIb3yMYLLEu1ltFVURAKn8Uo4s8qTlXC/tnO7A6sdSpVhOjCt1NNdkJ2TqoYwRXxfSHJmAHh86IRM0qnG9cTCmnq8+8vKeql95bdOtKr9ifXrv4ktJbg/jjyppNr/kHW2jMYkbEtjTuL9mhjYXQ3WJPQatSI+lkmSfVsAmFiYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724356237; c=relaxed/simple;
	bh=MZJUjDEyuqm0og0j8KQ0KkAo5+l212rElWXzSDxYXHU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=d6RmqcYds7+cpOgytJK361gTEHcifebBHkSEgLxIMEC8SyyyoC0T8gHZ4509TgoifYyxtt7XorWcIqhtrPzlQlg4HjbVeZB571lEc+MQQLEL7I5MdyvmfOCBv063c6/gUvwbKF0vJcrB5FGCjVWnzSF4VSSbUxcTuNd5tKkeNwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqPq9XEW; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqPq9XEW"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f4f24263acso8119611fa.0
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 12:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724356234; x=1724961034; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWxEtQr2J/kaWTJIPOmF5FqpOdNvSUmbCKLrCxCnmyY=;
        b=kqPq9XEWvNxkXD7k03yAb3B0dSOazPOjff/s8Rt9gmCWir7oc7KWHHK5ERYi5E5TiI
         k7YVkBhje7TF6XmNM07TRmgJEHsVwleZK+gMjXGcb7kLHGP+5zzayn6jdnoRAadXWLNg
         U4HBoOkmrpqp0m1Pto5gSGYxzfTaHZ62zkzsJAAowEXSBPIL7zyN5Hkc68YXo1wLOaP5
         7TaFivhyanQk4IRmrGj/I/gG7rckb8MAIl4xEXT9MkqCAaKpVyAhYcG6uYxEkduIjthl
         GW1xjNioIUzdqBXSh8FdU5bmFly14b17HguDz8H40SXuJxAWYdTlVhebc7K45dsjyDrm
         mSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724356234; x=1724961034;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWxEtQr2J/kaWTJIPOmF5FqpOdNvSUmbCKLrCxCnmyY=;
        b=n/dCe+RVr6PKy/P+ERmww0tLP0tG67AW8uryq4PpNutxUiK65iLVs51UtkF1cZRyRI
         M3XT9PElMD1dUFz5X+KQMVE7EBmhgJduNGFwLSJjiniB3ytDGZORWplcaXXz8O0NVjNl
         WAsjV18vruTQOfcLyAXQggbMKnR4utqomVe7F0rKfJZh1iFgJIuFCZboil4QBssKlkVL
         PqTN4q31SQwqeMtTpNSywmeChlfQO07yneqnZl6fMOlYYPjpTC0OTfHHeEe1/W+AwgJU
         5dMZfGg/72A+8r1Ke9BnXum4Q4AqeT0wsCVWSgnIlRPoCWRCA38c6TQFNRGaM4ZPg7T9
         M+gQ==
X-Gm-Message-State: AOJu0Yx1VzUddjWJO8x1gFUUFF8Ej9HyUGXk+teSJhGbxOk4b3js65LH
	DK4cKZckyFIGR4JJ8WGKqKudmgUfTmAmHxtpV9xXZOCJr6WF0od/jbzESQ==
X-Google-Smtp-Source: AGHT+IHXCRyUB7IT3CVMqDGGErBk97P9Iwa3sf0oPGv9vNBgYSyT2qbPbjMNvnFe9O+9rTImx3LWDA==
X-Received: by 2002:a05:6512:1094:b0:533:71f:3a3d with SMTP id 2adb3069b0e04-534388473f6mr8946e87.24.1724356232986;
        Thu, 22 Aug 2024 12:50:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436cb9sm157278766b.121.2024.08.22.12.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 12:50:32 -0700 (PDT)
Message-Id: <pull.1768.v3.git.git.1724356231639.gitgitgadget@gmail.com>
In-Reply-To: <pull.1768.v2.git.git.1724234729288.gitgitgadget@gmail.com>
References: <pull.1768.v2.git.git.1724234729288.gitgitgadget@gmail.com>
From: "ahmed akef via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Aug 2024 19:50:31 +0000
Subject: [PATCH v3] docs: explain the order of output in the batched mode of
 git-cat-file(1)
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
Cc: ahmed akef <aemed.akef.1@gmail.com>,
    ahmed akef <aemed.akef.1@gmail.com>

From: ahmed akef <aemed.akef.1@gmail.com>

The batched mode of git-cat-file(1) reads multiple objects from stdin
and prints their respective contents to stdout.
The order in which those objects are printed is not documented
and may not be immediately obvious to the user.
Document it.

Signed-off-by: ahmed akef <aemed.akef.1@gmail.com>
---
    docs: explain the order of output in The batched mode of git-cat-file(1)
    
    this is the same change as https://github.com/git/git/pull/1761 but due
    to missteps, the PR got closed and I couldn't fix it, also applied the
    review comments from @pks-t
    cc: Patrick Steinhardt ps@pks.im

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1768%2Fahmedakef%2Fexplain-the-order-of-output-in-cat-file-batch-operations-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1768/ahmedakef/explain-the-order-of-output-in-cat-file-batch-operations-v3
Pull-Request: https://github.com/git/git/pull/1768

Range-diff vs v2:

 1:  3f742957aa1 ! 1:  6adeb2c7bb3 docs: explain the order of output in the batched mode of git-cat-file(1)
     @@ Documentation/git-cat-file.txt: BATCH OUTPUT
      -the whole line is considered as an object, as if it were fed to
      -linkgit:git-rev-parse[1].
      +from stdin, one per line, and print information about them in the same
     -+order as they have been read from stdin. By default, the whole line is
     ++order as they have been read. By default, the whole line is
      +considered as an object, as if it were fed to linkgit:git-rev-parse[1].
       
       When `--batch-command` is given, `cat-file` will read commands from stdin,


 Documentation/git-cat-file.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index bd95a6c10a7..d5890ae3686 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -270,9 +270,9 @@ BATCH OUTPUT
 ------------
 
 If `--batch` or `--batch-check` is given, `cat-file` will read objects
-from stdin, one per line, and print information about them. By default,
-the whole line is considered as an object, as if it were fed to
-linkgit:git-rev-parse[1].
+from stdin, one per line, and print information about them in the same
+order as they have been read. By default, the whole line is
+considered as an object, as if it were fed to linkgit:git-rev-parse[1].
 
 When `--batch-command` is given, `cat-file` will read commands from stdin,
 one per line, and print information based on the command given. With

base-commit: 80ccd8a2602820fdf896a8e8894305225f86f61d
-- 
gitgitgadget
