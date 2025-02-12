Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B795227183B
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 03:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330830; cv=none; b=fbhTCLwX4CuhWZzjsKQg0b8WHvxBjnFyfvalcduFDknYo6q+Qva9TQwPtzR/xeJhj2AVw/WtDsuBtzUH0VqEpy9cyXwYtTD8pt0cQS/Mh/Og4Sr+AdGjFwFe6jqOJkgfuEweHR1Hg2DlHqPDv+xAEiG5lWFX27oe67GpVI/oNLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330830; c=relaxed/simple;
	bh=c3nH58w03+RVInu33wBQpZFjNc2dS60XPgZTZVYWa1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=la5Nc+775y6tdslrCRr/Wbea5T7IIgiA0Kf6y0724GEqEuOyIPMe66ONqw/z4xI6Wr1q4SN/NAV7CvxxEJ86VLGF8bF3iNh/C3ouONhqer6I1Dy+/L4K1oMBQw1yjHgPHBO8vrhLTYKv2k8wlqkU+b9a0EwggyXPQ8xnZ4yfozU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4V+IkGc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4V+IkGc"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220c2a87378so896265ad.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 19:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739330828; x=1739935628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNeXdEkgO9I5WWa7maTRWqk1ipv359903CYWH9kZi0o=;
        b=M4V+IkGcyqUsRyzN6vYUwuB8xaxqldQEX3PINuy84TFjL7PI8GdYaOlcdwLSXMFVgI
         Nz9Cf+H6bz2dcdoBUJUH1G1k6RpCGA/vR1J58GSpxZKz5sLK7wOfSuwROvySGFR8Agxh
         GutFSLC5vmGYnpYDZoTuMrmZxpEvUyelm4YwRWvhCEyiHU27dvoYz7YvwK9GQcH+SzWa
         4wFN9V2yq6ljuqLG2/NnQ3PL3t3qdTE+cLg/AEDhYe0wNjk6wIFPWiNhGAw0CLE6opIl
         6hMljQMADNQ7f2Y1zXbSCDh2g4s60O+pWtVUrlZcYwVp8G5HvC9J9sejXl741BCH8mMf
         QsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330828; x=1739935628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNeXdEkgO9I5WWa7maTRWqk1ipv359903CYWH9kZi0o=;
        b=sgUI0zjHCpK+lsptoiUtNUqfJT2+vbnt4QnXuwviRco/C43k00qG90EO4q6HFMic1C
         0R10JP/m93cvzdM4UuJ0oyeno60pfobAk5chHyMKznEOplv1D3YEq7KndFyXCfTbDX8l
         yk2amj+KAi7VLG0A7v3u89Wi2bnIYrxeUNg8j3c3uyoxHm+wdZoKTbchece6EQ3zwX5f
         dzAsj19gWMmfTQC6UhMRrm67+FjgEv+9jXOsu6CGU2Pt7SjtNQgWbkreDjnR1nAOzOZ7
         P9Vg9+bv0qHjSu2mOUpgzOmlqqK35ztRPxW4nrG5+QwmPrCInHB7tfiyd+VrMpUiSEmr
         FyPw==
X-Forwarded-Encrypted: i=1; AJvYcCVDWjjPmu3aQT3DsX559opsBSpNxUP8rL2ci26vA8+gXjnE1nsZWPIse/LRH+Q6lw6UdDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5eyyAwaxFZzSysxRuLIvu3WcBe9z6xsHVdba8rZoZwFLQciaW
	f9F9OKXsWenyEWs+E/R8ulq24j6uOGln0hr2u1XwIdn3u98UjMyw
X-Gm-Gg: ASbGncvkSm0rBzTfw7gKUkigu+EKzV5+Wxvib4lmkHprd5duEtXQvgNxiMyG6h2whbz
	3+S8ab4LHxsKiDEZC1irLPq54jr0OAvhYVpR6m/LTVlbfMz870XrpP3wK1c/9o0fly+h6+WjcpU
	UpnzSIv0O93f8cVZqn7H+lGEfHdPP67sENeg7exovm9zvboetwODCuheGr0ws0IZMjlwdaNaq/B
	is34NFkPJ0wXjNTKbnOcc6pIdHlWvTto1wjAwx/wjcGegQ7cmn0o/x9EdzL2QX0Hm9crmOWXV0B
	dUTOeMCmc/nf8y6wvS9Axi4XUs/JLBhKgW2WJdg=
X-Google-Smtp-Source: AGHT+IF6tdkL5nnOH6nYD2aeIb5Fn30qi6X/dA7BHV7FIRygrccv+dCRN2CthMtaMuKKZwK/Exky6A==
X-Received: by 2002:aa7:88d3:0:b0:732:2923:b71a with SMTP id d2e1a72fcca58-7322c3f6cdamr2750521b3a.19.1739330827875;
        Tue, 11 Feb 2025 19:27:07 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:508a:741e:539b:1c5c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f6esm10129577b3a.74.2025.02.11.19.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 19:27:07 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v5 00/10] Long names for `git log -S` and `git log -G`
Date: Tue, 11 Feb 2025 19:26:44 -0800
Message-ID: <20250212032657.1807939-1-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206014324.1839232-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rebased v4 [1] on top of `master`.
I've accidentally published v4 based on `next`.

[1] https://lore.kernel.org/git/20250211085028.3923875-1-illia.bobyr@gmail.com/

Other than the rebase, it is identical to v4, details below.

Split the big change from v3 [1] into multiple, mostly independent patches, to
make it easier to review and merge each one separately.

Patches 1 through 4 are fixing minor bugs and inconsistencies.

Patch 5 contains updates gitdiffcore to use same placeholder names as the rest
of the code.

Patch 6 contains a minimum change to add long versions of -S and -G.

Patch 7 adds bash completion support.

Patches 8 through 10 increase usage of the long argument versions in tests, CLI
help and docs respectively.

Please, let me know if you prefer it split in a different way, or reorder the
changes.

Illia Bobyr (10):
  t/t4209-log-pickaxe: Naming typo: -G takes a regex
  diff: -G description: Correct copy/paste error
  diff: short help: Correct -S description
  diff: short help: Add -G and --pickaxe-grep
  docs: gitdiffcore: -G and -S: Use regex/string placeholders
  diff: --patch-{grep,modifies} arg names for -G and -S
  completion: Support --patch-{grep,modifies}
  diff: test: Use --patch-{grep,modifies} over -G/-S
  diff: --pickaxe-{all,regex} help: Add --patch-{grep,modifies}
  diff: docs: Use --patch-{grep,modifies} over -G/-S

 Documentation/diff-options.txt         |  36 +++++----
 Documentation/git-blame.txt            |   2 +-
 Documentation/gitdiffcore.txt          |  55 ++++++-------
 contrib/completion/git-completion.bash |  11 ++-
 diff.c                                 |  18 +++--
 diff.h                                 |  11 ++-
 t/t4062-diff-pickaxe.sh                |   8 +-
 t/t4209-log-pickaxe.sh                 | 106 +++++++++++++++++--------
 8 files changed, 155 insertions(+), 92 deletions(-)

-- 
2.45.2

