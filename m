Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9A491F404
	for <e@80x24.org>; Sat, 24 Mar 2018 00:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeCXA4A (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 20:56:00 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46166 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeCXAz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 20:55:59 -0400
Received: by mail-qk0-f193.google.com with SMTP id o184so14796275qkd.13
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 17:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3pIuGFzjx3TioEUTfMY+uignR43SGYnQwcbSV6kiu/M=;
        b=kGdXAOwd4/u9G2fKV91TG/C+rwj0deqfeg0rST4Sal6w/sTQJGifyIt3vKNU3pVqSK
         5jpegZfqJkwN6TrupN25Xev9hQrCO9Db8qO9cm3mzuPHHt2jMmKlgY3qqiykQ6OxBlFR
         qj/OJxQY39e6sWQO2rbNMYTaFCxNI27oSOwGnjigPGKapgiuPKy2xH7j7Ml4M4hgVDOe
         LlAe0GPThGymqsaPeaHY8ASeGKSbGxx742Fk+OUxiCVdj9Rx6DUEpZ3bNZypq5HPQE34
         AzJmnNI4kfy9xQJ4Wr22LSzoJrYRKot41abMQCa9V4XzVGwCnWYLr5mHbcITvJCUM8Lq
         hNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3pIuGFzjx3TioEUTfMY+uignR43SGYnQwcbSV6kiu/M=;
        b=uEr+Ng6pc4z+2ZQ83kW2aXEJ94vL5xzuCUkNt/Zdj5TuB6Mr4C7tn2PJLqx7cyWiJk
         XzcU4ZH7rYrJluyBrK+1VVQuy2mREJc5NiC7OFacZZb/Ra6kU3pNHoIcPvfKAmL+VgrW
         +S1zG7lj4HDXsJcGy5Cd2XE7houY1OK7g/++SVN069j+xs1bOID2ol8y7zY/DnDsgGMR
         fNypeThNzuAmJknDroqMEx1axKFE2E4R4nkTNqxbsyJ1vksS3nKFMyq2kXaiFG5+Ff/J
         HL88RVQAHm5L8675czEP1l7JRcnaZTVzXGZfGMypiHAE4GeWZSB2TwdTH3OcNwCJ4Qtb
         N7kw==
X-Gm-Message-State: AElRT7FP7RfrYT2J+zX4NWeC20/sc7XGHohKv2uiJd6vUzREAF+9wWP5
        T2sCxaxkL3wTv8x/LvDOYhD24g==
X-Google-Smtp-Source: AG47ELvxpiw2OZaVQAVmdaNA8FFM3WDJjHFgqEc3FsCIYd2XR+iezMfqhUWV/Po5w4HwZiPYufQj8g==
X-Received: by 10.55.212.205 with SMTP id s74mr44719487qks.244.1521852958634;
        Fri, 23 Mar 2018 17:55:58 -0700 (PDT)
Received: from localhost (u-of-rochester-128-151-150-17.wireless.rochester.edu. [128.151.150.17])
        by smtp.gmail.com with ESMTPSA id o22sm7607022qtf.59.2018.03.23.17.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 17:55:57 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        sunshine@sunshineco.com
Subject: [PATCH v2 0/4] Teach `--default` to `git-config(1)`
Date:   Fri, 23 Mar 2018 20:55:52 -0400
Message-Id: <20180324005556.8145-1-me@ttaylorr.com>
X-Mailer: git-send-email 2.16.2.440.gc6284da4f
In-Reply-To: <20180306021729.45813-1-me@ttaylorr.com>
References: <20180306021729.45813-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is 'v2' of my patch series to add a `--default` option to `git config`.

I have addressed the following concerns since the first iteration:

  1. Better motivation in 'builtin/config: introduce `--default`'. (cc: Peff,
  Eric)

  2. Fixed a typo in the message of 'builtin/config: introduce `--default`'.
  (cc: Eric).

  3. Changed the first mention of type specifiers in `git config`'s
  documentation from a paragraph to a brief list (cc: Peff, Junio).

  4. Changed the signatures of some new functions, particularly in 'config.c:
  introduce 'git_config_color' to parse ANSI colors'.

I have thus-far avoided mentioning any specific deprecation of `--get-color` and
`--get-colorbool`, but would not be opposed to changing that in this series
before queuing.

Thank you again for all of your feedback, and my apologies that it has taken me
so long to respond. I was out of the office last week, and have been quite busy
since catching up on Git LFS-related issues.


Thanks,
Taylor

Taylor Blau (4):
  builtin/config: introduce `--default`
  Documentation: list all type specifiers in config prose
  config.c: introduce 'git_config_color' to parse ANSI colors
  builtin/config: introduce `--color` type specifier

 Documentation/git-config.txt |  38 +++++++---
 builtin/config.c             |  30 ++++++++
 config.c                     |  10 +++
 config.h                     |   1 +
 t/t1300-repo-config.sh       |  24 +++++++
 t/t1310-config-default.sh    | 131 +++++++++++++++++++++++++++++++++++
 6 files changed, 226 insertions(+), 8 deletions(-)
 create mode 100755 t/t1310-config-default.sh

--
2.16.2.440.gc6284da4f

