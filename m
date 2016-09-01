Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A39B1F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 16:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934199AbcIAQIG (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 12:08:06 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34167 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933949AbcIAQIF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 12:08:05 -0400
Received: by mail-wm0-f53.google.com with SMTP id w207so5536959wmw.1
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 09:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=3OpjZgFXxH0il2OwZBjim92uhCD955daydYwX+8vVvk=;
        b=bAfPlyWDEw0KhCAAdYKY3uCPyv6X3YPwn93nz+7OUWE6PBo+uQ6+kl8QQFKr+agJbv
         HYxSZjw70DjDUMRJKKzTTeKbe7NA5bVdZwNyRATSvTyMCnxXbH+7JXgEzjCoeLw4nRCN
         yIvHZJ4SLOqFbJBgi1mxXBdV8fq0hv4Ff0KaDIrgldOtRO8pffmmRuje3vsDSoZDQGUw
         5D8HkNBvF1JhlKnagYSGMXIVtEpgpeLdpE5+AVSwfth980B9eywY0sRNZFzsY6H2PNg0
         rA8q4mR2W+WaQZ4TKzT+3r6cykNjHr/l4fsx4lem7kDsRWVUjZVFUOXBgNdNrgT6De3c
         TAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=3OpjZgFXxH0il2OwZBjim92uhCD955daydYwX+8vVvk=;
        b=Q5xoGFWjGMBrdFQxqcNQzZNUPy6LEfom+a7AWWW06Sy6YagSGK4V9teykTkfua9BDC
         kApa6uPHcgEwDSttdF7860uad6q6Hyx3xgFqWahTVv5W4sNRX2j1W9iKADA069KnqZxM
         LtjW2RsV0XRZkiP1w6yr7DZz8aJ2RWZ78bzBG7REDCPMorNRvCgOOWEPSpJCzErYo90q
         Bz0UCfAk3EbuM5VK8r74GxjAIJs0B1NgHRYt/+4jKr+wDV0XbqlfqHNIRGQ9oAHQQUN8
         uGof6yJQt6n/FuPb/tLp1sfS65D6RbQ7evVk8COly71YiE/+DR34Twe7YSC4fz18JJep
         ZezA==
X-Gm-Message-State: AE9vXwOxlDVAevlBajQWZJ/h28tNqAzasGaIiPzX8bp9EYxW1VoFIvlYPnXrkM6B74cOyn4Xg8yOE3UlC6cJ0Q==
X-Received: by 10.194.134.234 with SMTP id pn10mr14549637wjb.35.1472746083974;
 Thu, 01 Sep 2016 09:08:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.96.137 with HTTP; Thu, 1 Sep 2016 09:08:02 -0700 (PDT)
From:   Jan Keromnes <janx@linux.com>
Date:   Thu, 1 Sep 2016 18:08:02 +0200
X-Google-Sender-Auth: yxmzWNjovhFc0wCcT3a3FO2F3IQ
Message-ID: <CAA6PgK7C18F1WGyZMTEUAWEVsUWqiZND5Ne_0SH-rUEm8u5dNg@mail.gmail.com>
Subject: `make profile-install` fails in 2.9.3
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm trying to `profile-install` Git from source on Ubuntu 16.04, to
have the latest stable Git optimized for my machine.

However, this fails (and has failed in previous versions), because it
runs the whole test-suite to get the profile, but bails out if there
were test failures (which happens often).

Problem: Is there a way to `make profile-install` but ignore
occasional test failures, as they're not problematic to get a useful
profile?

Related problem: `t3700-add.sh` currently fails in 2.9.3. I can
provide more debug information if you don't already know this problem.

Thanks,
Jan Keromnes

---

Steps to reproduce:

    curl https://www.kernel.org/pub/software/scm/git/git-2.9.3.tar.xz | tar xJ \
     && cd git-2.9.3 \
     && make prefix=/usr profile-install install-man -j18

Expected result:

    - runs all tests to get a profile (ignoring occasional failures)
    - rebuilds Git with the profile
    - installs Git

Actual result:

    - runs all tests to get a profile
    - at least one test fails, interrupting the whole process
    - Git is not installed

Failure log:

    # failed 1 among 40 test(s)
    1..40
    Makefile:43: recipe for target 't3700-add.sh' failed
    make[3]: *** [t3700-add.sh] Error 1
    make[3]: Leaving directory '/tmp/git/git-2.9.3/t'
    Makefile:36: recipe for target 'test' failed
    make[2]: Leaving directory '/tmp/git/git-2.9.3/t'
    make[2]: *** [test] Error 2
    Makefile:2221: recipe for target 'test' failed
    make[1]: *** [test] Error 2
    make[1]: Leaving directory '/tmp/git/git-2.9.3'
    Makefile:1633: recipe for target 'profile' failed
    make: *** [profile] Error 2
    The command '/bin/sh -c mkdir /tmp/git  && cd /tmp/git  && curl
https://www.kernel.org/pub/software/scm/git/git-2.9.3.tar.xz | tar xJ
&& cd git-2.9.3  && make prefix=/usr profile-install install-man -j18
&& rm -rf /tmp/git' returned a non-zero code: 2
