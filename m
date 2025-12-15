Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DFD1DF75B
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765829130; cv=none; b=ka9OP+aMUE/s+ST9GnzIG+u12qjjUoSAzO/7dHQzE/fsCSCH7Hkb61q3rSf7603ein6zz78Hh92jPp0wybCaYe6lqZ7ao0YDn6LQWS2Q1a996CJFze0SJC4OQFu+KKmZ5nhMDaARlUc/vzXy2E5JZcMUoBJ6s3BtGoXx6dyDsQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765829130; c=relaxed/simple;
	bh=Zvoe34S+Dz72gegJiCOua5fVRvBwwzeDjW0ivyWpccg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tq5NlORdgCKm81ayPVSeQgQeyVHCKrXXgdVcV4GidIwi4L+vuRC5++LK13JgVAa+T5KkiZcNJ4fZmW9EQpD758SKMtgdmBiNOaRtHWw2tFp8skEG2dSayWltlP7YvpiNlI3nh+s8yDWLvWOyjHI9wp4MfAykiE5TBeieFFYeMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQNVofOK; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQNVofOK"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c7660192b0so2786992a34.0
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 12:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765829127; x=1766433927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g691Iju60N3k0dqg5oNDPVwTYF7nfEnsjoWkChUfofM=;
        b=FQNVofOKiGbOohOfGYGAfHjVJoTKpkN7vSCfMuggGQCq3TyXqtM+t2b5BmKdVr49RW
         9nxYwUPpEecsg+kV6dNe83xEGe15MhRIyKMa2v+lFVRSF3HJYYyzFLlz1l6syO70zRm1
         CXJutMip0zL1nxk3Y/Cm8fX1jfEGQ7mhCH+TZArGsA5r5W4veTirLB7d6PU/eL1Wp5kT
         CsJYLhPz3jOXwinZBPUM6AlyM5oBO7M2EiqWodhuJUc/mJyT3OAdOWbOBvAgyKlbD+PI
         uP5CQ790Cb3A/3FcuXHQKmyxBuBU/Il2onStx7+I1OISrqcQR253KvdJcA2D3TRbl7Wn
         T9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765829127; x=1766433927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g691Iju60N3k0dqg5oNDPVwTYF7nfEnsjoWkChUfofM=;
        b=FT69gKTxyv+Ifa0+zfH6Z9A51wSkci0vHaMXMulZ9H9vs7DXCs6yIb0WxzD+5dwYEq
         TcVLiu4YwRsNvu2amdgtNF/RFdyoYP+i4wu9SXBMpWg7WBOkOqr6vit7wuXJZg4EH4t/
         E5WDQj9LUiQPio5o8DcJCB/ERSSdGYjiqitsIgyl+p675r0R5WAYbbR+P9B6Uj4LyAC9
         zTluDW6KVVb1mgYcSGSbJfWATP7WP5kJsOj2cEdo+7zUTAI3g7eFXy9UtEKNzE1TDTHK
         ++8uSHyAMvdvicegYpQXajzjjvjbxBMMrwk5l/HnGQ2WQNNi41QF4dUYy7DsyK6nsqpS
         3x2A==
X-Gm-Message-State: AOJu0Yy0EW803ZmPFeHVCZSgYgb/StMbbEerIK7aVi3bCgkUXr3OTe9S
	YVvZBCV6GZ+VunlzsL+0pS4+BIBfAr40ugdwWtmQTyLBiGdKtlf5aT6QJerYHw==
X-Gm-Gg: AY/fxX5IZyo3doxuYbd8/akD8In6ebDoD461kenKbF5bKfSsLRzm2+qIr/CCkTQfHy1
	KyMlvxKrbH3hJV6ffwpuluFaD7IolrfZtswBtGZSnJOg0iLvMQvxxSmZYgkUZa8eNwEfV4QNwfW
	hFB/YxolLrUu6MCiAM0tKvrR/qa0SqHF6dM1xyojhkMtRLOQztCkx79nx+4VyZsfQzUh8Bjswmt
	EtoYgjbW2zfozW7hAgrjRS5jDQEJfEiFF4DZyUasU2FlDAMPZdRVv5DKj3NC/zey9jubxLdsCPo
	se9oPqcW/cgdpp9iyJnOvuvw628zxS60FCVPRHVuRT0xQvqv6sur+JSDlMv0eklOZ5JX4wx6+fn
	0OyrFoptUo1KQ5RBk9mmUuZJ+/1dy7StvVSyX9a2s29X/3nsdMN8x1SywL+u8j5OoMh6ZUWyz+L
	l2De+j0MAUR1tF9ya3fVQ=
X-Google-Smtp-Source: AGHT+IFAhg4Ng91O9KhlsSU+1GCwlyh89I+O45iDbiUqbWf+WCYujnmv3u9edbPg6q+B5OWYRCFgpA==
X-Received: by 2002:a05:6808:5182:b0:44d:a6a8:1b5f with SMTP id 5614622812f47-455ac86056amr5440073b6e.24.1765829127309;
        Mon, 15 Dec 2025 12:05:27 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45598b992d6sm7251353b6e.7.2025.12.15.12.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 12:05:26 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH] docs: clarify git-rev-list(1) --filter behavior
Date: Mon, 15 Dec 2025 14:05:12 -0600
Message-ID: <20251215200512.2694155-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using the --filter option for git-rev-list(1), objects that are
explicitly provided ignore filters and are always printed unless the
--filter-provided-objects option is also specified. Clarify this
behavior in the documentation.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---

Greetings,

This small documentation update is in response to discussion from [1].

Thanks,
-Justin

[1]: <aT-djS-TrQJxxV8i@pks.im>

---
 Documentation/rev-list-options.adoc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index d9665d82c8..453ec59057 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -983,7 +983,9 @@ to name units in KiB, MiB, or GiB.  For example, `blob:limit=1k`
 is the same as 'blob:limit=1024'.
 +
 The form `--filter=object:type=(tag|commit|tree|blob)` omits all objects
-which are not of the requested type.
+which are not of the requested type. Note that explicitly provided objects
+ignore filters and are always printed unless `--filter-provided-objects` is
+also specified.
 +
 The form `--filter=sparse:oid=<blob-ish>` uses a sparse-checkout
 specification contained in the blob (or blob-expression) _<blob-ish>_

base-commit: d8af7cadaa79d5837d73ec949e10b57dedb43e9b
-- 
2.52.0.209.ge85ae279b0

