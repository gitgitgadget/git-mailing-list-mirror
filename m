Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56C6374E7
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705842949; cv=none; b=fj37HQZc/lJTW5g2T5jnXydLLM8WWJxXHBbkuEa5rsmnq6Kq3k4TbPoHxXbMu7Aw9G8yoe51zsGDDzlHq4MbIMZFFmpsh0wVxzgtKn5bacn32J0+yCxUKxqPlHyJRvIatF2wqXK9phEO+9cIuvcTVoA2vUGzftxOH8CKEigVAPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705842949; c=relaxed/simple;
	bh=ZZB2Me0hZC+F/869g+i1glDZFmrteYDQkUAxBYZfe+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ovj+B4s29vGJDksOj0xNYbUm9EouUsJAFRRte4Qfd2i9uKoTjQ6RqSLyLzFJ7sgNnF/ZMng7BB06IVllkd0kPwCMuRZUGnu7tS3axEay2UgxlNXvcfjgMZtAcfRmb7YxPb6GqXjABho7iaqi6Ba1jr2eAqCQoOvTkIJno3c1kcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBPd8tF3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBPd8tF3"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6db05618c1fso2215438b3a.1
        for <git@vger.kernel.org>; Sun, 21 Jan 2024 05:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705842947; x=1706447747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dCfY9ji/XaEgjdygE1LRi3A8zh1vB9pDamO6bGmR2M=;
        b=UBPd8tF32oRVzGdSo6uvCZwCMllcVJ0de1dkrBjInLoMSh3tN/PGoKZ99eH6KJb3kz
         RwMdfj2PolqHrSWTaCcBqpxWkGHWZTpkAlAMxtri5/SgiZ0xN7msKQ9CnQVtlQCE258e
         ZrUIvK6q8v3e1F+y9zd9dNEsUCGiHCNZtn8EKGQwQ7JjAxSw4h3jMElcLYTdJ0kZlpa6
         plJW0v3gx5682ThgjE4XpzU7VN3z0yUiclblNXFwvEk6A3BiedTAgEEiV+/lnxOm1ODJ
         eqkHsMOy+NKnGw+3kiOTfILlEQsMnwuV4BmZoE7qjQmfYtrCAaFwqZzYsN585k9liJDj
         J4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705842947; x=1706447747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dCfY9ji/XaEgjdygE1LRi3A8zh1vB9pDamO6bGmR2M=;
        b=XTtQ+fnCin0lU79cMn2q6+eHdIY21FDL3myepGhn5xy4E8WmkFPDkpbBieILkhHk2J
         EUA9iuOvF8WbQKu+k/5FVioYnnwLJzZdOidwuzvXP8ckn3ouIldbSjs+00Mo3LHHX3+J
         w6VM82i2tzEdfqufhBMQghy6qD/aIA5bBVpWBSMpQIc0xNteLY2fcATs6s8aoxJ9VyCN
         zNDUsv9gaHF4Ayha3/6kR1vZOVPwMN03PmGFWbhxxVLRaGwnPfqM2Jx3q+wYJ+F4Yyff
         5xXNqJqKtj/hLaoYonIkBJ7ZYaG1aUIB5AFOcqYrYBpdIrWPJitRspX51XhgqkMCMPoT
         6xhg==
X-Gm-Message-State: AOJu0YwIh19Ee0EiyM7JO6ehP0ciaHxDPEe1h1sVPwh7ZSQB0ve91vk1
	xZYHQDnXHDJXtc0T9QDX2fXn0ENqYqYiWULRLOfjXnMPTul6XO4UBMQMPUla
X-Google-Smtp-Source: AGHT+IHIu0bTlqOkgi7au+kCIN4mX6X8ojsjlLx193WqT12lm4ps/ExrwXmZLJNVSYO5Z8OJIvBnZQ==
X-Received: by 2002:a05:6a20:4709:b0:19a:f6f1:c63f with SMTP id ek9-20020a056a20470900b0019af6f1c63fmr2833868pzb.72.1705842946910;
        Sun, 21 Jan 2024 05:15:46 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id g5-20020a636b05000000b005bd980cca56sm6619005pgc.29.2024.01.21.05.15.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jan 2024 05:15:46 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Arver <linusa@google.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v6 5/6] transport-helper: call do_take_over() in connect_helper
Date: Sun, 21 Jan 2024 21:15:37 +0800
Message-Id: <12a5b5e532f46558a0b4abaf80b45a670a0e7f88.1705841443.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1705841443.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1705411391.git.zhiyou.jx@alibaba-inc.com> <cover.1705841443.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

After successfully connecting to the smart transport by calling
process_connect_service() in connect_helper(), run do_take_over() to
replace the old vtable with a new one which has methods ready for the
smart transport connection. This fixes the exit code of git-archive
in test case "archive remote http repository" of t5003.

The connect_helper() function is used as the connect method of the
vtable in "transport-helper.c", and it is called by transport_connect()
in "transport.c" to setup a connection. The only place that we call
transport_connect() so far is in "builtin/archive.c". Without running
do_take_over(), it may fail to call transport_disconnect() in
run_remote_archiver() of "builtin/archive.c". This is because for a
stateless connection and a service like "git-upload-archive", the
remote helper may receive a SIGPIPE signal and exit early. Call
do_take_over() to have a graceful disconnect method, so that we still
call transport_disconnect() even if the remote helper exits early.

Helped-by: Linus Arver <linusa@google.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5003-archive-zip.sh | 2 +-
 transport-helper.c     | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
index 6f85bd3463..961c6aac25 100755
--- a/t/t5003-archive-zip.sh
+++ b/t/t5003-archive-zip.sh
@@ -268,7 +268,7 @@ test_expect_success 'remote archive does not work with protocol v1' '
 '
 
 test_expect_success 'archive remote http repository' '
-	test_must_fail git archive --remote="$HTTPD_URL/auth/smart/bare.git" \
+	git archive --remote="$HTTPD_URL/auth/smart/bare.git" \
 		--output=remote-http.zip HEAD &&
 	test_cmp_bin d.zip remote-http.zip
 '
diff --git a/transport-helper.c b/transport-helper.c
index 6fe9f4f208..91381be622 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -669,6 +669,8 @@ static int connect_helper(struct transport *transport, const char *name,
 
 	fd[0] = data->helper->out;
 	fd[1] = data->helper->in;
+
+	do_take_over(transport);
 	return 0;
 }
 
-- 
2.43.0

