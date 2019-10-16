Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA4BC1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 17:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbfJPR0W (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 13:26:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34519 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfJPR0W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 13:26:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id k20so7334485pgi.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Fh7jOz5/g7ZGTUb2VhLJxPPALe/tA9JHgHrmbSsx7uc=;
        b=hJqxBvw7pC1wP/SnDrCHayrsCNiFn3LepUmo+bNrmhehcPddqEoGaNct4tN8IPVXbw
         ElO33+SQt/GM/d72tR0J46vRLePWPPMSO9rHbFyxcv6srrDui/MX1UzgJbew4FMcgLpg
         uOXnw0mNuDYRu2B80lYVtidMf0bcbGHSFlYmkRDmx10oNCQXwwaKmalrsStmyQcZ0rWK
         eex+Y/cBxU/5oo6+NKP0lRkhjvUhd5XQg4N8Ydbr5KyXJF/1LTHcjy/Qyzct5iW+otQl
         v/fhmJLIQTe9e7mWhvD4ap/at94AvTUp5qIRxcL8ck+w6LflVKBhMTMWpdcwvDIZfDy/
         JzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Fh7jOz5/g7ZGTUb2VhLJxPPALe/tA9JHgHrmbSsx7uc=;
        b=FLi3Oo4K2mBURJzpCNSTbhrU5ePLIfmSuQtW0WPmoHhFS3XpFSkRPXcVQTQq054n8w
         WcyvyBOiTyOkJs64BXAQ10vh+VoESf17v3YZqCDAAGLSGpLY2WeF2ecldsqz+q2eYdIr
         vnXuVEt3wj+Jf6lxGIO5OJUT7g0I0iNeTr7Oa1u0X6u85fS7VTN4L1R6IWpn81+AoTYu
         +HXnmqY8PJeLEbNc9uwmmeo+mndJjUP6kXHi+zW6p9zz3aQvuTQpbXpX5W1vvw383QEJ
         Ot+1VxI/YX4jK7Kr3q4dHeCojSp7GiPlo8upcy7fuPBq5HxwELYk3Tolv6M9mIuKdwr5
         ue2Q==
X-Gm-Message-State: APjAAAX1sSdEYG73jqud88dg7Zg8kgtkkBXPFpr6kPphI4zsphWblTOS
        ZX0rzKbH1SEOxqu997szW+VokyIZ
X-Google-Smtp-Source: APXvYqxpZWr+wLmNEADWNz4oaeoyjBO7hFMVZQoDwjF3r1vNAAi+m4vQ2jKYcLezsscv0ydkJjljxQ==
X-Received: by 2002:a17:90a:338c:: with SMTP id n12mr6304762pjb.24.1571246780986;
        Wed, 16 Oct 2019 10:26:20 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id b3sm3007268pjp.13.2019.10.16.10.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 10:26:19 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:26:17 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 0/7] merge: learn --autostash
Message-ID: <cover.1571246693.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban reported[1] that he expected merge to have an --autostash option,
just like rebase. Since there's not really any reason why merge can't
have it, let's implement it in this patchset.

The actual logic isn't too bad. That change can be found in the last
patch. The remainder is refactoring so that the change can be made
easily. One thing I would like some attention on is if apply_autostash()
is called in the right place. It's called somewhere above
close_object_store() and also in the --abort case, just like in rebase,
but I'm not quite sure if that's right.

Since this is an RFC, we're missing tests and documentation but I've
tested it and it seems to work reasonably well.

[1]: https://github.com/gitgitgadget/git/issues/394

Denton Liu (7):
  Makefile: alphabetically sort += lists
  autostash: extract read_one() from rebase
  autostash: extract apply_autostash() from rebase
  autostash: extract reset_head() from rebase
  autostash: extract perform_autostash() from rebase
  autostash.c: undefine USE_THE_INDEX_COMPATIBILITY_MACROS
  merge: teach --autostash option

 Makefile         |  75 +++++++--------
 autostash.c      | 239 ++++++++++++++++++++++++++++++++++++++++++++++
 autostash.h      |  24 +++++
 builtin/merge.c  |  13 +++
 builtin/pull.c   |   9 +-
 builtin/rebase.c | 240 +----------------------------------------------
 t/t5520-pull.sh  |   8 --
 7 files changed, 323 insertions(+), 285 deletions(-)
 create mode 100644 autostash.c
 create mode 100644 autostash.h

-- 
2.23.0.897.g0a19638b1e

