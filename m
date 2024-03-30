Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FF053812
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 22:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711838799; cv=none; b=qTE6PGNXlt60qzeS3VPhtc+ndmhL9w7JppU0UxalKMmMinK3riGHodJUo9iGtYLFWXsrKcJ7+XF3EILRjPb0/fr1K0lz313reUQ/2wcFFenLVd0mMyC+NKpwEl8sCframwpup8ccYGXj1emuYxUZuvUA8ivBEsqUSWBPlYGtL0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711838799; c=relaxed/simple;
	bh=yXMYdiTeEYmnS8E10alPu7HOgtgBmeEDhAjV4KfLwkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfjgWvlRKGeP3OfmNo9/8JJQP6L9cEdEMiTs1unWdwnsslm4+yNciynCYTeuI/jzDFgQc/hVSQA/+TUUO23tZXRk1J1jIO6kDS+DLiAb3Cub3BmdbzBE2ENk+eKxo2M6vIkYdDE5oIlvFA4vL8hx8YxpbAaNvS/XtdVW60+6HSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKz03yA/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKz03yA/"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-515c198e835so3281298e87.3
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711838795; x=1712443595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7whyboC5hIwRKKWtx1/0kVWea8p6fzKsGI3H7EjAOY=;
        b=jKz03yA/5zEhYUg4xGPG9X7Hq86gj5RS3ulVKPshoMtJ/gTJ1pw8B95+3/dJlPQRyU
         yWmLX73j5L8kO1PgP7/cKyPmxpsmyJoOFpD3dR/s1hjzm8hVnNUtuGVZfM//P/q7zBer
         LswnMaoVPVofFIvQCGmnF1q6STu7zGatV6Int8cCbXtsJ7xeHFOgnLG7OVgas5lSww1+
         dZaP/7HAbzD/A+WqLGyrj9Oq2qvepswFukj4l77YJ5wwQF7OIW63C/15tTTXXW9eHoBF
         UkzaBvbB+XcHXfJFxmTWdGHsmh4rW8ITwZgbEppSxLVSJu5xuQIMe7VLV1FjPjbtbBdD
         x2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711838795; x=1712443595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7whyboC5hIwRKKWtx1/0kVWea8p6fzKsGI3H7EjAOY=;
        b=c2Z8/R/FO3UBOQ6jAGXNC5HymPJ+M3m2JwR3ro86RLtsGf+lRZeEu+cZSWiBj0EZx0
         eDUZB05yOX3iObd/5S53sJqnjGTP4z0+hDub4i+RjjjRkLTlaf9vRZErbz2aBVs94Tz0
         alU3dQKMTEvj3iFBmH/BhUZ8HULVCotEKAuOtDXBX6yv0I5lL8He9HMpXTQSn/xh3x0R
         WyqEqR8oSK9RdbvjojPiipCQa2y6wyXNde3rZfQmi81FdnmngzkG4GV3fMmT66xtKR+1
         2BXZlOWA6UjbeSvHFlIvn0kkAWtUDgbYgzBAZVD7jkVOifZ4trVkJoeEP4n5z2bMUp58
         xOCA==
X-Gm-Message-State: AOJu0Yy4sLKGO68HTl+tEuKkpYdWdrbPotGIWJhoGHAYJjSG5MJQfiLb
	zqWFZ1bKN7Jsw/MwlaMmMvlmuZ3qmkd9j9uqwOt2fIkcNYyxQRAFYWEIoD3fy0o=
X-Google-Smtp-Source: AGHT+IHvhe5kTBPoQfa2sGhLoTQRfN9j4DdkLyFcpLfQeCt75De18erCkOMrSds6TZhSln6vrxYi0w==
X-Received: by 2002:a05:6512:40d:b0:513:c195:1c56 with SMTP id u13-20020a056512040d00b00513c1951c56mr3895043lfk.16.1711838794814;
        Sat, 30 Mar 2024 15:46:34 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:9f01:e67d:4cf3:c3bc])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090637d300b00a46cc48ab07sm3533580ejc.221.2024.03.30.15.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 15:46:34 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 8/8] refs: support symrefs in 'reference-transaction' hook
Date: Sat, 30 Mar 2024 23:46:23 +0100
Message-ID: <20240330224623.579457-9-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330224623.579457-1-knayak@gitlab.com>
References: <20240330224623.579457-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The 'reference-transaction' hook runs whenever a reference update is
made to the system. In the previous commit, we added support for the
`update-symref` command in `git-update-ref`. While it allowed us to now
create symbolic refs via `git-update-ref`, it didn't activate the
'reference-transaction' hook.

Let's activate the hook for symbolic reference updates too. This takes
the form `<symref-target> SP <ref-name> LF`, which deviates from the
form for regular updates since this only contains two fields.

While this seems to be backward incompatible, it is okay, since the only
way the `reference-transaction` hook outputs this syntax is when
`git-update-ref` is used with `update-symref` command. The command was
only introduced in the previous commit and hence only users of this
command will face this incompatibility.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/githooks.txt       | 13 +++++++++++--
 refs.c                           | 17 +++++++++--------
 t/t1416-ref-transaction-hooks.sh | 27 +++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 37f91d5b50..ae9f02974d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -485,8 +485,7 @@ reference-transaction
 
 This hook is invoked by any Git command that performs reference
 updates. It executes whenever a reference transaction is prepared,
-committed or aborted and may thus get called multiple times. The hook
-does not cover symbolic references (but that may change in the future).
+committed or aborted and may thus get called multiple times.
 
 The hook takes exactly one argument, which is the current state the
 given reference transaction is in:
@@ -513,6 +512,16 @@ to be created anew, `<old-value>` is the all-zeroes object name. To
 distinguish these cases, you can inspect the current value of
 `<ref-name>` via `git rev-parse`.
 
+For each symbolic reference update that was added to the transaction,
+the hook receives on standard input a line of the format:
+
+  <symref-target> SP <ref-name> LF
+
+where `<symref-target>` is the target of the symbolic reference update
+passed into the reference transaction, `<ref-name>` is the full name of
+the ref being updated. To distinguish from the regular updates, we can
+note that there are only two fields.
+
 The exit status of the hook is ignored for any state except for the
 "prepared" state. In the "prepared" state, a non-zero exit status will
 cause the transaction to be aborted. The hook will not be called with
diff --git a/refs.c b/refs.c
index 706dcd6deb..d0929c5684 100644
--- a/refs.c
+++ b/refs.c
@@ -2342,16 +2342,17 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 
 	for (i = 0; i < transaction->nr; i++) {
 		struct ref_update *update = transaction->updates[i];
+		strbuf_reset(&buf);
 
-		// Reference transaction does not support symbolic updates.
 		if (update->flags & REF_UPDATE_SYMREF)
-			continue;
-
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "%s %s %s\n",
-			    oid_to_hex(&update->old_oid),
-			    oid_to_hex(&update->new_oid),
-			    update->refname);
+			strbuf_addf(&buf, "%s %s\n",
+				    update->symref_target,
+				    update->refname);
+		else
+			strbuf_addf(&buf, "%s %s %s\n",
+				    oid_to_hex(&update->old_oid),
+				    oid_to_hex(&update->new_oid),
+				    update->refname);
 
 		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
 			if (errno != EPIPE) {
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 2092488090..fac5d5fc6d 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -83,6 +83,33 @@ test_expect_success 'hook gets all queued updates in committed state' '
 	test_cmp expect actual
 '
 
+test_expect_success 'hook gets all queued symref updates' '
+	test_when_finished "rm actual" &&
+	test_hook reference-transaction <<-\EOF &&
+		echo "$*" >>actual
+		while read -r line
+		do
+			printf "%s\n" "$line"
+		done >>actual
+	EOF
+	cat >expect <<-EOF &&
+		prepared
+		refs/heads/test TESTSYMREF
+		refs/heads/test refs/heads/symref
+		committed
+		refs/heads/test TESTSYMREF
+		refs/heads/test refs/heads/symref
+	EOF
+	git update-ref --no-deref --stdin <<-EOF &&
+		start
+		update-symref TESTSYMREF refs/heads/test
+		update-symref refs/heads/symref refs/heads/test
+		prepare
+		commit
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'hook gets all queued updates in aborted state' '
 	test_when_finished "rm actual" &&
 	git reset --hard PRE &&
-- 
2.43.GIT

