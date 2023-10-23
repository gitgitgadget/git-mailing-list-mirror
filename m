Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644D11BDE2
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXv5LgqF"
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE2E99
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:11:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32da4ffd7e5so2188651f8f.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698099116; x=1698703916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uo+W2feV77Xfw+0JMGZ45hvCuJpBMoPmCbc1Iks5z3U=;
        b=MXv5LgqFo7SvneRT1wS5PhigfbKsOOcXqSxiaC78WafI4zg0gXXDHVgY1ZG9tX/yh+
         RtA5P8m8bhz0t2jq3vj/ZemjxOOjOvxcfcf/Sze4llFZYPkcbpkTVbN+6h2395qnWGry
         bE4CmWJ/JwXHisGqLvcl49CBMwdMPZnF7v2GzcvDzHgEq5jjY3g7JOz9170FgbrnWQaB
         jP7MHabzd0Rg6pOEC05OA1u1sJmjA3Brenu4kNryPbJpcPWojRWbwmi5GKWsfpmk3kE3
         605MYwmj4qUAMCaeG+I6gDBm4P+/gr/EYCSXt3dXnG7cSepO+MtcRpSIkWTfzk+Hatsx
         Zj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698099116; x=1698703916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uo+W2feV77Xfw+0JMGZ45hvCuJpBMoPmCbc1Iks5z3U=;
        b=uHhnxGdjcomt7K+Gcp5fCFa2gamt7och0yNN5/4Eea33FNXOlZjk3Ik4DHjPAJRdAk
         rb4DTpaNUNhsuSBf08Q6VpxPmWDonlH7ou0e8czjlXY0SNWkf6IYBc2J9yOM/ACyjDUl
         s9GbKsUSZShigCaShKkl/35vzf9KNrvwM6fswm7zf4MXWIVzHDuKEL9F4/epdFlrUF6c
         vplIE1ezbZAEpAEVO0L8/aeuJycQKYbHxXgRboO71uK9Jpl+2yjR85v6FbiCbGCun5Eq
         I4hcV9Bbss/A7D0KPTBMcKBlh9Njv4WSltgntPeALNP8wrwZ+O/Xgvpp9tFwlLNbT0g7
         H6kg==
X-Gm-Message-State: AOJu0Yz1rmfJ+lv9WFOS+4sygUM6lMRq34HdzYmqTHeHv3R6kjhTYJWA
	0TEL0dnkt+Qc2dNTsatBNuoj86uRPA8TfA==
X-Google-Smtp-Source: AGHT+IHdpbSF3LwUPOn42gUEDkG1dIOJFktuadQiuYNfKDm7CZ9lXWmn2ubRcDor//3hl4kyZpmfWQ==
X-Received: by 2002:a5d:6a03:0:b0:32d:888d:7598 with SMTP id m3-20020a5d6a03000000b0032d888d7598mr11483782wru.4.1698099115714;
        Mon, 23 Oct 2023 15:11:55 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id w11-20020a5d608b000000b0032008f99216sm8559953wrt.96.2023.10.23.15.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 15:11:55 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	stolee@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v3 0/7] log: decorate pseudorefs and other refs
Date: Mon, 23 Oct 2023 23:11:36 +0100
Message-ID: <20231023221143.72489-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231022214432.56325-1-andy.koppe@gmail.com>
References: <20231022214432.56325-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements decoration with pseudorefs and adds three
slots to the color.decorate.<slot> config:
- 'symbol' for coloring the punctuation symbols used around the refs in
  decorations, which currently use the same color as the commit hash.
- 'ref' for coloring refs other than branches, remote-tracking branches,
  tags and the stash, which currently are not colored when included in
  decorations through custom decoration filter options.
- 'pseudoref' for coloring pseudorefs such as ORIG_HEAD or MERGE_HEAD.

CI: https://github.com/ak2/git/actions/runs/6618230811

Andy Koppe (7):
  config: restructure color.decorate documentation
  log: use designated inits for decoration_colors
  log: add color.decorate.symbol config variable
  log: add color.decorate.ref config variable
  refs: add pseudorefs array and iteration functions
  refs: exempt pseudorefs from pattern prefixing
  log: add color.decorate.pseudoref config variable

 Documentation/config/color.txt                | 32 +++++++-
 commit.h                                      |  3 +
 log-tree.c                                    | 57 ++++++++++----
 refs.c                                        | 59 +++++++++++++--
 refs.h                                        |  5 ++
 ..._--decorate=full_--clear-decorations_--all |  4 +-
 ...f.log_--decorate_--clear-decorations_--all |  4 +-
 t/t4202-log.sh                                | 21 +++---
 t/t4207-log-decoration-colors.sh              | 74 +++++++++++--------
 9 files changed, 192 insertions(+), 67 deletions(-)

-- 
2.42.GIT

