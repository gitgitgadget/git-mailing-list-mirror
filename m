Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E64683
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939854; cv=none; b=Pv6Q4q5FctOWSqPIpCyemjsakodu1O2eH9G5ZSBZ+vytVNr8rnOToXY/6l+s3s1wRA5JIoWClHHc1/zFIqFAzUjeuP37N7PzY4S6freEX47frOGXiqnxUHD33ULi544Sak7I6sUSdcNZNgSJKa0QVkxJmMR04JneYsTf8wC7Em0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939854; c=relaxed/simple;
	bh=fSnn05KgfT3k7qgeWN9WBrArTHwqbqYP39ymNfnmvLI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t9Po+DcGlKwjl8bgVkgAsbSph+D1bNNRaxSnv0KjRCxPSjYVJdbiD6zEmeRbfLGh/1QaCoTfQoiHVF7jt1ATHWlmuOWGeS40es3GQ+QZAgbxCv+D2XAT0DjuZ8r9BbI9O4QcAnZs09Hl0qoF7XUM3DsskjUWRh3sZx8xf4MMPdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4YE50ZoP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4YE50ZoP"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2904d0cad0so7167512276.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728939852; x=1729544652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQYj2/ASg+MLFTG1ljUfrV5FOwzhtwtLmlcc+T1afvY=;
        b=4YE50ZoPcZ3y72nUHoLcNVD3U3OGc7xkRTWzZGSCZ9S7dg925z+g2LScbyMoGhAuv6
         eq1UrGy30pbK4T/EwoVZS6OYXZf+XCcbHtF160EciBOKLN5BjLSVOlVc4VSyF52UBrsI
         GNtnrsN5TbuMlMmgeE1CkjjByixmvuaNAMDQ7NLN1jJYDXS4X6A4csIcnddX2etvTBm2
         VwY6931txN60MG1NvlzG8xk445lg6COqr4l8PI3Z+zUeMsUZiCmMA6MKqcd90qcySXpE
         d7Ph9sZ0Hi4gck799IYlTWkPkJPHIiWrWfdtlxt6COmDdljj+SWjXcmyhMjOYEtjPfxI
         TyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728939852; x=1729544652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQYj2/ASg+MLFTG1ljUfrV5FOwzhtwtLmlcc+T1afvY=;
        b=lM+diqnea0b/u2VvXOeIvW+W4nATA98BmVBGwC2kCQIAqKZe9DlU3Dc8MhkbvTLgi4
         90vzqjnaOPjenLIx+6+hrbICL/8UbA+38FNyAukSlj8fsEvZkGYHAFHx42SkREXQURLJ
         kl3gqFK5oqVt0MCjS+6KO/GHFaKu6uDH0QQ2WiFwkP/V8Gk32K1mQirYL0/slQFWdagZ
         a7/rJsK2azuHFDfxaQW8+WKyHaZ2QzI24p6ndF7d7DKrQ7uTTQ+kG2IOcIJBpctotMnP
         OP7wZHik6Zztm5lAgoUjmp1TfgstdNTtLpgmLywQCmSVFOZasDmq+5uL5blIb86GAzok
         6j/Q==
X-Gm-Message-State: AOJu0YwSMZuYVeL6cClE9syNL7R/O1vXDep+Qv2KAw/7TqG9ETfYuGU4
	wpUCtY4YMFBOvU8HCWSpVdnbBGAH375wLAHAC1TNkGKubUbye+uWb9j/+KByhcdWuGTV6YxgY0h
	xK/ITuZGmoxLyaKHaZwg4PbBHsax3GFiVHLEZCMspZ55YzwTQwEfoe6BiJXYX+55IqAqzbjkmcF
	d6/FtZ+C7X1WxEoVSMsgmfWX0K4KAdFBvGRv2ME70=
X-Google-Smtp-Source: AGHT+IEDMWVWONyV4T4Tuz4Tf2t+VvbzQ5ATAFgGxoQkjJY+xAfUs9Het4lY5F52WRIXMyz5vv68C4mbT0LJpg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:2a9b:d27f:d626:2e54])
 (user=steadmon job=sendgmr) by 2002:a25:ff1a:0:b0:e29:68a9:8612 with SMTP id
 3f1490d57ef6-e2968a98839mr8779276.4.1728939851740; Mon, 14 Oct 2024 14:04:11
 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:04:07 -0700
In-Reply-To: <cover.1728594659.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1728594659.git.steadmon@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <cover.1728939687.git.steadmon@google.com>
Subject: [PATCH v2 0/3] fuzz: port OSS-Fuzz tests back to Git
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: eric.sesterhenn@x41-dsec.de, jarlob@gmail.com, oswald.buddenhagen@gmx.de
Content-Type: text/plain; charset="UTF-8"

Git's fuzz tests are run continuously as part of OSS-Fuzz [1]. Several
additional fuzz tests have been contributed directly to OSS-Fuzz;
however, these tests are vulnerable to bitrot because they are not built
during Git's CI runs, and thus breaking changes are much less likely to
be noticed by Git contributors.

OSS-Fuzz's recommended setup is for tests to live in the repository of
the code they test and to be built along with other tests [1].

Port some of these tests back to the Git project, so that they can be
built and tested during our normal development workflow and CI, and as
such avoid future bitrot.

[1] https://google.github.io/oss-fuzz/advanced-topics/ideal-integration/

Changes in V2:
* Remove an errant `echo` in ci/run-build-and-minimal-fuzzers.sh
* Fix some style nits in ci/run-build-and-minimal-fuzzers.sh
* Fix whitespace errors in attr.{h,c}


Eric Sesterhenn (3):
  fuzz: port fuzz-credential-from-url-gently from OSS-Fuzz
  fuzz: port fuzz-parse-attr-line from OSS-Fuzz
  fuzz: port fuzz-url-decode-mem from OSS-Fuzz

 Makefile                                   |  3 ++
 attr.c                                     | 40 +-------------------
 attr.h                                     | 43 ++++++++++++++++++++++
 ci/run-build-and-minimal-fuzzers.sh        | 13 ++++++-
 oss-fuzz/.gitignore                        |  3 ++
 oss-fuzz/fuzz-credential-from-url-gently.c | 32 ++++++++++++++++
 oss-fuzz/fuzz-parse-attr-line.c            | 39 ++++++++++++++++++++
 oss-fuzz/fuzz-url-decode-mem.c             | 43 ++++++++++++++++++++++
 8 files changed, 177 insertions(+), 39 deletions(-)
 create mode 100644 oss-fuzz/fuzz-credential-from-url-gently.c
 create mode 100644 oss-fuzz/fuzz-parse-attr-line.c
 create mode 100644 oss-fuzz/fuzz-url-decode-mem.c

Range-diff against v1:
1:  625b8d607e ! 1:  04225dd421 fuzz: port fuzz-credential-from-url-gently from OSS-Fuzz
    @@ ci/run-build-and-minimal-fuzzers.sh: group "Build fuzzers" make \
      
     -for fuzzer in commit-graph config date pack-headers pack-idx ; do
     +fuzzers="
    -+commit-graph \
    -+config \
    -+credential-from-url-gently \
    -+date \
    -+pack-headers \
    -+pack-idx \
    ++commit-graph
    ++config
    ++credential-from-url-gently
    ++date
    ++pack-headers
    ++pack-idx
     +"
     +
    -+for fuzzer in $fuzzers ; do
    ++for fuzzer in $fuzzers; do
      	begin_group "fuzz-$fuzzer"
    --	./oss-fuzz/fuzz-$fuzzer -verbosity=0 -runs=1 || exit 1
    -+	echo ./oss-fuzz/fuzz-$fuzzer -verbosity=0 -runs=1 || exit 1
    + 	./oss-fuzz/fuzz-$fuzzer -verbosity=0 -runs=1 || exit 1
      	end_group "fuzz-$fuzzer"
    - done
     
      ## oss-fuzz/.gitignore ##
     @@
2:  770fe27c67 ! 2:  16c6573190 fuzz: port fuzz-parse-attr-line from OSS-Fuzz
    @@ attr.c: static const char *parse_attr(const char *src, int lineno, const char *c
      }
      
     -static struct match_attr *parse_attr_line(const char *line, const char *src,
    +-					  int lineno, unsigned flags)
     +struct match_attr *parse_attr_line(const char *line, const char *src,
    - 					  int lineno, unsigned flags)
    ++				   int lineno, unsigned flags)
      {
      	size_t namelen, num_attr, i;
    + 	const char *cp, *name, *states;
     
      ## attr.h ##
     @@ attr.h: int git_attr_system_is_enabled(void);
    @@ attr.h: int git_attr_system_is_enabled(void);
     +};
     +
     +struct match_attr *parse_attr_line(const char *line, const char *src,
    -+					  int lineno, unsigned flags);
    ++				   int lineno, unsigned flags);
     +
      #endif /* ATTR_H */
     
      ## ci/run-build-and-minimal-fuzzers.sh ##
    -@@ ci/run-build-and-minimal-fuzzers.sh: credential-from-url-gently \
    - date \
    - pack-headers \
    - pack-idx \
    -+parse-attr-line \
    +@@ ci/run-build-and-minimal-fuzzers.sh: credential-from-url-gently
    + date
    + pack-headers
    + pack-idx
    ++parse-attr-line
      "
      
    - for fuzzer in $fuzzers ; do
    + for fuzzer in $fuzzers; do
     
      ## oss-fuzz/.gitignore ##
     @@ oss-fuzz/.gitignore: fuzz-credential-from-url-gently
3:  4c9813313c ! 3:  ec6b5eed71 fuzz: port fuzz-url-decode-mem from OSS-Fuzz
    @@ Makefile: FUZZ_OBJS += oss-fuzz/fuzz-date.o
      
     
      ## ci/run-build-and-minimal-fuzzers.sh ##
    -@@ ci/run-build-and-minimal-fuzzers.sh: date \
    - pack-headers \
    - pack-idx \
    - parse-attr-line \
    -+url-decode-mem \
    +@@ ci/run-build-and-minimal-fuzzers.sh: date
    + pack-headers
    + pack-idx
    + parse-attr-line
    ++url-decode-mem
      "
      
    - for fuzzer in $fuzzers ; do
    + for fuzzer in $fuzzers; do
     
      ## oss-fuzz/.gitignore ##
     @@ oss-fuzz/.gitignore: fuzz-date

base-commit: 159f2d50e75c17382c9f4eb7cbda671a6fa612d1
-- 
2.47.0.rc1.288.g06298d1525-goog

