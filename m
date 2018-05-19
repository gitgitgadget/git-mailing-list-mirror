Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F6C31F51C
	for <e@80x24.org>; Sat, 19 May 2018 16:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeESQjK (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 12:39:10 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:45587 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbeESQjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 12:39:09 -0400
Received: by mail-lf0-f48.google.com with SMTP id w202-v6so18232618lff.12
        for <git@vger.kernel.org>; Sat, 19 May 2018 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=y1B2g/hm3H4fbPZgWe5N/J6BUhTVhHrntJVP/zwCbtw=;
        b=HsH/e5WK12JDodH/9rdXHOdDfxxWbP69+9g9mhvt9YzfiWrW/KvN4tOe5ZuEgtkqh1
         ucOB8tYBoSMwxEdmt19oRwYPamjEvALcCU2vW7g/6Hrz2zR7Fdzx5WR9m4sxBniQ5Uva
         mTnxwVM58NeXrzU4Iya9Qzt3BC3R+We0QuE0ZY2ImGdtgyKW1YqQIAUxJiUOcn+7u3HU
         0VZgZ0utmqyuYiUeIsay6AQVwnY2rXzNDiCMpGObfP/Hooe7bSX7JhAYbozxFhjRC6Aw
         do/r84s2dd1g00Z2cF6mL9urap9ds4FtxJF7+7362dZPMLMAwFpIYEJ1Q5qP6XQfE5X9
         o+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=y1B2g/hm3H4fbPZgWe5N/J6BUhTVhHrntJVP/zwCbtw=;
        b=dehleZivuQlrwzMTKhU6G+whdmyQJvWjsv239q9QFoYUReoExtv76WOHT8EYXuYekN
         hA2v4WqnLIYCHd8CXgqa+Q1Yv9F4uTzpTyFdhZsJ5Yt2ea4R0oCpy+JL82VzF5VD7U91
         sABVwDRUNlH0WI/Vw8SaJZKEte0WGr6nB6pYL4LxWJA7H0bPceS4sGyVeCGOrSO54M7C
         HRCBo/6JCYcuF02mbp1MkuCyiyiLXqsQJq4pNsJ6cAqaaIIM/H6l9McZ2PysXvrH5D6y
         0aYiVzyXH7WQk72jqC0s+CugkjBIJOg3LNJB9jE2eLn85rAwb7XnAxc2S58dhB0+RtCF
         6nWA==
X-Gm-Message-State: ALKqPwfxJjSEZnUQo7C6+LbnwWf02PrYNDZF8YgkWxO4tefKGwL80HfB
        fIcGmeJC/Er0SM5TmVEvU4ssUg0wmqxERqqE7IDDbg==
X-Google-Smtp-Source: AB8JxZrQHkLAV9APfqU29Pql3Ceig548FKkb4A3Xxigf8UMxBjau4YYpIxe/c6LwE8aZZhsyEXbUhmaQEC4q2m7FseA=
X-Received: by 2002:a19:becb:: with SMTP id o194-v6mr24503391lff.13.1526747947594;
 Sat, 19 May 2018 09:39:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:d485:0:0:0:0:0 with HTTP; Sat, 19 May 2018 09:38:46
 -0700 (PDT)
From:   =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date:   Sat, 19 May 2018 18:38:46 +0200
Message-ID: <CAAUqJDu_3DTyd1cFKaNRKOzo3AHosfxP1jjWpa=HGtyAyitTeA@mail.gmail.com>
Subject: git rebase -i --exec and changing directory
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am trying to run a script to edit multiple commits using 'git rebase
-i --exec ...' and I ran into a strange behavior when I run 'cd'
inside the --exec command and subsequently run a git command. For
example, if the command is 'cd src && git status', then git status
reports as if all files in the repository are deleted.

Example command sequence to reproduce the problem:

    # Setup:
    touch a
    mkdir dir
    touch dir/x

    git init .
    git add --all
    git commit -m commit1
    git tag base
    touch b
    git add --all
    git commit -m commit2

    # Here we go:
    git rebase -i --exec 'cd dir && git status' base

    # Spawning a sub-shell doesn't help:
    git rebase -i --exec '(cd dir && git status)' base

Is this expected behavior or did I found a bug? Is there any
workaround, other than cd'ing to the toplevel directory every time I
want to run a git command when I am inside a subdirectory?

$ git --version
git version 2.17.0

Thanks,

Ondrej Mosnacek
