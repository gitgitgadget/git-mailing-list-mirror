Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F78E20281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934115AbdIYIUl (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:20:41 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33160 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932617AbdIYIUi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 04:20:38 -0400
Received: by mail-pf0-f194.google.com with SMTP id h4so3328978pfk.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 01:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IBbFnxu5rz2HcZdcxo62xUiD7DnpWaDsRVtUTPExgw0=;
        b=HnMqWDNew9Q5PM1sGzNl8Zzri2NxcvfihUmCzDLyOc5pg2HAx0V9aN2T8jW6Vk4dom
         BLzb3O0SyzA2HC/pHIt87aC56/3md5T3noTcKqCJMhwZ/AEpvKcEYI0oUP9VfBebJUot
         Z8rrxkkre6BT+x8q5+Nt43izq1rVpz5Hhh1cs2svV0VV/b9e+PLtss8WTI9D+EPOolHX
         bYRptrsmYiCFxuJzT57QgTHyOVyC4TJp5nIZ+IXJO/dyMHvJ1p5dz8hnrRCGUFbKIP/F
         Nh6gaX+9CsT92D/TBup2ggAXsSHMxE18mLXQUjUqsPaiT7HmlFuK78NbV5WyWDAU4F6o
         m2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IBbFnxu5rz2HcZdcxo62xUiD7DnpWaDsRVtUTPExgw0=;
        b=qbSC8GxBEOK1YDTcnW/BJLGKpZr71EnrTnzBjqNT3ktP479ByI+cFu6uUqs0DalZWD
         IPCldsjcCQUpVMiVDTbcgaroaEk3AKrQZo7ObD8ByjApQoDmUATz9yhVyeGSqQNMJ32i
         GWfttb6/f+IwuunVhIKjS3+7asSCryCLyAKVCHl0tNd8lfmQYbajnv5/IyPWMFBgsZBo
         t8PhnKOhRrx55C3qJsP4gcr2lujR6DaohUa+5j3lDlFK426BqZMcea6gGYxti5guVMXt
         E6LUhfHiblmfS6D2mcmyUFawbkZSYzL67xMIGa4Aw6OOR76nMEVrB2H2jQrOMqwqksCk
         T2fg==
X-Gm-Message-State: AHPjjUgNLQNYd8sfHAcbnEmnsnTkV2EI9+Z5gTeVK06LbGncYpWyUxtf
        Q3rDEvGR3viP9LNkANoFaKV4/CtQG61bGw==
X-Google-Smtp-Source: AOwi7QAsOB7YBwBCjumXUnlNIWgl+Ng44CzlQV2rKT5M/QUX515EbLObRspszvJphTnWCAtchpRPmw==
X-Received: by 10.99.52.130 with SMTP id b124mr6900189pga.372.1506327637579;
        Mon, 25 Sep 2017 01:20:37 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:700a:bb87:18d5:bb83:9cfe:b5d3])
        by smtp.gmail.com with ESMTPSA id g16sm11469444pfd.6.2017.09.25.01.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Sep 2017 01:20:36 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Google-Original-From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: [RFC PATCH v2 0/5] Give more useful error messages when renaming a branch
Date:   Mon, 25 Sep 2017 13:50:19 +0530
Message-Id: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.935.ge2b2bcd8a
In-Reply-To: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
References: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

    [1/5] and [2/5] - cleanup patches
    [3/5] - refactor of a function that seemed a little unintuitive
    [4/5] - just a preparatory step adding part of the logic
    [5/5] - main patch that tries to improve the error messages

Changes in v2:

    - dropped [1/5] of v1
    
    [1/5]

        - incroporated suggestions of Junio

    [2/5]

        - new in this series
        - just a little thing I thought could improve things

    [3/5]

        - used the name 'validate_branch_creation' for the refactor
          instead of 'validate_branch_update'

        - changed the parameter names

    [5/5]

        - In v1 I added the connector string and removed it when it wasn't 
          necessary. It's not possible to do that as that string has to be
          translated too and it won't have the same number of characters in
          other languages. So, I switched to adding the connector only when
          needed. Though this seems to introduce some redundancy, I find it
          to be the only reliable way.          

        - tweaked commit message a little as suggested by Stefan

There is no change in the error messages themselves. So the sample input
output interaction sent for v1 still holds.

This series applies on top of 'master' and can be found in my fork[1].
In case you were wondering, the Travis-CI tests did pass.

[1]: https://github.com/sivaraam/git/tree/work/branch-move-revamp
[2]: https://travis-ci.org/sivaraam/git/builds/279199977

Kaartic Sivaraam (5):
  branch: improve documentation and naming of certain parameters
  branch: re-order function arguments to group related arguments
  branch: cleanup branch name validation
  branch: introduce dont_fail parameter for create validation
  builtin/branch: give more useful error messages when renaming

 branch.c           | 69 +++++++++++++++++++++++++++++++++++++++---------------
 branch.h           | 53 ++++++++++++++++++++++++++++++-----------
 builtin/branch.c   | 43 ++++++++++++++++++++++++++++------
 builtin/checkout.c |  8 +++----
 t/t3200-branch.sh  |  4 ++++
 5 files changed, 133 insertions(+), 44 deletions(-)

-- 
2.14.1.935.ge2b2bcd8a

