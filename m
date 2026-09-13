Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E1638D6A2
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789331198; cv=none; b=qC7tGl6yfoRP96bTIyxKivHDbaLFrlbrmfrGxa8Uvm6Rco7ckWPdid7TB96uSWWQj95reD+GxIVz/dGsDNagRNpkkMcd+Q4j4dDHAOvfVD/sHUEOAUVspYRyuee8QJXDe93Vh5aRwD2Fn/+Bsj6RVbw2vsePOfCf9P9keLQA7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789331198; c=relaxed/simple;
	bh=56Efp5+Dw4/sFn7J4dQTe0PGgj9YgXOWR8LNq583OVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZ0Rch5AFsT1I3mMV115a8vnxLYeeyiXjmMPPgZBAhdkyu/psPshMlWPRiMl9+C1MISOpwvKi32jdTo+skmbnnfbAkFob/NvZS0XXSrv0rRboaxafYG/BO96pAB2go8/1B8cTKN2ilPwukUcLa3ES1eqEJXMd5k3FigzIIEmW7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnA2HYo8; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnA2HYo8"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4ab20a32so1034819d50.2
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 13:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789331196; x=1789935996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W3vMGi6Kfl7IKSaJFcF8z47ZTv3cIrUQeufWU2YTq0o=;
        b=TnA2HYo8s1ye0zeOj3VfzCneChy6KiSixLvSskk8A4ghU5pVJxxF4YCh/hqtfeZ40q
         Tt9mcJLGw/w2KCpCMldB5QK1VlqmqsU6NBknucHWQlxj0VwBlruZABEI0aRugQDBj6Co
         8tT8n0JQVTbTXuQgly4I6dEgHMPUnRSDhDewn6j+twOwfJprF0bLhgPiB40OXfDLp4aC
         xe2gvkeH6TKZw7crvHXrsKn6lXHOlKGB/844Vao1xSOygWGrVKIeCuqMtn4C/1kAx8K4
         Vxz8DLlM16Y0iCAKPxyETxS1YvCR6SSaB7wUinyUTTZv7TbfGpXKfjPCbyta4pdoXSjk
         VBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789331196; x=1789935996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W3vMGi6Kfl7IKSaJFcF8z47ZTv3cIrUQeufWU2YTq0o=;
        b=XE8Q5uomqbUmfFlVGJfzdhPdpJtOUzR3uBb4RHyCS3xFDRd0mLOt0+XsezMX1JsAB3
         cWcsC90TXtg10ywFE7PRW8RJgnr/IHehhg8L6KGoLx8mgG18eXTDU9E/3wA0cszhcGzq
         tU6Iysw2LO0u3XDw2eEYbET2SAhtMGLbyDXFhbyR5Y8AqNqNmrzmuGgsiIIQpRaH9x8h
         FGoxcrt+ZtSfK7bT1/2EmuZXGn6+8306BMnacD/2oe8ZGq96QKm65Y5IW3Xgd7JJCy4R
         ap6npC7HnAX8D1nJboLVSwhbfOHb6mz27jkXIpDLzp8KpUIgT9bSpiRgh5mtiR8Xbmo5
         nZXg==
X-Gm-Message-State: AFuF++lyUWjOxEg1rAtYdpd4I4tueHzvM0fcRdy4gZixxiY/bJJFzZD0
	q8ERXI+2jln1ZlpeZ68KRPA6DvxLjFug/7jARKTibfUQcWqIDBntpbAi1AVQt0lL
X-Gm-Gg: AYBFou2PTU/+PII+PDPWfN0xl4gfzBiQf/JWRwKxfS9wEPvEF2bBuDBr0uzUx/0ToYe
	ZTsK9rehtpx3XcCTJbuVg3X1pv4EU87eLlR0eYcOCSN4NFx74/C3AJZXFT+UZxoYHkAUXHwBcff
	v83OYoFDty/m32GS2gXj9B8Qvme3ZggqXxYbXBAU/gtdb/n+YraHCKP2TNnZq1qqZuC1zvKdf4B
	huTW7MbtUkZ6jInnloRxgSOZRrG+iduAW0P/oPqOqJ9qBGzt9nhOlfqwxVW5jWenD2F0FsWW33a
	VqktSJ6SlaGKlidKXuhEC0rKOfAfvNdOv9ZG3yj5VHi7FF5K9LQSxROFqfJz7zi5ybcNWRbt1AS
	5TBSolgOnwnsCVcN9ebY6QkyjE1rPN29gOmGUCgFJo0eBM8sVh3qJLOiZsnJhzC9QUr6Fqw4V80
	cJ9fQG3sylvVtTuuMH+DMEbNl66sUzhkAmZTC3zf7fyF4Sw5qkvqrL+Rgz80LZIob0ugOg/zz9H
	wDUz1V7HmBTfkZKm/Sc1+4OXOeWNuarwevl6aljwt3pfnAZsVvUNA==
X-Received: by 2002:a05:690e:1303:b0:671:33f6:721e with SMTP id 956f58d0204a3-67135aa5a9cmr1592296d50.54.1789331195637;
        Sun, 13 Sep 2026 13:26:35 -0700 (PDT)
Received: from jtobler--20250820-SHC54 ([12.86.123.90])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8847db4476bsm30317047b3.5.2026.09.13.13.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 13:26:35 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/2] object-file: lift ODB reprepare out of packfile flush
Date: Sun, 13 Sep 2026 15:26:21 -0500
Message-ID: <cf14416f224f48475dfc9f79d8ec62756b9fdedf.1789328612.git.jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789328612.git.jltobler@gmail.com>
References: <cover.1789328612.git.jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When flushing a packfile via `flush_packfile_transaction()`,
`odb_reprepare()` is invoked so the written packfile becomes visible in
the current process. In a subsequent commit, repreparing the ODB is
slightly deferred when committing a "files" ODB transaction.

Lift ODB reprepare out of `flush_packfile_transaction()` and instead
require callers to explicitly invoke `odb_reprepare()` if required.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/object-file.c b/object-file.c
index a4cbf8b081df..0f123b79fad1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -857,8 +857,6 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
 	memset(state, 0, sizeof(*state));
 
 	strbuf_release(&packname);
-	/* Make objects we just wrote available to ourselves */
-	odb_reprepare(repo->objects);
 }
 
 /*
@@ -909,8 +907,10 @@ static int odb_transaction_files_write_object_stream(struct odb_transaction *bas
 	 * to zlib compression and is sufficient for this check.
 	 */
 	if (state->nr_written && pack_size_limit_cfg &&
-	    pack_size_limit_cfg < state->offset + stream->size)
+	    pack_size_limit_cfg < state->offset + stream->size) {
 		flush_packfile_transaction(transaction);
+		odb_reprepare(transaction->base.source->odb);
+	}
 
 	CALLOC_ARRAY(idx, 1);
 	prepare_packfile_transaction(transaction);
@@ -1260,6 +1260,7 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
 		container_of(base, struct odb_transaction_files, base);
+	int have_packfile = !!transaction->packfile.f;
 
 	if (transaction->objdir) {
 		struct strbuf temp_path = STRBUF_INIT;
@@ -1293,6 +1294,9 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 
 	flush_packfile_transaction(transaction);
 
+	if (have_packfile)
+		odb_reprepare(transaction->base.source->odb);
+
 	return 0;
 }
 
-- 
2.55.0

