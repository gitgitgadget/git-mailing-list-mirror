Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1280E2BDC0E
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356132; cv=none; b=dINyYZ5Ka4zFh+4E5vpql4rTLzHppEHQfS7JbK0oCcC/upHR2/efyNmYG4zcECxOVv5PfNRzrDchgs1J3PoSK7IYpvbOkkZsDSzI01weiF0m8fBxDW+VmTEvvSbzgnjOgiluy95puTPC2hthYztccL+RA9OgWgLDzZmgYuAEY1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356132; c=relaxed/simple;
	bh=J2kRrCXjzuRjx+UTJXBOeatJfiQ1KHbhBTF2IX5HaQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LfJl2wMtF5dndJtlSEzYL/QayROu71nty+32/4VJSwiu1NvJlVlkuIe9CtMw4JzW7UCWTXv7x0qo+5n0o3R1tEO2zZhQVSEs0W6QYEkoFrAqwbbK/lKdYrHOGgVijX+ENBZMiWNUEApgzUIoltf4IA9ec0A9kG5fZNnxv22rVaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DdUfMDT0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cf5wGxbN; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DdUfMDT0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cf5wGxbN"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 1D11B1D0014A;
	Wed,  2 Sep 2026 09:35:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 02 Sep 2026 09:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788356128;
	 x=1788442528; bh=AGeOz+oYNt03Nn8YivgCF/T5Pw5Lfku1ENnIxDrM4cg=; b=
	DdUfMDT07tmJu51LXTKMAJ1Ndjc0LMd+y1D9D5HroPS4un1Dy59wUMPOsVyQlKoX
	KbsM/rkM3MBDU9YAdvFLzMi32Vl8Z4ZjfWTqCFf1/b0FCGO5QpWYdh5SWqThuORH
	c757mu34QM1E5nnUs7BwB+hKjV4uX17VWdC+dP+G6BEHEBQX1SbTvbw9k4BWmZE4
	EA9lKyvyGeId8BiJ7FX2o/AhobG8v0ZBamjOfgKPpWcK0VxxhIM0UhxDV9vMLvHx
	Oow1+YtX4zpbH3PwuiXS7JN1SHTQu8TQTmAow2M7PJBM/uAUqWZtguCrDm9SZCbm
	S50IGWv6nqrXAt8DoemZRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788356128; x=
	1788442528; bh=AGeOz+oYNt03Nn8YivgCF/T5Pw5Lfku1ENnIxDrM4cg=; b=C
	f5wGxbNXftVcWdnUFRbzALKeZLyyfhOd8BjO4Ntu4yyMKJC06/cc3DaRha83yMS5
	5b9F77Pj+4z8jHugloq4/1kcJjKHkuRO6gGnlf5awWzd3tfnz8AY+8r6KpD6iXyE
	du9s1ZfaUtowaaWGVPCMNpmdacXjYsHb1dlLHbmWr/637wNyEc6VEeVxE4nmRmqL
	cgJdXHqz2ebZkTFTamGZzia55SA1YW9F1ab1Hwmt9LrrWWwHVp4LqeJrV1gpOHjJ
	uTKOwXP5o1orrYsdXzB3JUWxS4Ww/PZsaR0nev4ahn60sTFz/V0SLE3TBxSzUROD
	DBaaBj5X9vQNBkf4Zo4Pg==
X-ME-Sender: <xms:ICaYasn7NiIz8ivabRUu64kNIq_X7EvjtM8clYNP2jNG8H5gcKHiCA>
    <xme:ICaYah1qfzuDD6jFP_5WGahgGbEnDWko9txSTjq9VgZLOUkw1Ts33xp6XjaLNBA5h
    zlFE5qiuGAHdlD3h6aIspQRGorYC3OblMl0Q_33M2DdmAFp0CK8jb0>
X-ME-Received: <xmr:ICaYaoQym_urWsHgqh8Ib4KhfYC2TkljJpJIno6Og21sxRyrr8PzNtREWBeestpc18SX9Qk>
X-ME-Proxy-Cause: dmFkZTGrKOyneZupe5mOAQPCzJ04iP7AmLoFfKmvCbE1PXGMupxk+V2NHymWcC4MTqxXOZ
    qKq9wTecS2icL0DdCtTOCKdnafWbnAKgdH0wDaR59e/kpg4eReC0lLpo1evFjFMIgvnYon
    R2hs/5JOn9f3OdQ+vxHFb1QyrsNQEv+x0IdyoER3mghIqNxh/lgxkwG7av+ggFwoKfIkeu
    C1JKjSxfbfW7SEzYHMwa58HzzfC3iAL4Xe0WqbEAZkixIKWw5MujaEcHt0BX6zRfJxMnJz
    Bp+bTfsYkt7cMLy/SwKjfahsGUCnP+pXCap9lrxYaxGr/JafFjNSixolp5e/H25iF1cxiK
    2Hu1VGGBMKB1QhagUoBBMZir3dTY8HJUaa7hLdHeHMSDWOuUyVbH7koNxiBJAlt4n6h9Aa
    LlL6zZiP5VUpqE7UACJaHmNT0pRoUEzpIUe+w7iYcdPwM7QumsUo99yn7ONZDsAiJ6wQGN
    gWlKZQ5A/XjiUCkpwtIHj9ZqeLQksUcW45oWV0vjwrsniwXYhwk52kd6/kr4cdzg3GEI9l
    qUIP1v3GPZZ43lhUxv8sL52B9P27LS7WpXnkQ21Is0sv03rddDLdi0THz8Qpz5ybCJ6GIz
    iIw8ntu3AWrqnoxOP9d/OlfbA8ckqO/81fcPLoubSrfeOpiA809XDY+84ydQ
X-ME-Proxy: <xmx:ICaYajtjAcLLr4YlGPB55HRaxU4X-dnZgsEGxVEwDqivJ7hmfifGww>
    <xmx:ICaYata_6GdsooJjx6wFOUpb-uU0vB2lsomcM_o9G5PMA4xur4YrRg>
    <xmx:ICaYaovdU2Uyaj2o9F1tvtEz7iVxmKH9XbZ9MV5gTXmYoDeb8dSXEg>
    <xmx:ICaYavHoeB_TD0GHSZBZYlHSLEst0ZyY4574M3K1bkf-5TIzoc4prw>
    <xmx:ICaYan-iyuJg_JyMiSeRvDanO2gsogWEjlmalmiUaL1KS5tiK5Eozlgw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 09:35:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id be670e1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 13:35:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Sep 2026 15:35:00 +0200
Subject: [PATCH v2 12/13] t/helper: stop registering alternates in
 "ref-store" command
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-pks-odb-registering-in-memory-sources-v2-12-c6ca12fdea4d@pks.im>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
In-Reply-To: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When using the "ref-store" command we support access to multiple
different reference stores. As part of that we allow the caller to
explicitly exercise stores of a submodule. This allows us to verify
low-level behaviour of submodule stores, which is exercised in t1406.

When doing so we also link the submodule's object database into the main
object database. The intent of this is that it allows us to access
objects of the submodule, too. But that functionality is not even
needed anymore: when creating a submodule reference store, we will first
initialize the submodule repository and then initialize the store with
that repository. And as the reference subsystem doesn't depend on
`the_repository` anymore all subsequent object lookups performed by the
reference store will be routed to the submodule repository.

It is thus not needed anymore to register the submodule object store
with the main object database. Remove the call.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-ref-store.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 5a9a3053d9..db58f00589 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -74,14 +74,6 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 	} else if (!strcmp(argv[0], "main")) {
 		*refs = get_main_ref_store(the_repository);
 	} else if (skip_prefix(argv[0], "submodule:", &gitdir)) {
-		struct strbuf sb = STRBUF_INIT;
-
-		if (!repo_submodule_path_append(the_repository,
-						&sb, gitdir, "objects/"))
-			die("computing submodule path failed");
-		odb_add_to_alternates_memory(the_repository->objects, sb.buf);
-		strbuf_release(&sb);
-
 		*refs = repo_get_submodule_ref_store(the_repository, gitdir);
 	} else if (skip_prefix(argv[0], "worktree:", &gitdir)) {
 		struct worktree **p, **worktrees = get_worktrees(the_repository);

-- 
2.55.0.979.g7e5102b832.dirty

