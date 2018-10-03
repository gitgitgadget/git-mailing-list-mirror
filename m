Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AFC91F453
	for <e@80x24.org>; Wed,  3 Oct 2018 15:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJCWZh (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 18:25:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40246 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCWZh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 18:25:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id r83-v6so5544432ljr.7
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JsOYLy30W/TX9SmNm1ss24L+cwKwyh/hvRjHzAvMNEc=;
        b=pNFRqqxeGqhNl6x/CDBRAK7GnbvQVb4QLqhH0L1AqmFliFR//6pPmKPN3qsku4BNlP
         C36GJVzmltMhjGRVXGnv9D+lFGRj+lG8JsFYaS9HTaM//C2LOmR8Zs5866CrQJMjpmZq
         KQkJvzqMgVNhBEVEn9iG3Q92f9AAd2TYZRIt3Tl66Bx7UYpFisqMcfLmRUt1GjU9p3hT
         8r8k8VSfjSbDBjMYYhCo69qqQsDQb3g9dap1GslbcVdKlzDPY93jTtml7U0VFoKsCAf9
         HYrJps0pdniIHc+v++aG/2n9o606WwU2bj6cu3sK4rG7zP5jaLl4SEARl92m/TtUNBqj
         Xqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JsOYLy30W/TX9SmNm1ss24L+cwKwyh/hvRjHzAvMNEc=;
        b=L5YcFi2TAmo7mdkJEclvHzcjnwyYEG6TcMMVP1TW9a7VJoGGNWgKtsoHd9zN9Rr9AH
         UYyOn5zR+s8bYGjFeDCQbMf09JfT8pf8f2Kwun5v25Fe+WGo4tTB+D5b7lxIdOKmNQ5o
         MB/8mo+DCI/FyH+UPzN1IUvv9cw5L7qJs0GS2oTX4EN0FmaFveD9LV2g/sYdTwTISaTN
         pFCZND3pGmET4kepvcYtZhVmzAtXnhrvmFE7rtMbZUeZPf4ZWUr61LclSGJ82jGp7thd
         7KprhIUi8vnxTei93JDF5Ncm1C3fnHWAD5sUQp/2JLF4rXHJ5DWIJhwTEaqdWtv3oshb
         yY/A==
X-Gm-Message-State: ABuFfoh7QpNaIfuiJ3PL0+T8HlDkeLhsvLNsxiFfHpPAOIt97mZwkKL4
        vazs2EYlLyLz1G8lHrFWEEE=
X-Google-Smtp-Source: ACcGV60JMkAoaPsWAs1BOKkQdulNkB+AuwcWWgjZy6eopqWbtKyGpGNCPWr+18DIbU0zJJ2AqMjG5w==
X-Received: by 2002:a2e:6e08:: with SMTP id j8-v6mr1635116ljc.61.1538581001928;
        Wed, 03 Oct 2018 08:36:41 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id u196-v6sm471838lja.42.2018.10.03.08.36.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Oct 2018 08:36:40 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        gitgitgadget@gmail.com, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 0/2] commit-graph: more leak fixes
Date:   Wed,  3 Oct 2018 17:36:21 +0200
Message-Id: <cover.1538579441.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.0.329.g76f2f5c1e3
In-Reply-To: <1686b309-e0af-5518-0fa5-4635b2f481b9@gmail.com>
References: <1686b309-e0af-5518-0fa5-4635b2f481b9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

These two patches on top of yours make the test suite (i.e., the subset
of it that I run) leak-free with respect to builtin/commit-graph.c and
commit-graph.c.

The first could be squashed into your patch 1/2. It touches the same
function, but it requires a different usage to trigger, so squashing it
in would require broadening the scope. I understand if you don't want to
do that.

If you want to pick these up as part of your re-roll in any way, shape
or form, go ahead. If not, they can go in separately, either in parallel
or after your series lands. Whatever the destiny of this posting, I'll
follow through as appropriate.

Martin

Martin Ågren (2):
  commit-graph: free `struct packed_git` after closing it
  builtin/commit-graph.c: UNLEAK variables

 builtin/commit-graph.c | 11 ++++++-----
 commit-graph.c         |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.19.0.329.g76f2f5c1e3

