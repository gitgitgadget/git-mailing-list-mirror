Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C4F283122
	for <git@vger.kernel.org>; Sat, 10 May 2025 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746902086; cv=none; b=gkZizUs5j6TGtIXc/nkaAfOrorRxFIjQVUJrYsCG24L39QyBFp3yHeozhlgLlb2nzzJLz6Sk9IIqsLah7aGpv0HCNI1agee6idj8qhACe2Ni021Cig1zK8zd9cu4ZSPKSQGqbVVbv0gR4xzQDhRGr6LCbanh0dLze56jj38I014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746902086; c=relaxed/simple;
	bh=9f/LQ9HvBkvq+CxFmXdlR9xuFdnNLxWRYFn742Jw2DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7Rroo3bjJ8/a/NtJSMzKw5IE+L7iuy5dqVdds/S59KdrFBawF7rGu9Xp1tt86MpYaUhBqWOmCwXx1fuNDtnhEamFYm7jZIuXoWQe6WAYx6ej3TyWmCEaGzBTnnADzcvUb4/OdyDtd+oSKYqDY58QLBzHRRNMId4PAAt3kGQVFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DemGcRp6; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DemGcRp6"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e6e2971f79fso2919061276.0
        for <git@vger.kernel.org>; Sat, 10 May 2025 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746902083; x=1747506883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HiGXrQfTS5rf6zZjTkBvh28nHMDhdTDJ9F2EMGPWaM=;
        b=DemGcRp6XFEmBj+FZAqxrbnlTNzxJ51Y/kytrArdLrdClY4thdCUABOgE84qXyZ7Il
         IWAc77waqc9Zl3cz/Yl8RdD3xjQSyjSns0MTO8QLYZumPAS7zD6vrAIj31xmofNZ4UXh
         ZcBamAHI2WjwGFwIg+zh0M2cKklQkeR8IWcFgHkDS5MvAVRR+v/xVAJMou8r5S7rj4mv
         gL+V2XnuxTmK+5nxdGHbFeEdCpzL6bsJjScMOtPwohGGtSAlaROxUEI4EFfPcxCBpG74
         Ifv1Tllbds5hrzbHjr3gZMKIWH1Acz5KGft8YhJwDA8zRZqf4C08YD5406tBCIpbjJWs
         12Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746902083; x=1747506883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7HiGXrQfTS5rf6zZjTkBvh28nHMDhdTDJ9F2EMGPWaM=;
        b=g4d67AAuK/F35fnhflzo9U9hLrZXKgcgq4mEFZ/qdBcAcN4728RZ9VMZ//ZAa+LxfC
         lJEsd4zgXErQ+a3eH+9NXV3gAVmv0Z4dErsv+UWTia2Oxx17p/QMY6pyq9vdbwyMXuIl
         gzk7vai7//EZQpzIuN9dQths85xNjjY2BHtbfKVbvGvVCtpjBK3rDj6IEz0ZKcpnwrUU
         NrAwZoYAAFdp1GRQAc1DvKdnEf4bmgu1piuQVkeREIsYBOhzLowKgw5flH4TtcqU9czX
         ZJJ5RamsEVVSC7NgL4/eeDo3UfOacOtnrmdItxD5zoHTukOGq2EdSkYixt4f5eR+3SAu
         +GAw==
X-Gm-Message-State: AOJu0YzVXciVbeqxsuqY7h7Mh3auO0v641mXA4gcT+WbZVQblDuGpB/6
	I7n2tG/RxBaAB9Re4GMpgdTCA4UdwwV0SHhXCdoFvKm/9xzC4OXOxBEJJhWU
X-Gm-Gg: ASbGncvilqne7ccHPnfuyPw2S22eiaYmDpjYV3uqSLZNnH/hKsuG+sJT/FulgPS/wIc
	GnpBahvumVDTRMdmNLgLiOw8tPoVV0o8BBoScU5BjAvuf8YLSccwh8n6bOixhSxxBHFxwcS+Nrd
	+Zhp1A2v+gtLpLYE+X+kKTp2uRQ48KzFI9j+DAvfVk09rjNMcLqbDJfJGAAJDZdUGhYaxfIFXtW
	uTVcLUfYoAMIdkFXDs/ux1WY1zNvXxE4ST6aicNmQPHLCzJoj25pznrqcE0c28PbGepvmIasQ12
	YdgxEpdITpMC1SBQvbMbaOLipsshc0/OE5916H9bKxb2Of9PNhF4v2QCgmsQgslXKuUZXax+KoN
	r+i7oHvi52G+PCIYFvAiX6wh+
X-Google-Smtp-Source: AGHT+IF0ay4KkN4IMlKU3rex/F17aPvBxOxoqMadqCydg78FxzcyYgvBfN0FhFmiWtTTOucT2w7GHA==
X-Received: by 2002:a05:6902:138d:b0:e75:bf2b:84fa with SMTP id 3f1490d57ef6-e78fdd7a6e5mr10290891276.47.1746902083230;
        Sat, 10 May 2025 11:34:43 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a6:1600:541:bcf5:33bd:f1fc])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e78fd4a72f0sm1191649276.20.2025.05.10.11.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 11:34:42 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 9/9] t3906: adjust stash submodule tests to account for breaking changes
Date: Sat, 10 May 2025 14:33:44 -0400
Message-ID: <20250510183358.36806-10-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510183358.36806-1-ben.knoble+github@gmail.com>
References: <20250510183358.36806-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I cannot explain _why_ this occurs, but it seems that automatically
unstashing the index from previous commits resolves some known failures
in t3906 (which are captured by t/lib-submodule-updates.sh).

In particular:
- 'replace tracked file with submodule creates empty directory' succeeds
  with breaking changes;
- all KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR tests
  succeed with breaking changes;
- all KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES suceed with
  breaking changes.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/lib-submodule-update.sh | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 36f767cb74..4ae909c432 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -353,7 +353,21 @@ test_submodule_switch_common ()
 	'
 	# Replacing a tracked file with a submodule produces an empty
 	# directory ...
-	test_expect_$RESULT "$command: replace tracked file with submodule creates empty directory" '
+	test_expect_$RESULT !WITH_BREAKING_CHANGES "$command: replace tracked file with submodule creates empty directory" '
+		prolog &&
+		reset_work_tree_to replace_sub1_with_file &&
+		(
+			cd submodule_update &&
+			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
+			$command replace_file_with_sub1 &&
+			test_superproject_content origin/replace_file_with_sub1 &&
+			test_dir_is_empty sub1 &&
+			git submodule update --init --recursive &&
+			test_submodule_content sub1 origin/replace_file_with_sub1
+		)
+	'
+	# (unless we automatically unstash the index!)
+	test_expect_success WITH_BREAKING_CHANGES "$command: replace tracked file with submodule creates empty directory" '
 		prolog &&
 		reset_work_tree_to replace_sub1_with_file &&
 		(
@@ -368,7 +382,8 @@ test_submodule_switch_common ()
 	'
 	# ... as does removing a directory with tracked files with a
 	# submodule.
-	if test "$KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR" = 1
+	if ! test_have_prereq WITH_BREAKING_CHANGES &&
+		test "$KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR" = 1
 	then
 		# Non fast-forward merges fail with "Directory sub1 doesn't
 		# exist. sub1" because the empty submodule directory is not
@@ -392,8 +407,9 @@ test_submodule_switch_common ()
 	'
 
 	######################## Disappearing submodule #######################
-	# Removing a submodule doesn't remove its work tree ...
-	if test "$KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES" = 1
+	# Removing a submodule doesn't remove its work tree (unless stash applies the index!) ...
+	if ! test_have_prereq WITH_BREAKING_CHANGES &&
+		test "$KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES" = 1
 	then
 		RESULT="failure"
 	else
-- 
2.48.1

