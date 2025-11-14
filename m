Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E14F25BF14
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 05:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763099575; cv=none; b=Hqy8WIRTGvMk2Um6hG/NIEM7MUlIYTfnyqFz3YLwqDWJRbGHCDbC3ti9kaCpAvhV8EJG4qTy1fRZbMnf/it3N42qOIdf8Uft+RZ7nSVoTya3zT5ZNSvkKHUyxgxC/hY+ajbidHQkmEhYbAWAZ42s3QScfjCaCSpL1/rxRy5PPqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763099575; c=relaxed/simple;
	bh=VHHnAYr6t1eqcd8r5otMPObwutNSTGI+m9VQTkbDeU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZIwCfwgUN2cSovFv7r/6fcvKiDxhd4VVtUBKNUwyDurLtn51VWA4hRkyZNR4anddLIjCCKt9ADoWxtu4WR6/e8dVgxvCxcgxe+eo7NXjzKGOimkB/4DffxRB8MKJifAAGLmTu0jQ/d05NPxt//AjwUh7V0Dy63lqspMwAFFGDV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cr+VF4c3; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr+VF4c3"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63e16fbdd50so1470739d50.2
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 21:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763099573; x=1763704373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QFWjjwYd9UCJ0z32tr2Uv21RdRNIPVtpqweXC9wKNBQ=;
        b=Cr+VF4c3eujCExdsIlwUoZshje+uYs2vBHTvlf2kfgyqhB6k0gIsa2+6YzjYeWh/F4
         pyArlgJc1uB+qG602x3u6dCcnbZ12qpaSmYeIGawi+doqoSA33tYL48ys/HM0nuOjs4h
         oaHQ4TKyh8fnqTUhKZJW36GDDdatmY+uWOMpqq0L4Ds2RYhXCMsNHXuzAImRdeJC/40X
         CPD8JIOAm2/8MsiPe+7E/bxwBIjbqFfIOJ1K3KgKeNdASHMtBzaTtgP8DqQneV+xu6b4
         bbU6pX2U4H+bETzRggvy4HTQEpAu9EUoXH7UtGBM/t2wIm2I+C+1sgtqe7ZwsmhjZV9G
         LLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763099573; x=1763704373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFWjjwYd9UCJ0z32tr2Uv21RdRNIPVtpqweXC9wKNBQ=;
        b=DSbHCETFcmsUIh4d1oU+PTMeR/zER7LwPvl5VFqyxfMJlEBt/YhjhbHmkhVKlrbeoK
         0Z6WduUCDQIqdhVqCupsDEXYBUM2ZX8jqg3BGtvJCjN/2lTVYSfIe9xK19CZm6zyEiqG
         kBrHwFSMn1MmXzZdlGyaX2ikGU2K5sVtsfEUBog5EVkC3AEr+IiVckICKyYdbfhaVN6W
         /BE8vv0RQM+/Im/obpn3QoeNfobpU+05Ry8uesb26ImY4ChvKkpJaSIeSsoxbOX7JVDZ
         yFeeLllAoIgCgmSNXZh5H4i0AYPHHglk6Z2ZeUos0tr/GgoHXo7jze/dNRSwD2nGoc2W
         vbPg==
X-Forwarded-Encrypted: i=1; AJvYcCU61SKswlto5MlTOUKwEa7uxYM/p7Z4EncYvDYVvKQ6ldjZCK91gpKTZUNVjwAfP/toeRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/hNl3jYVgJ3FO8+feT4dxJYCX/d/I02hudpK0sMjZficU3kcc
	jHtAJBjrBefTBZAktE7QpjGlLAXPBYmyN6KGLUbAfQ8DFoWiOucfjais
X-Gm-Gg: ASbGncshs9lPXovfBt/VyH4q/Ft7A/vCjOxwzi29jp1O1eBUtc8tHzYrCX5XJotF8SN
	SwmUIjE48MKz/d4TnWqfgvLgT7qXTb6NIZTC74ktko24m4760ItR+cXcBT0MWPhdRNW6AJIIVpD
	GgCGGoUeaW1hOPuT4P2bvkdWvGwdx88gPWlRMLz6a1GNr3KlJb5ZPnUlFhZIjIDt9iRv+5trfA3
	ZswpE9XXLrCA/loVNbNlZlJ8L3JAR4N2hGT0BNrlRPPEtqgBlCX9WOQvRmm8dBbVRtPGzodgwzC
	TryxAupjpIFBdvuTWAsMpMGVaDnUib9akEq5MsSNpgesJ7haZVbADaR30Cp5Ysb50pQPSKMnswR
	bC4lWPvB/+ecRBGow3wYgoWHvVlmb7VE9zio5Q4Lok9megnR7MYlRytMcR4A5TPBiIwfbsGlxgz
	/Mrj8EPdQSqk1OPJfNh3UVJyc+HXlhuv5Yts7GDltlWf7v/fFVUhMYm/WzRCLQ6w==
X-Google-Smtp-Source: AGHT+IHk5MKKTG0gUgZmTUSKWmVyCZQWr6en52IfrY2eDBzN1+OcU+QWh/i9nmbVh7GkvgPYwImWPA==
X-Received: by 2002:a53:c055:0:20b0:63f:abf6:1cc with SMTP id 956f58d0204a3-641e74a35f5mr1348605d50.13.1763099573205;
        Thu, 13 Nov 2025 21:52:53 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6410ea037besm1411408d50.9.2025.11.13.21.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 21:52:52 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Justin Tobler <jltobler@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Subject: [PATCH 0/2] Fix misaligned output of git repo structure
Date: Fri, 14 Nov 2025 00:52:43 -0500
Message-ID: <cover.1763098804.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While localizing Git 2.52.0, I noticed that the output table from git
repo structure becomes misaligned when displaying UTF-8 characters. For
example:

    | 仓库结构   | 值  |
    | -------------- | ---- |
    | * 引用       |      |
    |   * 计数     |   67 |
    |     * 分支   |    6 |
    |     * 标签   |   30 |
    |     * 远程   |   19 |
    |     * 其它   |   12 |
    |                |      |
    | * 可达对象 |      |
    |   * 计数     | 2217 |
    |     * 提交   |  279 |
    |     * 树      |  740 |
    |     * 数据对象 | 1168 |
    |     * 标签   |   30 |

The previous implementation used simple width formatting with printf()
which didn't properly handle multi-byte UTF-8 characters, causing
misaligned table columns when displaying repository structure
information.

This change modifies the stats_table_print_structure function to use
strbuf_utf8_align() instead of basic printf width specifiers. This
ensures proper column alignment regardless of the character encoding of
the content being displayed.

BTW, I used two AI coding tools (Claude Code and Gemini-CLI) to generate
the commits, and added the "Co-developed-by" trailers in the commit
messages by using one of my opensource project:

 - https://github.com/ai-coding-workshop/commit-msg


## Changes

Jiang Xin (2):
  t/unit-tests: add UTF-8 width tests for CJK chars
  builtin/repo: fix table alignment for UTF-8 characters

 Makefile                    |  1 +
 builtin/repo.c              | 22 ++++++++--
 t/meson.build               |  1 +
 t/unit-tests/u-utf8-width.c | 85 +++++++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+), 4 deletions(-)
 create mode 100644 t/unit-tests/u-utf8-width.c

-- 
2.52.0.rc2.5.g4c20a63325.dirty

