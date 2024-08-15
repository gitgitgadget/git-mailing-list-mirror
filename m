Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A421714A2
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727659; cv=none; b=OarrD2O6zFd36HfiohnlgW+BaiSQSeg0319LjBDyQOwMHX/9pfr318Nz4rGKnAX7BflsHb1VZEgW7owBSn1sz5yk1d3bpvouk03EGlI5yZWh8hD0bhsGrzcYyhJSKk6FZTqAlGoQ1Wxymm/QZKD8gAgXeqng4Pv6CJALb66EDOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727659; c=relaxed/simple;
	bh=hq0HK4UDGhp6zl17ViFqg/jHv/7Sb9SAzzTw859XaTc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=e6I8lO/oKeDIQNeKHB0x/fVEbba/xtIvAbEJ+XpXtRcJIHUCBhuGW8c1393fOHkKogMCJPhm0Mvu2CwdT95q9GIqmhFvIaaa9HgXUwM8cywcXahrMIvffCbCCQVIFl8Qnf6Vij1nx2HnuhprgjOkJ1D9m3AA8nCtcWN5C3nbac4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikOxOurY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikOxOurY"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-367940c57ddso542776f8f.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 06:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723727656; x=1724332456; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXaeNNZRivDXhFJrs/yOGhawWFwbDEa4oD+EDF2PmR0=;
        b=ikOxOurYA4gvKmZiYCaIong0gvSVaMIJB5QZqZgGVMKwElUPQHGsik1ePyGrtE1pFd
         J1zJN5wEfm0r+qltwbGsGlHnOC29kVbT1Kk+k90AmRKCC4HEWRok6BoK7a/PH8yTQGS/
         PWlOzxOctgr9QmvBCobtMEtvFMjamNafAghl+Rp/ZQ6NyCMoXnpbkc69pWg9X99pLEwn
         XxDErGi1wQKHIOBVxK7CWE9qP8mw7wNSylPC7kwpugTSCQpI0DjzRB02q5mNJsW8qTma
         9Ux5VnLyZ/Eargc8qIjU+G33I8qwK+V0xX2DZwCH93RqqbCCaGzNejGSgIHdfO3xrQXy
         XmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723727656; x=1724332456;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXaeNNZRivDXhFJrs/yOGhawWFwbDEa4oD+EDF2PmR0=;
        b=jTyBkIgP4GsvmeR3FA3IICAZvfEcSuIgyYkzJtMdQ4E7tu7INr3s+Ljc3itQo2QCdu
         AppDwsT1VhdufazNJ5/FKpzM+kVVQqRBr2r9U+3SyeWSIIHQ2cGwsK39RN77DXdIJSTZ
         iRyn8Xi5XiA6SS3gDGf2NzDTEOJqh8lqoMJEg1KZXapQBbU4SW5xCFNzfuI/NWJsf5cb
         BjRDi5y1st56Hn5ZuTHIJnKCOLZJBrsKIkCihdzORm0vGPWA7GnBlCcUaC4Hv9VLoAjG
         NbKwg2ZuLbfsBKI6lKipYSMLzYA0yLCsWAqnSaKiW+6xHK9t3bVxSrP4baoGUw60x3T+
         MtLg==
X-Gm-Message-State: AOJu0YyA3x8XSTKhdyKx5fcgAcK30CkMQWiAfJ+4OBQ8eC2NMAPIegG2
	CpGcELLTr5fBk7IFGcgEh1Qif8SFHi+eYPoYlhRbpMnGx02/ao/fnum+bg==
X-Google-Smtp-Source: AGHT+IHxttC2RZELKPewUN6r/1KfGrRXUbD7fTVZM9w7tvzJUDvBZgajhA5NZ3NspEwtkAzldO9eEQ==
X-Received: by 2002:a5d:4985:0:b0:368:8015:8a96 with SMTP id ffacd0b85a97d-37177762e8fmr3962350f8f.16.1723727655192;
        Thu, 15 Aug 2024 06:14:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a56csm1518260f8f.21.2024.08.15.06.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:14:14 -0700 (PDT)
Message-Id: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
From: "Avi Halachmi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Aug 2024 13:14:05 +0000
Subject: [PATCH v2 0/8] git-prompt: support more shells v2
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Avi Halachmi <avihpit@yahoo.com>

This addresses review comment on part 6/8 (git-prompt: add fallback for
shells without $'...') which requested to use one form for all shells
instead $'...' where supported and a fallback otherwise.

Parts 7/8 and 8/8 are rebased trivially on top of updated part 6/8.

Using the GitGitGadget github interface, so I don't know whether it will
send only the 3 updated patches, or all 8 as v2.

Potential followups which this series does not address:

 * A comment on part 6/8 suggested to add to CodingGuidelines some of the
   guidelines in the commit messages, without being specific, likely
   referring to part 5/8 (git-prompt: add some missing quotes).

 * The same comment to 6/8 posted a suggested patch to CodingGuidelines to
   disallow bashism [[...]], and disallow $'...' - which is comliant (POSIX
   2024) but not supported in all shells.

Avi Halachmi (:avih) (8):
  git-prompt: use here-doc instead of here-string
  git-prompt: fix uninitialized variable
  git-prompt: don't use shell arrays
  git-prompt: replace [[...]] with standard code
  git-prompt: add some missing quotes
  git-prompt: don't use shell $'...'
  git-prompt: ta-da! document usage in other shells
  git-prompt: support custom 0-width PS1 markers

 contrib/completion/git-prompt.sh | 191 ++++++++++++++++++++-----------
 1 file changed, 126 insertions(+), 65 deletions(-)


base-commit: d19b6cd2dd72dc811f19df4b32c7ed223256c3ee
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1750%2Favih%2Fprompt-compat-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1750/avih/prompt-compat-v2
Pull-Request: https://github.com/git/git/pull/1750

Range-diff vs v1:

 1:  9ce5ddadf0b = 1:  9ce5ddadf0b git-prompt: use here-doc instead of here-string
 2:  680ecb52404 = 2:  680ecb52404 git-prompt: fix uninitialized variable
 3:  7e994eae7bc = 3:  7e994eae7bc git-prompt: don't use shell arrays
 4:  232340902a1 = 4:  232340902a1 git-prompt: replace [[...]] with standard code
 5:  4f77b7eb7f1 = 5:  4f77b7eb7f1 git-prompt: add some missing quotes
 6:  1c1b58e20ca ! 6:  363b7015763 git-prompt: add fallback for shells without $'...'
     @@ Metadata
      Author: Avi Halachmi (:avih) <avihpit@yahoo.com>
      
       ## Commit message ##
     -    git-prompt: add fallback for shells without $'...'
     +    git-prompt: don't use shell $'...'
      
          $'...' is new in POSIX (2024), and some shells support it in recent
          versions, while others have had it for decades (bash, zsh, ksh93).
      
          However, there are still enough shells which don't support it, and
     -    it's cheap to provide a fallback for them, so let's do that instead
     -    of dismissing it as "it's compliant".
     +    it's cheap to use an alternative form which works in all shells,
     +    so let's do that instead of dismissing it as "it's compliant".
     +
     +    It was agreed to use one form rather than $'...' where supported and
     +    fallback otherwise.
      
          shells where $'...' works:
          - bash, zsh, ksh93, mksh, busybox-ash, dash master, free/net bsd sh.
     @@ contrib/completion/git-prompt.sh
       __git_printf_supports_v=
       printf -v __git_printf_supports_v -- '%s' yes >/dev/null 2>&1
       
     -+__git_SOH=$'\1' __git_STX=$'\2' __git_ESC=$'\33'
     -+__git_LF=$'\n' __git_CRLF=$'\r\n'
     -+
     -+if [ $'\101' != A ]; then  # fallback for shells without $'...'
     -+   __git_CRLF=$(printf "\r\n\1\2\33")  # CR LF SOH STX ESC
     -+   __git_ESC=${__git_CRLF#????}; __git_CRLF=${__git_CRLF%?}
     -+   __git_STX=${__git_CRLF#???};  __git_CRLF=${__git_CRLF%?}
     -+   __git_SOH=${__git_CRLF#??};   __git_CRLF=${__git_CRLF%?}
     -+   __git_LF=${__git_CRLF#?}
     -+fi
     ++# like __git_SOH=$'\001' etc but works also in shells without $'...'
     ++eval "$(printf '
     ++	__git_SOH="\001" __git_STX="\002" __git_ESC="\033"
     ++	__git_LF="\n" __git_CRLF="\r\n"
     ++')"
      +
       # stores the divergence from upstream in $p
       # used by GIT_PS1_SHOWUPSTREAM
 7:  4a086ffc360 = 7:  4aa75cdb5dd git-prompt: ta-da! document usage in other shells
 8:  f241c3ae1e4 = 8:  e71ddcd2232 git-prompt: support custom 0-width PS1 markers

-- 
gitgitgadget
