Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C38C5CDF4
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707589948; cv=none; b=pAbtSjAk6HQL143BY36IRO1hrU3+ab5pp8//MyP80yyzvk+tL36pH1YWpKraKtJvbBZ5tFKIpSQN/NqU+jJtTA9jm7UMH+TfHPjI/3ZcHVwRYy27QVdyC4AemelcCWtFDMK/qgQF6d/VMUloE0OD+BUgAq5jtr+e2bre4onDnoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707589948; c=relaxed/simple;
	bh=lvMxwpu5SITz45OThYK9Sw30XiLRRcYvW3f6jY6Cpqc=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EJ+WInTR+gCzXTqUdyxglegzDOiT9s2P5hxSbHRT7VOnQScAsyWBQOdKH+BTI4QP1dWLhpLUbuxLctjDOSlJq1uxQ6xM/jmQkStDGa40YgIuXviFAmzjvBbaTajXPUf1VkNj3cMaQ8OjjVhZ8YsCOalh5Tw3rMaUHtFvfitnrno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcwOTXWa; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcwOTXWa"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b712ebdb9so386518f8f.0
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 10:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707589945; x=1708194745; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXyWyvBibm9hTSLDiYgyRvra4RZZ/TOhpEDNI9Sq/xo=;
        b=dcwOTXWaRkeZOyVqzZM3udfwH259fVLAaBmjGckV4N+b55dTm7jFWTShZggZjmpZSL
         cYbA5K5p5yW6tb9D/q+CrfJ1TL71v97/K3AT3tUTrBYDZX6jClkc29CsAZFrb6U57IDS
         7EfHy3zwZGAPZMkN39+dHPGZndDC+pl+S/XXwcUuAjKWbnWXV1M5yyFuqfXLMHdAR1KD
         SO9Nn1Cqx8ML3Fu5zXRJGySYxhgtqpC580IgQRrCASJjqd+I1949bV6zQfF9tgAtPJh5
         AOCNIB2++Lhg0Oc492TeyyNeJoygDvhPOl0JIWCDWLSZXHb4PTPX3LRmVRGJS9az6Kyw
         Ge+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707589945; x=1708194745;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXyWyvBibm9hTSLDiYgyRvra4RZZ/TOhpEDNI9Sq/xo=;
        b=sDA4pvtybrbd7Rqn2Kg0Znwz0o5qD/sGqdL9mgg4QcH3QF5aIY0c/xPrfmXsGnO1Bw
         ez84j8NzVI76mRXB6652c+S0ZQko0Wl25AhEImKGK4V+crRJ9A5yDWqtrOHUFD8CXbkU
         gSrz238WG9rC9Kz/AJChjszxJ9GGuc7UJA3rT8o1syw6XFx8oFZ6eNWxOQU4rhgn0Siz
         iIoHPR1a2fi6o14KEOKb+4hBAHUu55BeJykutOOvYFhO4WzAP20MhXQ92hQVK18OaeUw
         zcqwxjzy8af6qyPKPzGZg1308DFGAI3jBP9SX6AuXcFTvri4ySNalZHK4Ao+sSavw1Jy
         NwxA==
X-Gm-Message-State: AOJu0YyaeH6Guwr3R4d4U0Bi9QZRQilBZjRxLu5BWNYXXar7ylPBQCqt
	0gyVQcr792RDmzwdJcVJq4HHYhi8NXsBaW8HwtzPdQ24sH+xLqUyq1rNam4b
X-Google-Smtp-Source: AGHT+IGy0RAL4OkH/8n4t9ZKzzK+194qPZUG1Dg5unsjZEn3YMzB2OpWZTvlpEyCVmu+db+XGeZ1oQ==
X-Received: by 2002:a5d:47cb:0:b0:33b:3e48:59ec with SMTP id o11-20020a5d47cb000000b0033b3e4859ecmr2799170wrc.63.1707589945186;
        Sat, 10 Feb 2024 10:32:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdAdZAzqqkEizByXsPGGJd2/h1shjwM/TpVRkF8B0enWucg+relgafPlI7MQI02S2gBje1N40GL1Jd3/2h79KeQ52g4DFgm4uj6cHrPA==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15-20020adffc0f000000b0033af5716a7fsm2436567wrr.61.2024.02.10.10.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 10:32:24 -0800 (PST)
Message-ID: <837d92a6c277015fc8633ca84557124465390548.1707589943.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.v3.git.git.1707589943.gitgitgadget@gmail.com>
References: <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
	<pull.1660.v3.git.git.1707589943.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Feb 2024 18:32:20 +0000
Subject: [PATCH v3 1/4] completion: add space after config variable names also
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
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

