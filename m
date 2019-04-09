Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2C6C20248
	for <e@80x24.org>; Tue,  9 Apr 2019 18:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfDISEX (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 14:04:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36963 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDISEX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 14:04:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so4400722wmf.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 11:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aryXOjOqavXWF57E+N99A14GALkDUXKJ64PtQkPBJFU=;
        b=ASKl85hafvJj1/b0H8kRUimg6hwpvYsV1+qOUsGRYZbAtjK4uhONlAeHS8YFtBqPq1
         S73c6Z8O0g9gU0m2lhvhxvz/FfxbwAG/eaA/knEr7cWAWjGxdZggK3b9Y85VVdL4WKWn
         9ipNZ1W6yHq0C5MnTGIrA2jiZ+xEvFjmF5rTLM0P+nDOoJnc9sV0B+7Od/nGKyx/nAic
         5pQxsVcncJN34fYfnwpng9iyAL9CEyDcUpyZDba0SSetX0zilGnytkGwYoVStKnhVnUQ
         34+JT12TKDjDFGQa3KuT8AwP85Sb4YR4hkz6+Idb1NeclTkT9dta06DAVOY4KFkYCwtg
         wt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aryXOjOqavXWF57E+N99A14GALkDUXKJ64PtQkPBJFU=;
        b=pqSZeTowmjdLjaoP+nJMxCiniujUPZCunkpeNPmgksidOveoISwDglns2SWxUHt52z
         c2482gNKwJvavxW2Egsoa8IKuvAW8//b/LiTkti9K0rx0TVCLjKaPZutsbnP1M2OB7yd
         4iaINfLUrhYxbHzPaoJqlq4K92r8GZzO6iNWSyi6crnJhg0vGWcRfJBFKuj/6kJB03s9
         YS+89SE+LaArGqbx4qk6B8U0HvtDxrooe2ii9RWzR5eb9lr81tQVMiGQ6HomVHBygu+J
         HKvAtr9F4kgXZHxYcyvPBK45Lm9PyiefbzRg2IzoJ/bG++Al9+Mp5yMqZiCXdisS+YA+
         vqzQ==
X-Gm-Message-State: APjAAAVS9HuJAqRq5l1omFqY1ukch234s7KQ2cMI5mJIZZ31MDux3ACk
        /m3xtBKMRd+myoMu7AFYx+0=
X-Google-Smtp-Source: APXvYqzguCqjxYBHhucqbXMlK6Qz3CzVOvfZ93mdpDitcVQZDWLq3wWUEzi7z/rlTedCVO6+lzmBMQ==
X-Received: by 2002:a7b:c769:: with SMTP id x9mr23298074wmk.103.1554833061048;
        Tue, 09 Apr 2019 11:04:21 -0700 (PDT)
Received: from szeder.dev (x4dbe2124.dyn.telefonica.de. [77.190.33.36])
        by smtp.gmail.com with ESMTPSA id w2sm25299054wrm.74.2019.04.09.11.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 11:04:20 -0700 (PDT)
Date:   Tue, 9 Apr 2019 20:04:18 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3] rev-list: exclude promisor objects at walk time
Message-ID: <20190409180418.GH8796@szeder.dev>
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
 <9856e7fc74f51b60ae162cbed3f5c0cf8c603222.1554757275.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9856e7fc74f51b60ae162cbed3f5c0cf8c603222.1554757275.git.steadmon@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 08, 2019 at 02:06:04PM -0700, Josh Steadmon wrote:
> For large repositories, enumerating the list of all promisor objects (in
> order to exclude them from a rev-list walk) can take a significant
> amount of time).
> 
> When --exclude-promisor-objects is passed to rev-list, don't enumerate
> the promisor objects. Instead, filter them (and any children objects)
> during the actual graph walk.
> 
> Remove the mark_uninteresting() function as it's not used anywhere else.
> 
> When testing against a large repo [1], this patch reduces the
> connectivity check runtime from 3 minutes to ~7 seconds.

This patch breaks test 'repack -d does not irreversibly delete
promisor objects' in 't0410-partial-clone.sh' when run with
GIT_TEST_COMMIT_GRAPH=1.

  +rm -rf repo
  +test_create_repo repo
  +test 1 = 1
  +repo=repo
  +mkdir -p repo
  +cd repo
  +/home/travis/build/git/git/t/../git init --template=/home/travis/build/git/git/t/../templates/blt/
  Initialized empty Git repository in /home/travis/build/git/git/t/trash directory.t0410-partial-clone/repo/.git/
  +mv .git/hooks .git/hooks-disabled
  +git -C repo config core.repositoryformatversion 1
  +git -C repo config extensions.partialclone arbitrary string
  +git -C repo commit --allow-empty -m one
  [master (root-commit) 71905df] one
   Author: A U Thor <author@example.com>
  +git -C repo commit --allow-empty -m two
  [master 202c4a3] two
   Author: A U Thor <author@example.com>
  +git -C repo commit --allow-empty -m three
  [master 4737577] three
   Author: A U Thor <author@example.com>
  +git -C repo commit --allow-empty -m four
  [master d6ba7e0] four
   Author: A U Thor <author@example.com>
  +git -C repo rev-parse HEAD^^^
  +ONE=71905dfcd543b7cbb0b4b66fbd20379e67220557
  +git -C repo rev-parse HEAD^^
  +TWO=202c4a3dd9a2dac927f056abb747cce9ea2eb67b
  +git -C repo rev-parse HEAD^
  +THREE=47375779ebcca4b422e3afdd14aa37a358081297
  +pack_as_from_promisor
  +printf 202c4a3dd9a2dac927f056abb747cce9ea2eb67b\n
  +git -C repo pack-objects .git/objects/pack/pack
  +HASH=2e675cd706e508d6c52a21d28cfcddde5ec02a06
  +
  +echo 2e675cd706e508d6c52a21d28cfcddde5ec02a06
  2e675cd706e508d6c52a21d28cfcddde5ec02a06
  +printf 47375779ebcca4b422e3afdd14aa37a358081297\n
  +pack_as_from_promisor
  +git -C repo pack-objects .git/objects/pack/pack
  +HASH=31f7d2797549ab9b1c425a9e60eb2030481170e5
  +
  +echo 31f7d2797549ab9b1c425a9e60eb2030481170e5
  31f7d2797549ab9b1c425a9e60eb2030481170e5
  +delete_object repo 71905dfcd543b7cbb0b4b66fbd20379e67220557
  +sed -e s|^..|&/|
  +echo 71905dfcd543b7cbb0b4b66fbd20379e67220557
  +rm repo/.git/objects/71/905dfcd543b7cbb0b4b66fbd20379e67220557
  +repack_and_check -a 202c4a3dd9a2dac927f056abb747cce9ea2eb67b 47375779ebcca4b422e3afdd14aa37a358081297
  +rm -rf repo2
  +cp -r repo repo2
  +git -C repo2 repack -a -d
  warning: reflog of 'HEAD' references pruned commits
  warning: reflog of 'refs/heads/master' references pruned commits
  fatal: unable to read 71905dfcd543b7cbb0b4b66fbd20379e67220557
  error: last command exited with $?=128
  not ok 23 - repack -d does not irreversibly delete promisor objects


  https://travis-ci.org/git/git/jobs/517874310#L5822

