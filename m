Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D85B3AEF4E
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521192; cv=none; b=bcNwS3I3Kg6Y7mOhqTOrH/aiK5RN+FDFJz3apScvZXzM0Pi7Xup/8WnF1jjdSWcTuZHRYKtf3rynIkwI+BozzXQUL97kvd9UMZh6SQ91Rkd2BVCrH+VNrahrFvwOV36Zv3FYjtoRK3NzVZnyhjjF2OvZq0Rid1oRx/23d4cAEpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521192; c=relaxed/simple;
	bh=Wb0z0ScONlBnC2myqKjPXPkp8TZ2zjW/gBlQDKwyE+E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=K2UyWmVireRpd1x2wapJ95cp+tDIpNwm6P0uc84dnkHO8LylWfFkuukqrrjEyp2eh0bZClj3qvsFEq7J3QonGntlPCoUT7OZHDTCKqbLJwfIlXTFWcsdwIuZ68gD/AFK2eaBQQ65HwLNf0oSfnmksyhzumU4rCOM1TtAs0naXeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssqTCLyL; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssqTCLyL"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so825230a91.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 00:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521190; x=1787125990; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wp5NKYlxEj5uoYdkzvpvhMd8uALMSstbiZSfAcu3H5o=;
        b=ssqTCLyLU8+Bp7SxVEumBuObmt/O9OoHZYiTOungsYyaiiqnNTCWNFGbTIYJrynn3u
         F8PBRU0WNw0oATwhCl2sJPFD+jY7OWAIw54lN4TfIXpxOP5ssLp0/tbh8JRLZZhHMRk9
         /C9LssFV50Yu0DMZnXfOGOh4kwP2SBbRaGMLXiHh1tpybRQKVyPGA8jLZz168yqLaRDp
         ARD+C6azrSHa+DahLEBqAmp5yPwWsOhkkQh+Ug1ufolGp4PwVY3st4rmZJx+rb+Wx/1Z
         ns0YCRU/yGPHWDHfzdCcSB4vlzUOPQkq/YeZAzPZnAoKSELlo/IsDmtAOiyniwU3fFbD
         JgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521190; x=1787125990;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wp5NKYlxEj5uoYdkzvpvhMd8uALMSstbiZSfAcu3H5o=;
        b=kSDIftJZX3Rg5DSFKKO1RntgCZ/3xi6yeK2NIZj1cL6/eWOS6LePQT148A3If4y/za
         50LgL+tmOFnTDdj1OrFWKizw6XD3wydkBle3zyrqId7D1qq2QcDg0cEg1COCE0puphnz
         Hdu27XmpP7lp289wsV7NMfRti8LjHLUmpBH7hqfOCu4qYhIai5+BxNyV2n4mhUN/MfQu
         x+GuNoenin9dxtM2lUOpzIpyNsC+4bXeE6iNoxZ+YGLRTjOogzeX/22h+0eWY+XJX9jq
         5DWFhKmNgcVE8sFw7RZXzA1kRxmt0p9UFjGsQ7ls2t+xBczwx8nyfRc8hyoJzeAk/faI
         fB9g==
X-Gm-Message-State: AOJu0Yye/kFtFa02ZOsl2fioFnTMdRSBh0NMg3+ZD1kgtPrEv2blbnfi
	3+xgQ45PEAEbtjTl6Vqelj0+g0z95bzugAIw9fQCEK62uuK51xpJY3bHa5WsKQ==
X-Gm-Gg: AR+sD11varhvlKOSkNKm1mss//abxtsII6WxY8KhQLvuQh5b7qtO2plNIfzNNOiyCCz
	qq12o6axaT4VWMeNyiLb6SIUq9VDFia8nGy9Qqkx9M0y7KZ99u+vEwSF3ZOSss20Oe717MREgvs
	7rrcc4Bo9XVh4bpqQ0Y0s+bBJs45O0Rb+RnNQK+uCahPv0jQLm0RpcTyO64jlQiZdg6ROEjRWK/
	1id+phgQHbHlrLB7N7o6AbFJPWl9C3tCXuz0/KVgVH0NYkKJpEsbtTZBgttygeHyCkXV4x0B50Y
	5yZ6m77JjpmO200lly4ucOVH3ejCZv+lCtCVmxF+zdSC3x5xugj2piAXRxVSAGUUau3cP7AYfzH
	/yDDmiwoOX/7tCHshejECLKivXqkojOAR3amQa7JZ+G/ffty5OhnUMAuxtnfKwlOiyFvdo547sB
	P8YVaZc+mXFp0uWmDGvINVBPlCedxuJ0djsd1V7x74wx7hKxP9NO5xALAJ+9iGV7YO
X-Received: by 2002:a17:90b:1dc6:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-393013c4248mr4105894a91.2.1786521190324;
        Wed, 12 Aug 2026 00:53:10 -0700 (PDT)
Received: from [127.0.0.1] ([20.184.150.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f935f73csm2527648a91.6.2026.08.12.00.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 00:53:08 -0700 (PDT)
Message-Id: <60a2999b75a921fcdfd14a7f04dc288c79e56638.1786521173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v2.git.1786521173.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 07:52:49 +0000
Subject: [PATCH v2 09/12] windows: skip linking `git-<command>` for built-ins
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is merely a historical wart that, say, `git-commit` exists in the
`libexec/git-core/` directory, a tribute to the original idea to let Git
be essentially a bunch of Unix shell scripts revolving around very few
"plumbing" (AKA low-level) commands.

Git has evolved a lot from there. These days, most of Git's
functionality is contained within the `git` executable, in the form of
"built-in" commands.

To accommodate for scripts that use the "dashed" form of Git commands,
even today, Git provides hard-links that make the `git` executable
available as, say, `git-commit`, just in case that an old script has not
been updated to invoke `git commit`.

Those hard-links do not come cheap: they take about half a minute for
every build of Git on Windows, they are mistaken for taking up huge
amounts of space by some Windows Explorer versions that do not
understand hard-links, and therefore many a "bug" report had to be
addressed.

The "dashed form" has been officially deprecated in Git version 1.5.4,
which was released on February 2nd, 2008, i.e. a very long time ago.
This deprecation was never finalized by skipping these hard-links, but
we can start the process now, in Git for Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config.mak.uname b/config.mak.uname
index 3a90995587..88bbe1d78f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -518,6 +518,7 @@ ifeq ($(uname_S),Windows)
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	NATIVE_CRLF = YesPlease
 	DEFAULT_HELP_FORMAT = html
+	SKIP_DASHED_BUILT_INS = YabbaDabbaDoo
 ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
 	# Move system config into top-level /etc/
 	ETC_GITCONFIG = ../etc/gitconfig
@@ -710,6 +711,7 @@ ifeq ($(uname_S),MINGW)
 	FSMONITOR_DAEMON_BACKEND = win32
 	FSMONITOR_OS_SETTINGS = win32
 
+	SKIP_DASHED_BUILT_INS = YabbaDabbaDoo
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
-- 
gitgitgadget

