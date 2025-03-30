Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA51D1E4AB
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 20:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743367428; cv=none; b=uxeEmn1zvGvbJG6c4xepM/AtNkyatnMJ6tmRtiH8cVu6s5negOKymWBxo3kIW40T000TWYuFQa8kJV9wGWuXKmND5D4v9anGlai1vmmYnrDTp02gwbCrOb3AO8EMd2vTZdrMZwtJawI+cXfz+RIEnnVWn6F42YhArqMA1Nfc73c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743367428; c=relaxed/simple;
	bh=nKSaHQwwtp7ebVn81F8zGx4DSBejjys5krO64MyVqhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFLmbtufO/IClsCmrkA3LlVAD6+L3HcAqKNcMJhjNFNPtWfQi0sGSXpaWa8ADQj/DsFkR6Xh1gttVYclA44PN9nKWh7oWvrUs7N60ulOayimbS9WypmImEZyWXwA0hHVKooNIOGZ8fd0J1v3p7r6E7k+W/oUZM/GZ2/YiaXY5fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiQJ0qpg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiQJ0qpg"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so5159618a12.1
        for <git@vger.kernel.org>; Sun, 30 Mar 2025 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743367425; x=1743972225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOWYX1B/frbpACGxJ16x0u27l2w5cvmW4QmkHTw9d28=;
        b=JiQJ0qpgqRH/pISI+d3lduHnJu0WaP1CuXhI7M5bgOiHJCPfrhe4mmhFkidJLNd11E
         6R5r5u5GgJcJhpTtTmNBIEgtdDy1MScKxukWUyaqyOI54v4oA58q05yL+i+cyw+mxpvN
         3WlRVRCG1l/EVw04Z8pur1S5mgFoGlDJ4U1Jk+x1Pl3dThlFi+YuJ96WgJ7Q8ti3+62j
         5yTvpOxTxOZp/yR6pWz5ldiTXEEaO+Fsr0lrBLr/9zH+2q0CZkDwDuU4uMSLYKmwn/Kt
         TimriJrEPoRXh8fb7GmO7ce9TMYuL5sAKn5plvtuVniSAnONnKt/r3bbxuBOzQ/wAcGc
         MamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743367425; x=1743972225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOWYX1B/frbpACGxJ16x0u27l2w5cvmW4QmkHTw9d28=;
        b=t8MjElPSHIuetYFq2mZLLF3IIFI3pazXzCzoQNGHYWzCRA7cK++PF8S4x5ZEQ0cO12
         5VIaznXwGSIOmW+SooUG6Fb5by3A2zx0+Y95D6ppBsuRsBgL3ajSNadHY2Hj29WXkTKe
         gRGGUe+RJFf6HFwVNjMIn2GUzVT11ZlxH23ijFHnUDDN7OLJgkoXXycqbEkBzoLadBD6
         QqXlE2+gMvVROTDeb9vqQ8EimEIp6zZJpBOGSFSqZCuX8BfFR8pOLb6uJprGACa5ceL0
         J1bZSh2X2wZduvU82pqEV73QnreBQZBveZ91QzjrydlrTjDZki/ZlTELP8XSTmRZ535P
         FDEA==
X-Forwarded-Encrypted: i=1; AJvYcCX91Tdy3v2r9GQJ+0ZO13PMjQ2iGkVYnusk6wen7KAsShu5ZBMlsxp/QXmopZmPswVoNYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvk6Y2klg4253erilS903nCpgQuskHnNflihKa4Z3z5KBlvZ05
	PzvKpact5kFwEQ3I+riBghYk2u42aPQCiFEfJMQmcOk+mtpre1vX
X-Gm-Gg: ASbGncsjslIWoXYfGDYe/R8rchRggieaa63WL4y3poegI6Ewi2BOsUhRs9TvQPHtYth
	H4bBYOlS84Ivq1LhBkUJZRL6tEi0jU0iRNembdyLHKbL/MmXn8lR05eJl/Wng3juxlT4NYsHa4Q
	6q3pwC+YAr/JMUwz4srIc0PIi8DBHCNXvRqwWWrjcy2ZpxOobSbG9VbCdkXjC1wBBnkE9K6tGBD
	IpsTJyWI7w789WlBjNf8Xlb9rKyQuFq99xEDeQek/Kt+FH9ERRTeK5zx66GZg80yCPINsm4sPcu
	RyLJEijNp2Y4CUBkza/FKUn8w4LXIgtJSjUaohDYp7kfG8xQCpBVT0ZfpY8giM/pug9Pe1zNFZY
	AVg==
X-Google-Smtp-Source: AGHT+IGTKCep/9cWxcSp8Le/PyOycCaHOInv/i1neIGwZPRiBxrXPHaYwO418Le7Vh7+XJKV+RxP3w==
X-Received: by 2002:a05:6402:27cf:b0:5ec:c976:268a with SMTP id 4fb4d7f45d1cf-5edfd136213mr4959559a12.15.1743367424894;
        Sun, 30 Mar 2025 13:43:44 -0700 (PDT)
Received: from knayak--20220801-595b8.fritz.box ([2a02:2455:8268:bc00:23ce:1a9:c070:6741])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16f02bdsm4698050a12.43.2025.03.30.13.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 13:43:44 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH v4] blame: print unblamable and ignored commits in porcelain mode
Date: Sun, 30 Mar 2025 22:43:39 +0200
Message-ID: <20250330204339.191382-1-karthik.188@gmail.com>
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
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v4:
- Remove extra newline in 'puts'. Modify the test to compare the
  entire output, the earlier test missed the extraneous newline.
- Link to v3: https://lore.kernel.org/r/20250329-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v3-1-10f695ae519a@gmail.com

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
Range-diff versus v3:

1:  bc359248f6 ! 1:  5250fb436e blame: print unblamable and ignored commits in porcelain mode
    @@ builtin/blame.c: static void emit_porcelain_details(struct blame_origin *suspect
     +static void emit_porcelain_per_line_details(struct blame_entry *ent)
     +{
     +	if (mark_unblamable_lines && ent->unblamable)
    -+		puts("unblamable\n");
    ++		puts("unblamable");
     +	if (mark_ignored_lines && ent->ignored)
    -+		puts("ignored\n");
    ++		puts("ignored");
     +}
     +
      static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
    @@ t/t8013-blame-ignore-revs.sh: test_expect_success mark_unblamable_lines '
     +	test_expect_success "mark_unblamable_lines with $opt" '
     +		sha=$(git rev-parse Y) &&
     +
    ++		git -c blame.markUnblamableLines=false blame $opt --ignore-rev Y file >raw &&
    ++		sed -e "s/^\ty3/unblamable\n&/" raw >expect &&
    ++		cp expect raw &&
    ++		sed -e "s/^\ty4/unblamable\n&/" raw >expect &&
    ++
     +		git -c blame.markUnblamableLines=true blame $opt --ignore-rev Y file >actual &&
    -+		test $(grep ^unblamable actual | wc -l) -eq 2
    ++		test_cmp expect actual
     +	'
     +done
     +
    @@ t/t8013-blame-ignore-revs.sh: test_expect_success mark_ignored_lines '
     +	test_expect_success "mark_ignored_lines with $opt" '
     +		sha=$(git rev-parse Y) &&
     +
    ++		git -c blame.markIgnoredLines=false blame $opt --ignore-rev Z file >raw &&
    ++		sed -e "s/^\tline-one-Z/ignored\n&/" raw >expect &&
    ++		cp expect raw &&
    ++		sed -e "s/^\tline-two-Z/ignored\n&/" raw >expect &&
    ++
     +		git -c blame.markIgnoredLines=true blame $opt --ignore-rev Z file >actual &&
    -+		test $(grep ^ignored actual | wc -l) -eq 2
    ++		test_cmp expect actual
     +	'
     +done
     +
---
 Documentation/blame-options.adoc |  3 ++-
 Documentation/git-blame.adoc     |  9 +++++----
 builtin/blame.c                  | 15 +++++++++++++++
 t/t8013-blame-ignore-revs.sh     | 30 ++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 5 deletions(-)

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
index 370b768149..50a0a7ca4a 100755
--- a/t/t8013-blame-ignore-revs.sh
+++ b/t/t8013-blame-ignore-revs.sh
@@ -158,6 +158,21 @@ test_expect_success mark_unblamable_lines '
 	test_cmp expect actual
 '
 
+for opt in --porcelain --line-porcelain
+do
+	test_expect_success "mark_unblamable_lines with $opt" '
+		sha=$(git rev-parse Y) &&
+
+		git -c blame.markUnblamableLines=false blame $opt --ignore-rev Y file >raw &&
+		sed -e "s/^\ty3/unblamable\n&/" raw >expect &&
+		cp expect raw &&
+		sed -e "s/^\ty4/unblamable\n&/" raw >expect &&
+
+		git -c blame.markUnblamableLines=true blame $opt --ignore-rev Y file >actual &&
+		test_cmp expect actual
+	'
+done
+
 # Commit Z will touch the first two lines.  Y touched all four.
 # 	A--B--X--Y--Z
 # The blame output when ignoring Z should be:
@@ -191,6 +206,21 @@ test_expect_success mark_ignored_lines '
 	! test_cmp expect actual
 '
 
+for opt in --porcelain --line-porcelain
+do
+	test_expect_success "mark_ignored_lines with $opt" '
+		sha=$(git rev-parse Y) &&
+
+		git -c blame.markIgnoredLines=false blame $opt --ignore-rev Z file >raw &&
+		sed -e "s/^\tline-one-Z/ignored\n&/" raw >expect &&
+		cp expect raw &&
+		sed -e "s/^\tline-two-Z/ignored\n&/" raw >expect &&
+
+		git -c blame.markIgnoredLines=true blame $opt --ignore-rev Z file >actual &&
+		test_cmp expect actual
+	'
+done
+
 # For ignored revs that added 'unblamable' lines and more recent commits changed
 # the blamable lines, mark the unblamable lines with a
 # '*'
-- 
2.48.1

