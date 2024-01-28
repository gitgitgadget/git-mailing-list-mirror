Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D83219F
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472179; cv=none; b=ULTKTt2vl0+qTy90FS8DNJJTNTivYrwKsdqDnbZdH4LJ9DQh4yVTwFMnUQorS3bFlsjtuvhI4ND6KHydfaYAEPaZbuH+v30dgNvCpe1G+BoAJu1YHz9TLCPDn/e4KWpezeV9tW1AYlQ8BjFGSDBxOBG2uj5S0Y4lPyQ/nRonDtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472179; c=relaxed/simple;
	bh=lvMxwpu5SITz45OThYK9Sw30XiLRRcYvW3f6jY6Cpqc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FFDPUq7NMdYpHTMuC6TGbJ0RGpKjLyyexnOopLa4Qhn1X0dytR4JbLbB5qztUnTqka4+x5xfN9sA4Yya2TWL76cArQUWqQ0swoh3gAKYMuFgHVGCJ4QFTDbQlIvQPkaLMzIuKfGGIJsMc8m5xyfT+klAoD1cxzKNJsT1qOjLNzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f68UeDkr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f68UeDkr"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e80046264so33295925e9.0
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 12:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706472175; x=1707076975; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXyWyvBibm9hTSLDiYgyRvra4RZZ/TOhpEDNI9Sq/xo=;
        b=f68UeDkrmbFMvznjVrRznAeyZB3SRhLBHcSf0956U44S1Fx9gt8KaPnEY90wnXUaKR
         5o8MaVy+AihkRk4qxXXrrCARu/cNgOaZ33ZlJRVgsGuG9Je1QB7Ru0IW3JV12WSHYD5c
         rlW9dZyogt5vq6AzcHp/1IsPOK0NNj0asvHmwVpQtbPMf9aMOHnY1o9TylxRbyxVk0TL
         dxC9oM+6lDsGsb+s31taFgCyNTg54SfhhTknVIg4BIQkBnpyS7TDkLfG0NwnJCK+x5U9
         dVCBgXVnlzni1cQZAcJn2CrOAhdz4uUoCXAeNBDVuNrrBIy9g9fDT0Mb/lIgIOKmyiFL
         247g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706472175; x=1707076975;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXyWyvBibm9hTSLDiYgyRvra4RZZ/TOhpEDNI9Sq/xo=;
        b=u4cs0THNqQj1CuBI6XnpSK7yTGBufNmOjqSHZ28zhqcQbHHeZ1AVtyeEIDlVuW7wE0
         CZEmaLH+N+iOnRaWU0kbNrlZGCcjT568pvDeXuN6COw8Mwzm5QjL3iv7zXMlXziub6hg
         vEBMKdMK/dQo3VKz01byUr7HzmMWBzGyK+lgv7afm+PnT/XwmfWxsAYIS8XeHe4xr1wV
         SieoSAvwrSG1j6YspAQCp4b1gK+7n5buMUEi+imOUQcezNEi73yBQCdc+louBE3oGZhZ
         zSmEY3tHZ03oluWCPI7rg1r/m36C10Q44PKJRK/SONGihF177ySDijvY4rfjkwBmFQul
         ND8g==
X-Gm-Message-State: AOJu0YyFoqSOK4/N2HX8g2gYgNN+jriBjY6emlV45VOWk4Ikp/lyd+pW
	Ow24UT4wnVOh8EFGewpsEmEtQx7ybLMBlZaBEWUpse2hOrKxE1pPdvnXDTv3
X-Google-Smtp-Source: AGHT+IEe4KOW6t/0Yx2+wBQsqHj03N3YRnMn20KR4sbWIEOVqpDQMsu79emGcyf23NmYLtpoju1jrA==
X-Received: by 2002:a05:600c:46d3:b0:40e:a255:8f53 with SMTP id q19-20020a05600c46d300b0040ea2558f53mr3604637wmo.13.1706472175275;
        Sun, 28 Jan 2024 12:02:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc20-20020a05600c525400b0040ed1e5d5f3sm11133620wmb.41.2024.01.28.12.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 12:02:55 -0800 (PST)
Message-ID: <837d92a6c277015fc8633ca84557124465390548.1706472173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jan 2024 20:02:49 +0000
Subject: [PATCH 1/5] completion: add space after config variable names also in
 Bash 3
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
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

In be6444d1ca (completion: bash: add correct suffix in variables,
2021-08-16), __git_complete_config_variable_name was changed to use
"${sfx- }" instead of "$sfx" as the fourth argument of _gitcomp_nl and
_gitcomp_nl_append, such that this argument evaluates to a space if sfx
is unset. This was to ensure that e.g.

	git config branch.autoSetupMe[TAB]

correctly completes to 'branch.autoSetupMerge ' with the trailing space.
This commits notes that the fix only works in Bash 4 because in Bash 3
the 'local sfx' construct at the beginning of
__git_complete_config_variable_name creates an empty string.

Make the fix also work for Bash 3 by using the "unset or null' parameter
expansion syntax ("${sfx:- }"), such that the parameter is also expanded
to a space if it is set but null, as is the behaviour of 'local sfx' in
Bash 3.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6662db221df..159a4fd8add 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2750,7 +2750,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
-		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
 	guitool.*.*)
@@ -2784,7 +2784,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__git_compute_all_commands
-		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl "$__git_all_commands" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
 	remote.*.*)
@@ -2800,7 +2800,7 @@ __git_complete_config_variable_name ()
 		local pfx="${cur_%.*}."
 		cur_="${cur_#*.}"
 		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
-		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx- }"
+		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
 	url.*.*)
-- 
gitgitgadget

