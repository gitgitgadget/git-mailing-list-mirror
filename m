Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B861223DDA
	for <git@vger.kernel.org>; Sat,  4 Oct 2025 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759588957; cv=none; b=XmTLrXS8a6wgqlhyXFHKjJOJSXCXvYNoe+j1W8/A0kESQ39eZYTkbMqbxfG74q4jlNOFFiYPG8ZfRRJTz9c+mVBdSmcYK3AhoqlGJ4gmAiXyU0A7Yw920I4w0b9csK9yRQAnSiihhoSheh5o9x00wzr2u7XKGKelGlLy7uXgSTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759588957; c=relaxed/simple;
	bh=NG/Cq9DMvJ1U10QMqqBoy1exCjgHf7uoxNv4hXr52eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XmwBDAz0uK3oznYRj19050mulTtWM5C4ipdobkJTo3anpcAn0YvEx7vGdAMp8KxKTHdBm4poRFBSdespcEiHZwY+yszyjxy9CWQIOZjdSFjQGUcFSHt1oVHDaDlJhPuL0dO85ANNqb5ZqDu+0FnLRmJeO6BennCqQiu4j3tzLCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=elC/as3Q; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="elC/as3Q"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b5d80f5a23eso3416446a12.1
        for <git@vger.kernel.org>; Sat, 04 Oct 2025 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759588954; x=1760193754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xSt5VPybsYD+y+gIjSmgAZ67Eda4RLB0LlJVVzVD7j8=;
        b=elC/as3Qin8W25VhAUIS9C8fAN8dOjxOIQZZ3W/rx+xh6uSl8O+9BUJ9AffOga6ZO1
         lNVwyHCPITSTgzJEly4HAVB1o4bkhJHuv10ZDHx17AZvaiOuS32TAAFBBq/FYwniLn+H
         5n5PnYDsHhSMw97Oye+3AUyuhDXmnaHwYBQXvLtcutn6r5zPGMzWYwg8uuPGgOH7Vdm8
         QXEwV1x0Zd5T82y6FjKk+FBqsrSvaQs5GQa/XX/IKPrqrthRbjNuQF8S9bgS5iyeUond
         LLAPl++3hw2Jk/JCSqLy7LTYJUMMiDF8bVYAEyCWmNyfpnDA/o4YNtrvZcGsqj/idMS3
         gwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759588954; x=1760193754;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSt5VPybsYD+y+gIjSmgAZ67Eda4RLB0LlJVVzVD7j8=;
        b=gUQ+9OtbMWJd/fy8MJimhpYd1428BY9BFHeEcZBSeKSNEKLkt4iTL13ZOVTGJOQMZd
         x9uNlEYxp5+4ar4tr+nA7K+uobQmsTcTLZnWPcCB26e3NDyArdesqMZfuWjlTbNcJoTd
         iaRmACWmXraHYvuKbcWoTVmydfV7Aazs9lrGgREPT1lOphKx5mq2a2tQr9CmGxA4qtwj
         wxj6o38QSC41TKSyBe8NYNM/1/nDbjHvVmThZQBGktQrUGsUqE8jyR19Xf7E/ADVjXBv
         hifopxmHArF0fhUtz4WIaeSF0IRhjx63X16RE1r+cXl18xTQqBmto/El5m1JVBDx+qAn
         bHLw==
X-Gm-Message-State: AOJu0Yy7oXpgjjJCdRKMASlrsUGQV4HTJak6V5IBMPzZvVjCarfy/MGy
	8I/B2VGNm01ta2ifNQWozJiAgQPc6/bkTbloHJdpScFjTG8JDPQ0PNcFAku3MCxW/ulJynpgZD0
	pLYFl
X-Gm-Gg: ASbGncslSeekkGy2S77jJHH4bWP5/12Uvotncf7vqQ3Wcmk7Ocys7WJa5OBkRwXJGCy
	TsGU8dKAPqDXuRwknziy59irnYN09gdobCzsjSgyHdJSdnd4JmpBATGtf61djOPI4FtzH2ACjtn
	tHthYWbh1lxQzZwgG1+Oy/ZwNnsx+ExijtSt4BXhzOGqV5Osb+WG/CJnT2daoQN+ldmovsFpMQy
	zbj9P/4CgQov5LPHw2KMnvqxBviSb8AhaKGy2PympvMv9WlMrFQJwxXZ++lVviEH1+8BGyFcYUb
	lXLE3o80u3Y3v+SazvS0jSHX/Tx/EPfn2XfMJuVtLHAbuaB/ca+MC+pQG9ZrJzyeSiVsPjRZV7h
	+PNsELMe/y29fTlB6cTDzklcjN1ez8LG+4ZFpG9EjsjsKg75E8EyTyG4iBo31fWGTxkDheudfm1
	MNxFlhqPmSmUwfLfk=
X-Google-Smtp-Source: AGHT+IFf1bNa3+Tmu7Ujnvj6incsXrhmplgbN6U74+aQbmXrhz0SWrZYA9bmfjz4G9H81n+C09HpqQ==
X-Received: by 2002:a17:903:2f10:b0:265:b60f:d18 with SMTP id d9443c01a7336-28e99babb07mr73540615ad.1.1759588954092;
        Sat, 04 Oct 2025 07:42:34 -0700 (PDT)
Received: from LTY2K703JV.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1dc00esm80477475ad.117.2025.10.04.07.42.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 04 Oct 2025 07:42:33 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	Han Young <hanyoung@protonmail.com>
Subject: [PATCH v=2 0/1] files-backend: check symref name before update
Date: Sat,  4 Oct 2025 22:42:22 +0800
Message-ID: <20251004144223.23436-1-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.51.0
Reply-To: 20251001150805.9652-1-hanyang.tony@bytedance.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Han Young <hanyoung@protonmail.com>

Following the discussing, I looked into the refs verify and fsck
commands. The refs verify command does not check the HEAD ref,
fsck checks the HEAD ref name and the commit object it points to.

I think we can move the fsck_head_link from fsck to refs. Then both
git fsck and git refs verify can use the same function to check the HEAD
ref.

However, there's no harm in adding a runtime check. 'git reset foo' will
happily create a ref file outside refs/ and return without error on an
invalid HEAD ref.

Change from v1:
* add a test in t7102-reset

Han Young (1):
  files-backend: check symref name before update

 refs/files-backend.c | 10 ++++++++++
 t/t7102-reset.sh     |  8 ++++++++
 2 files changed, 18 insertions(+)

-- 
2.51.0.373.g2c26b26d9

