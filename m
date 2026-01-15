Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F4C29B217
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511788; cv=none; b=WuPzU8ldkr49W1ahKWzIdJ1G/m6iHkxNKyBZDJivtR9a+w2bELGlIZGzUy3HWXrnkZOA3ufWrv3uTv29L0vskMxW5lfUltqkKVrEYCqlhcIo77QfpmLk+oueluv6PotMYLtZPVbjF4SWxTS4oR3AOVC/MAX6R0CidbARC4IWXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511788; c=relaxed/simple;
	bh=7zfyRcQjC6wi9kqmETH2/bCBy5dtqJDor3NdyM2lCbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRMDbazPwqaG1Yf58JjIsA9sWfQYwMltOx/beK2vH6OK+4ysGzi0FiT1yFuGQ6NAL2sHDEptprS+kb80zhzxcmNOIPz6bO1WkvKt0ULmXst5qtRVNCDLdzl4H17XRSTZwb5bTRsab0wvq6sZc9j+LPS3fGEffMtB/pC5XVxIOA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8nVSqEG; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8nVSqEG"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-81f4c0e2b42so782539b3a.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 13:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768511786; x=1769116586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LftdnmNNDOcfUmB9M2K4mZLX6oj5V4W6Oea8qIaCeBw=;
        b=P8nVSqEGGpYIwb+b/v51twjNjC/iefpqe/VDlsjRr6KYulPb/kogFmyiyj/5bG8Eqt
         9EqHmoGQFq4Gy/xtH02RnQik/Hb3QP4lqj4EWFW5YbNo1u8b9RAkJBF6MDkB12o7JrH7
         bSmw15vfp8H/aCU/dhd+BzFb6Ocb2+zYgpdrruzhKQALqsHxqEtmx7ghLL7msLDbqzcC
         3raMQUZonQKqX4lJtQjvKVcnE0yxuqBE9dXpj9UhCAhrtG14RijpwkPVifV1GzGRH+Lk
         TYDB3wysKCSYYDLsteK741wwYlmB15JCW//+xuYFynpFHUYIi17CG84u7PVhoWiHoAGo
         3ARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768511786; x=1769116586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LftdnmNNDOcfUmB9M2K4mZLX6oj5V4W6Oea8qIaCeBw=;
        b=TP6P9zEM3Rncjc+BpDUnC/EyEHvZDIXszGYW+fT6akCj+aLs8q3AAHbQdn6mJyYXaW
         vGrh2EorHXqxPTGOLtfcF2GyyFFwXVWOpztfJZ7GLa/mFre4PAm1VbDFvRNKUOlhxsAR
         zMM1hLoH96yHWoM8cJsBfXbuY/rfhhbbCR6Jg1igNEmYcYPh/eFsY2DvZA2BG1rEYv5b
         G84hUgMs7buULAAzmc9N6pITfxFBT2dasQYLfEZasacqFRV//fzlEFKTw2+Pb5aEQbrw
         O/Do0rci4rTz1k6GJsuPSmirTV2xpzVy+Sy3YQbnF9Kz1gvI+/fmbzuRc60o3yBBSXDa
         q97Q==
X-Gm-Message-State: AOJu0YyKc6/Ew7yIyKTR9y2FPFDegXuE40n8+aSQA/IQ4cypXOvBVkOM
	6TKYLfbvOmpZ+l3y2bhoJ9VbCdJG7c1RRYVIuSmw4nnJbhZmfLrOUU9966MEe/6+
X-Gm-Gg: AY/fxX5YodC+BQgWa0c1byWynwjYWkj+kFmoHjsPFvz6Pr4M0DBJAIzbnHiVtPei1bJ
	VKDqYBRJsNtnNIytjnvcY7URfUmGDYNWAOHhzw8bstrISW7bd93jnOgcktR2xvSduKiCznpkXg3
	TJJOaHjEyqc/cZ/E9MEperqYI8G145/DUNi+vS/RHEodmvxGx47Dz4LxtHCuPeeWbEX4XZx24+i
	uu+fZO1M3HOtXhzgWSMLVHnBlkSxRTpHVY9QPQQl0fcPT9VbshccNcEAa4CDZ2LfAZ+NxPqv+xo
	4pdm2FyCoYVZuM0+qGaH8BC+x46QdQ9IkgFoYdhSNna/HGYkD2y2e+nLhd+O29OBXajWoyamATj
	EgtTlMwJD1Xn1QDHqLLTJ3RtsvdfaSkUDlv7zdcF3M7PsmT1k8yNcTa7wXO+K8N2VNI8cZspaT2
	2EGBIbcnjRT4Z9dDUTdbf/QAuXxNctJjc3k/SIxVaNEOMIOMLHrb9F+8Lz
X-Received: by 2002:a05:6a00:3491:b0:81f:47ad:6a86 with SMTP id d2e1a72fcca58-81f9f68f7bbmr777498b3a.9.1768511785773;
        Thu, 15 Jan 2026 13:16:25 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:8811:38e1:40a4:2a1f:e343:cf67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1278460sm255099b3a.38.2026.01.15.13.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 13:16:25 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: pushkarkumarsingh1970@gmail.com
Subject: Re: [PATCH] Documentation/config: fix replacement for --get-urlmatch
Date: Fri, 16 Jan 2026 02:44:40 +0530
Message-ID: <20260115211609.17420-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115110832.15315-1-pushkarkumarsingh1970@gmail.com>
References: <20260115110832.15315-1-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> The documentation claims that --get-urlmatch is replaced by
> 
>   git config get --all --show-names --url=<URL> <name>
> 
> However, --url cannot be combined with --all, and this command
> fails in practice.
> 
> Update the replacement to use only --url, which matches the
> actual behavior of --get-urlmatch.
> 
> Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
> ---
>  Documentation/git-config.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
> index cc054fa7e1..ac3b536a15 100644
> --- a/Documentation/git-config.adoc
> +++ b/Documentation/git-config.adoc
> @@ -332,7 +332,7 @@ recommended to migrate to the new syntax.
>  	Replaced by `git config get --all --show-names --regexp <name-regexp>`.
>  
>  --get-urlmatch <name> <URL>::
> -	Replaced by `git config get --all --show-names --url=<URL> <name>`.
> +	Replaced by `git config get --url=<URL> <name>`.
>  
>  --get-color <name> [<default>]::
>  	Replaced by `git config get --type=color [--default=<default>] <name>`.

Thanks for working on this, the change looks good to me.
I was also looking into this based on [1] and was planning
to send a similar fix, so I’m glad to see that it has been addressed.

While digging into this, I noticed that neither the documentation
nor the help output currently mention that --url cannot be combined with
options like --all, --default, or --regexp, even though there are checks
in code to prevent that.
I was thinking that might be added in a follow-up.
I also had a thought that we could modify the synopsis of git config as well,
showing two versions of git get, regular lookup and with --url,
not sure about the plausibility of this though.

Best,
Shreyansh

[1]- https://lore.kernel.org/git/CAGJzqs=0Zr2iqsTUZdjdwpbtaS7kuBOf=E_XT=vbdfyNTKkjNQ@mail.gmail.com/t/#u
