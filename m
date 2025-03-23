Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEDA14012
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742743776; cv=none; b=sRuLCW8FhT+fp/tJy60Mnhbhra3XCWiOEMxamngYnD4ncPHApik0c3qUAm+QLcfEZMZnuHQX/fBuFA47htWQr1hzkQSIOrJFnKE5lB+jkdlwhsKjeuierCxgxlaLhH2eNEBYe4aspxP9gdsDYopvy6uRZlbH0gZVam/avnmKikc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742743776; c=relaxed/simple;
	bh=3XHRyTca49+4utzUcA+OpaxPMp5rVAtUtKKlPtRTfVw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DNO1dha4hTe4t5g6I5SJP3EpQz9XXhr6BJvcvLVINC9u6oqNACjbT6z4vXZoHnnFaYxahtHFfy6cmEJc4ebFtLHpNUYpv91TKHYm162G5VtFq4rm/ktEamzKIqK5P+WK6T4UaSZXQVAXD0r/Xr1+hiIWV276KVcHA00Mkk0vLXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4COqBXh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4COqBXh"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so32754405e9.1
        for <git@vger.kernel.org>; Sun, 23 Mar 2025 08:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742743773; x=1743348573; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlDwTVMY6SZcKSN4UG7s04O34HY+gbQaF4B7+e+C8QM=;
        b=l4COqBXhlhGCbP9fa+YtT9N0uevZWs28F5k15R3B6D7cvHUzkcvwrI4Wyk/3zQqRAK
         MSfBQU0HM2ahL4e3RCZqHMUo2K8Wr5zaxg+Aowp3UsFVUREUWhCxBgGWtglcJCo2RgaK
         2Yp8rTKmAGIpV1gAoNC18lSRPEk9QuJfPdwJ2zlj21RnDZelTGTUiJOBpPuFjipnzELz
         WbnSKjsyM8mHqSK1+siq8Qg2OO1I0r8D4VDzNNi31giYcA5hvdOoEDHedtKiEEM2EaNV
         RXxHyIe87Fhy8MrjtazorjfquEHgss5NsOZFDGxbLB2tZa/P6VdDl6cuPd21ETiTn07o
         r0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742743773; x=1743348573;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlDwTVMY6SZcKSN4UG7s04O34HY+gbQaF4B7+e+C8QM=;
        b=iREsscmAQxfe7cbwgLuhMddiMIFZVCDf8SN4qqra6POh0WXEELTVhE49h2IyewKeo9
         kJSJPmRSki/bTTPfzS1JBfEOUb9p6PyYLc9tedZ8oo/iKGsAjRqGG7tPLqn/sjRTovUp
         CzsjzNd1EjubIUjfZ3gFQQlL0XMp5t3YCT5Sfpd3NXTJekbH1jPB6s2nTSN0oRZ99xO8
         cEmoxOiE4sOl/tk7HpmCtzInIyhD1CmYUNjaqXsgHE7d/cNa2pA+h/JAOoymrkbxrm4c
         cOeid3OGy2NNzX9XOd8QYA5NyG8+/pQb2kBLwUcwGf7cegJ1U/LYwQ7idWql3htUzqUT
         tXhw==
X-Gm-Message-State: AOJu0YwvUqk/ZGg7kZknAsS9QKC1OC4J39ozdEcpkyVbUKUSBI6Y2z8V
	ka8Cva70gYyp/ieG2bpCgHMmkQLFgrc+HcG/qY//27x08j8Wp4yx8gPSiQ==
X-Gm-Gg: ASbGncv7DeHZatBcGHt+e8kQ22b+OWemXOZXEvhx9IWMyCugbwPytZPLPhwRr7vRvBy
	GUnvbux6HKLWVz9Jb2GBYbI1s/3dMMgjDT5T5yFpiOTIdZutSUVxUMXCFS0DZru10zZCw5LbdN1
	5UDKa26uYWoMXeE2thJuojB7dlMyPz+GwAIr1a+KHZFiUiEMsFPl2pvNAnqr5a8rzHZijjySBJv
	dRMsPCEnuOJlXNXzmi+Nw8mBEHo6fGvOub73apfxl6sTXz2B43iSZ3YZmYO+7kqSL9xTINUI+9G
	Krozxu+GmuNg3XmwQcOvgYzyeLwT79i0OrflBiW/2JNWipcWdlU9ORhq
X-Google-Smtp-Source: AGHT+IHYvVwS2qmuF6F+5gejQv8K9P9ZXUbmDm+DXbvs7vReLCIA4XPA9DSJa2L7wdcFtXM3ZJZfpw==
X-Received: by 2002:a05:600c:4584:b0:43c:efed:733e with SMTP id 5b1f17b1804b1-43d509f58b4mr85623925e9.14.1742743772564;
        Sun, 23 Mar 2025 08:29:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6676sm8113304f8f.62.2025.03.23.08.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 08:29:32 -0700 (PDT)
Message-Id: <pull.1930.v3.git.git.1742743771108.gitgitgadget@gmail.com>
In-Reply-To: <pull.1930.v2.git.git.1742688740650.gitgitgadget@gmail.com>
References: <pull.1930.v2.git.git.1742688740650.gitgitgadget@gmail.com>
From: "Ayman Bagabas via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 23 Mar 2025 15:29:30 +0000
Subject: [PATCH v3] shell: allow overriding built-in commands
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
Cc: Elijah Newren <newren@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ayman Bagabas <ayman.bagabas@gmail.com>,
    Ayman Bagabas <ayman.bagabas@gmail.com>

From: Ayman Bagabas <ayman.bagabas@gmail.com>

This patch allows overriding the shell built-in commands by placing a
script with the same name under git-shell-commands directory.

This is useful for users who want to extend the shell built-in commands
without replacing the original command binary. For instance, a user
wanting to allow only a subset of users to run the git-receive-pack can
override the command with a script that checks the user and calls the
original command if the user is allowed.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
    shell: allow overriding built-in commands

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1930%2Faymanbagabas%2Fshell-override-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1930/aymanbagabas/shell-override-v3
Pull-Request: https://github.com/git/git/pull/1930

Range-diff vs v2:

 1:  60c6339e790 ! 1:  7e6996d199e shell: allow overriding built-in commands
     @@ shell.c: int cmd_main(int argc, const char **argv)
       		}
      +		/* Allow overriding built-in commands */
      +		full_cmd = make_cmd(cmd->name);
     -+		if (!access(full_cmd, F_OK)) {
     ++		if (!access(full_cmd, X_OK)) {
      +			const char *argv[3] = { cmd->name, arg, NULL };
      +			return execv(full_cmd, (char *const *) argv);
      +		}


 shell.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/shell.c b/shell.c
index 76333c80686..8c7f4388bd5 100644
--- a/shell.c
+++ b/shell.c
@@ -194,9 +194,11 @@ int cmd_main(int argc, const char **argv)
 		/* Accept "git foo" as if the caller said "git-foo". */
 		prog[3] = '-';
 
+	cd_to_homedir();
 	for (cmd = cmd_list ; cmd->name ; cmd++) {
 		int len = strlen(cmd->name);
 		char *arg;
+		char *full_cmd;
 		if (strncmp(cmd->name, prog, len))
 			continue;
 		arg = NULL;
@@ -210,10 +212,15 @@ int cmd_main(int argc, const char **argv)
 		default:
 			continue;
 		}
+		/* Allow overriding built-in commands */
+		full_cmd = make_cmd(cmd->name);
+		if (!access(full_cmd, X_OK)) {
+			const char *argv[3] = { cmd->name, arg, NULL };
+			return execv(full_cmd, (char *const *) argv);
+		}
 		return cmd->exec(cmd->name, arg);
 	}
 
-	cd_to_homedir();
 	count = split_cmdline(prog, &user_argv);
 	if (count >= 0) {
 		if (is_valid_cmd_name(user_argv[0])) {

base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
gitgitgadget
