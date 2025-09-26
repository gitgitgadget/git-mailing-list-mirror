Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393710E0
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871559; cv=none; b=t7MAyJ/nmqoWFT/Kox/gIbe6fRU3/0RGB+Cmrtmf9hjXyBCqBGMhr7J+TgJz66cjfpXUNOrIZO3SotSTsSfjgpzO9oAQJmN8yMaFA/X1LtvIehWC/DJtu9i0WmyLhPY4KDEL8jMN1yNkxH3nPWpaHulhIozu8ewtCBawaw4H5g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871559; c=relaxed/simple;
	bh=JH7+hzo96RZFA0fJ/oTR97bI7I3kubQm4EtqpiXk2/w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=WiAZvz4h0lifv3hguxeR4RDKPGU0fnaDYw5xhrQS/2/owFzQiADrD+cHwQFCoBUfz9KnZROduDVM+4VFnS71IluZ/+tWesYE7OoUsz+S8W8PMlyLqY3RpQYwc2FdeqTdkLVJXcXnoomQ/nUSndc0+yM6zlWkW2t9lse67Fr4xMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqO2TYgP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqO2TYgP"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62fa99bcfcdso3646763a12.0
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 00:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758871555; x=1759476355; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YotAS+e+SZ/McF02DQkqqtSuz5m0xU5pgWVbRZQYo/E=;
        b=PqO2TYgP4EZCan2T4BKzK9x2qcZE7h5OdsE4gTGEbgq5ZZi/QcPUhmHgV83t8Kj7kL
         uQVou67ugNO7pSyzxS/63Xx2Dm3pm++o0KN5PrrVqGcu5Fw6qSSh10q/ATAJX+l+2uzb
         aQACVsszHbZ3X1ZBT5AM/w1td0wvrvRk91chbzx36EcK9X78a41x40TzGSDEt9Uj3Gos
         5qAzUee+IQ4rINpWlVzvE6wYcNUQTFQzx4xoO/90+zVgV2Ht2ciegclKSeOKatA/euCV
         0ygf3uftCBoAd0cnhgf97DppzFLy4XAu6AoKvTUvMylsUdGIw0UVcGK3oOJY3IP8Vs8/
         eGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871555; x=1759476355;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YotAS+e+SZ/McF02DQkqqtSuz5m0xU5pgWVbRZQYo/E=;
        b=J9Dsl04j1mQr5lyF5xbub4g6/nebUEZ7VT1C2Mtf7EVSscj604jM04g6L8ikSAP/Fs
         o+5w286vLnPQDUxqjZINpCDWgbB0YAztd+wRd9rQOyehJbAWEjxV25iZbnoipO+Uzelr
         ue0BGxUOa2Tu/Z1S1I/vNFmABMHCiE+IuHEmkrECSgR7IDXuYbZ5ZkO+WXZBNHefSrCc
         Fw+H7Xvs29JGaXPQaubfV1BmvUSlY4qH6of0yFhZG7Z8FfyMIrNWPO5CzQJZ1fxi1CnH
         p8w+HNGJDJfdxMoiFcWizfmQZgzxLPoArkkfT2SE1PQRx9ClUETckiYwWWEwtiARHGbs
         ZHDA==
X-Gm-Message-State: AOJu0YwsUPiUMtJnwDoZGRMOQrdwRdyMbflf01fjXD6JaNR+KqD1DvhS
	Wg/PHr3bBEhB2nq5PTtyScyJTTtYupVkkmqii5rEKNGOzCdamTYHl6Th
X-Gm-Gg: ASbGncvZYwiSgOHRaBg1oaFM/liOvoPoEhgcjQGI3YUeKek+fCcRIip5/OWpBYd/HII
	Z5a7oE0BnXDsSJ6zXy/ct2JCFYi3B9O43TsUarnp++awxsiged1lNmC8iIMuTwkTo4NlK7B3/4Q
	tQhwahaM/+HZRIqeuTSRDCR4H+EMGr8wqGy+4mn/FzhRCDbpDQ1Iy1FxOY4lxDYwvEeLIO/X0Ve
	/svNdD3bdeNfVzHOjqMezjfe5DMuLtVYb/IfQ7et5mnr1fqSbyhCL27FqJFOKkSuAEZ3GEEzSo2
	lT38p6Rq22IIOfkwu/gPeuwrKlx9itwb1BfRmA1blbqbP5wvD6D035N518eoWNAnjOWOk0dzJ6j
	yV6gATxkH6u91e8S/hiDnnCQs+bRP
X-Google-Smtp-Source: AGHT+IGhBun0vP9+wyUu/JGlRBb+qApthGSHCInAAE3wjzlVapp24IMeHFcCQx1N7FyBUsbfKVQ7Jw==
X-Received: by 2002:a05:6402:160c:b0:62f:41d3:ece7 with SMTP id 4fb4d7f45d1cf-6349fa1b9a4mr4137327a12.14.1758871554247;
        Fri, 26 Sep 2025 00:25:54 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:2fd5:3bfb:87f3:d768])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af54desm2368795a12.40.2025.09.26.00.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:25:53 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 0/7] refs/reftable: add consistency checks
Date: Fri, 26 Sep 2025 09:25:43 +0200
Message-Id: <20250926-228-reftable-introduce-consistency-checks-v4-0-c96fd8551c0d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPg/1mgC/5XNu64CIRSF4Vcx1GK4KXAq38NYMLBxiAonME40Z
 t7drRYauykXl++/kwY1QSN/izupMKaWSsahlgvie5cPQFPATQQTa6a5okIYWiEOrjvhXR5qCRc
 P1JfcUhsg+xv1Pfhjo1LbAMFKv1aKoPeP39L11drtcff4vtTbKz3y5+m7YridURk5ZdR0Jm6Mt
 tFZ2B7OLp1WvpzJszKKj2yZmCMLlFW0m04aqbS2v7L8krmZI0uUheYuMgmdVOFbnqbpAaZX8fi
 WAQAA
X-Change-ID: 20250714-228-reftable-introduce-consistency-checks-379ded93c544
In-Reply-To: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, gitster@pobox.com, 
 shejialuo@gmail.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=21951;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=JH7+hzo96RZFA0fJ/oTR97bI7I3kubQm4EtqpiXk2/w=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjWP/6NQYL/IE2mxMUWMjqEj1Vpb+XSosceF
 xxHGJL8rLvKVokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo1j/+AAoJED7VnySO
 Rox/vtUMAJnETclO38wGa5jv7kE3pbcDws9xEjtplGMxuIbYNWVZbS3SwYIdq0lZ5EMYoos5f/I
 54YXY7y0cxoM9A/7cUbkfqZ85vUTic1NRwB/SM4Ysbgqjq8MPP3pxxnj/6UmdjMw5motuzgfotc
 mwWFOyb9NU50SRt7I97f4K9Yp+ZrDwe//W7ur0gN/Q/D5dxMDyGhTiLBEXW7Vx77D6CLOOCshV3
 OJv9N5H+N6X8rP1r5aG4JltjEKw1lTWeNiogcPa+CYxdRHnwD/irsPuNiK88DU4ROFxPwwkLrlQ
 38A7WNAjpRYjnHUOAocpgI0t0vVEJSpFMJ13VCaxl+ZQmQ5vcOu4lZu/qGkYzYpkOFIwKNW5rBO
 wrur5Rlceu46KKGW1rqKS3NELwcvX85kSSMp8CnyriQ7p5ortOBw/BNV2prJc7gEEBV1ZxguFGY
 lzpEOTrXYulKr4DujghwLAlLFWaFyvpWBIKgmZI4yo1rA/ZbBr+8q3koeuPaECjjNN21+sN3Pe8
 cw=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The reference subsystems allows for adding backend specific consistency
checks. These checks are run as part of 'git refs verify'.

While the files backend has some consistency checks added, the reftable
backend currently has none. This series first tightens the reftable
backend to make it a little more strict and then also adds the required
infrastructure and some simple consistency checks.

Since the reftable backend is treated as a library within the Git
codebase, we don't want to spillover our internal fsck implementation
into the library. At the same time, the fsck checks need to access
internal structures of the reftable library which aren't exposed outside
the library.

So we solve this by adding a 'reftable/fsck.[ch]' which implements and
exposes a checker for the reftable library and returns specific errors
as defined by the library. We then add glue code within
'refs/reftable-backend.c' to map these errors to errors which Git's fsck
implementation would understand. This allows us to separate concerns.

We add the following consistency checks:

  1. Check for validating the reftable table name. This is treated as a
  warning since the reftable specification only suggests a table name
  but doesn't enforce it. Also there is a difference in the table name
  used in Git vs that in jGit.

We tighten the reftable backend by raising a REFTABLE_FORMAT_ERROR error
when:

1. The 'tables.list' file doesn't have a trailing newline.

---
Changes in v4:
- The biggest change is to iterate over the tables in a reftable stack
  for consistency checks instead of all files inside the REFTABLE_DIR.
  This avoids all race conditions. Also, since we only check the tables
  in a stack, it no longer makes sense to check file type.
- The discussion about update indices was concluded that tables indices
  in a stack must be strictly monotonically increasing. While modifying
  the code to do the same. I realized that we already have this check in
  'reftable_addition_add()' where we check while adding a new table to
  the stack: `wr->min_update_index < add->next_update_index`. So I've
  dropped this patch from the series.
- Change parse_names() to accept the output string array as an argument
  and return an error instead. This makes the flow a little easier to
  understand.
- Link to v3: https://lore.kernel.org/r/20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com

Changes in v3:
- I took a long hiatus from this topic, mostly due to other priorities.
  This has been rebased on top of '92c87bdc40 (The eighth batch,
  2025-09-12)' since there were conflicts.
- Junio suggested that two of the consistency checks (trailing newlines,
  sequential update indices for tables in stack) should actually be
  checked during runtime. I have made that change in this version.
- I've cleaned up the code and modularized the 'reftable/fsck.c' code.
- Invalid table name emits a warning, since the reftable spec doesn't
  enforce it but only makes a suggestion.
- Broken down the commits to make it easier to review.
- Link to v2: https://lore.kernel.org/r/20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com

Changes in v2:
- Ensured that 'struct reftable_fsck_info' is passed around as a
  pointer, this provides a smaller footprint (pointer size vs struct
  size).
- Run FSCK checks for other worktrees too, even if one of them fails.
- Separate messaging for table name vs table check and add additional
  test.
- Use the relative path in messages used.
- Small style and typo fixes.
- Link to v1: https://lore.kernel.org/r/20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com

---
 Documentation/fsck-msgids.adoc   |   6 +--
 Makefile                         |   3 +-
 fsck.h                           |  39 +++++++--------
 meson.build                      |   1 +
 refs.c                           |   4 ++
 refs/debug.c                     |   1 -
 refs/files-backend.c             |   3 --
 refs/reftable-backend.c          |  58 ++++++++++++++++++++---
 reftable/basics.c                |  37 ++++++++++-----
 reftable/basics.h                |   5 +-
 reftable/fsck.c                  | 100 +++++++++++++++++++++++++++++++++++++++
 reftable/reftable-fsck.h         |  40 ++++++++++++++++
 reftable/stack.c                 |   7 +--
 t/meson.build                    |   1 +
 t/t0614-reftable-fsck.sh         |  38 +++++++++++++++
 t/unit-tests/u-reftable-basics.c |  24 ++++++++--
 16 files changed, 308 insertions(+), 59 deletions(-)

Karthik Nayak (7):
      refs: remove unused headers
      refs: move consistency check  msg to generic layer
      reftable: check for trailing newline in 'tables.list'
      Documentation/fsck-msgids: remove duplicate msg id
      fsck: order 'fsck_msg_type' alphabetically
      reftable: add code to facilitate consistency checks
      refs/reftable: add fsck check for checking the table name

Range-diff versus v3:

1:  4522c10e6e = 1:  b91194e060 refs: remove unused headers
2:  40a83fc6fa = 2:  d48afbf588 refs: move consistency check  msg to generic layer
3:  df401e46f7 ! 3:  cd7ca2a585 reftable: check for trailing newline in 'tables.list'
    @@ Metadata
      ## Commit message ##
         reftable: check for trailing newline in 'tables.list'
     
    -    In the reftable format, the 'tables.list' file contains a newline
    -    separated list of tables. While we parse this file, we do not check or
    -    care about trailing newlines. Tighten the parser in `parse_names()` to
    -    return an appropriate error if there is no trailing newline.
    +    In the reftable format, the 'tables.list' file contains a
    +    newline separated list of tables. While we parse this file, we do not
    +    check or care about the last newline. Tighten the parser in
    +    `parse_names()` to return an appropriate error if the last newline is
    +    missing.
     
    -    This requires modification to `parse_names()` to accept a third argument
    -    which will hold the error value.
    +    This requires modification to `parse_names()` to now return the error
    +    while accepting the output as a third argument.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ reftable/basics.c: size_t names_length(const char **names)
      }
      
     -char **parse_names(char *buf, int size)
    -+char **parse_names(char *buf, int size, int *err)
    ++int parse_names(char *buf, int size, char ***out)
      {
      	char **names = NULL;
      	size_t names_cap = 0;
    -@@ reftable/basics.c: char **parse_names(char *buf, int size)
    + 	size_t names_len = 0;
    + 	char *p = buf;
    + 	char *end = buf + size;
    ++	int err = 0;
      
      	while (p < end) {
      		char *next = strchr(p, '\n');
     -		if (next && next < end) {
    +-			*next = 0;
     +		if (!next) {
    -+			*err = REFTABLE_FORMAT_ERROR;
    ++			err = REFTABLE_FORMAT_ERROR;
     +			goto done;
     +		} else if (next < end) {
    - 			*next = 0;
    ++			*next = '\0';
      		} else {
      			next = end;
      		}
    @@ reftable/basics.c: char **parse_names(char *buf, int size)
     -						names_cap))
     -				goto err;
     +						names_cap)) {
    -+				*err = REFTABLE_OUT_OF_MEMORY_ERROR;
    ++				err = REFTABLE_OUT_OF_MEMORY_ERROR;
     +				goto done;
     +			}
      
    @@ reftable/basics.c: char **parse_names(char *buf, int size)
     -			if (!names[names_len++])
     -				goto err;
     +			if (!names[names_len++]) {
    -+				*err = REFTABLE_OUT_OF_MEMORY_ERROR;
    ++				err = REFTABLE_OUT_OF_MEMORY_ERROR;
     +				goto done;
     +			}
      		}
    @@ reftable/basics.c: char **parse_names(char *buf, int size)
     -	if (REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap))
     -		goto err;
     +	if (REFTABLE_ALLOC_GROW(names, names_len + 1, names_cap)) {
    -+		*err = REFTABLE_OUT_OF_MEMORY_ERROR;
    ++		err = REFTABLE_OUT_OF_MEMORY_ERROR;
     +		goto done;
     +	}
      	names[names_len] = NULL;
      
    - 	return names;
    - 
    +-	return names;
    +-
     -err:
    ++	*out = names;
    ++	return 0;
     +done:
      	for (size_t i = 0; i < names_len; i++)
      		reftable_free(names[i]);
      	reftable_free(names);
    +-	return NULL;
    ++	return err;
    + }
    + 
    + int names_equal(const char **a, const char **b)
     
      ## reftable/basics.h ##
     @@ reftable/basics.h: void free_names(char **a);
    @@ reftable/basics.h: void free_names(char **a);
     - * without terminating '\0'. Empty names are discarded. Returns a `NULL`
     - * pointer when allocations fail.
     + * without terminating '\0'. Empty names are discarded.
    -+ *
    -+ * Errors are assigned to the `err` variable.
       */
     -char **parse_names(char *buf, int size);
    -+char **parse_names(char *buf, int size, int *err);
    ++int parse_names(char *buf, int size, char ***out);
      
      /* compares two NULL-terminated arrays of strings. */
      int names_equal(const char **a, const char **b);
    @@ reftable/stack.c: static int fd_read_lines(int fd, char ***namesp)
     -	*namesp = parse_names(buf, size);
     -	if (!*namesp) {
     -		err = REFTABLE_OUT_OF_MEMORY_ERROR;
    -+	*namesp = parse_names(buf, size, &err);
    -+	if (!*namesp)
    - 		goto done;
    +-		goto done;
     -	}
    - 
    +-
    ++	err = parse_names(buf, size, namesp);
      done:
      	reftable_free(buf);
    + 	return err;
     
      ## t/unit-tests/u-reftable-basics.c ##
     @@ t/unit-tests/u-reftable-basics.c: license that can be found in the LICENSE file or at
    @@ t/unit-tests/u-reftable-basics.c: void test_reftable_basics__names_equal(void)
     -	char in2[] = "a\nb\nc";
     -	char **out = parse_names(in1, strlen(in1));
     +	char in2[] = "a\nb\nc\n";
    -+	int err = 0;
    -+	char **out = parse_names(in1, strlen(in1), &err);
    ++	char **out = NULL;
    ++	int err = parse_names(in1, strlen(in1), &out);
     +	cl_assert(err == 0);
      	cl_assert(out != NULL);
      	cl_assert_equal_s(out[0], "line");
    @@ t/unit-tests/u-reftable-basics.c: void test_reftable_basics__names_equal(void)
      	free_names(out);
      
     -	out = parse_names(in2, strlen(in2));
    -+	out = parse_names(in2, strlen(in2), &err);
    ++	out = NULL;
    ++	err = parse_names(in2, strlen(in2), &out);
     +	cl_assert(err == 0);
      	cl_assert(out != NULL);
      	cl_assert_equal_s(out[0], "a");
    @@ t/unit-tests/u-reftable-basics.c: void test_reftable_basics__parse_names(void)
     +void test_reftable_basics__parse_names_missing_newline(void)
     +{
     +	char in1[] = "line\nline2";
    -+	int err = 0;
    -+	char **out = parse_names(in1, strlen(in1), &err);
    ++	char **out = NULL;
    ++	int err = parse_names(in1, strlen(in1), &out);
     +	cl_assert(err == REFTABLE_FORMAT_ERROR);
     +	cl_assert(out == NULL);
     +}
    @@ t/unit-tests/u-reftable-basics.c: void test_reftable_basics__parse_names(void)
      {
      	char in[] = "a\n\nb\n";
     -	char **out = parse_names(in, strlen(in));
    -+	int err = 0;
    -+	char **out = parse_names(in, strlen(in), &err);
    -+	cl_assert(err ==  0);
    ++	char **out = NULL;
    ++	int err = parse_names(in, strlen(in), &out);
    ++	cl_assert(err == 0);
      	cl_assert(out != NULL);
      	cl_assert_equal_s(out[0], "a");
      	/* simply '\n' should be dropped as empty string */
4:  435707f26c < -:  ---------- reftable: ensure tables in a stack use sequential update indices
5:  ac6275ab87 = 4:  e3e0c0b4ae Documentation/fsck-msgids: remove duplicate msg id
6:  6c02925af1 = 5:  24a8d93adc fsck: order 'fsck_msg_type' alphabetically
7:  1ada7bc89c ! 6:  d83d763be1 reftable: add code to facilitate consistency checks
    @@ Commit message
         stack. The callee provides the function with callbacks to handle issue
         and information reporting.
     
    -    The added check, goes over all files in the reftable directory and
    -    validates that they have the expected file type and a valid name. It
    -    raises specific errors for both.
    +    The added check, goes over all tables in the reftable stack validates
    +    that they have a valid name. It not, it raises an error.
     
         While here, move 'reftable/error.o' in the Makefile to retain
         lexicographic ordering.
    @@ reftable/fsck.c (new)
     @@
     +#include "basics.h"
     +#include "reftable-fsck.h"
    ++#include "reftable-table.h"
     +#include "stack.h"
     +
    -+static bool valid_table_name(const char *name, uint64_t *min_update_index,
    -+			     uint64_t *max_update_index)
    ++static bool table_has_valid_name(const char *name)
     +{
     +	const char *ptr = name;
     +	char *endptr;
    @@ reftable/fsck.c (new)
     +	/* strtoull doesn't set errno on success */
     +	errno = 0;
     +
    -+	*min_update_index = strtoull(ptr, &endptr, 16);
    -+	if (errno == EINVAL)
    ++	strtoull(ptr, &endptr, 16);
    ++	if (errno)
     +		return false;
     +	ptr = endptr;
     +
    -+	if (strncmp(ptr, "-", 1))
    ++	if (*ptr != '-')
     +		return false;
     +	ptr++;
     +
    -+	*max_update_index = strtoull(ptr, &endptr, 16);
    -+	if (errno == EINVAL)
    ++	strtoull(ptr, &endptr, 16);
    ++	if (errno)
     +		return false;
     +	ptr = endptr;
     +
    @@ reftable/fsck.c (new)
     +	ptr++;
     +
     +	strtoul(ptr, &endptr, 16);
    -+	if (errno == EINVAL)
    ++	if (errno)
     +		return false;
     +	ptr = endptr;
     +
    @@ reftable/fsck.c (new)
     +	return true;
     +}
     +
    -+static int stack_check_all_files_in_dir(struct reftable_stack *stack,
    -+					reftable_fsck_report_fn report_fn,
    -+					void *cb_data)
    ++typedef int (*table_check_fn)(struct reftable_table *table,
    ++			      reftable_fsck_report_fn report_fn,
    ++			      void *cb_data);
    ++
    ++static int table_check_name(struct reftable_table *table,
    ++			    reftable_fsck_report_fn report_fn,
    ++			    void *cb_data)
     +{
    -+	DIR *dir = opendir(stack->reftable_dir);
    -+	struct reftable_fsck_info info;
    -+	struct dirent *d = NULL;
    -+	uint64_t min, max;
    -+	int err = 0;
    ++	if (!table_has_valid_name(table->name)) {
    ++		struct reftable_fsck_info info;
    ++
    ++		info.error = REFTABLE_FSCK_ERROR_TABLE_NAME;
    ++		info.msg = "invalid reftable table name";
    ++		info.path = table->name;
     +
    -+	if (!dir)
    -+		return 0;
    -+
    -+	while ((d = readdir(dir))) {
    -+		if (!strcmp(d->d_name, "tables.list"))
    -+			continue;
    -+
    -+		if ((d->d_name[0] == '.' &&
    -+		     (d->d_name[1] == '\0' ||
    -+		      (d->d_name[1] == '.' && d->d_name[2] == '\0'))))
    -+			continue;
    -+
    -+		if (d->d_type == DT_REG) {
    -+			if (!valid_table_name(d->d_name, &min, &max)) {
    -+				info.error = REFTABLE_FSCK_ERROR_TABLE_NAME;
    -+				info.msg = "file with invalid table name";
    -+				info.path = d->d_name;
    -+
    -+				err |= report_fn(&info, cb_data);
    -+			}
    -+		} else {
    -+			info.error = REFTABLE_FSCK_ERROR_INVALID_FILE_TYPE;
    -+			info.msg = "file with unexpected type";
    -+			info.path = d->d_name;
    -+
    -+			err |= report_fn(&info, cb_data);
    -+		}
    ++		return report_fn(&info, cb_data);
     +	}
     +
    -+	closedir(dir);
    -+	return err;
    ++	return 0;
     +}
     +
    -+static int stack_checks(struct reftable_stack *stack,
    ++static int table_checks(struct reftable_table *table,
     +			reftable_fsck_report_fn report_fn,
    ++			reftable_fsck_verbose_fn verbose_fn UNUSED,
     +			void *cb_data)
     +{
    -+	struct reftable_buf msg = REFTABLE_BUF_INIT;
    -+	char **names = NULL;
    ++	table_check_fn table_check_fns[] = {
    ++		table_check_name,
    ++		NULL,
    ++	};
     +	int err = 0;
     +
    -+	if (stack == NULL)
    -+		goto out;
    ++	for (size_t i = 0; table_check_fns[i]; i++)
    ++		err |= table_check_fns[i](table, report_fn, cb_data);
     +
    -+	err |= stack_check_all_files_in_dir(stack, report_fn, cb_data);
    -+
    -+out:
    -+	free_names(names);
    -+	reftable_buf_release(&msg);
     +	return err;
     +}
     +
    @@ reftable/fsck.c (new)
     +			reftable_fsck_verbose_fn verbose_fn,
     +			void *cb_data)
     +{
    -+	verbose_fn("Checking reftable: stack checks", cb_data);
    -+	return stack_checks(stack, report_fn, cb_data);
    ++	struct reftable_buf msg = REFTABLE_BUF_INIT;
    ++	int err = 0;
    ++
    ++	for (size_t i = 0; i < stack->tables_len; i++) {
    ++		reftable_buf_reset(&msg);
    ++		reftable_buf_addstr(&msg, "Checking table: ");
    ++		reftable_buf_addstr(&msg, stack->tables[i]->name);
    ++		verbose_fn(msg.buf, cb_data);
    ++
    ++		err |= table_checks(stack->tables[i], report_fn, verbose_fn, cb_data);
    ++	}
    ++
    ++	reftable_buf_release(&msg);
    ++	return err;
     +}
     
      ## reftable/reftable-fsck.h (new) ##
    @@ reftable/reftable-fsck.h (new)
     +#include "reftable-stack.h"
     +
     +enum reftable_fsck_error {
    -+	/* Non regular file in the reftable directory */
    -+	REFTABLE_FSCK_ERROR_INVALID_FILE_TYPE = 0,
     +	/* Invalid table name */
    -+	REFTABLE_FSCK_ERROR_TABLE_NAME,
    ++	REFTABLE_FSCK_ERROR_TABLE_NAME = 0,
     +	/* Used for bounds checking, must be last */
    -+	REFTABLE_FSCK_MAX_VALUE
    ++	REFTABLE_FSCK_MAX_VALUE,
     +};
     +
     +/* Represents an individual error encountered during the FSCK checks. */
8:  77be84e23f ! 7:  c49b7887d8 refs/reftable: add fsck check for checking the table name
    @@ Commit message
           ${min_update_index}-${max_update_index}-${random}.ref as a naming
           convention.
     
    -    So treat non-conformant file names as warnings. Introduce another check
    -    to check for file types, non-expected filetypes will be treated as
    -    errors.
    +    So treat non-conformant file names as warnings.
    +
    +    While adding the fsck header to 'refs/reftable-backend.c', modify the
    +    list to maintain lexicographical ordering.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    @@ Documentation/fsck-msgids.adoc
      `badReferentName`::
      	(ERROR) The referent name of a symref is invalid.
      
    -+`badReftableFiletype`::
    -+	(ERROR) File with unexpected type in reftable directory.
    -+
     +`badReftableTableName`::
     +	(WARN) A reftable table has an invalid name.
     +
    @@ Documentation/fsck-msgids.adoc
      
     
      ## fsck.h ##
    -@@ fsck.h: enum fsck_msg_type {
    - 	FUNC(BAD_PACKED_REF_HEADER, ERROR) \
    - 	FUNC(BAD_PARENT_SHA1, ERROR) \
    - 	FUNC(BAD_REFERENT_NAME, ERROR) \
    -+	FUNC(BAD_REFTABLE_FILETYPE, ERROR) \
    - 	FUNC(BAD_REF_CONTENT, ERROR) \
    - 	FUNC(BAD_REF_FILETYPE, ERROR) \
    - 	FUNC(BAD_REF_NAME, ERROR) \
     @@ fsck.h: enum fsck_msg_type {
      	FUNC(UNKNOWN_TYPE, ERROR) \
      	FUNC(ZERO_PADDED_DATE, ERROR) \
    @@ refs/reftable-backend.c: static int reftable_be_reflog_expire(struct ref_store *
     +}
     +
     +static const enum fsck_msg_id fsck_msg_id_map[] = {
    -+	[REFTABLE_FSCK_ERROR_INVALID_FILE_TYPE] = FSCK_MSG_BAD_REFTABLE_FILETYPE,
     +	[REFTABLE_FSCK_ERROR_TABLE_NAME] = FSCK_MSG_BAD_REFTABLE_TABLE_NAME,
     +};
     +
    @@ refs/reftable-backend.c: static int reftable_be_reflog_expire(struct ref_store *
     +	enum fsck_msg_id msg_id;
     +
     +	if (info->error < 0 || info->error >= REFTABLE_FSCK_MAX_VALUE)
    -+		BUG("unknown fsck error: %d", info->error);
    ++		BUG("unknown fsck error: %d", (int)info->error);
     +
     +	msg_id = fsck_msg_id_map[info->error];
     +
     +	if (!msg_id)
    -+		BUG("fsck_msg_id value missing for reftable error: %d", info->error);
    ++		BUG("fsck_msg_id value missing for reftable error: %d", (int)info->error);
     +
     +	return fsck_report_ref(o, &report, msg_id, "%s", info->msg);
     +}
    @@ t/t0614-reftable-fsck.sh (new)
     +			git refs verify 2>err &&
     +			test_must_be_empty err &&
     +
    -+			touch ".git/reftable/$TABLE_NAME" &&
    ++			EXISTING_TABLE=$(head -n1 .git/reftable/tables.list) &&
    ++			mv ".git/reftable/$EXISTING_TABLE" ".git/reftable/$TABLE_NAME" &&
    ++			sed "s/${EXISTING_TABLE}/${TABLE_NAME}/g" .git/reftable/tables.list > tables.list &&
    ++			mv tables.list .git/reftable/tables.list &&
     +
     +			git refs verify 2>err &&
     +			cat >expect <<-EOF &&
    -+			warning: ${TABLE_NAME}: badReftableTableName: file with invalid table name
    ++			warning: ${TABLE_NAME}: badReftableTableName: invalid reftable table name
     +			EOF
     +			test_cmp expect err
     +		)
     +	'
     +done
     +
    -+test_expect_success "invalid file type should be checked" '
    -+	test_when_finished "rm -rf repo" &&
    -+	git init repo &&
    -+	(
    -+		cd repo &&
    -+		git commit --allow-empty -m initial &&
    -+
    -+		git refs verify 2>err &&
    -+		test_must_be_empty err &&
    -+
    -+		mkdir ".git/reftable/foo" &&
    -+
    -+		test_must_fail git refs verify 2>err &&
    -+		cat >expect <<-EOF &&
    -+		error: foo: badReftableFiletype: file with unexpected type
    -+		EOF
    -+		test_cmp expect err
    -+	)
    -+'
    -+
     +test_done


base-commit: a483264b01b977f3e65a4419103c21e6af7412a2
change-id: 20250714-228-reftable-introduce-consistency-checks-379ded93c544

Thanks
- Karthik

