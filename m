Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmgszBjS"
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07BFEB
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 22:41:27 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3332efd75c9so2067318f8f.2
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 22:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701585685; x=1702190485; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFKpsdp2o3YTXIe4JCGPsqVbXJJnbQVjI8qM+BqcSMc=;
        b=LmgszBjSmMsnAo8Mt9eVVmnRpIV5T1FZ52LRcvKpmfyAbJNiGcvmKy/qSsX/BQWwTM
         cRchRsOf6lrUAwUV1TUJoYAWPUowLze0ALX+bPObmjVasPkarUGp9mlj7PKBz1Z4wWqF
         pX/3av5ydLyT3oUB1bgnlwlfVybwjfqxL8YmrVCenQtfFgUU+D/yVtrqbS/iLKyIQv8V
         IH9dndPLfrI6CuhZVE7KooiFLKN9cqpDCKoYXygfam8xE4IncSiX8BAOHna780ukD/tj
         Ih0MwNW2evlm5e6awcYQ059v0EVb9usOudF2pHrw+U2hTDbX1lmjF8u0i8Wq7jKwTPi/
         4DYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701585685; x=1702190485;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFKpsdp2o3YTXIe4JCGPsqVbXJJnbQVjI8qM+BqcSMc=;
        b=dEydykwc8N6rnmtJhAlnG7OV0PSbgdL1NFUf6QdwYOkM/eI56vbBX9GSLzN5nmOpnR
         Eo69xNPi4Ybf2AR8n+UySA3co9q0RsTFfUT7b2fp8DJvyLYDEP0HET3eEMfcLgNnQkxH
         ImeE8Vgz2VVC1VtutvHrzNU2YpQ4DuBTC+Rx6yZLXi3LqFyYIqJKn47vbL2Cd65ioQKh
         5BJKmKmIDCSDLME2QK9T5Cibftm1+DCQBxa0crvha+lxUwG//7UJUTwqn8HGRhhJL1Rw
         8abnAOzoX5ybo3y4py31wWgZZ3Ckx7VFcnlxAK3FR8vVWW/zXsQZ3d0KdNy6POm8hnPu
         9FDg==
X-Gm-Message-State: AOJu0Yze6BTaTQBGnMaDlCownN1BGdTmCGQ93KtKXT4GAeiCvSROrgK4
	czP5gfN7oFHWUjXI2pCWOGOQeyl+aFQ=
X-Google-Smtp-Source: AGHT+IFSgjV4iw5r2I2iiHTtFYTyVLgTyGEEa5aIuy9zrECPM+3XLG3UPgwPVZtS5D0cMykKuv1cNw==
X-Received: by 2002:adf:f509:0:b0:333:3117:c45a with SMTP id q9-20020adff509000000b003333117c45amr1229534wro.235.1701585685246;
        Sat, 02 Dec 2023 22:41:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d5909000000b003333bd63792sm2869706wrd.117.2023.12.02.22.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 22:41:25 -0800 (PST)
Message-ID: <2f8ff69314e6fbff828ea63eae2362fc6e3dea25.1701585682.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 06:41:10 +0000
Subject: [PATCH 01/12] treewide: remove unnecessary includes from header files
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

There are three kinds of unnecessary includes:
  * includes which aren't directly needed, but which include some other
    forgotten include
  * includes which could be replaced by a simple forward declaration of
    some structs
  * includes which aren't needed at all

Remove the third kind of include.  Subsequent commits (and a subsequent
series) will work on removing some of the other kinds of includes.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 fetch-pack.h       | 1 -
 midx.h             | 1 -
 ref-filter.h       | 1 -
 submodule-config.h | 1 -
 4 files changed, 4 deletions(-)

diff --git a/fetch-pack.h b/fetch-pack.h
index 8c7752fc821..6775d265175 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -2,7 +2,6 @@
 #define FETCH_PACK_H
 
 #include "string-list.h"
-#include "run-command.h"
 #include "protocol.h"
 #include "list-objects-filter-options.h"
 #include "oidset.h"
diff --git a/midx.h b/midx.h
index a5d98919c85..eb57a37519c 100644
--- a/midx.h
+++ b/midx.h
@@ -1,7 +1,6 @@
 #ifndef MIDX_H
 #define MIDX_H
 
-#include "repository.h"
 #include "string-list.h"
 
 struct object_id;
diff --git a/ref-filter.h b/ref-filter.h
index 1524bc463a5..4ecb6ab1c60 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -3,7 +3,6 @@
 
 #include "gettext.h"
 #include "oid-array.h"
-#include "refs.h"
 #include "commit.h"
 #include "string-list.h"
 #include "strvec.h"
diff --git a/submodule-config.h b/submodule-config.h
index 2a37689cc27..e8164cca3e4 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -2,7 +2,6 @@
 #define SUBMODULE_CONFIG_CACHE_H
 
 #include "config.h"
-#include "hashmap.h"
 #include "submodule.h"
 #include "strbuf.h"
 #include "tree-walk.h"
-- 
gitgitgadget

