Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0886C1DA4D
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 04:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711685991; cv=none; b=dz57Q+J/v5jpjrPE91eJ431m0Weg+lCtL9QE7oMn9uig9W+7rZTyN3cbXcbH35VxDngFkD60xTBH76iBDFl+hKW8xeEGwf9X0eYYG600v/HRtke5VbzsfM+bj1ly2m7ATmn39Wihbj27qbiAnYxmIm+14JBs9oUykuWOfGDtQk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711685991; c=relaxed/simple;
	bh=ChTVYB+7hTny4UWSikKARhQ6osuH+BDuMhwnCWFG7Ig=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=r/bgE2lGgnyqAvGwjztdULfMEqfEzvzBt2OKKydyyGYdvxbokZ6g094JM2e3yzPHzK0tWE0psfkaKXQdqHWZjTFJ+ECKiE2vXgjDckK7HFq+bxuB8uwvkBcWei+Z5gZQSxpRBPQU/HJAHDQlyLuLZwOJM+uG9FkKCzOzCItajIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1qx7EKK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1qx7EKK"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33eee0258abso960184f8f.3
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 21:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711685988; x=1712290788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WcXaZtmG3p/9nfl3/+JZipgoILStwp80MWlVL4q0YnA=;
        b=S1qx7EKK3thPeyG6meYGjb+cUgLOyWyLt29qWmow/UI5BcC4/UBbmZlr7QLY7+FgdY
         srILr1DFqonzmyazM/u8RMgS7nVTX5QbJxlKkhj8/DQUNO0qSzWfsRxPhpLJhMxXYbjH
         Y7PI0QexvCqixRkfWCnxeXfc0NqLOJGTViYQjiU49P1ArOBVKioRIrm/iav2mfGH7p6m
         9B/d7EUlGnT6XijzE6i1eF63F2m/mVCVeaYPBrVyrYMRtyYyA8vSe7fJWeBDEK6X7i6E
         JJUwwQPg+TJ907C9aOJdvwbBsCg2kcd21aTMY5pJW2WwwgNdVIjeqeEcsoStZN8pVSWT
         r01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711685988; x=1712290788;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WcXaZtmG3p/9nfl3/+JZipgoILStwp80MWlVL4q0YnA=;
        b=RoItSRbqMW0q8OhMku5EMiJ9y8KevfHYrq/q1pJWmf3R7V1dHx3IvTp38CMi8Crr1W
         2C9DH/1KPeQfgA5HyrOXLNNOgqckIGLeETBhEIqsi2AG95I+cAC416h8lYjiHGeP1DPY
         dTMdqFN3rERulI3SsF32ICVh5alO/jSudZJEAXE0ladHFb3tTCTRUp6wD42AUxaSRnrK
         dNXNgn70KNaVgZqBhzbgjlTU8wg0pBocXK8Zzk3QJOeXCuh2op/uJO78mFWjmYiD3CzU
         yZmZi8c3txvTN9dtKFBQXqq5sea/oYR/kMA5wE20BiyMgNNcsrlTkiuyAsmx6yWTG0O6
         kiCA==
X-Gm-Message-State: AOJu0YyPNLCKraV8RV060dAFYwSjagfscMEc50uSKLgOp8rzqX8qZ/XH
	nDVkdVkZbGJJLxCcNP9GVj+QJM+qSfdZjnmHAfxQJBoWPzzQGsGDU0NhdIvk
X-Google-Smtp-Source: AGHT+IGurSFXATAM6f24tiEam/L2BL55vCAHIT8d7dexzL3eSjfocFJvho1jyf35ljZsaM6IluMpuQ==
X-Received: by 2002:adf:f34a:0:b0:33e:c4c3:6f with SMTP id e10-20020adff34a000000b0033ec4c3006fmr504114wrp.64.1711685988250;
        Thu, 28 Mar 2024 21:19:48 -0700 (PDT)
Received: from gmail.com (220.red-88-14-47.dynamicip.rima-tde.net. [88.14.47.220])
        by smtp.gmail.com with ESMTPSA id m11-20020adfa3cb000000b00341cd8e04a0sm3193835wrb.105.2024.03.28.21.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 21:19:48 -0700 (PDT)
Message-ID: <dd1f4753-b82f-47e4-a7f3-0d252579cc36@gmail.com>
Date: Fri, 29 Mar 2024 05:19:29 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/3] add: use advise_if_enabled for ADVICE_ADD_EMPTY_PATHSPEC
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
References: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
Content-Language: en-US
In-Reply-To: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the newer advise_if_enabled() machinery to show the advice.

We don't have a test for this.  Add one.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/add.c  |  6 ++----
 t/t3700-add.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 8f148987f7..289adaaecf 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -438,10 +438,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (require_pathspec && pathspec.nr == 0) {
 		fprintf(stderr, _("Nothing specified, nothing added.\n"));
-		if (advice_enabled(ADVICE_ADD_EMPTY_PATHSPEC))
-			advise( _("Maybe you wanted to say 'git add .'?\n"
-				"Turn this message off by running\n"
-				"\"git config advice.addEmptyPathspec false\""));
+		advise_if_enabled(ADVICE_ADD_EMPTY_PATHSPEC,
+				  _("Maybe you wanted to say 'git add .'?"));
 		return 0;
 	}
 
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 76c2c9e7b0..681081e0d5 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -28,6 +28,16 @@ test_expect_success 'Test of git add' '
 	touch foo && git add foo
 '
 
+test_expect_success 'Test with no pathspecs' '
+	cat >expect <<-EOF &&
+	Nothing specified, nothing added.
+	hint: Maybe you wanted to say ${SQ}git add .${SQ}?
+	hint: Disable this message with "git config advice.addEmptyPathspec false"
+	EOF
+	git add 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'Post-check that foo is in the index' '
 	git ls-files foo | grep foo
 '
-- 
2.44.0.371.gf9813d4ed5
