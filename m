Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36D115B103
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 22:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661153; cv=none; b=SHVQ8VxiGpVZIInXDK/k3hmTSs1002yJm77PSsqpxEvgbO1oVogQpGRFE8M9cUL14QVSVSoLdJFr/LxCg60y8EhD7DFTUAuw6KLF/WVMnNACGRt5UMXgIIyrYmTiiN4P+90cO+mGNFVonmnsXwWxNF3QpIR8gPBqaPx9GOcWLYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661153; c=relaxed/simple;
	bh=PxLN5m5EXJV1ctoIXLFAVQ3GqOaQzeXl5yzDTh9oY+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j6LXyvFphO/WnzeLGa7O7fULEr9T4/JMd1J3iKRV0XNJ9Vd5njSjlymmNK5DGVKY+BTyMpYfTMh7363qc+jPaQhsYuYJQO9k6mXZ+LhADO8wywrVPt+qW+UPAm/rX3BJ28NscNpMyer7z1COoSF6QGAq0CyUSamlWLUbSdbgOhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wCQfrEMn; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCQfrEMn"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-718e2da2e33so340033b3a.1
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 15:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725661151; x=1726265951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ycUov03TXAul8Vt/xl1ncqCf+0quPWwcMtdIZEUOks0=;
        b=wCQfrEMnO1rl9ny4Ix0ogHvGK4+R/6xUBlqRv3Gh8xOvFMruFlBsfvUeiaNN/Pbq9O
         fhXuRhsfYgOKwzKPlUTzKuzy57/uC3W+nfO0XY5K8yA5uarNA2zBz9i/ZSit2JW4/PSO
         ErPd3+A7tnPqXVtgZC7H/F4SctUfytbJKN2dgZ9ANiPYAmKqzuDCC+6DmamhQEXtEjDf
         uob4qfC5YOAA29IASviiK6kJog/GzCi5SvnG67T1g9ggcEgtFEqjvU9d8Z4uy5SEUI2+
         kGwgxMbGbABcdduw4wtp4i2+iPNBRfa0XHFPuWkMwRpc4bVs445Et4DWuIMQ2ftQO8Tr
         DSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725661151; x=1726265951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycUov03TXAul8Vt/xl1ncqCf+0quPWwcMtdIZEUOks0=;
        b=RXR8gpaLfThJAoJ15cRuP2TO1NBOKePcKEEreRGOdUo24rt3Dmd8Navu9YpSNYrE58
         TVYfcUg74Nj3fjzirPYMyHU2UgcuFIl+t5sWM6zao0DMunphvPRuei7sPgyGR8DrEQKa
         lreWtavIx2GjR6QlJ2/sEL+skvlUJSUM9De+OT2UfCd+PBhyFVQvhFJyrAFILqjUDL88
         9SSq2yhXr2D8BxXBmXafHodCphchMe58zr12MHGjrm5dJEyKNuDsDulJPwCwHrPHatqy
         48yY3ihdX4seB3Nc9uXxXcqBnocztQpEqyx2OSrMkfH/olEjQ/kgCMW8/vhDdfPFYwg6
         ZVOQ==
X-Gm-Message-State: AOJu0YyJtoB67yJme9mtwWzOk4xz/ckqn1UgjWX9De4psKRkdfcNLdQC
	S77Z++0t9VtYknSOWRwxBqBPCpHN2W8PiRWJhyuZCBW5UVoADNd76e/10RVdwBlH2FdGX3gcTAk
	AxKX01HwO51s+YKjl/Qo/mckhyU8Ypv8h6Kuoq9ht3JRFPgQ6+XKsRwgEJXp5PekeU4ihSz0jAU
	7AS+WxcOXst601JWlFHrXP8WPjFJZeBL37kgAQ7t3yLUIA
X-Google-Smtp-Source: AGHT+IFtUwRIR1KDPjHcYfkNBIYRUCi028LKK+lIsEjU2R+HE9AEiHLDPDhiVqW7l44qa3lDMxQEv/xvOJQ4aVA=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:7207:b0:714:37ed:dcb3 with SMTP
 id d2e1a72fcca58-718d5f1b2a8mr7801b3a.4.1725661149719; Fri, 06 Sep 2024
 15:19:09 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:18:52 +0000
In-Reply-To: <cover.1723242556.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1723242556.git.steadmon@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906221853.257984-1-calvinwan@google.com>
Subject: [PATCH v3 0/6] Introduce libgit-rs, a Rust wrapper around libgit.a
From: Calvin Wan <calvinwan@google.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, steadmon@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, 
	gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"

This series provides two small Rust wrapper libraries around parts of
Git: "libgit-sys", which exposes a few functions from libgit.a, and
"libgit", which provides a more Rust-friendly interface to some of those
functions. In addition to included unit tests, at $DAYJOB we have tested
building JJ[1] with our library and used it to replace some of the
libgit2-rs uses.

[1] https://github.com/martinvonz/jj

Please find V1 cover letter here:
https://lore.kernel.org/git/cover.1723054623.git.steadmon@google.com/

Changes in V3:
* Renamed cgit-rs to libgit-rs and cgit-sys to libgit-sys

* Makefile cleanup, particularly adding config.mak options that
  developers can set to run Rust builds and tests by default (Patch 6)

* Provide testdata configs for unit tests

* ConfigSet API now uses &Path instead of &str -- more ergonomic for
  Rust users to pass in and errors out if the path string isn't UTF-8

* Fixed unresolved dependency on libz in Cargo.toml

Known NEEDSWORK:

* Supports older Rust versions by removing any dependencies introduced
  after 1.63.0 (Debian stable)

* Investigate alternative methods of managing symbol visibility.

* Figure out symbol versioning

* Automate the process of exporting additional functions in libgit-sys
  (possibly with a wrapper script around bindgen)

Calvin Wan (3):
  libgit-sys: add repo initialization and config access
  libgit: add higher-level libgit crate
  Makefile: add option to build and test libgit-rs and libgit-rs-sys

Josh Steadmon (3):
  common-main: split init and exit code into new files
  libgit-sys: introduce Rust wrapper for libgit.a
  config: add git_configset_alloc() and git_configset_clear_and_free()

 .gitignore                                    |   2 +
 Makefile                                      |  31 +++++
 common-exit.c                                 |  26 ++++
 common-init.c                                 |  63 +++++++++
 common-init.h                                 |   6 +
 common-main.c                                 |  83 +-----------
 config.c                                      |  11 ++
 config.h                                      |  10 ++
 contrib/libgit-rs/Cargo.lock                  |  62 +++++++++
 contrib/libgit-rs/Cargo.toml                  |  10 ++
 contrib/libgit-rs/libgit-sys/Cargo.lock       |  55 ++++++++
 contrib/libgit-rs/libgit-sys/Cargo.toml       |  12 ++
 contrib/libgit-rs/libgit-sys/README.md        |  15 +++
 contrib/libgit-rs/libgit-sys/build.rs         |  31 +++++
 .../libgit-sys/public_symbol_export.c         |  76 +++++++++++
 .../libgit-sys/public_symbol_export.h         |  28 ++++
 contrib/libgit-rs/libgit-sys/src/lib.rs       | 124 ++++++++++++++++++
 contrib/libgit-rs/src/lib.rs                  |  85 ++++++++++++
 contrib/libgit-rs/testdata/config1            |   2 +
 contrib/libgit-rs/testdata/config2            |   2 +
 contrib/libgit-rs/testdata/config3            |   2 +
 t/Makefile                                    |  16 +++
 22 files changed, 671 insertions(+), 81 deletions(-)
 create mode 100644 common-exit.c
 create mode 100644 common-init.c
 create mode 100644 common-init.h
 create mode 100644 contrib/libgit-rs/Cargo.lock
 create mode 100644 contrib/libgit-rs/Cargo.toml
 create mode 100644 contrib/libgit-rs/libgit-sys/Cargo.lock
 create mode 100644 contrib/libgit-rs/libgit-sys/Cargo.toml
 create mode 100644 contrib/libgit-rs/libgit-sys/README.md
 create mode 100644 contrib/libgit-rs/libgit-sys/build.rs
 create mode 100644 contrib/libgit-rs/libgit-sys/public_symbol_export.c
 create mode 100644 contrib/libgit-rs/libgit-sys/public_symbol_export.h
 create mode 100644 contrib/libgit-rs/libgit-sys/src/lib.rs
 create mode 100644 contrib/libgit-rs/src/lib.rs
 create mode 100644 contrib/libgit-rs/testdata/config1
 create mode 100644 contrib/libgit-rs/testdata/config2
 create mode 100644 contrib/libgit-rs/testdata/config3

-- 
2.46.0.469.g59c65b2a67-goog

