Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EE73DDDBF
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559170; cv=none; b=bw+IR8G8imPJ0q+DFZI5auQaPW3LgEdFmWfcjB3Xsl1ewO50qdsyVkmnfyQDTUfD9GuR8wM4FlQkOE6YxK4lBA1vm28TD2ZxNDF/TYqmBiaTYV8mnnn/45zOCebgSna+kWb252P5p8kwNqszdP6KaNDzysU0nPYw9UXgrBJuRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559170; c=relaxed/simple;
	bh=qaB1nsiXAcgKjaL+Qht+y9BlAoNECNd5rcmEi+61Miw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=G990Rfs9rHPp1qkdVBIcKxb7Bkw8x3sYOHIVN+MTRu6lUGSRlDEmFLiumLZsXzRv0aCNOYJleaivtMZgjgkPcP2uRT2w0OOMbqJl1atpKcEKdV3UyQXuyRfNCROJMggGk/icYFDxSOUgreI3vNP3ZccRcYWWmXaJRbW8cTrPmMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig2QU2FX; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig2QU2FX"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9158643e538so40870585a.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 00:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780559168; x=1781163968; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LTIQGno0E9IVyA8/YHvOOSseNq4q5Fmb1ybXTEFeAI=;
        b=ig2QU2FXyV/MUQbTXCGHnXrqR7+2ljDolOj6zl1tDZvxo6M4t4eKiTMeqFG3/OAAk1
         PWU104duApg961dP03+o6gFJ16HMeN6otRVesLOLkUI38nDgPGWr6oHvJOJNsSczA15C
         PqdeVJhyNUvjHzDYvKXZq5NIptyD3x5dWap+ssQCQXIJ6gIUTRYMaEZpXH9L3jixrM8U
         BTsrazvTRUx9d7KZIIWDQIgudrmFyT6ZhlBet2IfzccxaQbtss8RIekTBndQhgWpn9/2
         NEahtS3ND7onm26/Ki3CEA90G1E8HxedsFuDCOXFXFUd7nW3Y8auNe+qNYUnTRUPZoly
         Juqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780559168; x=1781163968;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/LTIQGno0E9IVyA8/YHvOOSseNq4q5Fmb1ybXTEFeAI=;
        b=MV3DgqS2H0WrZnuvvOUmYXtIu0wbo4rCLAIaSsiAq6GaQ00/osX0t3z7z1TsLMYca7
         x6jFZX5ormcXZsuCtIBdrKQhZFJwG18Er2C17Zu+hZnP8uhE9s6siVxowQhE5oefx8NV
         x/3xxAmDvWRxSXQ0Q7H83nQryuyK7pQbvbymrohA+AcF3X1rZd3cPEJm5gCPyM2HETw3
         qLwkkNRUrwXW3iVwaBeYEulJoTfdOOSIIddWyVUxLfJxNKRKcy5e3V0f6+Q2K7MOMwBr
         HqT432MP9YVTsERMk8q7UZVfgtDDxE/PZN09UeTRpi1TkI0vRVD39mHKIp3gBsFYgvPx
         uz5w==
X-Gm-Message-State: AOJu0Yy2q6x8fChH4Yhv/UXTq+IvS2S+GsWYhXJI0JhEqRKSA9JSGGgX
	tS7pvzbDlAOWJGeyQlrNV1hzjSY28xelCYyDRdiwnvUZl003/CcFMJXyduT4kB3u
X-Gm-Gg: Acq92OGfPxE0yVQHtaI4T8d/VrTsyK0C8yX6iOFJMgFALni60Y06VCpEPo3ZRbWc1CD
	ePZxsNE0GkAWIUuUkki/dmFfqkZBPDQs2rfl7WmegozYVDhrwK0pMjvJfVkukCa0nHnk+pATBNu
	2beiPMAftSBmVy2oaf0BdQeJw/foJeeX6ShQoa3uo4+v5qrt6xqwAtrO1qtuyzTe4Q2Ym3QpPxK
	irlTFmepspXZ599BSx4m4PBCf+8qjhA+BHblDbBWhHcTu7xVUx6gymJM/zWh85ZsA31h6msIK5I
	mANrfUt8tFX28EAXyhbg9r5/ms1C8r+yKNHQI5LTKqvtiEWnXq/1HE4DkhZ0teFbfLmsteqxlYz
	s5xYox2iTZtVWxEPs4dF0w3qGU7bveXDKA4vfx+J2Yo0DDJJeDbYyDvnb+nCD/CO5jRNdqZmtcK
	SmCbTcgdsZfyZ9cwCxxMT05LeMeV8LgELOuKec
X-Received: by 2002:a05:620a:4482:b0:914:d093:abbe with SMTP id af79cd13be357-9158a659b63mr1123214485a.12.1780559168149;
        Thu, 04 Jun 2026 00:46:08 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.86.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00ba04sm505276985a.7.2026.06.04.00.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 00:46:07 -0700 (PDT)
Message-Id: <c0db9fdb5bf9a9b8218e32de043b8a9ca1aaf023.1780559158.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
References: <pull.2135.git.1780559158.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 07:45:57 +0000
Subject: [PATCH 5/6] t: fix grep assertions missing file arguments
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Three grep assertions were missing their file arguments, causing
them to read from empty stdin instead of the intended file:

- t2402: '! grep ...' should read from 'out', matching the
  grep on the preceding line.
- t7507: the closing quote is in the wrong place, making the
  entire 'diff --git actual' a single pattern with no file
  argument instead of pattern 'diff --git' and file 'actual'.
- t7700: '! grep ...' should read from 'packlist', matching
  the redirect on the preceding line.

Without file arguments these greps always succeed (empty stdin
matches nothing), so the assertions were not actually checking
anything.  All three tests pass with the corrected file arguments,
confirming the intended behavior is sound.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/t2402-worktree-list.sh  | 2 +-
 t/t7507-commit-verbose.sh | 2 +-
 t/t7700-repack.sh         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index e0c6abd2f5..93f92e854a 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -144,7 +144,7 @@ test_expect_success '"list" all worktrees with prunable annotation' '
 	rm -rf prunable &&
 	git worktree list >out &&
 	grep "/prunable  *[0-9a-f].* prunable$" out &&
-	! grep "/unprunable  *[0-9a-f].* prunable$"
+	! grep "/unprunable  *[0-9a-f].* prunable$" out
 '
 
 test_expect_success '"list" all worktrees --porcelain with prunable' '
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index b53d71c086..acdb6b1455 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -163,7 +163,7 @@ done
 
 test_expect_success "status ignores commit.verbose=true" '
 	git -c commit.verbose=true status >actual &&
-	! grep "^diff --git actual"
+	! grep "^diff --git" actual
 '
 
 test_done
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 63ef63fc50..c6ff3aed30 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -194,7 +194,7 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
 	git verify-pack -v -- .git/objects/pack/*.idx >packlist &&
-	! grep "^$coid " &&
+	! grep "^$coid " packlist &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $coid
 '
-- 
gitgitgadget

