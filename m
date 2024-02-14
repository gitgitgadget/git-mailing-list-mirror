Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9085647F
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920738; cv=none; b=luVx+X4eeA4h1NR/khI8kR5sro5/6/j4gYzlk9G+JBW1+ArvKjRB3tm77aXO1cxy78PKtRz7DsX+wdm7U3CySLz7tVjzbJqt8b+/kiE0stSMLEujf1DKHE1zAs1pJp/PFNmfpqiITTlwudunvrKr2t/BX6NRpSpCeHtNphsXLl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920738; c=relaxed/simple;
	bh=zU3jDEbxmkLPTGNydT7/pswV+ZCTFRkVzIvs42Ia6p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lmNWe9lISsxNyjwdxSKt3lS6l45wtG7b3VOSgAYlpLWB0CDK64prBny8Vajvi6mdpOtnVmuhTM2Hhm0S5NfnnHlNHHj3LmwSFV9jJmwn5AvZgrQ+l8pwE6v+ge0BzPXuWFyvtlHbZqRsTM3LUONI8cG2FCS83ESOpiDfkIr3sXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNXrrtb9; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNXrrtb9"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d1025717c7so28818901fa.2
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 06:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707920733; x=1708525533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTVjo8loGFWk1Vbeynzc/ijT3epPw7vTC5+Zcmh34H8=;
        b=cNXrrtb9/kkOwPgz/561w3IO9SHWO9JJo5VUQb6BjqLXLcoPwAA1AwiqobS0O6IOHp
         2lEvTeBTybPNr5HEVszI1v3c5Xsfi4ixEb/j/ytvnWdEdiE9GCgFXI4fGOoK32fhx8Kd
         iRYnW3eICCVQ+dUZ5EXRu2aXAsc1mqJ8OJw6Fui+GoM6Mz3jcRgMhcLxLRX6Qbk4fbQo
         ORShb8MD1OcGL0mkt/XBfXXvhWdkMVT2bcOkmSDxnpNoICnlf8RELwlK3x/qWGCzg7v2
         G7jQhd+08nO+/F7tG8jenn+8i6WT4+6c9vQUGQXYp+1XAilVxC9dMoeIOQgq9Yv0YYK4
         GE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707920733; x=1708525533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTVjo8loGFWk1Vbeynzc/ijT3epPw7vTC5+Zcmh34H8=;
        b=PT0IiR5t1a4p8E/eaNjLqB4bOhIlcpaV6PgRESmC1IXwdzYvgOjY1FOcQfZK/60Q8J
         oepaVrwGPLjMoM5MUbVmTh3wYbpIgKs47RwABH7vudIW4xMTNtizZqyw3iS5gscG8Dlj
         WO2p1MYM6vPqyP88coYseGwdpmW4BHjVkJ5P7tk1IqpSDD3+iXZCDFja/FGulNvy2HS5
         xu0hNBTT3KDPD/Q2PniOZ2ayGmclqSAzreLVE0uhwo5GLuJoCIiu9qRuVmDLJVfMhGy5
         g6iw+VVS965eHS3JjUZC5uOmTmly63k7tvwzz7klUaKiTmgX3CRFVlV22rP7OIxK4yjd
         n+VQ==
X-Gm-Message-State: AOJu0YwMpaE4GAdauIBz0zHD/ZWfSRKQYIPs4hfoCes+FVG6kWUu5TNr
	y/I2Im3SUyLxUWlXxGttMhuJ549Xuc1QClTXD1O0X7s967nnnJHBlnaIW2nF
X-Google-Smtp-Source: AGHT+IE07f4HQyzFsWfpFWjvaQ0BuWaWh8YubcJkSm1v846PsvAK7VVRnxr9RtfM3DdowL30RNmHYg==
X-Received: by 2002:a2e:95cf:0:b0:2d0:ca39:5fb8 with SMTP id y15-20020a2e95cf000000b002d0ca395fb8mr1934294ljh.53.1707920731841;
        Wed, 14 Feb 2024 06:25:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1ocn/3+OBQhujRVG92F8nm5jpep2wa9Oy44+xKHGKoszNKt/cVnPlCnSL1RdkxqJETA3dFMFBViF2B2Ms9wkzc3E5oXA0+J5APA0XIQDNVmpwe9uiQCORwB8f1gCuggPdQSwlCXWmmjEIt0yPugEAMt0XEu/LjKYxFxlB73H13PoS/Y7QnbKCiKIGgzyakeMBs+/uY74=
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:4d2b:b120:8137:3062])
        by smtp.gmail.com with ESMTPSA id z1-20020a05600c0a0100b00411ce6def3fsm2146871wmp.38.2024.02.14.06.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 06:25:30 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Linus Arver <linusa@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 0/5] rev-list: allow missing tips with --missing
Date: Wed, 14 Feb 2024 15:25:08 +0100
Message-ID: <20240214142513.4002639-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.44.0.rc0.51.gda36843b44
In-Reply-To: <20240208135055.2705260-1-christian.couder@gmail.com>
References: <20240208135055.2705260-1-christian.couder@gmail.com>
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

Patch 1/5 (t9210: do not rely on lazy fetching to fail) is a test fix
suggested by Junio, so that a mostly unrelated test will not wrongly
fail when this series is merged.

Patches 2/5 (revision: clarify a 'return NULL' in get_reference()),
3/5 (oidset: refactor oidset_insert_from_set()) and
4/5 (t6022: fix 'test' style and 'even though' typo) are very small
preparatory cleanups.

Patch 5/5 (rev-list: allow missing tips with --missing=[print|allow*])
allows git-rev-list(1) with `--missing=<arg>` when <arg> is not
'error' to not fail if some tips it is passed are missing.

# Changes since V2

Thanks to Linus Arver, and Junio who commented on V2!

The changes since V2 are the following:

  - Patch 1/5 (t9210: do not rely on lazy fetching to fail) was added
    to fix a test that wrongly failed when this series was applied,
    thanks to Junio who authored it.

  - In patch 5/5 (rev-list: allow missing tips with
    --missing=[print|allow*]), some grammos and typos were fixed in the
    commit message, thanks to Junio and Linus.

  - In patch 5/5 (rev-list: allow missing tips with
    --missing=[print|allow*]), the NEEDSWORK comment was improved, thanks
    to Junio. In particular, it doesn't use "ugly" and "dumb" anymore
    and gives an example of what's broken.

  - In patch 5/5 (rev-list: allow missing tips with
    --missing=[print|allow*]), a code comment as been clarified by removing
    "already" from it.

# Range-diff since V2

-:  ---------- > 1:  6e6f2cc26b t9210: do not rely on lazy fetching to fail
1:  5233a83181 = 2:  733c78144e revision: clarify a 'return NULL' in get_reference()
2:  cfa72c8cf1 = 3:  4c9e032456 oidset: refactor oidset_insert_from_set()
3:  5668340516 = 4:  35ca6e7c3d t6022: fix 'test' style and 'even though' typo
4:  55792110ca ! 5:  da36843b44 rev-list: allow missing tips with --missing=[print|allow*]
    @@ Commit message
         We could introduce a new option to make it work like this, but most
         users are likely to prefer the command to have this behavior as the
         default one. Introducing a new option would require another dumb loop
    -    to look for that options early, which isn't nice.
    +    to look for that option early, which isn't nice.
     
         Also we made `git rev-list` work with missing commits very recently
         and the command is most often passed commits as arguments. So let's
    -    consider this as a bug fix related to these previous change.
    +    consider this as a bug fix related to these recent changes.
     
         While at it let's add a NEEDSWORK comment to say that we should get
         rid of the existing ugly dumb loops that parse the
    @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *pr
         * Let "--missing" to conditionally set fetch_if_missing.
         */
     +  /*
    -+   * NEEDSWORK: These dump loops to look for some options early
    -+   * are ugly. We really need setup_revisions() to have a
    -+   * mechanism to allow and disallow some sets of options for
    -+   * different commands (like rev-list, replay, etc). Such
    -+   * mechanism should do an early parsing of option and be able
    -+   * to manage the `--exclude-promisor-objects` and `--missing=...`
    -+   * options below.
    ++   * NEEDSWORK: These loops that attempt to find presence of
    ++   * options without understanding that the options they are
    ++   * skipping are broken (e.g., it would not know "--grep
    ++   * --exclude-promisor-objects" is not triggering
    ++   * "--exclude-promisor-objects" option).  We really need
    ++   * setup_revisions() to have a mechanism to allow and disallow
    ++   * some sets of options for different commands (like rev-list,
    ++   * replay, etc). Such a mechanism should do an early parsing
    ++   * of options and be able to manage the `--missing=...` and
    ++   * `--exclude-promisor-objects` options below.
     +   */
        for (i = 1; i < argc; i++) {
                const char *arg = argv[i];
    @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *pr
     -  if (arg_missing_action == MA_PRINT)
     +  if (arg_missing_action == MA_PRINT) {
                oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
    -+          /* Already add missing tips */
    ++          /* Add missing tips */
     +          oidset_insert_from_set(&missing_objects, &revs.missing_commits);
     +          oidset_clear(&revs.missing_commits);
     +  }


Christian Couder (4):
  revision: clarify a 'return NULL' in get_reference()
  oidset: refactor oidset_insert_from_set()
  t6022: fix 'test' style and 'even though' typo
  rev-list: allow missing tips with --missing=[print|allow*]

Junio C Hamano (1):
  t9210: do not rely on lazy fetching to fail

 Documentation/rev-list-options.txt |  4 ++
 builtin/rev-list.c                 | 18 ++++++++-
 list-objects-filter.c              | 11 +-----
 oidset.c                           | 10 +++++
 oidset.h                           |  6 +++
 revision.c                         | 16 ++++++--
 t/t6022-rev-list-missing.sh        | 61 +++++++++++++++++++++++++++++-
 t/t9210-scalar.sh                  |  9 ++++-
 8 files changed, 117 insertions(+), 18 deletions(-)

-- 
2.44.0.rc0.51.gda36843b44
