Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35BA51F51C
	for <e@80x24.org>; Fri, 18 May 2018 21:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbeERVXx (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 17:23:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50847 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERVXw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 17:23:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id t11-v6so16311034wmt.0
        for <git@vger.kernel.org>; Fri, 18 May 2018 14:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HTX3UiS6kYKuPCNIMpmvxfzzmI2D6UevtdhKosZqSrA=;
        b=CGgfR5KjWMGErhsdT2o80+yEhUp/1TRzNu6ojqKeaG+h/4QgPELgYQrvpel+1WBnSZ
         2aUBq4oAMykLDnAaKMkaB1yFO2Aem3IOvDYDdnc2XAQfF56rSygUt7u4EEfhdtLEZfAH
         uHth1NHn+ZlptW8AOHdBSVZ/87Cb+iIOTJpViQu4IPc4rVebTDXRcjt7jkrqqvd/aHic
         S1YvYTEe0v+jr/ZwoTqbR5vvTib+9Pg5n6ELS871mM2V+C2esLwx2OwAHnVVjyOYpHup
         npPXVopINJ6k3NHxT+K+AWwhA0q/h/4B3SxrTaZ+XL4NQn+FejpNl88vU8TNweUpLqhe
         L2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HTX3UiS6kYKuPCNIMpmvxfzzmI2D6UevtdhKosZqSrA=;
        b=WkmBq96Q/t1NBpip122c8KYXVp1fWC7YPcX7mszragV6A+OteOelhsjKQ4Iar2r9dA
         PFkpzJzkR+TVTYPNlJjlb2n30kFqib24Yaj+61YoHYsYTS/4wQcsVyQLdDb4SIcOwqG/
         37D2GfkxhP3sYaMKPoXajphSd8XnZjRvibeNHYl6VgtSMr8hhAu4YSyn1FzdTxm7OhXQ
         AA5+bBDqzTKCr1ye8E0a2us+JUbBBWlFBXmX3/6XfsO2mOQTrQuAwJgKmH8vhbB3sGBT
         cHl1HPBGQvDaHuxod33HlfDqywNlt/VV3yaAk+ywmwGOgHk4hVuIECRdjJiYkdnC++HY
         VO7g==
X-Gm-Message-State: ALKqPwfBSx4h1pqZqnd0BK0BJE2I/CqzgzXHGntCVto3ptM6R/7zN4YC
        wxTSt56pVrCNqhMx63OBy1sS+4I/HZs=
X-Google-Smtp-Source: AB8JxZrxfF/SkHFQXT5zuK7Pm/xJMYG2v8F+5hB+RQtNSAYQvCnWDwUekgLG+YS37Psg0GYzQzlIVg==
X-Received: by 2002:a1c:17c9:: with SMTP id 192-v6mr5304613wmx.95.1526678631408;
        Fri, 18 May 2018 14:23:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id u35-v6sm10969192wrc.29.2018.05.18.14.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 May 2018 14:23:50 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/3] unpack_trees_options: free messages when done
Date:   Fri, 18 May 2018 23:23:24 +0200
Message-Id: <cover.1526677881.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <CAN0heSo80SjjGtC2x9s-TmNY0=W=YWTYxyjeuAQ3utEAEynXeA@mail.gmail.com>
References: <CAN0heSo80SjjGtC2x9s-TmNY0=W=YWTYxyjeuAQ3utEAEynXeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a reroll of my attempt at freeing the memory allocated by
`setup_unpack_trees_porcelain()`. The first two patches are identical to
v2. The third patch no longer relies on rather intimate knowledge of
which strings are on the heap and which pointers are duplicates.
Instead, as suggested by Junio, I keep a separate string-list of strings
to free. That should make things more future-proof.

v2: https://public-inbox.org/git/cover.1526488122.git.martin.agren@gmail.com/

Martin

Elijah Newren (1):
  merge-recursive: provide pair of `unpack_trees_{start,finish}()`

Martin Ågren (2):
  merge: setup `opts` later in `checkout_fast_forward()`
  unpack_trees_options: free messages when done

 unpack-trees.h     |  6 ++++++
 builtin/checkout.c |  1 +
 merge-recursive.c  | 30 ++++++++++++++++--------------
 merge.c            | 35 ++++++++++++++++++++---------------
 unpack-trees.c     | 23 +++++++++++++++++++----
 5 files changed, 62 insertions(+), 33 deletions(-)

-- 
2.17.0.840.g5d83f92caf

