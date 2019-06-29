Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4A6E1F461
	for <e@80x24.org>; Sat, 29 Jun 2019 19:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfF2TsJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 15:48:09 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:42010 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfF2TsI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 15:48:08 -0400
Received: by mail-ed1-f52.google.com with SMTP id z25so16606212edq.9
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 12:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=SEa+K6Ujc5op1eK7USncd3K1qyU0g7nB9a4wK/qyRNg=;
        b=KyVlRwzoqvHkafl5/88A/WMn6FL3kYK5fw/heSSKxZcTKjjNa0fqy56xYfgcZYghnp
         4Nizjle0r+/+drwEV8QHjXTezvPALr8TAPNAQ/xiRL14cvEpqmY2/J47PQERN1r/EvH0
         Txvo1qEn+6cCE2+l76/WSjNormBB4JigudQwfwuXJ/YsVmKdW3sYKVQwnAZFWvg+6zhl
         VPr35Lg27pVlOYhKJoe0dTJge7bs0pOnVbqKx1amDcF7/tcI9RcLTGSNobUpwc1oRoGm
         dOuDQnX5J6s2E8DRm0I3X5T8iThZx2KOtaaZrmxWvNcl3G6roVpDaQtGRsEqXpPB/6kE
         oW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SEa+K6Ujc5op1eK7USncd3K1qyU0g7nB9a4wK/qyRNg=;
        b=kz0WtZ+N046Qo4YjjeNUrhGPBFkbRXjP7yn7BNA5D/JwnL2LD/zS0UjaZY911UcTVt
         BC5s9aU72qcUr9/gCg7SrFL8RqF7gO5/8sjaQQLxgJqv/sqqafN+Az/p9qS6uDzGFdx6
         teVScsDDQmgkJ7wyOfzqSE+oOLMM9WYctqZqwlBLEGyhB9fSB15KQHoQkB/piMUfRDNM
         wLe2+RViRXblV7GEpoAELHgD5+WFKe+gP33tnlBvhwShmaIFxCoXgcES3JcEOsn8M+Ml
         WilwS+oPXx7ngEXh4nCg54BugpE3cFYNrTbFpSrjwcoWWa39PF8RN4NQINghk5NmVOBe
         A4/Q==
X-Gm-Message-State: APjAAAVI9LcuTFUZVUZVrsPHserGnDnEGpS5+lYLYtsDtrcPQG81RCzV
        SUSamlZJLgseiSfEs69Ety07pX8oQGdJ5oIBTTMASf3fVyayMtY0
X-Google-Smtp-Source: APXvYqyz8w1UkXdyvEfy3MZh129osyYuaL3R1Y1leQSFpEQG7jZn/gQ6Y773yR8EFB3n0q+/w7EpLdZNhOhtLK8H88c=
X-Received: by 2002:a17:906:f0c7:: with SMTP id dk7mr15090904ejb.97.1561837686455;
 Sat, 29 Jun 2019 12:48:06 -0700 (PDT)
MIME-Version: 1.0
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Sat, 29 Jun 2019 21:47:41 +0200
Message-ID: <CABUeae90FQnxS1FCZLo+5LgMPD9xWQv6w7p7ymCtLdBoOijcRw@mail.gmail.com>
Subject: [Git 2.22.0] git submodule foreach now requires quoted command?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a script which I have used for long time, with numerous
git commands and one of commands is this trivial:

git submodule foreach --recursive git clean -ffd

I updated to Git 2.22.0 and noticed Git started to complain:

```
$ cd /d/boost
$ git submodule foreach --recursive git clean -ffd
Entering 'libs/accumulators'
error: unknown switch `f'
usage: git submodule--helper foreach [--quiet] [--recursive] [--] <command>

    -q, --quiet           Suppress output of entering each submodule command
    --recursive           Recurse into nested submodules

fatal: run_command returned non-zero status while recursing in the
nested submodules of libs/accumulators
```

Apparently, I have to quote the command to avoid the error

git submodule foreach --recursive 'git clean -ffd'

Is this expected behaviour?
Could anyone help me to understand what has changed?
I can't find any related changes in the release notes.

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net
