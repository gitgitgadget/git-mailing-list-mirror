Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D329F2C0323
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699090; cv=none; b=eL91RfxC4QAGb3+OMy19P+ouFRx/22XZiEj3sULYdhwyNJWU4xZxRNMDcjFJQUl9jcDlsRusSE/JlisAS7vUZr4l25KAw2/1Re0ai8rNrSu09g59ydYPZRpoL6DQf9vRVqD/5PEw7LpJxX9TTWHeSUfC3wEFdzZatKG4qzzLw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699090; c=relaxed/simple;
	bh=zYMcbf9Hz5NI6gm8lctuFS9RnELe5oaCERjy9MWgT7k=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=qtDkh5DD0VKHOxw7LCRzdl3ELCLYOPaU7eEMBPvjSH9UVSDvtNSjPNkmvGscSx7xHpEAC4wE3nfdpoXQ7aqt9DpEqjLgP4P5MRO8O/qrJ3BY3MB8DtvbBEwXu27/vPWiF//EMDxzGmbO2qk9mLu1qUXHaTII4fpVXFaDqs+lLjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDcg2y4+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDcg2y4+"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso8868398b3a.1
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 10:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764699087; x=1765303887; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7Fw0Gxp25ebhgH7PAugQXlExHqJ7w1/GJ7/Ls+KRUAc=;
        b=nDcg2y4+dIsMJdo0jpDMqwsFiuPRul6Bojo7/G1pQBeHsie5OjnXBM+QZ8VyjgvFjS
         b+07ES0TDYwWLNlugDQC8hrHPy6p4zuyTuYYkaxR3hDk3bTuIPYu0wcxjx27fUVAqXs8
         m6DzXsUEKqf7gDsVRfDsa85MxEfHpxssUkBpMXCiED6mKnMyB5KoAOxgWUI+g5EE37YK
         pqnfdU68EXi25UD0K/ADRXHMdyhQVxKjDp2NsX/C04XImHYZ0wZXJh+hU+eQbBgRB6HE
         sCvcoK2XRV7Xk7EngMcJD+Vlkk5eCx413o8tzKeypPThZ6yhTxJgUmGrkdjdiNkgN47I
         C+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764699087; x=1765303887;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Fw0Gxp25ebhgH7PAugQXlExHqJ7w1/GJ7/Ls+KRUAc=;
        b=SjoQXlXJhp2mbLaZa6Oi9b0/0KBJcNQsA6iJ5zElgSHIN7rEcdEAFvKtzHsLOPUWdc
         wVFPOPVDEdmbC1y4+h568RBvmBocAFaHLX9TpK7ARFPAkKKvgrYxsjO4Os4H7+qcamqp
         +YLFfMdEHId5TKCOmiLdYNYZFybqvDcu6a2Lje/yG14aVSNuImtzUQPppwAN18nMJA5q
         9dB8m/EhCkRD2dMV34XTZpgH9xbYiIqw8BbtqWu8NRgxONOnYXc9r9qEQsaAt3IwqXsU
         j4olh4hP5sP39iCKhOgqEM9l8AmUZR9rtH55cXzcEnGgLGpPL3sGAnlVKI/Hr2vm9SNh
         ZK5w==
X-Gm-Message-State: AOJu0YxpeOKDEflL0HhXNd8NH62iaj7jdq+Y/GzRfkRIb/WY8+NsSjgv
	M2WschaJrp3m4j2yy2ew6lOqZjsgok+cBG05BdIY2g8UDvZYTHaxHabzeCYuLQ==
X-Gm-Gg: ASbGncsCevXhqma2A4V0NyaEPIg3mCKtfKEGlXxV8wIhKvSJMvAEIwJ5GtwQxqqoBLA
	AkUKblIhRoCBHjaI9itFF5SvNs/ydrojvzS74EmZKPEPA+WnF7yGV4ZrzIrAuNaqE2uv3Lw7so/
	MaGJKJKNKpPQ7DbA8QrN2P6qla88fgTdMDRi7wxsdNPdikZN9h+u6uM8k+sWa7BWs5NJgC9js0e
	fT1sft0jd2Z9L63QTIAYnKEFxYZUBoU7okt4AlhwWJqT9TyKNhajprikjEVDjTHuPJ9XXV9OVjz
	aRgOO5TgLZSoRhC56OPSVJKsALJ1I6UJPPelZsqx9IMerityW4rqf6KMzPRlF07SbG7LmZpQF8W
	wRr4duHQzm65hwjtF6eBxkyI8Eq9FWGy2qLQd/GvbSxTCfE6TbJDU10rrvq+AibneLlGZcY2FAr
	AeZ1aSmzsnnQgCYQ==
X-Google-Smtp-Source: AGHT+IGRL5cCe4mR9vyXZSfoySjxtfb75a5BKjSJb4DTdkXvW80lGo1/gQYjZf0+7AxyD3sIFei9Kw==
X-Received: by 2002:a05:6a20:3d1d:b0:361:51d9:e18e with SMTP id adf61e73a8af0-3637e0d2ac9mr33590553637.52.1764699087458;
        Tue, 02 Dec 2025 10:11:27 -0800 (PST)
Received: from [127.0.0.1] ([172.208.154.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d150b68805sm17653838b3a.9.2025.12.02.10.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 10:11:25 -0800 (PST)
Message-Id: <pull.2014.git.1764699084703.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 02 Dec 2025 18:11:24 +0000
Subject: [PATCH] doc: remove stray text in Git data model
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

I meant to delete this sentence fragment when rewriting this paragraph,
but accidentally left it in. It's repetitive (since it was meant to be
deleted) and it's causing some formatting issues with the note.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
    doc: Remove stray sentence fragment in Git data model

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2014%2Fjvns%2Fgitdatamodel-stray-text-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2014/jvns/gitdatamodel-stray-text-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2014

 Documentation/gitdatamodel.adoc | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/gitdatamodel.adoc b/Documentation/gitdatamodel.adoc
index 3614f5960e..dcfdff0346 100644
--- a/Documentation/gitdatamodel.adoc
+++ b/Documentation/gitdatamodel.adoc
@@ -235,8 +235,6 @@ there will no longer be a branch that points at the old commit.
 The old commit is recorded in the current branch's <<reflogs,reflog>>,
 so it is still "reachable", but when the reflog entry expires it may
 become unreachable and get deleted.
-
-the old commit will usually not be reachable, so it may be deleted eventually.
 Reachable objects will never be deleted.
 
 [[index]]

base-commit: f0ef5b6d9bcc258e4cbef93839d1b7465d5212b9
-- 
gitgitgadget
