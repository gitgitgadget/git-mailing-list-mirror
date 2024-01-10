Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC47DDA0
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 06:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFccqFTh"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e4f692d06so8761965e9.1
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 22:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704869489; x=1705474289; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7BgYQvjSF2Sp3QtAufatmejKgsnKRiK0tnz0jhA8+fU=;
        b=gFccqFThlbtwyjlz9c28MeiQAsIFBnkwcqBWUkqTrNz9Umdyauh3+uQF2lZmt0hzhK
         esQglRIkl285GQSFIVl+WUskJT6IMzzgQkcvkWnxHDZnVTAjNdCXpyR3T8ADootP7Gvz
         GaMRsg0hE54pHwN+OW47Dj+ITg1as6FSuc0eFwk+TzavfQhfXG7RNFmjY5UkIscWqJtE
         3tH4Gxivf/uwE/qsI6tcQmR1Td9/rJsdyDVy8ibl6FruyRDoByAEzGy45EkioYI495/W
         ixFKhljMnMg6vXKatvQSAukr2hodf8lgWbBq2+o5stvTAM2w11jVn4FHVXdCAW5tvdAz
         kofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704869489; x=1705474289;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7BgYQvjSF2Sp3QtAufatmejKgsnKRiK0tnz0jhA8+fU=;
        b=GfECpGG1A02pmTQBzB5ARqR0iHKSrqhgbpkxCzCGJSZGUg72HqW1vMj8Yya+0ouw2Z
         XPQaSH7GhC98L9/9fafePw/j5AFy2+kKtemPdK3Z9Lo20ic3mYQYaeZldcJa7Xa8vGD5
         VLUoToxidHcbiqiifOX7pxnqoHrMKqH/dD6JKxiKtkPr+7unp6E4e29nigBAIxPKKby7
         R5JiSqtKPxWJaMm4SP4x3OVD4DXlpJ44oIJwbxtMgTDEbY/Kgk31yBe7w/5vBv/0rvKA
         nQclziU0mb0vDATQMvZ8XlqsnCwEvQRohssXrzdu4hL7zUBUtcTA1P0cqoOwFFV9TyzF
         KgPw==
X-Gm-Message-State: AOJu0Yzd9tZfr+QF8ftlJHs4s6FTRsLdGVw9IACiDJXerueoTTibxtxR
	bGDOhUR95Zct3qEkROCu4xNHwT9txAQ=
X-Google-Smtp-Source: AGHT+IG10ARN7Lm4FzYDpUJovd4V6PddRvt6OSP03Mdenskc0A6/V8MalkoX417HN2PpIeMifBikTg==
X-Received: by 2002:a05:600c:11cd:b0:40e:4519:f450 with SMTP id b13-20020a05600c11cd00b0040e4519f450mr289413wmi.46.1704869488625;
        Tue, 09 Jan 2024 22:51:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b9-20020a5d4b89000000b003366aad3564sm4095195wrt.30.2024.01.09.22.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 22:51:28 -0800 (PST)
Message-ID: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Jan 2024 06:51:16 +0000
Subject: [PATCH 00/10] Enrich Trailer API
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
Cc: Emily Shaffer <nasamuffin@google.com>,
    Junio C Hamano <gitster@pobox.com>,
    Christian Couder <chriscool@tuxfamily.org>,
    Linus Arver <linusa@google.com>

This patch series is the first 10 patches of a much larger series I've been
working. The main goal of this series is to enrich the API in trailer.h. The
larger series brings a number of additional code simplifications and
cleanups (exposing and fixing some bugs along the way), and builds on top of
this series. The goal of the larger series is to make the trailer interface
ready for unit testing. By "trailer API" I mean those functions exposed in
trailer.h.

Currently, we have "process_trailers()" in trailer.h which does many
different things (parse command-line arguments, create temporary files, etc)
that are independent of the concept of "trailers", whose interface trailer.h
defines. This makes unit-testing this function difficult. While there is no
technical reason why we couldn't write unit tests for the smaller functions
that are called within process_trailers(), doing so would involve testing
private ("static" in trailer.c) functions instead of the public functions
exposed in trailer.h which authoritatively define the API.

As an alternative to this patch series, we could keep trailer.h intact and
decide to unit-test the existing "trailer_info_get()" function which does
most of the trailer parsing work. However this function wouldn't be easy to
test either, because the resulting data structure merely contains the
unparsed "trailers" lines. So the unit test (if it wants to inspect the
result of parsing these lines) would have to invoke additional parsing
functions itself. And at that point it would not longer be a unit test in
the traditional sense, because it would be invoking multiple functions at
once.

This series breaks up "process_trailers()" into smaller pieces, exposing
many of the parts relevant to trailer-related processing in trailer.h. This
forces us to start writing unit tests for these now public functions, but
that is a good thing because those same unit tests should be easy to write
(due to their small(er) sizes), but also, because those unit tests will now
ensure some degree of stability across new versions of trailer.h (we will
start noticing when the behavior of any of these API functions change).

Another benefit is that more clients (perhaps those outside of Git in the
future) will be able to use the same trailer processing algorithms used by
the interpret-trailers builtin. For example, a web server may want to parse
trailers the same way that interpret-trailers would parse them, without
having to shell out to interpret-trailers. Importing the new (richer)
trailer.h file that this series promotes would help them achieve that goal.
This use case was the original motivation behind my work in this area of
Git.

Thanks to the aggressive refactoring in this series, I've been able to
identify and fix a couple bugs in our existing implementation. Those fixes
build on top of this series but were not included here, in order to keep
this series small.

Linus Arver (10):
  trailer: move process_trailers() to interpret-trailers.c
  trailer: include "trailer" term in API functions
  trailer: unify trailer formatting machinery
  trailer: delete obsolete formatting functions
  sequencer: use the trailer iterator
  trailer: make trailer_info struct private
  trailer: spread usage of "trailer_block" language
  trailer: prepare to move parse_trailers_from_command_line_args() to
    builtin
  trailer: move arg handling to interpret-trailers.c
  trailer: delete obsolete argument handling code from API

 builtin/interpret-trailers.c | 169 ++++++++--
 builtin/shortlog.c           |   7 +-
 pretty.c                     |   2 +-
 ref-filter.c                 |   2 +-
 sequencer.c                  |  35 +--
 trailer.c                    | 579 ++++++++++++++++-------------------
 trailer.h                    | 106 ++++---
 7 files changed, 482 insertions(+), 418 deletions(-)


base-commit: a54a84b333adbecf7bc4483c0e36ed5878cac17b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1632%2Flistx%2Ftrailer-api-refactor-part-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1632/listx/trailer-api-refactor-part-1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1632
-- 
gitgitgadget
