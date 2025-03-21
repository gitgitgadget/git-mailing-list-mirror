Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD413233714
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595267; cv=none; b=b8LxIAylpmkmM/oO1z3GRrPRXCnLmSdzTuRdTljXFGOcL2EndKCgGmRl0/7XC9RJfGf+TvFQzzzpzznqzenv12GkYqTpp6r9gp/bwyCoksmbr2YY4S5Y6n28V3ceDNCguOsqmeQKMqbQuEV4Gr4S1+E0SzV/5Rm3BE8P8vcnWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595267; c=relaxed/simple;
	bh=Qi+amG2NLM2o2V2RsVNTYhZmLNUrBhUKdRasfBUlN8w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vx4FCM2YiJ5kUbkJYNhq9YvH0gLRJa8wToFbo9Ro6q4ApKKAA0L4febD0oroBIpMuXz5ksST525b6MGjBwr1IF71TIq7vwXhWE6dkXJJmczMCBVyvibdyEseYxL2yj+tT69voijl8vkA7E03FJf1QnQP8BKNHCaj+stlY1Z+TtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eoSE5y7I; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eoSE5y7I"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2241ae15dcbso44462735ad.0
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 15:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742595264; x=1743200064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NsZqir39Mrn06qV1OENEGcHX2M4YNPQG7AnXRpopEGQ=;
        b=eoSE5y7IrI436CTsD5A9E4GMAnFjDVCIGzekTVCKLBg/h4/6jMSwP6Nos8sNGpEqYO
         FC/DaSIaZscLEF3bOVxrKThuqgHpBA+Nl3EcLaTmWthmNszBjlawUHB4hK/imLKUw6JZ
         fGaSfzNfKVWKapbs6o95vCoa6JfoTUkdtN8anWLo1xIE4ndV0N8nRvCiM+jyhAWKs4hh
         5TpQ4TQi/Z4snp1rfb2dAfdoCjlHXbG5GyCvlE0qYf5V6ktPr1Hkzq8s1FJswrAizv1v
         puiR4+R7vKxANM3M8+FTthUuDBG/JmusV+0NhXTKFOSsZeUlDMyFnW+M7eKX6ZqKT6/H
         JmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742595264; x=1743200064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NsZqir39Mrn06qV1OENEGcHX2M4YNPQG7AnXRpopEGQ=;
        b=e0qHI+kMDpFjBb7UgatFrfofeSqQZ3L/YNRq64/38KVaiWzGdLKRBJFwQI4/9y8vO3
         WR4fh+r8n8neHxzZ/QXAy2UYkQ5jx+Tz83mqpdRi59AxY5d+TeiyyUcs/sHmk7syTYeo
         J98BR8eHfZdYt1vLTYYPdYQKFIJvJI/b5E3WYVvolAx8OQtjxeVgBcD7LcxS5GEAgGgL
         0k3nZrPFupP5udWL1o/Z92cFym49Aw0REil7OeB3k1jg8jjZvgpQH4aIIfHbQTm8/JKH
         tlQ0F2cPmZk5oJ+xScbYb/7TwLzOr4JRTnWTjOPC9LcRbb9AYjPDhvBqjXS5kvlgvbns
         /gjw==
X-Gm-Message-State: AOJu0YxaoyeAZ9S8ZmqD6NxQGIGMvvZF2ucgYdymKN0QNpCrLaIy7+kg
	fKgRw13r/57MUbKKcSFFczTxhnpblQvbau9ASm0WMFayx5Awh18K4bM9WisFMq/jVUDC7/MCyVO
	7XYm0z76jOOqw4vgbVpcAPWecW0VC8qqgbJ4Bz2mzdSntB3qrFMsZ+LGoyTA7BYuUJJA9oOC9W6
	Szo0iFlEZkJ+SR3W/iEdf7X3Cs7HFL++4rUvdIdA8=
X-Google-Smtp-Source: AGHT+IFQXgTapaB+VM7/gNMQyvlM/bS7jIOgC1Vkuu5V93SSylFRTBSf2LxO9/Y2jZIDuJRJWN05VxsO41jX/A==
X-Received: from pfmx7.prod.google.com ([2002:a62:fb07:0:b0:730:796b:a54a])
 (user=steadmon job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a90:b0:736:5664:53f3 with SMTP id d2e1a72fcca58-739059ffb6bmr7740263b3a.15.1742595263998;
 Fri, 21 Mar 2025 15:14:23 -0700 (PDT)
Date: Fri, 21 Mar 2025 15:14:11 -0700
In-Reply-To: <cover.1742594960.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1742339107.git.josh@steadmon.net> <cover.1742594960.git.steadmon@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <3a87f5469374e442fc812eb8b6052f02331df96a.1742594960.git.steadmon@google.com>
Subject: [PATCH v2 5/5] libgit-{sys,rs}: add license and description fields
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add license and description fields for libgit-sys and libgit-rs. These
are required to publish our crates on crates.io.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 contrib/libgit-rs/Cargo.toml  | 2 ++
 contrib/libgit-sys/Cargo.toml | 1 +
 2 files changed, 3 insertions(+)

diff --git a/contrib/libgit-rs/Cargo.toml b/contrib/libgit-rs/Cargo.toml
index c3289e69db..9747ba3cb4 100644
--- a/contrib/libgit-rs/Cargo.toml
+++ b/contrib/libgit-rs/Cargo.toml
@@ -5,6 +5,8 @@ edition = "2021"
 build = "build.rs"
 rust-version = "1.63" # TODO: Once we hit 1.84 or newer, we may want to remove Cargo.lock from
                       # version control. See https://lore.kernel.org/git/Z47jgK-oMjFRSslr@tapette.crustytoothpaste.net/
+description = "Proof-of-concept Rust API for a portion of libgit"
+license = "GPL-2.0-only"
 
 
 [lib]
diff --git a/contrib/libgit-sys/Cargo.toml b/contrib/libgit-sys/Cargo.toml
index 1c1efb6211..cfbcca9c8c 100644
--- a/contrib/libgit-sys/Cargo.toml
+++ b/contrib/libgit-sys/Cargo.toml
@@ -7,6 +7,7 @@ links = "gitpub"
 rust-version = "1.63" # TODO: Once we hit 1.84 or newer, we may want to remove Cargo.lock from
                       # version control. See https://lore.kernel.org/git/Z47jgK-oMjFRSslr@tapette.crustytoothpaste.net/
 description = "Native bindings to a portion of libgit"
+license = "GPL-2.0-only"
 exclude = [
   "git-src/.github",
   "git-src/Documentation",
-- 
2.49.0.395.g12beb8f557-goog

