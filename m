Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5F15EA2
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709394751; cv=none; b=fibJrvFCpwjnEMbSJhj4YTlG9h4oIF/F4NJWYA2THfn5t7vXV+9RE31kPkl4N0NeCYjsX0X0zwz3FMEk05JTyBXUl6JMF1s/UR6xk5BTYppBSxuft8Xg23Y/p71SDLZITp42eanBLRMoM2dut24yP2JjPIraDW++mGsYvL0XwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709394751; c=relaxed/simple;
	bh=+A+qOK+diXtjXBPuHwcxj6QJHxOFjkx6XVzHbwvElSc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AKwQqHPS1G3ijAt6tLPe6Jlbo4dr+5V4Z3zYu5cKjxyVBZ0/TYVmjnTP8e8h5pmdQJxdNVBhk8yX5Qnsw8U6MT4vVXpBBhGXKwp4tXz1X6fLuEHyFkoykeBX0WlJsRB6QwiZorLQlX6Jf+U28BYnQ9bZkNtxWkOWqrCUgcWwC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qp1zKShq; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp1zKShq"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d37f6bbab6so3161881fa.1
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 07:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709394748; x=1709999548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D6lCqzq6++SzEJIf3GoNH+DztW1Z6+HXpdaEeA/5uMo=;
        b=Qp1zKShq+8LYEh9y3QZ9zczwRWy3QsumHcQW472U5Eq9wcyMKHJtqVjt12qokd/6HX
         FsMgfsawFG6wWB325kfwCy0Dhr8mAmHXFTpNzd7SQWOrrGgGAueoANwV4FYB4CrtkTRG
         Ih+2K9peGZrfgFbz63b18oiMSbcEp1Qrj7H/LJo5gP13ScIatcpoVAm3r2P2AimFsEtD
         ZpnCAgm1a0JU3WSEJja3iGwmR8C9WbRxmERd0kmde+iQ+rZT5Rcya0GssUKvhrNlzjEV
         cFTzLk5+HLQzSRIjj6Uk44L8UBThcqEMcmRz8Kv0HfUnspxHeh8JN41oQ/Dpx3GDrsHT
         aAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709394748; x=1709999548;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6lCqzq6++SzEJIf3GoNH+DztW1Z6+HXpdaEeA/5uMo=;
        b=gKggHFTDsR+wr8/YpFfXW6YYdQIyL7p/lBjSnWg0GPOr9SsW+U3NVxac5pvRP6hff6
         H3Sts2V05iPxhqt+Gekxb0PpeuAs9TjAKhWAn6oUOQEKEUz5Yb3DxjNsiH+DjZYfZe1j
         xLDBZdjRkuHEmsLthpmUqnj2Ur09ra67IQuph+d+anSFeC/LXiNCCg5bkHtf58HpCikz
         uK5E5hSHZ0gDpfXG/ncGkPNP655dzRK0ENEp5GRWMF5ouFzIKk1Kl7QjDc44puj0IoWL
         IE0XJaBL9Kc7wPn1ag3tIdmGsnSOC1E8vlG6TCme3/asLj19/dabTfRpqKsPQD9Y66wS
         iA3Q==
X-Gm-Message-State: AOJu0YzSKQO+ZgNIfYJHDbzc3mO8qd0cJXPdTUhYPgeZU8hENmBe+k1f
	pABeSOwp8ettR478GNZIH2aDxUrpV4c9luLBTjcRVdF50btZQwOjn+xj6WXS
X-Google-Smtp-Source: AGHT+IGbkpze3qZgChrp6wd1CSWOdrLbiGYeDQlu91LcL2sLwXVABXZbWmiCgdJGceZw6wDCQlpWzA==
X-Received: by 2002:a05:651c:2cf:b0:2d3:5cfe:c600 with SMTP id f15-20020a05651c02cf00b002d35cfec600mr1706416ljo.3.1709394747736;
        Sat, 02 Mar 2024 07:52:27 -0800 (PST)
Received: from gmail.com (243.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.243])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c4fc600b00412656ba919sm1204842wmq.20.2024.03.02.07.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 07:52:27 -0800 (PST)
Message-ID: <cf3933b2-a577-4df1-9425-cf324f03d6da@gmail.com>
Date: Sat, 2 Mar 2024 16:52:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 5/5] completion: reflog subcommands and options
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
 <ea6c8890-9ff3-46c9-b933-6a52083b1001@gmail.com>
In-Reply-To: <ea6c8890-9ff3-46c9-b933-6a52083b1001@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make generic the completion for reflog subcommands and its options.

Note that we still need to special case the options for "show".

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 contrib/completion/git-completion.bash | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f9fbf1f703..c5c9e9de2d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2445,8 +2445,12 @@ _git_rebase ()
 
 _git_reflog ()
 {
-	local subcommands="show delete expire"
-	local subcommand="$(__git_find_subcommand "$subcommands" "show")"
+	local subcommands subcommand
+
+	__git_resolve_builtins "reflog"
+
+	subcommands="$___git_resolved_builtins"
+	subcommand="$(__git_find_subcommand "$subcommands" "show")"
 
 	case "$subcommand,$cur" in
 	show,--*)
@@ -2455,6 +2459,10 @@ _git_reflog ()
 			"
 		return
 		;;
+	$subcommand,--*)
+		__gitcomp_builtin "reflog_$subcommand"
+		return
+		;;
 	esac
 
 	__git_complete_refs
-- 
2.44.0
