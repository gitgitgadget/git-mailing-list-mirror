Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7742A1D54D
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947144; cv=none; b=mzmWiTeF7FOrn25KC2I6/sRsWaz+GQKOnvYAkwZ6V028o1+LRyzV6ImOGEAXKo0CAE1kw+gxVvOuNdYkJRs9/tHeNxYMoeeNgtkPepgO36ZoGy0mhuoXRSz2AdkNzTcykXmxyKjiViLeU8o5k9j+m8jE8Fty3lcVrONLwfKPwRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947144; c=relaxed/simple;
	bh=1/MQR/0jcjn9DRjlIrWbMIOUPKNZkF+CAYMXFalwl0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ODpnzh4inc6duJwlwimr+aLEl7MAqIpS4lShx1glVcfOeVDYl/jmlUoiejJR2FqDbVKu4GUDJgghMy6x/HPvTNSwWKeXluKN5qCanIBOg4iEh68GbC+tWTPxHp0SLRAVThUqtEGHAiLkHjUrBRGuISPjNRCiV3JUpUamWk2WwUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ea1N9QeE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea1N9QeE"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412a588c8b4so4221295e9.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 03:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708947141; x=1709551941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=752i568WfZl4sRAC7PCZl5P0a1N32XPl43kJISHp/cw=;
        b=Ea1N9QeEMsJSLsEfn9x1nlL2SQGzgTfG/Ed8E2cYmXD/+Fyhm0GhwpcrNHfWjP9S4V
         cvuMj+p7Nf6iTW/TmO20FfBgxC2WPWcNqpP5H6jE28eujMckeTtNoaVsnnMGDi8K5m1F
         Jz00UPooHIASJ5yRthPwWVJEHm5atxk3ZGP5xrs43v83tO0IEZrN625McsOOSZ4e4P0m
         ugTsALe/9Ccb5HNqeIYvFmc/tJiMTmWzomshMX9UXMTe0amLWz5do+voZiPmqQ6UHFSX
         F0pILH3ODckyJXFozvCNC8ZseFesjIlqmoZkgc6XbDCMyJ1XyqRZw1TuvH2n6wUS512a
         qwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947141; x=1709551941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=752i568WfZl4sRAC7PCZl5P0a1N32XPl43kJISHp/cw=;
        b=ZD/6DG5Azyzu1EQfwgApeAWcfk/7Ooei9RYy9PxtuY8iC60//ZR4jXzSI3+fUZDtmJ
         7yY05EUZQetQWIgp2s4kEbBitrysCEOrkjHfuORKoFNWG6LfgtE1KFiyOU3kS2zgkLmu
         BNO7FsXuH52OK84k68Tq9LN67MWDfdwqzluvbABcdEf31ns+qeOc8LsyZGZ3BXy1ys77
         9FYMw70EL3HO6bTegQwSyBSnNq0/N8KE15rAgMuQPFN29oYvQ93+IKGl2zNzrkMYdSss
         cc+LCg1LEiQXBAPlA6jDic1SwLrD2zSkV4jvoNvJ9SB5paVCNjdVQGT5RY7juYkXD9wQ
         dGCw==
X-Forwarded-Encrypted: i=1; AJvYcCWzrjQDYeD7HD25Uajo2dywHrjXXvU1UqZVytslS4Fr8mtdiAObJvwh14HC7ZFXJk8i68aCJvxhhkdMvBMIjnbELtSr
X-Gm-Message-State: AOJu0YxwhNePl40+YYzzOg0h/k+7gKq8MpXF/FQ33Hu+R0DMdjS6izQr
	DfhSF/fPZVUuiBs5R1gSp15ZFnBmvWPfK4G4b/0d1C5hgrktgPmDYUbgm6Jp
X-Google-Smtp-Source: AGHT+IHh9vnuxIzOFqlcc7RFStgL32U1uHDCogcfqjydnS0Hf2XjSNtRoq0JInJHFuxKJ4avvNuAfw==
X-Received: by 2002:a05:600c:3151:b0:412:a0bb:55df with SMTP id h17-20020a05600c315100b00412a0bb55dfmr3570857wmo.15.1708947140586;
        Mon, 26 Feb 2024 03:32:20 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ec0c:62c0:a3b:6b59:debb:debf])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b00412a466f0c3sm3543379wmo.15.2024.02.26.03.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:32:20 -0800 (PST)
From: Gabriel de Perthuis <g2p.code@gmail.com>
To: g2p.code@gmail.com,
	git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH] replay: Fix documentation of the --contained flag
Date: Mon, 26 Feb 2024 12:32:15 +0100
Message-ID: <20240226-fix-replay-docs-v1-1-a5f8bf08414a@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708946205; l=1457; i=g2p.code@gmail.com; s=20240226; h=from:subject:message-id; bh=1/MQR/0jcjn9DRjlIrWbMIOUPKNZkF+CAYMXFalwl0k=; b=UyB2XGO8X0QXUpx0hedUkh2X0At8Dk26NvRUYihl3UtdLab9NQNIBdkbaNzVwr4xdWzCupD+X xUieJTtYhwdDvxzor4d0ocFpVts6RNi34S6ENmC2b+4Z6vImfzSyiqa
X-Developer-Key: i=g2p.code@gmail.com; a=ed25519; pk=iNCUUSsYvx8i030j8RjSUXbvD9xNTnyXfNZ/i7Y+cQk=
Content-Transfer-Encoding: 8bit

There was a paragraph describing the behaviour of that flag (which
affects branches and refs), but referring to it as --onto.
--contained is used with --onto but it is a more specific flag.
--onto by itself refers to a commit and does not have the described
effect on branches.

Signed-off-by: Gabriel de Perthuis <g2p.code@gmail.com>
---
 Documentation/git-replay.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-replay.txt b/Documentation/git-replay.txt
index f6c269c62d..ab28e86a4a 100644
--- a/Documentation/git-replay.txt
+++ b/Documentation/git-replay.txt
@@ -27,12 +27,12 @@ OPTIONS
 
 --onto <newbase>::
 	Starting point at which to create the new commits.  May be any
 	valid commit, and not just an existing branch name.
 +
-When `--onto` is specified, the update-ref command(s) in the output will
-update the branch(es) in the revision range to point at the new
+When `--contained` is specified, the update-ref command(s) in the output will
+update any branch(es) pointing within the revision range to point at the new
 commits, similar to the way how `git rebase --update-refs` updates
 multiple branches in the affected range.
 
 --advance <branch>::
 	Starting point at which to create the new commits; must be a

---
base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
change-id: 20240226-fix-replay-docs-70a54ea9e3c8

Best regards,
-- 
Gabriel de Perthuis

