Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FFA5DF2B
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707589950; cv=none; b=CYPhqmy+dhZEG7WiY/FRVS3n9wjrLtTwmrqBxytTcidQGiKuoY6BFDnMtFRmRaiSn9d5DMgAOAOcILoYW/S1xZyCF6E3SsC10bw02RKRIsVxVir0h2fjudttvTmo47dHVtB7ytVWBZnmm+TbK+tZ1XKbirtk9oeKBSuAqBDaCic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707589950; c=relaxed/simple;
	bh=W7xtYyfVVpDq81xPOVIDjBnFOpvbp+AlcWtA29lfP1c=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=q3LW1E3I3jcDqwpnCya2PnaOdmdZeGA2daVqFwUQX+rV3PrAbqQHCoXRBF++q8FGEDPzUr4+AoICntt/75IP3ZdZok/yZrmd/CmsnZu1Nac0zN93ONSH+b7nAwxjKe2FhLcRB13chGVb2wGshPirf1giscKyZBBZWiFOZ7VfG0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrMCFDfg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrMCFDfg"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3394bec856fso1840893f8f.0
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 10:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707589946; x=1708194746; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYjYJjkluNZcKwS//F0JOUSShn667tF7NbqkqQN6uMg=;
        b=lrMCFDfgNEA1qH+drISogLNVOeAVI+AO7NDIqYLQMbm3xgyg1Fc6M0+vW/k2h4Hsl4
         OOjL+uWJNO+AwzgXmOMbfBgGca2d3A2exKeGfSKD/KX1aSJ51ITwBVdOGUyxLBL35uZB
         Lx//J5YMCVdULE9lVnH4j1Tq0bZStg77lHUbz+84jTM7hSShS41dq3hbu3c7r5BuCkQz
         RK38l/Mos3vO7/Tzf058siuoGPbio+KpjRc18rAW2zakstsKAks0nKQ5ncqDC4m0P+ey
         V/vA3qG/WAyBKTwrG54jj/wQ2y5QcZBoS2GTmeUmf2aPW3E35b2q/iibJWcy7pLmsIXN
         kb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707589946; x=1708194746;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYjYJjkluNZcKwS//F0JOUSShn667tF7NbqkqQN6uMg=;
        b=v4xLiFTOagg/mqzxRupn65musp/gJp7G6g5wzhPVPJ6Ds6DHmv41LWWQ31uqAggBYL
         s9mQddsHY5mVa8OZVVq2LRnUGZKtu3y10pSA6qaM2xI9S7j9D3D+Q4KtW+b6sdH+U1kt
         FSCqJxQ2jzv+ENOsc2FfVQDALsrzFxPtpnitsBk0dNSl1tiyVM1Fgw6xOImrjLpNDhoN
         gDP48ZTz7RgHnIxrYqJwK71AjqDDj7MRx+kBz6Q6+YNpr7IuzyNhVrNZuiay5qvTS72B
         dMeWkktz+bP4M8c7cJZjQJUlpx6dZ++U/iTnWudd6RIk6r7d7GQomyBF0M/+Ly/uSr0C
         slaA==
X-Gm-Message-State: AOJu0Ywl7llbn/uaM0+pxNI4r/iKaiLx+NnoM2W4W0SnwUsRd1nf08uJ
	JW2hyE1K1Ee2OoUoFHX7O6SrGSH16eMQXkRN+cJYah5ebI8xyl/gE8JOTf7U
X-Google-Smtp-Source: AGHT+IExeDQtYlbVHzDnrddEH1SXaXyEILgTY5Csj4Mgmc+Iuujy9GXwcB6fH3jKJ+zfBHTkXnCXrw==
X-Received: by 2002:a5d:6daa:0:b0:33b:26c3:4fe0 with SMTP id u10-20020a5d6daa000000b0033b26c34fe0mr5139967wrs.6.1707589945913;
        Sat, 10 Feb 2024 10:32:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIiHhvxwj/+z/vE4gP6Yz1O0sbNQ3BlCgKSz8meHL+aMYi2AQZOxrkxLPjNNW+HsOBSuGBbJQuMAqcBS6ah1/vg/0ikT8f/C2qKdfHSg==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c1c1000b0040ee51f1025sm4097041wms.43.2024.02.10.10.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 10:32:25 -0800 (PST)
Message-ID: <6b75582ee35f0e535928cdb716935565864c2205.1707589943.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.v3.git.git.1707589943.gitgitgadget@gmail.com>
References: <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
	<pull.1660.v3.git.git.1707589943.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Feb 2024 18:32:21 +0000
Subject: [PATCH v3 2/4] completion: complete 'submodule.*' config variables
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

In the Bash completion script, function
__git_complete_config_variable_name completes config variables and has
special logic to deal with config variables involving user-defined
names, like branch.<name>.* and remote.<name>.*.

This special logic is missing for submodule-related config variables.
Add the appropriate branches to the case statement, making use of the
in-tree '.gitmodules' to list relevant submodules.

Add corresponding tests in t9902-completion.sh, making sure we complete
both first level submodule config variables as well as second level
variables involving submodule names.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 13 ++++++++++++
 t/t9902-completion.sh                  | 29 ++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 159a4fd8add..8af9bc3f4e1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2803,6 +2803,19 @@ __git_complete_config_variable_name ()
 		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
+	submodule.*.*)
+		local pfx="${cur_%.*}."
+		cur_="${cur_##*.}"
+		__gitcomp "url update branch fetchRecurseSubmodules ignore active" "$pfx" "$cur_" "$sfx"
+		return
+		;;
+	submodule.*)
+		local pfx="${cur_%.*}."
+		cur_="${cur_#*.}"
+		__gitcomp_nl "$(__git config -f "$(__git rev-parse --show-toplevel)/.gitmodules" --get-regexp 'submodule.*.path' | awk -F. '{print $2}')" "$pfx" "$cur_" "."
+		__gitcomp_nl_append $'alternateErrorStrategy\nfetchJobs\nactive\nalternateLocation\nrecurse\npropagateBranches' "$pfx" "$cur_" "${sfx:- }"
+		return
+		;;
 	url.*.*)
 		local pfx="${cur_%.*}."
 		cur_="${cur_##*.}"
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 35eb534fdda..23d0e71324c 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2583,6 +2583,35 @@ test_expect_success 'git config - variable name include' '
 	EOF
 '
 
+test_expect_success 'setup for git config submodule tests' '
+	test_create_repo sub &&
+	test_commit -C sub initial &&
+	git submodule add ./sub
+'
+
+test_expect_success 'git config - variable name - submodule' '
+	test_completion "git config submodule." <<-\EOF
+	submodule.active Z
+	submodule.alternateErrorStrategy Z
+	submodule.alternateLocation Z
+	submodule.fetchJobs Z
+	submodule.propagateBranches Z
+	submodule.recurse Z
+	submodule.sub.Z
+	EOF
+'
+
+test_expect_success 'git config - variable name - submodule names' '
+	test_completion "git config submodule.sub." <<-\EOF
+	submodule.sub.url Z
+	submodule.sub.update Z
+	submodule.sub.branch Z
+	submodule.sub.fetchRecurseSubmodules Z
+	submodule.sub.ignore Z
+	submodule.sub.active Z
+	EOF
+'
+
 test_expect_success 'git config - value' '
 	test_completion "git config color.pager " <<-\EOF
 	false Z
-- 
gitgitgadget

