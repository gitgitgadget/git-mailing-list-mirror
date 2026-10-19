Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03FD4D4874
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408179; cv=none; b=AHxQNGsqkxKse9VNm45y4NmI6lZatUGcupXBTgN12iJJVMKPd77EQQ1AQWyAXFk4rrELBLiV4VEj8mc2fJNR2TRFgkLk+CGf0GucRVA5dHdcHOZRT7CNeyA5ebXV/LhxRl7sAmMSkmaalZaav360Zqr5rWitPKjkT+IXz7etbyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408179; c=relaxed/simple;
	bh=rj1SvSVV59B71u9I0J7hSV8hsFFTD7WiVRoiv0iBxWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esqxUbuS+R82Tbczmi7qdaoNr2V92XLxkiLb28wKNxnNAVGC/uun/blCmKZhInwRwZuKh6yB+v+UWIEsyPDploP+QqdF84nSbdlzDCHJFN7vdv6Fo9qe5RJPfg53NTjckbnAsJZBaMml9gPpjUM+GTjtEI2g/2cfoanVt86Yrvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com; spf=pass smtp.mailfrom=gitlab.com; dkim=pass (1024-bit key) header.d=gitlab.com header.i=@gitlab.com header.b=Rqa7Ybpt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gitlab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitlab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gitlab.com header.i=@gitlab.com header.b="Rqa7Ybpt"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48afbd2c386so940033f8f.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 04:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google; t=1792408176; x=1793012976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3y3fAuTKClcr2gqIa6+yLnmjRPpd4Or998soxBZK9Ao=;
        b=Rqa7YbptLn2KKBQcIvzpqXnnphL+vNQf6VwW4Dei0LZbBDOwDlDiD4tUuhkgquBSoq
         9e7g+A7rxYj6TeXybKvhq0wtwI175ael0+xg9FXkT51SQzkXSFztMcrEQZ08R1mPsEOF
         dM09rhknr6eKzmLbjJdIaKrthdHG3tqHEgJHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792408176; x=1793012976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3y3fAuTKClcr2gqIa6+yLnmjRPpd4Or998soxBZK9Ao=;
        b=xraDUuzKwfFRV6XJpH6a/98EZ4m3ltpyt+1LexgMuood9a2QwwYgjwAAXLyu6zkDHi
         XxVFgkh3ieTeq2eAqJiPpZ4nNow75Vfpkc+jelqTvPxzimXrf9gOLAAJHVV/RdRJza/3
         V6G6IScyGLwSugzRy848AqORQk+mU4n20omaZx41oosYUakhXb73MovxW7aYKfjZeVEZ
         oQqsMd/Y5jP6RRgGmnpyZq5/o8t/S2bPN4KQJG5XP3zfJIJdafVbAJPvprhFr0QSQJsD
         EKU4Crr52io1AIaOOQcGNuALe+Hk9T4T4wrUgiJqLOa4VEdRsbMlPLvgwY31E/IHEPwQ
         ebSw==
X-Gm-Message-State: AFq9FYJW4qL3xw+DVRBmXnMLygXqtIT+vyS5hBLcSl1gAa0X4eqbd/9J
	eVi0U2WfrzG7eym7IDrdCpi+GMUEtpiIXR8x1bWySinFhjdt13didFHGtcKUgxdVqmwLBqFFPt0
	EgTmyrQsAXA==
X-Gm-Gg: AYBFou3OL9odwXkOvneaKUpDOShXrsqGfX6ebjZuNalu4bgSGgiNmsyL3rLDev4vRCB
	fTpG3a1GlqieO8ViOO8F6ZbNkMvTTNSelC+mAxkD0ZcyXGqBZ4MEcDMpa5jCLFwtfj9f5hbeD7l
	EY3VBnSOyxoVedKjynSuDZVtVMbqEalZ+Ri4kEe20jmSXky2JjRpYsnIR1dqH8uPtTla2I0HTRR
	b3l4IenHRq9agA6GgOBl6nwMBwE4prYt6PeUERJV8kKY93l+2e7Hw1onJYAPbhp0Q4sj8zKoS4Q
	sqjjiYPnrVLw+uStzT6A3RGnmZdBvAZBwPoeKBVi9Ttgea8dWIU8OBbnH06Eq6ca5hIuldbARD6
	F1FCbqFXjqxj7V7HfWGqbot5C95dRhck6iT1VxMlxBzeEXSQ7uVayivXJDKJDk9rKgpn0Sd29ho
	DU8BcPL5y4KF9aIzNItIqzsAwz3ZhRs+DShd7WQpGYaaC9CLtsPgT7XeGtHGlUWvj1V6S2BuZQ9
	QrDjiWlGzMxWn0I+vu3ZEI0rfSp6fC0lG1ExQ==
X-Received: by 2002:adf:e187:0:b0:48d:ef7d:4b4c with SMTP id ffacd0b85a97d-48e07fa8491mr14496519f8f.44.1792408175712;
        Mon, 19 Oct 2026 04:09:35 -0700 (PDT)
Received: from iwiedler--20220823-X3P9M ([2001:9e8:a97:4482:588f:b276:463d:6918])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4d4dddsm22208956f8f.22.2026.10.19.04.09.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 04:09:35 -0700 (PDT)
From: Igor Wiedler <iwiedler@gitlab.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	peff@peff.net,
	jltobler@gmail.com,
	Igor Wiedler <iwiedler@gitlab.com>
Subject: [PATCH v3 2/2] odb: ignore refs of shallow and grafted alternates
Date: Mon, 19 Oct 2026 13:09:18 +0200
Message-ID: <20261019110918.71193-3-iwiedler@gitlab.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014181134.56220-1-iwiedler@gitlab.com>
References: <20261014181134.56220-1-iwiedler@gitlab.com>
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
Helped-by: Jeff King <peff@peff.net>
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
index 3c5fbef463..68139a1b3e 100755
--- a/t/t5618-alternate-refs.sh
+++ b/t/t5618-alternate-refs.sh
@@ -70,4 +70,17 @@ test_expect_success 'connectivity check of a deepening fetch excludes alternate
 		--alternate-refs --quiet <deepen.trace
 '
 
+test_expect_success 'refs of a shallow alternate are ignored' '
+	git clone --depth=1 --no-local . shallow &&
+	test_commit -C shallow shallow-only &&
+	shallow_tip=$(git -C shallow rev-parse HEAD) &&
+	cp .git/objects/info/alternates alternates.bak &&
+	test_when_finished "mv alternates.bak .git/objects/info/alternates" &&
+	echo "$(pwd)/shallow/.git/objects" >>.git/objects/info/alternates &&
+	git cat-file -e $shallow_tip &&
+	git rev-list --remotes=origin >expect &&
+	git rev-list --alternate-refs >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.56.0

