Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E674261B6C
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757796881; cv=none; b=T+U04W1BmjM1QRAJ04KscdcA5MZiW41HNq6VK+GvOGb4OGeyj+33JUZd6xlVW6naNbdznWSctupoEiT+T44Peyil1sdi5vYrN9+EenxOHPBOcQcdPyzJWYhj3LVHlFZGAi2WzNgYA+4V665G8op35Hg/pxtljcYFnpJt/d9YeM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757796881; c=relaxed/simple;
	bh=YpdjhjRtQSPX0O2SsppHL8EXLsfVW1NMwTlP+4LdaJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HhVZ1zgBYxIsfaXjHm1KuCjzVJ3YYTy+r/AcFppHP0J0UAZT65buxOiVUHtqEV6MbCaXjGHw177rDFHPNEq+eESzTODW7AD83CLbgTVHwa4U1wzThGQlLrFGOjIZk5e1N7MEeD7AU7QbfuQQufo+GY9wgwN/A2QP+29Zy1cp34Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0jxKSs/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0jxKSs/"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so453761466b.2
        for <git@vger.kernel.org>; Sat, 13 Sep 2025 13:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757796878; x=1758401678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIUC+1yPEzHPkylf13Ugd3Q2BVlkcy5VmAHSs/mXueE=;
        b=D0jxKSs/JQHBXcfVEmjZTWKTcMll66rQ8yeGR/iOkyIeqwz6fZzZ8WI3SqwzRQi5AQ
         uDJm9O3/C6SFjaL3c6rNNSD6uFUIKSBuYFI5A/hlbX3GquGLrIHXQ9aEucvgstAmQ368
         4CLzqxYDHKt/xYeDzXwOyU02ikYgZ4jGQ6GsZY53Op8NlchdN5HRmQO28l7axliS09gu
         24ojRDNtg86XDMa9lD4p+l6HlBR3FXbbAfByAnRlINyqoIk146xhjgHQmgwV9sS72kJi
         j8HAt2Q6PDiv/Psb3xWzTP73X5qtCiH/QKf/qxzD9HutKo5Ai50kuso9oYkvl4ArlgaT
         9mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757796878; x=1758401678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIUC+1yPEzHPkylf13Ugd3Q2BVlkcy5VmAHSs/mXueE=;
        b=U9Xl79IE2gEUznXGTTODnl6QvK8EyL3m2glISJVbPE7x0DK3WJpUMk6J5AdBnF5nEA
         plS8kbZp7mqX6OPHzr9JcIWHvgGSD7n0slFyiRUWVHJcpC6K9yI/CyA8Qwv7OIKknjvA
         UmSzvs2tpd+6aq0XWVVRKtuqJqLt9TMTwStOe2xITQSN1QKJryYEV7zsrXaQM5pD5Gcq
         Ev4xLe9rv+D6SZZpvK7gPfGQeKMDeUYQImIVcKU2lI1mGA8G2yfJqPaGTBVSwuCn4u/y
         4pr2IqDsrvHj/OlyH6P4vE7WFdVINndKybO3Z1lqRPZm9eo+1wVwEmquIPdTuuLRFW1l
         l2JA==
X-Gm-Message-State: AOJu0YzKr/A0J1ABKgmxM7+CXUe9QlPIMvG4x7qOHsX6b39/PnYkd4yA
	UpTt2fdI6xfMlzdu3VWcBlp3UG71NpHp+j75dLcXiwpqVLT/FWw6sE8vHdkpGo19
X-Gm-Gg: ASbGnctBGs2U/gOx3bUSdX1JuAU7ifIJG2JNAhesUALrEH7K8qxlNOEZhhTJvV633Q8
	cpxvoHJKI2mA17TYZZLak+OWdt7xVLkrgHBZYDCzs/86vHDo3KhliiLHXxwvZzII8jJRpInOi8E
	tk4eGowsMy90TZB5mmfqJPzvL60xY0BCa0t1Gh94FFBaFzneBEhRxzIg168iAGxi1EQvFVxa5ca
	7nZ6IeCE0FdI5g7gZRipsSj0FZ0QyTZceOkPNj1w36Ls7wgdXXHwUrnllPrst+t/LuAmPEuXu3V
	zgyjkaSBdbiCpkDMlJLempAl8WfTeThX6PELiC4w4048X9q+i93PvgCiKo2SLTOXeoah/8g/kxp
	SahmWa4iNv5TVxDP7vZhDD6FqcMK2
X-Google-Smtp-Source: AGHT+IHWKGQFKHD5PIH3h5AmWvGJex3AVgIFb1w2oo8amkOqJ0yPsPHpiarVPZMe4jxukgIksJAqdg==
X-Received: by 2002:a17:907:3e21:b0:b07:c1d1:4b66 with SMTP id a640c23a62f3a-b07c356d5ffmr719671566b.14.1757796877432;
        Sat, 13 Sep 2025 13:54:37 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:5b4f:6b96:ff06:27eb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32ef574sm635383466b.73.2025.09.13.13.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 13:54:36 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 13 Sep 2025 22:54:32 +0200
Subject: [PATCH v3 4/4] refs/files: handle D/F conflicts during locking
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-4-195569740b57@gmail.com>
References: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
In-Reply-To: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, joe.drew@indexexchange.com, 
 peff@peff.net, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6338; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=YpdjhjRtQSPX0O2SsppHL8EXLsfVW1NMwTlP+4LdaJI=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjF2gkmIwEXxbJOVDQZMbqbJK43NhcB5BF/c
 UmyVQalRe9f94kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoxdoJAAoJED7VnySO
 Rox/24cMAJHxe3BrxnKRRWKxW3ys4yRMTHrcB6SJlxddbTqbKXmUlpyT+E1Wdbu9GBM9xWaBO3W
 9Yt9wF1Kb0vsh9DP6ahqb8cIV7jK9POTGqg6m09S5aazg5hsGvwmmm7+CaPL7qd2kKadU0NL/vA
 ZYpdBrlRPhfY2+Hli5lpKDfmlMDiaIejEGKTvVo4PUSF8tbQys9lQEhVpYx2BFaiLLUo/QFP94Q
 DwHaY605PItbUGSeBdMFCHiPI+R6zW9Vf/pkZDj0acnf4VTJbsjbAP3EFqKz/wVRPDZiXzJlgPQ
 LHFsfs5d1RFxf3TimTelNe5XYoxdwaMYGajPyV/1EjwR+QQwCEF0EwPwDYPFaX4eh+AyE0Yn7oB
 4xxt5bGy2FUdjkuvfaCFjr7A6MKcQliNs0igWr5Pkps8fLoZfs2JxSI6RhEbdoSRrbnZjtiWbNA
 G+VSd8tmVV6TlCEbDzzJnvJRxiIGuEBkzenyTk9NldYM8ih8SLM8gf6sKFP4y1XPcrV9RM6TDd4
 Gg=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The previous commit added the necessary validation and checks for F/D
conflicts in the files backend when working on case insensitive systems.

There is still a possibility for D/F conflicts. This is a different from
the F/D since for F/D conflicts, there would not be a conflict during
the lock creation phase:

    refs/heads/foo.lock
    refs/heads/foo/bar.lock

However there would be a conflict when the locks are committed, since we
cannot have 'refs/heads/foo/bar' and 'refs/heads/foo'. These kinds of
conflicts are checked and resolved in
`refs_verify_refnames_available()`, so the previous commit ensured that
for case-insensitive filesystems, we would lowercase the inputs to that
function.

For D/F conflicts, there is a conflict during the lock creation phase
itself:

    refs/heads/foo/bar.lock
    refs/heads/foo.lock

As in `lock_raw_ref()` after creating the lock, we also check for D/F
conflicts. This can occur in case-insensitive filesystems when trying to
fetch case-conflicted references like:

    refs/heads/Foo/new
    refs/heads/foo

D/F conflicts can also occur in case-sensitive filesystems, when the
repository already contains a directory with a lock file
'refs/heads/foo/bar.lock' and trying to fetch 'refs/heads/foo'. This
doesn't concern directories containing garbage files as those are
handled on a higher level.

To fix this, simply categorize the error as a name conflict. Also remove
this reference from the list of valid refnames for availability checks.
By categorizing the error and removing it from the list of valid
references, batched updates now knows to reject such reference updates
and apply the other reference updates.

Fix a small typo in `ref_transaction_maybe_set_rejected()` while here.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs.c               |  9 ++++++++-
 refs/files-backend.c | 11 ++++++-----
 t/t5510-fetch.sh     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 4c1c339ed9..e7109ea5fe 100644
--- a/refs.c
+++ b/refs.c
@@ -1223,7 +1223,7 @@ int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
 		return 0;
 
 	if (!transaction->rejections)
-		BUG("transaction not inititalized with failure support");
+		BUG("transaction not initialized with failure support");
 
 	/*
 	 * Don't accept generic errors, since these errors are not user
@@ -1232,6 +1232,13 @@ int ref_transaction_maybe_set_rejected(struct ref_transaction *transaction,
 	if (err == REF_TRANSACTION_ERROR_GENERIC)
 		return 0;
 
+	/*
+	 * Rejected refnames shouldn't be considered in the availability
+	 * checks, so remove them from the list.
+	 */
+	string_list_remove(&transaction->refnames,
+			   transaction->updates[update_idx]->refname, 0);
+
 	transaction->updates[update_idx]->rejection_err = err;
 	ALLOC_GROW(transaction->rejections->update_indices,
 		   transaction->rejections->nr + 1,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 817b56f4ce..fec7713ea6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -869,6 +869,7 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 				goto error_return;
 			} else if (remove_dir_recursively(&ref_file,
 							  REMOVE_DIR_EMPTY_ONLY)) {
+				ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 				if (refs_verify_refname_available(
 						    &refs->base, refname,
 						    extras, NULL, 0, err)) {
@@ -876,14 +877,14 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 					 * The error message set by
 					 * verify_refname_available() is OK.
 					 */
-					ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
 					goto error_return;
 				} else {
 					/*
-					 * We can't delete the directory,
-					 * but we also don't know of any
-					 * references that it should
-					 * contain.
+					 * Directory conflicts can occur if there
+					 * is an existing lock file in the directory
+					 * or if the filesystem is case-insensitive
+					 * and the directory contains a valid reference
+					 * but conflicts with the update.
 					 */
 					strbuf_addf(err, "there is a non-empty directory '%s' "
 						    "blocking reference '%s'",
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 08dbea6503..6b2739db26 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -59,6 +59,12 @@ test_expect_success "clone and setup child repos" '
 		cd case_sensitive_fd &&
 		git branch foo/bar &&
 		git branch Foo
+	) &&
+	git clone --ref-format=reftable . case_sensitive_df &&
+	(
+		cd case_sensitive_df &&
+		git branch Foo/bar &&
+		git branch foo
 	)
 '
 
@@ -1592,6 +1598,46 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'F/D conflict on case insensiti
 	)
 '
 
+test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensitive filesystem' '
+	test_when_finished rm -rf case_insensitive &&
+	(
+		git init --bare case_insensitive &&
+		cd case_insensitive &&
+		git remote add origin -- ../case_sensitive_df &&
+		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
+		test_grep "failed: refname conflict" err &&
+		git rev-parse refs/heads/main >expect &&
+		git rev-parse refs/heads/Foo/bar >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success REFFILES 'D/F conflict on case sensitive filesystem with lock' '
+	(
+		git init --ref-format=reftable base &&
+		cd base &&
+		echo >file update &&
+		git add . &&
+		git commit -m "updated" &&
+		git branch -M main &&
+
+		git update-ref refs/heads/foo @ &&
+		git update-ref refs/heads/branch @ &&
+		cd .. &&
+
+		git init --ref-format=files --bare repo &&
+		cd repo &&
+		git remote add origin ../base &&
+		mkdir refs/heads/foo &&
+		touch refs/heads/foo/random.lock &&
+		test_must_fail git fetch origin "refs/heads/*:refs/heads/*" 2>err &&
+		test_grep "some local refs could not be updated; try running" err &&
+		git rev-parse refs/heads/main >expect &&
+		git rev-parse refs/heads/branch >actual &&
+		test_cmp expect actual
+	)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.50.1

