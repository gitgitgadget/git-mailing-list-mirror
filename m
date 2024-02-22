Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432DD3FE2C
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624252; cv=none; b=ewmuBHSYKZ4apifm91tnjgzOOYypB0j4rI0Magr7QYr3PYOKbPRHU1UMo16FFSHCj17+z0aN72HmJzQ0DBO9/PPe8G6nx0azWVd6ehyxLnjaZq0/dSOrkWFloYu7ZYtkW+tExB+XFZtNHvGIsTqobEgbMsrHlSHj20OHX9Uwzd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624252; c=relaxed/simple;
	bh=iqRJQ8yzq4j1JGh46btayrfbmG54j+jz5kc8JmK53JU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sM8s/N7tE8mdy2GmyVtdIMldsazQXJCC9D2r2Pbt0T7oS3OEcyfCKe+oewqbB8+85VIdFsQKxgfL9+nautONJ1iT6js6yw0KGZTecW3KZfA6Kcv16C/97ifv2qmNiGMen837/ZYQZcsX2alHCsmjq71QZ9D2A+KXx5CiP2bwJCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oxx4xS0c; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oxx4xS0c"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d7465d60b7so163855ad.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 09:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708624250; x=1709229050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrSOUfkXo7x+mPp6j0IcKBBc9Bqo7Nu/5KAy1mGgmG0=;
        b=Oxx4xS0c4kwgMddGBCU6/Cms3Z53j5O2DrflcJH4UfQPRERRQuw2wOleCGYJqah44j
         2OxsdTdHOITTpDHQ3dnmVgzVLOOkT+0RktbPXyt8S4chN3T+llwtjAKJtGOgtNM0XLhY
         8htDGjrvLpefXRcy+/0dX/EvG+SGqLTM90kU9cPXpAvmiqDCUbNz9Oh7ItCtZrx7TbWM
         DIxIKFj0SZ7mokTnnsucpnbq4z0Y3cLSV1wp7OhWyGRci2r4BmGdfgiODD0YI0MDmI5Q
         nd+Mc/66/EwNtOx6Ae7jP/krVGvYzcmmv6cqUpv9CWZPc05aEPRz4/PBUiyPWtyY8EHD
         NGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624250; x=1709229050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrSOUfkXo7x+mPp6j0IcKBBc9Bqo7Nu/5KAy1mGgmG0=;
        b=WNC2tvfPR1oqbKfQ3ZCipRGeJslwZulk/DVUn5LlMRIiHZDR3syBc8CXhVYq50qkBQ
         JbUulM6oOdM41RSqVwGdMQ5zcc5E3Kc1WNxyN/fWsUXClvRyqMpg4zzmMsJqShugGvuN
         R8EfxatWpMKh7MtgznGTKT+jpCgX5F9s1ha8s9VXwRoIP69tbbNtODhGeSgRACbGKcFP
         6yYIyzEgVbS7pZQp074zeB1yTcj79Z6kYErJ8Z77C77XU/M3sH3QArEgfFmt+J13qy+N
         wUpHcPIijwYjlvsn6H2az3ZgKRtRK0jtfaVrWPIx0CMlOa1yILlrQaST9I17w0T2KCJz
         iOog==
X-Gm-Message-State: AOJu0Yx9D6tDElmgKh4poelyPY2Pwu6rKuLKehs+I+3RkuCPLz8QTqJk
	ojUuyhDeH44lkjjcPnk6OymIQOKDwVWdI5KNtObIUajEolAQi/fa7KzdMiRLqfest1WOCh1LcNw
	jeYI9cROaCZs1qyxePsNsJ0+dP+vamQoI/mrTlfHkSPpMG143agQamE1XrIZybrRUq3kXIINwyH
	QNkYY/PXNCoXDdyCogAAqj9EdBD2Jj/dTDTJiSCQpwgrvV
X-Google-Smtp-Source: AGHT+IF5OtiXV0zzYz3Za/R7h197IYfHXsHqIMM+vJ/hvD/uLDvkrvr9mGh/HZiGwgh6PNkWtQZOHIzE+uDx74g=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:a509:b0:1d8:d705:c4d7 with SMTP
 id s9-20020a170902a50900b001d8d705c4d7mr779089plq.3.1708624250346; Thu, 22
 Feb 2024 09:50:50 -0800 (PST)
Date: Thu, 22 Feb 2024 17:50:30 +0000
In-Reply-To: <cover.1696021277.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1696021277.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240222175033.1489723-1-calvinwan@google.com>
Subject: [PATCH v5 0/3] Introduce Git Standard Library
From: Calvin Wan <calvinwan@google.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Jonathan Tan <jonathantanmy@google.com>, 
	phillip.wood123@gmail.com, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

While it has been a while since the last reroll of this series[1], the
contents and boundaries of git-std-lib have not changed. The focus for
this reroll are improvements to the Makefile, test file, and
documentation. Patch 1 contains a small fix for a missing include
discovered by Jonathan Tan. Patch 2 introduces the Git Standard Library.
And patch 3 introduces preliminary testing and usage examples for the
Git Standard Library.

One important piece of feedback I received from the previous series is
that Git should be the first consumer of its own libraries. Objects in
git-std-lib.a are no longer contained in LIB_OBJS, but rather directly
built into git-std-lib.a and then linked into git.a. There is some
functionality that is used by git-std-lib.a that's not included in
git-std-lib.a, such as tracing support. These have been stubbed out into
git-stub-lib.a and can be built with git-std-lib.a to be used
externally. Thank you to Philip Wood for these suggestions[2]!

The test file and Makefile have been updated to include cleanups
suggested by Junio. Since git-std-lib.a is now a dependency of Git, the
test file has also been included as part of the test suite. The series
has been rebased onto a recent version of `next` and function calls that
have been added/changed since the last reroll have also been included
into the test file.

Finally, through our libification syncs, there have been various topics
and questions brought up that would be better clarified with additional
documentation in technical/git-std-lib.txt.

[1]
https://lore.kernel.org/git/20230908174134.1026823-1-calvinwan@google.com/
[2]
https://lore.kernel.org/git/98f3edcf-7f37-45ff-abd2-c0038d4e0589@gmail.com/


Calvin Wan (2):
  git-std-lib: introduce Git Standard Library
  test-stdlib: show that git-std-lib is independent

Jonathan Tan (1):
  pager: include stdint.h because uintmax_t is used

 Documentation/Makefile                  |   1 +
 Documentation/technical/git-std-lib.txt | 170 +++++++++++++++
 Makefile                                |  71 +++++--
 pager.h                                 |   2 +
 strbuf.h                                |   2 +
 stubs/misc.c                            |  34 +++
 stubs/pager.c                           |   6 +
 stubs/trace2.c                          |  27 +++
 t/helper/.gitignore                     |   1 +
 t/helper/test-stdlib.c                  | 266 ++++++++++++++++++++++++
 t/t0082-std-lib.sh                      |  11 +
 11 files changed, 575 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/technical/git-std-lib.txt
 create mode 100644 stubs/misc.c
 create mode 100644 stubs/pager.c
 create mode 100644 stubs/trace2.c
 create mode 100644 t/helper/test-stdlib.c
 create mode 100755 t/t0082-std-lib.sh

Range-diff against v4:
1:  2f99eb2ca4 < -:  ---------- hex-ll: split out functionality from hex
2:  7b2d123628 < -:  ---------- wrapper: remove dependency to Git-specific internal file
3:  b37beb206a < -:  ---------- config: correct bad boolean env value error message
4:  3a827cf45c < -:  ---------- parse: create new library for parsing strings and env values
5:  f8e4ac50a0 < -:  ---------- git-std-lib: introduce git standard library
6:  7840e1830a < -:  ---------- git-std-lib: add test file to call git-std-lib.a functions
-:  ---------- > 1:  57b751a497 pager: include stdint.h because uintmax_t is used
-:  ---------- > 2:  e64f3c73c2 git-std-lib: introduce Git Standard Library
-:  ---------- > 3:  e2d930f729 test-stdlib: show that git-std-lib is independent
-- 
2.44.0.rc0.258.g7320e95886-goog

