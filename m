Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E7A78F26
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766850020; cv=none; b=HtnlTRCQN1v+PTVFtntwkNOeoNllTVjW7RJ/zUrDB3qvyYZCgXEVL5IOrvPm4MtpM/of63Ig9mxWKhrAs2+6ZIcHNJnyVmcWRWBPgEKvwDDpLSe6Lb+wwrOqI5MC1iDHWSOcElkk2BBA4h+IL44tRqLsU7DDLXkDJpfsnMgea2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766850020; c=relaxed/simple;
	bh=TvtdNJlIMJjezxM92FPUrHQkBi0Oy5fri3yuFwKnVbI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=IWKa3JtE32zc7haq4MDLRwYy5jprhy4XCRRFByBl9OZYPyGFMzP7UIbFF6TXqjvx6IPVCWeDb5jGdcBKR3UfY7w4VHOGHnGv8h24pvdsuZtuVPyLBLH8nOdIOT2R0Nh5vQU3xxW7f2fszufDJY4oso017yihTEnJONBqQi6qiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9pS2QTR; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9pS2QTR"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-45391956bfcso6445913b6e.3
        for <git@vger.kernel.org>; Sat, 27 Dec 2025 07:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766850017; x=1767454817; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BW/e85aLRA1TJT48v1C42BB7L8LxAVGmK11Zp532XcE=;
        b=e9pS2QTRn9/xsXmiIa2aN/Qo3PKB2vl7magMoQ6ZeV7FeGnCRYnzjcWWeu0aiYm4GO
         ftjZ6d9mY7AJ9du9BXB/LVTmSW0yGsFXiCftZFCi2F7qaBxnDXXG/quN0W2ktievLLGf
         +i8C4RgaMO36SF0LUvi6dNm6QFDBKsez7KA5vvvDW67gslCDM1oTRPrEXphUmqLgNqMS
         ttP1hDPWVDkCjpq2rpvST//tjDUGV3gZzQhyXyGgf72z6mms+HZFGqPazwBZWawbYn4n
         4rus8RmHXY/V4qh8TbGF6bgKcUir1nGOO22MaKyPYQ0flQmPY0QSZHDsKjGGsKegZhi7
         CfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766850017; x=1767454817;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW/e85aLRA1TJT48v1C42BB7L8LxAVGmK11Zp532XcE=;
        b=QkluY7hWLXhXRmNcwgEyEHJ2n4aFx2/hU/r6drOX5kcGVBLOZgcD6nXtuY3ZGIH3fL
         lTIhFRHRgS0aZGR/fD3ApZA7bU3XZ5M0Rn7w5zb9iTE8TEItriSYcaKa1XoNZxtHfvgJ
         dNTcZO9evD3DnrloClMYDkD8Q9P3j9rGIqWr3Fz6mfEH3HvE39lMmD1EUJXR5WGM9VRY
         31+JPpTzTobhm+snYoz34Hytek6Z39BgtXvyiFE+oUisuPCEuKJ/scsx3ofj9tZaPziB
         8aiPXlMwU/fkmoI8rzmMsjFIJ0CO0gNfHDiKjnI4tpuBxkfZfqBU63bKaRdCOsQVjSvL
         bW8A==
X-Gm-Message-State: AOJu0YwatSqN+u6ijVesyKl9CXdEInsGhdZ1jaS3swPYImuGZAdMNz5u
	Qy0TvSY9/jukh79RnMPWpmoPnl7ak/eaQaUgT+WJErUmQw+wsRyq3F0RWNIMFg==
X-Gm-Gg: AY/fxX4RI7vFLBQ8SG1iINQxvrlC3Xfwf4HDl6iPA6nbweEPDPiJnaeil6qvSCGcvlQ
	74jIc/9WMyX7+CtO26pf7vHqktx2s/IibmY+qyFldXbVbrgbsc8VBpejNPVLJ+OX9XBFG+ym5CW
	iQi4JeF41shVqG7fdRhLFbP6iK8fnK5qN4IZwPwVF67Z3fwcSyMzAl+mD+ISyUGnMz7/za8LYoG
	tRXiC6lYl+UbQt7o84I/uAw4Poy/XHFQLLFXxpaOuVztphFkbKNKbAsw1R/zuOoIaSQ9hK4eJIR
	xAeto883bR9OE+cEiY/BApwELkMna2iPDQYibHqFHogK8LSdueIQPezdEkEvVtpqbBaZ0t4pwAi
	Y0qWKhxNwK6rMgD4rqOcc0VXfaiQt9ues1HKpOK580/6ZJscepOiMguN1fCXh1Z6YMrzhnInMrn
	Pz06zYae6BsTJp
X-Google-Smtp-Source: AGHT+IHTnSl39y765nB3CZnDDiAvAfAUdmmmAeQF3GchCF9tvq/YCLiOl+DVWDtIsHDJFd9D+qGbQA==
X-Received: by 2002:a05:6808:c117:b0:450:976c:490d with SMTP id 5614622812f47-457b223fe3bmr13660914b6e.52.1766850017274;
        Sat, 27 Dec 2025 07:40:17 -0800 (PST)
Received: from [127.0.0.1] ([52.173.162.33])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457b3f1761csm12118012b6e.22.2025.12.27.07.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 07:40:15 -0800 (PST)
Message-Id: <pull.2144.git.git.1766850014289.gitgitgadget@gmail.com>
From: "Troels Thomsen via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Dec 2025 15:40:14 +0000
Subject: [PATCH] receive-pack: fix crash on out-of-namespace symref
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
Cc: Troels Thomsen <troels@thomsen.io>,
    Troels Thomsen <troels@thomsen.io>

From: Troels Thomsen <troels@thomsen.io>

`check_aliased_update_internal()` detects when a symbolic ref and its
target are being updated in the same push. It does this by building a
list of ref names without the optional namespace prefix. When a symbolic
ref within a namespace points to a ref outside the namespace,
`strip_namespace()` returns NULL which leads to a segfault.

A NULL check preventing this particular issue was repurposed in
ded8393610. Rather than reintroducing it, we can instead build a list of
fully qualified ref names. This prevents the crash, preserves the
consistency check from da3efdb17b, and allows updates to all symbolic
refs.

Signed-off-by: Troels Thomsen <troels@thomsen.io>
---
    receive-pack: fix crash on out-of-namespace symref

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2144%2Ftt%2Ffix-crash-on-out-of-namespace-symref-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2144/tt/fix-crash-on-out-of-namespace-symref-v1
Pull-Request: https://github.com/git/git/pull/2144

 builtin/receive-pack.c           |  9 ++++++---
 t/t5509-fetch-push-namespaces.sh | 13 +++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9c49174616..a9e0568e94 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1685,7 +1685,6 @@ static void check_aliased_update_internal(struct command *cmd,
 		cmd->error_string = "broken symref";
 		return;
 	}
-	dst_name = strip_namespace(dst_name);
 
 	if (!(item = string_list_lookup(list, dst_name)))
 		return;
@@ -1730,10 +1729,13 @@ static void check_aliased_updates(struct command *commands)
 {
 	struct command *cmd;
 	struct string_list ref_list = STRING_LIST_INIT_NODUP;
+	struct strbuf ref_name = STRBUF_INIT;
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		struct string_list_item *item =
-			string_list_append(&ref_list, cmd->ref_name);
+		struct string_list_item *item;
+		strbuf_reset(&ref_name);
+		strbuf_addf(&ref_name, "%s%s", get_git_namespace(), cmd->ref_name);
+		item = string_list_append(&ref_list, ref_name.buf);
 		item->util = (void *)cmd;
 	}
 	string_list_sort(&ref_list);
@@ -1743,6 +1745,7 @@ static void check_aliased_updates(struct command *commands)
 			check_aliased_update(cmd, &ref_list);
 	}
 
+	strbuf_release(&ref_name);
 	string_list_clear(&ref_list, 0);
 }
 
diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index 095df1a753..3c333ccc5f 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -175,4 +175,17 @@ test_expect_success 'denyCurrentBranch and unborn branch with ref namespace' '
 	)
 '
 
+test_expect_success 'pushing to symref pointing outside the namespace' '
+	(
+		cd pushee &&
+		git symbolic-ref refs/namespaces/namespace/refs/heads/main refs/heads/main &&
+		cd ../original &&
+		git push pushee-namespaced main &&
+		git ls-remote pushee-unnamespaced refs/heads/main >actual &&
+		printf "$commit1\trefs/heads/main\n" >expected &&
+		printf "$commit1\trefs/namespaces/namespace/refs/heads/main\n" >>expected &&
+		test_cmp expected actual
+	)
+'
+
 test_done

base-commit: 66ce5f8e8872f0183bb137911c52b07f1f242d13
-- 
gitgitgadget
