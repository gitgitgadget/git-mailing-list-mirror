Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD492475C8
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696214; cv=none; b=dyfSNzHQ5UZGuKiQeO6MouEPaw/J4xnqOru5h/935F9Rv091zl1ND0/hax7z3xmyILpZb5O7j/pnkqcQILrwJbb4UCEh9/RJeSAqYauSasBifDQbrAxc4oxrjDp6Tiho4bSUVmWKGZMu2ZBSEHWTUylGKA/kTX80nkBXL3wCNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696214; c=relaxed/simple;
	bh=k80QDJA4Hm7BQDDrHA+JcC+kbMbR4mXRpXQ15Iv8mMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDlL9i9nfHuevX1rpccziKoFbmU9wmRa6AkQr3HyraByGhM4tV1qdJoMpFFxDxjfT2ufKmMsXIW2bKbNYPFifH5mbNj9wOw8vRb/Wu1yc4lAhtrLEyewX+2GnNVAyeCydZHwDAvIFM4xaSQLI/ec0oOjn1bef8S4oR4Alex1668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhTuTWkU; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhTuTWkU"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso192243166b.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 09:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743696211; x=1744301011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtjqCYCEU2z84ypK7+YCUrchKpko1/4HF0he7w9Yv7E=;
        b=BhTuTWkU0NW8VlBUZJzlNmQY7iOuS3ARjfXh6CijBIs5zMpaBRUCi9lDmBLdZL/wI7
         NgTDZ5Ifz6NLqaH7jTrf6HfnALWF4D1pTBshI6rLnrf6CSMfZUG78cx1q9THedjxH4c9
         K1v/bWaHbb+8jk4OlYYHJVfZ/KQEsB+8VZEZ0m50+JgsPXb3fY2EmWlqDPw0y4YoJsaj
         UOpkSFGqfH02A4HDizP1jYcLtrVd0bFv1B6z70ZHM+4qMa2M5O9gas3NK6aWCF/LVklp
         YvOKXDJ58ajlb/861KRFbIbSInmVvQWqql+Zl158H2b9DjDi71Wej4ifKxiP1OfaHc/D
         dSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743696211; x=1744301011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtjqCYCEU2z84ypK7+YCUrchKpko1/4HF0he7w9Yv7E=;
        b=hC26FeW4Z+fcNYk5BfYz4EumO0aCeVVmwOWHZVssgPDT8QFIY4ERC3uvuqO4Mc6soU
         HDqvvI/A1FuW8nUpaEkPp6+9EcmsRKaR3+i/UHpFKL4I4OVCTRlPVCe8VfzitF97guo6
         y5ZjKu4uls4biz+tT2riTDA5yPDAZHDT0iRiQESRp/P9M4fZjSFDs7ryU9YTZKo2SnXs
         6wnFPjhylMoBjg2CE8elVVbeZ1FDxTZ4ng0PY71pAp/6qGuh68VJA644Pgv8ge6eSHCl
         +uiuX/mX2nDAsniOARDJySnSVIrzudajXLcoJMepDY1XkQQHLNIEZIEHdDZkSp/GepFU
         icFg==
X-Forwarded-Encrypted: i=1; AJvYcCWMokvsYzMAj0ULci65yqwuXGRpcpM1C43SNuU+qkqhgQw/dvrqNOIgUkZq1Za7GLTrAOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN7TYG5mQEy42+jfL04+ArUn9JA0ex6URcrvPBeqmL3gcPHv6K
	FNOj/EUtrxxNneIlyn2iiHqp0WMMHEVx0B9r70uIJw9vlV/369qn
X-Gm-Gg: ASbGncutFgELLuHpw5sfnjDjXK3MVE6Cy97tegTZbdxNl0NURGlJ8Phk4BinQIvQy1I
	3pIvfs+/LhLtPjG6KzL8Bt1FwZqaw8ebm8/NWaKs/sFnQjkGsMEFTUdIyCB4wFh6v0MeHP8TGgg
	tqEMTQ/auV7s5qvs1Lx0uNH0eYas58JfjaqF4K8EDsvusIesa+gdeAvwWVhE40bUx+s0+R+PpRv
	aGGRiHnSmap+kxkFWI7D9YieM031Q2MsXYSN739brcWGZxFKv+FbjDaBwf12Lehnm8G9zq0g3gc
	E7aMqwzfSuyvKQiOL09OsUHIz0efpBEdgQZ6WTOzQCDxdL9TdDd8w+YPyb2bOVeP7G68T+4wzJK
	MQyk=
X-Google-Smtp-Source: AGHT+IE5BCG/KuOFFcSVOgYpKp/ZfGTF8f9+bz+6n/b1osNNkk9JtS0/WCLKRu5jn8sneotSjWw72w==
X-Received: by 2002:a17:907:2d94:b0:ac2:26a6:febf with SMTP id a640c23a62f3a-ac7b712907bmr368106266b.20.1743696210619;
        Thu, 03 Apr 2025 09:03:30 -0700 (PDT)
Received: from knayak--20220801-595b8.fritz.box ([2a02:2455:8268:bc00:62a7:64ce:53bf:d441])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c013f80dsm112070466b.119.2025.04.03.09.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 09:03:30 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com,
	toon@iotcl.com,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5] blame: print unblamable and ignored commits in porcelain mode
Date: Thu,  3 Apr 2025 18:03:26 +0200
Message-ID: <20250403160326.120124-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'git-blame(1)' command allows users to ignore specific revisions via
the '--ignore-rev <rev>' and '--ignore-revs-file <file>' flags. These
flags are often combined with the 'blame.markIgnoredLines' and
'blame.markUnblamableLines' config options. These config options prefix
ignored and unblamable lines with a '?' and '*', respectively.

However, this option was never extended to the porcelain mode of
'git-blame(1)'. Since the documentation does not indicate this
exclusion, it is a bug.

Fix this by printing 'ignored' and 'unblamable' respectively for the
options when using the porcelain modes.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Toon Claes <toon@iotcl.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v5:
- Fix the test to be more portable by not using '\n' in 'sed'. 
- Link to v4: https://lore.kernel.org/all/20250330204339.191382-1-karthik.188@gmail.com/

Changes in v4:
- Remove extra newline in 'puts'. Modify the test to compare the
  entire output, the earlier test missed the extraneous newline.
- Link to v3:
https://lore.kernel.org/r/20250329-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v3-1-10f695ae519a@gmail.com

Changes in v3:
- Use double-qoutes in the test to ensure correct variable dereference.
- Fix incorrect test name. 
- Rename the function from 'emit_per_line_details()' to
  'emit_porcelain_per_line_details()' to be more descriptive.
- Ues 'puts()' instead of 'printf()'.
- Link to v2:
https://lore.kernel.org/r/20250326-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v2-1-79037e17a74b@gmail.com

Changes in v2:
- Instead of printing the markers before the SHA in porcelain
  mode and breaking scripts and backward compatability, let's 
  instead add a newline printing 'unblamable' or 'ignored'.
  This is printed per line in both the porcelain modes. 
- Link to v1:
https://lore.kernel.org/r/20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com
---
Range-diff versus v4:

1:  5250fb436e ! 1:  43bc55bffe blame: print unblamable and ignored commits in porcelain mode
    @@ Commit message
     
         Helped-by: Patrick Steinhardt <ps@pks.im>
         Helped-by: Toon Claes <toon@iotcl.com>
    +    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## Documentation/blame-options.adoc ##
    @@ t/t8013-blame-ignore-revs.sh: test_expect_success mark_unblamable_lines '
      
     +for opt in --porcelain --line-porcelain
     +do
    -+	test_expect_success "mark_unblamable_lines with $opt" '
    ++	test_expect_success "mark_unblamable_lines with $opt" "
     +		sha=$(git rev-parse Y) &&
     +
     +		git -c blame.markUnblamableLines=false blame $opt --ignore-rev Y file >raw &&
    -+		sed -e "s/^\ty3/unblamable\n&/" raw >expect &&
    -+		cp expect raw &&
    -+		sed -e "s/^\ty4/unblamable\n&/" raw >expect &&
    ++		cat > sedscript <<- 'EOF' &&
    ++		/^	y3/i\\
    ++		unblamable
    ++		/^	y4/i\\
    ++		unblamable
    ++		EOF
    ++		sed -f sedscript raw >expect &&
     +
     +		git -c blame.markUnblamableLines=true blame $opt --ignore-rev Y file >actual &&
     +		test_cmp expect actual
    -+	'
    ++	"
     +done
     +
      # Commit Z will touch the first two lines.  Y touched all four.
    @@ t/t8013-blame-ignore-revs.sh: test_expect_success mark_ignored_lines '
      
     +for opt in --porcelain --line-porcelain
     +do
    -+	test_expect_success "mark_ignored_lines with $opt" '
    ++	test_expect_success "mark_ignored_lines with $opt" "
     +		sha=$(git rev-parse Y) &&
     +
     +		git -c blame.markIgnoredLines=false blame $opt --ignore-rev Z file >raw &&
    -+		sed -e "s/^\tline-one-Z/ignored\n&/" raw >expect &&
    -+		cp expect raw &&
    -+		sed -e "s/^\tline-two-Z/ignored\n&/" raw >expect &&
    ++		cat > sedscript <<- 'EOF' &&
    ++		/^	line-one-Z/i\\
    ++		ignored
    ++		/^	line-two-Z/i\\
    ++		ignored
    ++		EOF
    ++		sed -f sedscript raw >expect &&
     +
     +		git -c blame.markIgnoredLines=true blame $opt --ignore-rev Z file >actual &&
     +		test_cmp expect actual
    -+	'
    ++	"
     +done
     +
      # For ignored revs that added 'unblamable' lines and more recent commits changed

---
 Documentation/blame-options.adoc |  3 ++-
 Documentation/git-blame.adoc     |  9 ++++----
 builtin/blame.c                  | 15 +++++++++++++
 t/t8013-blame-ignore-revs.sh     | 38 ++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/Documentation/blame-options.adoc b/Documentation/blame-options.adoc
index aa77406d4e..19ea187238 100644
--- a/Documentation/blame-options.adoc
+++ b/Documentation/blame-options.adoc
@@ -125,7 +125,8 @@ take effect.
 	another commit will be marked with a `?` in the blame output.  If the
 	`blame.markUnblamableLines` config option is set, then those lines touched
 	by an ignored commit that we could not attribute to another revision are
-	marked with a '*'.
+	marked with a '*'. In the porcelain modes, we print 'ignored' and
+	'unblamable' on a newline respectively.
 
 --ignore-revs-file <file>::
 	Ignore revisions listed in `file`, which must be in the same format as an
diff --git a/Documentation/git-blame.adoc b/Documentation/git-blame.adoc
index f75ed44790..e438d28625 100644
--- a/Documentation/git-blame.adoc
+++ b/Documentation/git-blame.adoc
@@ -135,10 +135,11 @@ header elements later.
 The porcelain format generally suppresses commit information that has
 already been seen. For example, two lines that are blamed to the same
 commit will both be shown, but the details for that commit will be shown
-only once. This is more efficient, but may require more state be kept by
-the reader. The `--line-porcelain` option can be used to output full
-commit information for each line, allowing simpler (but less efficient)
-usage like:
+only once. Information which is specific to individual lines will not be
+grouped together, like revs to be marked 'ignored' or 'unblamable'. This
+is more efficient, but may require more state be kept by the reader. The
+`--line-porcelain` option can be used to output full commit information
+for each line, allowing simpler (but less efficient) usage like:
 
 	# count the number of lines attributed to each author
 	git blame --line-porcelain file |
diff --git a/builtin/blame.c b/builtin/blame.c
index c470654c7e..9436f70aec 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -351,6 +351,19 @@ static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
 		write_filename_info(suspect);
 }
 
+/*
+ * Information which needs to be printed per-line goes here. Any
+ * information which can be clubbed on a commit/file level, should
+ * be printed via 'emit_one_suspect_detail()'.
+ */
+static void emit_porcelain_per_line_details(struct blame_entry *ent)
+{
+	if (mark_unblamable_lines && ent->unblamable)
+		puts("unblamable");
+	if (mark_ignored_lines && ent->ignored)
+		puts("ignored");
+}
+
 static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 			   int opt)
 {
@@ -367,6 +380,7 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 	       ent->lno + 1,
 	       ent->num_lines);
 	emit_porcelain_details(suspect, repeat);
+	emit_porcelain_per_line_details(ent);
 
 	cp = blame_nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
@@ -377,6 +391,7 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 			       ent->lno + 1 + cnt);
 			if (repeat)
 				emit_porcelain_details(suspect, 1);
+			emit_porcelain_per_line_details(ent);
 		}
 		putchar('\t');
 		do {
diff --git a/t/t8013-blame-ignore-revs.sh b/t/t8013-blame-ignore-revs.sh
index 370b768149..cace00ae8d 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -158,6 +158,25 @@ test_expect_success mark_unblamable_lines '
 	test_cmp expect actual
 '
 
+for opt in --porcelain --line-porcelain
+do
+	test_expect_success "mark_unblamable_lines with $opt" "
+		sha=$(git rev-parse Y) &&
+
+		git -c blame.markUnblamableLines=false blame $opt --ignore-rev Y file >raw &&
+		cat > sedscript <<- 'EOF' &&
+		/^	y3/i\\
+		unblamable
+		/^	y4/i\\
+		unblamable
+		EOF
+		sed -f sedscript raw >expect &&
+
+		git -c blame.markUnblamableLines=true blame $opt --ignore-rev Y file >actual &&
+		test_cmp expect actual
+	"
+done
+
 # Commit Z will touch the first two lines.  Y touched all four.
 # 	A--B--X--Y--Z
 # The blame output when ignoring Z should be:
@@ -191,6 +210,25 @@ test_expect_success mark_ignored_lines '
 	! test_cmp expect actual
 '
 
+for opt in --porcelain --line-porcelain
+do
+	test_expect_success "mark_ignored_lines with $opt" "
+		sha=$(git rev-parse Y) &&
+
+		git -c blame.markIgnoredLines=false blame $opt --ignore-rev Z file >raw &&
+		cat > sedscript <<- 'EOF' &&
+		/^	line-one-Z/i\\
+		ignored
+		/^	line-two-Z/i\\
+		ignored
+		EOF
+		sed -f sedscript raw >expect &&
+
+		git -c blame.markIgnoredLines=true blame $opt --ignore-rev Z file >actual &&
+		test_cmp expect actual
+	"
+done
+
 # For ignored revs that added 'unblamable' lines and more recent commits changed
 # the blamable lines, mark the unblamable lines with a
 # '*'
-- 
2.48.1

