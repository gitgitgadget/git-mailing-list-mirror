Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1C01F404
	for <e@80x24.org>; Thu, 29 Mar 2018 01:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbeC2BQj (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 21:16:39 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42910 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbeC2BQi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 21:16:38 -0400
Received: by mail-pf0-f194.google.com with SMTP id a16so2073722pfn.9
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 18:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0vD0+y722p7jA+I/bbS952W1zMtof0/tpumKggHBbLs=;
        b=U8Em7IZOPzxDB2LpeKe54m1OeHUlUTM2A+g0aih0TNG6NnHKQw69HuDfT0pZwwik0u
         F5VEaAHE57OOrfJ4iP/oCQimXPoCnJXaSE78wmAkSa+KhtCivgFjJKWDKPI1VhB24IpD
         DDI8BhFuizxKvD5q2u09DJEenkTM8mcLOiKujRq440N162mSaaTaFVfUVIC4szCjN312
         prDIlWC14Okq/f0gI+U72H55wpmRUG/tlJLrs/MnzHcsJFTK6iQkba99mupBs1iXzDgn
         m5lSGL3sYhjV7y/wba48vj121lRxqy49lSTRq40YUoQbxL6KvmrK0uo8tr/ciwQlmQeZ
         gxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0vD0+y722p7jA+I/bbS952W1zMtof0/tpumKggHBbLs=;
        b=A551zYXayUyJeJHPtkKmZ9UOoLHjG2nMPPZfhDnNTvoyfClS2q4V4NPJO5yNdT0GIB
         q0YJgaMRfrXcdVZi9SYBntCvIGZM6ruRad2nzc5Pxs6ZetHHkEcf5wdDkfOhxsvEXOAf
         Y+YVmiv1o+EyyBWtvDORevnOOIhKOYWTvXEzXGQVerx91D2nyA4X2JcO1l/aDHQD2sdA
         zxu4oMc1WL10+usc/tHKvNwz5ZwsAa8tGmkwmNcPBglUi3J2HPueurnwJGfKqS4wDPTV
         KVXKn7oaHT6PuTYVeZ2k17BBlkM03nYkzAbrKu7xm15w7MVTiIhhbMXWnMKQ5aYURwOq
         m0NA==
X-Gm-Message-State: AElRT7FHpDyEtuAulkhAmwiciEmF47VbchCH7+eLZAmrs0qbeIyexpBI
        UAkHRSraVsnsialrFsNIGp+88HHoIbU=
X-Google-Smtp-Source: AIpwx48IbRdOPzaGwsSUrBOsrDMcwx7tjPFT8/y7fUS8nUkAYa0FlN7SmqqD7kS+jIehEHCqGJ2YyQ==
X-Received: by 2002:a17:902:24c:: with SMTP id 70-v6mr6014008plc.384.1522286197559;
        Wed, 28 Mar 2018 18:16:37 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:ec10:419d:d341:c920])
        by smtp.gmail.com with ESMTPSA id d12sm8731017pfn.42.2018.03.28.18.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 18:16:36 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     peff@peff.net, gitster@pobox.com
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 0/4] Teach `--default` to `git-config(1)`
Date:   Wed, 28 Mar 2018 18:16:31 -0700
Message-Id: <20180329011634.68582-1-me@ttaylorr.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da4f
In-Reply-To: <20180324005556.8145-1-me@ttaylorr.com>
References: <20180324005556.8145-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Attached is 'v3' of my patch series to add a `--default` option to `git config`.

The most notable change since the last reroll is that this series is now based
upon tb/config-type-specifier-option [1], with discussion about that change here
[2]. This was motivated by my and Peff's shared concern that by adding `--color`
as a top-level type specifier, that we'd be "squatting" on adding `--color` in
the traditional sense of "colorize this output."

As such, `--color` is _not_ added as a top-level type specifier in this version,
rather, it is accessible via `--type=color`. This leaves `--color` unused and
available for other uses in the future.

Other changes since last time include:

  1. Fixing an erroneous diff in Documentation/git-config.txt, where a header
     was removed.

  2. `git config` will now die immediately when the `--default` value is not
      canonicalize able under the given type specifier.

  3. Removing redundancies from t1300 and t1310 that are--as Peff wisely points
     out--unlikely to catch any meaningful regressions in the future.

  4. Documenting behavior in builtin/config.c that we "throw away" the
     canonicalized value during normalization.

As always, thank you for the helpful feedback. I look forward to your thoughts
on this version of the series.


Thanks,
Taylor

Taylor Blau (3):
  builtin/config: introduce `--default`
  config.c: introduce 'git_config_color' to parse ANSI colors
  builtin/config: introduce `color` type specifier

 Documentation/git-config.txt | 15 ++++++++++----
 builtin/config.c             | 38 ++++++++++++++++++++++++++++++++++++
 config.c                     | 10 ++++++++++
 config.h                     |  1 +
 t/t1300-repo-config.sh       | 30 ++++++++++++++++++++++++++++
 t/t1310-config-default.sh    | 38 ++++++++++++++++++++++++++++++++++++
 6 files changed, 128 insertions(+), 4 deletions(-)
 create mode 100755 t/t1310-config-default.sh

--
2.16.2.440.gc6284da4f

