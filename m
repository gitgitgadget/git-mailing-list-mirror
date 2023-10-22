Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DEB134DC
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6KI7iyF"
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14960E5
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 14:45:09 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32da9ef390fso1833312f8f.2
        for <git@vger.kernel.org>; Sun, 22 Oct 2023 14:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698011107; x=1698615907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K25zeyXlarRKqIkIj3AkaloSE1+7P6VsOq9Vds38CjA=;
        b=S6KI7iyFN4oSqWQVUtPmT2aATnRlk7W4Eif9jOR9D1WIJ0A/8iyklR3t9F9EEBfqUB
         8/hhCBrNnyzXXZLzkuhh364rH1fQlTmOKaL5ZsNcRPKHa+JChuyN+aV4GWqDcnoVngzX
         ENWTYRNY97yzPaRWu8L+Y2G+9+fXN3rJMeDddowTT4EC0u0lBKWq5zL2IRR5w7Cs9MJR
         RYOS1OLmsXu0Vj9yJFW/aS4ffflPEiE83iB/E2ZzzTNHGSJyy26ACCv51aGD9zsiGr1A
         c7woHUi5YhrFwVgBBujezzGRrjWEti72FglQeCE6KzcjtZwVrH/YdQENHhPRlLp5MyPx
         m4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698011107; x=1698615907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K25zeyXlarRKqIkIj3AkaloSE1+7P6VsOq9Vds38CjA=;
        b=XcDMzpwdOqkfM7WRe153KMSrlaVyHVHDAZX8vQ273D5ALcME7uVE0L7ELxKWnCkFfg
         rUrse1XYPQkSgSOSBjxWmtzfQAH1fDqZ8Nc/66vIaTj/Y1eKhqMuiCWwznt7rYd4sbCn
         XHJIl329Pi9tRK5opXyWjkrbOnq9eB5xrWFoNXLM0DurzRB1qMzCeadmI38rjvnWzP2d
         IHcAAzTqajV0evZ7n3jZo0tepvX8P87+0zXhaHF3Of70cvG7HBUIs3onR8x4ZcpZ+PPZ
         S3QXresphe3T2L1ec6aTU/0CrEfsGVAm3IBHDgicU9rkIwofbchagmQoY2ntFCxx0Aj3
         yePQ==
X-Gm-Message-State: AOJu0YyNdVKfbsDQLhvGbPO9prTzNHfICHAq15fzYGusJc7R/oExCqyo
	WkVsVmCFCGmkUFig/hRH1qO4H+tBL3E=
X-Google-Smtp-Source: AGHT+IFTtWACnO/dpuFjuQnAzMgkqpBddxHOsi2GvbMDHtaqQZUfnPNIf0HLXoSTp8+2qNoDKZv9/w==
X-Received: by 2002:adf:e3ce:0:b0:32d:858d:e002 with SMTP id k14-20020adfe3ce000000b0032d858de002mr5810242wrm.40.1698011106891;
        Sun, 22 Oct 2023 14:45:06 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id v3-20020adff683000000b0032d9523de65sm6291972wrp.48.2023.10.22.14.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 14:45:06 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v2 0/6] log: decorate pseudorefs and other refs
Date: Sun, 22 Oct 2023 22:44:26 +0100
Message-ID: <20231022214432.56325-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231019193911.1669705-1-andy.koppe@gmail.com>
References: <20231019193911.1669705-1-andy.koppe@gmail.com>
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

CI: https://github.com/ak2/git/actions/runs/6605893645

Andy Koppe (6):
  config: restructure color.decorate documentation
  log: add color.decorate.symbol config variable
  log: add color.decorate.ref config variable
  refs: add pseudorefs array and iteration functions
  refs: exempt pseudorefs from pattern prefixing
  log: add color.decorate.pseudoref config variable

 Documentation/config/color.txt                | 32 +++++++-
 commit.h                                      |  3 +
 log-tree.c                                    | 43 +++++++++--
 refs.c                                        | 59 +++++++++++++--
 refs.h                                        |  5 ++
 ..._--decorate=full_--clear-decorations_--all |  4 +-
 ...f.log_--decorate_--clear-decorations_--all |  4 +-
 t/t4202-log.sh                                | 21 +++---
 t/t4207-log-decoration-colors.sh              | 74 +++++++++++--------
 9 files changed, 185 insertions(+), 60 deletions(-)

-- 
2.42.GIT

