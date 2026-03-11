Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4F83BD65C
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219040; cv=none; b=ik85Lx3MkkeG7g1fNFb76LZzrdBPZK3+32l/ljJZWZ9YSqTSaEnB54Lt5V4Bj0k5YDTmChlioMdt1Kn/g5UTHEZy9YvlGUPnjRCTL9ULcmU1keMB9fFhxKznSiMUTz5YFL7Hgi3JKWZD0knEfCYo71yO4hEylJbEmnW94h2Of/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219040; c=relaxed/simple;
	bh=N4bl45+ugHBhJTK8b1LEjbjDMqTcTFmnyc9du+YCtG4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aoWGhGjqdoyb7RaXMkxfnWFYfFUruXi7Oms3outK82bda8c8to2H9X+vMKlyHVg2S9XnIKm+8sJXlm6YFXWsgFJ7TkQydGAsGvvHj0J679n37253dHOXc6ltt+6pcGSeeoTpkOkN0nYt1x33WIB4tV/RSXS5RuQT1yk0wgJ9qbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWiJspM6; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWiJspM6"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899ed41208fso192837606d6.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 01:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773219033; x=1773823833; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDHqb+0tAKIx6CbJXkCNT0BIOeQZL5zcuAbIjSUDvxw=;
        b=mWiJspM6bX+LdVYveqMapt1JkywTiZxUC+jDBpkTPP7/zhjzDip/wP+y4Ya0kxug6x
         onK6Emt1aWVo/rfYKMS03TOmNER9++c0z7RfRNa98B3vSATriK/K0RY7du0wqXkcJtAD
         OJe/ETPhpiWLKDjFV/GbtdoWPaNiWmLUxdcfV1rznbsopipAYYRwABjO9/Q3tposVlwU
         ufGko6MHQIfV30LNdll8thDP+a4IfSUyN3Eb5SG1nZxa5e7xTqrCD4um+gImn27pPn9X
         6yQpWSztIBMbQIUZ1hihmTsF8+tCLViPpEnm6oxUCbUxKwi+sfvWaKnCKVmzZeurhMHb
         Ookw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773219033; x=1773823833;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDHqb+0tAKIx6CbJXkCNT0BIOeQZL5zcuAbIjSUDvxw=;
        b=MCmniFrm3AJ4/41IhGJWIdvgnHiDXIiLJOMFMxJEMfUtHIYQkmvVXhL2QCk11pgFyN
         dFXu5s7J1W+ClXpH4tmCjHmLrzxLh3o5NRHmjW+tX5IWyUGSwEwd5u2ykPIr/HHqDasX
         aHsfI+65TLmWbn3qKByO+0Faw9DNrGuiuH3QHGV6bFMefnkWxCKDFQdHeSURHmLvMJ/R
         411WGVXPnQPu07hOm5jR1ve4/0J30wcrN1JVtzWTYRimiJnDxCS2lkp3iGeKbv/RzTYm
         Hwe+mV2FFBgxgl6AiuYSdZQCrWBjerkwl294QO3mqdy0TcR+Du7zJ5WVotgqLYhv66oF
         /Bnw==
X-Gm-Message-State: AOJu0YyV4qGWGOz4sYkvX8CZGE1QvxvKCAbtRwvn1KyC54sH9nOZuj+J
	uT4jkk3vk7M2bqfIY4l+GMpsGl+djCNX/RisGRTICpciqeh2su4OAYsu2s3c2s3s
X-Gm-Gg: ATEYQzwKhslu8iSpmVah3KjqDOKJkwqB1+575fRBXG0wrEqtzF8++tBQs3zqAgrJXW8
	g/CKTXVjfQFswFD73NiTmCQns73mOIIx9q46Ga1l6nJTV49MZa8jbNf+3rWbY5mg0M8EOdA0Wgu
	qD0Qg4nefpEkEEcQhgeWMWcx8d1cOJeF0xzhLNQr9Rgi+D5f7mHF01YpU6dVtv2UrRfudf5k7W4
	IjaYo7wCcsGuiTp9/rwI0WgC08eY4/NMuQ7I5WpRc+oQZ7URqqsu/pvxq/4YAunB4ZvsUBTsGwk
	Shg7Y7OhjIpqW2hORk+SECx+rGGaS7pZRiKwdmC8t1UzM2XGV7FLiy6FTeaXdF2QP+C0Mwgl1B+
	4ktZhHUiBIjB3jVB0VuxFQINvYjHRNSJt2DJsb8OGSCy0w8vjAbjDCt679awKjLC6L0fPRLhBCj
	9U8my8nzaoXCT299C9x2WBU6g=
X-Received: by 2002:a05:6214:2aa6:b0:899:fc75:cbf with SMTP id 6a1803df08f44-89a66a4719cmr22902536d6.16.1773219032976;
        Wed, 11 Mar 2026 01:50:32 -0700 (PDT)
Received: from [127.0.0.1] ([40.81.42.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65cd5fa8sm9814576d6.30.2026.03.11.01.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:50:32 -0700 (PDT)
Message-Id: <eb5639dbc3571fde15f2d93cf2d137b8df775d2f.1773219028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
References: <pull.2233.v3.git.git.1773149337.gitgitgadget@gmail.com>
	<pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Mar 2026 08:50:24 +0000
Subject: [PATCH v4 1/5] advice: add stashBeforeCheckout advice for dirty
 branch switches
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>

From: Arsh Srivastava <arshsrivastava00@gmail.com>

Add a new advice type ADVICE_STASH_BEFORE_CHECKOUT to guide users
when they attempt to switch branches with local modifications that
would be overwritten by the operation.

This includes:
> New ADVICE_STASH_BEFORE_CHECKOUT enum value in advice.h
> Corresponding "stashBeforeCheckout" entry in advice_setting[]
> New advise_on_checkout_dirty_files() function that lists the
  affected files and suggests using git stash push/pop
> Documentation entry in Documentation/config/advice.txt

The advice follows existing patterns established by
advise_on_updating_sparse_paths() and can be silenced with:

  git config set advice.stashBeforeCheckout false

Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
---
 Documentation/config/advice.adoc |  5 +++++
 advice.c                         | 27 +++++++++++++++++++++++++++
 advice.h                         |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/Documentation/config/advice.adoc b/Documentation/config/advice.adoc
index 257db58918..8752e05636 100644
--- a/Documentation/config/advice.adoc
+++ b/Documentation/config/advice.adoc
@@ -126,6 +126,11 @@ all advice messages.
 		Shown when a sparse index is expanded to a full index, which is likely
 		due to an unexpected set of files existing outside of the
 		sparse-checkout.
+	stashBeforeCheckout::
+		Shown when the user attempts to switch branches but has
+		local modifications that would be overwritten by the
+		operation, to suggest using linkgit:git-stash[1] to
+		save changes before switching.
 	statusAheadBehind::
 		Shown when linkgit:git-status[1] computes the ahead/behind
 		counts for a local ref compared to its remote tracking ref,
diff --git a/advice.c b/advice.c
index 0018501b7b..e1264f525c 100644
--- a/advice.c
+++ b/advice.c
@@ -81,6 +81,7 @@ static struct {
 	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
 	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
 	[ADVICE_SPARSE_INDEX_EXPANDED]			= { "sparseIndexExpanded" },
+	[ADVICE_STASH_BEFORE_CHECKOUT] = { "stashBeforeCheckout" },
 	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning" },
 	[ADVICE_STATUS_HINTS]				= { "statusHints" },
 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption" },
@@ -312,3 +313,29 @@ void advise_on_moving_dirty_path(struct string_list *pathspec_list)
 			    "* Use \"git add --sparse <paths>\" to update the index\n"
 			    "* Use \"git sparse-checkout reapply\" to apply the sparsity rules"));
 }
+
+void advise_on_checkout_dirty_files(struct string_list *file_list)
+{
+    struct string_list_item *item;
+
+    if (!file_list->nr)
+	return;
+
+    fprintf(stderr, _("The following files have local modifications that would\n"
+		      "be overwritten by switching branches:\n"));
+    for_each_string_list_item(item, file_list)
+	fprintf(stderr, "\t%s\n", item->string);
+
+    advise_if_enabled(ADVICE_STASH_BEFORE_CHECKOUT,
+		      _("You can save your local changes before switching by running:\n"
+			"\n"
+			"\tgit stash push\n"
+			"\n"
+			"Then restore them after switching with:\n"
+			"\n"
+			"\tgit stash pop\n"
+			"\n"
+			"Or to discard your local changes, use:\n"
+			"\n"
+			"\tgit checkout -- <file>"));
+}
diff --git a/advice.h b/advice.h
index 8def280688..c035b5d8e3 100644
--- a/advice.h
+++ b/advice.h
@@ -48,6 +48,7 @@ enum advice_type {
 	ADVICE_SET_UPSTREAM_FAILURE,
 	ADVICE_SKIPPED_CHERRY_PICKS,
 	ADVICE_SPARSE_INDEX_EXPANDED,
+	ADVICE_STASH_BEFORE_CHECKOUT,
 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
 	ADVICE_STATUS_HINTS,
 	ADVICE_STATUS_U_OPTION,
@@ -83,5 +84,6 @@ void NORETURN die_ff_impossible(void);
 void advise_on_updating_sparse_paths(struct string_list *pathspec_list);
 void detach_advice(const char *new_name);
 void advise_on_moving_dirty_path(struct string_list *pathspec_list);
+void advise_on_checkout_dirty_files(struct string_list *file_list);
 
 #endif /* ADVICE_H */
-- 
gitgitgadget

