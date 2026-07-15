Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A18306752
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149329; cv=none; b=snumSviSOPiKBLa4ql6hZpySZYZwIEZTZy60SqiuX7H/vY9qDPVDVLYjRhNA7K3p3kP5sHlAvivBSFhua79tUAnsUajfl2tXl9NopQZUfhCU+m9e9Ie8Z9zmTovYRC7+OL/NgD9UFtlSmC/ibkym7vGx6M2jvcKIADEXaBVbKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149329; c=relaxed/simple;
	bh=QtdmL+gWbDnszPFL3rdQ7vT5v8e8YiJzIiPdXEiKV+E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GGb5Kcxvf01NCiC6tTVPpgX5gjGA6KUdqMRXp8j1xOp/tlMEzEMskTY2YbINbUfT5MopTRRdgyzq6B705CSd/Dv2+IlAy2J31gz634JxdZ+M4Hzw3cxs/Jx0hX29lTmWqp6XiQNH70KvB1ATDZRq/S9818YgKod2WO9EtFoqUcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yuv4bxJT; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yuv4bxJT"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-90327237340so18653616d6.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 14:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784149327; x=1784754127; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TE7tDKBkdwisr1c9mLpYjFAaDuwy96fYtPG8oo1KLmg=;
        b=Yuv4bxJTGqsxFy7RIWP/LNqHKymny8EXrDP12CKch6+B/kI7kFO6b3T9dKFCUInPnG
         VO4f7RwmiYahdEoddJKUpLMt3C3ScbpdtCukIZbNyGVQwGfvDMwCWlsA2uTVLb1W2lZ4
         A6RWHWhiEpdEe8NiBq4GCY3a016OANYcD0sBWoipRBugDCwYSh5Uov6RzI/xjm4ArURm
         dvXNLZXzxYxE7J+YGIfUHdOM5p26lNba3UZh+L6TLYgo1N1L0DL+nr9QMEW8ZWiT1txC
         uupXFDYx3I1D3Mh0Y+c71hVm9bUTAES6XosQ+/VfPrTPH1cwm1WPV73+d+VPZyg9ggGl
         NjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784149327; x=1784754127;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TE7tDKBkdwisr1c9mLpYjFAaDuwy96fYtPG8oo1KLmg=;
        b=qeJEkQmIWdZ0HGtcvzDtEGKExP0sskQSFW97pdTpCp0TYdctqkEJGlTFItN5n4DjXW
         Shz2xGBg3OJKFJYPcHoK6ZS1OPxMw4uo9SjgpH5aY+XXzBBNLTr0RjzaFiVMkOMVeJjV
         SqYc8yBxOEjDYDhVZl6waTnWSE4qEUTiHB6nGw0rs2xwwofdrF8WXsVoBAQ4b1TVu99D
         IbkAHB4qxnaA9KD74Zg9v1CW+4O+eArgqdkdf3W50GWauVsj0CInPweimDARU/LsZH5u
         CXKL8617/wX38bfEwpeyLk3ZQ35unXq2rDGJA8Spo4H41iQG1EL/WGaWOPlmPUTUguAP
         fJwA==
X-Gm-Message-State: AOJu0YzTFq+tZ4pcJw6LIArI8QZtZJDfzcj7Zj4PSIGo/+tcq2dUJCXq
	R1eFZYkuhUQectQSa4P/6I+56HyOgKCB561/eRA3ljdJmWzgt5/t0mM+QWMI7A==
X-Gm-Gg: AfdE7clmZEi46yKzenE8dLtC6vmdCfd7OjXmMcXFdANllCVVRN+5KEgm9kUS67HJ+DG
	MRZ427Ci53zzU5s3vocHbK5cVe4xKn8rxPh9SKrflTUd8CI2Cdr4FqsEeSyqh65qOf9DV9PMP2R
	JsJZVWx49tbRpu/IuPGEJGr3s/nT5iSTxxYJb9ZChgaCgKHJdZi6HHyBCaNxQsxni3DVuqG8g10
	/9cdTnqoPPu1vzOHnDyQ5djQFUEZdBCTvE1wnVkH7tpbgZpQ65dTiBUziwjpDzGIQ0ZEdCCT6RP
	0OQBREhYO6K+lL5MSEzLI0FJQp/TsY+//DbbrCmLcdnwWITMpnxSXvFMHfUqG6+IVg6NGA/mtJc
	lyrPpXuPXsasNbRRQbN/ykAK+D/Lp6lNCGp6NHhAoeXVC2iDgRCIJrhxXYJkQ1ULCQ5MAcKw4wc
	karmlSFw==
X-Received: by 2002:a05:6214:3384:b0:8ef:2d29:699 with SMTP id 6a1803df08f44-907653c9d2dmr13582676d6.12.1784149326912;
        Wed, 15 Jul 2026 14:02:06 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.193.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-902de1fdb3bsm177210456d6.23.2026.07.15.14.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:02:06 -0700 (PDT)
Message-Id: <0fd994a3d3c7b226d0c63124133268f65a2eb339.1784149323.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
References: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
	<pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jul 2026 21:01:54 +0000
Subject: [PATCH v5 1/9] gitattributes: document how external diff drivers
 relate to diff features
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
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

The "Defining an external diff driver" section explains how to
configure diff.<driver>.command but not how the driver relates to the
rest of Git's diff machinery.  In particular, the command only
replaces the textual patch: word diff, function context, color, and
the like cannot apply to its output, while the summary formats, blame,
and git log -L do not run it at all and keep using the builtin diff.

Spell this out so the scope of an external diff driver is clear.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/gitattributes.adoc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index bd76167a45..2c4fbfd7f1 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -784,6 +784,16 @@ with the above configuration, i.e. `j-c-diff`, with 7
 parameters, just like `GIT_EXTERNAL_DIFF` program is called.
 See linkgit:git[1] for details.
 
+An external diff driver replaces the patch Git would otherwise
+produce for the path: Git runs the command and shows its output in
+place of its own.  Output features that post-process Git's diff do
+not apply to it; word diff, function context (`-W`), `--color-moved`,
+and coloring all act on Git's builtin diff, not the driver's output.
+The driver is consulted only when Git generates a textual patch.  The
+summary formats (`--stat`, `--numstat`, `--shortstat`, and
+`--dirstat`), `git blame`, and `git log -L` do not run it and
+continue to use Git's builtin diff.
+
 If the program is able to ignore certain changes (similar to
 `git diff --ignore-space-change`), then also set the option
 `trustExitCode` to true.  It is then expected to return exit code 1 if
-- 
gitgitgadget

