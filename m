Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C467B881E
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983031; cv=none; b=g9t9s+gtlUGgAyMXlFIb7KY1syCDZtAH6461v5oD2hc7WHnpQ+VNI1qByBVWMt7lB+FOtOKyD3pE8bwZKvFQqc/avbobliN+7sgn63Mmt0KgHOnIaNYCMrfJZSOSv6Mt9uFrQYzK8RBwvTximmPnd+boxoJZjvSK4Q/rKosFFpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983031; c=relaxed/simple;
	bh=3t0qUrhrz5CTwjte3idYh69I/Ac9AVdrjBcrV0tYFwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3K3ik45DI879BaVZMg7akxuJJUz3ely0UrYA7HZ/Yo9Jr7yq9Sut/V+qIUiMQBaYSSeVpcE24Is/3ESCvIZvfjLkoQf5GgpN1vYJMzxMBVXfqiC+RSqP//yFBmiKFO2yvB8dhra7JVvdAKGBy4+WflslY43IH3J+5MZCIZAz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNuEsYQp; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNuEsYQp"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-453647147c6so41672975e9.2
        for <git@vger.kernel.org>; Tue, 08 Jul 2025 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751983028; x=1752587828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sg8CVRD2mCYyVaItpKM8YpyqUN0zE+lsIVukwwIs3mI=;
        b=dNuEsYQpfac6NF7CzEda3jtHigsPWOfGCu6zHgPDiOdQy0IEgHDlNSqGo43N89uuNM
         NbYYW/cFADA6ogkd1YPquM4/1xX7j5je46DILADENJNxKsnqEmf06ncDhIixlQUuCMTr
         BR49jrBgHG/7+0RHk/MgHe/NrnffmF+5bsPYVNse6S2r4f3kVxWNJy6tqsoNPquVm7+M
         G7XTRb8OtKcW3eJWL8PI6SKeiPUGwywY4oDc/lGGdZ3V+1FVhsFP/U/zyXH1I9tXNDpf
         fxzM0LG/FR87TiElHjz7O8k+O19nl3m2uO+dojpn7br2Z30cYKJExOVDZGUWefsoFBqQ
         oHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751983028; x=1752587828;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sg8CVRD2mCYyVaItpKM8YpyqUN0zE+lsIVukwwIs3mI=;
        b=Iryj/yhP0rQU29/hWErk+LmGxjJqbWjR6KcwJ5r9MLi+Dn6NXyWF04ocFAAixKT/CR
         eKsXDxEnyd6yRBRiEIttqcsLnUuZ3X1JoLVuNu2rPKUa12Tyo+i7SyrNoKRFpBuPuC2O
         CMvL1v0EGB2f1d6gkEHL4J229UZV2IT9NY1BLsHK5ss1mdB+8kubMU0KfGrOM2qY7e4D
         FnMoM/YjQuSXdo/4Pp1U2yoE9pst2t8IxOmMKA+PHC7x4ClujmcmoZe1tiL7oNDnGmtU
         oku3Ha6J5ZC/wB13rET/5uOpAePbSIRr8unInCKZs1+RqGfZAHYn5f/Z80Uw/8G29it/
         AY6A==
X-Gm-Message-State: AOJu0YzjP1+gS4zuZLJh6LklDgq4Kg5pXGB4L+sL+nvDdGAXHcfgwvjP
	JxJBqJP8cMPe9KUXnX3lWfWmz8tmxHMQoeth6e/JFP2WgTGM5nfL4a3NJd/ICg==
X-Gm-Gg: ASbGnctpJezNzP1M5zPa1LWzNJwORHMtDx3CsNlHE3C3et/RQNLG5nrPK9Qut22fFrz
	Eu+Cgpr1iOXpnS849Oym5eel8XDgknMym3EI6tj1AGcWoGHVaOMoYjEukp8uXm60UjC/Ko3csoF
	rnqvv2WLOFRZLYBUbuP/BKhOBeBNUJ9mqh7YSuMyTndp3qLiW9HbJEjEHwPD+KRqqj3GwYd2ocG
	mwijDU+J+f7J5BbpdHW5rV8Lz6j9jUSL686uhSfIeFegGqA5cQ6KNG7RMhNbaFo67G2g0SfY+td
	wEacjbLeCWloGV6OYodkj8mDpn8uV2kQ5gY5Cr7PhAUSQ2zC3IMXDpFKdKN446Vve+xBs61yf8T
	g3VIRedg=
X-Google-Smtp-Source: AGHT+IGwjA0AsHcjFpwKopAvBmAPQs8OIS6PlmgNM39zSxReO+H/A6KyALRFF+7aQaelNDj/NyS33w==
X-Received: by 2002:a05:600c:4ec7:b0:44b:eb56:1d45 with SMTP id 5b1f17b1804b1-454cd4d6e82mr39275425e9.15.1751983027740;
        Tue, 08 Jul 2025 06:57:07 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b470f871casm13089252f8f.45.2025.07.08.06.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 06:57:07 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH 0/2] breaking-changes: deprecate support for core.commentChar=auto
Date: Tue,  8 Jul 2025 14:56:50 +0100
Message-ID: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This series implements the plan to deprecate and remove support for
core.commentChar=auto outlined in [1]. This feature has been the
source of a couple of bug reports recently [2,3] and as explained in
the first patch the design is tricky to fix. When git sees the
deprecated config setting it will print advice like the example below
to help the user either remove the setting or set a custom comment
string.

hint: Support for 'core.commentChar=auto' is deprecated and will be removed in git 3.0
hint:
hint: To use the default comment string (#) please run
hint:
hint:     git config unset --file ~/.config/git/config --all core.commentString
hint:     git config unset --file ~/.config/git/config core.commentChar
hint:     git config unset --global core.commentChar
hint:
hint: To set a custom comment string please run
hint:
hint:     git config set --global core.commentChar <comment string>
hint:
hint: where '<comment string>' is the string you wish to use.

[1] https://lore.kernel.org/git/6a3154e0-e7bc-45ae-b554-67ccab18727a@gmail.com
[2] https://lore.kernel.org/git/20250315140913.577404-1-oswald.buddenhagen@gmx.de
[3] https://lore.kernel.org/git/20250626132233.414789-1-ayu.chandekar@gmail.com

Base-Commit: f0135a9047ca37d4d117dcf21f7e3e89fad85d00
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fremove-auto-comment-char%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/f0135a904...83d0d3ece
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/remove-auto-comment-char/v1


Phillip Wood (2):
  breaking-changes: deprecate support for core.commentString=auto
  commit: print advice when core.commentString=auto

 Documentation/BreakingChanges.adoc |   4 +
 Documentation/config/core.adoc     |  20 ++-
 builtin/commit.c                   | 192 +++++++++++++++++++++++++++++
 config.c                           |   4 +
 environment.c                      |   2 +
 environment.h                      |   2 +
 t/t3404-rebase-interactive.sh      |   2 +-
 t/t7502-commit-porcelain.sh        |  32 ++++-
 8 files changed, 252 insertions(+), 6 deletions(-)

-- 
2.49.0.897.gfad3eb7d210

