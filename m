Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3ED21F955
	for <e@80x24.org>; Fri, 29 Jul 2016 14:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbcG2Ovg (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 10:51:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36121 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbcG2Ovf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 10:51:35 -0400
Received: by mail-pf0-f193.google.com with SMTP id y134so5583789pfg.3
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 07:51:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=+gij5GBoy4i/DeWjYEetNDW295oFeLYY8G2ehzLiu6o=;
        b=pyVc3ttmz8XfXFkOz8TGBa0z3FCIx/gTGTNEt3KwURbmm+/KkvLNDO5Fif4VDNq4Lk
         Yg21ZpGvij6Kg7xTpf46tsE5ZNAQRDpXAvpy2KSmtNdC8x7MDItKTtLtSgq8GujQScfg
         qYE6Jij1NsFf+uycu0buFy8oOMGvB4egQE125Onl0KC/rSwrN1NrSIgCxFQK+Ko9pVyZ
         Nt1q6wbCBvLgz/SEKRUulzI/AWZ/bEI94gfEPGMxyiDmYjhH3Auvx5JIrfKw8fb2UDtp
         s4TGzc7usjPM9VRY77SZ3hLZ1MA/HcbxFpTTdwc1NL44HpbFyE6b/8rWnophV9hjWx58
         swzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+gij5GBoy4i/DeWjYEetNDW295oFeLYY8G2ehzLiu6o=;
        b=fj7E4nIfioVZg2vTXbgFFoQ98HpMphh1FOK3H8nnod2FRgZo+CbgOj4l9Cx2BO0Qq/
         Gu6avUu8ihZh64qBZu8/8QNGgqqWNX6RM4YNDfBzfp9fiLVeOdBLqx4PXvv+rJCkSTa3
         4CtBE7GuXE0rvINX9gjAV8BcLNN/4x7/mw23CZU7+ce/G1RxFlyItI/31U1P9OTY7pYC
         LUfDRO0WBmJkXoOcH0N0hIQ7GrEnffkk4ypzRynXNMZ+sWgvokBTnXiryoeNe01Le64t
         VJdQhTZvolsMnUBz4kIpq+m28HiT8Dc4WB1QL/CTWUgVE0mnX7mznlVkE/t4mtts0QW9
         UUbQ==
X-Gm-Message-State: AEkoouu4tYxKuL+tAj2gRMGsMde3Rw52NeVoi6fr7g2bjfHGW7ttJ4kgvHxKwJFxtOwDEw==
X-Received: by 10.98.69.201 with SMTP id n70mr70597430pfi.64.1469803894550;
        Fri, 29 Jul 2016 07:51:34 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id t7sm5627686paz.21.2016.07.29.07.51.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jul 2016 07:51:33 -0700 (PDT)
From:	Brian Henderson <henderson.bj@gmail.com>
To:	git@vger.kernel.org
Cc:	Brian Henderson <henderson.bj@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 0/3] diff-highlight: add support for git log --graph output.
Date:	Fri, 29 Jul 2016 07:51:27 -0700
Message-Id: <20160729145130.9514-1-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

(resending as thread instead of attachments)

Hi, I've been working with Jeff King on this patch, but he encouraged me to
email the list.

I recently learned about the diff-highlight tool, and find it very helpful,
however, I frequently use the --graph option to git log which breaks the tool.
This patch looks to fix this.

I wanted to try and add some tests as well, but I was unsure what number to
pick for the second digit. As there were limited tests in the contrib directory
(only t93xx and one t7900) I just chose the next number in the 9xxx range.
Please let me know if I need to change it.

I'm also not super happy about my test case for the graph option. If anyone has
any better ideas, please let me know!

Brian Henderson (3):
  diff-highlight: add some tests.
  diff-highlight: add failing test for handling --graph output.
  diff-highlight: add support for --graph output.

 contrib/diff-highlight/Makefile                  |   5 +
 contrib/diff-highlight/diff-highlight            |  13 +--
 contrib/diff-highlight/t/Makefile                |  19 ++++
 contrib/diff-highlight/t/t9400-diff-highlight.sh |  76 ++++++++++++++++
 contrib/diff-highlight/t/test-diff-highlight.sh  | 111 +++++++++++++++++++++++
 5 files changed, 218 insertions(+), 6 deletions(-)
 create mode 100644 contrib/diff-highlight/Makefile
 create mode 100644 contrib/diff-highlight/t/Makefile
 create mode 100644 contrib/diff-highlight/t/t9400-diff-highlight.sh
 create mode 100644 contrib/diff-highlight/t/test-diff-highlight.sh

-- 
2.9.0

