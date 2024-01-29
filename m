Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF5B64CE4
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534888; cv=none; b=O8AXwpwrZHee1X70SkKa/7Wr+xKl9y3Ec79zd6TAXXiiE1ou/GTwwJRld+8bd+nyHFUAgzrpxwUI3i8WPIltBMAfwZ25rl1ymBjNl92RpaDeQep8RZ8P3tMFCG+gIhPt7yo2a9ei8L4YaZ7W7vAOM2O+dGLj+ZHTktb1O482cqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534888; c=relaxed/simple;
	bh=lvMxwpu5SITz45OThYK9Sw30XiLRRcYvW3f6jY6Cpqc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N0F8C+qcziNDs+vVIW7S7wr3/849XgxmaxcvHcwMCLLUcMXLSnIvZ5OrgCyF6csDf3HjNCtjU677SHff6nt0ktu2RIXp6je/AVu46K8vxJmLw8gWpp2xQ9h68qgTXrrKklLLkEkAk4j7XZk0oVN2vDnokoSHYhwPaj7MUSdYw1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3sAD4fw; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3sAD4fw"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51032058f17so1633442e87.3
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 05:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706534884; x=1707139684; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXyWyvBibm9hTSLDiYgyRvra4RZZ/TOhpEDNI9Sq/xo=;
        b=Y3sAD4fw8zHJR/fEAQrFypTUBn3jY4kWyye+zXrYUyZB/ByUUMxR/Bp45jicpsnYhq
         4kBQGR88lJTL3zP9Ll1UuqnY/IRZX8p2toRj37OsB9epKXndypdSE3UDuayyM6MeVfBe
         gqKoIC+7QcvGcb0RDh2XLGfTKU94kt4ZqXPtOVWKAq0bTc2Pww+L7ub5PRSwATHGb3+f
         SiG4jqYIWULkO34cjVxoRxEbHSM3la8pOwUAFcjpy5uZ91j3YiSc3lr0ToEnRDA0tWFV
         x03kCf5H7vOsoGzWrFFqNOvT6zXVChJBpBbFrv66Z4IEt+c4GW8HngrkZ7YL51a3r4im
         RNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706534884; x=1707139684;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXyWyvBibm9hTSLDiYgyRvra4RZZ/TOhpEDNI9Sq/xo=;
        b=Gh/7qC40u0o9e4nT48bVWmIZJqxlFKXV4hoz2rhStJ2+kYM7i1UYP5zMZRoTe+tuPl
         VwiR0XjclYD/9li8jFBMHzlpgHGu7CHjJQwZIgOpHGgUzQwhnzoE9sykveI0NZ8e3M4z
         FucUFhRWJnGU3NyYNHh+8qZTaZGQiY+dDhVWNEtcvDm2BdCF5MWy8RX1MkHS5ZV8S1sy
         PDupPWHVt9jWCWc0QntgG3O2fgzL64YOOB0T+XYOBqtTTzsyXPbYPPnYkL1dUr6Mr9sq
         qSXtJFHAGeU9c6kUs22lUlEJ6cybVCIgPlzI7o9DL4+t7dd7UvmVmKhggCb7+s5OIf2+
         4bRQ==
X-Gm-Message-State: AOJu0YzgMJkTPYXirhUOLDlytM/fe2zid63oENSjZYI652SO4y9z/xg7
	H1Rz1rDPNTxs2+ru0ZxBJVfs871e8KhKL0nb6SGwsGIsTpwtPJKps2bf513v
X-Google-Smtp-Source: AGHT+IF9li1dss0YchDlMl6u1PCNDHR3+bxWKH0CoGNPz0SndnGr0Qe7xD06BR/xS2GxkOKfPZ33RQ==
X-Received: by 2002:a05:6512:3192:b0:510:1878:9f00 with SMTP id i18-20020a056512319200b0051018789f00mr3990935lfe.64.1706534884041;
        Mon, 29 Jan 2024 05:28:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fa7-20020a05600c518700b0040ec6d7420csm13956920wmb.14.2024.01.29.05.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:28:03 -0800 (PST)
Message-ID: <837d92a6c277015fc8633ca84557124465390548.1706534882.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
	<pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 29 Jan 2024 13:27:57 +0000
Subject: [PATCH v2 1/5] completion: add space after config variable names also
 in Bash 3
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

