Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C769341687B
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 18:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792001528; cv=none; b=TcXJto4y4Tot1EuVw8ckn6HbsafvQ6g3lqrSg9rYrhND/I8tL5cutUZyVtWZsQvx3hyfYcytoXCOxMFofpHvxvlAS9PJKrTeDQ32SdksFskhHpO6XYdvNoOhtQMKbPa87WbmWjsjsedzah3T5L7xqUM20RacZ+cn7/cD6kniqcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792001528; c=relaxed/simple;
	bh=281Kmr57zbEPmVT5hMdnJsLkNU/m8Peni2uHCGE9UQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajya3xKJaRwfJUciDtO7JxHrxvkJz2ndqF/t/VbrOMc+utfLl6G2U+qX1uiGaXsgpsAVTWf5yW1eXaYUC5xzETZIsjW0nqk0UVSOeqCKJtR1kDD3DXMqpqvRxiJmg1EniG4cCjOUO4n0jb9hkMv1QyxRqfydtFeQ6meeNXTTlTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com; spf=pass smtp.mailfrom=gitlab.com; dkim=pass (1024-bit key) header.d=gitlab.com header.i=@gitlab.com header.b=dcELiU+a; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gitlab.com header.i=@gitlab.com header.b="dcELiU+a"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48afbd2c386so2644502f8f.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google; t=1792001525; x=1792606325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/PGZdV20Ne2Rx+H3Ne52u/i5FTm8l6IJDF4y/G/HfCU=;
        b=dcELiU+amlVY3YFEwuPzB53WKOI8OKDWwNNJPKjhfRkJCz7aWb8uBAXXIQpBTO7Egz
         Jcs+PhQC7IQdvXuj0GXRmVi3FU1xFIlsgA0OCnZfYdCJgCtnoJxLaV4idPigTsjKfXMx
         GqvvjWhqinAIMJIKSNBFkZE4e0M1LrHV5OQJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792001525; x=1792606325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/PGZdV20Ne2Rx+H3Ne52u/i5FTm8l6IJDF4y/G/HfCU=;
        b=jbAw+EMjeu+/ULbmxjhSkeahaMwWQltjYE2VLNVSSa1oTYY6zUTxDAiVOkWbKhvfIV
         E6mYjMq6LPMFAbBonA1UKbEqO2PHo9ItvbVu36TOqCMz6FBDvd/HfiTi3Y7CsYgWo157
         RuJWztY9QYSSBSHS+1N2Fo3a6ffqUdlM40VpMT/RKyr3T+YQQtIyJo7vBuYaBGYjeEw/
         ds3r6VdMS1RILV0Gj+5oedTRL4TT4LLVRyz/yGei8OVziWy6vQK1ix8T31PCdnB7RvyK
         /MjSjKlD4XHT7zeszMZ1ULkL36lW+EOAesOBSDFOcpYxHM5/o5m8nDprAYI9mhMNQUsW
         RTcg==
X-Gm-Message-State: AFq9FYJaw7E3KdJ7b0PWJwUt7WNmQsYZAzOqhej901IFfY+nTvDm2NXW
	pQ1mysnkw5qmT+tFRkxRQOAr00sPEs84LJaHNn0eV6oJU/bnRu5zXLUczm5kgrd8M/hy9SgIKVh
	v+q8kL/pFSQ==
X-Gm-Gg: AYBFou0jP095kl7VAA/eyCVkTUR72jBb/MQ17gR1kGxY2rAsauuc1hmRxK3Den/HfHW
	ajUL5tZYvkuoKHVFs4iPR6IlKJbbQFmgXaQJiZoHAJwfYpJCZu83NtSSmeO1IgbOaFiGe+8Flqa
	fWb6vgJM0vMWBssiPhD12S4so4Xgnj/R1rLi5IpCctAnkx8Q1XOcVMTqg8/Vnf90Ji1vUJwRIl+
	Vr1Qrlr1/zLpOzVdSoEKhfgDdMj1pIIc210X5SZHrKu6sUYVs2S0tL6D4miYeP9gE3FYAphO5qj
	nwxRCync1JcxGBZvevKLQ24uCDMxPfM1KYat3DZUx9t3OqsKC6JmszeGPykXs/qSYfe9Vc76h5u
	aj4DJHA87YQxkd1XoSzy2Rgvjld3wYi3eXywYFfPXUQ7A7hSAsapCtXFq0w8RWSZrbORoK+bnEF
	LPUq7XkVwT/3ttLtbyl6g/10ciGv5qwjDEioW0EwSUhJGKv7dUkv/aY11Y+lIpylubv8u1WrOir
	nXP2q2E01rBIx80DQPdd1n31tzfE+hybPXioA==
X-Received: by 2002:a05:6000:98b:b0:48d:ee3d:101b with SMTP id ffacd0b85a97d-48dee3d107fmr5183089f8f.25.1792001524827;
        Wed, 14 Oct 2026 11:12:04 -0700 (PDT)
Received: from iwiedler--20220823-X3P9M ([2001:9e8:a86:1382:f12e:5410:6774:61fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab4f34sm13806721f8f.28.2026.10.14.11.12.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 11:12:03 -0700 (PDT)
From: Igor Wiedler <iwiedler@gitlab.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	Igor Wiedler <iwiedler@gitlab.com>
Subject: [PATCH v2 2/2] odb: ignore refs of shallow and grafted alternates
Date: Wed, 14 Oct 2026 20:11:34 +0200
Message-ID: <20261014181134.56220-3-iwiedler@gitlab.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014103507.35317-1-iwiedler@gitlab.com>
References: <20261014103507.35317-1-iwiedler@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

odb_for_each_alternate_ref() reports the refs of every alternate
object store that is a repository. Its three callers use them as
commits whose history can be assumed to be present: "rev-list
--alternate-refs" (and through it the connectivity check after a
fetch), fetch-pack, which sends them as "have"s so that the server
does not resend what the alternate has, and receive-pack, which
advertises them as ".have".

That assumption does not hold for a shallow repository, whose refs
point at commits with no history behind them below its shallow
boundary, nor for a grafted one. A repository borrowing objects from
such an alternate does not see the alternate's shallow file, so the
history that is missing there is missing here as well. The fetch then
succeeds, the connectivity check stops at the alternate's refs, and
a later "git log" fails with "Could not read <oid>".

"git clone --reference" already rejects a shallow or grafted
reference repository for this reason, but nothing prevents such a
repository from being added via objects/info/alternates or
GIT_ALTERNATE_OBJECT_DIRECTORIES, or from being made shallow after
other repositories started borrowing from it.

Skip the refs of an alternate that has a "shallow" file or an
"info/grafts" file, the same checks clone uses. Its objects are still
available through the object store. Only its refs are no longer used
as a boundary.

Partial clones have the same problem for the objects they lack, but
detecting one requires reading the alternate's config, so this
patch does not handle them.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Igor Wiedler <iwiedler@gitlab.com>
---
 Documentation/rev-list-options.adoc |  7 ++++---
 odb.c                               | 11 +++++++++++
 t/t5618-alternate-refs.sh           | 13 +++++++++++++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index bd9f345690..982a53c694 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -223,9 +223,10 @@ explicitly.
 	Pretend as if all objects mentioned as ref tips of alternate
 	repositories were listed on the command line. An alternate
 	repository is any repository whose object directory is specified
-	in `objects/info/alternates`.  The set of included objects may
-	be modified by `core.alternateRefsCommand`, etc. See
-	linkgit:git-config[1].
+	in `objects/info/alternates`.  The refs of shallow and grafted
+	alternate repositories are ignored, as the history behind them
+	may be missing.  The set of included objects may be modified by
+	`core.alternateRefsCommand`, etc. See linkgit:git-config[1].
 
 `--single-worktree`::
 	By default, all working trees will be examined by the
diff --git a/odb.c b/odb.c
index 0200e26f21..e6bb7ce6e6 100644
--- a/odb.c
+++ b/odb.c
@@ -458,6 +458,17 @@ static int refs_from_alternate_cb(struct odb_source *alternate,
 		goto out;
 	strbuf_setlen(&path, base_len);
 
+	/* A shallow or grafted repository may lack the history behind its refs. */
+	strbuf_addstr(&path, "/shallow");
+	if (!access(path.buf, F_OK))
+		goto out;
+	strbuf_setlen(&path, base_len);
+
+	strbuf_addstr(&path, "/info/grafts");
+	if (!access(path.buf, F_OK))
+		goto out;
+	strbuf_setlen(&path, base_len);
+
 	read_alternate_refs(alternate->odb->repo, path.buf, cb->fn, cb->payload);
 
 out:
diff --git a/t/t5618-alternate-refs.sh b/t/t5618-alternate-refs.sh
index 4cc39af0f0..9c3862709a 100755
--- a/t/t5618-alternate-refs.sh
+++ b/t/t5618-alternate-refs.sh
@@ -70,4 +70,17 @@ test_expect_success 'connectivity check of a deepening fetch excludes alternate
 		--alternate-refs --quiet <deepen.trace
 '
 
+test_expect_success 'refs of a shallow alternate are ignored' '
+	git clone --depth=1 "file://$TRASH_DIRECTORY" "$TRASH_DIRECTORY/shallow" &&
+	test_commit -C "$TRASH_DIRECTORY/shallow" shallow-only &&
+	git -C "$TRASH_DIRECTORY/shallow" rev-parse HEAD >shallow-tip &&
+	cp .git/objects/info/alternates alternates.bak &&
+	test_when_finished "mv alternates.bak .git/objects/info/alternates" &&
+	echo "$TRASH_DIRECTORY/shallow/.git/objects" >>.git/objects/info/alternates &&
+	git cat-file -e $(cat shallow-tip) &&
+	git rev-list --remotes=origin >expect &&
+	git rev-list --alternate-refs >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.56.0

