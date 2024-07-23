Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3918813E03A
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721762322; cv=none; b=dF2RvQTOm3z5uh6hy9wMEcKscvQ3kHoEzzJAIjIilklL6KEydN7JOSHweZqoJgJxML3Hs6ziyXeA2trv+tf6kwyAWrPxJYaU9T4VIq18SUrYmhcGDcBmQPK6tU37wM1AXdvOR5TUOupp/tNyi6GhKMwG82xAtU4nPzOHZii4/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721762322; c=relaxed/simple;
	bh=C4KixscV5HqK7gXWNomwL24BIhtihamlg4G6dKhrCzQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ANhv5D/3nfptHPSXnxg48dCo7k7421gNDEmiUFgHRlA/aR0+LaANWQN6UsZKfj19lG7kOwPmXv4xj1JEJSqxJ5/yQQJdxKkgdSOSCESUTt0kbc1IeMiUfaBLQ9BgLdXZSZlp+UOzsagoQnWyY7w2pIVTYoheeAAcJUhM+zLUq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUSw2w9b; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUSw2w9b"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso29664766b.2
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 12:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721762319; x=1722367119; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ehy5/8tJEN9ttSmgFEoZjXY6G4I9WOinFK1xBXmSINo=;
        b=RUSw2w9bWmYC6HUkr7rpxQ72aqP63CGZYAqaA4/1tSWO4G3VCaIaQHzbX1/QdklVQS
         213NlGoV2O9KKWEY1kT2UgN1pHH8wXwI/LcTMdj66xTifz/yWQI2IjNJC/zz35xhYsrF
         8jVRBCPgji0N42fU6HDibvVKD7r8CAAjw1pvV9Hwf66JVwZh0O8etess7qp0op06Y2hq
         BVzMqbOnHq249F7bnTEX3ypQymKxIcQHMtLfhyX6ZwBv3F7RmT2j1QyXv9+dir6y05Ws
         ffnSTukCIOFJraMmVHvNTzavzJ9D8lSYTqZU4hZ51TsM2toMtKlz2mJ4C6XMaGaMyKMV
         pWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721762319; x=1722367119;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ehy5/8tJEN9ttSmgFEoZjXY6G4I9WOinFK1xBXmSINo=;
        b=GARPfGBCOF9t1U2LDExRp6rHN+VMegjaxoTRoT2KYFP/FdQl+hY4Stvt1HdHlNeXGA
         lrJVuYIuEIzRYAIN5kTOjMonjR5CFzDjjbsC5ePkQY1JavU9gi70e2aY3hLUIcPuWPcD
         Hr5RH+ppXuI0k/jCzHDo+zl8/ggUCwt1TCw4BkUAWZJ6uf8PlG+Hq6zvS2iUQLVQ3CrM
         ffoksdi4zS/R2B0izIBan09tbJ0FcCrlyf0moR6lvwbO4hoHgbr1cbP0/G2gI2PI7y0a
         7ZEPhZqIiNwSn4RxPxN19ZiDX2YegKbgr9J/6nMw2IcH1Z+2oTIWZYQllO4EyKlfb/zP
         S7FA==
X-Gm-Message-State: AOJu0Yy6o4pWXeo8T87Fvt1bBl6KZv9Gb9dhR5M+M7mg7UMln1kjo7yt
	15TzieWN22KMkzRjiFpswqWHSkkyClGD+64w4NB+aBQcfUWd/SZhlwnymQ==
X-Google-Smtp-Source: AGHT+IGwseeqliE2hPNTRRKaZWPZSyreSSXnMVfPNOIJ4kYy+GVVBcB+tU9O1lziTI6VvCY3DP3p/g==
X-Received: by 2002:a17:907:d18:b0:a72:8c15:c73e with SMTP id a640c23a62f3a-a7a4c2a32famr685297766b.55.1721762318694;
        Tue, 23 Jul 2024 12:18:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c9230bdsm576194166b.176.2024.07.23.12.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 12:18:37 -0700 (PDT)
Message-Id: <f241c3ae1e405c04c51d8853b9415f428b06c535.1721762306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Jul 2024 19:18:26 +0000
Subject: [PATCH 8/8] git-prompt: support custom 0-width PS1 markers
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
Cc: Avi Halachmi <avihpit@yahoo.com>,
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
index 5787eca28db..60df5cb94fe 100644
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
@@ -314,8 +319,8 @@ __git_ps1_colorize_gitstring ()
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
