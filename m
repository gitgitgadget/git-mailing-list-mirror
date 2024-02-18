Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C890C71B4A
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 19:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708286384; cv=none; b=l2b8I+xxTVrzQ7hPILTn6+QBrepZ2xx5s/WxZsy+73UgRvzjzvPlmnJxy8CJbrgCpEyqMdrQODHHok6un2UemC7sqBu9W5exkBeZjU/G+MEkPuG2yK5EbIDjlfMhM06i8OtDU54F8PMhu3pKj0WdTLk/ke3JgKOUXHoeHEdi+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708286384; c=relaxed/simple;
	bh=FmPAJoncZifGIK+ki6+imjE16pCm3iqm1RJxRBQaHZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7S7txe5CtRu2uPF2aMKoF9R5f5ewynaQdGI2uzg75kqcXgVO/fnnrwH5SvOFkh8bdvp+nAWihiOWloUQS5Jymzpg9yAURUMCkJ6xLYFSBWPsqWqTcdpKCliDilNTVKFJkwLwI1WoVimRNfp7H+DDp+IUS64u7Go5nO7V4VwXb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3CgzqUb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3CgzqUb"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3e82664d53so44413766b.3
        for <git@vger.kernel.org>; Sun, 18 Feb 2024 11:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708286381; x=1708891181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kp2n/AxMm4iMLySdN2e8I0yh8tEWJx3SZZyloE9mgi0=;
        b=h3CgzqUbfRkBKWAMSGU551P3BPS5LsGdV5GwhqZCJ2yOJYkPc4Zwrfm3QKQRsffJPU
         5EA0dL3RX9dPZC+TWdPPW1pN7DA03zEreyWUr+PJw0eJXBExmGwDc55X5YyNHuTVy8x3
         4PlBy8WI9mzmnBNyPKr29Cam7yoJXK3/fIH0jH2/rUNfHyJcmBgzU6n6DafablUmchex
         7/PzYmEd8BbxMYQvuZw665CNZ6gism6BnBZpyH2BKwtXGLqt2OikUgjpok8hEFmYfgBJ
         wjMBu6inZf3daX15KlZhtEhc6T15iqdulIRs3GZ8HUTEEKc0t89ek5U2KB7HStBqweBb
         breQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708286381; x=1708891181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kp2n/AxMm4iMLySdN2e8I0yh8tEWJx3SZZyloE9mgi0=;
        b=G76WUVQpPpNM/iBohKX13IzKEHt/RrspmQ8ZnaePuIz26c0UQfpbzLclDvJZ6epmQA
         lA9juHQdCt/F1tt8h/2K3J+JpkeHei1ajMoKfAicldOa+VxyRgTPquY95gfXngThq3kx
         h2eHQFR4EopqpGY8UYgAUCqoyHwZ2Wf9DCiK0S8yk6yr4hzuDZBQo+fLYIN4CA4013uE
         85l8mSuWg2N0adrEZeU0AmqlJav/OxFG9dLA0UEoYJi1i+jTELSD4rJeKf5ie6fDdRJo
         2/lVHiyVJ8sM2KijAnIq7Pveb41v81SAvV0SzG6LGE93EP9sM4qw0863jcDOB4slRM76
         WLLg==
X-Gm-Message-State: AOJu0YzvP8HXELbAk7Ue8AsTAAtcrEBn+gbW7/OUj3lluIJGm5IZhk4O
	z0nCTmJWfLSkFR5T+4DP74gPh71H4QvVjWVCxeNpWPiwhfAB6bHUBk8g8QJE
X-Google-Smtp-Source: AGHT+IEpyaGSUdSqZd7DUxOB3nzj0+TjM9OzSYxI49m8IUXHRzx0+7MMWmAbMqJ6R7+fGsb0nYB8nw==
X-Received: by 2002:a17:906:3b94:b0:a3d:26b2:94f4 with SMTP id u20-20020a1709063b9400b00a3d26b294f4mr7445516ejf.73.1708286381089;
        Sun, 18 Feb 2024 11:59:41 -0800 (PST)
Received: from mkb-desktop.bosmans (89-224-201-31.ftth.glasoperator.nl. [31.201.224.89])
        by smtp.gmail.com with ESMTPSA id dt14-20020a170907728e00b00a3cbbaf5981sm2206999ejc.51.2024.02.18.11.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:59:40 -0800 (PST)
From: Maarten Bosmans <mkbosmans@gmail.com>
X-Google-Original-From: Maarten Bosmans <maarten.bosmans@vortech.nl>
To: git@vger.kernel.org
Cc: Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: [PATCH v2 5/5] notes: use strbuf_attach to take ownership of the object contents
Date: Sun, 18 Feb 2024 20:59:38 +0100
Message-Id: <20240218195938.6253-6-maarten.bosmans@vortech.nl>
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

Avoid an extra allocation in the strbuf when pushing the string into it.

Signed-off-by: Maarten Bosmans <maarten.bosmans@vortech.nl>
---
 builtin/notes.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 6863935d03..5be24a9c58 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -314,10 +314,8 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 	if (type != OBJ_BLOB)
 		die(_("cannot read note data from non-blob object '%s'."), arg);
 
-	strbuf_add(&msg->buf, value, len);
-	free(value);
+	strbuf_attach(&msg->buf, value, len, len + 1);
 
-	msg->buf.len = len;
 	ALLOC_GROW_BY(d->messages, d->msg_nr, 1, d->msg_alloc);
 	d->messages[d->msg_nr - 1] = msg;
 	msg->stripspace = NO_STRIPSPACE;
@@ -705,12 +703,11 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		if (!prev_buf)
 			die(_("unable to read %s"), oid_to_hex(note));
 		if (size)
-			strbuf_add(&buf, prev_buf, size);
+			strbuf_attach(&buf, prev_buf, size, size + 1);
 		if (d.buf.len && size)
 			append_separator(&buf);
 		strbuf_insert(&d.buf, 0, buf.buf, buf.len);
 
-		free(prev_buf);
 		strbuf_release(&buf);
 	}
 
-- 
2.35.3

