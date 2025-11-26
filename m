Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0221023EAA6
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174400; cv=none; b=JAoRK3CULPSJlSKQIQ692BYdj5TBcHFpVS0IyVHb7hrieuphWBn6QpG2YIc8eHQCWD9mgM5nNcw4fCMgI2nUGmcTm/yzKxVtbyzri6YWkujaF0+8erqyByJ9ui2PzRYcRIkHKYdn/yXVff6wqKXyRNLJxb9AqDnBsEmgLE5GimA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174400; c=relaxed/simple;
	bh=WmDsvQaAyzeTSGOjI6gwVgV1bBHE656q4PNFHk6mJ70=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gVgT2Pq7+XMpFwgWV+HpJJ3jD6CiVaUflz30nlTLNWDfbl37QeWKNAPZg0+SWrOQbmhuE8M3EdKAODKeHGfTRNXMRvmfjRk0qIQUAgKXms+hTrJ6ubE85O8thhDoFx3djcyRDZ7dOrouLgi9tDCSrhsTqMLeiRdPwr5faPvSqgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGdlO1z5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGdlO1z5"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bde0f62468cso2037715a12.2
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 08:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764174394; x=1764779194; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=683KBvZR0izTmosLNVvKXFM7A0pe0DlGy216v9PPz14=;
        b=TGdlO1z564avRf6f8M/weSn6FoBOWxYSVliAUL/h44wx5ZPBYGicr57iVwXRTh9J+h
         5H5Q2SgSw945J0EBU3rjbBiSxaAncBQpTLq99V3D1+Dqj9MJUVoLaSWBLGirHzkwGd+3
         XHDVqh4ZppoidYRbI6Y3AOp1+LGtaFYdhPs91micpeKKgugw+61tux3ammw1pUTJ7//e
         pLT02uOpLMdKzoaAhRYntdnLGq2Z05ve4FI/PMR6t9trW7UdvWUijWaZ95SFVsE5majK
         LSm39NzR6+PqwMGckF3hN6KbzWFDlrIT9AaZ744Rn8egWDWyw3Edvsl+WGs1VG1hiFsI
         MY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764174394; x=1764779194;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=683KBvZR0izTmosLNVvKXFM7A0pe0DlGy216v9PPz14=;
        b=IiwA8K+oI8a/DZuz63xB+EvE4ovGZwaFhoJWOUmX8C48RugwDHHeHjoeXAlr+LmfEg
         By43sAqrLbutd6t6oJNqPnWvz1jQbOxixy5YuWqN3sEKna1/2U2rvZYPwG6ZuvQQ6jy7
         ME66Rda0iJ4J0yTq+cVZwaswLF7WoSRqr1dGX5TD/SrWNwFsAaoFRGSH9/MGbsHj7Ty2
         TVtSt4Pa0Kzkq1YF6GUzRQCd9DSH+3324Ylymw3UvG2TlsVp1slwUjs3Bj8Q4XREFJtf
         OOYu3oU433u92Nvpqtjc7Svt1bVouUmggT7mJaUc6plnvOjkeUV22dEHMUNXqO/LjYGW
         WY6g==
X-Gm-Message-State: AOJu0YzBGSMM3gU8UQx/j5V+x1SqKYYduVOxeVtlL5Mwj/zWMqSKSG5/
	S5DW7gzi5RyCEOWds1Z99SeElPJC/psgB3eKHgABk4jHFBYvmDjNPfb6l9FXuqu4
X-Gm-Gg: ASbGnctYeqNLugBGTdqZRUhBnIwb6acNjHmskwunhjkRm98WMhp/eFIWwqITmPnnyTn
	HokxLPnXWXcBKow8eR98QiVtywWVxCnbvyLWsaN8CtM8CUS26ZflwRgi594nocCkxUtbomZ8FYY
	gupDZ+Xs2tR0mw37eOhHT/WCxROtdEh6swurzfO1UgQ3aRKVBivqHXPTo3NiI8SXISN2eeXGY/0
	alc4e9WVqLHkTjsZ+A2PuJaoRRqAg3A8nlKU0cdvsVGf0TYtqAJOJJHvxRPlyVIwKksUzBje5SG
	jgQ/cXCvo/uDviG5iT3jWHmdCfOnjTfvhFTWJOrbcC7K8EW1N62ZdBBc9ZbhwMMzKJaWCnokoig
	J9EDsK62qJdEmTNlCbSRoitHI8kAQPw8uDIGZeyTXV7RGGNQUTnWbzaeaFWuFNeMN2k4R4Mwkzw
	PSShJXXgJ6gEqy
X-Google-Smtp-Source: AGHT+IHbzdvzOwDwoJ4OZa76O/EJiePBpa4qIdDW5OIWk5Bzi/Aalv9jf6cYt/eGxoRnRM53WrBemg==
X-Received: by 2002:a05:7300:ed01:b0:2a4:3592:cf5d with SMTP id 5a478bee46e88-2a9415820dbmr5166717eec.1.1764174393759;
        Wed, 26 Nov 2025 08:26:33 -0800 (PST)
Received: from [127.0.0.1] ([20.169.72.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc5e3750sm67138926eec.6.2025.11.26.08.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 08:26:32 -0800 (PST)
Message-Id: <pull.2100.v2.git.git.1764174391776.gitgitgadget@gmail.com>
In-Reply-To: <pull.2100.git.git.1764052739534.gitgitgadget@gmail.com>
References: <pull.2100.git.git.1764052739534.gitgitgadget@gmail.com>
From: "Wiktor Mis via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 16:26:31 +0000
Subject: [PATCH v2] completion: complete "git -<TAB>" with short options
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
Cc: Wiktor Mis <mwiktor023@gmail.com>,
    Wiktor Mis <mwiktor023@gmail.com>

From: Wiktor Mis <mwiktor023@gmail.com>

"git" itself has completion for long options and cmds, but not short ones

Signed-off-by: Wiktor Mis <mwiktor023@gmail.com>
---
    Add completion for short options

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2100%2FWiktorro%2Fpatch-3-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2100/Wiktorro/patch-3-v2
Pull-Request: https://github.com/git/git/pull/2100

Range-diff vs v1:

 1:  1b15a0b458 ! 1:  e6161ffe3b Add completion for short options
     @@ Metadata
      Author: Wiktor Mis <mwiktor023@gmail.com>
      
       ## Commit message ##
     -    Add completion for short options
     +    completion: complete "git -<TAB>" with short options
      
     -    Git provided completion for long options but not the short ones
     +    "git" itself has completion for long options and cmds, but not short ones
      
          Signed-off-by: Wiktor Mis <mwiktor023@gmail.com>
      
       ## contrib/completion/git-completion.bash ##
      @@ contrib/completion/git-completion.bash: __git_main ()
     - 			--help
     - 			"
       			;;
     + 		esac
     + 		case "$cur" in
     +-		--*)
      +		-*)
     -+			__gitcomp "
     + 			__gitcomp "
     + 			--paginate
     + 			--no-pager
     +@@ contrib/completion/git-completion.bash: __git_main ()
     + 			--namespace=
     + 			--no-replace-objects
     + 			--help
      +			-C
      +			-P
      +			-c
      +			-h
      +			-p
      +			-v
     -+			"
     -+			;;
     + 			"
     + 			;;
       		*)
     - 			if test -n "${GIT_TESTING_PORCELAIN_COMMAND_LIST-}"
     - 			then


 contrib/completion/git-completion.bash | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 73abea31b4..1705ca3323 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3898,7 +3898,7 @@ __git_main ()
 			;;
 		esac
 		case "$cur" in
-		--*)
+		-*)
 			__gitcomp "
 			--paginate
 			--no-pager
@@ -3914,6 +3914,12 @@ __git_main ()
 			--namespace=
 			--no-replace-objects
 			--help
+			-C
+			-P
+			-c
+			-h
+			-p
+			-v
 			"
 			;;
 		*)

base-commit: fd372d9b1a69a01a676398882bbe3840bf51fe72
-- 
gitgitgadget
