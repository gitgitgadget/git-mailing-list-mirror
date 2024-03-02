Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88D18657
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709394655; cv=none; b=SMwTmBzpHhmcLIFU7KhPLy2jtoNWCDk1uGEQZAOyI0QYiQaWCoS8u/YpQkAacFD2q8cbeUCQAaebLzz3QgL/Y4qlCCoRqsrSU9Lmf2oAtFgNPQPFBTiLQy6HzzOitel8dmMfJ7QMu5BW9UEx/6NZK6lZgZJ4W8MLPYdq/gt2Gzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709394655; c=relaxed/simple;
	bh=aMmT52VA3qq4tUJY1QcwlXwEw6+Fi0nOqbnLZFfTvSM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=S9OrfXcKz4dW1X7pDXRGVvcVtVjfP+RNvKwzu9fPJklgSfu9B36RKbVO/R9vF8q+u99kz2RfO2lBCqoEkifczsqtt1sPEVNss7cwEtPuwLzMNtuR42BQSmQf+LEa+GsgpA1Bq3BG7+8QNUfVOU16eEswcbZ49ugb2IyR1Ee33mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asTPIDt2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asTPIDt2"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412da818207so2220375e9.1
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 07:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709394652; x=1709999452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uKsMsTglGNrI2tQScoVSN5413wK+rz2J3hThgN9+rw=;
        b=asTPIDt29PbGcebt76e1lVedKf6j/IAwSeaIBuNESbTYoEPUB8g5u1zI1ZGUUoWhSG
         Ypoi8PdC5qW2v+FX+UF9mMu7qXtTbtlQ+QNQHqaQROLJsMSR7p6Cmbo50ZJnGfCug7xb
         fwq9EEL/niDl5Pr9Ukm8voF5IR2jhch16dAgySfycSHsZ1ppBWClMugictnG57tR6G7U
         r5jYZl71ICNXYCbEwd6UIdXgTpG0gxIbzB8wsW9Hzi3v9y+ULeyayKpqW5tpNQQtewpF
         Yi/0S3xx7w8LSXnmHgaSAaKnqTxBXbunsKC6jkug131Xk8GmgOf3mDB2vHB759BA3fYt
         CZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709394652; x=1709999452;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uKsMsTglGNrI2tQScoVSN5413wK+rz2J3hThgN9+rw=;
        b=jDBKOxRBTnH62GylGkd96NW/d39eRAx2tz499XeU6xG9sPhz6sD96wia392CgBOkO2
         4RGPWJQ47ERI1C+L/MqnPSUMmuOHp7igwo322R/tYl3Af0IIDUQzuhK0/xZmsFHWguEX
         mi1ivD0mWTQopSy8BWJAkY2O8b1g66CVFk1c82yZiGg5TDvxrK6kStnr9pkdqIjxKatA
         Qd9K9KHniZX4PNejtmxVf4qc3IDU9TZz4Rn0ML64ZdlSnrpcd1OlRofzGJ4gp0vJkp2l
         MhyWCg7aarwP3sJ2XYR6081R7sFPNDEvavjoR5WH2wOCRcmdnZodfviCAhomRQ0J2No4
         QcXw==
X-Gm-Message-State: AOJu0Yw/yNahhEpgX064506+Ow5VRgquRiSK4p96XBSE7oco7cnhX9bI
	b0we7Qm301FpPg7xAx2+2lemacc+oAgAw3/+pZEhkAxR4WsFDDd4rzpXmRlz
X-Google-Smtp-Source: AGHT+IH6p2E8Mquj73NNEShcyaJkBrs4tmAqn5/5XXg9UrY80NCIiiohlPxWt6qnB1ia5TLMOqMniw==
X-Received: by 2002:a05:600c:45cf:b0:412:78c8:b31e with SMTP id s15-20020a05600c45cf00b0041278c8b31emr3892325wmo.2.1709394652007;
        Sat, 02 Mar 2024 07:50:52 -0800 (PST)
Received: from gmail.com (243.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.243])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c4fc600b00412656ba919sm1204842wmq.20.2024.03.02.07.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 07:50:51 -0800 (PST)
Message-ID: <27fe304d-6011-430d-8f43-7e0581566182@gmail.com>
Date: Sat, 2 Mar 2024 16:50:47 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/5] completion: reflog show <log-options>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
 <ea6c8890-9ff3-46c9-b933-6a52083b1001@gmail.com>
In-Reply-To: <ea6c8890-9ff3-46c9-b933-6a52083b1001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Let's add completion for <log-options> in "reflog show" so that the user
can easily discover uses like:

   $ git reflog --since=1.day.ago

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 contrib/completion/git-completion.bash | 10 ++++++++++
 t/t9902-completion.sh                  |  5 ++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 849d191b02..dc5f73a9f3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2427,6 +2427,16 @@ _git_rebase ()
 _git_reflog ()
 {
 	local subcommands="show delete expire"
+	local subcommand="$(__git_find_subcommand "$subcommands" "show")"
+
+	case "$subcommand,$cur" in
+	show,--*)
+		__gitcomp "
+			$__git_log_common_options
+			"
+		return
+		;;
+	esac
 
 	__git_complete_refs
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index dbd57e6a28..04f3620e5b 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2626,7 +2626,10 @@ test_expect_success 'git reflog show' '
 	shown Z
 	EOF
 	test_completion "git reflog show sho" "shown " &&
-	test_completion "git reflog shown sho" "shown "
+	test_completion "git reflog shown sho" "shown " &&
+	test_completion "git reflog --unt" "--until=" &&
+	test_completion "git reflog show --unt" "--until=" &&
+	test_completion "git reflog shown --unt" "--until="
 '
 
 test_expect_success 'options with value' '
-- 
2.44.0
