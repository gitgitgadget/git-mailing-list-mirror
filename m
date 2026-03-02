Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77838411603
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465811; cv=none; b=JECDxJq726n68h8Ktknwu+6ouB6gS5EXMHVWJdIPhIvHJwn/zz2staLICqVoR1JK10gdFMuoKRGZA4/tJYdHQUqg5tH5FmkUAdsq9tMZ63IhYaN0p+UjZhf0DscoLEthWaMcEXv6J5/hSB9zrwLwcRiE7wMAWNPsdKLuiIwVRu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465811; c=relaxed/simple;
	bh=nL/l8L9isnefRQJbrHLgTyQn96wA11x8KEEHRrthZnQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VyKYvD51hzzHzgnh8OnQwmfegP45SJ0cLAJfpGeUyOxf+zgYG1yCJMz7PcQDZ9eiX7+sEr9XzZurZncG8jNG4N4SWLOQLK/6GM6GEGJs3lHFaATcyunyDOxaHV0cdFzMGbGpGDS1cT/gtwphKu7h3O7eM43ygVDseqSXacSvMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn4wUh8C; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn4wUh8C"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2be0711f493so383768eec.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 07:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772465809; x=1773070609; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+d4Sv66rhjD5wiRebiqtbfSuBjUBTzMQir1i6glMjE=;
        b=Mn4wUh8CpaelwspjX1/7VfScuV1lybkXHHAGYlZTbOHDHhDimDYLN3kSiJ7zG1+Bm7
         qdbA8CbbYegrRLeZtCKJ4ehS3OctiYXrT2uGQDYlGJaGrFSyoSy0uDqBaHOlKzRuncjL
         Em208sospQD2uI/xl/aqOG/unrC4XFlZ9mSjExOko5OpW6w39rPJm/rSc0McUBf85SJj
         7OKJHi7XWuPC8b4nZxl/qtPilneUOuHS/w7NvlcP4Zliugg8zAPl7ZKryYG2YWuIuUai
         s0qn+l1i9NsVKHv40saH8ShZMmZVeI/1Sry2pQkxT2VupCzF3IzL+mortuWrgD3gxSqH
         AOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772465809; x=1773070609;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/+d4Sv66rhjD5wiRebiqtbfSuBjUBTzMQir1i6glMjE=;
        b=ULFfq7328maXjYrBoWLMkG6u1EOeFe9I8n4oKPB20M3FrvmsJCvQj0hR+UEt8JknTD
         Aqr/rSSJ9gayH5Meap2Lf7pCs6lJUUAttZEjqumNymmsq+fLVc6sCov1xcE5Snn8dalH
         OGQvA7z2olcPtdVlmhqL23FH7y0IznW83jM0/Dy6mv6bjemoyDXmVAxcQKnl/K+lD7Y3
         OjWD3vazW9l21FcqgbMF+EcadM9RZP/9qm2WumABeQuYocIUcXjdE95bP7Ru19sjyg6P
         Qr3JMRp35cxBzUCZJUYLdIXH9qdHl9S57tt+nH3PuwE1OE4mLEzv00WTg59ao5i5qbI8
         yFyg==
X-Gm-Message-State: AOJu0YxacnxOin/hcgvWJZOhqyB2giG9dPx8Q78iXEUCfM1rUcBaveF2
	fCsys0qSX8yRUjhsS96pAC28wp1ZoFEkmj8O9PgGJuNySMg1kPSubv4lHrVuig==
X-Gm-Gg: ATEYQzz1dr2oDQdkEzrl/M7qcF3CoKX33o+UiIL4fFr9uNw3gkbD8nCHWN5n88bs9Nj
	iXCNCb0ZfQj9r6/EfzvPNLFvjKh1mz2hvFb/VB9yr1wRi4eDEri3wcLE/XBLB0iYt09kMTOt+x1
	eWocPHa/pxJx7wWtT8pXu5Hmf07U6qs7NhWXWeuuNtebPi/5dnHsZsJKXdrlLLPPi2LMvYapX0S
	KPvTv8pMkSfKMkvMV/xFYCbrNtXWqTNsTDg4dbgIHzMQMKbrbCj8S19A+a9yFty/I6MwVvtXzhs
	NWsxa37k4rE0Zkxv7OZh5/mbazpvwR2Mhmx8zUot5j6PnzrU1M5m9ylAnsb1OHNUHupmHxgKsdx
	1vpEYRZNNf1K1Qk5HifsNFNveoz/djeIMBRV39HCNitv/MRXA+i9IA930sCQIS0LWY9h6a0R1vS
	ZbzrQp/i9oSL+W1N/q0lzHQT9o+G0=
X-Received: by 2002:a05:7301:3c88:b0:2ba:76e1:39fe with SMTP id 5a478bee46e88-2bdd0ecce69mr5329389eec.6.1772465809053;
        Mon, 02 Mar 2026 07:36:49 -0800 (PST)
Received: from [127.0.0.1] ([172.184.214.215])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1cefd7esm12325968eec.9.2026.03.02.07.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:36:48 -0800 (PST)
Message-Id: <6e9d4f3029daa2c0068bb16939b943e7ac924222.1772465805.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
References: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
	<pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 15:36:42 +0000
Subject: [PATCH v3 1/4] for-each-repo: test outside of repo context
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
Cc: gitster@pobox.com,
    fastcat@gmail.com,
    Eric Sunshine <sunshine@sunshineco.com>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'git for-each-repo' tool is frequently run outside of a repo context
in the real world. For example, it powers background maintenance.
Despite this typical case, we have not been testing it without a local
repository.

Update t0068 to stop creating a test repo and to use global config
everywhere. This has some subtle changes to test across the file.

This was noticed because an earlier attempt to remove the_repository
from builtin/for-each-repo.c did not catch a segmentation fault since
the passed 'repo' is NULL. This use of the_repository will need to stay
until we have a better way to handle config queries outside of a repo
context. Similar use still exists in builtin/config.c for the same
reason.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t0068-for-each-repo.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index f2f3e50031..512af34c82 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -2,6 +2,9 @@
 
 test_description='git for-each-repo builtin'
 
+# We need to test running 'git for-each-repo' outside of a repo context.
+TEST_NO_CREATE_REPO=1
+
 . ./test-lib.sh
 
 test_expect_success 'run based on configured value' '
@@ -10,9 +13,10 @@ test_expect_success 'run based on configured value' '
 	git init three &&
 	git init ~/four &&
 	git -C two commit --allow-empty -m "DID NOT RUN" &&
-	git config run.key "$TRASH_DIRECTORY/one" &&
-	git config --add run.key "$TRASH_DIRECTORY/three" &&
-	git config --add run.key "~/four" &&
+	git config --global run.key "$TRASH_DIRECTORY/one" &&
+	git config --global --add run.key "$TRASH_DIRECTORY/three" &&
+	git config --global --add run.key "~/four" &&
+
 	git for-each-repo --config=run.key commit --allow-empty -m "ran" &&
 	git -C one log -1 --pretty=format:%s >message &&
 	grep ran message &&
@@ -22,6 +26,7 @@ test_expect_success 'run based on configured value' '
 	grep ran message &&
 	git -C ~/four log -1 --pretty=format:%s >message &&
 	grep ran message &&
+
 	git for-each-repo --config=run.key -- commit --allow-empty -m "ran again" &&
 	git -C one log -1 --pretty=format:%s >message &&
 	grep again message &&
@@ -46,7 +51,7 @@ test_expect_success 'error on bad config keys' '
 '
 
 test_expect_success 'error on NULL value for config keys' '
-	cat >>.git/config <<-\EOF &&
+	cat >>.gitconfig <<-\EOF &&
 	[empty]
 		key
 	EOF
@@ -59,8 +64,8 @@ test_expect_success 'error on NULL value for config keys' '
 '
 
 test_expect_success '--keep-going' '
-	git config keep.going non-existing &&
-	git config --add keep.going . &&
+	git config --global keep.going non-existing &&
+	git config --global --add keep.going one &&
 
 	test_must_fail git for-each-repo --config=keep.going \
 		-- branch >out 2>err &&
@@ -70,7 +75,7 @@ test_expect_success '--keep-going' '
 	test_must_fail git for-each-repo --config=keep.going --keep-going \
 		-- branch >out 2>err &&
 	test_grep "cannot change to .*non-existing" err &&
-	git branch >expect &&
+	git -C one branch >expect &&
 	test_cmp expect out
 '
 
-- 
gitgitgadget

