Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B039AD5
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6HUIIov"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e43e489e4so32180725e9.1
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 07:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704814219; x=1705419019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ni2J1M9hC6jz+U0GSHk4fPv7xsSribPCM2g9vFdIb1Y=;
        b=O6HUIIovEe3DyvX8BkGyWK2cV7OPEWj+cf/+MtEjzn5m/hGfOV8D+oeFaJvwA3jVXQ
         3PGNo6YGWzS57gvqHxzsRTuezs+x0Jf1WFkNQnr1mLH+C99uwr8HhjerWFofREvEk2Le
         YCpHYpihfcNYRacIP3slLE6P6ChOGzwdVp5XqMF198F1HsNjRJ/7W8OAF8ULZYoZkAMQ
         1TCwTdaZWSEAHT51lEebmNVNK2Ez20XYDVJYBZZYkFoEJqdg+0jWJo73HxGApHgc2cFJ
         tzC4VMcFYcJdwO07lqYq/gzmBvT+bKqfgsydv4k2DIrNtqpv6NyV/8+18qEFvYZ2MOPX
         0U9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704814219; x=1705419019;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ni2J1M9hC6jz+U0GSHk4fPv7xsSribPCM2g9vFdIb1Y=;
        b=OIQekNg1RZTk4v9qa7s3GDTqrm+zXXDOA2WjbZmIQYEx+GGTigeQmWMl+DBiuOfIR6
         vEG9wxCGOFLjDHfLbLS9ZxZKdREukYT0usU6fK7TxctCLX94Vyn/4a5XNcHLlcY1HOjk
         SrwiIiMD1gyTnm4fj7EtdPm6U8yBkYSiWTx9J59AEapu/0ojtI8gATaocvzUr0/BI2OB
         RBmj4RKIJautpBMUSbaB3Z524HPlN3vwd9mNozVDpjMtB2+Fr7KRUSK2sKN1XqWpOuV8
         foeSrmqkY/eo5qXCVQgdTGi4p5xBGLzjL5t/XDe9Zp5eSGLbMeYSuOFaifvCr4oVKoNS
         yh8w==
X-Gm-Message-State: AOJu0Ywa3LpzrTW7znnprpbNe/OZvSdTKNjuaxyb1rHC8CPrNbBQHxlB
	9tNnC60x+bve/H3oshJuQ4H72d8rTlU=
X-Google-Smtp-Source: AGHT+IFOx7TzjTLN01mUhb80GLQrO6NsjA54O/HHSHIjey4+jum1Q7XK2aatcWMfM3vErgfJgv0dnw==
X-Received: by 2002:a05:600c:1c20:b0:40e:53f8:5242 with SMTP id j32-20020a05600c1c2000b0040e53f85242mr45043wms.72.1704814219242;
        Tue, 09 Jan 2024 07:30:19 -0800 (PST)
Received: from gmail.com (228.red-88-13-173.dynamicip.rima-tde.net. [88.13.173.228])
        by smtp.gmail.com with ESMTPSA id i11-20020a05600c354b00b0040e47dc2e8fsm4025906wmq.6.2024.01.09.07.30.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 07:30:18 -0800 (PST)
Message-ID: <d6099d78-43c6-4709-9121-11f84228cf91@gmail.com>
Date: Tue, 9 Jan 2024 16:30:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/3] advice: allow disabling the automatic hint in
 advise_if_enabled()
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
In-Reply-To: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Using advise_if_enabled() to display an advice will automatically
include instructions on how to disable the advice, along with the
main advice:

	hint: use --reapply-cherry-picks to include skipped commits
	hint: Disable this message with "git config advice.skippedCherryPicks false"

This can become distracting or noisy over time, while the user may
still want to receive the main advice.

Let's have a switch to allow disabling this automatic advice.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 advice.c          | 3 ++-
 advice.h          | 3 ++-
 t/t0018-advice.sh | 8 ++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/advice.c b/advice.c
index 50c79443ba..fa203f8806 100644
--- a/advice.c
+++ b/advice.c
@@ -79,6 +79,7 @@ static struct {
 	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath", 1 },
 	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
 	[ADVICE_WORKTREE_ADD_ORPHAN]			= { "worktreeAddOrphan", 1 },
+	[ADVICE_ADVICE_OFF]				= { "adviceOff", 1 },
 };
 
 static const char turn_off_instructions[] =
@@ -93,7 +94,7 @@ static void vadvise(const char *advice, int display_instructions,
 
 	strbuf_vaddf(&buf, advice, params);
 
-	if (display_instructions)
+	if (display_instructions && advice_enabled(ADVICE_ADVICE_OFF))
 		strbuf_addf(&buf, turn_off_instructions, key);
 
 	for (cp = buf.buf; *cp; cp = np) {
diff --git a/advice.h b/advice.h
index 2affbe1426..1f2eef034e 100644
--- a/advice.h
+++ b/advice.h
@@ -10,7 +10,7 @@ struct string_list;
  * Add the new config variable to Documentation/config/advice.txt.
  * Call advise_if_enabled to print your advice.
  */
- enum advice_type {
+enum advice_type {
 	ADVICE_ADD_EMBEDDED_REPO,
 	ADVICE_ADD_EMPTY_PATHSPEC,
 	ADVICE_ADD_IGNORED_FILE,
@@ -50,6 +50,7 @@ struct string_list;
 	ADVICE_WAITING_FOR_EDITOR,
 	ADVICE_SKIPPED_CHERRY_PICKS,
 	ADVICE_WORKTREE_ADD_ORPHAN,
+	ADVICE_ADVICE_OFF,
 };
 
 int git_default_advice_config(const char *var, const char *value);
diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
index c13057a4ca..0b6a8b4a10 100755
--- a/t/t0018-advice.sh
+++ b/t/t0018-advice.sh
@@ -30,4 +30,12 @@ test_expect_success 'advice should not be printed when config variable is set to
 	test_must_be_empty actual
 '
 
+test_expect_success 'advice without the instructions to disable it' '
+	cat >expect <<-\EOF &&
+	hint: This is a piece of advice
+	EOF
+	test-tool -c advice.adviceOff=0 advise "This is a piece of advice" 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.42.0

