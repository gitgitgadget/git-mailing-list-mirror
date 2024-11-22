Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F571DFE31
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732305031; cv=none; b=KQbqwFMVQb4MurZZke3CXEHJZmIL9VbJz9ckjE8z8L8aVghwLeIU+hX8Jr5Bc87rh/ZNaJ22nMCe80byB1DQSFLW7zfysv08bDzGyUeATQQvXJwgnVkjpRITy8UnMUDquj1UWaiHVTuuXM9wiIyA3XpPqcOU42G4JCrI00uMLY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732305031; c=relaxed/simple;
	bh=siOq5z8GqqGxaWRdsju/c/Z5/XLOPgCbQ+1Ae19Meks=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BpabR5Nvg6EEZmnk9lk6kxVNu95EICyecrnYbLGP4NdXK8vUSpeRKn8BtqwS82lwb9EM7vp8jmgPPH6r8XeVm9tLYE4D48jEWzoAengVVLGTrkc+qTQt4mejIylgEtJjtD/lEfoidmywR52xuarr5qNv1yaVHBjqtu+/OggXjvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlY2W4HO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlY2W4HO"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43168d9c6c9so22257095e9.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 11:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732305028; x=1732909828; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdKu/IJhnOg7qsEROIV+hwt1Jj1eUorL5hBHwgZIZZY=;
        b=RlY2W4HOneIonkqx5/71hcRpfU7TShdkOe2TsO2GMgY9SFZTubhHcl1DK9P3B5Yn3t
         I6YdsF/gHLL7Qatxh+BIIKmNKrsUuQn+ZEsddCNses8fGIahxQdYjSKvUUfslpZ3fJi1
         bJg/9X6ePtrCYVa9Q2TQy16fsbJNC9S4OTS6iF8+T9Otl7Pt0usSy+sDvDXQiFijkneM
         RRu3rqgwYeEAajQxwy1Cai+4V6lE0Z4anbE4mvzig1H23xJskn/36vJ48kneXkNY5wDW
         xp0inTcoxguxDiC4YYSP2PyONVdesgk7hYaN5kiiWAYAxIyez6q4rvDj448LjuA5ZkpG
         SJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732305028; x=1732909828;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdKu/IJhnOg7qsEROIV+hwt1Jj1eUorL5hBHwgZIZZY=;
        b=wreei//5KhVAFAjS0RRFdMeJ+Pm/iLAkhZT4edwS9rFHc5/Uaccj8oCr95JiYza3FY
         uN6k0ITiKZBnpad8qxopjibfO0VpAsCUppDxnYsl498feumNP5deOPQeM+gOuXp9fSZh
         XlYHewHAK8Xw599RQXbILWASmZdxCP8Ltb35z/QZvfurXpd61vGGi/v/n93Moy+UF02l
         78H50sb9ROuB1cYrGLyHoC7b4QTaL+tImVk+EuMyGL5v8iTs/glKuyvxMxmQZN22wKKB
         dOWhKMepo4LTB1A/55Wrzh2yTowUz9jAThxX0s/wMLjNEvG93USbXEFe756IK/q/ddyg
         bsVQ==
X-Gm-Message-State: AOJu0Yyh/YJy1f1HKs5SIwAkpAE1OUdCxViFFOCMlY3+WBRSFjj0s44X
	kXJ8nJR7lx0VxE0Vq4F+F+2GMnHZQMpqUT0sJLizGdQ52Tj/bHIyL2moGA==
X-Gm-Gg: ASbGncuuBQL5KrrnV9sAdduE980XMi+L6g4B+5GXZwZ4lJwwwz40Y3708ON1ez2tQY8
	VfIqIZNUOR6SGSoYxTo0HGbB29tAYiTdyALrSITzKk1Vgg8jfD/hI+IkzUHDlW8v0l30fQVj756
	vpHT1zdUBJTjnNFTgomOsaEyygUvcKJ+1wroUCie18nGsKb9Kxo8a95JRFHRnzzXrn+k2wdqFOL
	LYgYTtCHjgqDW2FP9kQmtQkCzsGxPG5BXkeFe/hjqk96v302sM=
X-Google-Smtp-Source: AGHT+IF1wyvHynu0+PdzIq+RFXkUCt0d9Fh0eCIYH/GuvLny0zMeDx31fTm2gpvtkyU/pAYaVhllBQ==
X-Received: by 2002:a05:600c:3b19:b0:431:3933:1d30 with SMTP id 5b1f17b1804b1-433ce41101cmr35055615e9.5.1732305028175;
        Fri, 22 Nov 2024 11:50:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde16a95sm37732165e9.18.2024.11.22.11.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 11:50:27 -0800 (PST)
Message-Id: <1d9e95c6cb14df3d3225210bde3c4877cb4cc540.1732305022.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1827.v2.git.1732305022.gitgitgadget@gmail.com>
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
	<pull.1827.v2.git.1732305022.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 Nov 2024 19:50:20 +0000
Subject: [PATCH v2 3/5] git-mergetool--lib.sh: add error message if
 'setup_user_tool' fails
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
Cc: Seth House <seth@eseth.com>,
    David Aguilar <davvid@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

In git-mergetool--lib.sh::setup_tool, we check if the given tool is a
known builtin tool, a known variant, or a user-defined tool by calling
setup_user_tool, and we return with the exit code from setup_user_tool
if it was called. setup_user_tool checks if {diff,merge}tool.$tool.cmd
is set and quietly returns with an error if not.

This leads to the following invocation quietly failing:

	git mergetool --tool=unknown

which is not very user-friendly. Adjust setup_tool to output an error
message before returning if setup_user_tool returned with an error.

Note that we do not check the result of the second call to
setup_user_tool in setup_tool, as this call is only meant to allow users
to redefine 'cmd' for a builtin tool; it is not an error if they have
not done so.

Note that this behaviour of quietly failing is a regression dating back
to de8dafbada (mergetool: break setup_tool out into separate
initialization function, 2021-02-09), as before this commit an unknown
mergetool would be diagnosed in get_merge_tool_path when called from
run_merge_tool.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 git-mergetool--lib.sh | 9 +++++++--
 t/t7610-mergetool.sh  | 8 ++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 269a60ea44c..d7e410d9481 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -159,7 +159,7 @@ check_unchanged () {
 }
 
 valid_tool () {
-	setup_tool "$1" && return 0
+	setup_tool "$1" 2>/dev/null && return 0
 	cmd=$(get_merge_tool_cmd "$1")
 	test -n "$cmd"
 }
@@ -250,7 +250,12 @@ setup_tool () {
 		. "$MERGE_TOOLS_DIR/${tool%[0-9]}"
 	else
 		setup_user_tool
-		return $?
+		rc=$?
+		if test $rc -ne 0
+		then
+			echo >&2 "error: ${TOOL_MODE}tool.$tool.cmd not set for tool '$tool'"
+		fi
+		return $rc
 	fi
 
 	# Now let the user override the default command for the tool.  If
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 22b3a85b3e9..c077aba7ced 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -898,4 +898,12 @@ test_expect_success 'mergetool with guiDefault' '
 	git commit -m "branch1 resolved with mergetool"
 '
 
+test_expect_success 'mergetool with non-existent tool' '
+	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count branch1 &&
+	test_must_fail git merge main &&
+	yes "" | test_must_fail git mergetool --tool=absent >out 2>&1 &&
+	test_grep "mergetool.absent.cmd not set for tool" out
+'
+
 test_done
-- 
gitgitgadget

