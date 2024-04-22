Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D29181B8F
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826462; cv=none; b=OkGq8XT9aAdU2jU2POPtbsj9wT+MCAnx11hrXejyJ+Wm6yh8CHpRaP8Xwf/PdLUFKk59TUo6cNmgcIk5P56RM85Pp74fdawiv0RhdUT3v22w+xL5rH4vgUTV1j6/5dbZ17LlmaJ8ZlIywye/trG1u001MpAM9zuwT92mKB5sEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826462; c=relaxed/simple;
	bh=MAu//HjzaPe2qU7i9dk8VBsvZ9ntU7VIspVpx4Dns50=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=e2J6iUUqCU52IWKBAxzf0vcwA3aS3HqNGVO3lZSiT+ZSjq1F8sqX/8g8o5jv1M+9aA3Z0Yf1C1pVg6SeoZapNw7r83O6KdnSn7RCrIOfwn8EDUHqdzR4iwSC1AvhWc6PXzvuo88d//1bzHAEs7N9YgztrQKjo3prX+bPBvCHiBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI51kRJq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI51kRJq"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41aa45251eeso4094725e9.3
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 15:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713826459; x=1714431259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7KYnuqjfJDqxYkVUF46VHuP2feo9kqLIDVoIS3nW7S0=;
        b=GI51kRJqSmfkqQvllXeAKmfczdAS4NT9T+0JZrjFmrS+V4fuQABxh7zF7fTxpj8gxd
         pMOCvX3Bx5u7XbBNo26Q7BHpvKK4Ybuq70wPj1zvs6/MiXCwZR1i9mWDyeobV497jiI6
         jUPZtvgfyzg4de3uTwVihtk2U8NhkAiNDkzlt6R2110HHO/kI5hMPKLbnpoQzA+VDgwK
         fuIGTyMjdS5EEWKV2euCj6IIjKfRYRG1ObojEaDkJXZSWr8Mdc+B6LZpHAaW3AjUcMyr
         RVADzfC5GkuycTX63Z3VwjZw3ix8hMH2LvnxRvn/jtq0BJPLzPjWynP/l835WzkX3aCm
         o4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826459; x=1714431259;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KYnuqjfJDqxYkVUF46VHuP2feo9kqLIDVoIS3nW7S0=;
        b=lZ4jn/jIALRV7Ztlhie2H0DhTD79wI5izFzDZYQD093BtJv7CpPTe3Q9Iq/hm/t1hM
         5o4P07rCscEns8oIZ7C1i1c5U+CQ+qjj0pKfnvhp0sdH3isgB3+ZaYFfy/+uo1FAkGrg
         IZNUJWgd62EnScX0BpMkvrkOkcSPkoXXmp6+TfRT22lAQbPFvroUVbr37o5JkHOn/kZx
         j0zsv9sSXhV1BDuks3d6SCKVXFlUQGBKVPB/Uvvzfgm/BKejI04fPFIZEqnP5xAQhuXm
         LSVbanhaQJl0cbautotiR02yUAs+7IUPSULrhusV/buim3/mu0Uu5djPlCe89LS+eqpW
         YVqQ==
X-Gm-Message-State: AOJu0YyKuR7XxOjd4PLvT5+1IRbTbVKqH3V3UJWFZG4ldPqdjQ+z4DVe
	gyl6ydvz8iWSAhgnWvr7L8Sew86OPqJUIMlPMcRduQJoAY5uaNPRUwMtWQ==
X-Google-Smtp-Source: AGHT+IGlIB/+wnXeMTfCi6H6HVYryjcMsyuBmmLBp6ugG3zatxTCOU7pUzFjhn/ByY3p3t4VNmqoiw==
X-Received: by 2002:a05:6000:e4c:b0:34a:3680:172 with SMTP id dy12-20020a0560000e4c00b0034a36800172mr6521242wrb.16.1713826459184;
        Mon, 22 Apr 2024 15:54:19 -0700 (PDT)
Received: from gmail.com (247.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.247])
        by smtp.gmail.com with ESMTPSA id y5-20020adfe6c5000000b003436cb45f7esm13016752wrm.90.2024.04.22.15.54.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 15:54:18 -0700 (PDT)
Message-ID: <f20291e7-fc2b-4ce4-a471-84cf76988f6e@gmail.com>
Date: Tue, 23 Apr 2024 00:54:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 4/4] add: plug a leak on interactive_add
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
 <69f86760-96ff-4c62-9649-4627652b7c19@gmail.com>
In-Reply-To: <69f86760-96ff-4c62-9649-4627652b7c19@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Plug a leak we have since 5a76aff1a6 (add: convert to use
parse_pathspec, 2013-07-14).

This leak can be triggered with:
    $ git add -p anything

Fixing this leak allows us to mark as leak-free the following tests:

    + t3701-add-interactive.sh
    + t7514-commit-patch.sh

Mark them with "TEST_PASSES_SANITIZE_LEAK=true" to notice and fix
promply any new leak that may be introduced and triggered by them in the
future.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/add.c              | 9 ++++++---
 t/t3701-add-interactive.sh | 1 +
 t/t7514-commit-patch.sh    | 2 ++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ae723bc85e..b7d3ff1e28 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -150,7 +150,7 @@ static int refresh(int verbose, const struct pathspec *pathspec)
 int interactive_add(const char **argv, const char *prefix, int patch)
 {
 	struct pathspec pathspec;
-	int unused;
+	int unused, ret;
 
 	if (!git_config_get_bool("add.interactive.usebuiltin", &unused))
 		warning(_("the add.interactive.useBuiltin setting has been removed!\n"
@@ -163,9 +163,12 @@ int interactive_add(const char **argv, const char *prefix, int patch)
 		       prefix, argv);
 
 	if (patch)
-		return !!run_add_p(the_repository, ADD_P_ADD, NULL, &pathspec);
+		ret = !!run_add_p(the_repository, ADD_P_ADD, NULL, &pathspec);
 	else
-		return !!run_add_i(the_repository, &pathspec);
+		ret = !!run_add_i(the_repository, &pathspec);
+
+	clear_pathspec(&pathspec);
+	return ret;
 }
 
 static int edit_patch(int argc, const char **argv, const char *prefix)
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index bc55255b0a..04d8333373 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -4,6 +4,7 @@ test_description='add -i basic tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t7514-commit-patch.sh b/t/t7514-commit-patch.sh
index b4de10a5dd..03ba0c0e73 100755
--- a/t/t7514-commit-patch.sh
+++ b/t/t7514-commit-patch.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='hunk edit with "commit -p -m"'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup (initial)' '
-- 
2.45.0.rc0.4.gfff7e48949
