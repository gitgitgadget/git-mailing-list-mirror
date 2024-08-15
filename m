Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B651A01D4
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723727666; cv=none; b=nIVDZOXLnLvH3nM+zfVgz/Q+EEX1wtrFXLakGo9pH6ZcvCLRlWr56teych2pVN2Q4Yh+sEvvwnPfX/8/a8NHfvFDJQMaHQnCSHHx4tM/ZxXgSGCQOJgDo3+21v89AsiakXeUO1/gFo24U/cScxhCzTOW3FwtFv2BX5wBdt9NhMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723727666; c=relaxed/simple;
	bh=v+jMPc8z8nEbTUtYnZtSs+t993RhPfq1zuufwrejIis=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TJ0y1CG248cOJwmiGayht9ZCAUkQqfxoTZzc06szhO4zK0akpJeQp4Y1NRyStWN5zrIcayhw/Y1Zf9dHmyxzo0WnA4mzdAVTa9aKWQiGWJLliHyDfI91uEnRGOvrBypGuoYr7Btv2bdz/dPbbpgeVlL3HmcB/9GJete1bAy/dLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnOiL2nC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnOiL2nC"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42808071810so6053535e9.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 06:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723727662; x=1724332462; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YF7YjmYcjoTfiyty4/qVcE6d/YtaHOgwJiFDBZrqMM=;
        b=bnOiL2nCfxwnPXZqNgChKMXf4r7lE2zCCVqoILF87f3xuTlG1we86EAD6NRGorYHzO
         yxxpd1HthkSNXzwaybDdigGVXDPiBcN+PMLM47MPEbCHsC8rbNC07EcseYhw61h8BAvh
         oFkQf34CfmcFSRC+VUS1sRzroS0ACOyLi8CGrvmrPTrza/6Vefq+lHiMsVKEfnd98l1a
         b5iWXsJoLmMcjT87Ci3JJB/P3XMbhMJLA9tb8LEC5/I53DQGx7NljJuBPT65uAnHl1M4
         WaGPPk1MuSylOaVr1hm2U9zxIMlMGEpSe38bSfYxoOxQD5NYjlaKCCwj9Q0il5+fRiOw
         N1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723727662; x=1724332462;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YF7YjmYcjoTfiyty4/qVcE6d/YtaHOgwJiFDBZrqMM=;
        b=Fdge4Uck66ltad+hgJWvZPA4x8/LuEBDoXVhfs33vYJ0eBC1Dsv5xByRBDabVzI6pB
         db965NXLcbQ+/7qyP4FQ85i5Kmof2dfu06SgcWNdoo0Dk2tTiqaIo2N6o6QvdkaPQUag
         9lJM/WK6IyEyQSDc+uKVgWYIDLMMZHE9PfiWRqVUTUXlvVlf+6JCiL0z0/7fEY5+gEap
         uG3bVM3/MPKieKXhJxndayQ6GHgiWAiK7V+jqY0uCWEpLBDfbw1e0GpcEPF+YRuhuVYt
         Gw2H9KKltu+ESLRqo7G1yBOQBPOtE7pSzL7IYcx0bfUjQVJ+iT2gxIjx9F7+elfeucV9
         UcbA==
X-Gm-Message-State: AOJu0YwWQ8gOuRCeNQhRbVsAwXPzXTEcVC8WZesCe0j97xyukg2qpbQ2
	1U58I8lYHZjUgPDTdTzAkcJkbbjv0AXaEf2DMB5hpar859B2RaB+HxMHcA==
X-Google-Smtp-Source: AGHT+IEMjZcfhq15pG0YsiZPPLOeFIjQJTcIawrcn1p9MTawwnARjWMc3Zafde7ClFwAdqx+UwtU8g==
X-Received: by 2002:a05:600c:4590:b0:428:141b:ddfc with SMTP id 5b1f17b1804b1-429dd2684b0mr47246045e9.31.1723727661517;
        Thu, 15 Aug 2024 06:14:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded71dfasm48697895e9.38.2024.08.15.06.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 06:14:21 -0700 (PDT)
Message-Id: <e71ddcd2232c6f687855e2d4a0c79def1164d71c.1723727653.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Aug 2024 13:14:13 +0000
Subject: [PATCH v2 8/8] git-prompt: support custom 0-width PS1 markers
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
    Avi Halachmi <avihpit@yahoo.com>,
    "Avi Halachmi (:avih)" <avihpit@yahoo.com>

From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>

When using colors, the shell needs to identify 0-width substrings
in PS1 - such as color escape sequences - when calculating the
on-screen width of the prompt.

Until now, we used the form %F{<color>} in zsh - which it knows is
0-width, or otherwise use standard SGR esc sequences wrapped between
byte values 1 and 2 (SOH, STX) as 0-width start/end markers, which
bash/readline identify as such.

But now that more shells are supported, the standard SGR sequences
typically work, but the SOH/STX markers might not be identified.

This commit adds support for vars GIT_PS1_COLOR_{PRE,POST} which
set custom 0-width markers or disable the markers.

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 75f272daa21..5c43981aa11 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -129,11 +129,16 @@
 #    strings (SGR color sequences) when calculating the on-screen
 #    prompt width, to maintain correct input editing at the prompt.
 #
-#    Currently there's no support for different markers, so if editing
-#    behaves weird when using colors in __git_ps1, then the solution
-#    is either to disable colors, or, in some shells which only care
-#    about the width of the last prompt line (e.g. busybox-ash),
-#    ensure the git output is not at the last line, maybe like so:
+#    To replace or disable the 0-width markers, set GIT_PS1_COLOR_PRE
+#    and GIT_PS1_COLOR_POST to other markers, or empty (nul) to not
+#    use markers. For instance, some shells support '\[' and '\]' as
+#    start/end markers in PS1 - when invoking __git_ps1 with 3/4 args,
+#    but it may or may not work in command substitution mode. YMMV.
+#
+#    If the shell doesn't support 0-width markers and editing behaves
+#    incorrectly when using colors in __git_ps1, then, other than
+#    disabling color, it might be solved using multi-line prompt,
+#    where the git status is not at the last line, e.g.:
 #      PS1='\n\w \u@\h$(__git_ps1 " (%s)")\n\$ '
 
 # check whether printf supports -v
@@ -309,8 +314,8 @@ __git_ps1_colorize_gitstring ()
 		# \001 (SOH) and \002 (STX) are 0-width substring markers
 		# which bash/readline identify while calculating the prompt
 		# on-screen width - to exclude 0-screen-width esc sequences.
-		local c_pre="${__git_SOH}${__git_ESC}["
-		local c_post="m${__git_STX}"
+		local c_pre="${GIT_PS1_COLOR_PRE-$__git_SOH}${__git_ESC}["
+		local c_post="m${GIT_PS1_COLOR_POST-$__git_STX}"
 
 		local c_red="${c_pre}31${c_post}"
 		local c_green="${c_pre}32${c_post}"
-- 
gitgitgadget
