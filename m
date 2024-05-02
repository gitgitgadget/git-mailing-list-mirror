Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659F724A0D
	for <git@vger.kernel.org>; Thu,  2 May 2024 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714625674; cv=none; b=mskyk5uCm91ocJwYCKs8c8n3wsI4OVWDjmp7EDYWvSzM1Hm/aTwXomPBShYb1U2rNrg06EDph5CFHlLGC+XcMm29fmJrS9kymOX8cbrlGxaOnzCHPMiVg1C+0iKu+vF/F09GnPjk+yFSRjo14MznLMuWX45PBW4rBuRrkvzx7EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714625674; c=relaxed/simple;
	bh=OdNUCPENncLy7uRbzpEAeFcZDnPdS2DcbiwAkYFTFOE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=tp5Ld/ES9QKvTblm+PGGLng6RG6v+XOMIY2nnbjpELBjhGu5YE9dbRTi1hu6k9FdH5J7vkW1POGyqWTEVRkmx+USV/R9a4EhQ6t2oZL3obbNcrGjc/t/HfH3zgQ8mL+c5sB5c/KU0/H2XZoi0WZ6JO4zfzCNQlABFz0EYq4PM0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+xqqK+Q; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+xqqK+Q"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41b5e74fa2fso47978335e9.1
        for <git@vger.kernel.org>; Wed, 01 May 2024 21:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714625670; x=1715230470; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8G9NzqN0I27sHeHS/+s42aHDiQi6Rp5z77y4kXqwvdk=;
        b=C+xqqK+Q15B+nbLHFdQROUibkjlU9hPf5OxL2E6CljUcD04XDH/6u030JKeYaDsiKF
         HbK7Tb7bwyuEdEqeG3K8gtfpJM5OnsWE5wz7N5OOdM5FNuLjCexemT85SsZ/ZWRMJSGY
         Cd1oCfd6b4j0/P7RtXPiZX2feNvTp1LfJRMHvDO17i0iVubKREIWHWFZbgvgVOE6wjqb
         eiy71PaTsOpJWry59SikU+moptc3W/V9VL2u1GUmPVQ3f211wja+Q8XTXa31Kd/jgII4
         gCIZtu6BUsXs3bLKdW6HBOPoK2a9x7yKg37dXA6SH9Spa0zCbSUfzo3EPvD6o35GrIL+
         NQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714625670; x=1715230470;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8G9NzqN0I27sHeHS/+s42aHDiQi6Rp5z77y4kXqwvdk=;
        b=uY6tzy8EdpdxXFN3XuozuPSrjxAG6yxS3RB0PBJ2PlMCe0mToEMQsIxcy2LPD25GlD
         BqAZ33viz2CrP1/w7xnp43CS12qR13tlHarPMbRXP9RpuHH2Yukn536u9Y9YJfBaSYzb
         l1UH5XgXxW0jtim2UF3oWAqmwUin0zK8iFbQKZCTS39XGOCQYcuBfbXlTV1oDffvRPEe
         jvMeXvKFYuZC3Yt7/6QFrtmKn78lokAvTabxkPj59haUENdATTn8b0iJbyycH/nzNTwF
         rdCAxHxbAcoN9J7grxypnPmGoYQ/w/D4ZgpmzE3NS3Jpa9YvENvK+GOAlkxKwfm1dUvV
         Jxyg==
X-Gm-Message-State: AOJu0YxD65WCgOa7kI9VdwuSUr00sUPU+b5C+xV/NuI6hcSP0LJ/g427
	oMu7rOwKdTD9OtwIW0KqWLCz8ieEou0LksG9UL1+PNvSEOtpl5FGVyQ5VQ==
X-Google-Smtp-Source: AGHT+IHnV7DpASfyE+HIhglGFWFvKZH0Fj3MxvjCK4od7Je8RGT+kUUNHy0JbY5UGVwq21qHTQySaQ==
X-Received: by 2002:a05:600c:4e93:b0:41b:e55c:8e0d with SMTP id f19-20020a05600c4e9300b0041be55c8e0dmr3154987wmq.14.1714625669998;
        Wed, 01 May 2024 21:54:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d5404000000b0034ca136f0e9sm240922wrv.88.2024.05.01.21.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:54:29 -0700 (PDT)
Message-Id: <pull.1696.v4.git.1714625667.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
References: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 May 2024 04:54:17 +0000
Subject: [PATCH v4 00/10] Make trailer_info struct private (plus sequencer cleanup)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linus@ucla.edu>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linus@ucla.edu>

NOTE: This series is based on the la/format-trailer-info topic branch (see
its discussion at [1]).

This series is based on the initial series [2], notably the v4 version of
patches 17-20 as suggested by Christian [3]. This version addresses the
review comments for those patches, namely the splitting up of Patch 19 there
into 3 separate patches [4] (as Patches 05-07 here) .

The central idea is to make the trailer_info struct private (that is, move
its definition from trailer.h to trailer.c) --- aka the "pimpl" idiom. See
the detailed commit message for Patch 07 for the motivation behind the
change.

Patch 04 makes sequencer.c a well-behaved trailer API consumer, by making
use of the trailer iterator. Patch 03 prepares us for Patch 04. Patch 08
slightly reduces the weight of the API by removing (from the API surface) an
unused function.


Notable changes in v4
=====================

 * Drop "25%" language in Patch 03
 * Rename some variables
 * Update patch emails to personal (linus@ucla.edu) email


Notable changes in v3
=====================

 * (NEW Patch 10) Expand test coverage to check the contents of each
   iteration (raw, key, val fields), not just the total number of iterations
 * (NEW Patch 09) Add documentation in <trailer.h> for using
   parse_trailers()
 * (unrelated) I will lose access to my linusa@google.com email address
   tomorrow (I'm switching jobs!) and so future emails from me will come
   from linus@ucla.edu [5]. I've added the latter email to the CC list here
   so things should just work. Cheers


Notable changes in v2
=====================

 * Add unit tests at the beginning of the series (Patches 01 and 02) and use
   it to verify that the other edge cases remain unchanged when we add the
   "raw" member (Patch 03)

[1]
https://lore.kernel.org/git/pull.1694.git.1710485706.gitgitgadget@gmail.com/
[2]
https://lore.kernel.org/git/pull.1632.v4.git.1707196348.gitgitgadget@gmail.com/
[3]
https://lore.kernel.org/git/CAP8UFD08F0V13X0+CJ1uhMPzPWVMs2okGVMJch0DkQg5M3BWLA@mail.gmail.com/
[4]
https://lore.kernel.org/git/CAP8UFD1twELGKvvesxgCrZrypKZpgSt04ira3mvurG1UbpDfxQ@mail.gmail.com/
[5]
https://lore.kernel.org/git/pull.1720.git.1713309711217.gitgitgadget@gmail.com/

Linus Arver (10):
  Makefile: sort UNIT_TEST_PROGRAMS
  trailer: add unit tests for trailer iterator
  trailer: teach iterator about non-trailer lines
  sequencer: use the trailer iterator
  interpret-trailers: access trailer_info with new helpers
  trailer: make parse_trailers() return trailer_info pointer
  trailer: make trailer_info struct private
  trailer: retire trailer_info_get() from API
  trailer: document parse_trailers() usage
  trailer unit tests: inspect iterator contents

 Makefile                     |   5 +-
 builtin/interpret-trailers.c |  12 +-
 sequencer.c                  |  27 ++-
 t/unit-tests/t-trailer.c     | 315 +++++++++++++++++++++++++++++++++++
 trailer.c                    | 167 ++++++++++++-------
 trailer.h                    |  94 +++++++----
 6 files changed, 506 insertions(+), 114 deletions(-)
 create mode 100644 t/unit-tests/t-trailer.c


base-commit: 3452d173241c8b87ecdd67f91f594cb14327e394
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1696%2Flistx%2Ftrailer-api-part-3-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1696/listx/trailer-api-part-3-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1696

Range-diff vs v3:

  1:  b6a1304f8ae !  1:  8a9f71442d8 Makefile: sort UNIT_TEST_PROGRAMS
     @@
       ## Metadata ##
     -Author: Linus Arver <linusa@google.com>
     +Author: Linus Arver <linus@ucla.edu>
      
       ## Commit message ##
          Makefile: sort UNIT_TEST_PROGRAMS
      
     -    Signed-off-by: Linus Arver <linusa@google.com>
     +    Signed-off-by: Linus Arver <linus@ucla.edu>
      
       ## Makefile ##
      @@ Makefile: THIRD_PARTY_SOURCES += sha1collisiondetection/%
  2:  4ad0fbbb33c !  2:  b503b539c6f trailer: add unit tests for trailer iterator
     @@
       ## Metadata ##
     -Author: Linus Arver <linusa@google.com>
     +Author: Linus Arver <linus@ucla.edu>
      
       ## Commit message ##
          trailer: add unit tests for trailer iterator
     @@ Commit message
          implementation details which are, unlike the API, subject to drastic
          changes).
      
     -    Signed-off-by: Linus Arver <linusa@google.com>
     +    Signed-off-by: Linus Arver <linus@ucla.edu>
      
       ## Makefile ##
      @@ Makefile: UNIT_TEST_PROGRAMS += t-ctype
  3:  9077d5a315d !  3:  4aeb48050b1 trailer: teach iterator about non-trailer lines
     @@
       ## Metadata ##
     -Author: Linus Arver <linusa@google.com>
     +Author: Linus Arver <linus@ucla.edu>
      
       ## Commit message ##
          trailer: teach iterator about non-trailer lines
     @@ Commit message
          for non-trailer lines, making the comparison still work even with this
          commit).
      
     -    Rename "num_expected_trailers" to "num_expected_objects" in
     +    Rename "num_expected_trailers" to "num_expected" in
          t/unit-tests/t-trailer.c because the items we iterate over now include
          non-trailer lines.
      
     -    Signed-off-by: Linus Arver <linusa@google.com>
     +    Signed-off-by: Linus Arver <linus@ucla.edu>
      
       ## t/unit-tests/t-trailer.c ##
      @@
     @@ t/unit-tests/t-trailer.c
       #include "trailer.h"
       
      -static void t_trailer_iterator(const char *msg, size_t num_expected_trailers)
     -+static void t_trailer_iterator(const char *msg, size_t num_expected_objects)
     ++static void t_trailer_iterator(const char *msg, size_t num_expected)
       {
       	struct trailer_iterator iter;
       	size_t i = 0;
     @@ t/unit-tests/t-trailer.c: static void t_trailer_iterator(const char *msg, size_t
       	trailer_iterator_release(&iter);
       
      -	check_uint(i, ==, num_expected_trailers);
     -+	check_uint(i, ==, num_expected_objects);
     ++	check_uint(i, ==, num_expected);
       }
       
       static void run_t_trailer_iterator(void)
     @@ t/unit-tests/t-trailer.c: static void run_t_trailer_iterator(void)
       		const char *name;
       		const char *msg;
      -		size_t num_expected_trailers;
     -+		size_t num_expected_objects;
     ++		size_t num_expected;
       	} tc[] = {
       		{
       			"empty input",
     @@ t/unit-tests/t-trailer.c: static void run_t_trailer_iterator(void)
       	for (int i = 0; i < sizeof(tc) / sizeof(tc[0]); i++) {
       		TEST(t_trailer_iterator(tc[i].msg,
      -					tc[i].num_expected_trailers),
     -+					tc[i].num_expected_objects),
     ++					tc[i].num_expected),
       		     "%s", tc[i].name);
       	}
       }
     @@ trailer.h: void format_trailers_from_commit(const struct process_trailer_options
       struct trailer_iterator {
      +	/*
      +	 * Raw line (e.g., "foo: bar baz") before being parsed as a trailer
     -+	 * key/val pair as part of a trailer block. A trailer block can be
     -+	 * either 100% trailer lines, or mixed in with non-trailer lines (in
     -+	 * which case at least 25% must be trailer lines).
     ++	 * key/val pair as part of a trailer block (as the "key" and "val"
     ++	 * fields below). If a line fails to parse as a trailer, then the "key"
     ++	 * will be the entire line and "val" will be the empty string.
      +	 */
      +	const char *raw;
     -+
       	struct strbuf key;
       	struct strbuf val;
       
  4:  4a1d18da574 !  4:  a3d080d4d6c sequencer: use the trailer iterator
     @@
       ## Metadata ##
     -Author: Linus Arver <linusa@google.com>
     +Author: Linus Arver <linus@ucla.edu>
      
       ## Commit message ##
          sequencer: use the trailer iterator
     @@ Commit message
          before when we iterated over the unparsed string array (char **trailers)
          in trailer_info.
      
     -    Signed-off-by: Linus Arver <linusa@google.com>
     +    Signed-off-by: Linus Arver <linus@ucla.edu>
      
       ## sequencer.c ##
      @@ sequencer.c: static const char *get_todo_path(const struct replay_opts *opts)
  5:  460979ba964 !  5:  44df42ca503 interpret-trailers: access trailer_info with new helpers
     @@
       ## Metadata ##
     -Author: Linus Arver <linusa@google.com>
     +Author: Linus Arver <linus@ucla.edu>
      
       ## Commit message ##
          interpret-trailers: access trailer_info with new helpers
     @@ Commit message
          implementation (and thus hidden from the API).
      
          Helped-by: Christian Couder <chriscool@tuxfamily.org>
     -    Signed-off-by: Linus Arver <linusa@google.com>
     +    Signed-off-by: Linus Arver <linus@ucla.edu>
      
       ## builtin/interpret-trailers.c ##
      @@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
  6:  d217858c637 !  6:  9ed7cef9d29 trailer: make parse_trailers() return trailer_info pointer
     @@
       ## Metadata ##
     -Author: Linus Arver <linusa@google.com>
     +Author: Linus Arver <linus@ucla.edu>
      
       ## Commit message ##
          trailer: make parse_trailers() return trailer_info pointer
     @@ Commit message
          format_trailers_from_commit() and trailer_iterator_init() accordingly.
      
          Helped-by: Christian Couder <chriscool@tuxfamily.org>
     -    Signed-off-by: Linus Arver <linusa@google.com>
     +    Signed-off-by: Linus Arver <linus@ucla.edu>
      
       ## builtin/interpret-trailers.c ##
      @@ builtin/interpret-trailers.c: static void interpret_trailers(const struct process_trailer_options *opts,
  7:  49c66c48cc1 !  7:  246ac9a5d07 trailer: make trailer_info struct private
     @@
       ## Metadata ##
     -Author: Linus Arver <linusa@google.com>
     +Author: Linus Arver <linus@ucla.edu>
      
       ## Commit message ##
          trailer: make trailer_info struct private
     @@ Commit message
      
          Helped-by: Junio C Hamano <gitster@pobox.com>
          Helped-by: Christian Couder <chriscool@tuxfamily.org>
     -    Signed-off-by: Linus Arver <linusa@google.com>
     +    Signed-off-by: Linus Arver <linus@ucla.edu>
      
       ## trailer.c ##
      @@
  8:  56e1cca4b7b !  8:  ca6f0c4208c trailer: retire trailer_info_get() from API
     @@
       ## Metadata ##
     -Author: Linus Arver <linusa@google.com>
     +Author: Linus Arver <linus@ucla.edu>
      
       ## Commit message ##
          trailer: retire trailer_info_get() from API
     @@ Commit message
          We have to also reposition it to be above parse_trailers(), which
          depends on it.
      
     -    Signed-off-by: Linus Arver <linusa@google.com>
     +    Signed-off-by: Linus Arver <linus@ucla.edu>
      
       ## trailer.c ##
      @@ trailer.c: static struct trailer_info *trailer_info_new(void)
  9:  35304837e08 !  9:  c1a0f1bed04 trailer: document parse_trailers() usage
     @@
       ## Metadata ##
     -Author: Linus Arver <linusa@google.com>
     +Author: Linus Arver <linus@ucla.edu>
      
       ## Commit message ##
          trailer: document parse_trailers() usage
     @@ Commit message
          comments a bit easier to read (because "head" itself doesn't really have
          any domain-specific meaning here).
      
     -    Signed-off-by: Linus Arver <linusa@google.com>
     +    Signed-off-by: Linus Arver <linus@ucla.edu>
      
       ## trailer.c ##
      @@ trailer.c: static struct trailer_info *trailer_info_get(const struct process_trailer_option
 10:  4d53707f836 ! 10:  310b632ddfd trailer unit tests: inspect iterator contents
     @@
       ## Metadata ##
     -Author: Linus Arver <linusa@google.com>
     +Author: Linus Arver <linus@ucla.edu>
      
       ## Commit message ##
          trailer unit tests: inspect iterator contents
     @@ Commit message
          iteration.
      
          Helped-by: Junio C Hamano <gitster@pobox.com>
     -    Signed-off-by: Linus Arver <linusa@google.com>
     +    Signed-off-by: Linus Arver <linus@ucla.edu>
      
       ## t/unit-tests/t-trailer.c ##
      @@
       #include "test-lib.h"
       #include "trailer.h"
       
     --static void t_trailer_iterator(const char *msg, size_t num_expected_objects)
     -+struct trailer_assertions {
     +-static void t_trailer_iterator(const char *msg, size_t num_expected)
     ++struct contents {
      +	const char *raw;
      +	const char *key;
      +	const char *val;
      +};
      +
     -+static void t_trailer_iterator(const char *msg, size_t num_expected_objects,
     -+			       struct trailer_assertions *trailer_assertions)
     ++static void t_trailer_iterator(const char *msg, size_t num_expected,
     ++			       struct contents *contents)
       {
       	struct trailer_iterator iter;
       	size_t i = 0;
     @@ t/unit-tests/t-trailer.c
       	trailer_iterator_init(&iter, msg);
      -	while (trailer_iterator_advance(&iter))
      +	while (trailer_iterator_advance(&iter)) {
     -+		if (num_expected_objects) {
     -+			check_str(iter.raw, trailer_assertions[i].raw);
     -+			check_str(iter.key.buf, trailer_assertions[i].key);
     -+			check_str(iter.val.buf, trailer_assertions[i].val);
     ++		if (num_expected) {
     ++			check_str(iter.raw, contents[i].raw);
     ++			check_str(iter.key.buf, contents[i].key);
     ++			check_str(iter.val.buf, contents[i].val);
      +		}
       		i++;
      +	}
       	trailer_iterator_release(&iter);
       
     - 	check_uint(i, ==, num_expected_objects);
     -@@ t/unit-tests/t-trailer.c: static void t_trailer_iterator(const char *msg, size_t num_expected_objects)
     + 	check_uint(i, ==, num_expected);
     +@@ t/unit-tests/t-trailer.c: static void t_trailer_iterator(const char *msg, size_t num_expected)
       
       static void run_t_trailer_iterator(void)
       {
     @@ t/unit-tests/t-trailer.c: static void t_trailer_iterator(const char *msg, size_t
       	static struct test_cases {
       		const char *name;
       		const char *msg;
     - 		size_t num_expected_objects;
     -+		struct trailer_assertions trailer_assertions[10];
     + 		size_t num_expected;
     ++		struct contents contents[10];
       	} tc[] = {
       		{
       			"empty input",
     @@ t/unit-tests/t-trailer.c: static void run_t_trailer_iterator(void)
       
       	for (int i = 0; i < sizeof(tc) / sizeof(tc[0]); i++) {
       		TEST(t_trailer_iterator(tc[i].msg,
     --					tc[i].num_expected_objects),
     -+					tc[i].num_expected_objects,
     -+					tc[i].trailer_assertions),
     +-					tc[i].num_expected),
     ++					tc[i].num_expected,
     ++					tc[i].contents),
       		     "%s", tc[i].name);
       	}
       }

-- 
gitgitgadget
