Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FC9366DCC
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989132; cv=none; b=tb5UYYltpzCYF8TYjuIqLswJ7KAB0lXnc1g1U6LPgrvxUYQpzmn2YYzhAJcPjbHx6TgF0Z3mqB9Q07UrDj/P41a5wbJU6yRel4tIkRLPavuqSwSNeYrUr4BabXDHeFcnrFxorMob/VB6qyxeuixAt3RQ6WDEsLvkm2SHKh086kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989132; c=relaxed/simple;
	bh=hRI4MoIbPK5hjtOrFpsiFUOBgNFgUuQgvSzrz+qq7nU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lYCBJV20nSm6H9jRcg6gjZwr1pCakN+4+18Utr8pjIKES1X0aQqse8uHBZStFLKwh9U6v5qgRF0WzikRHz0E0ctNXZ305mI7Ag24rbYZbvko1xK9u2x15osq+Hw0D2iDWuCY2h7WOMPQhVwfJ9KT3cTHzEytp7/O/lQXO6JxglM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOaD/EY+; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOaD/EY+"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-88a367a1dbbso73372346d6.0
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989127; x=1768593927; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G7RAFoOPU86bZj0aDhfKLT2X7BwUZV//AxWSsWgqHI=;
        b=DOaD/EY+FnKlrHbe8+zjRcK0ZvIC226cIKRutCKQpc70vBnPF87+ZUEIsiNkjDEJIR
         +5o7LpdARYRSHrw/IT6LTl6KY2WXe2hmvCbjzzHQaWkZGDedtTYRp1JLMJnb6+e0MyKO
         Qtssu3r9JmPnGUsBlN07zuuC0MSy04+u6vR5OMmqk3e7in56SAKMSNl3tX/j4WTNXqAB
         ZFSKzEmKz4gcIAZxLk4aHp73grGEgs5ZVRNnaaiMYjNTSkKy+9gSz0mBVm017voYn9aj
         KSDIekAivRD8iUJ1yZzn1E+416HktJ1iggUEvRT4Nz7jvUKxOkaKTMf+qN1FBskT5kFw
         SAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989127; x=1768593927;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0G7RAFoOPU86bZj0aDhfKLT2X7BwUZV//AxWSsWgqHI=;
        b=ee+HlhRC7MDvpR07UnvHqL3i2lIp92D/iiuOfGkMtH+gGLOKtG6opkLR+cZvkJ6+Gf
         XCX5c2ruDVTWKw5uS2y3oY1OmtKyh+W+jerekL3FZjIpVEvRmnwmO8OoO3beeabBruF+
         oTKm6Goyzw0k7zfAlYdeD5HT31HrWxX5yLQPwlyzFGKgpZtv6hK7fJqaJfXYv20LlMbA
         E2X0C1Gah6zgYyabpOKZoJRB3kuJkvdciQ/PoNUCdVNvn1wfzwmPk11XWMf18aOKxhmO
         hKL9z8a4r0jYjsPFKkW1eRt1YADd6pPR75OdLiO0ftH4VTxzI2FOzW5utxldCwur+KgL
         W44g==
X-Gm-Message-State: AOJu0Yz7E9JOrIyyeu0k6W/G4ofYv9PNRHQLy0Nh41V3Q8+mSAO0RzLX
	JcgJp2d7odD8KNXQU25BWYpScRATGSxij6nd+xs/o7zMe4Ki4oSk+QU26yBmzoGe
X-Gm-Gg: AY/fxX4N1jM/bYBWvcz1YZRvQaITCL45rY6VsCEXqROgYuJ82dbCU9efebE+WB+jxm/
	jX0NYq6nIC0e2eRPeCCdNhFNSr4eJS+/73gYHskyRE0iBDr+/XbMw9/n4/mh/5n59ANjktcDzl1
	PSgpLg1vlUlCkTfWeq3JBXCfJhp2TEu14dbUjGFf9XC2AmMUYG0TaC5mY8PZtHgbRmrt5SSqej2
	JwN+ybUd3aLZgUabAZ4hLChZ4pshkI65J6jiKd7McU3JZPSsuSlBi2V4468cdE5sNGDs5u7XUDW
	8Ct4Nn2IaRpMfLlq3VgRnJSJ+X3n803/ebzjdAOEAGQBVevkzG7mIUpt44ST3WRlmkCObWIwe/k
	u8Y7uiMRwA4HgqavQvNUihsMHo+b5YQ2AIVzxA9S7lIcZyu3NPtA1XtzsMXqt8NZ36eQKTISQZD
	4C2lZ3JfB3XymD
X-Google-Smtp-Source: AGHT+IGjU36ei3RTyVVuvnEpuk1nQOl3982G8nt4bfmLEckZed21xfRjdt9nYqKmJZqjwhJ18WsSUg==
X-Received: by 2002:a05:6214:428d:b0:87b:f369:35d2 with SMTP id 6a1803df08f44-8908424f2cemr154158936d6.39.1767989126826;
        Fri, 09 Jan 2026 12:05:26 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907726f1f1sm81120676d6.52.2026.01.09.12.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:26 -0800 (PST)
Message-Id: <86c07427485f6c73904fe1b637fa262468a38125.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:05 +0000
Subject: [PATCH v2 08/18] mingw: change default of `core.symlinks` to false
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Karsten Blees <karsten.blees@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Karsten Blees <karsten.blees@gmail.com>

From: Karsten Blees <karsten.blees@gmail.com>

Symlinks on Windows don't work the same way as on Unix systems. For
example, there are different types of symlinks for directories and
files, and unless using a recent-ish Windows version in Developer Mode,
creating symlinks requires administrative privileges.

By default, disable symlink support on Windows. That is, users
explicitly have to enable it with `git config [--system|--global]
core.symlinks true`; For convenience, `git init` (and `git clone`)
will perform a test whether the current setup allows creating symlinks
and will configure that setting in the repository config.

The test suite ignores system / global config files. Allow
testing *with* symlink support by checking if native symlinks are
enabled in MSYS2 (via setting the special environment variable
`MSYS=winsymlinks:nativestrict` to ask the MSYS2 runtime to enable
creating symlinks).

Note: This assumes that Git's test suite is run in MSYS2's Bash, which
is true for the time being (an experiment to switch to BusyBox-w32
failed due to the experimental nature of BusyBox-w32).

Signed-off-by: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 26e64c6a5a..0fe00a5b70 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2862,6 +2862,15 @@ static void setup_windows_environment(void)
 		if (!tmp && (tmp = getenv("USERPROFILE")))
 			setenv("HOME", tmp, 1);
 	}
+
+	/*
+	 * Change 'core.symlinks' default to false, unless native symlinks are
+	 * enabled in MSys2 (via 'MSYS=winsymlinks:nativestrict'). Thus we can
+	 * run the test suite (which doesn't obey config files) with or without
+	 * symlink support.
+	 */
+	if (!(tmp = getenv("MSYS")) || !strstr(tmp, "winsymlinks:nativestrict"))
+		has_symlinks = 0;
 }
 
 static void get_current_user_sid(PSID *sid, HANDLE *linked_token)
-- 
gitgitgadget

