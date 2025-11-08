Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE711F8691
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762637703; cv=none; b=mlQcxLx8buQ2Y3F2aJ8JnenwNTSXOcraQ5qGGf8/rv+X4mdWMfkU46jyoNeQ7hhD1PK1Ekn3UidrZNje1hi9Y8VkB9S5prhrEuA5SMuHBVysrciE1ekW/4wPhwzlcE3wj5HNUuN+jkpsWcncUHsWocVpiHNbZhlXWnWnDEIg9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762637703; c=relaxed/simple;
	bh=33z74LubyAw6yOWyjA+dGUnOKzNAE08PNZf3j5RYWgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Na/q08IfJRq5ZfjlwTRWpYP1JwZxCavFPtrA9hygCVSSnZsj9NKwrm8RiYWxCJqJKLEP65zCjpPFhO2VDcBOrh9brJT7wOqHRIKC/hfpykxEXdxf2JZzys4FHjW0TYMJWAGzukefF2y91cTMgXvOkojTzAeyuc9F1zVHhLo+DwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdTYWEzm; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdTYWEzm"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so801145a12.0
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 13:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762637700; x=1763242500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PTRaKB8l9skoqqS1px8sB8iQLEOuMULpa2+Vdv+/1KY=;
        b=GdTYWEzmaK+YojIQn+zPrwFeZyvfpZfaGCkn52oPYazoLGLrpB3IscjifHPduRFf1y
         vKZvYX67k3rONozp/ba3kJSRXEWhZdoAqM75zuRiUlEPmJOmIGyHJOzbC70VFZj0Qcn1
         NN2F1iIp5+L1Lhi5uij28l3UNtzIXLus75xNduo8s7EgByyuZ8tb1hKkCiVUXfqBxBR3
         ISrGq3MLylFNlqoYM8QIK0TSulLC4o8eyLysEiUszJLsVHdm4wcWVXIuHpx/K7FC007t
         oQo64WijdFm5NrS01a8Lf91vYrJP0w9xYHBLQMnameH6sqNlPatpZFStksIqM0PNs07r
         FgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762637700; x=1763242500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PTRaKB8l9skoqqS1px8sB8iQLEOuMULpa2+Vdv+/1KY=;
        b=KzuXyKeNmOBmmb2j25eCCR9pdg2vRth1xM7EUZI0wciFY0Wm73CbxhF3CP8h8OYME9
         L5ZEBvBnbYVbw2xpvz7rDnI2cZ1X+xmOtOz6vBXMfSNuN+ueTfO8pz1MHjAIMZoinH0c
         QKO5+EfC3HQc4A8DaWeKguDS2W4cffDyaxeuEati2mKtSfCuh4xTu64kPZ832bDmA2gA
         rjw2qMdSperg0i34bRgWZ9FXoNTc7AoqkZWcNHXHGt3/JE9wnulda8kcD3x5LJZPZQFO
         BYTDiScm6JqjBhbLQBgsDskjBG6sqKU/FcAzuOCdNgAbVYxQkkUbLaF7vwHZeNK1GbOb
         SsYg==
X-Gm-Message-State: AOJu0Yx0tZS5ayRFpbKnhR0oDWHwkqiMTIx/Eomz8YvR9kF223q1LezO
	ULPeVSspMHt4PGJl2sGLsiK4BTjcoLAiUQuCT/1hezAMMB+4AMvK2p4G
X-Gm-Gg: ASbGnctvSF4wpkOYbWmfXIsW4Xt4sfZf4Hpcaee6Jv2e3XEBgkQ7NAg8PjlVImpCAJ1
	t06uM/xATGiF/zqcN/jHT+ltqGpg9Unke+NpTz89jN6vbOgKkbXqmkxu1wIHaAGLLrynC/ghLjd
	AI9a5rmPd2gg+szaATx2BXgH2ggTh9S5kjBF7S1unErUqG3wbL0d3RBBKhqNltnvdpNEdkkzkYn
	fKEyziM0xjqd5xfn/6iMTIHTtCnFcMjvaOz7eYyZ1dSFGkWPQiyhYSuuYsiEFHb4JsftZkdLufQ
	AobTtaGpI+LKHuMC0et7QHgQIFsnPkXBNsyHUmTMlbIXF4Njsn1bGJG6CheU5PPtKChLxe8xjYN
	WUk3GKsBP38hRslOilp9c39nd5nMrETXOCyhTsVYRhBs9XyZAzI4kuwO4CBOrLL+zKPnyhDlpHw
	+Z9PKt
X-Google-Smtp-Source: AGHT+IEmtW2XIeA5BcXcF/5+ZxzWT5gMg/UFEQEEs2g2fBFqR+PCWNBlmT4T4aTx+zFtL+KuOS2okQ==
X-Received: by 2002:a05:6402:13c8:b0:640:abd5:863d with SMTP id 4fb4d7f45d1cf-6415e6fe635mr2708556a12.20.1762637699768;
        Sat, 08 Nov 2025 13:34:59 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:102:72e5:c961:8164:6be0:9490])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f7139bdsm7403661a12.4.2025.11.08.13.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 13:34:58 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 08 Nov 2025 22:34:44 +0100
Subject: [PATCH v3 2/2] fetch: fix non-conflicting tags not being committed
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-fix-tags-not-fetching-v3-2-a12ab6c4daef@gmail.com>
References: <20251108-fix-tags-not-fetching-v3-0-a12ab6c4daef@gmail.com>
In-Reply-To: <20251108-fix-tags-not-fetching-v3-0-a12ab6c4daef@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 sunshine@sunshineco.com, gitster@pobox.com, 
 David Bohman <debohman@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4158; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=33z74LubyAw6yOWyjA+dGUnOKzNAE08PNZf3j5RYWgo=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkPt3oE6n794joN/YqWs7tAkgxx4Q+DOjhsI
 3hyV2uRjdDvCIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpD7d6AAoJED7VnySO
 Rox/ucAL/jUvIb1fmIw5xm6Yn7fq3Nsama1iD5NXqiEDO+EYA4xgzrZl2A/a46eiMkrviHrgRKP
 pUWd0HddbA/bVE4mrViGr1pKGs0ShsWbpi5ChBeuMPdy6Sak5S1mXHC6jh4+zirFFhneE9kkjvX
 bqzB4I0fntI65r4IpbAtUsb6e5q4iIf3wW03IyKY1XjuNLPW5bwQGnXUB7AE5H6Af2LLE3/0gnn
 h4FyGOcbn6gjHc8Xh8WA6pZ+pzPpidORPMO0LV1lzTge8I5WfQL+iYoQtczbuyTFXvEIyZFvaMb
 +nUEF6hTBR0qat8rmrriAhvWYSsct/bB0BjajerAC5uNTO/XJ3jLQHlgOzk9jLF5P7g+1dljiID
 2soB3xRcc3tbrkBeqjNBa7uMZx0mQdE0sQOcoRIBACXLOdu2f8OOYXdRyyGOF56Al1CMD5AUzl9
 0rr9lK9bf/mzEOGokL/443/qjsmlvafcityjq3cGE/dFvrvYrxIL7dq29SJanTLHnlrk1jnNOc6
 VI=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The commit 0e358de64a (fetch: use batched reference updates, 2025-05-19)
updated the 'git-fetch(1)' command to use batched updates. This batches
updates to gain performance improvements. When fetching references, each
update is added to the transaction. Finally, when committing, individual
updates are allowed to fail with reason, while the transaction itself
succeeds.

One scenario which was missed here, was fetching tags. When fetching
conflicting tags, the `fetch_and_consume_refs()` function returns '1',
which skipped committing the transaction and directly jumped to the
cleanup section. This mean that no updates were applied. This also
extends to backfilling tags which is done when fetching specific
refspecs which contains tags in their history.

Fix this by committing the transaction even when we have an error code.
This ensures other references are applied. Add tests to check for this
regression. While here, add a missing cleanup from previous test.

Reported-by: David Bohman <debohman@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c  |  8 ++++++++
 t/t5510-fetch.sh | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 49e195199e..337ca2b0af 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1963,6 +1963,14 @@ static int do_fetch(struct transport *transport,
 	}
 
 cleanup:
+	/*
+	 * When using batched updates, we want to commit the non-rejected
+	 * updates and also handle the rejections.
+	 */
+	if (retcode > 0 && !atomic_fetch && transaction)
+		commit_ref_transaction(&transaction, false,
+				       transport->remote->name, &err);
+
 	if (retcode) {
 		if (err.len) {
 			error("%s", err.buf);
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index b7059cccaa..e62190d5d7 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1552,6 +1552,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensiti
 '
 
 test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with lock' '
+	test_when_finished rm -rf base repo &&
 	(
 		git init --ref-format=reftable base &&
 		cd base &&
@@ -1577,6 +1578,67 @@ test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with loc
 	)
 '
 
+test_expect_success 'fetch --tags fetches existing tags' '
+	test_when_finished rm -rf base repo &&
+
+	git init base &&
+	git -C base commit --allow-empty -m "empty-commit" &&
+
+	git clone --bare base repo &&
+
+	git -C base tag tag-1 &&
+	git -C repo for-each-ref >out &&
+	test_grep ! "tag-1" out &&
+	git -C repo fetch --tags &&
+	git -C repo for-each-ref >out &&
+	test_grep "tag-1" out
+'
+
+test_expect_success 'fetch --tags fetches non-conflicting tags' '
+	test_when_finished rm -rf base repo &&
+
+	git init base &&
+	git -C base commit --allow-empty -m "empty-commit" &&
+	git -C base tag tag-1 &&
+
+	git clone --bare base repo &&
+
+	git -C base tag tag-2 &&
+	git -C repo for-each-ref >out &&
+	test_grep ! "tag-2" out &&
+
+	git -C base commit --allow-empty -m "second empty-commit" &&
+	git -C base tag -f tag-1 &&
+
+	test_must_fail git -C repo fetch --tags 2>out &&
+	test_grep "tag-1  (would clobber existing tag)" out &&
+	git -C repo for-each-ref >out &&
+	test_grep "tag-2" out
+'
+
+test_expect_success "backfill tags when providing a refspec" '
+	git init source &&
+	git -C source commit --allow-empty --message common &&
+	git clone file://"$(pwd)"/source target &&
+	(
+	    cd source &&
+	    git commit --allow-empty --message history &&
+	    git tag history &&
+	    git commit --allow-empty --message fetch-me &&
+	    git tag fetch-me
+	) &&
+
+	# The "history" tag is backfilled eventhough we requested
+	# to only fetch HEAD
+	git -C target fetch origin HEAD:branch &&
+	git -C target tag -l >actual &&
+	cat >expect <<-\EOF &&
+	fetch-me
+	history
+	EOF
+	test_cmp expect actual
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.51.0

