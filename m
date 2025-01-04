Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8A5F9D9
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735949877; cv=none; b=ObRR1640CYbZCjKpYStZtggL6itXVq1TqOyc8i1mv4+vh7KnN96zWg6XsUyPhU5jqld/2ApfAYTQZ8ISrjFEC1/83qFvtI0briUZyFWzA7tzzS51aGjeok54KrS+PvIGjJ4MWLGwgYOUb/FNTE2y6wMfK9VJZjOWYmeusp6GYNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735949877; c=relaxed/simple;
	bh=xaJfgQn55hGrc12/wh6PnTZ1l8UDTMT08RpRuiu3jcU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VEemzleVTxMN3sB4U1Mdc5wFriOnmBR7gLChN7mrN4/4VaU9AvR0pjPC04btmSMwVTKwvnTbjKe77FAj/CpkxZj62Re4brF0dXci08pzC0Et7ndDr0nkqOy2w3XfknNCaiPKe5TZo6+J/wdjx/PzIsEGMrW0MpJb8qYZUgnXov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtmoAfkS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtmoAfkS"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361f664af5so143874205e9.1
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 16:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735949873; x=1736554673; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdWO6BxUbguSSg0d/HcUIKbcPzTRUX2XQlsSAmmeLHQ=;
        b=BtmoAfkS2/npW0kxSdD0t92Upc7enxTAyEPRwgT1MbZKBDrDBy3dKSnFbke0iVWOnc
         Q71/gv/Ydzy8rxCZ4weDiMomX68o+3uaa9NNj7upe33ee1dA6HcbXBSUs5+5+/0hGu/O
         YhX8K5jQBehBAL7TBDgNggUhwhZQVcFbidiqhwimz0GUzMhNZ7jRnkiISCjPrg1L5OHT
         PnEtb3fVenzIfxjg/fDDtQe99XEwhxWFzQTmeDr29H1vafVb6ucPUyoLDfz4PZi2l99E
         N5NDJ3uOcE6Bv3Eu9ME2fl6NgoZ/N/giXMH1oSVR8ExjKae0dfmBcLxosZerp26Jm0gy
         wjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735949873; x=1736554673;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdWO6BxUbguSSg0d/HcUIKbcPzTRUX2XQlsSAmmeLHQ=;
        b=Uwk7SelEFe5r5ZwlrKSDSNt9ZumkPMGWFhmt4R498aPfEcBPYbLkqOn+9VrHmfaVnt
         Q75aNyzMdX3EGOKppagrWnNy9ZG7HD29S8VajJgNkQBA8WOWLW5PhAO9OWLIsx41GMNY
         p9lGqLUrH0Yjuq8ub71U6WZSRGJyCHTt0wIfkZRWXjUS6/ppjzBdBKfTe3W0Ue8ASC6h
         xOXk9dIgaCoLtUWT3WGjmuBWLmAszY9nq4eMztrLvWu6z04349LC+c7mK2dDgeaQ1YPl
         OAeK7D9W64t4vCaSoU1O3CouV1DFyhJ+8NcOZWhZ98BMbJbacG15B2ub4StDi2+ugdyK
         5NIg==
X-Gm-Message-State: AOJu0YzxfF6VVbdSvfcxywcciIF1YfhLBl1LgBhVZ+5lyTdwMja5lVWz
	fQYXXO8ZiR9g07T1tQMrv/df2Q8cSq0F8UFxi/RmIV2YjxRGwO/1x6xGWA==
X-Gm-Gg: ASbGncuxLHuP3Khrs/6V1NRkYiVFyVJlMGQrRYAffBHDWxZv9rpUwT+R+AEG5TcFwvP
	G5lY+UHYKtVJ7OTa2BMu75Iai8bQ0270S6ePe5XOAe4N3+yT7fywCH1qnOMT9J4yrBiakQHL1LJ
	+g2c/Cf4yr1QzWtDCBOyoddBAd6csUfeZJ62MvI+1+3iDNjA3NhtLwyoMCjgYEXPnyoAW2z7cdi
	SzoJbpnCBLZyj2V6JyUvvdkFDikjbHLG4PbS0jPk/yrZp14JTrgmKVXjw==
X-Google-Smtp-Source: AGHT+IFodmSGUVvdv7/0ZMF1ZtMaTshbtnmrsbH0KEDOwCrkPSwEjurIEhb+aB7CeRTy1qjk/yhQsg==
X-Received: by 2002:a05:600c:3596:b0:434:f9c4:a850 with SMTP id 5b1f17b1804b1-4366864408emr548459815e9.10.1735949873281;
        Fri, 03 Jan 2025 16:17:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847d7fsm41684972f8f.60.2025.01.03.16.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 16:17:52 -0800 (PST)
Message-Id: <13f68bebe90549ba19452f12abb6fea41c2517fb.1735949870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com>
	<pull.1844.v2.git.1735949870.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Jan 2025 00:17:49 +0000
Subject: [PATCH v2 1/2] object-name: fix resolution of object names containing
 curly braces
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Given a branch name of 'foo{bar', commands like

    git cat-file -p foo{bar:README.md

should succeed (assuming that branch had a README.md file, of course).
However, the change in cce91a2caef9 (Change 'master@noon' syntax to
'master@{noon}'., 2006-05-19) presumed that curly braces would always
come after an '@' or '^' and be paired, causing e.g. 'foo{bar:README.md'
to entirely miss the ':' and assume there's no object being referenced.
In short, git would report:

    fatal: Not a valid object name foo{bar:README.md

Change the parsing to only make the assumption of paired curly braces
immediately after either a '@' or '^' character appears.

Add tests for this, as well as for a few other test cases that initial
versions of this patch broke:
  * 'foo@@{...}'
  * 'foo^{/${SEARCH_TEXT_WITH_COLON}}:${PATH}'

Reported-by: Gabriel Amaral <gabriel-amaral@github.com>
Helped-by: Michael Haggerty <mhagger@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 object-name.c       |  8 +++++---
 t/t1006-cat-file.sh | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/object-name.c b/object-name.c
index a563635a8cb..e54ef1f621e 100644
--- a/object-name.c
+++ b/object-name.c
@@ -2051,12 +2051,14 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 		return -1;
 	}
 	for (cp = name, bracket_depth = 0; *cp; cp++) {
-		if (*cp == '{')
+		if (*(cp+1) == '{' && (*cp == '@' || *cp == '^')) {
+			cp++;
 			bracket_depth++;
-		else if (bracket_depth && *cp == '}')
+		} else if (bracket_depth && *cp == '}') {
 			bracket_depth--;
-		else if (!bracket_depth && *cp == ':')
+		} else if (!bracket_depth && *cp == ':') {
 			break;
+		}
 	}
 	if (*cp == ':') {
 		struct object_id tree_oid;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ff9bf213aa2..398865d6ebe 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -240,7 +240,8 @@ test_expect_success "setup" '
 	git config extensions.objectformat $test_hash_algo &&
 	git config extensions.compatobjectformat $test_compat_hash_algo &&
 	echo_without_newline "$hello_content" > hello &&
-	git update-index --add hello
+	git update-index --add hello &&
+	git commit -m "add hello file"
 '
 
 run_blob_tests () {
@@ -602,6 +603,34 @@ test_expect_success FUNNYNAMES '--batch-check, -Z with newline in input' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup with curly braches in input' '
+	git branch "foo{bar" HEAD &&
+	git branch "foo@" HEAD
+'
+
+test_expect_success 'object reference with curly brace' '
+	git cat-file -p "foo{bar:hello" >actual &&
+	git cat-file -p HEAD:hello >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'object reference with at-sign' '
+	git cat-file -p "foo@@{0}:hello" >actual &&
+	git cat-file -p HEAD:hello >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup with commit with colon' '
+	git commit-tree -m "testing: just a bunch of junk" HEAD^{tree} >out &&
+	git branch other $(cat out)
+'
+
+test_expect_success 'object reference via commit text search' '
+	git cat-file -p "other^{/testing:}:hello" >actual &&
+	git cat-file -p HEAD:hello >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup blobs which are likely to delta' '
 	test-tool genrandom foo 10240 >foo &&
 	{ cat foo && echo plus; } >foo-plus &&
-- 
gitgitgadget

