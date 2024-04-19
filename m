Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C38129A2
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713504159; cv=none; b=P6xmXAlVya/JWSSB7l/xv3Xt870ZWropuG3LgqvsZ9+OOdmfahA95JepWg13qoXc6Af422NXApCWfZSp3nM+KX4BBJ+B1EC5oNfMzX/7Ei9tD0lRE8F8gxB42bO+nmdzKYYvfNPG0k/p1r/gPGgli5iFbEe8W69TAI4UDDEzfM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713504159; c=relaxed/simple;
	bh=wJJtBOYdga1UBK6kNnyOlufTLwndo426H8YWY7da8zU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=jre4mx7zfB5VPZZVn3sjLR58RblXKSWq82JFw1f7aIOvCgDSpgMtLqvT34RuRdeH5VA4Trxnm2fuYJjZjrbvycc6MPNUpu7QCTT0x90q/4iy9+N7iEInVfdExwAwRCXIwJ/qHYztFZJ6OnWek3HlbmGrQLOKQNprB4jdD4LQ6Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zph8MGGm; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zph8MGGm"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-571d5645e03so79194a12.3
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 22:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713504156; x=1714108956; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWYQPc4sInPelEJP4EFvLs1HlqEW4Uhvwa0+sjAZzdM=;
        b=Zph8MGGmHZqnYnjjzZvvI/WvChyXS1q7tX5CQwLtu+GsC++eJ11I0Sb45k4Obkjy1Y
         TjNTjJffRLQOCpV36ZCfaqzWYqeqoq4yAx5WOZnJFUDWl4+vzg1SFA8Gn68BwcZ/jTtc
         jE1KxOH+1zK/cOTEuvioYvQfbdVEjo035JaZDyFio71XaH41orMqhOpJpI9OepPoPvxz
         yOyy8biUEU1YMzpWbRfcW73LHOOYX2XMe+zUhtw3LcxIUOJvkG8/rBdBvUZiiksJn+/k
         wx4jlRm+umCDo61ZdtUi7XTtmdEVQ/vpl7poeChctteaAxCReww2+szgi3YkbItwGt9i
         bYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713504156; x=1714108956;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWYQPc4sInPelEJP4EFvLs1HlqEW4Uhvwa0+sjAZzdM=;
        b=ELqsav0JX/s03Xeu+ZghIShXQrhJwmWuzH+XwD6AyGxzuQuR1aNZ/c60DVJsZGIQGP
         gXZ52hZkxWjik0kgYi33QqIlSRDZ4bVp8C+zKnSowy/SUvNR7Zkw/HdvHTXz7x0Gl5ji
         b1oEE4C889HH9Z0QBVmHBJEQTkoyZDjTkDUqEKK2Ur6mSH31YlwTHFdUJGGJ3fVn2sdo
         LhQZnu6KVwmCULRRmg8z3QTeTREs2MSp2H1vu3XnQVLhp64v1vISpzrSvCXw673bc55c
         BCxJ2erPafAd+tRzfcy7tlU1AOkHAmVOMLuZUufR/kRJD0QlGPdOBDHysfIPAQNuXn8T
         1M6w==
X-Gm-Message-State: AOJu0Yw9cTs5sSpzL6dS9NqOMFDD/lTjL+RACsb3fqUrwIu2EigUDeZB
	zJJqGFaJhq+0tOoqXHm5q6PxNEi5aEdErBXO2B7D1spcVmFUS3qKsyHsPw==
X-Google-Smtp-Source: AGHT+IFR8l/DWX9MhgHezS/IQtHQX0vdKwyJBMWryerweQR2BtcyNi6usVLMScsoEYFKjYtdNoN3mg==
X-Received: by 2002:a50:baa5:0:b0:56e:309f:4cb3 with SMTP id x34-20020a50baa5000000b0056e309f4cb3mr608579ede.16.1713504155362;
        Thu, 18 Apr 2024 22:22:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ds2-20020a0564021cc200b0057059d26756sm1681682edb.76.2024.04.18.22.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 22:22:34 -0700 (PDT)
Message-Id: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
References: <pull.1696.git.1710570428.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Apr 2024 05:22:25 +0000
Subject: [PATCH v2 0/8] Make trailer_info struct private (plus sequencer cleanup)
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

Linus Arver (8):
  Makefile: sort UNIT_TEST_PROGRAMS
  trailer: add unit tests for trailer iterator
  trailer: teach iterator about non-trailer lines
  sequencer: use the trailer iterator
  interpret-trailers: access trailer_info with new helpers
  trailer: make parse_trailers() return trailer_info pointer
  trailer: make trailer_info struct private
  trailer: retire trailer_info_get() from API

 Makefile                     |   5 +-
 builtin/interpret-trailers.c |  12 +--
 sequencer.c                  |  27 +++---
 t/unit-tests/t-trailer.c     | 181 +++++++++++++++++++++++++++++++++++
 trailer.c                    | 161 +++++++++++++++++++------------
 trailer.h                    |  46 ++++-----
 6 files changed, 321 insertions(+), 111 deletions(-)
 create mode 100644 t/unit-tests/t-trailer.c


base-commit: 3452d173241c8b87ecdd67f91f594cb14327e394
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1696%2Flistx%2Ftrailer-api-part-3-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1696/listx/trailer-api-part-3-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1696

Range-diff vs v1:

 -:  ----------- > 1:  b6a1304f8ae Makefile: sort UNIT_TEST_PROGRAMS
 -:  ----------- > 2:  e1fa05143ac trailer: add unit tests for trailer iterator
 1:  32ad0397737 ! 3:  5520a98e296 trailer: teach iterator about non-trailer lines
     @@ Commit message
      
          Signed-off-by: Linus Arver <linusa@google.com>
      
     + ## t/unit-tests/t-trailer.c ##
     +@@ t/unit-tests/t-trailer.c: static void run_t_trailer_iterator(void)
     + 			"not a trailer line\n"
     + 			"not a trailer line\n"
     + 			"Signed-off-by: x\n",
     +-			1
     ++			/*
     ++			 * Even though there is only really 1 real "trailer"
     ++			 * (Signed-off-by), we still have 4 trailer objects
     ++			 * because we still want to iterate through the entire
     ++			 * block.
     ++			 */
     ++			4
     + 		},
     + 		{
     + 			"with non-trailer lines (one too many) in trailer block",
     +
       ## trailer.c ##
      @@ trailer.c: void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
       
 2:  dc873c3b820 = 4:  84897cf5c83 sequencer: use the trailer iterator
 3:  872e67286c8 = 5:  e961d49cd40 interpret-trailers: access trailer_info with new helpers
 4:  c55ae2cbda9 = 6:  093f68f3658 trailer: make parse_trailers() return trailer_info pointer
 5:  cf59dee5064 = 7:  0e9ae049b88 trailer: make trailer_info struct private
 6:  19de7c64171 = 8:  eca77a1a462 trailer: retire trailer_info_get() from API

-- 
gitgitgadget
