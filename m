Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D0C6EB7A
	for <git@vger.kernel.org>; Tue,  7 May 2024 06:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061653; cv=none; b=T2PD3CIbrcqx9XXHhOXH0nIzJjYAfPjWyV5dmWoGFixcZUUqWtSMyB6NNVR4SpMwQlsjdRPIC+B1Bd0PoZ2YldH2n1M7LXlXgAW/hbj4KLAUaEy4k/ViJp0KwCCDiDBLBe/7E1UZu45bck71zVQsfmcmNkdgGe+YLehrHtil2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061653; c=relaxed/simple;
	bh=e9imN1I21socGEjEcAjlHGmjZLgxzFHZIDkHaN/esAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYpT596i5C2nicJKBwQvnT7kGXjV79KBFhBPyycQOnf0Ff3c88b4ZFthfQxd5tNuZiFNY+PIumq7dIWh4QBjlwIMHqSDgWCXvspDkag3IIvrPaiq9q7Le9LqfZ0z6NUfy6bjDeCF1UzCNbo0GO/kszM58hqZSMyQ5SYipZUflQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4no6GPq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4no6GPq"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a387fbc9so649056566b.1
        for <git@vger.kernel.org>; Mon, 06 May 2024 23:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715061650; x=1715666450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOH5pbanK7ZQ02ZKP5sH5tnEdm44NkeP8GauV+D5Fhc=;
        b=U4no6GPqdQe6df4psBG4vRoX/CTKXI5Qi6WNYpeQrEXDIHV+yfJDL+2tzo+uUGv6t1
         l9psNIviMIseMVES0a0hDzi4AIKuIXh/PpIQ1WKHMEy0NCMiZw4CzBgGEahU8ciz3iCP
         MX/1zTi6D8Xh5q1Hh05u+cgK8+osVZ3/eTDlnK6oueODFosCTziP19ieG+VDqOftUJ0e
         ao+GnxrtExqo7cfnij6cnc0/qRLTwFx5FouUObOyMS3K5NAx6icWM0qaoUX5JimOjj17
         EmSrCMnewnks/IgcWxI+g/GmEXU+K3x67x+0ETWOoUtlvOq5WB3A6lE21ZMulSG1I678
         cXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061650; x=1715666450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOH5pbanK7ZQ02ZKP5sH5tnEdm44NkeP8GauV+D5Fhc=;
        b=m3gXxTgUkrdHVN74m/zr7wfbHvyvwlYSD9eXkaOrzVGwcLjRGi6Z1GaCmvyiznbK+D
         WodB+LLB3MkWY2REglq8AOZJ1fc78FG2tPv4nT9cynhiRyiKE79K3hIetCO+E0QPUPjE
         Oxg3X7/xK/xbkpPQQZHLFOiYvMX44yp1u4NG/BWZmlAM4WZ07+Cw6KFw7PMqNVjOQAq4
         47UUp6l7PrMqUB9mAv+UZqEiIv10BZU3qI+i73VqllFBCgMqkImIPqVByb7TD1vzC2m2
         ue9yX3Ij2+v1wapHDMerl1SyToirpAFEOJwxoDwT+ehzJJ8OVHG5Jn+k044DZVzxRuIC
         4ZHg==
X-Forwarded-Encrypted: i=1; AJvYcCVigOlPFuPInjbbIefmsdsUPoKOlkf7TtM9Wt6D7EaIyoJoUIasJMKJG52Ck1UvkOtKBP+wH+oqgDu9Ef2mHVse0bmC
X-Gm-Message-State: AOJu0Yz2vrARFq8rbZMOqOzdZ5Kr7L9LqGbhUMc95ezTU2FwLKrLxMp6
	MitG1bRULF+AukvSNM6ylIiXE2Z/4/qepd/EgeINZMxNrvJzZeGt
X-Google-Smtp-Source: AGHT+IFsZBKIU0251MIqCgUSOGUQei8M3nPU5wXr9IvIjL6kMOPcwPw3ExHd9DiP3L13Y/2SUI3rWA==
X-Received: by 2002:a17:907:6d10:b0:a59:bd5b:a0f3 with SMTP id sa16-20020a1709076d1000b00a59bd5ba0f3mr4907006ejc.38.1715061649928;
        Mon, 06 May 2024 23:00:49 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1aa1:adf2:4cd1:ebdc])
        by smtp.gmail.com with ESMTPSA id y27-20020a1709060a9b00b00a59baca79basm3066691ejf.60.2024.05.06.23.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 23:00:49 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH v7 6/8] refs: use transaction in `refs_create_symref()`
Date: Tue,  7 May 2024 08:00:33 +0200
Message-ID: <20240507060035.28602-7-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507060035.28602-1-knayak@gitlab.com>
References: <20240503124115.252413-1-knayak@gitlab.com>
 <20240507060035.28602-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The `refs_create_symref()` function updates a symref to a given new
target. To do this, it uses a ref-backend specific function
`create_symref()`.

In the previous commits, we introduced symref support in transactions.
This means we can now use transactions to perform symref updates and
don't have to resort to `create_symref()`. Doing this allows us to
remove and cleanup `create_symref()`, which we will do in the following
commit.

Modify the expected error message for a test in
't/t0610-reftable-basics.sh', since the error is now thrown from
'refs.c'. This is because in transactional updates, F/D conflicts are
caught before we're in the reference backend.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c                           | 24 +++++++++++++++++-------
 t/t1416-ref-transaction-hooks.sh | 23 +++++++++++++++++++++++
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index f3d6b3b8e3..7a693dbcfb 100644
--- a/refs.c
+++ b/refs.c
@@ -2305,14 +2305,24 @@ int refs_create_symref(struct ref_store *refs,
 		       const char *refs_heads_master,
 		       const char *logmsg)
 {
-	char *msg;
-	int retval;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
+	int ret = 0;
 
-	msg = normalize_reflog_message(logmsg);
-	retval = refs->be->create_symref(refs, ref_target, refs_heads_master,
-					 msg);
-	free(msg);
-	return retval;
+	transaction = ref_store_transaction_begin(refs, &err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref_target, NULL, NULL,
+				   refs_heads_master, NULL, REF_NO_DEREF,
+				   logmsg, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
+		ret = error("%s", err.buf);
+	}
+
+	strbuf_release(&err);
+	if (transaction)
+		ref_transaction_free(transaction);
+
+	return ret;
 }
 
 int create_symref(const char *ref_target, const char *refs_heads_master,
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 2092488090..067fd57290 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -134,4 +134,27 @@ test_expect_success 'interleaving hook calls succeed' '
 	test_cmp expect target-repo.git/actual
 '
 
+test_expect_success 'hook captures git-symbolic-ref updates' '
+	test_when_finished "rm actual" &&
+
+	test_hook reference-transaction <<-\EOF &&
+		echo "$*" >>actual
+		while read -r line
+		do
+			printf "%s\n" "$line"
+		done >>actual
+	EOF
+
+	git symbolic-ref refs/heads/symref refs/heads/main &&
+
+	cat >expect <<-EOF &&
+	prepared
+	$ZERO_OID ref:refs/heads/main refs/heads/symref
+	committed
+	$ZERO_OID ref:refs/heads/main refs/heads/symref
+	EOF
+
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.GIT

