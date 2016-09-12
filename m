Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0120E207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 12:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758284AbcILMzj (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 08:55:39 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35662 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758196AbcILMze (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 08:55:34 -0400
Received: by mail-lf0-f45.google.com with SMTP id l131so85954676lfl.2
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=Q468lU0vtcadK1zQuamFx37TPHvHKj9VU6tkR9uOEmw=;
        b=yIxRObyhyDW14VQL+UHUDyxWJO+MH0LKoyttV2ghCyhIStIVHhAc+KLH0zlSKLDUI8
         pHMOXN8mh7YPM6zP20BgFV/LNrc0Ixh+8mJncUUr15/GKAxgmBGvuTNwAxjYmESESG9t
         gJ3q/Ws9f2vHEB1JJfxmz9RwpGtd1b8pUeZ2FwUtV/9/vgNgu3sgTo0KVghdERVZxW5i
         gLcMOx6RUpRDj/Ch89KamP59DYqEKVT5r66IJhf2XfiAvyEUodrAfDWuGDoyBAczUUQE
         XqmOuIRii6FBrbCrUt/BtFsGJOEVVvX/Jo5agK+c0iJ8XNAivzpPnMT7jKvJcX8NkY4f
         x44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Q468lU0vtcadK1zQuamFx37TPHvHKj9VU6tkR9uOEmw=;
        b=fvomUwDjtXrYBv4UwhZwLeP1wURR1lMw+F0lDXgN5OK3DgEUEI1NVX+ndkyxj7clCd
         UR03QDSD1E7JNnZC7eyTPfDHBqfm3W/yRZEteQgBs9XoxasE4qnkCNJJbT6ALQRsyGHP
         hsLD7wyKDES1050EblTMkEaMTYwG9G/YoMExviMJuLgacgz2wZP0Ga+65ofHaXpdZzcy
         ju6jX43x67oJ7vShEQCMlt3QNS8OY/8shi0XelBNVwjKfUlMSTeUNfP+A8MBAxmD5A8N
         C2oeXPu0jNn0v0/KZPAie+9CD2sZD6LcaYck1dsIYKo47iLi8UIquagIrS3hvs6qYkwP
         glgw==
X-Gm-Message-State: AE9vXwOwM+qNYxKcSp6nYOxNo34A0c861xvkes/gpC+O9ciIaPZJPchoRi/ZVZVyMthZdXHuiaIjKqtx79zZRQ==
X-Received: by 10.25.146.197 with SMTP id u188mr4766939lfd.146.1473684932182;
 Mon, 12 Sep 2016 05:55:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.165.194 with HTTP; Mon, 12 Sep 2016 05:55:31 -0700 (PDT)
From:   =?UTF-8?B?0JLQuNGC0LDQu9C40Lkg0JjRidC10L3QutC+?= <betalb@gmail.com>
Date:   Mon, 12 Sep 2016 15:55:31 +0300
Message-ID: <CANYoZJng0GNZWU=eUEnXgVQ_NKQQOKM+mhJ9bsXMEJxxEhwQMw@mail.gmail.com>
Subject: Gitattributes file is not respected when switching between branches
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good day

I faced following issue with gitattributes file (at least eol setting)
when was trying to force `lf` mode on windows.

We have 2 branches: master & dev. With master set as HEAD in repository

I've added `.gitattributes` with following content to `dev` branch

```
* text eol=lf
```

Now when you clone this repo on other machine and checkout dev branch,
eol setting is not respected.
As a workaround you can rm all files except .git folder and do hard reset.

Issue is reproducible on windows & unix versions. Test repo can be
found on github
https://github.com/betalb/gitattributes-issue

master branch - one file without gitattributes
feature-branch - .gitattributes added with eol=lf
unix-feature-branch - .gitattributes added with eol=crlf

Thanks,
Vitalii
