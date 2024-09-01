Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93E83FC7
	for <git@vger.kernel.org>; Sun,  1 Sep 2024 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725206602; cv=none; b=OGbQp3+Z9lcVoSj7VpjVtDw9yac2ZMuOEDeAQI/fG2GVlYLXMLPhJmGNOb2v8VMRZP9ueJrlIDcv0Fn7c8+EFkfoKXwaCexMSoX0WOfUufpL25G0VFP1VBbrnP8m3Dy/7aMO8GlbB5G2pzX5CKpekG4sWXM2CPG2UNViy72fLys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725206602; c=relaxed/simple;
	bh=RjIrUfbDFf+p2Nh0LPFTM16aq6cV/FwBOkoOMa0NQS0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IZOUjLfJbxp+SungsFIt88WSittyQ49O9TEGC/J3i/IRDQXI1xb7mU13HJIdLmUKfWILtCBe5hB/n3UtOtXeSbpr01YnxOFHEVi10ZxAUUEmqa8yzzMyrZ/7NZ1NkOyo9Brx+OigTppGKXoEZRkuFdVQI4ZESqVOdSdsw0l7mLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=a15IkTjq; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="a15IkTjq"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6c49c9018ebso31865487b3.3
        for <git@vger.kernel.org>; Sun, 01 Sep 2024 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1725206599; x=1725811399; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TQGBZwXr+0V1naLjs08ZPUtNFbX4fv0Cj2S0qZ1LsQs=;
        b=a15IkTjq2JGX4m0FSIFlecDXNe4GqZkjTYEtj1ZoRmcNZ6ncEO20hKJCGted/ocq6T
         tfTx/ybqnHfDjZ6IlJKAYc85fTHXbEbkAr5G5w7FgVjFj45swQRoilvBmLQKTVcjo/n8
         5uEIgHwo+H9M25yBab+4dpTK0t+57ufPrc/wdAS0iLQu22D2OAOFEVO8nxEigxv+mt2C
         C0pOmFug+SiY7CJCIWcmn5zMshI6KdeNEL6mniu29lM0Iz/nJ3xnZRaOvmUs+Dahf7E9
         OUzcaZ88tb1B7v9UkqTUVW8O3Go3P6jnC7ucGYJNhKwBo3ADfw+EKzCbK6o0P5ZyL16H
         nVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725206599; x=1725811399;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQGBZwXr+0V1naLjs08ZPUtNFbX4fv0Cj2S0qZ1LsQs=;
        b=NFHiZJmQDtkHrp7KW766yqLihGZQJyloK9ubX9n57CmAW/8nD988lCmbaLqj0SZiZO
         yFcResRoJsnIE6zurMdbd+usuVg8qkLNNSfLKP1DTMi3DmIRyknjKg3/GMikIbHhLAY7
         kmWr73BMsFlS9FFANZYkKFVJxdJFsgeXHIkgWEYmGYvHSoIfPBll3uQFZofTU1HcBa5v
         2+QzTKLI7osgFITdrCtR3NU65/jn0gj3zSnvZqqJUwRpk3i7AmdhAvxtvQBpTDqTyJUf
         52PjXjUQ0Gv5kIcoovTFR12Ofjy39GeF8UiXvgjWYhRwHPMtBg4AmDVNh5p0ht9AXl05
         aUkA==
X-Gm-Message-State: AOJu0YwyAik6HBX5VaGedubmg0kexjmkeefBjGqqb+/HsAPLK2YnnlpX
	w5p1J0dZN0tgDLHWSPMgOGQGcK3vzd+tX66n4Akr7TtCYnTu2kbNHBokZ8LHzBfocxwMTm7SCy5
	VBX8=
X-Google-Smtp-Source: AGHT+IGE39RXT5NBzXTaVh5u/GePN/To/xeckBBTUkC0BrED95go8OLPCpAUl0tfZLa99aDLbjHbiA==
X-Received: by 2002:a05:690c:6711:b0:65f:7cee:43b with SMTP id 00721157ae682-6d40e180b26mr92379947b3.19.1725206599342;
        Sun, 01 Sep 2024 09:03:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d39c7237sm13156867b3.9.2024.09.01.09.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:03:18 -0700 (PDT)
Date: Sun, 1 Sep 2024 12:03:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <cover.1725206584.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This series adds a build-time knob to allow selecting an alternative
SHA-1 implementation for non-cryptographic hashing within Git, starting
with the `hashwrite()` family of functions.

This series is the result of starting to roll out verbatim multi-pack
reuse within GitHub's infrastructure. I noticed that on larger
repositories, it is harder thus far to measure a CPU speed-up on clones
where multi-pack reuse is enabled.

After some profiling, I noticed that we spend a significant amount of
time in hashwrite(), which is not all that surprising. But much of that
time is wasted in GitHub's infrastructure, since we are using the same
collision-detecting SHA-1 implementation to produce a trailing checksum
for the pack which does not need to be cryptographically secure.

This series teaches a new set of build-time knobs: OPENSSL_SHA1_FAST,
BLK_SHA1_FAST, and APPLE_COMMON_CRYPTO_SHA1_FAST, which can be used to
select an alterantive SHA-1 implementation for non-cryptographic uses
within Git.

The series is laid out as follows:

  - The first two patches are preparatory, allowing us to include
    multiple SHA-1 wrapper headers and adding scaffolding functions for
    the _fast() variants, respectively.

  - The third patch introduces the build-time knobs for selecting which
    SHA-1 implementation is used for non-cryptographic purposes.

  - The fourth and final patch updates the hashwrite() implementation to
    use the _fast() variants.

From the final commit, a clone of the kernel which took 19.219 seconds
on my machine with no build-time modifications now only takes 11.597
seconds when compiling with OPENSSL_SHA1_FAST=1, for a ~39.7% speed-up.
On a freshly-repacked copy of git.git, the time goes from 758ms to 333ms
for a ~56% speed-up.

Thanks in advance for your review!

Taylor Blau (4):
  sha1: do not redefine `platform_SHA_CTX` and friends
  hash.h: scaffolding for _fast hashing variants
  Makefile: allow specifying a SHA-1 for non-cryptographic uses
  csum-file.c: use fast SHA-1 implementation when available

 Makefile          | 25 ++++++++++++++++++
 block-sha1/sha1.h |  2 ++
 csum-file.c       | 18 ++++++-------
 hash.h            | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 object-file.c     | 42 +++++++++++++++++++++++++++++
 sha1/openssl.h    |  2 ++
 sha1dc_git.h      |  3 +++
 7 files changed, 150 insertions(+), 9 deletions(-)


base-commit: 159f2d50e75c17382c9f4eb7cbda671a6fa612d1
-- 
2.46.0.425.ge8f5cbd280c
