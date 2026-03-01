Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E82D2F84F
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772372858; cv=none; b=rlJD5PTCMoWV4xFcRBVFaC/3jDBwAmP//NV48s41NxhtAxVuvRjjdpNZXBzpvpLAOZPVn/UMecP1Fx3zxkdz2EVIy8vpv14gJY54ZKd9rQcdWTkVknhAVTkHH3yg6ZY/tuy4zK4l+p9jxFmtP3OSyEgYhN2CTrXmaTmwZZT2DlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772372858; c=relaxed/simple;
	bh=mtJB5UvDPMAFGazGeVKEOQghOSQk7ptjZM9f1diN4h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJgwR4dBXeYf+uo2D13UC15ccs6btAe1GjGBMMBu7hbukhH93OWYDUaQI/c440LMJsgqVzdVGDwUoo4nE/4+bO2WguDGg5n1X6MZ16/wIG5mWWzQ7s3lv2uuHz8siJttEh7e33gKlDxX853Yevi7k25DTTMVtI3SfcIz3EVbn1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7psOUVn; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7psOUVn"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35982fd8910so253816a91.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 05:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772372856; x=1772977656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEVvKZdHft7jfXmVExRAn5k+U0Zo1JqredTq0MTusaA=;
        b=L7psOUVnDUjNwJdMSDIViGgU7UfxQYQb9d6uDa1aJIqgmUqxqN6PpZK130xoWeo7YL
         +OptA6n7/cLXi+yyAvhVmJfNAg1vrHZAzx+BHNQ31fheUgc7+Mwx2xJi2Tjxlh7SSOjV
         woOj88B1rnBiGCSFPvUy+uRnkFdmy8g4JG4Cyx0wNo2zR/hnXWTzTXaoEEvsEolohGqr
         C7xYZ3p70BQkW01nrpj/+ZyXcfN7LQNY46553687+ZuvBQ16OrWLOUL3zFfnri45k6yG
         qGLySWUEoIAVKXcgAL0IDykY61KIcVid03BsX7YeddKP5InHk2ScpeKMi3HjjbIgXkh+
         GwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772372856; x=1772977656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XEVvKZdHft7jfXmVExRAn5k+U0Zo1JqredTq0MTusaA=;
        b=NWlTFWaz+LLG3nFXr5xPBgygf7F6hx/DhNBvRm7n4syrLWLNvXi7lup1O17VvXTxJc
         FVFRRgl12nPfmzFOganhr0LSv/1mMl1TVmwQTqA1C5GPCFwDv7i5zRbFmd7q4xZW+p/g
         UZIry2+Qx7S1Ey+XhWxSg3a5G129RuDMU+UgyDXqkfm9/JBVpCDI3P/nZqDxQ/OP9Nw1
         GYP7Lmqh+C+bVcxfuyGmlbi9nEwrelSNJMEPqB4i8C4xZ4LidsajqnH4HNJ2Pq0tF4S3
         2WXMHlfMAn/5BqUJ7Aqh61X/HCo4JPUaXI5khH28bFZ1LKj+R5XH1leT/j7LCisbUSXK
         1zBA==
X-Gm-Message-State: AOJu0Yy4XJW6Vhim77qBdoQJ2pxwfavy6tgxM58QpUv4z4KeEFVqyk9G
	Awsq/TH/Prd5t3BAJhehMk6XVDEywznXismMpWyqbBdn3xAaUCzWvsPa1XF1BJR0
X-Gm-Gg: ATEYQzzk9ZFl3Zeh3SvNURrRV7CFvfUU+NU+DijHsRyaZMxFgQLwxTxpWBpGYv/sX2j
	CxoEKDfHk/grdS0swrKc9Zd+LBdrHPW89ljyC6qdoxgSbUzTQuDU5fP7D4Hy2jt7pgKBmLKuAid
	bd25XsakUJVnKrE3hqIuVNDbH64xSGmqb9Hil7hLBNsOfUowiZvnheBc7XUNkk5dyB57e44rQyw
	uWNoycRIVqXxfpo0+p6q+imQ2VjxHsD0g9ldFm56BEj3eaN82QJL4j8ja/R2E4l2/rUWLI9oI70
	jU2ZG50CQEkaBNgIOy5ND0JgbGWNsinpmoVl+00DwPZjzP8T8PZwKCTLqYfBSKQFupL4tkCZM4S
	r7u1orwsUiQulYVEGmAwswiR0EAjzj3fnfOwm0QVu3bSUgldQtq7I3Wp5F3oqxZU06lyT+DqJna
	kQ7CTIxKwvcAMRJOW67x8HTIHeH74/xPbOkEPQiMzz/fjX
X-Received: by 2002:a17:90b:1ccc:b0:356:83b2:539b with SMTP id 98e67ed59e1d1-35965ce4389mr7512810a91.32.1772372856406;
        Sun, 01 Mar 2026 05:47:36 -0800 (PST)
Received: from Pushkar.xu.edu.in ([103.92.44.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35984676551sm2161989a91.17.2026.03.01.05.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 05:47:35 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthiknayak@gmail.com,
	peff@peff.net,
	lucasseikioshiro@gmail.com,
	jtobler@github.com,
	patrick@pks.im,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH 0/2] repo info: add path.git-dir and path.common-dir
Date: Sun,  1 Mar 2026 13:44:08 +0000
Message-ID: <20260301134412.1072596-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CALE2CrTt_2-9C4zCrZPBabtsWY=+Mk-bH4Jaemk=yHtfpoLjfg@mail.gmail.com>
References: <CALE2CrTt_2-9C4zCrZPBabtsWY=+Mk-bH4Jaemk=yHtfpoLjfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Following the earlier RFC discussion about exposing repository
paths via `git repo info`, this series adds two new fields:

  - path.git-dir
  - path.common-dir

These mirror the information available through
`git rev-parse --git-dir` and `git rev-parse --common-dir`,
respectively.

This series builds on the recent path-related changes to
`git repo info` (including `path.toplevel` and the
`--path-format` flag), which are currently under review.

Both fields respect the `--path-format` semantics introduced
there.

Pushkar Singh (2):
  repo: add the field path.git-dir
  repo: add the field path.common-dir

 builtin/repo.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)


base-commit: 625c4fb2daac9879b299dd1cae2e793d2821dec0
prerequisite-patch-id: a15d35d8ce98f550953b8d2b5766b945ae73013e
prerequisite-patch-id: c3311a175dacc8d31ac8143f6deb36a1a46bd960
prerequisite-patch-id: e2348c7f5cdad006aeb10ddda81a184859941c8c
prerequisite-patch-id: 54003bdf23d570ce671626496a6622319a4ee2c8
-- 
2.43.0

