Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B79417F505
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604550; cv=none; b=fpgqCeDVAMdA5JsXWOLpaOye4VIiY/Q+Ycxgfyaz5oGVFKD0rBKq4bF464HhaT5tsIg4iYcJUd4svLKoAXlJLhD8gSbnfHOaIazT7kU/BR4ZIkOj7ZW+UyTrsfHjrFvkt2aQkNsOTS9n1LUAUOB4yakCOBxnXU7yGNOpCfhE+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604550; c=relaxed/simple;
	bh=cUJllRLMwHFHVWMuPlYlSqYSjSGFOLbt1FR4FbLzWDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B+fp6f8fQ+qp1B7nmLutSubiI1/NFt9SGtsxk+Khg46YRIERMiyb24RHff8JcMJXa7Qql7xEhsLtjPvOYp07XnkOha19BnVzNLJ8WdoIYZ38uSUO9wGhmkIchRdKGdF7UkHv+Fx3SSb9nN+QDLelox153dCwVi4u6hjkP31OADQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Whj6Fmfj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Whj6Fmfj"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-720c286bcd6so796534b3a.3
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 09:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731604548; x=1732209348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFYdTQMJGtClUpRHksIKjLpyt7oa5T5HU93QtmOYM2s=;
        b=Whj6FmfjLi6zVvOctLmweVvNLMvB6eb8chGzG/1QUXBTY49dCr/K1NJmyQbDECjZJG
         T2f46AtWyQfqQIsnFzehHF9CBLbyrOqVGd1pn62PMd2As0e+Md6DzFpa9Ccwmq0sUXTX
         xd7DK5Vwzr3UUFPrVDpGl/u8JwDcowAhPLA1gbLdAjzajs6NvGAgwRbbSFhU8NrgfWi2
         PJ3e5FNSS0CGpOol+onkiVkTKjo0aEqebeD9b5tHjCE8eOI3zbQzjuEGI5/p1sMQIe7e
         TM23pHx4kzP1O/3hbfDQKO8qMjY8H+cuQZycMLM9ldHXo3wxB9nD88YJ40FiQ9jHIYKe
         7uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604548; x=1732209348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFYdTQMJGtClUpRHksIKjLpyt7oa5T5HU93QtmOYM2s=;
        b=bt54mQzMXGuuyuPLGDrFmtwzsvP/pVkkmPni5FJ7Tah6Bqyq+Tn7dkNf7ADLODWpPy
         92iLaCz0drMNLzG5FsTbzCCexnB5kHyn5Iy7KP5HlencTgVoD2GPV1U4ZjH/rirkcrBg
         Br4OZMWxeqk9lfOLclZ1sjkR3JBoubhDllW4zqYxKsqWx+27JJr0fmiuk1XmTMyH6E9D
         hC4xgOXqtjAdQjnkDvwNOZJVBqNGjDUb9MFgAyN7N6RBDrooljGgS2QvI+UQYwy90Md4
         nW5q7cW9Qfgngupx9BFzSMfYXltmW6lkvoXWraS0x+eDxmkIbYIQvZf/Vyfv/T91ihMQ
         kiFA==
X-Gm-Message-State: AOJu0YzR3/FOdIwXkSftoN7h4ftgxXzsea0sejLnICMTofIQ3yXtLCRx
	pb98DBAjuMtiOo/rfE4f8k68od9akmulBM7lI/J6RmLFZMBLjOOC5qo9og==
X-Google-Smtp-Source: AGHT+IF3VVyNHGy2kXfLgdU1YFUz3+hgVTZagE+srA/kPM/xI70fa02HYBpgcnmsPbK/xmEbvji4jQ==
X-Received: by 2002:a05:6a00:1150:b0:71e:7d52:fa6d with SMTP id d2e1a72fcca58-7241338a798mr33083572b3a.21.1731604548072;
        Thu, 14 Nov 2024 09:15:48 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a9bab91sm1539883b3a.149.2024.11.14.09.15.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2024 09:15:47 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH v2 5/6] push: only ignore finish_connect() for dry-run mode
Date: Fri, 15 Nov 2024 01:15:36 +0800
Message-Id: <1ad61a02955fca35c4d1763adfbac3fd36482e09.1731603991.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
References: <CANYiYbHGdJsTgdzJj1r4sPdTAcZCf3C-qA538fcXbD1jjB1BUw@mail.gmail.com> <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Patrick reported an issue that the exit code of git-receive-pack(1) is
ignored during atomic push with "--porcelain" flag, and added new test
cases in t5543.

Atomic push may abort the connection early and close the pipe, which
may cause an error for `finish_connect()`. Arbitrarily ignoring this
error will lead to issues. Modify it to only ignore the finish_connect()
error when both the --atomic and --dry-run flags are set.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5543-atomic-push.sh | 4 ++--
 transport.c            | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5543-atomic-push.sh b/t/t5543-atomic-push.sh
index a40afb949b..1d8f088a00 100755
--- a/t/t5543-atomic-push.sh
+++ b/t/t5543-atomic-push.sh
@@ -281,7 +281,7 @@ test_expect_success 'atomic push reports (reject by non-ff)' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'atomic push reports exit code failure' '
+test_expect_success 'atomic push reports exit code failure' '
 	write_script receive-pack-wrapper <<-\EOF &&
 	git-receive-pack "$@"
 	exit 1
@@ -297,7 +297,7 @@ test_expect_failure 'atomic push reports exit code failure' '
 	test_cmp expect err
 '
 
-test_expect_failure 'atomic push reports exit code failure with porcelain' '
+test_expect_success 'atomic push reports exit code failure with porcelain' '
 	write_script receive-pack-wrapper <<-\EOF &&
 	git-receive-pack "$@"
 	exit 1
diff --git a/transport.c b/transport.c
index 9e03a7148c..186d58e907 100644
--- a/transport.c
+++ b/transport.c
@@ -923,10 +923,10 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	close(data->fd[0]);
 	/*
 	 * Atomic push may abort the connection early and close the pipe,
-	 * which may cause an error for `finish_connect()`. Ignore this error
-	 * for atomic git-push.
+	 * which may cause an error for `finish_connect()`. We can ignore
+	 * this error when both `--atomic` and `--dry-run` flags provided.
 	 */
-	if (ret || args.atomic)
+	if (ret || (args.atomic && args.dry_run))
 		finish_connect(data->conn);
 	else
 		ret = finish_connect(data->conn);
-- 
2.47.0.rc1.21.g81e7bd6151

