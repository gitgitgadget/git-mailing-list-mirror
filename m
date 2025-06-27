Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179A139D1B
	for <git@vger.kernel.org>; Fri, 27 Jun 2025 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751005330; cv=none; b=sTXShFNnfd3HYar/dFXltWqUxmpr2Mq1DxWPzcbcW00H8h6Dae4VuP+4TjPvAaA7/iDj6QVqqVgCyZnnHRNiJ1zvwfKGEsCZqt8LuftEKph5EHRrKzncz6/L+YURjtP/LUf71ZZe9hhEcp6wNYMngZya6OibToBKcYTs11CrDhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751005330; c=relaxed/simple;
	bh=N2xLYLhl+JnEAAoWwlggCcrvQCxPdl9KfHYIFbxL8/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXec/2kUb63gYpee64U0LcmYwoCC7QJowHBHM/9lOmoiyz4j26dnj5T9jQXdJ4z4gdb5kFBFkT+MgTKeO4N84RyRAMdePATp9YH0ahO8XjntaLuNpPhZJfS67gTNHDdW3nVGw7zQZtceZQJKpecUhRRVGf7c/4y6DL8K7iRvk84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+VxoCWs; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+VxoCWs"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so1707940b3a.1
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 23:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751005328; x=1751610128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyjaOxt5p64F3Ybxe7q9lsDi8TZiR46puknN7/4Gn3U=;
        b=I+VxoCWs2RCLpVrbrXfx2J5Or0gBJ0RFHzBoxwPGBxAuGcaB8A6JOdIiWGcZ7PIrcq
         pTkleE6DFR30X40FHqmLa3COID+cjPIOLdqAET3Us+mgLnoeve0lqhQ74Qn3FHZ4N8yD
         15cWz528G8GiNAr/i4A2Fxh2odGVql3DmjWJmy+5AaPtAsxM9L3guoXiFtXlGrk7pAcI
         /SgWP7yvLeHmgns+kxc5vMbUQk7EYmvBwmdvtCARmkwv2e4hE3n9u23HRhim6kJ6VrJZ
         EH7CWc6QhSBk6hspaPbJi+DtLtvu9+jCSZpu2lxCdVPc0RxyUAhUuPIWIA5FXROc9u00
         InLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751005328; x=1751610128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyjaOxt5p64F3Ybxe7q9lsDi8TZiR46puknN7/4Gn3U=;
        b=OxNf8ttAH6vU8s8SoIV51SMYoVs7RvMaQx4Mau+Hgm4so3kmr33un1AMzITJP7tNs0
         MpYyI945CfozGusPP9MZPRwoEvzYvw0SJ49kiFSy5soj8h6gs3ZVV8Vp2U/Bmwrr8YZ9
         lCUQdFrbWdv9GHuqIu9hP4tXkJoUWZVUeS4S5eikrLqsXBgZoXi4O37OBDUsE2R9ZwXh
         99LPO64T9fFcVxZuHiJYYoNfwqtEiI6YBSnUjJrPXiSEI3kxPPy/vf7xMJmFXKf03YU/
         xchQKSJ+FjcnpuwlDL2PCIlZKq9hdgJY0bLLKmxvoPp7E11Bp6kA8JbIKeraZYPS4FIz
         aymw==
X-Gm-Message-State: AOJu0YygQyr9/QxdjAJijjRJTDCTdWWKmpehcpwEC6a6qXoz25hiuYDF
	p2k6/SqBU0PrCxGIAxiqdKEnCe/OG5yQ61cxpx/q8Wb2fXFXO8ERy0Ys1KV77q8F8ffB4so5
X-Gm-Gg: ASbGncv5qpem38t0D+bxM0EchPgKqm1BnVg4+D4r6H+7a7KgzKBczfodBbisYAx7+oJ
	YgiqEBIDoYJJOM/iulTVogo7AhaRZHPh3M6wa71cQb3rJVULfw8C8D6cvB5sIs0u2/hmKGUcP/U
	c5nbFdfxf4Pyo/w22A3lpq+RxJI2mEqjC9DswHIkbfL+B/QK4TDr9um8+9W9htdGruI9FEgiBLF
	bB87PVAMpDVTM0sx5Mt+KNpgqYGUGnGEfZ0gI5bp69FWAfeJmVcA2ZEGhpn+Fiwo7Bv0g2OP1n4
	Wc7aVhV96rk1k8+fQAu+PIaL++UcamezKX2uVw4aibRVHQbaH++YxyVp1U3hOqgyTnlN
X-Google-Smtp-Source: AGHT+IFKHV+ATwp/evHWFTXwZlaNeqrf/Fgy+ts/5vDR5hfK/mSKm716BIQSYXI4q/okACwdDeugHg==
X-Received: by 2002:a05:6a21:330b:b0:220:42a0:7f65 with SMTP id adf61e73a8af0-220a101d920mr2448382637.17.1751005327995;
        Thu, 26 Jun 2025 23:22:07 -0700 (PDT)
Received: from r760 ([188.253.126.212])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57ef4ccsm1414936b3a.156.2025.06.26.23.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 23:22:07 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
	Junio C Hamano <gitster@pobox.com>,
	Kai Koponen <kaikoponen@google.com>
Subject: [PATCH v2 0/2] bloom: enable bloom filter optimization for multiple pathspec elements in revision traversal
Date: Fri, 27 Jun 2025 14:21:52 +0800
Message-ID: <20250627062154.1121530-1-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.108.g6ae0c543ae
In-Reply-To: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The revision traversal limited by pathspec has optimization when
the pathspec has only one element, it does not use any pathspec
magic (other than literal), and there is no wildcard. The absence
of optimization for multiple pathspec elements in revision traversal
cause an issue raised by Kai Koponen at
  https://lore.kernel.org/git/CADYQcGqaMC=4jgbmnF9Q11oC11jfrqyvH8EuiRRHytpMXd4wYA@mail.gmail.com/

While it is much harder to lift the latter two limitations,
supporting a pathspec with multiple elements is relatively easy.
Just make sure we hash each of them separately and ask the bloom
filter about them, and if we see none of them can possibly be
affected by the commit, we can skip without tree comparison.

First commit creates a new data structure `struct bloom_keyvec` to hold
all bloom keys for a single pathspec item. Second commit add for loop
to check if any pathspec item's keyvec is contained in a commit's bloom
filter.

With this change, testing on Kai's example shows that
  git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 -- src/clean.bash src/Make.dist
runs as fast as
  git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 -- src/Make.dist && \
  git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 -- src/clean.bash

Lidong Yan (2):
  bloom: replace struct bloom_key * with struct bloom_keyvec
  bloom: optimize multiple pathspec items in revision traversal

 bloom.c              |  31 +++++++++++
 bloom.h              |  20 +++++++
 revision.c           | 121 ++++++++++++++++++++++++-------------------
 revision.h           |   6 +--
 t/t4216-log-bloom.sh |  10 ++--
 5 files changed, 127 insertions(+), 61 deletions(-)

-- 
2.50.0.108.g6ae0c543ae

