Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8E628E6
	for <git@vger.kernel.org>; Sat,  4 May 2024 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714791854; cv=none; b=AhJuyCUedcE92NTCWx2oPuZUB9IITjGozhWoBW/m+fOXTrc4Y8VSKqUxUrlt/B8YSLDfExTnoAToL8zeQEW+8x22ffgMvURzVZgS/hWKqN9VB45Q6779/hrWTJ/ERDl287hBlxkGneDZTBLhBFM/VgIzz3ZKtVJcKECCqRwSlhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714791854; c=relaxed/simple;
	bh=lyqDdkPyfpfbUVafr5a3ZsJaj3a7I/Mhti5RMvQV4pE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=l45+nHteknag35xbVhjyD0fVTMP1oDKlSlwxe0fpxgRMsKht05W3zUiOE3EkHjECAmOQ6tTrR2hX8VK1WkZ1JSF02hg8leLH13b3uhZ9M1nUOWBdRTF++yZklrCIh9bNlRhEuZy+VgRKwhaOVdooen8QOMOU/ARBeBYRl240+og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDJodsSY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDJodsSY"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34db6a299b8so198057f8f.3
        for <git@vger.kernel.org>; Fri, 03 May 2024 20:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714791851; x=1715396651; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gv7+/OHXCkLMZiWysCrc9VfV0mjmwJKw0sqasmCY1FA=;
        b=NDJodsSYziEcvjnTFiB86p8O4hnWRAV3RNhqGJzdT0Q6kgfgoNdLtjc51SoJqoBX97
         0v7yq25Ux6QRsQmBStYN8BGHliCdahPTWbd8j1L/hJCOZwxT+Z8BWy0wCZqQRDuV4PPu
         uY9XC40HEqEQ+1d0AsDCklnBGIiBLvQhNi0boICuN4irNBRChkblbgUYTff01pKZKpMY
         kEva8GE1VnvKS+M+8q+1repb+rlRkH16Bw2QV7LjfFL7QmFYfKZfu6L6pX0pQnW32tNq
         yZgBqX4Yy64Zn4nWD4HnQUVxmBMHNRc4anzcjYHfUTAu7AT5mqy+GJSZrMUM83Ye8BW2
         0kPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714791851; x=1715396651;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gv7+/OHXCkLMZiWysCrc9VfV0mjmwJKw0sqasmCY1FA=;
        b=icQHgkKIHvmoTuXQg3LA5+AuairipvTnrLwrXLIM7UKVRwwBOfMOWCGD2uuIn3btxw
         o9S4jaKxpMCekmO/56uwasJKiJFFpGlvylxjjK+YJRXOxxvhRrWVf3y/QYdVOISG8qCe
         wgGyyhP0e2tYAugkQmxkvLchxG4aZnHTOWyU3N5pd1z3vjvDYA66xpRPMyudhtGVsNKK
         KV+a9lnIGR3li19TWcfxepa+uFMIQPrErWghhnAsfXTPBTgTFOmpDbHJScLJeqK6el4S
         8RFPMJ3iZOAJg4g3+tVOA0vBinSNdC5oFV+68BSdDQS7L5EGeVkudUevQtgbpa9Z5iQX
         O+xA==
X-Gm-Message-State: AOJu0YwYkHAxmuKcEhCcmAiE4Hx1WhgQhkOGl6qN0PffoRoEJSQCO8+M
	z75b2j12Ndc5qrlCmldeuFsgNMBT1St+ifcWW2Peefpz6Dccsw5svdTQ/g==
X-Google-Smtp-Source: AGHT+IHOhokPrUP2LKNqoHuXcDabvfFY/8E0WXTOF6O+uXi4+SafLW8s6cd2dRtpMoaOsNOeurVuBg==
X-Received: by 2002:a5d:4444:0:b0:34d:b284:9540 with SMTP id x4-20020a5d4444000000b0034db2849540mr3079465wrr.4.1714791850468;
        Fri, 03 May 2024 20:04:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15-20020adff08f000000b00343eac2acc4sm5116902wro.111.2024.05.03.20.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 20:04:09 -0700 (PDT)
Message-Id: <pull.1716.v3.git.git.1714791848557.gitgitgadget@gmail.com>
In-Reply-To: <pull.1716.v2.git.git.1714711829698.gitgitgadget@gmail.com>
References: <pull.1716.v2.git.git.1714711829698.gitgitgadget@gmail.com>
From: "Ivan Tse via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 May 2024 03:04:08 +0000
Subject: [PATCH v3] refs: return conflict error when checking packed refs
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Ivan Tse <ivan.tse1@gmail.com>,
    Ivan Tse <ivan.tse1@gmail.com>

From: Ivan Tse <ivan.tse1@gmail.com>

The TRANSACTION_NAME_CONFLICT error code refers to a failure to create a
ref due to a name conflict with another ref. An example of this is a
directory/file conflict such as ref names A/B and A.

"git fetch" uses this error code to more accurately describe the error
by recommending to the user that they try running "git remote prune" to
remove any old refs that are deleted by the remote which would clear up
any directory/file conflicts.

This helpful error message is not displayed when the conflicted ref is
stored in packed refs. This change fixes this by ensuring error return
code consistency in `lock_raw_ref`.

Signed-off-by: Ivan Tse <ivan.tse1@gmail.com>
---
    refs: return conflict error when checking packed refs
    
    Changes against v2:
    
     * move test_grep to follow after their respective git fetch commands
     * Use "${SQ}" instead of '\''
    
    Thanks for the explanation and for the comments. I've updated the
    changes to incorporate your feedback!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1716%2Fivantsepp%2Freturn_name_conflict_error_for_packed_refs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1716/ivantsepp/return_name_conflict_error_for_packed_refs-v3
Pull-Request: https://github.com/git/git/pull/1716

Range-diff vs v2:

 1:  58b2cda5c18 ! 1:  943a8629b5f refs: return conflict error when checking packed refs
     @@ t/t5510-fetch.sh: test_expect_success 'branchname D/F conflict resolved by --pru
      +	(
      +		cd df-conflict-error &&
      +		git update-ref refs/remotes/origin/dir_conflict/file HEAD &&
     -+		test_must_fail git fetch 2>../err &&
     ++		test_must_fail git fetch 2>err &&
     ++		test_grep "error: some local refs could not be updated; try running" err &&
     ++		test_grep " ${SQ}git remote prune origin${SQ} to remove any old, conflicting branches" err &&
      +		git pack-refs --all &&
     -+		test_must_fail git fetch 2>../err-packed
     -+	) &&
     -+	test_grep "error: some local refs could not be updated; try running" err &&
     -+	test_grep " '\''git remote prune origin'\'' to remove any old, conflicting branches" err &&
     -+	test_grep "error: some local refs could not be updated; try running" err-packed &&
     -+	test_grep " '\''git remote prune origin'\'' to remove any old, conflicting branches" err-packed
     ++		test_must_fail git fetch 2>err-packed &&
     ++		test_grep "error: some local refs could not be updated; try running" err-packed &&
     ++		test_grep " ${SQ}git remote prune origin${SQ} to remove any old, conflicting branches" err-packed
     ++	)
      +'
      +
       test_expect_success 'fetching a one-level ref works' '


 refs/files-backend.c |  4 +++-
 t/t5510-fetch.sh     | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a098d14ea00..97473f377d1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -794,8 +794,10 @@ static int lock_raw_ref(struct files_ref_store *refs,
 		 */
 		if (refs_verify_refname_available(
 				    refs->packed_ref_store, refname,
-				    extras, NULL, err))
+				    extras, NULL, err)) {
+			ret = TRANSACTION_NAME_CONFLICT;
 			goto error_return;
+		}
 	}
 
 	ret = 0;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 33d34d5ae9e..530369266fd 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1091,6 +1091,22 @@ test_expect_success 'branchname D/F conflict resolved by --prune' '
 	test_cmp expect actual
 '
 
+test_expect_success 'branchname D/F conflict rejected with targeted error message' '
+	git clone . df-conflict-error &&
+	git branch dir_conflict &&
+	(
+		cd df-conflict-error &&
+		git update-ref refs/remotes/origin/dir_conflict/file HEAD &&
+		test_must_fail git fetch 2>err &&
+		test_grep "error: some local refs could not be updated; try running" err &&
+		test_grep " ${SQ}git remote prune origin${SQ} to remove any old, conflicting branches" err &&
+		git pack-refs --all &&
+		test_must_fail git fetch 2>err-packed &&
+		test_grep "error: some local refs could not be updated; try running" err-packed &&
+		test_grep " ${SQ}git remote prune origin${SQ} to remove any old, conflicting branches" err-packed
+	)
+'
+
 test_expect_success 'fetching a one-level ref works' '
 	test_commit extra &&
 	git reset --hard HEAD^ &&

base-commit: d4cc1ec35f3bcce816b69986ca41943f6ce21377
-- 
gitgitgadget
