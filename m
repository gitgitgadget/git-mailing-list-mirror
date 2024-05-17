Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D01411C6
	for <git@vger.kernel.org>; Fri, 17 May 2024 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715987764; cv=none; b=ExAIVweGd2nO9UJmynGqAS65100ARuZQXMXrE8RJA/dCanuVv+JHbz71oUFEXgH4MslcI27IqZkR44Kbd08sf7RTXjr+CPvrQEcvAg0cOHjNE7jihUTLLyDQDafIlqAOCRuZBunoO3oDuQZ0VAdCxawdfat/5StA4cDro0J5his=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715987764; c=relaxed/simple;
	bh=NACUjCKOyFbBT9Jcvg+gdcvRvWOxx7KfWVnfiD/FlN4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XMiUcHkyukU1dylgKPhZvURtm/6jGJLGIwpLDAnYIJESzypR8c7gmfv55oihj5i1vKn8oBrgrQQt7Qd+MgEFUBXj5QharPIy7Qkm5gUkmCfSnR2WfbpBx98yWUi0D1JL9MVoSc1uIm0yg0Coq8TxnU/5axkYhGp7uX2KGlaTosc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHPaRNkW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHPaRNkW"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34db6a299b8so510703f8f.3
        for <git@vger.kernel.org>; Fri, 17 May 2024 16:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715987761; x=1716592561; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6d3NikhGkK867apaAyTM/p8Uvw8q8n1MJ0T9cVpYng=;
        b=WHPaRNkW9RXW+twLGJg/sgUhks9ocQ2oZQ+0g5YvNrDXmlfkBwk1wUGOkUIVZXca1F
         E+00oUPfZJXV2POc6FFH5jowe06uqwq+BJ3sK3y+o9P+O6DmZXgd8VPfSdrApAc53BRK
         4wBqHHh0IHSmHv5fpfbIa3LoG6jmPoHQKK506E1FAanpHhcSpQkM84MELvHcZgCYKfDt
         HhikwPq6liBelK/fapvzpExd3ddJtMPeSB6B1qwWefoOpdvwXaqKICRSA+UXxvifGsSa
         CwzJqJ+7H+TNY0x/y2+PaInzJyBOO3go+VUkgp5mRUbKUobrGZiMinb5xpYhRaGRQ5sb
         uKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715987761; x=1716592561;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6d3NikhGkK867apaAyTM/p8Uvw8q8n1MJ0T9cVpYng=;
        b=g8Va3EeOSdWzyTCZzs/QaiOrw8UR5+zyPf+IwmkD/oRSs8qPI8GLp3pYfgVyFY9GxY
         D/ZydlczxAcr5J3MwoCEVF3/39BpGers+OpUGZ/gzjFoRKUBmTcOxS5faSEqrSswcIRN
         LEcVzJkSm6W9GYQCcPkmNEkAWwaoOTygtSQQ8/GdvKx8Zz/LGRE5n3ZAzw8HShr2uZZT
         joKkxDvZkoLql0nR7JrfxklIIx3ZC6/BGYtO5OW7aDpVacOHH5Sk+zhauo81YlVKBY3T
         Hs9HcHwFGVNQDFHxOpSGQj4qUsb+zMzYIBTf9tix5muB8a7xCkcWOLf4Y0/O9EzeHXhI
         DO4w==
X-Gm-Message-State: AOJu0YzFxJil95NHb7BOO2aOBH/q8z1uM78F2IWR40y96cP95Iu6Aywy
	WGfhuTyx4/YnJZdAgKueKWCt4/1XglwdIL5cQZALU1JyORKSJsJat7Vg8w==
X-Google-Smtp-Source: AGHT+IGeRCm13beF3yUS8rBe7/WpVutucYrcAoRsP2dbaHLt+wauo8KEVwbWWq7PyBYqVU24GcdXbg==
X-Received: by 2002:a05:6000:12d0:b0:34d:b5b7:6189 with SMTP id ffacd0b85a97d-3504a96ce11mr15165040f8f.58.1715987761379;
        Fri, 17 May 2024 16:16:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacef2sm22758391f8f.85.2024.05.17.16.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 16:16:00 -0700 (PDT)
Message-Id: <57db89a14977bdff01f8f82cb4d6f85cc49d4b55.1715987756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 May 2024 23:15:51 +0000
Subject: [PATCH 3/8] Revert "core.hooksPath: add some protection while
 cloning"
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This defense-in-depth was intended to protect the clone operation
against future escalations where bugs in `git clone` would allow
attackers to write arbitrary files in the `.git/` directory would allow
for Remote Code Execution attacks via maliciously-placed hooks.

However, it turns out that the `core.hooksPath` protection has
unintentional side effects so severe that they do not justify the
benefit of the protections. For example, it has been reported in
https://lore.kernel.org/git/FAFA34CB-9732-4A0A-87FB-BDB272E6AEE8@alchemists.io/
that the following invocation, which is intended to make `git clone`
safer, is itself broken by that protective measure:

	git clone --config core.hooksPath=/dev/null <url>

Since it turns out that the benefit does not justify the cost, let's revert
20f3588efc6 (core.hooksPath: add some protection while cloning,
2024-03-30).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c        | 13 +------------
 t/t1800-hook.sh | 15 ---------------
 2 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/config.c b/config.c
index 85b37f2ee09..8c1c4071f0d 100644
--- a/config.c
+++ b/config.c
@@ -1525,19 +1525,8 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "core.attributesfile"))
 		return git_config_pathname(&git_attributes_file, var, value);
 
-	if (!strcmp(var, "core.hookspath")) {
-		if (current_config_scope() == CONFIG_SCOPE_LOCAL &&
-		    git_env_bool("GIT_CLONE_PROTECTION_ACTIVE", 0))
-			die(_("active `core.hooksPath` found in the local "
-			      "repository config:\n\t%s\nFor security "
-			      "reasons, this is disallowed by default.\nIf "
-			      "this is intentional and the hook should "
-			      "actually be run, please\nrun the command "
-			      "again with "
-			      "`GIT_CLONE_PROTECTION_ACTIVE=false`"),
-			    value);
+	if (!strcmp(var, "core.hookspath"))
 		return git_config_pathname(&git_hooks_path, var, value);
-	}
 
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg = git_config_bool(var, value);
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 7ee12e6f48a..2ef3579fa7c 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -177,19 +177,4 @@ test_expect_success 'git hook run a hook with a bad shebang' '
 	test_cmp expect actual
 '
 
-test_expect_success 'clone protections' '
-	test_config core.hooksPath "$(pwd)/my-hooks" &&
-	mkdir -p my-hooks &&
-	write_script my-hooks/test-hook <<-\EOF &&
-	echo Hook ran $1
-	EOF
-
-	git hook run test-hook 2>err &&
-	grep "Hook ran" err &&
-	test_must_fail env GIT_CLONE_PROTECTION_ACTIVE=true \
-		git hook run test-hook 2>err &&
-	grep "active .core.hooksPath" err &&
-	! grep "Hook ran" err
-'
-
 test_done
-- 
gitgitgadget

