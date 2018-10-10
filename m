Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C91251F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 10:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbeJJSDb (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 14:03:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43292 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeJJSDa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 14:03:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id n1-v6so5137621wrt.10
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fw5lyk+g9Dp2tVGYMoGnsShT/gnJScbEGeUdYsWxpn8=;
        b=PlBU/G1y61WvSV5U7rUg74IIjGZYbXKNbwn/OBoFq/YYglETW7rzHz5TyWPel1MZib
         GcXG0Jzxksov12uPrLj76NSqQpOiG+unxsA3ziitEug2lUoYMXmioOM/DflshZ3dck8I
         otOmIA+LPO8W++qt9e0DAB/3PyZYTth7G310yTdqeXE4/8COZbwtIGmmz9siZgfaSpFX
         mRB8o0G8zPV28Xm4P/bFy4DWzFV2iufBU1f/NnnyGpMdjD9MbOyMJShWVqOiOSs8ojow
         3LqgY2DeDwO99jVDoE56/rQPjDzDMLWUzenuNJ+LHGhzJGXIYu49zIjl6oogP7C5VjnR
         Lb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fw5lyk+g9Dp2tVGYMoGnsShT/gnJScbEGeUdYsWxpn8=;
        b=WQC9clVeNmYLQWvSV3QDE5UOKgsTHW1YBXfmJegk6VCTVR4KmiYzsJEr2N3w9wgc9G
         zUN5cqBxJwcDaxCVysLMaKn8py8yRu4z3XQZ9tS2pY1u2qOYdMrNyQRKi6O2XZWQfjUY
         vI2EvPdXuquZH+kuptlX++3MY/1sUxY6gLYTICtQ6co2rPnZBXfL2BLuHtS8MKVu4jqW
         pIR5IYubtNk2aZnQrv5JdTrlrl5rX/Zs8Jg1a13YiTYPEdJEAY2F7pR/c/Zxws75c5yD
         kcskRJUr+dzsa2HgXx7M0WG09kDavkuKPkNhgdhcyu2OAUcjT8LjxTUKiOGyo/j4wB/B
         NQYQ==
X-Gm-Message-State: ABuFfojrgH1wPguAo65Mv/JuEYnzfubLkJsqoo9+2QxtyXjgSWzV6Whh
        o4JKzkCZPavW1Hun2gNSt74/dils
X-Google-Smtp-Source: ACcGV60LsE04kGlspiH/fR8WJqlOnnU80OSmteHUTItkaZqa1oSDev6ErUXjm9lcMxEYz4fp4dfhvg==
X-Received: by 2002:adf:e607:: with SMTP id p7-v6mr23131808wrm.254.1539168115846;
        Wed, 10 Oct 2018 03:41:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 204-v6sm16061644wmh.25.2018.10.10.03.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 03:41:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] add an advice on unqualified <dst> push
Date:   Wed, 10 Oct 2018 10:41:43 +0000
Message-Id: <20181010104145.25610-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.390.gf3a00b506f
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Years ago I accidentally deleted the "master" branch at work (due to
git push origin $emptyvar:master), and while I could tell from the
reflogs what SHA-1 I needed on the other side ran into the fairly
cryptic error message, certainly to me when the adrenaline is flowing
and you've just ruined something in production.

So this series makes that error message better, and suggests to the
user how they can fix the situation, first I needed to mark some
strings in remote.c for i18n.

It would be better if we could just give the user a full command to
copy/paste, i.e. what the ran but with refs/{heads,tags}/<their-ref>,
but between passing the remote name down, and handling any push
options I think it's better for now just to suggest the refspec.

Ævar Arnfjörð Bjarmason (2):
  i18n: remote.c: mark error(...) messages for translation
  push: add an advice on unqualified <dst> push

 Documentation/config.txt |  7 ++++
 advice.c                 |  2 +
 advice.h                 |  1 +
 remote.c                 | 86 +++++++++++++++++++++++++++++++---------
 t/t5505-remote.sh        | 25 ++++++++++++
 5 files changed, 102 insertions(+), 19 deletions(-)

-- 
2.19.1.390.gf3a00b506f

