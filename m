Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B18A3D891F
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031648; cv=none; b=p99itxi0LaCJ1ifvo8DU8WxtQpMrL2TLKlyon2nRPsQlHOH0gY4RZx9A7/VGKvOhI/6bCIH6u4q9Es36+zuRDZztbP5YpPx245MSFq4C1J+AKZ+a/W/t+KUEea5RLv4uMZ4XPYaqq/XWlBPKX7VKE5qPyNC1nqRBmCHLfTuIkOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031648; c=relaxed/simple;
	bh=oxOiyZe2GkR8Zh+7nTF21XlEU4idzMbx0//DSLlgAqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNcJvK1+G0JFWYZIUYkQKUnO9ydb17yGv/CTZMfdmjB577RnEspsoIJ5VulIHWwV35eUQDvdtTjdR41wxq72wJUlGqft78R0rKeUKxcZ6xnXdsj4W+8WTFRHBnUVPp1L6/ubVr/zaEton/GS9f96raL3LV3aM9QZ9tiTLKckoeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K46yYfAk; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K46yYfAk"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381216921aaso4534698a91.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 05:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784031645; x=1784636445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hn4fGLgO2yYYjVj7LfLoetSqVNKYoFnKyEwF+zsFRt8=;
        b=K46yYfAk9d+aGvSicxSqk2K3WVaDg/z4FW+SNJdAlNP5wXPXQSgV8/ZIX1hV8B9OnF
         PluOP7A666pPKoRLlkGFzX/Il4yRTHKLrbswiqgo8HH+7bzk8n40uep7eS0xXHy3593w
         mLlUMSJgnG5lgyLhFARpT7TZiHRFENzrPCmH8u/bFmx6TcR1g8KXowBwwkp+KEqRDlHN
         v84bNubXb54LDUS1G5tr0keFOy3nrlUjzZmmlGyJhqGskqBQRAjSwS5R27G0g0W0RYcb
         LCi3XBquFq8nnTFn4dMp94KhKWnpgP+stIBlBr92j+E4+yG8rN7VlMpc7/g9vv5DIQHI
         7i0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784031645; x=1784636445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hn4fGLgO2yYYjVj7LfLoetSqVNKYoFnKyEwF+zsFRt8=;
        b=V/Wh9RiM83G4GQrqlrM0VWpLcQauQMqWZQVGhfx09orfIoXWGBSWjdizPUinKhT3pE
         4vtZHvj+pBFkGFZzTmjhHgQwBHWgDtWMnhjvrQ2Co0miKljMdCMxCQiPE8dbbcMKfoZ/
         Xtp3TpwMD7spNs7hOoZSmYrui1Kr/BHd6h2Es9NvLeEq2VmCZ1UCEUI27TjLpBy7P4Hp
         7wJ9f/XIeknanO4mW8IRY7zdzd2o43BrvVHectAlrK1JTNSuLL6QrBZwuT7XhZs4dxfk
         oDFHDeNCfm6oeBkUuJ0FCYhnpGAtusx9XbYHI0guuCXz8RmpT4DQJgAIxHkU1+h2kTJG
         C2bg==
X-Gm-Message-State: AOJu0Yzmp7QJkslc/ynkx+Q/i4gT+9KYIkpKof2G62Zi+/24qjUETX0s
	/IVhMhqX67iuP68/xX8wIq+g3sHkEfY37Wba1om9oyvdOwCXOUOvWTweLStc8kmX
X-Gm-Gg: AfdE7clLLXAFeKeJvLcpe15lc/98z6ZqkH1VM62p8zg5pAwXCBHSQmYgUnIViui8PxW
	iH1f55fEniDDKxJL9qEdDwCb3miykLpU0MZ4oVBs4utNgYqWrbu7APUJTS7L1oCNsMaW2riZ7qL
	Fkjm3ZXP0bqLblpsvdNMmgdo4S0ihwoxWoMaljUIsFW9CnVt+sh4rYO73m37hjBO9K1WybPLiJY
	OiteNbioCi2RQrpiJEk8AW2fx9K63Al5wt0MCDWtE6knxknXI0lx4S6IAfXsCEoIFHufg/YRagM
	X0kp5oOg9M999CiJhQThkx2SjBBn/P3zakt4tM0q6RI1yv7S0gr+pl5jzYZnLImdY9Y8j4rQdBb
	4JoxIsh8h/Zh6NU6VMKf4TYiTc1uxDMlFujOzUmUHtns1eauBHzm1aWBnljZaPIBvQNYswf7hL8
	Bzwl2/oElrX5Vg2IKFYqYYvC8vXN9ae6ao1aRhUGBh6j4dfs7LDwnzKMMJh+U=
X-Received: by 2002:a17:90b:580c:b0:38e:2524:724f with SMTP id 98e67ed59e1d1-38e2524791bmr382081a91.12.1784031644517;
        Tue, 14 Jul 2026 05:20:44 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c0a:50c7:895a:a6b8:b3bb:5640])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm74390182eec.6.2026.07.14.05.20.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 05:20:44 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Shlok Kulshreshtha <diy2903@gmail.com>
Subject: [PATCH v3 1/2] t1100: modernize test style
Date: Tue, 14 Jul 2026 17:50:32 +0530
Message-ID: <20260714122033.61947-2-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260714122033.61947-1-diy2903@gmail.com>
References: <20260714071633.35446-1-diy2903@gmail.com>
 <20260714122033.61947-1-diy2903@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tests in this script use the old style in which the test title and
body are passed as separate backslash-continued arguments, with bodies
indented using spaces:

    test_expect_success \
        'title' \
        'body'

Convert them to the modern style in which the body is a single-quoted
block on its own lines, indented with a tab:

    test_expect_success 'title' '
        body
    '

While at it, remove an extraneous blank line between two tests.

This is a style-only change; no test logic is modified.

Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
---
 t/t1100-commit-tree-options.sh | 43 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/t/t1100-commit-tree-options.sh b/t/t1100-commit-tree-options.sh
index ae66ba5bab..9a639f946c 100755
--- a/t/t1100-commit-tree-options.sh
+++ b/t/t1100-commit-tree-options.sh
@@ -22,29 +22,28 @@ committer Committer Name <committer@email> 1117150200 +0000
 comment text
 EOF
 
-test_expect_success \
-    'test preparation: write empty tree' \
-    'git write-tree >treeid'
-
-test_expect_success \
-    'construct commit' \
-    'echo comment text |
-     GIT_AUTHOR_NAME="Author Name" \
-     GIT_AUTHOR_EMAIL="author@email" \
-     GIT_AUTHOR_DATE="2005-05-26 23:00" \
-     GIT_COMMITTER_NAME="Committer Name" \
-     GIT_COMMITTER_EMAIL="committer@email" \
-     GIT_COMMITTER_DATE="2005-05-26 23:30" \
-     TZ=GMT git commit-tree $(cat treeid) >commitid 2>/dev/null'
-
-test_expect_success \
-    'read commit' \
-    'git cat-file commit $(cat commitid) >commit'
-
-test_expect_success \
-    'compare commit' \
-    'test_cmp expected commit'
+test_expect_success 'test preparation: write empty tree' '
+	git write-tree >treeid
+'
+
+test_expect_success 'construct commit' '
+	echo comment text |
+	GIT_AUTHOR_NAME="Author Name" \
+	GIT_AUTHOR_EMAIL="author@email" \
+	GIT_AUTHOR_DATE="2005-05-26 23:00" \
+	GIT_COMMITTER_NAME="Committer Name" \
+	GIT_COMMITTER_EMAIL="committer@email" \
+	GIT_COMMITTER_DATE="2005-05-26 23:30" \
+	TZ=GMT git commit-tree $(cat treeid) >commitid 2>/dev/null
+'
 
+test_expect_success 'read commit' '
+	git cat-file commit $(cat commitid) >commit
+'
+
+test_expect_success 'compare commit' '
+	test_cmp expected commit
+'
 
 test_expect_success 'flags and then non flags' '
 	test_tick &&
-- 
2.52.0

