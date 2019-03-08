Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D5820248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfCHJ2o (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:28:44 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34543 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfCHJ2o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:28:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so13703771pgd.1
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xhvAA2XO4BKtzzV3J2LH2iap+rMOe1+cijfFmSwZWQ=;
        b=UefAj6z9qmU/SelSMHenb+cejkSqOKbA8wg7rU7FCkVfexUNK3+DzljRV4feG7Ju+x
         DRdy96d5u6d3DlbIToM1ZHm3atACmbSmdfGtW5TxGrpxZHjcRUpvGQ6WWlNoFcqDQJRY
         1MnIhKRrg5+OIMXs7DtKuSZtODoviG73Epk1Y47m4Z2xS1eSztjkRz27ixrNWM2EpQ6t
         OTroMOgFws40az7KTg58pBqItqhrjwF90MEeUiKB/EPwFQIHe6Vxk4DwxA11xZFuaurB
         E24gx0pIDoiRG9AGbsXS+Mkf57MJob2tCj8w+943UQCg3O7BUzMujX5amyU4AAxM7QQZ
         HsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0xhvAA2XO4BKtzzV3J2LH2iap+rMOe1+cijfFmSwZWQ=;
        b=Xo9o9c2gS1vw5RuxT06I1pmIHwrh0CisjhDv8Ad6u1K9Dq7T/3K7CvSmH8gOHjnbwe
         l6zjLwa4D2/xR62q9lSUVwbsyQhHyyV8dWQ/OB5U76fGABJ5MqnPZf76WGuC+w6y8TTO
         F5mNU+TE/9DHlu3fvxGElTwTig4FxMU9bzd/B23DR2ELLxX5f6V2WxDB6yMWz0WLq/Xt
         U/nxEXd96MW0tsDz92kvJv/byX3e7+rQwg4o0b3lcbsu1NDnQ8Th+i0Mt0uw0Uwex80T
         Kpjno41yGu218Fns+GuJOIVss6xF/i3GoHZTOQeYYeLkprdl98WL428GF+ti2HZJWK5N
         c9Fg==
X-Gm-Message-State: APjAAAX8tt8tKFRpd7txf7vX5C2p0PHRRT6uZ/1yRUKYjpTsdy0IWMRm
        dH6FDYY8TwVbbwHb5ngyKHg=
X-Google-Smtp-Source: APXvYqxzne7tHO95nx40pK78qfdjhbS2OtSAn48eiObbv5jx3nYy2hzi/G1z1Qx+KjHBQJpQgtgFow==
X-Received: by 2002:a63:df09:: with SMTP id u9mr15579465pgg.299.1552037323413;
        Fri, 08 Mar 2019 01:28:43 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id 20sm15982938pfs.182.2019.03.08.01.28.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:28:42 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:28:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        hi-angel@yandex.ru, peff@peff.net, ramsay@ramsayjones.plus.com,
        sunshine@sunshineco.com
Subject: [PATCH v5 0/1] worktree add: sanitize worktree names
Date:   Fri,  8 Mar 2019 16:28:33 +0700
Message-Id: <20190308092834.12549-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190305120834.7284-1-pclouds@gmail.com>
References: <20190305120834.7284-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v5 is basically Jeff's version from one of the replies in v4, where
check_refname_component is enhanced to optionally sanitize.

I was reluctant to go this way because it makes check_refname_component
more complex (turns out still manageable) and burns worktree rules in
it. But there may never be the second sanitization user, we deal with
it when it comes.

As said, refs.c is pretty much Jeff's except two major changes:

 - handle foo.lock.lock correctly by stripping .lock repeatedly

 - sanitize refname _components_ instead of full refs. I could construct
   worktrees/<name> and pass to Jeff's sanitize_refname. But then I need
   to strip worktrees/ after that.

I took credits so that bugs come to me first (then I'll blame him
anyway while doing some evil laughs)

Nguyễn Thái Ngọc Duy (1):
  worktree add: sanitize worktree names

 builtin/worktree.c      |  10 +++-
 refs.c                  | 103 ++++++++++++++++++++++++++++++++--------
 refs.h                  |   6 +++
 t/t2400-worktree-add.sh |   5 ++
 4 files changed, 104 insertions(+), 20 deletions(-)

-- 
2.21.0.rc1.337.gdf7f8d0522

