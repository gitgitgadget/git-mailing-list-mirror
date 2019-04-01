Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADB7320248
	for <e@80x24.org>; Mon,  1 Apr 2019 20:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfDAUv6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 16:51:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44838 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfDAUv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 16:51:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id y13so5151963pfm.11
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 13:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tUtsBbdJ83xf7Oc1B53311qtwKkXdib8ELxgEej1L7Q=;
        b=JRS+C07GJsUjaLvjINPqOypJHDYQL7JNI//GdWpoG8+LyDEzo/UdAEGHSvuRsUQKp7
         OksOFoRK2Ixxlk2HuyScL4gxfCzh+i2BD2cuDs6GJU8g8sEH469+oaO7MxrUr/1diwdu
         iow10OW8dJoe/naY/TNIjMPjCSDCJcfNv2eq7a62GbEY40i5vQ4vn29Daq7atpyXm98x
         H32G/2hyGdm2q9SZtJIpKzNQTIkJAqY1TaLclXr18tw7hj0Qeur5hhruY5eom3WDVFx9
         mbcrYKTjFEcJq3Ik04GXX7cIVHPjUspR+Fzo2Yeg8yFRdTGn8FyQzjUy/HMJwyPgVDwi
         Ihxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tUtsBbdJ83xf7Oc1B53311qtwKkXdib8ELxgEej1L7Q=;
        b=VaNwmYAexAays0cI29ni1oaa9afE+ReQtb6rUXx4mMRo2ytORn5Ad3KRJcNp69ctRl
         iTERZbHhEeAhXazf7fiRbY4IxQfpwLGx2zKp4UdPbh4Iv7wRpoB7LWUbOGY9glIho+Bd
         SSrymJgpj0oK/dQadDunRsS2QWO+rVixrpiXwcnFhHWxp/kBy7FAv8qyjo2G3s3FhFsj
         DdqC1UrNP49yWn9qKuIlFSg+KlYVula48iy1X3ceGrqWjXIuVYPwGsfY47C5gdJPA++z
         IHhm8mr+D08/TUsmIHlUEV+LZPUnSL/jkDaQYrlSzoGkHbOmKaHe91CscmzzLOskFvvb
         okCA==
X-Gm-Message-State: APjAAAUk7y+p3+TTayjDJ4faubJrGnKsJQ1BHWiJLAEAdj8fI+QZuakv
        UlyhRR7ANOobSxcloQCW5DfRRMNY
X-Google-Smtp-Source: APXvYqyb2wQuqVI5fcTcWvyuBjWJWDMwFo1poETw7TiDrpmdnHIAKRdgx5uomYGFo7HrCFoAuDA53Q==
X-Received: by 2002:a62:2fc4:: with SMTP id v187mr66900921pfv.147.1554151917430;
        Mon, 01 Apr 2019 13:51:57 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id 13sm13703719pfi.172.2019.04.01.13.51.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 13:51:56 -0700 (PDT)
Date:   Mon, 1 Apr 2019 13:51:54 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 0/4] rebase: teach rebase --keep-base
Message-ID: <cover.1554151449.git.liu.denton@gmail.com>
References: <20190328221745.GA3941@dev-l>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190328221745.GA3941@dev-l>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks again for your feedback, Ævar! I think we're both on the same page now.
Hopefully I've addressed all of your high-level concerns with this patchset and
we can move into a discussion on implementation detail.

This patchset now depends "[PATCH 1/8] tests (rebase): spell out the
`--keep-empty` option" which is the first patch of Johannes's "Do not
use abbreviated options in tests" patchset[1]. (Thanks for catching
that, Johannes!)

Changes since v1:

* Squashed old set into one patch
* Fixed indentation style and dangling else
* Added more documentation after discussion with Ævar

Changes since v2:

* Add testing for rebase --fork-point behaviour
* Add testing for rebase fast-forward behaviour
* Make rebase --onto fast-forward in more cases
* Update documentation to include use-case

[1]: https://public-inbox.org/git/a1b4b74b9167e279dae4cd8c58fb28d8a714a66a.1553537656.git.gitgitgadget@gmail.com/

Denton Liu (4):
  t3431: add rebase --fork-point tests
  t3432: test rebase fast-forward behavior
  rebase: fast-forward --onto in more cases
  rebase: teach rebase --keep-base

 Documentation/git-rebase.txt     | 30 +++++++++++--
 builtin/rebase.c                 | 72 +++++++++++++++++++++++---------
 t/t3400-rebase.sh                |  2 +-
 t/t3404-rebase-interactive.sh    |  2 +-
 t/t3416-rebase-onto-threedots.sh | 57 +++++++++++++++++++++++++
 t/t3431-rebase-fork-point.sh     | 57 +++++++++++++++++++++++++
 t/t3432-rebase-fast-forward.sh   | 62 +++++++++++++++++++++++++++
 7 files changed, 258 insertions(+), 24 deletions(-)
 create mode 100755 t/t3431-rebase-fork-point.sh
 create mode 100755 t/t3432-rebase-fast-forward.sh

-- 
2.21.0.695.gaf8658f249

