Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184D41C1F05
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749289542; cv=none; b=oaVmpgvC0P9WDt+g9xgUltLgm46mfzsm7z8rG9v8+Yg4GuULbgY0r8bamqllhu221/oVSJNrItfERv6FTE8t9dtlykj6XCrtX5U5lM/CCZv0uDSIst7nEbjzabWLglp3v0M2zMkza9BP98VjFrCp998yarXfWL3o4ASXmwZ9THo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749289542; c=relaxed/simple;
	bh=mwzKzXdP2gLNiUZWirm+AfpV99ldwaj/gfmDdtlpVBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8Q3LCOIM+ny39tJM5mbLyp6oVIq3LR5W++c+fg7nfv4pBkwdWm6XXDN58YGS1jld8UA3RW4qDJ67+I/9QCr4Ny05LFLit7QaO0o9H6v46edtz3UNvFlv5WZcoylgag9l0iepq0oOtU1Yr+DBp7B9F4EnZMFFOLaLKrTOFq1/bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVtE/Oz4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVtE/Oz4"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450d37d4699so17934045e9.0
        for <git@vger.kernel.org>; Sat, 07 Jun 2025 02:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749289539; x=1749894339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ctedll3TJtbigetODdVryVKfsPBzghT+ji0+GQvrh7o=;
        b=jVtE/Oz40qn8yWOV3+gix6knPuYLMwXwZuSNyy8xzGUazGrgRVY42iNnIsIwWl+93j
         p6xNC+Fi5SOASiOG4dNFJuCFzKWEggqTNZEPNagQqYzZdZ2s+d47vFksUFj+Aqr1kqOr
         a6dJqRzM6sJKjQFPTB91Ih83PohYD4c3ip74mt/M1eZUqZUiHfrSfg96R2UWIsi3Eo27
         gflzeoQZ/x8q1Fa5QIK1weFwjh90gk+8rDt/JBhal3Xwr/c5skeP/b1FLm//q33nR26+
         mMErpW4FXNl5tfcIYxMAWld5DrMbVRr0oufxKSQezvvhsNO3Lia5OFbF6bpVy553GWjr
         LO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749289539; x=1749894339;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ctedll3TJtbigetODdVryVKfsPBzghT+ji0+GQvrh7o=;
        b=dUULOJIZ/eCkG6mR8jZk/ANO8Ylln0zT6q6GcDRk0NCBs1ysUYCj9aOeR1Q6yYNorL
         1h1ZO6bMXPaonY2R9PygROhevgg2c1BUuDVKFQ/zLiVVNO6OhTxaks+LAWUNGlJ+V+qm
         tk9rjyeMYO/Xi09grS1tlxrF5SihmSy3GkFa6bZjdfiE6FnRGy17LQie9QKTwREfQYVt
         iWzIhTw3tfNJMOlxhi+exfIeviywSx3ZzoZO5ZKH8clXrheOEDn2X12jU701Gmu1f3vJ
         RjN5lqMWOlPeRB/PIWFQOQxCMUz0wA6R4RMf1AcFy3s2qVON1TDGkXeEvmjl4Bddz7KG
         dyvA==
X-Gm-Message-State: AOJu0YzDrucFjHoX1d+vzTrgERya3Y5l7+FOVJ5Lfe7jU/cCL3PgJVUj
	eMjmHFo2yHHrOYMY7W2lF6SlTeeX2SMjllS/NR39tTdGJe4ffMhe9gxLI8I1JA==
X-Gm-Gg: ASbGncuQAHtfLJ5HqlCW4KseY4dvNdlMroyg8iQWJEtbRFji8DgnK8uS6L3DpElpO7B
	lSHZ2rMbu3h+8zcJdAmQ6xiUaLTdRa+//O1kd/N1yzxqlPcklrfKaR6uBhkyNgG0zFxkpKo0vLk
	10TNvjor2sZeu0GVEHYrxpKmg4x0nvhl4yoKUo/8k2keKXLzaz/GDRXvvXto7vX84e8gw8FlBIz
	xJtwwWDhl0VVHRJHY5hqFRBqBcn+cvQ2RknH50eZ+M1D+fb/8IfRhXJUn/p1N15jxqdQkY41NLf
	ip/YqMiMV9B/aPaeW9qAB5Q6doZA6Le4HgYaZzkUwjNojK2fDZVCq4VqpuZG+2RUdp9dsLYq5Im
	+/A==
X-Google-Smtp-Source: AGHT+IGXJhnA825+wFiCfNWbQ3h0W5x2pLTEFTkxdLSa+7LhhZKvGZF/KUa/XFoWHrPWa5oTs8KImQ==
X-Received: by 2002:a05:600c:1c83:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-452014390afmr58881085e9.14.1749289539121;
        Sat, 07 Jun 2025 02:45:39 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730c7761sm48351795e9.32.2025.06.07.02.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 02:45:38 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 0/2] stash: fix and improve "git stash -p <pathspec>"
Date: Sat,  7 Jun 2025 10:45:24 +0100
Message-ID: <cover.1749289514.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk>
References: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

"git stash -p <pathspec>" should imply "git stash push -p <pathspec>"
but that was broken by a code cleanup in c3713cede7 (stash: eliminate
crude option parsing, 2020-02-17). This regression is fixed in the
first patch. Although "-p" implies the "push" subcommand "--patch"
has never implied "push". That is fixed in the second patch.

Thanks to Martin for his comments on V2

Changes since V2:
 - Made test stricter as suggested by Martin

Thanks to Junio for his comments on V1.

Changes since V1:
 - Split out the regression fix into its own patch

Base-Commit: 1a8a4971cc6c179c4dd711f4a7f5d7178f4b3ab7
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fstash-assume-push-with-dash-p%2Fv3
View-Changes-At: https://github.com/phillipwood/git/compare/1a8a4971c...d3a958430
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/stash-assume-push-with-dash-p/v3


Phillip Wood (2):
  stash: allow "git stash -p <pathspec>" to assume push again
  stash: allow "git stash [<options>] --patch <pathspec>" to assume push

 builtin/stash.c  | 10 +++++++---
 t/t3903-stash.sh | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

Range-diff against v2:
1:  2cd67f5cd85 ! 1:  c147eaf2eae stash: allow "git stash -p <pathspec>" to assume push again
    @@ Commit message
         Fix this by regression by checking argv[1] instead of argv[0] and add a
         couple of tests to prevent future regressions.
     
    +    Helped-by: Martin Ågren <martin.agren@gmail.com>
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## builtin/stash.c ##
    @@ t/t3903-stash.sh: test_expect_success 'stash -- <pathspec> stashes and restores
      '
      
     +test_expect_success 'stash -p <pathspec> stash and restores the file' '
    -+	cat file >expect-file &&
    -+	echo changed-file >file &&
    ++	test_write_lines b c >file &&
    ++	git commit -m "add a few lines" file &&
    ++	test_write_lines a b c d >file &&
    ++	test_write_lines b c d >expect-file &&
     +	echo changed-other-file >other-file &&
    -+	echo a | git stash -p file &&
    ++	test_write_lines s y n | git stash -p file &&
     +	test_cmp expect-file file &&
     +	echo changed-other-file >expect &&
     +	test_cmp expect other-file &&
    ++	git checkout HEAD -- file &&
     +	git stash pop &&
     +	test_cmp expect other-file &&
    -+	echo changed-file >expect &&
    ++	test_write_lines a b c >expect &&
     +	test_cmp expect file
     +'
     +
2:  98ad3de9770 ! 2:  d3a95843055 stash: allow "git stash [<options>] --patch <pathspec>" to assume push
    @@ t/t3903-stash.sh: test_expect_success 'stash -- <pathspec> stashes and restores
      
     -test_expect_success 'stash -p <pathspec> stash and restores the file' '
     +test_expect_success 'stash --patch <pathspec> stash and restores the file' '
    - 	cat file >expect-file &&
    - 	echo changed-file >file &&
    + 	test_write_lines b c >file &&
    + 	git commit -m "add a few lines" file &&
    + 	test_write_lines a b c d >file &&
    + 	test_write_lines b c d >expect-file &&
      	echo changed-other-file >other-file &&
    --	echo a | git stash -p file &&
    -+	echo a | git stash -m "stash bar" --patch file &&
    +-	test_write_lines s y n | git stash -p file &&
    ++	test_write_lines s y n | git stash -m "stash bar" --patch file &&
      	test_cmp expect-file file &&
      	echo changed-other-file >expect &&
      	test_cmp expect other-file &&
-- 
2.49.0.897.gfad3eb7d210

