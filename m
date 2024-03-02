Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287518627
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709394676; cv=none; b=l9XP/yhN12+enWzZqfXdRL/pfNOw6v/cwy5v/g+aMVwNGOZOWRE8GxPy73YkGLNwLxcry7e5pWMNwt0iAX4me4njAoClK4mPy1MJ6X+bENBtLMCncVNTCGvaO6+hHyh/j+oWwLK444h6K+2vlXbD77FVKkopkGQaInMrnip1UqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709394676; c=relaxed/simple;
	bh=tKZFnWm2BzNRZXOSi0G6MCpqcOTrJlu8UFAvP4ddKUE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=foIkN4YrWO7PdFbQ/v5xq+d0bgzebjaIy2oCvNOBOAcTe6LFUeNdLxKKSjf5o8oCf5khzhU4iE0jMMlKXZP/aA1joviNdMSGor+2yjcv/1mhEBI98t4MO9HsyJSe8QlD6e4Gr5Emz+wno4h4maoLuPZp4nVCfTuyMr8MreX/fco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWEiRoLa; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWEiRoLa"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d37f6bbab6so3153261fa.1
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 07:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709394673; x=1709999473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7BlxXP0GO2d0Y/z0JgYaWtM2zccmb+RqF1MhPjVI2M=;
        b=AWEiRoLaNekOTxCRrQv5ZRIkxLP5kHgpJT0wkhovWMR5JPfq/au8myzn1ZPsREfmpf
         73+CQhCBvdu2bbascnTZ7a5BfIozBdsE7tSvp8TqDV+BGVcNLJiTrN6r+r1OWL2dFYEz
         KcFI13dhL8sPz4Igvfqucqb+GUNjuDCw4kwDchh/m866mWVdmAY0U5QeNyd6Aovib7fU
         6US/2pkvbB3TvM7GeIw2NzmDi8JOx/JfBY882x2NkH9/WHZsU0qSnQJ48a6XvVge0m9K
         W144vqHfVUZeaTS43pyrH1ECWEGmrBIVBKcVGOtncXgTIaoY+XcrYWeEVO/+WtkxcKlw
         RpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709394673; x=1709999473;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7BlxXP0GO2d0Y/z0JgYaWtM2zccmb+RqF1MhPjVI2M=;
        b=uq3QdC2nac8I7J5jdeU9XoxBhZ1+sTaH7W/QxbCFb9mUWEZd7ay4doNoEA5Z+1nSn3
         TvF9OaHnhUQOZLVwiF9cq/PGBsxGw1ZjJdQbn+XVUpl+/27ojLpMvnCGkLNV9ShNy8YT
         0JUtCfJknNBag0vxUWj3F4u8bLqj0f3VCm6ONnUoflNuYTT27TPZFgYRei5r2379y4Mk
         vYZ4Y4eo1Yz/Ngxz0oTg/X0nmig5WTzkNdzaNA+1XEXOPV3SqN5NDc1oa/OtMpa7MnOF
         C2m8T5gDamyda7v8fZJOlLco8xTHPy6EkKLjRnAsmv0RHNmidTfS2F8T9B+VIfchH3h0
         D0GQ==
X-Gm-Message-State: AOJu0YxCXjAaPRhBQZgOiSge3Oaac2rt9Gc0MCEO9HH48PXsDhREpoeo
	z0MZfPKn10faK73SA/L67ZDoTnNU3Wocx2w2kYRAY0Upf5r4jBrtpNeB9lyb
X-Google-Smtp-Source: AGHT+IGB9gw0DRl/DpHLOQ/NxZC3do4EzQHwtsXu3AjUhiCU1cDUB1zv1Ue/42A6DmlC/95QF4a8aA==
X-Received: by 2002:a2e:3207:0:b0:2d3:4b73:7b40 with SMTP id y7-20020a2e3207000000b002d34b737b40mr2588539ljy.17.1709394672513;
        Sat, 02 Mar 2024 07:51:12 -0800 (PST)
Received: from gmail.com (243.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.243])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c4fc600b00412656ba919sm1204842wmq.20.2024.03.02.07.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 07:51:12 -0800 (PST)
Message-ID: <58420452-9491-4e46-8746-55afe95f41de@gmail.com>
Date: Sat, 2 Mar 2024 16:51:08 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/5] completion: introduce __git_find_subcommand
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
 <ea6c8890-9ff3-46c9-b933-6a52083b1001@gmail.com>
In-Reply-To: <ea6c8890-9ff3-46c9-b933-6a52083b1001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Let's have a function to get the current subcommand when completing
commands that follow the syntax:

    git <command> <subcommand>

As a convenience, let's allow an optional "default subcommand" to be
returned if none is found.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 contrib/completion/git-completion.bash | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ff216f1c65..849d191b02 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -554,6 +554,26 @@ __gitcomp_file ()
 	true
 }
 
+# Find the current subcommand for commands that follow the syntax:
+#
+#    git <command> <subcommand>
+#
+# 1: List of possible subcommands.
+# 2: Optional subcommand to return when none is found.
+__git_find_subcommand ()
+{
+	local subcommand subcommands="$1" default_subcommand="$2"
+
+	for subcommand in $subcommands; do
+		if [ "$subcommand" = "${words[__git_cmd_idx+1]}" ]; then
+			echo $subcommand
+			return
+		fi
+	done
+
+	echo $default_subcommand
+}
+
 # Execute 'git ls-files', unless the --committable option is specified, in
 # which case it runs 'git diff-index' to find out the files that can be
 # committed.  It return paths relative to the directory specified in the first
-- 
2.44.0
