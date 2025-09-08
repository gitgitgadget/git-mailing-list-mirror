Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E9F218827
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 04:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757306195; cv=none; b=vA8R72E1LW15uSyE61LLZQBXuzn7eIEJLSXpHkOIM17crb0jrDgZua+hC8eYbR9G/GK26pJraTzPd4sFUCXspiQasIf/bEqrYAL5WxgezTENW/mEadTxEWMwZAJvu6UAYXSyHGxJQ5zP+/Y0Yu/lvRBicWZPze23fZhx2mXwqCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757306195; c=relaxed/simple;
	bh=F2FBZiAT/pjTOJjCoiazIebsRHwZxCUCqmcS+IvZZ2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OyI2ERwCbLdV7Tqv7Mw6E7k9rCvwCTqlatRUxa2RRNwLFqsTaIXr3pPaEqvKnfreiQ3o1GiPqavJvJH2E3K+QWBeFjoKgVz6/+UFddcLcdTAFj7edMTwRNmVmDntxtYEMM3W+EBGzHWmlmuvtou5/EYJhFQjV6fWV7tVZh8+kOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTK8thPu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTK8thPu"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7724df82cabso4513454b3a.2
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 21:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757306191; x=1757910991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t6Eq4cQ11Hb7LrCrAxwO/6Pmb0Bq6LERzkKRHIdmlPY=;
        b=hTK8thPuWA8HdSrdJ5sTZljnFBt3BoZrwcMz1/ayITfDqfDmz73Blk/EY/3Drw7iG6
         fyL9MuzuU9fq9wLlFl5mQbHZ/7WY8nXfkuEDKVu7Wh4Sv14gbnSZ0g0yG9HjlLCf6TYz
         R7PdB/lrVW7a3tD2GB6pSK2agnrD9HcF7klH5W7gmWz/TITl8gKrh7ELKzXxzRClHYrh
         c9UzPqaE88ApZMsER3btoBLxRHc/+wAj9IpMxfrCkJxHAI6X6Retmy7MP/ORK8BwO+G3
         0CRBY7oZV7RecbCaovLH1Rownsm8mh5JbR9YEoDDRSPXp4+FpheesrkRoewlVO/f/2eJ
         x/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757306191; x=1757910991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6Eq4cQ11Hb7LrCrAxwO/6Pmb0Bq6LERzkKRHIdmlPY=;
        b=TRBYi1ldIfL9xB5guq9/aW3D6fz/SzjtIyg6tv9Q08Z+gcdO/AN86P73ktOFngF8LB
         9QTYjUOWJQf2xnBEbgL8xhKPdooFkUMI1MmQ2/Yp9IXLGv0baMWvVFNbpPj/hVhOoADM
         TflsCWnKtBV8KuTupO3J0YuP6aXhTrdLh74KGxXifzr2P/10dJNlmt9CqtNEPc8/CCyN
         Wt/5ndwQhGe3gqg4WsyxG2mEGdOE1pp+0pCTA4gCwJ1XtjRDQSpkM0JwIMrt5Xlao/OE
         1otgf6wEBVuFhaLhm44r6VIZ1Dbt08BsSLfcsOER/HsvcWMgE/8msH+zHVa+h3/Rih2v
         cWUg==
X-Gm-Message-State: AOJu0YxCgqb2LXOMIbw6YHKv4T0uc/FeQ0nTeBy4CPrhKjpoWpZ4IRm+
	oSW0wtVgmZtPPU1QbxF9HTy/sYNZ8JXfLLkQU2X2dbxxqDkkmO9B16hGFOz3itEg
X-Gm-Gg: ASbGncvVchWA2LC52OZ8Bp3BXx7y9+gF3HEFHp+o4hnO1HiZlqCWdo0nScHOkrm49gM
	eZdYLb4uD+kikhd3naac6EkihnWED9VMKXoESAoPuZwiMP4nHK8Ds8Z4bt72g7vhDOp7hhCdoj0
	ZB7++T6kqSM/WAj8TPwWzdDL0Hks8z9bPvcWtvN7Yve4ZSkC7z+nPq+t4UcfLQBUhm4Muffw9J2
	69lWAoexz/JkfW6plY55f4YODdbKS908y0Er3Yk+8bEbvdyhqPEiKZUQ+v0hJMwaVdVerrYFIK5
	Gx1RDXNtDcLLsMbyGD7Sx/G1hniaadvCAKecQch8KLg5lGFN184bBtM0NUMv62hcBZdOfFlRdgK
	SovKtj27mRdwhXvksWavhastHfeiXmgkh/q0nfv3pTbyXxKzKJE8fyAZ+ndkTPIZ6
X-Google-Smtp-Source: AGHT+IFt/nA/4mP7Te3Z++Sf5Wl84lmqdlJfWdo3kV/RGByxETrl2fM7u/pNtI8BqPMtdQMHsaSkfg==
X-Received: by 2002:a05:6a20:3c89:b0:24e:84c9:e99b with SMTP id adf61e73a8af0-2534585b850mr10028772637.48.1757306190567;
        Sun, 07 Sep 2025 21:36:30 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:56:7e97:c01c:f128:b5c5:e0c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9c2b1288sm127720805ad.106.2025.09.07.21.36.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 07 Sep 2025 21:36:30 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>,
	John Cai <johncai86@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 0/2] replay: add --update-refs option
Date: Mon,  8 Sep 2025 10:06:18 +0530
Message-ID: <20250908043620.57848-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds a --update-refs option to git replay. Right now, 
when you use git replay, you need to pipe its output to git update-ref 
like this:

    git replay --onto main topic1..topic2 | git update-ref --stdin

This works fine, but it means running two commands and doesn't give you 
atomic transactions by default. The new --update-refs option lets you do 
the ref updates directly:

    git replay --update-refs --onto main topic1..topic2

I discussed this feature with Christian Couder earlier, and we agreed that 
it would be useful for server-side operations where you want atomic updates.

The way it works:
- By default, it uses atomic transactions (all refs get updated or none do)
- There's a --batch option if you want some updates to succeed even if 
  others fail
- It works with bare repositories, which is important for server operations
  like Gitaly
- When it succeeds, it doesn't print anything (just like git update-ref 
  --stdin)
- You can't use --update-refs with the existing --update option

This should help with git replay's goal of being good for server-side 
operations. It also makes the command simpler to use since you don't need 
the pipeline anymore, and the atomic behavior is better for reliability.

Siddharth Asthana (2):
  replay: add --update-refs option for atomic ref updates
  replay: document --update-refs and --batch options

 Documentation/git-replay.adoc |  62 ++++++-
 builtin/replay.c              | 134 +++++++++++++-
 t/meson.build                 |   1 +
 t/t3650-replay-basics.sh      | 323 ++++++++++++++++++++++++++++++++++
 t/t3651-replay-update-refs.sh | 273 ++++++++++++++++++++++++++++
 5 files changed, 778 insertions(+), 15 deletions(-)
 create mode 100755 t/t3651-replay-update-refs.sh

-- 
2.51.0

