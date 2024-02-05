Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C7138486
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166186; cv=none; b=UkYLqqCkwsxqEwq8wDTlLA8Wf8FN+4YCseT1TTFkfM1jl8ypwvcJhFml5P8CcpMEVuoBmeHgpJEXem2/6QZpHhhY/Y4eMzfwVe8VSXSkJhFumt70eAw6DwBazKImS1R7DHguGQIcK0zg2kNUohJT67PtUu15m2RalRE8q4iKqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166186; c=relaxed/simple;
	bh=+VFgeyDIPqKRMyQVVGlVyzpkWrO6rl8szjbOkEAX6H4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rhfRytlB+H9EWKCyvPwUSQu/PJH8IOs3Fmk9mx0K8hDjcW/1cbPMyrbCuWjF6LlvMPnLLWqaWRNCNDgvqZcRfjSw6jJJuTaIoJBMR2d7BJrJPHakKVOckCspx3BESw47dDqVj8Fyho9q3Cioe0nvWWCo2zDchj/+8bAAisSHiXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxmgM84f; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxmgM84f"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56077dd7936so1472003a12.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 12:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707166182; x=1707770982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YJkHV1YkyRD2JV7KlIJ4XrCX9bjw9YZlhwmTskK2Kg=;
        b=jxmgM84fZoi9bRbjc3PQr7Ofn1JGTUk5Z6CXSCBwTbY2cQjUdl9PIh0VQhw+RGKUw1
         PxuhZe4QRAoNZC+LdKha9wBB58itFhnzb9Z4tin19qW0ahQwDTqnN/lBAWPcueWI8/X1
         IT+DsO/yGVek9jqNw9RNcqkErvlyu0gaunPsDdKwvltwahV4kyemIeb/G0IGbJgoLe1q
         sIYcPPLpRwztzyvvjNMwWAtK9EONoilajEx2kdT3F/pMZHZ2awM7d5ibD21xfGQ5aEID
         +ROHoXrsxbrrc5HYHVlna95n6/g1tfDq0tgfKzBw8RFb63S/XvwbXdI2yfrg7W78WsSg
         Tzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707166182; x=1707770982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YJkHV1YkyRD2JV7KlIJ4XrCX9bjw9YZlhwmTskK2Kg=;
        b=OBr5uEIHwwmKHC4/5fU3Xjwa8WeFZghmsNvpTdtjKXizru8WLajiEa5PbhhtyS0+qi
         djriqvsfk61ClnohrwnFsAFcWY5DYrLq6Ad0SkkN4HydHFcnIxTsmYTTRaN97QwmbkA7
         T6OkOxXypsBLc8QdEINmCzqwVgRzBnWtBao60xm0yLhu20CcFQxojjUUDH9def6w81uG
         WFi4Mfkqk1CX3QrQjcgNdUYi/k/muLCOR0vqW1VhcwmGGSofnov3fJOyYjfywD6fRRB7
         JkGAMxpcnOa9kWTNBge3YmwHDg+SfjKPZ1hNIp5BKkDt/cXmH1/rutyiBOj7sUyxU1We
         9oYw==
X-Gm-Message-State: AOJu0YxVX7ZHKS/oxohA301VsOTMhZfzvJrQZUlihoQ0yAIs8ZuFzNtf
	aJKpcJssLLmqYWx2Cn6x43vM+3Lwx7SMayu1D5rT0WQkYiUC0cYZAiVirExh
X-Google-Smtp-Source: AGHT+IHTBDMF6IVc5AKuwXFd9+3wUo9HsYbFHLo7UHgAJ1ZN0MmeNVZ3iguZdFS3LlirDHR4tWjYyw==
X-Received: by 2002:aa7:d4d9:0:b0:55f:efcc:53f0 with SMTP id t25-20020aa7d4d9000000b0055fefcc53f0mr345305edr.10.1707166182491;
        Mon, 05 Feb 2024 12:49:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXJDn6D66IYRYvKYEbnQ+uEeRnb7eIXN/q76ceWeOurhCZ56ZtkAzzG1T+tx0HKe+k1ULk9ZnumuQ2w1H25PzlG1eA2UA+bBxyUhw==
Received: from mkb-desktop.bosmans (89-224-201-31.ftth.glasoperator.nl. [31.201.224.89])
        by smtp.gmail.com with ESMTPSA id be28-20020a0564021a3c00b0055ef4a779d9sm275551edb.34.2024.02.05.12.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:49:42 -0800 (PST)
From: Maarten Bosmans <mkbosmans@gmail.com>
X-Google-Original-From: Maarten Bosmans <maarten.bosmans@vortech.nl>
To: git@vger.kernel.org
Cc: Teng Long <dyroneteng@gmail.com>,
	Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: [PATCH 2/4] notes: use exisisting function stream_blob_to_fd
Date: Mon,  5 Feb 2024 21:49:30 +0100
Message-Id: <20240205204932.16653-3-maarten.bosmans@vortech.nl>
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

Use functionality from streaming.c and remove the copy_obj_to_fd()
function local to notes.c.

Streaming the blob to stdout instead of copying through an
intermediate buffer might also be more efficient, but at the
size a typical note is, this is unlikely to matter a lot.

Signed-off-by: Maarten Bosmans <maarten.bosmans@vortech.nl>
---
 builtin/notes.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 8efe9809b2..048b8c559c 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -149,18 +149,6 @@ static int list_each_note(const struct object_id *object_oid,
 	return 0;
 }
 
-static void copy_obj_to_fd(int fd, const struct object_id *oid)
-{
-	unsigned long size;
-	enum object_type type;
-	char *buf = repo_read_object_file(the_repository, oid, &type, &size);
-	if (buf) {
-		if (size)
-			write_or_die(fd, buf, size);
-		free(buf);
-	}
-}
-
 static void write_commented_object(int fd, const struct object_id *object)
 {
 	struct child_process show = CHILD_PROCESS_INIT;
@@ -205,7 +193,7 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 		if (d->given)
 			write_or_die(fd, d->buf.buf, d->buf.len);
 		else if (old_note)
-			copy_obj_to_fd(fd, old_note);
+			stream_blob_to_fd(fd, old_note, NULL, 0);
 
 		strbuf_addch(&buf, '\n');
 		strbuf_add_commented_lines(&buf, "\n", strlen("\n"), comment_line_char);
-- 
2.35.3

