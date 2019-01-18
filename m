Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B461F453
	for <e@80x24.org>; Fri, 18 Jan 2019 18:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfARS4I (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 13:56:08 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39034 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbfARS4I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 13:56:08 -0500
Received: by mail-qt1-f196.google.com with SMTP id u47so16352330qtj.6
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 10:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJSdsgPVHoEBXTlT8XL0geo30OdqvKUgEYiQOfExs6c=;
        b=ZDiN6nj6Zk5QbSnyzKP17Nveqzdl2L7acb375buC3AiZjq/pB+oaRUBnvUiu3h4TAl
         koFVsp37Y3cIaFI9MB3lkgXVt2lde+4O+apcR909Eps7/v7lTkZ7q8cZjNB6Jf/7j83l
         Eq8f164Qg4Y3CjpmmPocMjidfJOATLzCvYa3HG8/3YkA6eryM48Y8OBKSCjobFd8lx7n
         fpkUt3cAp50xGoMniGFB98tusP2isHBKhB6qoqus0EmZP3jcwey7Lu6kEJaFJItL1Byf
         Us30FouVmrEvgviPr5aVUK0/HRtgCKfvpIUBU5P/8ItfuZPyauMm5Wbr3vqMJ7RnOpVS
         GJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJSdsgPVHoEBXTlT8XL0geo30OdqvKUgEYiQOfExs6c=;
        b=VBOnL6BegSPu+n0lI1V56lgMbFZi03uR3f4xrLEhazNqvKVlKe6FsruGe5hLLZK+vI
         tN3dsdo5gkxlpqv/CiJVUeqxBkNUoKf8667uDjB+Ez909r7lS7tGiBlBFL/fKELRZR2P
         XhMrhOPc0mMZTDwJXrquQ6vSzHOH0pJE1a/33XxG+VboK27ynT8rI9IZJsAkNf2AP0h7
         0wDTzjob+eq46cNqgagYBRaHvGXc/UKsSbQ5T5ZRHl38N3HmO1LOk5DS88J9oCDAcVrp
         B3DU1LtA0SnhcAZbYaYa+d1uZf60grbc0O5dTvdjwUQo3rAix5N57S5EaOuc+Q4k2Gar
         oNbA==
X-Gm-Message-State: AJcUukf+qDdkLTMm+OT5LL1GsGw5q2e3iF9/doLZ1bKGzfIwkw89Htg4
        rZUFrIrcr3qKdRZayWhS3WBxbYlCJ2c=
X-Google-Smtp-Source: ALg8bN5ZQORUCf9uCHTNcAnFWuXNoKriBGKrn3lAOm4dK4YrI3tIAu37/ZaUlpxt9qliHUwABvoMSg==
X-Received: by 2002:a0c:e34f:: with SMTP id a15mr16784915qvm.147.1547837767309;
        Fri, 18 Jan 2019 10:56:07 -0800 (PST)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id b20sm70228520qkb.17.2019.01.18.10.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 10:56:06 -0800 (PST)
From:   Ben Peart <peartben@gmail.com>
To:     git@vger.kernel.org
Cc:     benpeart@microsoft.com, asottile@umich.edu, pclouds@gmail.com,
        gitster@pobox.com
Subject: [PATCH v1 0/2] Fix regression in checkout -b
Date:   Fri, 18 Jan 2019 13:55:56 -0500
Message-Id: <20190118185558.17688-1-peartben@gmail.com>
X-Mailer: git-send-email 2.19.1.gvfs.1.16.g9d1374d
In-Reply-To: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
References: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Anthony Sottile <asottile@umich.edu> determined that commit fa655d8411
"checkout: optimize "git checkout -b <new_branch>" introduced
an unintentional change in behavior for 'checkout -b' after doing a
'clone --no-checkout'.  Create a test to demonstrate the regression then
fix the bug and update the test to demonstrate the fix.

Base Ref: master
Web-Diff: https://github.com/benpeart/git/commit/3930f7fa32
Checkout: git fetch https://github.com/benpeart/git initial-checkout-v1 && git checkout 3930f7fa32

Ben Peart (2):
  checkout: add test to demonstrate regression with checkout -b on
    initial commit
  checkout: fix regression in checkout -b on intitial checkout

 builtin/checkout.c         |  6 ++++++
 t/t2018-checkout-branch.sh | 11 +++++++++++
 2 files changed, 17 insertions(+)


base-commit: 77556354bb7ac50450e3b28999e3576969869068
-- 
2.19.1.gvfs.1.16.g9d1374d


