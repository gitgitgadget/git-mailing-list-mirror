Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B7223312D
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595263; cv=none; b=SQkwHuoDFRjqCMjddWD4cET3fY1IXmvMfts5e1eQ33gdqNzndNNNu9y4zaI3J0olgxAT/DRmpeiI1D6sYwfaY/e987PvKDwxaYznlYywjrSQltKsOi0tStfAJliuyskQO1kauuo04AbK+8Uq8cvOexlTP6il4ZZ/BjfOr29IRR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595263; c=relaxed/simple;
	bh=ETecl+UdDj1OOsvYoQNIAWQidEPB5s3z94BMhToIy8A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZlcD/TOOu6DqIDJ7yXqAc6PHMxzRvbYf+kjJozvyf8u9NCeHlFH5b5O044ogVld0DO9TPNbjVqUcjgs8rM7jPxe9R4+y5zX+HuS+DCbhsdARgw0vp3GMFlL/3R0gAsFKjweOuxkKwEpSfOL/911XZRqR7TaKarIDpTI+oYhK154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oe9pnLCj; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oe9pnLCj"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-601e231e8d2so1484108eaf.3
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 15:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742595260; x=1743200060; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TsLjmM+cZHdukY3VI/Tt/97n2gAmHQgX0ISkWP9p+u0=;
        b=Oe9pnLCj5h2Pf95ga9uNqdOak6HNZM1zZkkZv1Jh4eFnP9XXPHj9qTlS0JaUr5ZnmL
         3FmTXDn7HF6d1Y7v34WBmKja0/iGb98Yrcgc5Fw33eeUKzSUWVL3JbM/QF40deD1Ebw3
         hz9gO9R6OqdaDBRgVOO1IefOzVTM7CQvNrSjy12j9Mc8vbNDZZHg9BLy/Zxx7qYHCpbJ
         A8p/4AcljgXFKUN8g9wwsjFWAljuRXw+ZWqVdTPS+O4PPL/QnbP1tGHRyV+oCeDngpv5
         2egIx0pEcocTMb8jgX74Xdeem3DLS54WwYI64sg3PgcKGAvaJon5PzKNQ3TRw/T35p+K
         0h0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595260; x=1743200060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsLjmM+cZHdukY3VI/Tt/97n2gAmHQgX0ISkWP9p+u0=;
        b=HZtdlEyQwoFUdwVABKvQDAVsDrVvSS0elEiWXHl/I0VH/9iaNJEyze5mu05l7plQ6N
         /ZEyVKy3PpR9XNoliRTU71n/k7rBiVzUbdYUYHqDLbL+Vnp+XjRVgUHMB7fyxesUVawD
         x1QvL39TiiIMli1mebCwaz7lWN0qVH62qC6q9wDaVOfHqzk2siBirDyq+mZ2CwtenLJB
         89Xvv0/r672021+7TEujL9o72E3afyT3vQr3tWhw3rnvgyKnV7eXCGaFRWhM4r+lFhzV
         igWi58sE/4cwZmooiWA1oCI6zNWhCawns5uck5ZT78DdWR3yWyOV0dvCAr+vYcdy5/pe
         aDRA==
X-Gm-Message-State: AOJu0Yxw7MAvssa0h2L/nF5Ww9ofz7i0PQCih9RzkhARhaWd+OiRgyM4
	73r2bHGQlRYVmVA0E/fmRHelr/chC2xi68Z1KndVZsL7+/EYcRcqyWLMLQOuxXiNmGSH/T4I7We
	M5OrvQaGm4X6m/DAiXT+alU7zLauTFVSFw3J+EdJ8hPug5UjnNLKR12OOUJ5Ig88AsxwbfTxahF
	lebZYMiu98t5wO1egIeel3C9l73SSSiI6k1fEnPkY=
X-Google-Smtp-Source: AGHT+IG61Gh3dVaQ8m8E+VJ1cbKzNFAo/sJPloLl5SAzhNvbvMvlJDBuL2H7YmDpEAImrZyK7G/+7sFFyBZUtA==
X-Received: from oacpy22.prod.google.com ([2002:a05:6871:e416:b0:2bc:6860:2684])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6871:a58f:b0:2bc:8c86:ea31 with SMTP id 586e51a60fabf-2c7802fff9emr3108785fac.20.1742595260197;
 Fri, 21 Mar 2025 15:14:20 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:14:09 -0700
In-Reply-To: <cover.1742594960.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1742339107.git.josh@steadmon.net> <cover.1742594960.git.steadmon@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <a34e23a83d66feafcd8245419ee3f6681f4c93f3.1742594960.git.steadmon@google.com>
Subject: [PATCH v2 3/5] libgit-sys: parallelize build with Cargo's jobserver
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Cargo provides GNU Make flags that can be used to connect to its jobserver for
managing parallel builds. They are not automatically passed to any `make`
invocations, so let's add that to our build.rs script.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 contrib/libgit-sys/build.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/libgit-sys/build.rs b/contrib/libgit-sys/build.rs
index 19407663f5..1237c9a37f 100644
--- a/contrib/libgit-sys/build.rs
+++ b/contrib/libgit-sys/build.rs
@@ -8,9 +8,11 @@ pub fn main() -> std::io::Result<()> {
     let crate_root = PathBuf::from(env::var_os("CARGO_MANIFEST_DIR").unwrap());
     let git_root = crate_root.join("git-src");
     let dst = PathBuf::from(env::var_os("OUT_DIR").unwrap());
+    let makeflags = env::var_os("CARGO_MAKEFLAGS").unwrap();
 
     let make_output = make_cmd::gnu_make()
         .env("DEVELOPER", "1")
+        .env("MAKEFLAGS", &makeflags)
         .env_remove("PROFILE")
         .current_dir(git_root.clone())
         .args([
-- 
2.49.0.395.g12beb8f557-goog

