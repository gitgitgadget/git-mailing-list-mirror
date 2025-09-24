Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D22857C2
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749073; cv=none; b=qMblzlAFboii0Z8Kxp1WWZgB+JHZSOcrTJpos1dmMv2N9CoEocp/Zi9qZ6HEd695z+rnwKfL5EW8tR8+DZNUQdkMLHu27S6cljKAVbfrED6BOeRRknjv5MsXlvnjKTNKLQ1duyvJdaaFxSRjiu2Jf+kKr1RMnKg5PRp39UmSpnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749073; c=relaxed/simple;
	bh=XaBJ9GMLZ2nom6jTZzSPgn56cY3LKGumA5k5w+lmWok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQkzmt6Yu/V13s+zcxyFgW6ma6PkrJDF03FlsVaYtjAGxX/aj8FiLFjrm1lzMZhgxZof/75yt2l9LV9WEcVhQ0KNM1fLplfzrlgxE5/oVKt+OYXnu3yNvLFUMvRhrlQX6FqE4fVZsm9drzNrQfGFpn6fk1a66ThVU4b9XLfe0xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZwdp7uw; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZwdp7uw"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-63a1f3c0820so178417eaf.2
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 14:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758749071; x=1759353871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ux8qeUo+oDR/hfiunepROi9ceUwQTroRRENfoZZMnTQ=;
        b=SZwdp7uwUfTWxRJ1OPz3fo5SOKyA/wHDnIVORuEN+cbF7VLPpGLyjvyUHyvavr1ltm
         GDaY5YKX7OfRK5vwUmP+TATyLSXLyu1JAnr6PrgYreJa6tQwNzVez2hF5n8vhWVaZcgh
         HWLHCVk4dxjile+WOq+UxR/0vVPQROHVt7LDJ6ILQaMSFqIusp6ktqnEZX4RXW4kZUFw
         QaHhay/i7YuLUO7LjPyqLLJ358t2T3rF+Xo0PrQzlkzWluSZ+MKgjry4tf/w2JNbxWKw
         lYsraE7j5mGRrVSMrSZ4j3LOHe/x1ih3YaiyjTQy9y4jqqtfLsN/W671yiED+YRAmMmN
         27RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758749071; x=1759353871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ux8qeUo+oDR/hfiunepROi9ceUwQTroRRENfoZZMnTQ=;
        b=qm4G5xIFhT1iLA35Qsgydno7ZoIq+oDnziFXJTRCA62sB9vhIFvTx4uSK0PO0aT/t8
         TzFmDPKEQ0IgQpnNgaaybnV04tgW14z0Y5sTTixNhUwjYrLa9EIO35WCU8a5hDRayxq6
         KInXxa/jx8I/qiUThRPK2Bn77hFbllCLN284IHxXo/6Wug/74RXxOrzzueg/1JP4sjKn
         spEmJsqC3j6mMtekgoP7u1ykn+tiwiyDlI9eK5RSUIAc04XUM2ZxsIIS4AcJOK951Dc5
         dYxDCmWX1Q4ibIyJ6fbipZ7Fd+8Jz3JFB8Q8yIoykX67/QhAHjB80U/2VjLCLkx5egqG
         5Eeg==
X-Gm-Message-State: AOJu0YyRc/jbda4b2xQIVk3cTmVmWoaHwA8c2UhgiMN9BpMfJdLhgcoz
	LW+MHTYpr1JRzm6bOb4AB15unSM4l4KyzCFJToBXvcLcKCsYOIrCn1hJUfYe6g==
X-Gm-Gg: ASbGnctycUJ0/kOjYoct7sdeRpDCbKjqlrXuXvdUvwnqJalkrLK5s8O0nvfJ4Q0BFeV
	Y+ZY7XxXnZUEa4qXfQAskvrRTlbfWK1/7xZPFiLqqB3b0/tNguOmhFigqkWxEpitAnBuLQ+VQMn
	VimSfZm3gdYrexSdy42AvwFnmavACodL8ltn1gJP9O+dhX6QNSGcNE2ZNEVVUwAZYALsu97fYGc
	fl4Ng5KDtXP9GOks3FEzx4ZUSekQ7bksNMIvA+5knMC1ktS3rMYlfs4eGKHnmNyTrNTjZA+D6N3
	RJHTEWyMo7kBfY+vqYa6Q8kUJwcf9WHqHVT8qCnhiOJD/tffLcGm88RSm9pYdHhgS1tBQIL+4/p
	ARflJ8iNsdFgibvvP+6QY64S8i8DMbyE=
X-Google-Smtp-Source: AGHT+IFMTYhti8eutHSzB06DsVrAEAv16FkwpN2iu+PhOkmWcylM+JjXMak+MsAvquf6FibwOzvpCw==
X-Received: by 2002:a05:6808:22a6:b0:43f:4c84:abef with SMTP id 5614622812f47-43f4cbf29c7mr874047b6e.10.1758749070921;
        Wed, 24 Sep 2025 14:24:30 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f46f5dbdcsm400117b6e.12.2025.09.24.14.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 14:24:30 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/6] builtin/repo: introduce stats subcommand
Date: Wed, 24 Sep 2025 16:24:20 -0500
Message-ID: <20250924212426.2930029-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250923025700.3046260-1-jltobler@gmail.com>
References: <20250923025700.3046260-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

The shape of a repository's history can have huge impacts on the
performance and health of the repository itself. Currently, Git lacks a
means to surface key stats/information regarding the shape of a
repository via a single command. Acquiring this information requires
users to be fairly knowledgeable about the structure of a Git repository
and how to identify the relevant data points. To fill this gap,
supplemental tools such as git-sizer(1) have been developed.

To allow users to more readily identify potential issues for a
repository, introduce the "stats" subcommand in git-repo(1) to output
stats for the repository that may be of interest to users. The goal of
this subcommand is to eventually provide similar functionality to
git-sizer(1), but in Git natively.

In this initial version, the "stats" subcommand only surfaces counts of
the various reference and object types in a repository. In a follow-up
series, I would like to introduce additional data points that are
present in git-sizer(1) such as largest objects, combined object sizes
by type, and other general repository shape information.

Some other general features that would be nice to introduce eventually:

- A "level of concern" meter for reported stats. This could indicate to
  users which stats may be worth looking into further.
- Links to OIDs of interesting objects that correspond to certain stats.
- Options to limit which references to use when evaluating the
  repository.

Changes since V1:

- Translatable terms displayed in the table have formatting separated
  out.
- Squashed the `keyvalue` and `nul` output format patches into one.
- Added a progress meter to provide users with more feedback.
- Updated docs to outline to outline reported data in a bulleted list.
- Combined similar tests together to reduce repetitive setup.
- Added patch to improve ref-filter interface so we don't have to create
  a dummy patterns array.
- Many other renames and cleanups to improve patch clarity.

Thanks,
-Justin

Justin Tobler (6):
  builtin/repo: rename repo_info() to cmd_repo_info()
  ref-filter: allow NULL filter pattern
  builtin/repo: introduce stats subcommand
  builtin/repo: add object counts in stats output
  builtin/repo: add keyvalue and nul format for stats
  builtin/repo: add progress meter for stats

 Documentation/git-repo.adoc |  30 +++
 builtin/repo.c              | 354 +++++++++++++++++++++++++++++++++++-
 ref-filter.c                |   4 +-
 t/meson.build               |   1 +
 t/t1901-repo-stats.sh       | 109 +++++++++++
 5 files changed, 493 insertions(+), 5 deletions(-)
 create mode 100755 t/t1901-repo-stats.sh


base-commit: ca2559c1d630eb4f04cdee2328aaf1c768907a9e
-- 
2.51.0.193.g4975ec3473b

