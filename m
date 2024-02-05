Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A8F137C58
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166186; cv=none; b=QUlvq+qjLx/HTkxj806+wyDE9LNtDaiqMkURcDRd4jVZsRhjCezhBzaJzALAFBb7/TV9cm4qZej0QQEGO3X04bnGBTBbegsYDEbN6GvSsNKlHcHLXJlNlo1559nwLJwQIFVKtlO4z7z3Dt7AxLuLq1d38Rvv1/AOVcMGArnGUis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166186; c=relaxed/simple;
	bh=t+hI9iXXF+0AmIr4X5SK4Qp0Uemi3B/Di0NszJj2TaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lk/wh+72e9hJR+IajUYKH1ZMvIMP+jAzqNppiJKdPH2DGq1LhJx/upr/6CFS8Uasoo/tiCtkWrvDWTBQf7CFklh5tHJdQNlP5sb0gK6m7cg3vDLZ7l2r07txYmqL/7XBuoheS/MuMlCgWcszrrbIee7WPwAOjQgbdgoJozDypTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8qWLo2u; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8qWLo2u"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56003c97d98so3477443a12.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 12:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707166182; x=1707770982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfUFuAwyWi69Rr805APOzspd8n1EC0I7ZC0wqMXz7rM=;
        b=c8qWLo2uAML1QiQr5vys2EOEZeKwBLBrkS+kUmHnCh1TnnorDaqhvQaqxwHin1mWTO
         TSWKWZVobFC1xvMjOiyZ08bzhwBw7m3UnUDBl7b1FPDDcwWxi8uYGokPcvu7orOt03FD
         oW4QyEsk9z2COT400UXpM0t2EWbkon5109eH2VLC5wJaLYmvIMWF6g4r7p2Oi9qcnLzj
         Kx3XcmfjVtTbQb51vsHhFDuORJrt2tZEA8VZ5wiNd29lObWgWHkqZKUUtrXRtHw1Or+L
         mbu2ITkBguqiwPtldWYjzr5g2oZB6jqissqXhWalGlbmJE/sLqWCbLh0KevMyyci8C2u
         TZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707166182; x=1707770982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfUFuAwyWi69Rr805APOzspd8n1EC0I7ZC0wqMXz7rM=;
        b=W0svYKTPzE0XhK+07F0+bFzC7hLLpZkNxGbKLQrDrNJDuJZTSeEyrtHkc8x8R7vCkJ
         1KtYOXB/MyHec5SuC0KcXDADRwx5eUcljuUY3iRC4SOln3wwHIuGZOd/oJOSc0/oQSWX
         h5Ft9CpKgSvM3UTeD4oKh2O2XRhSRf0yQSxSp4brHjF50Z7++XCPnZ6Xu9NFCkd85+Yq
         +Cq9H2lU3RNYVL3joT0KN3E0LAugfwMrmYjOfFwPaJI7/ma6c1cpTwnUAyNSdDnq3YSX
         z2f7/GNjCXSIMAztZH59SlsUniW/KLnRZtfj46IFDJsn1SpDe5uOGCrhJJjCaVPYP5Am
         t+YA==
X-Gm-Message-State: AOJu0Ywl6ga+p2K30mdvgyEtNNgajxCxDOwnnGyNfinHbjKYoTSgwTeY
	O1MDAI+n+SnbIB3NUVBa3Dqd7AW68DNK3ekghrpOiy4lwql+vM1LC25ILvRC
X-Google-Smtp-Source: AGHT+IERqjxKeY+A4h334dXSxK+sAkfjLuWvt7VLNhwi0Ih1FOfJNnZJnwivc4QGwq/R+lBgL/oRVg==
X-Received: by 2002:a50:fc18:0:b0:55e:fcfa:607b with SMTP id i24-20020a50fc18000000b0055efcfa607bmr129523edr.32.1707166182061;
        Mon, 05 Feb 2024 12:49:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWNLYixWRXHOYOiKs2kHp92/D4PMDnkqTz2gTVU8xF8mNE6Zmr+ENMBzpQLNG0YRq+Cm7klbxjJs1U7cR5FuMyNJ1uEVaWLp2cZZw==
Received: from mkb-desktop.bosmans (89-224-201-31.ftth.glasoperator.nl. [31.201.224.89])
        by smtp.gmail.com with ESMTPSA id be28-20020a0564021a3c00b0055ef4a779d9sm275551edb.34.2024.02.05.12.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:49:41 -0800 (PST)
From: Maarten Bosmans <mkbosmans@gmail.com>
X-Google-Original-From: Maarten Bosmans <maarten.bosmans@vortech.nl>
To: git@vger.kernel.org
Cc: Teng Long <dyroneteng@gmail.com>,
	Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: [PATCH 1/4] notes: print note blob to stdout directly
Date: Mon,  5 Feb 2024 21:49:29 +0100
Message-Id: <20240205204932.16653-2-maarten.bosmans@vortech.nl>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maarten Bosmans <mkbosmans@gmail.com>

From: Maarten Bosmans <maarten.bosmans@vortech.nl>

Avoid the need to launch a subprocess by calling stream_blob_to_fd
directly.  This does not only get rid of the overhead of a separate
child process, but also avoids the initalization of the whole log
machinery that `git show` does.  That is needed for example to show
decorated commits and applying the mailmap.  For simply displaying
a blob however, the only useful thing show does is enabling the pager.

Signed-off-by: Maarten Bosmans <maarten.bosmans@vortech.nl>
---
 builtin/notes.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index e65cae0bcf..8efe9809b2 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -20,7 +20,8 @@
 #include "repository.h"
 #include "pretty.h"
 #include "refs.h"
-#include "exec-cmd.h"
+#include "pager.h"
+#include "streaming.h"
 #include "run-command.h"
 #include "parse-options.h"
 #include "string-list.h"
@@ -751,7 +752,7 @@ static int show(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	struct object_id object;
 	const struct object_id *note;
-	int retval;
+	int retval = 0;
 	struct option options[] = {
 		OPT_END()
 	};
@@ -776,8 +777,9 @@ static int show(int argc, const char **argv, const char *prefix)
 		retval = error(_("no note found for object %s."),
 			       oid_to_hex(&object));
 	else {
-		const char *show_args[3] = {"show", oid_to_hex(note), NULL};
-		retval = execv_git_cmd(show_args);
+		setup_pager();
+		if (stream_blob_to_fd(1, note, NULL, 0))
+			die(_("object %s is not a blob"), oid_to_hex(note));
 	}
 	free_notes(t);
 	return retval;
-- 
2.35.3

