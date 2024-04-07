Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400785EE8D
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495514; cv=none; b=Of33CzjFBA5Ht+DDnPWq88Iic5rKRO2ZyzdHO9cpeGDkOWhETne6NkGGbeGd5SR8AseJXZgAzfoo8SRfOQUk0ubKz+3mVxMrlXRJURaX1xiZYoW9YK9/HJV84V5FAnur31M/l2HunNLshgm+Rv6QzEJU1q0SJ5yIVZ5ZlstnE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495514; c=relaxed/simple;
	bh=4qjjrVTJHduu4K776d34OouqqRMyncLLt7Ljf2SmeHI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=kNWW1f5U+W2xp1ztuVYrmG82djDHkkptVlOtVP72lJ1/9sQnt7ToGcIOOdf7KXFFmMqxayvLkCSNG2S6OwUMiBkegqCwR5wEktObSZ4LmM69c7z3PUnpplf7Kdbfl+96ljLR0HrR7whAs9F2tujuFxyiOX8hhMmzRK5U+tgC5VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ke0C4eiu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ke0C4eiu"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-415446af364so26632395e9.0
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 06:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712495510; x=1713100310; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1vwYem2K/5eaLuk/nWfdkaaDmKGgP6WavDkws8Cwhc=;
        b=Ke0C4eiuzEHVwNsrZUqWlpz7Td0n6OTH+Orjstm7E5GAR62FNVklJ5VYrDhBC1aiYg
         F+KdiayykkQDEDiZPxbgPcD8qAfZuCcKEodDsNrTS+6po7sam7RoGvio0kYI9n7oHNs+
         gv2ORkTALPLHOkI1Bh6U8Wp0MNQ4jxOBTwR20OryScGFRGcv08oCQxlCtLspBda5EK62
         OjXJPrTELTI7lZ8JflmGVGBGgncoVxjtm2U6+gbX+rSFKxiLJr7fCTK/XgfQCfvvgio0
         HhAGSK5BxeL9ubsn5joHU26jEg7lYdzPimaozCFVLrlmgjW2tOal4f4zFAZ7dzika3IM
         ecXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712495510; x=1713100310;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1vwYem2K/5eaLuk/nWfdkaaDmKGgP6WavDkws8Cwhc=;
        b=epD9BeSzC64DY3R+O7T1nXlCZsk4nUwd5fckjhoMIS+xLmIW779PtYw2WUkL4p3iQ2
         nhfpfP4/vRVrJT9vlBDLRqr4/uC0I2fB3q4XeUCsxvfqi4+NXpB9JOpyVIedtafdb8eT
         FsGn0HpdaoTunBhC1l6Bnprk6wlbVAegPgnmxD271ZLdKm8xzdSw9BYsP16JvETt1OHG
         72CRj/SrjgNNmlPTOtN1n/tRbS3bK3/fT44cSPHRgIdJRmxTeeG+dlDgW/U4IzCTa4eh
         d0F7eB7UzZMq+YHpdmZOvl9fEu9yR8RyAhaunXFM1i3A2G3fqtsNpIY5ndgZzIL17Y/8
         67+Q==
X-Gm-Message-State: AOJu0YzlyRx6xmA/2tjIo0gyb4mrZ4+Q97iQVjmjWVq4NZCoziNPUXGb
	3MLAw0KvgQZ40ZJovS6uDX6Knl/IHi5tnuCKslwVovc88C7EKzUmgWTPj7ER
X-Google-Smtp-Source: AGHT+IHGj0rM69MGP/QuBDcirAwo6fJHYZT8Mu/aFbouma9Fv4oCcUL9TYMsNkbQ88xgnZxoU+h8qA==
X-Received: by 2002:a05:6000:4020:b0:345:811b:466e with SMTP id cp32-20020a056000402000b00345811b466emr1660878wrb.26.1712495509227;
        Sun, 07 Apr 2024 06:11:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10-20020adff58a000000b0034349225fbcsm6579433wro.114.2024.04.07.06.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 06:11:48 -0700 (PDT)
Message-Id: <pull.1711.git.1712495507815.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Apr 2024 13:11:47 +0000
Subject: [PATCH] midx: disable replace objects
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
Cc: blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

We observed a series of clone failures arose in a specific set of
repositories after we fully enabled the MIDX bitmap feature within our
Codebase service. These failures were accompanied with error messages
such as:

  fatal: did not receive expected object ...
  fatal: fetch-pack: invalid index-pack output

Temporarily disabling the MIDX feature eliminated the reported issues.
After some investigation we found that all repositories experiencing
failures contain replace references, which seem to be improperly
acknowledged by the MIDX bitmap generation logic. During cloning or
fetching, git-pack-objects, which may make use of MIDX bitmap to find
objects to pack, would give wrong objects even if we explicitly
specified not to enable replace refs by GIT_NO_REPLACE_OBJECTS=1.
Indeed, this issue appears to have persisted since the introduction of
MIDX.

This patch updates the MIDX logic to disable replace objects during
operations, mirroring the handling seen in single pack index scenarios,
i.e. git-index-pack and git-pack-objects. The added test uses
git-rev-list to give a more intuitive check.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
    midx: disable replace objects

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1711%2Fblanet%2Fxx%2Fmidx-ignore-replace-objects-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1711/blanet/xx/midx-ignore-replace-objects-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1711

 builtin/multi-pack-index.c    |  3 +++
 t/t5326-multi-pack-bitmaps.sh | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index a72aebecaa2..8360932d2e7 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -8,6 +8,7 @@
 #include "strbuf.h"
 #include "trace2.h"
 #include "object-store-ll.h"
+#include "replace-object.h"
 
 #define BUILTIN_MIDX_WRITE_USAGE \
 	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]" \
@@ -273,6 +274,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	};
 	struct option *options = parse_options_concat(builtin_multi_pack_index_options, common_opts);
 
+	disable_replace_refs();
+
 	git_config(git_default_config, NULL);
 
 	if (the_repository &&
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 70d1b58709a..5e4cdef6a8b 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -434,6 +434,30 @@ test_expect_success 'tagged commits are selected for bitmapping' '
 	)
 '
 
+test_expect_success 'do not follow replace objects for MIDX bitmap' '
+	rm -fr repo &&
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit A &&
+		A=$(git rev-parse HEAD) &&
+		test_commit B &&
+		B=$(git rev-parse HEAD) &&
+		git checkout --orphan=orphan $A &&
+		test_commit orphan &&
+		C=$(git rev-parse HEAD) &&
+		git rev-list --objects --no-object-names $B |sort >expected &&
+
+		git replace $A $C &&
+		git repack -ad &&
+		git multi-pack-index write --bitmap &&
+		git rev-list --objects --no-object-names --use-bitmap-index $B |sort >actual &&
+		test_cmp expected actual
+	)
+'
+
 corrupt_file () {
 	chmod a+w "$1" &&
 	printf "bogus" | dd of="$1" bs=1 seek="12" conv=notrunc

base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
-- 
gitgitgadget
