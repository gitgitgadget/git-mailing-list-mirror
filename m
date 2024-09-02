Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A479182B4
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 02:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725245933; cv=none; b=B0+kXEjD59dXi48rA5VZajIg9MZNi96qaPN7O0mRVXWj0zm/Xl1wENoyWtxnwjcDGFmbwAUdO1o3fLeTzJYOiJnldjm8TTK7EddnMRckWco3WyKC6bkBiK8QAXWloXzrrzCiXoNFf4+gtnNZ1j5GWC+6EFkS0FxxkLWnwAX1IKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725245933; c=relaxed/simple;
	bh=enFKLb6oL0LsQFOkz3xi9A1pp4paH+zb2ibgSXVxOhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZsW6ONywyTg5H2/e1y8HT6MD1jWJ4HJHs9G8owlHEFlPgGtQKiQzE5R941b9BDgrEa4mfsWlLdLfD5yB+t6ZpDvveZ32C7sT2qnbw/Pr7bWaIu8NKlKOB7c+tCEpDtDyqaCQjpzE9h2Y0TVmXMfwOhEpHQeMI7XJKpCFos3ryas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c95Yhfes; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c95Yhfes"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3df06040fa6so2020846b6e.3
        for <git@vger.kernel.org>; Sun, 01 Sep 2024 19:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725245931; x=1725850731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAckgoa8hfE90FANbN7m5fBgddgrmkC8O+8vSumxbCw=;
        b=c95YhfesW9T7+v2ork7mNjIaDtCanZFIN9YANmXqE36CXBn7KzF5GBTx44Ul7yZmEN
         6quvng1OhqWja3rScaMi6e/xmkGyMzVBAAVGcA+4zjVDOcYeAnjZLeXmfpZw8D4fRZLJ
         /NC7zJUMFrJCxAfaDrlH3NZNhpwmPBl8KvOFSMatLotN0TFxlKgV3coCDDgbz/iRzXNH
         0LEn/vWZDJCsk7lNM6UIFTfljGxxwccN2iBzxuBy/MmjOJXGIXprNVVm1AU/p0wKUdld
         rV4doUR9yEjNP8ddD7iL0/olueSoPk5DIzN/RlEZpyUXR4un5lWmfpCNs9c4trgYLj8Y
         xIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725245931; x=1725850731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAckgoa8hfE90FANbN7m5fBgddgrmkC8O+8vSumxbCw=;
        b=ViRhUvru7smsucxdBx3HWF3TO6h/xRFFOfRtgbomMb09o+XTRcWs/hgXJf7CEVjIqr
         vZNA/NDGAgazMcyWHJ8p4eUbPVmMUXZ/Ho8ScovlHX1fAC2KyA5ok09XbtJQJ0QnZXkT
         rzjMCLcueC1w34gFyzr8d8UZZU0b18bNpavLv/LpfbwlBceXPZR7jF9ooCabdcnxjX7I
         CLCo+j510OOzF9D1HHNTaDh4gwzfThhYy8h+tPr6lTct70ZGHw5p44K+JpkNQauyASBC
         36HFm+us/kN68VMEJ0BoR6KLI41rXMPtcBLZ5i2ZI46YjQfGpqFPk39Qa+QavsyyYGrx
         mBhA==
X-Forwarded-Encrypted: i=1; AJvYcCVmEMAy5mn1V7sGlm/9BtHBzrhp2cvdzNyRfz52+RL3ZlCbSJlGPJ3damOpZYQFGIV9n9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWrgxxRG7U2CzmO5osLVodtDwHXdZavq/8GBBxyFuiNY/K6H1G
	2nZ+7p/fcuR3tOzIfAFdnV6uv+yOd4Wf14gzhAVndV0Uch2EXuBW
X-Google-Smtp-Source: AGHT+IFbvqQc3CBpacMWqTSZdsFyFRtaaBJD0SxvS/uoQBYOOzjfxkVKVBjGV4gWkUqo1gph3dPwUw==
X-Received: by 2002:a05:6830:71a3:b0:709:42dc:a017 with SMTP id 46e09a7af769-70f706f42e2mr6619479a34.12.1725245931142;
        Sun, 01 Sep 2024 19:58:51 -0700 (PDT)
Received: from panther.lan ([2607:fa18:92fe:92b::47f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a5223sm5882828b3a.72.2024.09.01.19.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 19:58:50 -0700 (PDT)
From: Alex Henrie <alexhenrie24@gmail.com>
To: Johannes.Schindelin@gmx.de,
	cogoni.guillaume@gmail.com,
	stolee@gmail.com,
	gitster@pobox.com,
	git@vger.kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] mergetools: vscode: new tool
Date: Sun,  1 Sep 2024 20:59:14 -0600
Message-ID: <20240902025918.99657-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VSCode has supported three-way merges since 2022, see
<https://github.com/microsoft/vscode/issues/5770#issuecomment-1188658476>.

Although the program binary is located at /usr/bin/code, name the
mergetool "vscode" because the word "code" is too generic and would lead
to confusion. The name "vscode" also matches Git's existing
contrib/vscode directory.

On Windows, VSCode adds the directory that contains code.cmd to %PATH%,
so there is no need to invoke mergetool_find_win32_cmd to search for the
program.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 mergetools/vscode | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 mergetools/vscode

diff --git a/mergetools/vscode b/mergetools/vscode
new file mode 100644
index 0000000000..3b39b458d6
--- /dev/null
+++ b/mergetools/vscode
@@ -0,0 +1,19 @@
+diff_cmd () {
+	"$merge_tool_path" --wait --diff "$LOCAL" "$REMOTE"
+}
+
+diff_cmd_help () {
+	echo "Use Visual Studio Code (requires a graphical session)"
+}
+
+merge_cmd () {
+	"$merge_tool_path" --wait --merge "$REMOTE" "$LOCAL" "$BASE" "$MERGED"
+}
+
+merge_cmd_help () {
+	echo "Use Visual Studio Code (requires a graphical session)"
+}
+
+translate_merge_tool_path () {
+	echo code
+}
-- 
2.46.0

