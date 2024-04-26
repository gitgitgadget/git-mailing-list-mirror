Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC0364
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 00:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091176; cv=none; b=LIFmH0lKdIrOyfBqybSd2oc4d8OM3Pf4tzczhI5wQaIXPzXU5ijYyRZNPabhyQdPuMhCqMrB+RK30QcT2XCOz57CJJAUoF0+YKn1RD1U2sGu9cO0xF/QSFY9EIbubr+ChgYMmR3eOp9aTcdrXqmRNDk9tRAvXRlXDf9d24RPcQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091176; c=relaxed/simple;
	bh=IE36wALklEj+57PfsBOfVzbhkf4k3AzTqvlm3gEP/GM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=WUnQ3d4+ZNpwPN5qflv1axh+F81j/+/Y3plK112vxm2QoZEZPEbwKFwCqEpisaivIJA2u03mhTz8D84ZofzA/maCqry3kSYHTtOuXpe/sKRbgjCU5sTmWqiuDKe2tGKck9y9Au4AzkbTV6KecYjHAd5uR9KBjKp31EjnD7bXp8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMdST5Ki; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMdST5Ki"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34665dd7610so716625f8f.3
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 17:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714091172; x=1714695972; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGFdJ2hXi6l38toI72rNERzUd/Ej/tKevnHwSkUqEOw=;
        b=QMdST5Kipj59i5eRkX8Jk+6lOvuxTutKn3jK0fIFcVwrRcUnNE5Vj46jktlefVMW5c
         z8ExS4qrQIoBC+Hxjp9oHHU+wRQFTcrQvuFvcyNWeH81mSn1V3C2rCgVSr//KSe7vtB+
         7bMbrKasYAZuOrqvohzLx4JGVktd3FULm9WXrpjvduHBLXkiGhR77apTjlXK8g469L27
         joG5XutStWPC8o+/6wSvNo2vOvKVZEizwIrXKMJ1517aq8lziio1MZWAxkd/WJ+nJTb5
         uPlGEbTLl5kprXqdF52cs87mcT2BKcrY8STc1RToS+kdX1VjOCEd9OpdCakxfyItqK2l
         Ze1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714091172; x=1714695972;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGFdJ2hXi6l38toI72rNERzUd/Ej/tKevnHwSkUqEOw=;
        b=fRjKQFJIHQwk92VkhFVyiyT127bEp9gMPJmqkExjW9/1Juj8Uo/zRrLb84TqDcOOPW
         AtJ8yYbvrLdzwRU0aNUCUdpPAiqyseAMQBFEiQTTBR47n93yqOiCS/is98pvij5LD1HT
         ahIVHe9u/ifECcad8fe8Rwgb1VTzYUMH7gOTNswIVD2aV3eXaXDcYWTrRiQVM9QEuICX
         axgKifA1U5QH0bWQi7BcDngscsrf7Damj/zeIjUxXjcglanS7cqIOcTREhTfrwsQgb8s
         idv36Zbh46YB5MkYYoixAjLBmBQtudI5aAsEDqznyjIxlv5Sp6Fto6qR2Uyr2ZEQt3Tq
         Keiw==
X-Gm-Message-State: AOJu0YzKsFKDVVLh4UhwzfnmgnZfBGMd54wMs5sWk19GHYtW2+xdmZEk
	0upi2AGp9sbX5XHXu9bAYKqkgzowe98kFZD4UaR3y6Ntcy2WIrUvQifmkw==
X-Google-Smtp-Source: AGHT+IGPjgTTNK6UiUfPjf1SVmNSH9x+Aq0aysnUa8tTYTdg2Wk0NBLUfg18/ktpRS1/lCFdaM5E3Q==
X-Received: by 2002:adf:eb8a:0:b0:343:f2f1:21c1 with SMTP id t10-20020adfeb8a000000b00343f2f121c1mr618761wrn.24.1714091172131;
        Thu, 25 Apr 2024 17:26:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bf7-20020a0560001cc700b003439d2a5f99sm20967691wrb.55.2024.04.25.17.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 17:26:11 -0700 (PDT)
Message-Id: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Apr 2024 00:26:00 +0000
Subject: [PATCH v3 00/10] Make trailer_info struct private (plus sequencer cleanup)
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
    Linus Arver <linusa@google.com>

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
 trailer.h                    |  95 +++++++----
 6 files changed, 507 insertions(+), 114 deletions(-)
 create mode 100644 t/unit-tests/t-trailer.c


base-commit: 3452d173241c8b87ecdd67f91f594cb14327e394
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1696%2Flistx%2Ftrailer-api-part-3-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1696/listx/trailer-api-part-3-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1696

Range-diff vs v2:

  1:  b6a1304f8ae =  1:  b6a1304f8ae Makefile: sort UNIT_TEST_PROGRAMS
  2:  e1fa05143ac !  2:  4ad0fbbb33c trailer: add unit tests for trailer iterator
     @@ t/unit-tests/t-trailer.c (new)
      +	size_t i = 0;
      +
      +	trailer_iterator_init(&iter, msg);
     -+	while (trailer_iterator_advance(&iter)) {
     ++	while (trailer_iterator_advance(&iter))
      +		i++;
     -+	}
      +	trailer_iterator_release(&iter);
      +
      +	check_uint(i, ==, num_expected_trailers);
     @@ t/unit-tests/t-trailer.c (new)
      +			/*
      +			 * Even though this trailer block has a non-trailer line
      +			 * in it, it's still a valid trailer block because it's
     -+			 * at least 25% trailers and is Git-generated.
     ++			 * at least 25% trailers and is Git-generated (see
     ++			 * git_generated_prefixes[] in trailer.c).
      +			 */
      +			"not a trailer line\n"
      +			"not a trailer line\n"
     @@ t/unit-tests/t-trailer.c (new)
      +			"\n"
      +			/*
      +			 * This block has only 1 non-trailer out of 10 (IOW, 90%
     -+			 * trailers) but is not considered a trailer because the
     -+			 * 25% threshold only applies to cases where there was a
     -+			 * Git-generated trailer (see git_generated_prefixes[]
     -+			 * in trailer.c).
     ++			 * trailers) but is not considered a trailer block
     ++			 * because the 25% threshold only applies to cases where
     ++			 * there was a Git-generated trailer.
      +			 */
      +			"Reviewed-by: x\n"
      +			"Reviewed-by: x\n"
  3:  5520a98e296 !  3:  9077d5a315d trailer: teach iterator about non-trailer lines
     @@ Commit message
          for non-trailer lines, making the comparison still work even with this
          commit).
      
     +    Rename "num_expected_trailers" to "num_expected_objects" in
     +    t/unit-tests/t-trailer.c because the items we iterate over now include
     +    non-trailer lines.
     +
          Signed-off-by: Linus Arver <linusa@google.com>
      
       ## t/unit-tests/t-trailer.c ##
     +@@
     + #include "test-lib.h"
     + #include "trailer.h"
     + 
     +-static void t_trailer_iterator(const char *msg, size_t num_expected_trailers)
     ++static void t_trailer_iterator(const char *msg, size_t num_expected_objects)
     + {
     + 	struct trailer_iterator iter;
     + 	size_t i = 0;
     +@@ t/unit-tests/t-trailer.c: static void t_trailer_iterator(const char *msg, size_t num_expected_trailers)
     + 		i++;
     + 	trailer_iterator_release(&iter);
     + 
     +-	check_uint(i, ==, num_expected_trailers);
     ++	check_uint(i, ==, num_expected_objects);
     + }
     + 
     + static void run_t_trailer_iterator(void)
     +@@ t/unit-tests/t-trailer.c: static void run_t_trailer_iterator(void)
     + 	static struct test_cases {
     + 		const char *name;
     + 		const char *msg;
     +-		size_t num_expected_trailers;
     ++		size_t num_expected_objects;
     + 	} tc[] = {
     + 		{
     + 			"empty input",
      @@ t/unit-tests/t-trailer.c: static void run_t_trailer_iterator(void)
       			"not a trailer line\n"
       			"not a trailer line\n"
     @@ t/unit-tests/t-trailer.c: static void run_t_trailer_iterator(void)
       		},
       		{
       			"with non-trailer lines (one too many) in trailer block",
     +@@ t/unit-tests/t-trailer.c: static void run_t_trailer_iterator(void)
     + 
     + 	for (int i = 0; i < sizeof(tc) / sizeof(tc[0]); i++) {
     + 		TEST(t_trailer_iterator(tc[i].msg,
     +-					tc[i].num_expected_trailers),
     ++					tc[i].num_expected_objects),
     + 		     "%s", tc[i].name);
     + 	}
     + }
      
       ## trailer.c ##
      @@ trailer.c: void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
  4:  84897cf5c83 =  4:  4a1d18da574 sequencer: use the trailer iterator
  5:  e961d49cd40 =  5:  460979ba964 interpret-trailers: access trailer_info with new helpers
  6:  093f68f3658 =  6:  d217858c637 trailer: make parse_trailers() return trailer_info pointer
  7:  0e9ae049b88 !  7:  49c66c48cc1 trailer: make trailer_info struct private
     @@ Commit message
            (2) external API users are unable to peer inside this struct (because
                it is only ever exposed as an opaque pointer).
      
     -    There are a couple disadvantages:
     +    There are a few disadvantages:
      
            (A) every time the member of the struct is accessed an extra pointer
                dereference must be done, and
     @@ Commit message
            (B) for users of trailer_info outside trailer.c, this struct can no
                longer be allocated on the stack and may only be allocated on the
                heap (because its definition is hidden away in trailer.c) and
     -          appropriately deallocated by the user.
     +          appropriately deallocated by the user, and
     +
     +      (C) without good documentation on the API, the opaque struct is
     +          hostile to programmers by going opposite to the "Show me your
     +          data structures, and I won't usually need your code; it'll
     +          be obvious." mantra [2].
      
          (The disadvantages have already been observed in the two preparatory
          commits that precede this one.) This commit believes that the benefits
     @@ Commit message
          [1] Hanson, David R. "C Interfaces and Implementations: Techniques for
              Creating Reusable Software". Addison Wesley, 1997. p. 22
      
     +    [2] Raymond, Eric S. "The Cathedral and the Bazaar: Musings on Linux and
     +        Open Source by an Accidental Revolutionary". O'Reilly, 1999.
     +
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Helped-by: Christian Couder <chriscool@tuxfamily.org>
          Signed-off-by: Linus Arver <linusa@google.com>
      
  8:  eca77a1a462 =  8:  56e1cca4b7b trailer: retire trailer_info_get() from API
  -:  ----------- >  9:  35304837e08 trailer: document parse_trailers() usage
  -:  ----------- > 10:  4d53707f836 trailer unit tests: inspect iterator contents

-- 
gitgitgadget
