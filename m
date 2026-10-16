Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870FE1E0E14
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117751; cv=none; b=kRoFSXjhhArWuHI3SP6xmIqwzte/AiwNK5nCbDeY+xTbnAi+LaVyzhEjnkMi0S0QFlJZFFVtWclPN+pF6ZlT+7vK1JKQ0uV915OaozOSGh/GHfaRxmT1duRp0mEiDSjO3xs7VCblLTF8luGVCQ5gt5r+LBHj/LSiiV3TmBBanpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117751; c=relaxed/simple;
	bh=WhpOIFCr6rI81ghCm6VOkXgftnwac2YDwNO6Mxpk74E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PVZrAZkj9pQfBEW0DFPhSc9BQXyWegTIiaGzOMWWlIp04gXvyy63G+WflGT18Efy+3zk3o0apHwTuhpPBBRJ7tLoFe/xvHRWYUsjneNxVKL66WzIn4RqZu5qetRLrakXgWEU3K7HFGsbgtp2ZNlXByH9VL5rS/qLftpPFj+UU2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVWcVi8K; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVWcVi8K"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4b190cdc9feso3678544b6e.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 19:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792117749; x=1792722549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MdsoSSziCUD3qxrZABX2+evRXWaI9/r9cerHlsFIuLE=;
        b=nVWcVi8KwoU7Jk+rlyx275k/md3LoJaYV0r7X8liHur0S1KNht1xH7JTFBvwTazeKf
         m5GmjJ1N4Z0QG+3ZDAj732mDs/TSayPLDHRSM8qNUGGIf8tKv2Hc5lBGsqW4liVekOLo
         z0tOI+pzWx7VEmZ6oYcvfqYNqmKSkL4s1qwr/lzxjs9gr2FNBAk89I8Kdy4W5Z7QbwLP
         X8aLZEcZcDopG96Nov65pM7I1eWJnmoThGPU+B813jclVUdFgW5BT/SPHpVDz9cGEkb9
         0hrQPS352Y+++QQpfP2zCsYdWhCjyy7jy+uDS4z3xlOGbTxbczUZoeOurBTJcCVyhZaH
         QTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117749; x=1792722549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MdsoSSziCUD3qxrZABX2+evRXWaI9/r9cerHlsFIuLE=;
        b=ULn1oPb7TlDKprdQhIqM1+piLysOiJ/0pe9F5MT2iV18KHlykgcyYcqS+hCw+lrwO5
         /Cu1QLxUWRdgR/mPsxWvnKOYnsh7Uv9VjxPkZDWC6FxwBJeNCMdsrrlCwM29Aq/cA5Wt
         TVR2jgJWI/KAwR750c8e5sBgDdbkyuOr5QO+b7LvWZthWtY+couAJvn5bKd7CSRhmVFD
         3zW7r9I8jO6tX5SqDGghfOUh6yuZyidY3dhoIjG3y7gMusZPOp2QM0d161fk7Cb0duqK
         tmsKrHFv4f1kYG2cxYdfqoknKDd2/ykJD5SoLth+EHYPtwuw/1ilz9c0dJ5SYkrR3d3K
         429Q==
X-Gm-Message-State: AFq9FYJiRKc7Se4xE1h1BHx4X1oYE89NmuF/Nj8mBCap4ftl6ZTq2Lri
	PqxVslnDpyV7SxdnU6cVmTSNWBGDNCbGxAScgiZTQeMKUGBWLY6TPlBfPEpsJQ==
X-Gm-Gg: AYBFou3+GdM2zu5rE7qvIKKRGONeBsjWUGhZt96dFS5o4lQ0/MgPBvmjWG+Hmd8WLCt
	VAQCZNCNoyqUqN4Ok6EVMa8r3FUGMFFo2Ue9M+GY7T32gkuIaf+MVmFB4NsgBjZJm6H81Pj8lA4
	1pFJXfBO1lyWKsG41h2YLWhp5fGvYuDoiA8X4ushc3ZGJeP8p3ufepWObzNmcZcAGGfGSaLu7dv
	ZsrV5kPbEOvbeCZy8h/JVYiEc8nM0upxx+IEcrrJsNYL91QAJYCoQJhvEjp7zvZqhkT8Y9AE1dj
	OfcclW0b/qjxz484Jb7qhxUW6Al6ONi4M0fZag6AFmK7+rRonOoOZmEuPHCRuI1OAQ/4adH/dgX
	2KPCbSGE0mH/kCJkVKilJR5o1JAXguPuOSyWbRhckEwXKPWbcERdyB44Vo75uMdqseRyaxdc0bV
	tbjNi5N86263Mvod+mKZJQZTGuXMRSciinaj25kk0riLbhkL3jnBmUG301ts2FzcXkNg2tR6u6n
	1aW68EjJb6pDBVBKUpEexs2u89zMQNqtGcg3g==
X-Received: by 2002:a05:6808:1918:b0:4f4:3f10:830d with SMTP id 5614622812f47-50c5b27c152mr21956290b6e.53.1792117749257;
        Thu, 15 Oct 2026 19:29:09 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388a5572a9sm506284b6e.4.2026.10.15.19.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:29:08 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/3] object-file: fix ".keep" lockfile ownership in ODB transactions
Date: Thu, 15 Oct 2026 21:28:58 -0500
Message-ID: <20261016022901.3838402-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

This series addresses a bug report[1] regarding a git-receive-pack(1)
process deleting ".keep" lockfiles of with the same name but from
another concurrent git-receive-pack(1) process receiving an identical
packfile. Deleting the ".keep" lockfile for another process leaves its
newly written packfile vulnerable to deletion by another concurrent
housekeeping process.

The root of the problem here is that the temporary ".keep" lockfiles are
generated and registered in the object quarantine prior to being written
in the primary ODB. This means that even if the ODB transaction never
commits and exits early, the tempfile atexit(3) handler still runs and
tries to delete the lockfile at its expected final location. This
blindly deletes any file matching regardless of whether is was created
by the process.

The first two patches are some preparatory changes so that
`odb_transaction_files_write_pack()` is able to start explicitly
creating the lockfiles without relying on git-index-pack(1). Patch three
migrates lockfile generation to happen during ODB transaction commit to
ensure the lockfile is actually able to be written before registering it
as a tempfile.

Thanks,
-Justin

[1]: <932e8e425aecfbd33c1e5caf66c80a0226abacba.1789385483.git.gitgitgadget@gmail.com>

Justin Tobler (3):
  pack-write: lift and expose index-pack report parsing
  object-file: explicitly write ".keep" lockfile
  object-file: write ".keep" lockfiles during transaction commit

 object-file.c              | 117 +++++++++++++++++++++++++++++--------
 pack-write.c               |  69 ++++++++++++++++------
 pack.h                     |  10 ++++
 t/t5547-push-quarantine.sh |  29 ++++++++-
 4 files changed, 181 insertions(+), 44 deletions(-)


base-commit: f57c9a73884400380bddd172acc88b569834f909
-- 
2.55.0.424.g13c7afec21

