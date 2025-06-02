Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709042C325A
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748897441; cv=none; b=Dm3JLy5t7o8QxvdZFuKe54ggMUq6mm7077sD9HVqgCBmcddwCQXmZE2T18z7+1f5KB692J8zvCdoibbXZmkhwxQN5gJp2oY+5KWU9cns4ezS8+5DiaQ9zBH6DadDjYgZrcMFBMqhGlmDTFam4/8AywMItok00Pt0vxhtqqAedA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748897441; c=relaxed/simple;
	bh=SPsTUZ4ZBevZT0DlVUWDPypFKNVbCJG+jMpkO42/psM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KcbDdDfsXQJNjKBGO1lVoMssWn9lm1VIJID93UmHdIS9DcM3xgmM9HAeJuQLMhyEGSFUCWpngTTb0ZBpZszZxrkKpx1Hy3lamzJNGc42KNeGekmqZg82uLgH9I0p9KtmwOiBY06DmZlVZA3SzEhezZFE9IHwACcegq0vcTUzOHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhTEfz7l; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhTEfz7l"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86f9c719d63so916373241.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 13:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748897438; x=1749502238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb0DzIQt8gdXoJBqPler848XL7oag0xgHVO1ZYEzNKg=;
        b=RhTEfz7lJD6l5nWJ1DLCQumJnLkzvfwbuQ50MWoWeOSF+e4jMGPavGUZk/Yuu9vWtA
         S1hfeUyQDkrp2SDuRRjrIZ39BmFshmnKXA3slOCNWnJE5NzJQXw+o5kEN2wBqwLwvcXs
         aVTh3uM7UfS8Gsr1WachFgG4qHFx/8LpUwByepiRFrCcMdF9g1AULUGvSxaK+sTMBnwf
         9p/v7W7hUSzODkexVuTA5MKneYf+gFIgZWufB6Lvmb71YEsEjFcNkO8lBob0LEzaUmL/
         TBR2RDkxrB9aCxeFmJZdHKNWMKk9rKF+DAxIMaHqUPJ1O5Rn4ijROJrstMUfVoBqCNCq
         JEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748897438; x=1749502238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gb0DzIQt8gdXoJBqPler848XL7oag0xgHVO1ZYEzNKg=;
        b=KNAWQTP5Fm7F0AQCw8gtJRCB9/tePvOb3rSH02SnBzERqTonh6gXhj/RGvkD7xoO5T
         vGHy8VzIx+YBMe4ilALnM00qi88jLhQ4dzTlxxtd9TUWzuD62+77KKNtgEJUPHaG+rZ0
         rg1XRePjr2eQ1pvzsx+uYtj9/yxfmZ+oK5upmLbuQgMfq3Sm+lCEnbmgd658IoaMV4cA
         3y6ZoEHWtbXxqsmbI2UznlFOBDVWK0K7LwDwqZu/IuMXuwSYS9oqsBhP6JY2KFosY0Z3
         NQ8pQM56+UYYzkfBqxX4naUYDyqdlyAX818RgY1L3tabyhnL+BAUBDKb6U2a82CQ/xWZ
         DLmQ==
X-Gm-Message-State: AOJu0YyNBbTJAZ1qQBYc0Bo8G70wLmBfNGwOWbse0KOM9x1NDy1oUlVG
	IoVYWmoQF0mpdBKSy+fYIPX0OITU+54bqLPlwy2fOl3sDjCdNgfCSl43ClIZfg==
X-Gm-Gg: ASbGncv8mqA5HURa6H9TQb95pXm0ys5lZLaTcQ0dB9VjLd71tL/S/zIccVndOInjWWn
	1z2OTjuOoUugOYghPP8cLWY1j9wfzBsWIh9MfyqU1Uji1u4iaPT+4Wyq28o+FQ3LYg+YdM6V+j1
	h3gLMiLIAzvxUM4i0/dQ7wR0pfvvnn2csXzIeptlqaFIiC60kIAOcLtKSzFMXLgkpWlQCMUMx3q
	omSGx9P8S66Ye/VgNrIQaL2eXo4tUhDJwSd7bNok/igH82+EpZBiXSq+RYIoBr0Ki7w9bPH6bnI
	mJ/bfJsVDEu55SzsPqnalisih+/clHCWgj3iW6I3DZ+0rVhU1yh7VFdlxA2DUO8vmHJ8UlaHc8X
	heIUttrcFQyCvujCJJQ7W
X-Google-Smtp-Source: AGHT+IHC6JqjpACWsQBRenDr3YnQEqem5t9BK6Rj5Wf/4yHEf5zqDV+S4Agmy4HcATPiq2jjtOUL5w==
X-Received: by 2002:a05:6102:1621:b0:4df:8f03:12ca with SMTP id ada2fe7eead31-4e701cb1808mr7024958137.21.1748897437855;
        Mon, 02 Jun 2025 13:50:37 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:58:c47c:a673:bf76:10ce])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e2a2a1622sm6746409241.10.2025.06.02.13.50.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Jun 2025 13:50:37 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v2 2/2] MyFirstContribution: add walken.c to meson.build
Date: Mon,  2 Jun 2025 17:50:21 -0300
Message-Id: <20250602205021.4223-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250602205021.4223-1-lucasseikioshiro@gmail.com>
References: <20250529192036.75408-1-lucasseikioshiro@gmail.com>
 <20250602205021.4223-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instruct in the documentation to also add an entry in meson.build for
builtin/walken.c, as currently both Meson and Make are supported.

Helped-by: Karthik Nayak <karthik.188@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/MyFirstObjectWalk.adoc | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/MyFirstObjectWalk.adoc b/Documentation/MyFirstObjectWalk.adoc
index a4ba6e21ec..413a9fdb05 100644
--- a/Documentation/MyFirstObjectWalk.adoc
+++ b/Documentation/MyFirstObjectWalk.adoc
@@ -96,10 +96,23 @@ maintaining alphabetical ordering:
 { "walken", cmd_walken, RUN_SETUP },
 ----
 
-Add it to the `Makefile` near the line for `builtin/worktree.o`:
+Add an entry for the new command in the both the Make and Meson build system,
+before the entry for `worktree`:
 
+- In the `Makefile`:
 ----
+...
 BUILTIN_OBJS += builtin/walken.o
+...
+----
+
+- In the `meson.build` file:
+----
+builtin_sources = [
+   ...
+  'builtin/walken.c',
+   ...
+]
 ----
 
 Build and test out your command, without forgetting to ensure the `DEVELOPER`
-- 
2.39.5 (Apple Git-154)

