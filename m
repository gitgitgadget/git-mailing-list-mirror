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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A8E420A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 22:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbeLNWs5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 17:48:57 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:37837 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbeLNWs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 17:48:56 -0500
Received: by mail-ed1-f48.google.com with SMTP id h15so6209831edb.4
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 14:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=VpQFePRvPn1jv9SDhiYJkOWMsVERrjBLBYc+/d9mqyY=;
        b=iudnvviAI9iWNRC3Opp61eE5HfmwsN6eS3uXzQkbZtUN0cjzBN3PYy+zXGD/I/jj+A
         25B7ROJ4SG89dtgyhqgUT6hLm8rlCoD31tJtgzg+ngga7TcPHdQVPH+Xg7d/LyaI8tkZ
         1N57CSO8wY0dIaoDiHISngTtgKiAa5r7m7YDwBZSOYDwhS9nPDfasnG9UlMCwFZBqeR+
         EVqLcROyUxlL9FeVn4feQRrePZxW8ul24JiAF7wlfZ+YbNB1yv3EKWlul1UglMdPnAJ/
         0FT0ALt58nnh50Z7g3loxVZGS7t1cSp8NGOe7iSU7ukTpi/A7Tmvkj8TglkDQ8RKzbhv
         BvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=VpQFePRvPn1jv9SDhiYJkOWMsVERrjBLBYc+/d9mqyY=;
        b=FF0SiYH+2snPGE3JFOOzqQcne+Zg3vKXJ+dv7d5xZS7lz7dDk91Hw1urDVJPGAyqyt
         xgIpVmT29v4Ev/IPFepAZeb8D0LU8a1dqrHVL+qp51EPq9OYh+gu3tAsoJpS0Bn5T+OK
         gxZ3yDQM7O9CgUg4+uCSjiUqd0vF7opteMwSj35sQomCdfCc81bEMFQHjnxqW9QyqRlY
         RzyujG0ggc86ZMusKz1mXxh2lQurfxQsIhqvPItDfKl9sAUxNhovqqRMIAEsuXWJiPYu
         Yy3qxV1nJaccBUm4UFPM4Z//pDLZUeYvOwunKfh1nnFeG+FW7x4eMpveUf35oR/3U15C
         TQ7w==
X-Gm-Message-State: AA+aEWZQXi62/F3xsMw7a5Erj9O6Crw7o4iOWYYWsFLXhuXO8j+4+wHe
        jEAVgmUaqdQZ+weF9sq4tL4=
X-Google-Smtp-Source: AFSGD/UBZRe+NgBpQ4ZNjg3RUGHy4SbeGSV2EKCH+20ZtI76E1eh+xEcPPdudubKCvneAt93dQCqUQ==
X-Received: by 2002:a50:98a6:: with SMTP id j35mr4415571edb.141.1544827734066;
        Fri, 14 Dec 2018 14:48:54 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id q13-v6sm943628eja.8.2018.12.14.14.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 14:48:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Clement Moyroud <clement.moyroud@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git blame performance on files with a lot of history
References: <CABXAcUzoNJ6s3=2xZfWYQUZ_AUefwP=5UVUgMnafKHHtufzbSA@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CABXAcUzoNJ6s3=2xZfWYQUZ_AUefwP=5UVUgMnafKHHtufzbSA@mail.gmail.com>
Date:   Fri, 14 Dec 2018 23:48:52 +0100
Message-ID: <87ftuz208b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 14 2018, Clement Moyroud wrote:

> My group at work is migrating a CVS repo to Git. The biggest issue we
> face so far is the performance of git blame, especially compared to
> CVS on the same file. One file especially causes us trouble: it's a
> 30k lines file with 25 years of history in 3k+ commits. The complete
> repo has 200k+ commits over that same period of time.

There's a real-world repo with a shape & size very similar to this that
has good performance, gcc.git: https://github.com/gcc-mirror/gcc

    $ wc -l ChangeLog
    20240 ChangeLog
    $ git log --oneline -- ChangeLog | wc -l
    2676
    $ git log --oneline | wc -l
    165309
    $ time git blame ChangeLog >/dev/null

    real    0m1.977s
    user    0m1.909s
    sys     0m0.069s

Its history began in 1997, and the changes to the ChangeLog file by its
nature is fairly evenly spread through that period.

So check out that repo to see if you have similar or worse
performance. Does your work repo show the same problem with a history
produced with 'git fast-export --anonymize', and if so is that something
you'd be OK with sharing?
