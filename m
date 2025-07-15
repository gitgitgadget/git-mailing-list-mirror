Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BCF7261D
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605527; cv=none; b=kn13SlXcNtY+FpKnU5fdepgA86fsQAUPBzwylX5FTi9qY5giUC0xSV8z1IxFD49Ny9Z7zmstOhzqFzB8dSwBQRZgJ0+G+uizB0WTFi88PlVdW/8lVwl/vFMXDjFsemEi3izo9f73xxtEVPHVQi01pHzB05N4xH4xptcnETn1i/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605527; c=relaxed/simple;
	bh=X4r7OCACYnB+dyfrHxfKIPlsckmdk0SoHyj2q5bamno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHmSBQ3As34kL6xBahZxdLEctZw/TX3JxaTQK1BiaAeB5WNYwGWwVboIwJfP1bXJ6GBgZYQ9Kqfas6O2bJiu6BIV3KGhlJdHu4BquUKaFL1D8ojm6Q0CeF8h142mGdoK/9XpNmhX6MD+0+4yd/3iaYny7XC9KRWqOU6jZHyPKAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWmzCCYs; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWmzCCYs"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-75001b1bd76so2300989b3a.2
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752605525; x=1753210325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpLwk8zzGHFLqRAzsoBszn/0sSVoiZJUeECG6kvLk5w=;
        b=fWmzCCYs0ZYx0jw3Nq13WzRoNJMiiC3GgO1gaJty3o4T9hTSHpwQXi8c2RPy2YdtyJ
         wAdmKmtlQAAic/wisPb+XepNXmUHv2iA7DMDccHAzWk+AVaMzO93aPXMLERFfNDtICgi
         ZJIqJqzAWfuG8Jh7zMMIZgbgANHibHsA3keo6EVRtOtUghu44N5wnuWCxH4yQcy5y79r
         RZqfSz51DnG4ScOmvvgX8D1aqccG14BAvPW6rXvv6eYOe5/QL3JhvO1RSYV2HxhLYNGL
         kHSxvkr+nGbTD5n+uO3DVILvdmIXCqgATh0kV9y3rgWoPgQvXbCCaTkEv8NVp9UpPUpJ
         IokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752605525; x=1753210325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpLwk8zzGHFLqRAzsoBszn/0sSVoiZJUeECG6kvLk5w=;
        b=D9ORLglnkcZGjIHLRej7DJFhR63TxXIxFdTWKcndM+PKT1q443BcFcdGAEZ4snn/fh
         rrGLvOLIOXog4hOa7wvjBDiKNydDm91EyfFt3PBDffSxR+60vsABcArO0ojbCMmYVbi1
         AL8PKk4VWAujMRLzZ7PTCTob9ZJerADtEGJNlM7CbHJjepRnUtZdq61pX+nURPYl7tcm
         JYhLuQDTRIEFVJavDt6tZoN0CcM3rbPQrUKrlWA1GwFVGTHaVzEkzA0ME9CeMREP/JBM
         ZWPUN6vqEvBjJTI5bX5rCzvg8mOB+9X1ezzOb6DmkGhn/HX9CfeXHpY6IHhHhXWXap49
         Bd1A==
X-Forwarded-Encrypted: i=1; AJvYcCUzlX9ExnOFeii9ktflPZB2f3F0uyjKS9LkwHnOZbjvkhY6sifCozGCjoIflzE3bP6w86Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCAv1JuGNAJQobdRXylPfe4iByyqO/+6UvdSBdEzLqcvlUEa6C
	I/90ZVNbXsI5rmX4tlZ8+EpGaeJeD9ZhQN/9ugGd8Bq+atIDggT+wwZY
X-Gm-Gg: ASbGnctbUtiy1P3UDjOnQmQLaqYSYLBFf1YBsq4uDqSgZq7RtcLqeZgDNrd7ZBJ6R+p
	6vW3hCKSeGdCf0W9VaNa6jWTMw1eeXRV1Xl3AU30oLUhdpGpw19jT9clCTtCebAFGd7rJhkOlCC
	U8oQjjUCotFfSqCGYykfES1RU1lwu3qBskWb4uWFRkPMR5beKer0AAHiJpo2m+/acQiC8UXQQkL
	evT8lnI/csNWvsE8UVZp5K/ryIsITF61Wk91RqqF3Z1EmjTvztL9jxoaID4DjGETG12D4yktN6H
	BWVg59HsZW6q9yGih0QNqq0mFGJ7a0UvkjM/Xv2WUcP4PzoCj221js7fMIB7kQpjmi+4NxrdjgT
	IpK3fg6o5l68ZnF9Sj7YfIF2g8QFsw6MkiZg=
X-Google-Smtp-Source: AGHT+IFyrPkNBRMl6kyb4hnSdi4t/5jppdQ54fESMoF2GN85olkyIenmYI7eiZaUg8ZCum/hGR+GjQ==
X-Received: by 2002:a05:6a21:648d:b0:21f:ee3f:8ad5 with SMTP id adf61e73a8af0-237d7235caemr603306637.20.1752605524965;
        Tue, 15 Jul 2025 11:52:04 -0700 (PDT)
Received: from thinku.iitr.ac.in ([103.37.201.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52c914sm12415806a12.7.2025.07.15.11.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:52:04 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: ayu.chandekar@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	phillip.wood123@gmail.com,
	shyamthakkar001@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	gitster@pobox.com
Subject: [GSOC PATCH 0/2] commit: improve behaviour of core.commentChar=auto for comments in commit messages
Date: Wed, 16 Jul 2025 00:21:24 +0530
Message-ID: <cover.1752602474.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626132233.414789-1-ayu.chandekar@gmail.com>
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey everyone,

The aim of this patch series is to improve the behaviour of core.commentChar=auto by the following patches:
1/2 - Fix a bug which reads comment character of the comments in commit message leading to change in the value of `comment_line_str` and thus resulting the comments in the final commit message.
2/2 - Standardizes the behaviour of code by resetting the 'comment_line_str' to "#" when core.commentChar is set to auto. 

Thanks to Junio, Phillip and Kristoffer for reviewing the patches and also Christian for the reviews and mentoring me.

Ayush Chandekar (2):
  commit: avoid scanning trailing comments when 'core.commentChar' is
    "auto"
  config: set comment_line_str to "#" when core.commentChar=auto

 builtin/commit.c           |  6 +++++-
 config.c                   |  6 ++++--
 t/t3418-rebase-continue.sh | 13 +++++++++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.49.0

