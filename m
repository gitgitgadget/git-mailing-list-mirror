Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610B278B69
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707400281; cv=none; b=uVTVgmTIyLg3ecCmBJ5zAfnpp8mCl8jl4lJnPHxOddni7T5LEX3K6xmkfExPEOYUmFMGhwxJHnUPKv2XpNxm3Z1vSCbMvn8l85In2Z+67zffaTJu+JQiZy06DUGdxHHH9CFly/n5q7E2M1H9nLKHBhpKE06gHbln4C4/nlAVkFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707400281; c=relaxed/simple;
	bh=JZOEIemr+GI9M5XpNl/Ibta4CCoL/0RvB76LcW6bYuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBlnJWSfx05h71NveNy4jI+zh/yLN1I5OBizwnGxYvKHaIBKACUZmUdNnF6AtPNYv+qxbkJM3fWfF0ci7KZ4px/T3i28DXLlyzjNfC0S3jLHWa+5z3JPPHw63HYULBXk9w5N4r4INmYUvHRAJL2bLtjEl4qYMT0ZWCb2iXXV9i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wpi97uN7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wpi97uN7"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4103be6e938so4663395e9.0
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 05:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707400277; x=1708005077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ydcASjF3a+XkgFoIYrUAchNBjfJQ/3rm6LsAi/MAm/k=;
        b=Wpi97uN7hSB4JoZ8TqgnN+U0ClG3U/y8eQyPMCaMPpHOZxDzfNBGwkJSPXo778Vtbp
         tLdpwHQ5UMWFXqWkK7HArATostlk3reEqm6kGfS9qs8dRzbkBUmfrhHQDUL20UuhHwKH
         8fbDtZCuKprQwhI/4j2cMposGZd1aS340izBghylDNewKQUHyCzKj3SVxRb+n0SYaCRL
         wkbO4qvF6Z61btiZJ/5yyk+v1lqB4GK/eSQ8QVDRZfC0o4fwGhgGpijNSg/8meTdz4x+
         8XBCW9kEs/ueEVz7qyLA4IqAWjxirasj4XK0ewJvhuw84czP9ylB1GtbyEvPAi+kqhPc
         7pBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707400277; x=1708005077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydcASjF3a+XkgFoIYrUAchNBjfJQ/3rm6LsAi/MAm/k=;
        b=uELhZ1cMgpfRTwU6WUMcIEAfAKF1SjuL4PL681LfHTlkiWSnK/Y2hi3IPZMdtzdIPT
         MjKKm5eVYqe0e792b2aYWaQpoWuyeutfZjLl2SCmLmPgYJQ2Af25vJ88gf67FwY/S8sP
         vrLEQ1siHDeYJBN9qwQNgMSJpoEorzp/ps7DEBmk3ciWnafa3nEsxED/n2cHwdLNgD0T
         14L/1vrabrrnEqvQLtWBOZlglCIhAbdzlG/ytCWs5sBPYetbawwN+bljhiqAVnWeQ4MS
         +3g7PymccoedjD80GhzixglfwzAvyZsjsga30woQnypV4MwlitTF74yHrL5UFEJDN0iJ
         uwRw==
X-Gm-Message-State: AOJu0YwkqZJ+a8UCyn5vNs0RT1fZtO2Ka6z+yzqFIL1AXwgB4yLvULBf
	6TDodvSXnqjauFE1TxIRet1IU26LK0hXlhlYaN2eMhOg32AcRq9o1U9ISzje
X-Google-Smtp-Source: AGHT+IFjD48X7RaXBBA8zy83c9jw6OwDvMnVT/exlZIYI9L5JsFAygwBC9te7ADJZrwE8abXEBJq+g==
X-Received: by 2002:a05:600c:4708:b0:410:384f:ec36 with SMTP id v8-20020a05600c470800b00410384fec36mr1562350wmo.15.1707400276797;
        Thu, 08 Feb 2024 05:51:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFQw/Ojn6wv4k1KVIRa5+ZxofxSiBzvg2Lyj6TCSr2VscuamQB2gaXj8cyPtrMO50o5FJEow6tMc93FG4HO0+peeHULaEC0bdVpTB/ckbipr1h7G1thQi8Q+rR1GJA+Ihd8Fgta1ZOWOZpnQgFg/v+M5OsRt5EtB89FNnDYg==
Received: from localhost.localdomain ([2001:861:3f04:7ca0:4c16:5b8b:3341:9836])
        by smtp.gmail.com with ESMTPSA id j12-20020a05600c190c00b0040ebf603a89sm1698307wmq.11.2024.02.08.05.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:51:15 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Linus Arver <linusa@google.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/4] rev-list: allow missing tips with --missing
Date: Thu,  8 Feb 2024 14:50:51 +0100
Message-ID: <20240208135055.2705260-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.565.g97b5fd12a3.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

# Intro

A recent patch series, kn/rev-list-missing-fix [1] extended the
`--missing` option in git-rev-list(1) to support commit objects.

Unfortunately, git-rev-list(1) with `--missing` set to something other
than 'error' still fails, usually with a "fatal: bad object <oid>"
error message, when a missing object is passed as an argument.

This patch series removes this limitation and when using
`--missing=print` allows all missing objects to be printed including
those that are passed as arguments.

[1] https://lore.kernel.org/git/20231026101109.43110-1-karthik.188@gmail.com/

# Patch overview

Patches 1/4 (revision: clarify a 'return NULL' in get_reference()),
2/4 (oidset: refactor oidset_insert_from_set()) and 
3/4 (t6022: fix 'test' style and 'even though' typo) are very small
preparatory cleanups.

Patch 4/4 (rev-list: allow missing tips with --missing=[print|allow*])
allows git-rev-list(1) with `--missing=<arg>` when <arg> is not
'error' to not fail if some tips it is passed are missing.

# Changes since V1

Thanks to Linus Arver, Eric Sunshine and Junio who commented on V1!
The changes since V1 are the following:

  - In patch 1/4 (revision: clarify a 'return NULL' in
    get_reference()), some 's/explicitely/explicitly/' typos were fixed
    in the commit message. Thanks to a suggestion from Eric. 

  - Patch 2/4 (oidset: refactor oidset_insert_from_set()) is new. It
    refactors some code into "oidset.{c,h}" to avoid duplicating code
    to copy elements from one oidset into another one. Thanks to a
    suggestion from Linus.

  - Patch 3/4 (t6022: fix 'test' style and 'even though' typo) used to
    fix only an 'even though' typo, but while at it I made it use
    `if test ...` instead of `if [ ... ]` too. Thanks to a suggestion
    from Junio.

  - Patch 4/4 (rev-list: allow missing tips with
    --missing=[print|allow*]) was changed so that missing tips are
    always allowed when `--missing=[print|allow*]` is used, as
    suggested by Junio. So:
      - no new `--allow-missing-tips` option is implemented,
      - no ugly early parsing loop is added,
      - no new 'do_not_die_on_missing_tips' flag is added into
        'struct rev_info',
      - the 'do_not_die_on_missing_objects' is used more instead,
      - the commit message as been changed accordingly.

  - In patch 4/4 (rev-list: allow missing tips with
    --missing=[print|allow*]), a code comment has been added before
    `if (get_oid_with_context(...))` in "revision.c::get_reference()"
    as suggested by Linus.

  - In patch 4/4 (rev-list: allow missing tips with
    --missing=[print|allow*]), a big NEEDSWORK comment has been added
    before the ugly early parsing loops for the
    `--exclude-promisor-objects` and `--missing=...` options in
    "builtin/rev-list.c".

  - In patch 4/4 (rev-list: allow missing tips with
    --missing=[print|allow*]), a code comment now uses "missing tips"
    instead of "missing commits" in "builtin/rev-list.c", as
    suggested by Linus.
    
  - In patch 4/4 (rev-list: allow missing tips with
    --missing=[print|allow*]), the added tests in t6022 have the
    following changes:
      - variables 'obj' and 'tip' have been renamed to 'missing_tip'
        and 'existing_tip' respectively as suggested by Linus,
      - a comment explaining how the 'existing_tip' variable is useful
        has been added as suggested by Linus,
      - `if test ...` is used instead of `if [ ... ]`, as suggested by
        Junio.

  - Also in patch 4/4 (rev-list: allow missing tips with
    --missing=[print|allow*]), the documentation of the `--missing=...`
    option has been improved to talk about missing tips.

# Range-diff since V1

Unfortunately there has been many changes in patch 4/4, so the
range-diff shows different patches:

1:  b8abbc1d42 ! 1:  5233a83181 revision: clarify a 'return NULL' in get_reference()
    @@ Commit message
         revision: clarify a 'return NULL' in get_reference()
     
         In general when we know a pointer variable is NULL, it's clearer to
    -    explicitely return NULL than to return that variable.
    +    explicitly return NULL than to return that variable.
     
         In get_reference() when 'object' is NULL, we already return NULL
         when 'revs->exclude_promisor_objects && is_promisor_object(oid)' is
         true, but we return 'object' when 'revs->ignore_missing' is true.
     
    -    Let's make the code clearer and more uniform by also explicitely
    +    Let's make the code clearer and more uniform by also explicitly
         returning NULL when 'revs->ignore_missing' is true.
     
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## revision.c ##
-:  ---------- > 2:  cfa72c8cf1 oidset: refactor oidset_insert_from_set()
2:  208d43eb81 ! 3:  5668340516 t6022: fix 'even though' typo in comment
    @@ Metadata
     Author: Christian Couder <chriscool@tuxfamily.org>
     
      ## Commit message ##
    -    t6022: fix 'even though' typo in comment
    +    t6022: fix 'test' style and 'even though' typo
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    @@ t/t6022-rev-list-missing.sh: do
     -                  # Blobs are shared by all commits, so evethough a commit/tree
     +                  # Blobs are shared by all commits, so even though a commit/tree
                        # might be skipped, its blob must be accounted for.
    -                   if [ $obj != "HEAD:1.t" ]; then
    +-                  if [ $obj != "HEAD:1.t" ]; then
    ++                  if test $obj != "HEAD:1.t"
    ++                  then
                                echo $(git rev-parse HEAD:1.t) >>expect.raw &&
    +                           echo $(git rev-parse HEAD:2.t) >>expect.raw
    +                   fi &&
3:  8be34ce359 < -:  ---------- rev-list: add --allow-missing-tips to be used with --missing=...
-:  ---------- > 4:  55792110ca rev-list: allow missing tips with --missing=[print|allow*]


Christian Couder (4):
  revision: clarify a 'return NULL' in get_reference()
  oidset: refactor oidset_insert_from_set()
  t6022: fix 'test' style and 'even though' typo
  rev-list: allow missing tips with --missing=[print|allow*]

 Documentation/rev-list-options.txt |  4 ++
 builtin/rev-list.c                 | 15 +++++++-
 list-objects-filter.c              | 11 +-----
 oidset.c                           | 10 +++++
 oidset.h                           |  6 +++
 revision.c                         | 16 ++++++--
 t/t6022-rev-list-missing.sh        | 61 +++++++++++++++++++++++++++++-
 7 files changed, 106 insertions(+), 17 deletions(-)

-- 
2.43.0.565.g97b5fd12a3.dirty

