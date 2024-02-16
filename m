Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F40617BC4
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 23:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708124957; cv=none; b=p0CVPdbIhv1olcFJMlUl5e6ARzCLZGFcBu50pajCHfUPMLD0S3iMu1IbgsIfpagJOJXudgpBlfEohmh9so5ebsPgREnb37218AT0gOspRXi3xxcP5qYsIrU6sBdiMMl4ESbAQn+VQGc5cKm6IJGGtQjRk7a3sUOgAA4AOZFfYks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708124957; c=relaxed/simple;
	bh=S7a7FVWjwq/5gQ1Xc62eahvgD8nB1RqE0VBvO9joQLw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mPG7ZlGsDANDb5g/69WcdTN2E5nUqMeJS54H2gCVIjgLQ68oC5MyHk1ivnRffunWUY7242YKfoAyBeWrm1FdiqU9XIWleKks3bzetoEIClh3Ayn5TvbJ/bXmtPQXrvInRC1FrYmqQGzJgTb8d38b89f562bmBZhIHJfAzcnTxw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLFShF8U; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLFShF8U"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d211c27abso514439f8f.3
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 15:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708124953; x=1708729753; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2PmXPaQYDxLAd4iclBP7QwSrsI0mveU67X8L4i9wWE=;
        b=HLFShF8UYIBUbnl2DRB27bc7wE9NbE19/V29qEMDqnb6RLzh530oiH7R03zFOm0NDS
         6lhmzYEFoERIBAPvXv4Fx2YZQ0m6wo8YW6L5O1gZUqkSOYdoqOMj200jJPqw+UEKbrnW
         qHTacQhhV2J9jHVjpGSQzahVVcwZpM0+GRWlliEp4BoIAqotF5jIC1+K0W8vnSdZTsKG
         2iG36Tv/oVHQHWsJSnC2Y2RX2GOmRGtMW8UXQRQiP0pbeEcZAQVphMAMtOrSfoT+gTYs
         gG6dDEZl0lbAD3d3gnc/7sSAOnZNh6H+cKyE9vNSgAy6bUa5aSzdnz4rGwLEwkjfbFMb
         yQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708124953; x=1708729753;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2PmXPaQYDxLAd4iclBP7QwSrsI0mveU67X8L4i9wWE=;
        b=ILW8Jwl6Y/iP0ktmmuLoNjmEAy53f935jCKbY/AY8StEoaauUWjXrEK1hqdhV5yKID
         dK3L/rxYylmcMvalY2HThx/DD3gFCfqsa3AC06a1TPVVnV+7WfliYH2Z3WpuK55wZLbq
         yRsccZSplOf/YqG5C+NNNXd3EK8fn6MJhxeb0ROgUBw3Y8+w8CMuHDqD/qH9hPPJPeNV
         graXewexdSfOam7iS+WiwghYBriiqb3+Xx2KeacrYYfqflcilbz5hefHzT1efuoXEVmX
         /H7mHPoCSySaMSp+PuEHQRsLl9k2HNDIW1UvtHzyw7sBAVtlEnLxYkPx6eSYWsKuCnKO
         yuxw==
X-Gm-Message-State: AOJu0Yy18diwiGnFlA7L6JCfw5qxOZxqb/FohgjP11ZsX0m3rNeTDm8H
	ULhuvyoL5B8CJhaenpysBdgbds8dnF1DwTM10YpXJ1Hz+u18EgC0n2sVaz/+
X-Google-Smtp-Source: AGHT+IH1xif3xaMMf3CUMR4S5YOrx8+aqbuVhKW1ht0FccqVQAAxxUpq4/4vRiQAjW9S03nZPtNEGQ==
X-Received: by 2002:a5d:438b:0:b0:33c:e339:23ee with SMTP id i11-20020a5d438b000000b0033ce33923eemr4887309wrq.48.1708124952925;
        Fri, 16 Feb 2024 15:09:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u5-20020a056000038500b0033b66ce7ae9sm3410667wrf.84.2024.02.16.15.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:09:12 -0800 (PST)
Message-ID: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 Feb 2024 23:09:01 +0000
Subject: [PATCH v5 0/9] Enrich Trailer API
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linusa@google.com>

This patch series is the first 9 patches of a larger cleanup/bugfix series
(henceforth "larger series") I've been working on. The main goal of this
series is to begin the process of "libifying" the trailer API. By "API" I
mean the interface exposed in trailer.h. The larger series brings a number
of additional cleanups (exposing and fixing some bugs along the way), and
builds on top of this series.

When the larger series is merged, we will be in a good state to additionally
pursue the following goals:

 1. "API reuse inside Git": make the API expressive enough to eliminate any
    need by other parts of Git to use the interpret-trailers builtin as a
    subprocess (instead they could just use the API directly);
 2. "API stability": add unit tests to codify the expected behavior of API
    functions; and
 3. "API documentation": create developer-focused documentation to explain
    how to use the API effectively, noting any API limitations or
    anti-patterns.

In the future after libification is "complete", users external to Git will
be able to use the same trailer processing API used by the
interpret-trailers builtin. For example, a web server may want to parse
trailers the same way that Git would parse them, without having to call
interpret-trailers as a subprocess. This use case was the original
motivation behind my work in this area.

With the libification-focused goals out of the way, let's turn to this patch
series in more detail.

In summary this series breaks up "process_trailers()" into smaller pieces,
exposing many of the parts relevant to trailer-related processing in
trailer.h. This will force us to eventually introduce unit tests for these
API functions, but that is a good thing for API stability. We also perform
some preparatory refactors in order to help us unify the trailer formatting
machinery toward the end of this series.


Notable changes in v5
=====================

 * Removed patches 10+ from this series. Thanks to Christian for the
   suggestion.
 * Reworded the log message of patch 09 to reflect the above arrangement, as
   suggested by Christian.


Notable changes in v4
=====================

 * Patches 3, 4, 5, and 8 have been broken up into smaller steps. There are
   28 instead of 10 patches now, but these 28 should be much easier to
   review than the (previously condensed) 10.
 * NEW Patch 1: "trailer: free trailer_info after all related usage" fixes
   awkward use-after-free coding style
 * NEW Patch 2: "shortlog: add test for de-duplicating folded trailers"
   increases test coverage related to trailer iterators and "unfold_value()"
 * NEW Patch 27: "trailer_set_*(): put out parameter at the end" is a small
   refactor to reorder parameters.
 * Patches 5-16: These smaller patches make up Patch 3 from v3.
 * Patches 17-18: These smaller patches make up Patch 4 from v3.
 * Patches 19-20: These smaller patches make up Patch 5 from v3.
 * Patches 23-26: These smaller patches make up Patch 8 from v3.
 * Anonymize unambiguous parameters in <trailer.h>.


Notable changes in v3
=====================

 * Squashed Patch 4 into Patch 3 ("trailer: unify trailer formatting
   machinery"), to avoid breaking the build ("-Werror=unused-function"
   violations)
 * NEW (Patch 10): Introduce "trailer template" terminology for readability
   (no behavioral change)
 * (API function) Rename default_separators() to
   trailer_default_separators()
 * (API function) Rename new_trailers_clear() to free_trailer_templates()
 * trailer.h: for single-parameter functions, anonymize the parameter name
   to reduce verbosity


Notable changes in v2
=====================

 * (cover letter) Discuss goals of the larger series in more detail,
   especially the pimpl idiom
 * (cover letter) List bug fixes pending in the larger series that depend on
   this series
 * Reorder function parameters to have trailer options at the beginning (and
   out parameters toward the end)
 * "sequencer: use the trailer iterator": prefer C string instead of strbuf
   for new "raw" field
 * Patch 1 (was Patch 2) also renames ensure_configured() to
   trailer_config_init() (forgot to rename this one previously)

Linus Arver (9):
  trailer: free trailer_info _after_ all related usage
  shortlog: add test for de-duplicating folded trailers
  trailer: prepare to expose functions as part of API
  trailer: move interpret_trailers() to interpret-trailers.c
  trailer: start preparing for formatting unification
  trailer_info_get(): reorder parameters
  format_trailers(): use strbuf instead of FILE
  format_trailer_info(): move "fast path" to caller
  format_trailers_from_commit(): indirectly call trailer_info_get()

 builtin/interpret-trailers.c | 101 ++++++++++++++++++-
 pretty.c                     |   2 +-
 ref-filter.c                 |   2 +-
 sequencer.c                  |   2 +-
 t/t4201-shortlog.sh          |  32 +++++++
 trailer.c                    | 181 +++++++++--------------------------
 trailer.h                    |  31 ++++--
 7 files changed, 204 insertions(+), 147 deletions(-)


base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1632%2Flistx%2Ftrailer-api-refactor-part-1-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1632/listx/trailer-api-refactor-part-1-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1632

Range-diff vs v4:

  1:  652df25f30e =  1:  652df25f30e trailer: free trailer_info _after_ all related usage
  2:  fdccaca2ba0 =  2:  fdccaca2ba0 shortlog: add test for de-duplicating folded trailers
  3:  4372af244f0 =  3:  4372af244f0 trailer: prepare to expose functions as part of API
  4:  4073b8eb510 =  4:  4073b8eb510 trailer: move interpret_trailers() to interpret-trailers.c
  5:  b2a0f7829a1 =  5:  b2a0f7829a1 trailer: start preparing for formatting unification
  6:  c1760f80356 =  6:  c1760f80356 trailer_info_get(): reorder parameters
  7:  9dc912b5bc5 =  7:  9dc912b5bc5 format_trailers(): use strbuf instead of FILE
  8:  b97c06d8bc3 =  8:  b97c06d8bc3 format_trailer_info(): move "fast path" to caller
  9:  6906910417a !  9:  7c656b3f775 format_trailers_from_commit(): indirectly call trailer_info_get()
     @@ Commit message
          format_trailer_info() only looks at the "trailers" string array, not the
          trailer_item objects which parse_trailers() populates.
      
     -    In the next patch, we'll change format_trailer_info() to use the parsed
     +    In a future patch, we'll change format_trailer_info() to use the parsed
          trailer_item objects instead of the string array.
      
          Signed-off-by: Linus Arver <linusa@google.com>
 10:  f5b7ba08aa7 <  -:  ----------- format_trailer_info(): use trailer_item objects
 11:  457f2a839d5 <  -:  ----------- format_trailer_info(): drop redundant unfold_value()
 12:  a72eca301f7 <  -:  ----------- format_trailer_info(): append newline for non-trailer lines
 13:  ad77c33e457 <  -:  ----------- trailer: begin formatting unification
 14:  11f854399db <  -:  ----------- format_trailer_info(): teach it about opts->trim_empty
 15:  ba1f387747b <  -:  ----------- format_trailer_info(): avoid double-printing the separator
 16:  31725832224 <  -:  ----------- trailer: finish formatting unification
 17:  6f17c022b15 <  -:  ----------- trailer: teach iterator about non-trailer lines
 18:  cc92dfb0bda <  -:  ----------- sequencer: use the trailer iterator
 19:  f5f0d06613f <  -:  ----------- trailer: make trailer_info struct private
 20:  607ae7a90cd <  -:  ----------- trailer: retire trailer_info_get() from API
 21:  38f4b4c4135 <  -:  ----------- trailer: spread usage of "trailer_block" language
 22:  94bf182e3ff <  -:  ----------- trailer: prepare to delete "parse_trailers_from_command_line_args()"
 23:  3bfe4809ecb <  -:  ----------- trailer: add new helper functions to API
 24:  80e1958bb8d <  -:  ----------- trailer_add_arg_item(): drop new_trailer_item usage
 25:  a9080597a28 <  -:  ----------- trailer: deprecate "new_trailer_item" struct from API
 26:  9720526dd8a <  -:  ----------- trailer: unify "--trailer ..." arg handling
 27:  26df2514acb <  -:  ----------- trailer_set_*(): put out parameter at the end
 28:  14927038d85 <  -:  ----------- trailer: introduce "template" term for readability

-- 
gitgitgadget
