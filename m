Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 533C31F404
	for <e@80x24.org>; Mon, 19 Mar 2018 23:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755931AbeCSXSo (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 19:18:44 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35117 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755871AbeCSXSn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 19:18:43 -0400
Received: by mail-wr0-f196.google.com with SMTP id n12so20328992wra.2
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 16:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XKFoaMhu3gu67086fNyT/nSdPRfXN+XLIRy2vqmpqcY=;
        b=ZPqAJ0zCDzjfd0PdZafCQilnnyXd4O0MG2jjxhnHsc4sbMp+FteGsowrgF6pdL+CGO
         argi66aqNi5z59I2ZvI8WPDlEoji8C5jkMUw4ybMlH/KBk4SXP1Vskf4O+nNkYuaAVhf
         7T8dLhn+P35LlnjBfY/39HacOjaznweY2SqOCy2NARaXiBeHTC50Wn2bKjyfMiLwXike
         Fbri1/n0o9up3qyTvVHgQT0n/9saXvVI/COrBKRdWbKRwZr11vFiRfJu/xHhmWet6tJ+
         LMF4TtQZggN5n1fX7tbGF82pTt9mxKb5pRezNUqhnsJrCWM2pL4Med0ePYS9304LdHyH
         kaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XKFoaMhu3gu67086fNyT/nSdPRfXN+XLIRy2vqmpqcY=;
        b=L3Z34v2LPzKZAe9VC+pNMGQh5+wAVWgIn8yPaU6H0XNnpjHd02qbMAkN7SZA++ZDsd
         Qxwv6sRioed2ONJ42SfJhZ+9NE9EXTbcpzCGorJ3eXvPo2hrb4E/mluzrFvXMIinAZ9/
         bd+cOM94bjJHTEa0IJ5i5dA+JmvWyy8fo8ymxfRES4BTlj46LimeRbcNWQoXhcublyge
         wAdYP7U862j2wF/uJbYzkkWhmnZDU3npbOcDlotMB65DzrmDH4QnvPmWJMISaFqDm01U
         VWbOlUDZyXmWwX+IcyFznZG9lVdX8VUIx3/KT8x9BVzZtuUWYGWt4CfDayCksK+yT2aZ
         Jn5g==
X-Gm-Message-State: AElRT7HohCkFj25pL1Y1SNTVOC5P/3iIkpo5VzYNZLcZKce2MsvDadUy
        d2HoLTi7Zt87I4MrwzwP/tEUgwZj
X-Google-Smtp-Source: AG47ELt5/+K51zz7FYpuLr6c4+itl1OsMzwywWUcASwFoJQH+N6FgeKHyjcE3bpxagylcAp3kSjlxg==
X-Received: by 10.223.134.47 with SMTP id 44mr3720056wrv.114.1521501522078;
        Mon, 19 Mar 2018 16:18:42 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id j4sm435791wrd.53.2018.03.19.16.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 16:18:40 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 0/3] stash push -u -- <pathspec> fixes
Date:   Mon, 19 Mar 2018 23:21:53 +0000
Message-Id: <20180319232156.30916-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.1.33.g3165b24a68
In-Reply-To: <20180316223715.108044-1-gitster@pobox.com>
References: <20180316223715.108044-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks again Marc for all the testing and Junio for fixing up my brown
paper bag copy-pasto.

This iteration addresses the breakage Marc noticed with the latest
version of the patches, adds some more tests, and moves all the new
tests to t3905 instead of t3903, which I just noticed exists and is a
much better match for the new tests.

Patch 1 and 3 are the same as in the previous round, Patch 2 is mostly
rewritten.  Instead of trying to avoid part of the pipeline we're
using to get rid of changes, we now are getting rid of the 'git clean'
call in the pathspec case, and use the existing pipeline to get rid of
changes in untracked files as well.  I'm not adding an interdiff,
because Patch 2 is mostly rewritten and the other two are unchanged,
so it is probably easiest to just review patch 2.

Junio C Hamano (1):
  stash: fix nonsense pipeline

Thomas Gummerer (2):
  stash push: avoid printing errors
  stash push -u: don't create empty stash

 git-stash.sh                       | 12 +++++----
 t/t3905-stash-include-untracked.sh | 52 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 5 deletions(-)

-- 
2.15.1.33.g3165b24a68

