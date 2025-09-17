Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D79221F03
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071810; cv=none; b=NBGP90ocOftFIp7c718BSs82cGvpjjoykK9YSuB3t+1qiG5lakXTVLsAgGs5Cs6TjBlvN5Grd1V0STH8YDE/wPJ9Lavh8sl89Im8H82Rc1pBKqeCp0M0LuDzWqKy6dkyIbmAfrdVM4ZNuAsrG1FqIwK7fRa8moEV3V4LWoVZ7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071810; c=relaxed/simple;
	bh=xXL7zfgt3+jgNoWDezrHc6KYiglD5BnX6GpbFNI0iNE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pNTs94FPbrari+y2nKyqH2lrW7RvAyo/+kHLeGB5mRGkTFvpY+QZKxhCC0wzgOClDY0y6bvXBvICdTGIxFeVVp+IXioZ9yaas5S/lBX0d0T1X3CO0yaTNYj4U8kbHWT/7Eks/MO/rG+0Gc7guPr0L2rFUHqQh9RJLAtpngzbIG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgutlQB/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgutlQB/"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32df1321879so3178388a91.2
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071807; x=1758676607; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBo69bkiuLnHfjqTvBBicsJ3JcOhmWu08tu66M2e5dM=;
        b=RgutlQB/C2CtYFg0OWJeAZOkJnnCfCvvRJYNF/E+3H28NCAWgGxuse5vaKmkbKKrqv
         3A/oNtVNKNjo/JQrFrfXbXWPg6lH1TMH+d37Gj5YrXUIGyTGyeZUT2QmkcXZU8VFEXwL
         OkiXd0bhP1KhTXThOsrOM0qSC5gombiCOfvi+Ij2ltkVrpdWe0eYNBs72RyjJymQoTlu
         eoTC5wbvH8lt99S0rUH83f+FvmZwLgX7Zk1M6i7g2K3PPoD69sdA04v6F9sg2vTU5CoU
         n6Qf2Hvqa4s6GhaYvckAUHOwjUEx3fWnyDXoA3jOwumDkKEgnUAzvJCPo1Uvdpgt1BUq
         iNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071807; x=1758676607;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBo69bkiuLnHfjqTvBBicsJ3JcOhmWu08tu66M2e5dM=;
        b=Ud1mS1BW8ZjeAgfzMUjXRtxkTENE8Kwi44icgMEh+cqnlZNBv9XBOc38oPtWp8n0mQ
         yEVE+UIenpqcAznm2GnwQxfsa37d9QqpoeCU3JVEW4wwv73I9Bc2d0HyAVPWsQBCBYCg
         aBEhYFv/4bQgIHku+2dztr0iDp5e+txBjcXdkM1tiMCob6vc8hUe16gxHgtgLhXKix6f
         uKxkd6fAAYOPGaC3wl//7qadNbi1sbqsj1lEsHSLMCqDd09OCVJyzxlqgGiNI1MqQbat
         rlrxrsW/kKs6U38gtdCJVVed5yTI5+rG9cnzMPNsNJL9n4utN54rJh6OdxfGYl67cgXa
         /cLA==
X-Gm-Message-State: AOJu0YwM6w4lAeBKYMTiphLqVcTAWKUw6wROvuqo8xIHmEMyC5fWKq9D
	zPNd95Dyd0vkYJ75tVvJPfecODztHHUH+f/oq1DJZUgZHx4GlFyI4wl4uqhMrw==
X-Gm-Gg: ASbGnctXRtUcmcnfepq+ua0aamXG4vePrRxNoy8/NJ25BJ/SI0foQbgxfViU4MwXWvX
	njz2gPKAbiugowlj5EP4+8OGzDCIApY9P0TMJmJddE9mEqb1KUJrucwykn6PLbsGYPCQd5B/XJT
	MqqkMW2qpdqRCEqnkRrgcysqW1c05rUtbDwzAUG7pMFSkEWiY1YcqEyAwQAtHyEPcDoyWa8pFFg
	Fj3zWv7CBJzucf494nl/I+6KKHGLsXPvCg/RS8sB4Wd3KMQeusn4ycXl4xOciCo1OiWQO9DA2nP
	9TrAbyHe+CI+hojuJtZ/rLrlsHMaXvXXMeaolChVWu3ffmVtjXcTp0Jut/NUWgWhD6i6hLzeRwF
	qGGgYq+uq/O0SERjPDq4YFo+QGq8=
X-Google-Smtp-Source: AGHT+IHPQb9xOIslJNiRv305blJtK/iae/dNXIlD5NHH/lPO4TcNykRZ/YIXfjcoHVU4QfAmIVjfKg==
X-Received: by 2002:a17:90b:4fc9:b0:32b:9d3c:13b3 with SMTP id 98e67ed59e1d1-32ee3f6250emr413580a91.18.1758071807365;
        Tue, 16 Sep 2025 18:16:47 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3a9e25bsm15399429a12.47.2025.09.16.18.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:16:46 -0700 (PDT)
Message-Id: <8e030170ddc3e6307760fa12387b8b4310ae5e26.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "Patrick Steinhardt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:26 +0000
Subject: [PATCH v2 06/18] BreakingChanges: announce Rust becoming mandatory
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Patrick Steinhardt <ps@pks.im>

From: Patrick Steinhardt <ps@pks.im>

Over the last couple of years the appetite for bringing Rust into the
codebase has grown significantly across the developer base. Introducing
Rust is a major change though and has ramifications for the whole
ecosystem:

  - Some platforms have a Rust toolchain available, but have not yet
    integrated it into their build infrastructure.

  - Some platforms don't have any support for Rust at all.

  - Some platforms may have to figure out how to fit Rust into their
    bootstrapping sequence.

Due to this, and given that Git is a critical piece of infrastructure
for the whole industry, we cannot just introduce such a heavyweight
dependency without doing our due diligence.

Instead, preceding commits have introduced a test balloon into our build
infrastructure that convert one tiny subsystem to use Rust. For now,
using Rust to build that subsystem is entirely optional -- if no Rust
support is available, we continue to use the C implementation. This test
balloon has the intention to give distributions time and let them ease
into our adoption of Rust.

Having multiple implementations of the same subsystem is not sustainable
though, and the plan is to eventually be able to use Rust freely all
across our codebase. As such, there is the intent to make Rust become a
mandatory part of our build process.

Add an announcement to our breaking changes that Rust will become
mandatory in Git 3.0. A (very careful and non-binding) estimate might be
that this major release might be released in the second half of next
year, which should give distributors enough time to prepare for the
change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Documentation/BreakingChanges.adoc | 35 ++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index f8d2eba061..56bbd5699e 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -165,6 +165,41 @@ A prerequisite for this change is that the ecosystem is ready to support the
 "reftable" format. Most importantly, alternative implementations of Git like
 JGit, libgit2 and Gitoxide need to support it.
 
+* Git will require Rust as a mandatory part of the build process. While Git
+  already started to adopt Rust in Git 2.49, all parts written in Rust are
+  optional for the time being. This includes:
++
+  ** Subsystems that have an alternative implementation in Rust to test
+     interoperability between our C and Rust codebase.
+  ** Newly written features that are not mission critical for a fully functional
+     Git client.
++
+These changes are meant as test balloons to allow distributors of Git to prepare
+for Rust becoming a mandatory part of the build process. There will be multiple
+milestones for the introduction of Rust:
++
+--
+1. In Git 2.52, both build systems will default-enable support for Rust.
+   Consequently, builds will break by default if Rust is not available on the
+   build host. The use of Rust can still be explicitly disabled via build
+   flags.
+2. In Git 3.0, the build options will be removed and support for Rust is
+   mandatory.
+--
++
+Disable building with Rust:
+Meson: `meson configure -Dwith_rust=false`.
+Makefile: `make WITH_RUST=false`,
++
+The Git project will declare the last version before Git 3.0 to be a long-term
+support release. This long-term release will receive important bug fixes for at
+least four release cycles and security fixes for six release cycles. The Git
+project will hand over maintainership of the long-term release to distributors
+in case they need to extend the life of that long-term release even further. In
+that case, the backporting process will be handled by these distributors, but
+the backported patches will be reviewed on the mailing list and pulled in by the
+Git maintainer.
+
 === Removals
 
 * Support for grafting commits has long been superseded by git-replace(1).
-- 
gitgitgadget

