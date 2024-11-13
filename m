Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70D9C147
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459136; cv=none; b=rNJZLmIt6jvYol4UNXf8mNyatcXwlnLPeqPeCFOPYI74mJCIxAWOSI22gOJMzsgKvxqABrhe0gMSh/OTJkDHBZ0hf1JThLc6fJiJbDBDVKlpQ6XeYYxG58rcBqj9OilD5T21UxKZRD/7Rf4mm7BRrpAvY6Kw0MFyRVAmltC6d+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459136; c=relaxed/simple;
	bh=rvPhr0//X4L2n/g7/j43QDIaxRWHqGE3sZkpuEjOeYE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=p/bYNc/TVfrmPsJtnvH/xxYSsB24Vx2ASbnl2KZckJVg4DSIPZ0BK3m6JD4n9ia7R3Ih5Oo3JLH3NiVuPfBHeIkO+mnEfraTmrnm591HUVypSqjC25f/ZahchqbefTmplj7cBBNLh0Ai7u7d2UbWNXE9e95hRBSeis9VNVZoSig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cM5lkh5F; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cM5lkh5F"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4314f38d274so79351855e9.1
        for <git@vger.kernel.org>; Tue, 12 Nov 2024 16:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731459133; x=1732063933; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW1FnMD8h6nUXg181Dfk4yTuTgYRbDWen/pqY6AhIgQ=;
        b=cM5lkh5FsBPHXrz9qeKpeXxeO0oqL3VHvBxfQ1l2sBCRcH8kAyK1C30lhTErLPSltw
         arRZZq8ZG+Myk8zDErFz2P7v45K/ZbxhxdxhLjavc53IsJXEGSB0fTyt+AfwhBB/LU1a
         IQA3FOu+qa/v0SKx9g4x35mipmTJ4u/ENv9EePfL6aTdK1NERcXPTwgxNhEbiVOdC+Hk
         lZnoNpz8lO+oTf44TDNHOpFdJdNZHhiVDaOSfV+MO5FJyMZheqzWp9XgCpn8uaz9/Mi1
         irZnTjxdBaOFz6pggd2yJTx4VwEuhOOmeH3UD68UFIzXYvzgBAAdaHwvO8vlbBGPEJWt
         GSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731459133; x=1732063933;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CW1FnMD8h6nUXg181Dfk4yTuTgYRbDWen/pqY6AhIgQ=;
        b=Dc+mihFv4jW5MhxiYFylRcqfyTERDR379Q1LtJ6Xi1o8wFzBSk54MPay11Tkjq1Ra0
         f1R95PmRrzSbhfvu7vX/REFnq1t1j3HGoZS/vv9uFW+PhjzG2emX+mZuXt7BcS9HQm01
         W29GCQJRB/DxZVfgQHNqIfvmATcV/UGr6zztC7u0/b2W/Zuqst+dAa5+ymVfLBlsgE0n
         ciSwVvAczGkegArzjFkXdiI+yWOcs5OackRC9zFnCdDsT45IvPGaFKkFbGubobDxMEtp
         F1ckKbJUOVEkZuogh7gqhYM6hyQywacBZFleddZe7OgQsqYH4fG+jOEy4H3DpocAsOhL
         eUWw==
X-Gm-Message-State: AOJu0Yz0uXArkHXePEJKyj0+pnTeyyAUSqm9DrA08csHx48xf0dQSHQd
	pUuflIx7/c5uXtjOimkZlPxbLg82a7D2QC/epwuLMufi1cg9hAS3x959yQ==
X-Google-Smtp-Source: AGHT+IFsupcilVP21zWqtZE22N5tsmlrDO5OVvzj4k7MjGkyaSRFz/idbqPmtPCDLiTWBgCwjKd/lA==
X-Received: by 2002:a05:600c:3b87:b0:431:5ba1:a520 with SMTP id 5b1f17b1804b1-432b74fec0bmr207572225e9.3.1731459132626;
        Tue, 12 Nov 2024 16:52:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d5503abesm4780515e9.20.2024.11.12.16.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 16:52:12 -0800 (PST)
Message-Id: <79c3a6ffe8f2872755f76340e2d5ae1a94885456.1731459128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 Nov 2024 00:52:06 +0000
Subject: [PATCH 3/5] git-mergetool--lib.sh: add error message in
 'setup_user_tool'
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

which is not very user-friendly. Adjust setup_user_tool to output an
error message before returning if {diff,merge}tool.$tool.cmd is not set.

Adjust the second call to setup_user_tool in setup_tool to silence this
new error, as this call is only meant to allow users to redefine 'cmd'
for a builtin tool; it is not an error if they have not done so (which
is why we do not check the return status of this call).

Note that this behaviour of quietly failing is a regression dating back
to de8dafbada (mergetool: break setup_tool out into separate
initialization function, 2021-02-09), as before this commit an unknown
mergetool would be diagnosed in get_merge_tool_path when called from
run_merge_tool.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 git-mergetool--lib.sh | 10 +++++++---
 t/t7610-mergetool.sh  |  8 ++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 269a60ea44c..f4786afc63f 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -159,14 +159,18 @@ check_unchanged () {
 }
 
 valid_tool () {
-	setup_tool "$1" && return 0
+	setup_tool "$1" 2>/dev/null && return 0
 	cmd=$(get_merge_tool_cmd "$1")
 	test -n "$cmd"
 }
 
 setup_user_tool () {
 	merge_tool_cmd=$(get_merge_tool_cmd "$tool")
-	test -n "$merge_tool_cmd" || return 1
+	if test -z "$merge_tool_cmd"
+	then
+		echo >&2 "error: ${TOOL_MODE}tool.$tool.cmd not set for tool '$tool'"
+		return 1
+	fi
 
 	diff_cmd () {
 		( eval $merge_tool_cmd )
@@ -255,7 +259,7 @@ setup_tool () {
 
 	# Now let the user override the default command for the tool.  If
 	# they have not done so then this will return 1 which we ignore.
-	setup_user_tool
+	setup_user_tool 2>/dev/null
 
 	if ! list_tool_variants | grep -q "^$tool$"
 	then
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 22b3a85b3e9..82a88107850 100755
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
+	test_grep -i "not set for tool" out
+'
+
 test_done
-- 
gitgitgadget

