Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B0571B43
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708286384; cv=none; b=QuxJJPmxru1jmxefTwt3X8n7aBZwFsq3R9t5hHSVKyBHS3fz6R8eMc5GDC7fuptVDTC56ptFHxuPsOsCwsTCc6yUOEW5Fvj5PJB4twdW3tRBqRl9ZTwC6YUTdvvWQ7sgF8IWBm2iHXcWjbDKecr932lRc8DFcuw9Z+bFJi1Kl4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708286384; c=relaxed/simple;
	bh=xelLq95xRldvKB5NCG/ZoCY1dgNlzxuOB8zrNJmpKcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cf8zuRj2jzrqrU2i3WS+Ju3y8VA8WLaHfnebM+8Ev+otIOI4HcSloxIzPH+Tx3hg2SRixYBAiSfpct6rOe9ibiM3TNapJyiSV2w5Il+6bJV6jd44CL9ITyq1vQM+cozr2SlcHUuW1rebaOk4kRDBU7cHjEiA0pPjoJHf+wGMo74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pzre+wti; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pzre+wti"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512b29f82d1so487481e87.1
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 11:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708286380; x=1708891180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0peiUkHc5fI+1Eh9ijkXYBrEd4b4BTC4Rzf8i/gOFRk=;
        b=Pzre+wtiGrwgxyPgfSlCzD7KUGi9YcM3DlIaCraJOiIF5NKlqPXvPydmXaFYTOr5HH
         ZcnRt3QkN8qftzwsMNV0ARuuEeCIg/3uh3boo3h9HEgPJ5kMFI1UCM6xFC5uUgpQ+tnz
         HQ28nQ3RiYCaHg+7Fk+nfKHbT2gILvPS7LRW3x2FR72z5gOkXjvJk2InBGihK+pJRSG6
         P0lESEADc1F7ztrozeKw95z3ysyrraZC1xS7jBIYcAjwzbaXs7T8goriQ23rvEX/lzh6
         ZwDH8Mq4GTR8gxZ+26RPTlvbej7itJeOzrLkjd/hF8ZCNbu4vojgobImITkWDrmSU8qa
         fD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708286380; x=1708891180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0peiUkHc5fI+1Eh9ijkXYBrEd4b4BTC4Rzf8i/gOFRk=;
        b=gS14U90+S5nosY9i3hpH6gHZ+pGjmqMgcrEXm9FuYDOBNLi1dJdi7z0Pt0s9l1yXEg
         XuGipJaUtH9qEho6rRxpav4dnL1B8LXV3YpaKMu5oj1hGK/CDv6QnVAjD0a4t3+14d+W
         Uzaud0AlPXlzSoDF7aOQzVwnSsnrnBjPz3TdveMptLL20UP5c1biM6dsRr8fx+5vk+4B
         NR31uYpqv7PODQTSEzcuomF4bAMfq2sGFG/Q7jcCCTFjdmrp9kF1xaXQOOFmOZCRIwGK
         aakjli2xvX3nRJaz+OG86MRn+R5kb3qXDIER3nvfjvuH6dT7/qgxb8FpN4yANWunmiK3
         v3JA==
X-Gm-Message-State: AOJu0YwScIkrPzKN7ZrsGoZ9DaFplZn8UUPMs7USwXTB8Q0wSBpyzoA3
	kvPkPbx29KET4R/I8DB549Oww9vCBG+90cOfjSqrwNpO617LrkdtHtXILua8
X-Google-Smtp-Source: AGHT+IEWRLaoE0qIv2FisSImPlZgy4GGk7htf5F4UtJfS6MH2nbECyB8m1165IDxPmkSpTRF00yXsQ==
X-Received: by 2002:a05:6512:2f3:b0:512:b1c0:55f4 with SMTP id m19-20020a05651202f300b00512b1c055f4mr815830lfq.60.1708286380029;
        Sun, 18 Feb 2024 11:59:40 -0800 (PST)
Received: from mkb-desktop.bosmans (89-224-201-31.ftth.glasoperator.nl. [31.201.224.89])
        by smtp.gmail.com with ESMTPSA id dt14-20020a170907728e00b00a3cbbaf5981sm2206999ejc.51.2024.02.18.11.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:59:39 -0800 (PST)
From: Maarten Bosmans <mkbosmans@gmail.com>
X-Google-Original-From: Maarten Bosmans <maarten.bosmans@vortech.nl>
To: git@vger.kernel.org
Cc: Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: [PATCH v2 2/5] notes: avoid launching a child process to show a note blob
Date: Sun, 18 Feb 2024 20:59:35 +0100
Message-Id: <20240218195938.6253-3-maarten.bosmans@vortech.nl>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240218195938.6253-1-maarten.bosmans@vortech.nl>
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240218195938.6253-1-maarten.bosmans@vortech.nl>
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

This locks in the expectation that a note oid refers to a blob, and
not a tree or something else.  To still keep the option open that the
blob might not be a text blob and in the future we might handle such
notes differently, the show_blob_object() function is called in order
to have the same behaviour as though `git show <note-oid>` was called.

Signed-off-by: Maarten Bosmans <maarten.bosmans@vortech.nl>
---
 builtin/notes.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index caf20fd5bd..2a31da6c97 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -20,7 +20,8 @@
 #include "repository.h"
 #include "pretty.h"
 #include "refs.h"
-#include "exec-cmd.h"
+#include "pager.h"
+#include "log.h"
 #include "run-command.h"
 #include "parse-options.h"
 #include "string-list.h"
@@ -753,7 +754,7 @@ static int show(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	struct object_id object;
 	const struct object_id *note;
-	int retval;
+	int retval = 0;
 	struct option options[] = {
 		OPT_END()
 	};
@@ -778,8 +779,9 @@ static int show(int argc, const char **argv, const char *prefix)
 		retval = error(_("no note found for object %s."),
 			       oid_to_hex(&object));
 	else {
-		const char *show_args[3] = {"show", oid_to_hex(note), NULL};
-		retval = execv_git_cmd(show_args);
+		setup_pager();
+		if (show_blob_object(note, NULL, false))
+			die(_("object %s is not a blob"), oid_to_hex(note));
 	}
 	free_notes(t);
 	return retval;
-- 
2.35.3

