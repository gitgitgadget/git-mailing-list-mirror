Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965B2080C1
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830596; cv=none; b=SEFSU1rksO5PjF/oRC1XDthf0sg6wdbVSqkvOclBTcYnjCS10g6fBAxygXllwiNtXVotAc71Lw3d+rXR5IKaez8FFkTQwtafcPdDkTBOxghKBkJSIt8V60H+NYuVMXy+f6qDawor1l8+i/t+K7Ez8stQNVQtQiHRGipX/wpfrwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830596; c=relaxed/simple;
	bh=Q6gx3prx5o79szlwXSYzmAi8ze9CQjzAjMt87+VmPRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X1JNEikY7lKY89esoCw/bpSutt/311W2qYX9mjyfjI04NAw/X7d7igf7d3XqmXrZ39x3XSrOZRn0hJsAaGoFEOGKNBpOBNiA9XaPCdHoQ08L7hmPJ5MUvtmewAiLC60Hex0OwBqnOpLXNySRsmkcFxSdwWHqrtYmlrawQrh28as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h++jV1Bw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h++jV1Bw"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725ee27e905so2213075b3a.2
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 03:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733830594; x=1734435394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcxkaU8uPKqOGFxXNbC8ipIMKJSUq2HYp5uR0QBXBDo=;
        b=h++jV1BwDAU6LtuwhUPYeD3B3g0cjOq5xRdhdi3uu/j2hQ6B9OCfwSPiJwE4MpbjnA
         FjQaREzZb74niSOYNqRZF7dPh/dz/sLpzPMNk+nMPSa9UY58Jx7d5w7YldNlQnpWt+u6
         Z8LfqUETT1Q5AzcCCOjE07ApGdvheblixdQnwliVUZdBCif/DiSIgi0/OZMwaWZaG1/8
         nNUI9jceeVnX9gUgNZpzZcoLFNp9TjCtoENf3YWRGV11vRPIgsQSazvAzp6v/n6GmXD9
         A5oQyuGsdaQc/oZyBcFfmPoCTKFvjBiKArwrA4bfyq7aWYRb4Q8LYmGCaG5MZLPejlpJ
         miZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830594; x=1734435394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcxkaU8uPKqOGFxXNbC8ipIMKJSUq2HYp5uR0QBXBDo=;
        b=rE7KkVC+yhemGYN45sP4SMko95XGsZt2J/NyPU3q45m9h9OqEcT4Mt3Uagqnzycw+/
         ciluqLNYcbFFqB/+DZuhUrzxdVpVEeRFwGU7p/Fr78i7axwYjqLcJMRlGb2HK3/1W8cp
         pPbopL+OQiIAJGB4jNqRKnp+/cjDkLnBV7SDWAbktLh891B5Qd5TJXu6AaCTMfVSBtZ5
         vtSnXjcJtAZWPDhgdtzFRDYJ+wWBpm/3ssRxvdesl8nTVmua8D8aEIf+SERmGlRI7lWu
         jYl5EUTDBm8DL4LlL3dQXgcImAsV38X+BsODgqsLXfXdR6hGAroe6EGt2sOR5aBDVOvi
         Ub/w==
X-Gm-Message-State: AOJu0YwCnYMjtTKgIBiBT1BUQ2zqZmm5ejogLvr2TtSxX71i3a0alNg7
	sku1/03R8leDMyjaZvSlCaxakFaW5c57bwsXd2Eyrymz0OAsngPp9mGYmw==
X-Gm-Gg: ASbGncsZKZzkjrRSyxHAbyzXNmy21vppJQbIW9P45HpU7FGU1pWeKS5puHOe38HX2dv
	LEpWWZlFj37nJmAEvoQbxLsWG7BKONb/HmaLLeks+LVO2f8mMCT+WSuMDOLnyug0OKY5jaI35oK
	CAODrDAtHmgaDlzN0UUQ57AIa/IUwn4Wb5iBUTgVSPXViRjYoTqR8OMf2X+zLF7Y1VeBB+HnCCf
	TIPs8Fl9/kkShHOrcw6m4ofJKD4pMRZyEpT1YA8kLi3gYgr6p8RbxOyYgD4nBBzGLJvqf2oX51g
	LXhzRP5rgjWoProd6XBQO4hlq+jaVmpVBql9DN7IL5D/dg==
X-Google-Smtp-Source: AGHT+IEXRnxtFOxXW/LXPGk+bjfEq+7dZ7QtQt0MXxIM59d9fmCvhaELpEBj5S1fpCSuYZHUFF5AxA==
X-Received: by 2002:a05:6a00:1896:b0:728:e81c:2bf4 with SMTP id d2e1a72fcca58-728e81c45edmr627448b3a.11.1733830594147;
        Tue, 10 Dec 2024 03:36:34 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd54aa2399sm2554532a12.39.2024.12.10.03.36.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:36:33 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 0/8] fix behaviors of git-push --porcelain
Date: Tue, 10 Dec 2024 19:36:20 +0800
Message-Id: <cover.1733830410.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Patrick reported an issue that the exit code of git-receive-pack(1)
is ignored during atomic push with "--porcelain" flag, and added new
test cases in t5543.

This issue originated from commit 7dcbeaa0df (send-pack: fix
inconsistent porcelain output, 2020-04-17). At that time, I chose to
ignore the exit code of "finish_connect()" without investigating the
root cause of the abnormal termination of git-receive-pack. That was an
incorrect solution.

The root cause is that an atomic push operation terminates early without
sending a flush packet to git-receive-pack. As a result,
git-receive-pack continues waiting for commands without exiting. By
sending a flush packet at the appropriate location in "send_pack()", we
ensure that the git-receive-pack process closes properly, avoiding an
erroneous exit code for git-push.


# Changes since v2

* Split the changes made to t5548 into several commits for clarity.

* Correct the inconsistent return code of "push_refs()" across different
  transports to ensure that git push --porcelain behaves consistently.

* Gracefully close the connection for early exist of atomic push to
  resolve to root cause of wrong exit code of atomic git-push.

--

Jiang Xin (6):
  t5548: refactor to reuse setup_upstream() function
  t5548: refactor test cases by resetting upstream
  t5548: add new porcelain test cases
  t5548: add porcelain push test cases for dry-run mode
  send-pack: new return code "ERROR_SEND_PACK_BAD_REF_STATUS"
  send-pack: gracefully close the connection for atomic push

Patrick Steinhardt (2):
  t5504: modernize test by moving heredocs into test bodies
  t5543: atomic push reports exit code failure

 send-pack.c                     |  10 +-
 send-pack.h                     |   3 +
 t/t5504-fetch-receive-strict.sh |  35 ++-
 t/t5543-atomic-push.sh          |  30 +++
 t/t5548-push-porcelain.sh       | 425 +++++++++++++++++++++++---------
 transport.c                     |  17 +-
 6 files changed, 374 insertions(+), 146 deletions(-)

-- 
2.47.0.rc1.21.g81e7bd6151
