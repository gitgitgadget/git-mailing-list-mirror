Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F85F1A08A6
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256787; cv=none; b=grcj+WMRnFpM8XxKOEtVEd3w4ql+p7WjcWg5XcsU53CqezKw30Xvs8mNjKHBWTrjqLxlUvKz0KRvYwI/BBeUlHTWReUhao6QqkICNjbSDaaikWwHQU7UZ4r9qk44T4JvKDv85evwsr3qZNG+ZTANXqxO3EYNX+1H4CZotm+GoZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256787; c=relaxed/simple;
	bh=sBXlGnl3YiPDVj/7H6m5lyGneW9o3oghfDsYkvyY6MI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I64OOHTKGscOVmpUVumwjAXaAZsowBD+aHJ8AJ+twsyZNif0/dP+pIe7PM9aEygOJwEZGhbDTManiMAvEFULJFrW5GyOMghVR3mJ/3V/GK2htNNYoXtts7O4drkUi4gNFrjrjIsIETW8fnXA4dq+ipn7Stcj1pitHnu14l7+qz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeSOpNHD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeSOpNHD"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abf4802b242so96355666b.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 02:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741256783; x=1741861583; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgs3VXcVUBh0msV7ZKlvolwa9jpOD/UhNH+Fgco2h0U=;
        b=FeSOpNHD0ewRZnU3lyAsPxs/+lnWcHYuomCPMhduebXjnfg1HklILkAfmWA+nxuXDy
         ySnoSw1kUGhecbxdVmMHUr5OVoy3joEMEKL2/9IHBK6O+1V9TzkrohPjIX3nzG15fvWV
         7bD1Y65BqihFCaZuy+RDGuI3v4NCSyp5INIsSe2GttnDhvqRPhmnM1K1bIuUvWb0VEpP
         DjZbXZ9HDiDzIF0gHvtdOcoeqSvooFmPBeFmGmNQH2ZmZQhiBN4D8/edM7O+aRCzZAAe
         aY7R0QyLfC74cKKwW7NJPcaDxnzgVYzDKWZORuR+ENO/GWYYl+dB86qtuBeGlKJfePrE
         4WGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741256783; x=1741861583;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgs3VXcVUBh0msV7ZKlvolwa9jpOD/UhNH+Fgco2h0U=;
        b=B4kM0geMr1JQOoCNWw+kFT466u3kymxmD+aGDOkUbteTXhMvoh2sYw1AeA2Iu0hcUI
         X+KkMQt9JemdLVRa7PoXjNYVnMGiTpWmskwvR4F9bk+g7/AHV5cCA3Zx2yCkeJjqiBrL
         PDujaYclZ4Avpj+aPsCKeTJn5DbqalMMQfXU9VQFmcr65wySA+P5lGBUgS8vVXChsCeT
         vDGOqwtugZk4w/oZouYWVYtMYHQCsViHlun4ssAaYqjB0eYBpz4/rUIpuaT3VNPtB/Xc
         gak2gBcZyQsVXjxkefuOkU8fdFPFtj24FJBxNRognliakBxcAKS1w3/1zImrV5NuwKUl
         Pr9g==
X-Gm-Message-State: AOJu0Yx8DOXWeNxKHiMKsZzBnfnW6FVEIm8awskM017T1+3tjvutYcGG
	Z97IjXxOhdM8xT6giNcrfGLVFFtHcFukYQYxvoJsZOHBnjAXVTISzq1nvQ==
X-Gm-Gg: ASbGnctcDPAKwjKNqRUpogsFuhr/zQ7f24O7gATaVK0pTUui5IMLYUHcrmtBpv2Jb+y
	QZFp+qeHVnijX4qbBue4dhyPNrrbITxfBueahgI45zbKjxCm3FlOnoNglypzzQBMgPiOk6zhNRk
	ZK4uhfYemAM5NsNiBtEXGWWXMhZYnFU9sJQGOV6oZosCyoBc5F41SsbS/S3Pcpo+9U51OW6NytJ
	OSOct4jaxBXyHiOUephLbRXHoajb2LnMCRFPOPvsH1EJ3dbl/NlSind1K1guz50/pAXAwwxabtN
	8h+xcC2uRtJZt3VQYxsiXdxKwj4eSVH+BR/Rs5GFJQzGxw==
X-Google-Smtp-Source: AGHT+IH7C7cQcfwTHYvN1Sf7x1cCQ2z1ZUvCo5hKgY47PMw0zOZU1pXtTSUgQtZCXcB63/ti5X6Ggw==
X-Received: by 2002:a17:907:9494:b0:ac1:f002:d840 with SMTP id a640c23a62f3a-ac20da862d9mr785174166b.45.1741256783013;
        Thu, 06 Mar 2025 02:26:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988e740sm70361566b.157.2025.03.06.02.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:26:22 -0800 (PST)
Message-Id: <3e9ccffc7474698947bdcb6d49b5d0728deadd08.1741256780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1867.v2.git.1741256780.gitgitgadget@gmail.com>
References: <pull.1867.git.1740671049.gitgitgadget@gmail.com>
	<pull.1867.v2.git.1741256780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Mar 2025 10:26:18 +0000
Subject: [PATCH v2 1/3] ident: stop assuming that `gw_gecos` is writable
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 590e081dea7c (ident: add NO_GECOS_IN_PWENT for systems without
pw_gecos in struct passwd, 2011-05-19), code was introduced to iterate
over the `gw_gecos` field; The loop variable is of type `char *`, which
assumes that `gw_gecos` is writable.

However, it is not necessarily writable (and it is a bad idea to have it
writable in the first place), so let's switch the loop variable type to
`const char *`.

This is not a new problem, but what is new is the Meson build. While it
does not trigger in CI builds, imitating the commands of
`ci/run-build-and-tests.sh` in a regular Git for Windows SDK (`meson
setup build . --fatal-meson-warnings --warnlevel 2 --werror --wrap-mode
nofallback -Dfuzzers=true` followed by `meson compile -C build --`
results in this beautiful error:

  "cc" [...] -o libgit.a.p/ident.c.obj "-c" ../ident.c
  ../ident.c: In function 'copy_gecos':
  ../ident.c:68:18: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
     68 |         for (src = get_gecos(w); *src && *src != ','; src++) {
        |                  ^
  cc1.exe: all warnings being treated as errors

Now, why does this not trigger in CI? The answer is as simple as it is
puzzling: The `win+Meson` job completely side-steps Git for Windows'
development environment, opting instead to use the GCC that is on the
`PATH` in GitHub-hosted `windows-latest` runners. That GCC is pinned to
v12.2.0 and targets the UCRT (unlikely to change any time soon, see
https://github.com/actions/runner-images/blob/win25/20250303.1/images/windows/toolsets/toolset-2022.json#L132-L141).
That is in stark contrast to Git for Windows, which uses GCC v14.2.0 and
targets MSVCRT. Git for Windows' `Makefile`-based build also obviously
uses different compiler flags, otherwise this compile error would have
had plenty of opportunity in almost 14 years to surface.

In other words, contrary to my expectations, the `win+Meson` job is
ill-equipped to replace the `win build` job because it exercises a
completely different tool version/compiler flags vector than what Git
for Windows needs.

Nevertheless, there is currently this huge push, including breaking
changes after -rc1 and all, for switching to Meson. Therefore, we need
to make it work, somehow, even in Git for Windows' SDK, hence this
patch, at this point in time.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ident.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ident.c b/ident.c
index caf41fb2a98..967895d8850 100644
--- a/ident.c
+++ b/ident.c
@@ -59,7 +59,7 @@ static struct passwd *xgetpwuid_self(int *is_bogus)
 
 static void copy_gecos(const struct passwd *w, struct strbuf *name)
 {
-	char *src;
+	const char *src;
 
 	/* Traditionally GECOS field had office phone numbers etc, separated
 	 * with commas.  Also & stands for capitalized form of the login name.
-- 
gitgitgadget

