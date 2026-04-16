Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801C17A30A
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 03:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776310377; cv=none; b=j6DuH8prF6rXyca2sZVz6gRH3e7rwQuoviU7gD4IngM3xcwysFJWhd6JSeCPwlnplcDsS4CJvx62nuSDa40hVSqhx3FHm1isD27krZUQQ+4Pr59fXphUpEdIarSIl02fVwCyQdmFPzLoKja9bTopH2PNG0RUufZlx0VVOw6Oqo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776310377; c=relaxed/simple;
	bh=QtYoMyRSBFJLhZORIKqjMv4QdD79SX8hrQtpM+ZqdIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3AfZqzEZZk9wnzAcBu1f8o+YxB1SQIVlVhYqmigkwhDHjKpqW4lKGJr07fYQuq4BkqA9VqKpgtZpxTSIIsch/j3M7yECs/FqmRHjpKIqyqPc1JKjuHDlspsnmpZdDnZB9QGOAbSgVMk+1vRZqHpeQ+Ac+AcpxF4p1ytHS7m0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l96QRRi/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l96QRRi/"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82d0b68837aso4104067b3a.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 20:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776310375; x=1776915175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYAYczqqQwj6k62PLJ+ag2/K4t3wBDgXxWfOVHZWqyc=;
        b=l96QRRi/UC+YgHdAzerfP3Zptq25qmypP3DwxsgLwMkQP/6hK51v/Bz+cY32tjr7El
         ZKklAlWNZ13cDQhgHwLpSMmTI/pF/56jnmgvk64ZlHVmvsYQyOAUfsXj2nFXTRckKW+l
         EXdFkLVvO/eOhHGPC4JAxvbzqZl3WvqAC2xD4GrLwnPSub1x7Jjj9LNGPGyN0tZ1n8Wy
         s48TQklq+Yw4DdIkhw0APwYLKbdB4OyEP5sShYvmF4qImFkmaVFOqfEo6AnFgvWbfmVB
         7pMzSwuIbBUNfZJnXTOB9wtcZSugG6IK/guakVYVgUDws9B2gwMXC5Ha7PZ1o8xhHGHv
         BQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776310375; x=1776915175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYAYczqqQwj6k62PLJ+ag2/K4t3wBDgXxWfOVHZWqyc=;
        b=o0B+ej0LYdWWHJs1ROXlSmYs3Cpbzz0O2UzdWbvhz96RUTh7B02rYKPYuXRgW0Bhvs
         UZMYz/IT6Gdq3ofXVbGnb5mKM0oQg7Tju/heMA7JJVVL09mHT+bZ1XmqTrEARdXUheLf
         t5fGaCf+hXXrM/79mJ0RkJGaa32N0dQjcY7yvsuMz4fuySEhXp7x06ca1B5tv42hR5BD
         dX4Q9yjvWwLCNm8zkPnT999/nHjSvlbyemw94sYf8+KKWWpTGwFial8JwPp8pCxWatr3
         +SEMfpVpygOBxpzr3DjWEb2bDFWuGd9/QLEtqNm9jmV/XaLmbPRaxtQaMKgky1a+VnJ6
         tT0Q==
X-Gm-Message-State: AOJu0Yw5ghV86dl0H96NGyop0bOHeGjm/HT3XjepagG3RSq0WLbHzOFW
	Gy3DMZg8wF/rlonVajACG2jU3u4UpDZ/7pYoVrzxH25mHWT0IWp+qfx2OFx2mg==
X-Gm-Gg: AeBDieus3K7aoDV4JJWcp3xeh4uoURC7PHUMNPMh9QWqIBC0LZp/YpzPVFOZabPWPhq
	eXmfGYfex39lnz211glIGgd3OOQNGyuPhedcWbzWxm3BfPA7dW8ZTKWOwgikVFRP+h8AdxeGcH1
	/gIOexd4h4R4v0MpbNJCleNrn9xH6dBmCyVDApsM6uxklOK2xg8dZFzJamVnw/Bc0at/ulOIfVm
	Ifwr8dMxsQnSn0ALxqrmPihMvlJt8siYvmK5r3mRR445g3LQWgHDKdiiHCW6QzHcjyEA3K5TkDC
	RtopdyqZptsBZlRDkztRFAgG0Fgn5iUXvZMbjMNVNsTxI1qcz1pTfi3OXJdcAwTlYTPKDhvGOBl
	H6wNrUFPQ3MwA2ZRUuthAcuxTnJYjUHZkInErUiUzDTNbxBV652u9CRaVLpZvmxmCY9I13lmK3I
	w0Z9YvOKAutqMqvqEDKg287CQ8HGG85bqxKu1fsRoBoRDEpxA4OC5jZsy2Ew==
X-Received: by 2002:aa7:8289:0:b0:82f:29fe:7239 with SMTP id d2e1a72fcca58-82f29fe8801mr12975754b3a.50.1776310375139;
        Wed, 15 Apr 2026 20:32:55 -0700 (PDT)
Received: from localhost ([2409:40e3:30ab:6862:6400:e3b3:3e97:389e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67449c3asm3680170b3a.53.2026.04.15.20.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 20:32:54 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	christian.couder@gmail.com,
	ps@pks.im,
	gitster@pobox.com,
	toon@iotcl.com,
	jn.avila@free.fr,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v5 0/1] cat-file: add mailmap subcommand to --batch-command
Date: Thu, 16 Apr 2026 09:02:49 +0530
Message-ID: <20260416033250.4327-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415150943.40493-1-siddharthasthana31@gmail.com>
References: <20260415150943.40493-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-cat-file(1)'s --batch-command works with the --use-mailmap option,
but this option needs to be set when the process is created. This means
we cannot change this option mid-operation.

At GitLab, Gitaly keeps interacting with a long-lived git-cat-file
process and it would be useful if --batch-command supported toggling
mailmap dynamically on an existing process.

This patch adds a `mailmap` subcommand to --batch-command that accepts
a boolean argument and toggles mailmap dynamically for subsequent
commands.

The series is based on top of 5361983c07 (The 22nd batch, 2026-03-21).

CI: https://gitlab.com/gitlab-org/git/-/pipelines/2456596910

Changes in v5:
- Simplify documentation: remove the `;;` sub-list describing
  `true`/`false` effects and replace with a single sentence noting
  that mailmap data is read upon the first use and only once.
- Link to v4: https://lore.kernel.org/git/20260415150943.40493-1-siddharthasthana31@gmail.com/T/#m5226263dafcf5c774c080a6688e9af0f402003c0
- Link to v3: https://lore.kernel.org/git/xmqqv7dyoei6.fsf@gitster.g/T/#m0a109f3eb5129e619ecec5f2d58ead0c5a49a4f3
- Link to v2: https://lore.kernel.org/git/xmqqv7dyoei6.fsf@gitster.g/T/#m445eab3b309bded92d1b130d225b882c73988ff2
- Link to v1: https://public-inbox.org/git/a4ec7bfa-f16b-4505-9b37-d3dd137e93cb@gmail.com/T/#m5c62fb6ad0fbcc99a706dba4c78b66359c247acd

Thanks,
Siddharth

---
Siddharth Asthana (1):
  cat-file: add mailmap subcommand to --batch-command

 Documentation/git-cat-file.adoc |   5 ++
 builtin/cat-file.c              |  37 ++++++++++++--
 t/t4203-mailmap.sh              | 105 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+), 4 deletions(-)

Range-diff versus v4:

1:  25ebffe39e ! 1:  b4d6f08b43 cat-file: add mailmap subcommand to --batch-command
    @@ Documentation/git-cat-file.adoc: flush::
     +`mailmap (<bool>)`::
     +	Enable or disable mailmap for subsequent commands. The `<bool>`
     +	argument accepts the same boolean values as linkgit:git-config[1].
    -+	Possible effects are:
    -++
    -+`true`;;
    -+	Mailmap data is loaded on first use and kept in memory until the
    -+	process exits. Passing `true` again does not reload the data.
    -+`false`;;
    -+	Mailmap replacements are disabled for subsequent commands, but data
    -+	already loaded stays in memory.
    ++	The mailmap data is read upon the first use and only once.
      --
      +
      

base-commit: 5361983c075154725be47b65cca9a2421789e410
-- 
2.53.0
