Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BA7620248
	for <e@80x24.org>; Sat, 23 Feb 2019 19:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfBWTDW (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 14:03:22 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33059 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfBWTDV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 14:03:21 -0500
Received: by mail-qk1-f195.google.com with SMTP id x9so3126313qkf.0
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 11:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUrYx7kpDgdZN97hUvbm5A21VdmjRSYT6dRlq7E5Z14=;
        b=nBUUvBCiOGsUxL8afQ9H/60VZt+p3YMJwLgeU/RJ/ilR1DCrfpoLg6fbGu/muadixq
         v8GW88qOTZBbHlbZRhxl1pA8iEV2R3/avkVhM9KI9wbPEragmbYfYzqHn7TqPdTNmcUN
         SQsiEMEyqwwgOcBM/2v/snAXjY04PSLSBtfjXr+l84933xUwT8Vi4BnqgipvHnJxOnVI
         W4YLBsO7J4iMQHvR6AasEmPOACTAe7BvIh2dUyAFBLvp7dM+xvjIvov/6sDgD20+k2ch
         tOstYo9NNfRb7ZnzY9RF7q178Mfiex57KCXh6MTHKvf0RBal0EhzZOgFOG44vCgfgJ9Y
         P/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUrYx7kpDgdZN97hUvbm5A21VdmjRSYT6dRlq7E5Z14=;
        b=XSd1vWxbTWEPPGwcgg0VKasFGUSjuShqJLnRcyf3bO5ucs/UEXewDNTLiyjn6whAhE
         F8z1KVDdkLyT3lcq5do1Yy/EnEGXMhbwCVZEsX+70JOBwx3vBAR1PAozyzaE8u1wgBp4
         s8HoaOHNHklOPntqmkzP9rVtQDNV12qMozr6y7T8QUd7kSUYEddthORVwTXPkZfBQWkp
         VvruZVWqCc7EWlTUGN+c3JekUCkwNmWq6ut/1NAsBAaLixxeIvs3yJgUfDB0zLsfYbNV
         V6DXCwqUlTd7lRgz+38vMLccDoITpUVfgj4YwHa5+vLVfxfJ9VAxn1hXzFAaoGU+kw5P
         PXHA==
X-Gm-Message-State: AHQUAuZjRJYOpNXki4DmIyX2lLYGZti0kKCzPTgSYbSwXCKWDpe4T6jD
        DB/+vueUEmZL7ESc45OJbEu86yz6C28=
X-Google-Smtp-Source: AHgI3IbwCczj1I4GYjOQljnAIIBvsikxy7tVTOpIcAMQ19DvCt0JmCUSAfYsvau2DTeJzDWchv/LZQ==
X-Received: by 2002:a37:59c4:: with SMTP id n187mr7713173qkb.156.1550948600437;
        Sat, 23 Feb 2019 11:03:20 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id j9sm1028064qtb.30.2019.02.23.11.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 11:03:19 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>
Subject: [GSoC][PATCH 0/3] clone: convert explicit dir traversal to dir-iterator
Date:   Sat, 23 Feb 2019 16:03:06 -0300
Message-Id: <20190223190309.6728-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add pedantic option to dir_iterator_begin at dir-iterator.c and convert
explicit recursive directory traversal at copy_or_link_directory
(builtin/clone.c) to the dir-iterator API.

This is my microproject for GSoC 2019. Idea taken from
https://git.github.io/SoC-2019-Microprojects/#use-dir-iterator-to-avoid-explicit-recursive-directory-traversal

Build: https://travis-ci.org/MatheusBernardino/git/builds/497512561

Matheus Tavares (3):
  dir-iterator: add pedantic option to dir_iterator_begin
  clone: extract function from copy_or_link_directory
  clone: use dir-iterator to avoid explicit dir traversal

 builtin/clone.c      | 72 ++++++++++++++++++++++++++++----------------
 dir-iterator.c       | 23 ++++++++++++--
 dir-iterator.h       | 16 ++++++++--
 refs/files-backend.c |  2 +-
 4 files changed, 81 insertions(+), 32 deletions(-)

-- 
2.20.1

