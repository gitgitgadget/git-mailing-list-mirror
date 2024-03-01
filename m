Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BF8629
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252092; cv=none; b=rCTAPduoblSpuOfKdFDcKVXJMID8dqFkXsxjZ0JAEGq6CBn/H0arfgJCu+/CwE6Quihi8jMYlgR/J2T17wq6iI7rtpFh1M/m+MoebO0mlOHY1sJ3MomXs1UzVSv1D66EJ0bsaugrcKstpx8UdrtED6Syu7aXvzZCp33gyFdWmjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252092; c=relaxed/simple;
	bh=rS3US6SDH5egTLSEQnlsDbu6KCcZ3nIOG+ZEiSb7CI0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oPZSRHNLKq4rhP9WWhMqIWAGd2VNmW15Vrw6bfjCE64doo+xm/8vTW1XYvY7w1sUQJMztlgxXjC5vsAHYEe+PEunx9PmDaYCNAx2O/oi6Wk2WdAn72PeJMn9X4FCNkpYqnUoQO2V/05rnnq9enITipxX01iTrlhFWJk/AKasgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpkgGcQw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpkgGcQw"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412c780464dso570795e9.0
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 16:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709252088; x=1709856888; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NOTTz9Zhd+7MnSR1dqaOPXWE1fcGEiWPhMnsNu67i8=;
        b=kpkgGcQw+D2HO26KUofX75hyUpY8wow7Wv/vWMQg8+6xbBLe4brj4prTnKPQNajxUA
         MiD0WCyrZQ96iKpB58TP39C1oeriXbpJEEdkHvwjPBCbKi+Ep6QfWU5fFYp7eMh1Oyaa
         JsK0aRdohVqUalo3f1yzblh8O95lwrsRYvWmVoXb4JB8E2q4scnlr7SA0khA6wSwozIG
         mTTWlpEXl0IoqoJlF9+JXSfb5Pfo1Ftox+2UDSYrrT47Pz/OJoPuK7cxgMg+UTH6l9T8
         lSycCkvY3SdcFQnTm5cMNapkLsd+gs71ulB5z6KSh73khQkcGmRWf32ftK7OBMq08MiC
         BqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709252088; x=1709856888;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NOTTz9Zhd+7MnSR1dqaOPXWE1fcGEiWPhMnsNu67i8=;
        b=UH2fpo/ctJMLNS3ZlBljUzbkEhyLtiLVJXXc6pqEMlYsdcLcyeElYer6KYUOGMwLse
         0ai4yPMXu1f1Rp9kozHnDjCSQDlecYR07bXqd1QS6cX0g/74qBCRriLy7bNwafB8HXva
         /D4caExp0FWYuSqHOExUV1u5f07gfIew5Qm8t7ifaLojcZMTvna2xeFakLabRlhub6BG
         ZLy/k1F7MwmEYRu8Bf2SnAz72bZ9fE9JAuYlawyUW7Jw7hbQFM4BaSKGF2CITlHT9F+h
         M4CLRa+nlk4aTng/l8nj46BrAAJkNbfd9ATydf+Zck7R4nai9P5PgmYqfLUev2PGpRm/
         JPIg==
X-Gm-Message-State: AOJu0YzDoBSK+w9ATmncqsdqglrEo2CmP+Q+mLYNdQVtLG5JqE++6NRT
	Vv3vwbxhJsR+p5oxYSjkRb7aaAl9Tmkgs+0tju1DXF7jvJNxj+8G/qKCj3NO
X-Google-Smtp-Source: AGHT+IGwZ7VHB+mdxS7s5cmxciCb0ZW3zUZCQfa92+gqIKjCEenkgyDBXGYv6uMXsWzNQrv+DrfXag==
X-Received: by 2002:adf:f20d:0:b0:33d:a010:5add with SMTP id p13-20020adff20d000000b0033da0105addmr96687wro.54.1709252087984;
        Thu, 29 Feb 2024 16:14:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6-20020adfb646000000b0033e033898c5sm2996494wre.20.2024.02.29.16.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:14:47 -0800 (PST)
Message-ID: <pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
References: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 Mar 2024 00:14:37 +0000
Subject: [PATCH v6 0/9] Enrich Trailer API
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


Notable changes in v6
=====================

 * Mainly wording changes to commit messages. Thanks to Christian for the
   suggestions.


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
  trailer: rename functions to use 'trailer'
  trailer: move interpret_trailers() to interpret-trailers.c
  trailer: reorder format_trailers_from_commit() parameters
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1632%2Flistx%2Ftrailer-api-refactor-part-1-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1632/listx/trailer-api-refactor-part-1-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1632

Range-diff vs v5:

  1:  652df25f30e =  1:  652df25f30e trailer: free trailer_info _after_ all related usage
  2:  fdccaca2ba0 =  2:  fdccaca2ba0 shortlog: add test for de-duplicating folded trailers
  3:  4372af244f0 !  3:  7b1d739cddb trailer: prepare to expose functions as part of API
     @@ Metadata
      Author: Linus Arver <linusa@google.com>
      
       ## Commit message ##
     -    trailer: prepare to expose functions as part of API
     +    trailer: rename functions to use 'trailer'
      
     -    In the next patch, we will move "process_trailers" from trailer.c to
     -    builtin/interpret-trailers.c. That move will necessitate the growth of
     -    the trailer.h API, forcing us to expose some additional functions in
     +    Rename process_trailers() to interpret_trailers(), because it matches
     +    the name for the builtin command of the same name
     +    (git-interpret-trailers), which is the sole user of process_trailers().
     +
     +    In a following commit, we will move "interpret_trailers" from trailer.c
     +    to builtin/interpret-trailers.c. That move will necessitate the growth
     +    of the trailer.h API, forcing us to expose some additional functions in
          trailer.h.
      
          Rename relevant functions so that they include the term "trailer" in
     @@ Commit message
          them by their "trailer" moniker, just like all the other functions
          already exposed by trailer.h.
      
     -    Take the opportunity to start putting trailer processing options (opts)
     -    as the first parameter. This will be the pattern going forward in this
     -    series.
     +    Rename `struct list_head *head` to `struct list_head *trailers` because
     +    "head" conveys no additional information beyond the "list_head" type.
     +
     +    Reorder parameters for format_trailers_from_commit() to prefer
     +
     +        const struct process_trailer_options *opts
     +
     +    as the first parameter, because these options are intimately tied to
     +    formatting trailers. Parameters like `FILE *outfile` should be last
     +    because they are a kind of 'out' parameter, so put such parameters at
     +    the end. This will be the pattern going forward in this series.
      
          Helped-by: Junio C Hamano <gitster@pobox.com>
     +    Helped-by: Christian Couder <chriscool@tuxfamily.org>
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## builtin/interpret-trailers.c ##
  4:  4073b8eb510 =  4:  7ac4da3019a trailer: move interpret_trailers() to interpret-trailers.c
  5:  b2a0f7829a1 !  5:  47c994ce025 trailer: start preparing for formatting unification
     @@ Metadata
      Author: Linus Arver <linusa@google.com>
      
       ## Commit message ##
     -    trailer: start preparing for formatting unification
     +    trailer: reorder format_trailers_from_commit() parameters
      
          Currently there are two functions for formatting trailers in
          <trailer.h>:
     @@ Commit message
          last, because it's an "out parameter" (something that the caller wants
          to use as the output of this function).
      
     +    Similarly, reorder parameters for format_trailer_info(), because later
     +    on we will unify the two together.
     +
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## pretty.c ##
  6:  c1760f80356 =  6:  7a565580167 trailer_info_get(): reorder parameters
  7:  9dc912b5bc5 =  7:  46c7f4c0e81 format_trailers(): use strbuf instead of FILE
  8:  b97c06d8bc3 =  8:  26b1f19d0e1 format_trailer_info(): move "fast path" to caller
  9:  7c656b3f775 !  9:  0e884d870c8 format_trailers_from_commit(): indirectly call trailer_info_get()
     @@ Commit message
      
          This is another preparatory refactor to unify the trailer formatters.
      
     -    Instead of calling trailer_info_get() directly, call parse_trailers()
     -    which already calls trailer_info_get(). This change is a NOP because
     -    format_trailer_info() only looks at the "trailers" string array, not the
     -    trailer_item objects which parse_trailers() populates.
     +    For background, note that the "trailers" string array is the
     +    `char **trailers` member in `struct trailer_info` and that the
     +    trailer_item objects are the elements of the `struct list_head *head`
     +    linked list.
     +
     +    Currently trailer_info_get() only populates `char **trailers`. And
     +    parse_trailers() first calls trailer_info_get() so that it can use the
     +    `char **trailers` to populate a list of `struct trailer_item` objects
     +
     +    Instead of calling trailer_info_get() directly from
     +    format_trailers_from_commit(), make it call parse_trailers() instead
     +    because parse_trailers() already calls trailer_info_get().
     +
     +    This change is a NOP because format_trailer_info() (which
     +    format_trailers_from_commit() wraps around) only looks at the "trailers"
     +    string array, not the trailer_item objects which parse_trailers()
     +    populates. For now we do need to create a dummy
     +
     +        LIST_HEAD(trailer_objects);
     +
     +    because parse_trailers() expects it in its signature.
      
          In a future patch, we'll change format_trailer_info() to use the parsed
     -    trailer_item objects instead of the string array.
     +    trailer_item objects (trailer_objects) instead of the `char **trailers`
     +    array.
      
          Signed-off-by: Linus Arver <linusa@google.com>
      
     @@ trailer.c: void format_trailers_from_commit(const struct process_trailer_options
       				 const char *msg,
       				 struct strbuf *out)
       {
     -+	LIST_HEAD(trailers);
     ++	LIST_HEAD(trailer_objects);
       	struct trailer_info info;
       
      -	trailer_info_get(opts, msg, &info);
     -+	parse_trailers(opts, &info, msg, &trailers);
     ++	parse_trailers(opts, &info, msg, &trailer_objects);
      +
       	/* If we want the whole block untouched, we can take the fast path. */
       	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
     @@ trailer.c: void format_trailers_from_commit(const struct process_trailer_options
       	} else
       		format_trailer_info(opts, &info, out);
       
     -+	free_trailers(&trailers);
     ++	free_trailers(&trailer_objects);
       	trailer_info_release(&info);
       }
       

-- 
gitgitgadget
