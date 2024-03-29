Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E983AC10
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 04:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685962; cv=none; b=PBidC6jihEZ2P7nkWpsBkKEh8sBsUJbC5dqeQhXSrYQhn6x9Phd4tFDUEKrIIPz8netbgIKOTosFTOKAylhx3AOuB73T1Gdl/SREN8Yg5QejbhKRePoZhlRZSLr2EeQ1sS0iqQaYNXdHcdfVy9X9xoAjBbOfE5L/klpIGYIbzh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685962; c=relaxed/simple;
	bh=6GamySPjUr+iSRaNgKiOoRbW1DOlZxHuO6/dXyYks4c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BQihnQLkwBsOd8i//4IfJPbWNvl3eQIBe312/PB9P6Ga60Z9NZLo0eblQa/v2BwpebU30k7Ufn9JXb4i5GPylhNkk9IWy4sfUtgNlnCgbYUHz19WYJ+SXtnUUnQsGNihajnohcPfFrasbWUBT2b90GgjpIcQwPBhSabUR6gvALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeDm8F+H; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeDm8F+H"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-415482307b0so9696815e9.0
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 21:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711685959; x=1712290759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0wgMbDllIpwJOBR0QxHNF9Ov4355KSb/bYp3J7Y8wQE=;
        b=UeDm8F+HBmrrHgv6Ui59VmR7z7iv+Rihyf/4OZLAdfLJvR7jIVE3Sl/1T9waFjBXO7
         fj0Re41HBRNbS9K3Rrj3Z0NwrDgEfSio1hxRxu94/l6U/wWe9RQsoo/Uv0rXybzpRJE+
         6N8YyLAolgl4YyECw+qHjQ1I6P6kQAWl9NS2B9+gaFA0oL7FR4A2q++YSsgpp82s2DMs
         D2S5DHsR+wVHgKs6S1DdeIjATULflR33phtRNWWLiiPe1EPE56hPQZYxCIC+ARK9ROO3
         wliV0I15g9oaW1TFMDq1cH5GRBh3qigtfsTG2F7ZsjGz7Z0Qtf/y+oBE8aeYiic3phO4
         YAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685959; x=1712290759;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wgMbDllIpwJOBR0QxHNF9Ov4355KSb/bYp3J7Y8wQE=;
        b=EXpGOw0Hqh2hSuIrynAgMceBTBwaFbE/OWHoGSvVJpKO+PgK6WRZR2awE4elrmY/gn
         igzhCWrpc7vWaWlIjIhQdnqURR+5z7dUB+jqXNentTidtZLAatdMjZiK0Lqr9ttHI9Fo
         02vihzs1vjyjnPlzUqJK5HkYQLjs3apLzyr3VCUGDS53m6RlElyvzczf4oGoYGzoNXMG
         kI789COoMjnfXAAXGlcBx85SBtgK59x84VRp2pl4HVD1/Qy094glajglMaBKLKJ7Wx6w
         zrvON+lDkAcuEQ9UKrWqbt6EQkNl70aTYocag5MrTk7Y9xDHuvkXmvXzQ5+cbJs9hCQb
         HORg==
X-Gm-Message-State: AOJu0YxrQ4eX1/jiVNGsRT302ZwNr6gZJzV9T5olLNOv7NJtW/BF6yHg
	Cn1goVUMHZIGH+V5kiTlWlR+QXfcivrKJ6pRIozNwZUwhhurRSUKVpzXsbOk
X-Google-Smtp-Source: AGHT+IGmO7q7EyCZ2+0oVXyWZ7pN5lATFpH34m+3hjnMb7vIcWsCF6dDtrdwDgTjcB+9fcchUANB5A==
X-Received: by 2002:a05:600c:4688:b0:413:f1c5:4b1b with SMTP id p8-20020a05600c468800b00413f1c54b1bmr1017568wmo.33.1711685958813;
        Thu, 28 Mar 2024 21:19:18 -0700 (PDT)
Received: from gmail.com (220.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.220])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600c510a00b004148a5e3188sm7288005wms.25.2024.03.28.21.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 21:19:18 -0700 (PDT)
Message-ID: <37f79186-b849-496a-ae91-f5e05a280dae@gmail.com>
Date: Fri, 29 Mar 2024 05:19:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/3] add: use advise_if_enabled for ADVICE_ADD_IGNORED_FILE
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
References: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
Content-Language: en-US
In-Reply-To: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the newer advise_if_enabled() machinery to show the advice.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/add.c              | 6 ++----
 t/t3700-add.sh             | 3 +--
 t/t7400-submodule-basic.sh | 3 +--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 393c10cbcf..8f148987f7 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -328,10 +328,8 @@ static int add_files(struct dir_struct *dir, int flags)
 		fprintf(stderr, _(ignore_error));
 		for (i = 0; i < dir->ignored_nr; i++)
 			fprintf(stderr, "%s\n", dir->ignored[i]->name);
-		if (advice_enabled(ADVICE_ADD_IGNORED_FILE))
-			advise(_("Use -f if you really want to add them.\n"
-				"Turn this message off by running\n"
-				"\"git config advice.addIgnoredFile false\""));
+		advise_if_enabled(ADVICE_ADD_IGNORED_FILE,
+				  _("Use -f if you really want to add them."));
 		exit_status = 1;
 	}
 
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index f23d39f0d5..76c2c9e7b0 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -370,8 +370,7 @@ cat >expect.err <<\EOF
 The following paths are ignored by one of your .gitignore files:
 ignored-file
 hint: Use -f if you really want to add them.
-hint: Turn this message off by running
-hint: "git config advice.addIgnoredFile false"
+hint: Disable this message with "git config advice.addIgnoredFile false"
 EOF
 cat >expect.out <<\EOF
 add 'track-this'
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 00c1f1aab1..5c4a89df5c 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -212,8 +212,7 @@ test_expect_success 'submodule add to .gitignored path fails' '
 		The following paths are ignored by one of your .gitignore files:
 		submod
 		hint: Use -f if you really want to add them.
-		hint: Turn this message off by running
-		hint: "git config advice.addIgnoredFile false"
+		hint: Disable this message with "git config advice.addIgnoredFile false"
 		EOF
 		# Does not use test_commit due to the ignore
 		echo "*" > .gitignore &&
-- 
2.44.0.371.gf9813d4ed5
