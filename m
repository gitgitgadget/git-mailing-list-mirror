Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E67E21F404
	for <e@80x24.org>; Thu, 26 Apr 2018 07:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753800AbeDZHvT (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 03:51:19 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36166 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753589AbeDZHvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 03:51:16 -0400
Received: by mail-wr0-f195.google.com with SMTP id u18-v6so28447718wrg.3
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 00:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RjUNbTIqJZ7vZFXU0J/nlNoPzSxeq8gjLM1m16WmeUg=;
        b=IlEvajnkDWi5SoR79Wfa1IVC46sK2xUyPsq+7p2QTIQ3zxzuNWcBzkbppNgfIWl9rj
         m4OC+zCaDWfupdmECVzrnwXk7NZLRjibRPmvZ8AdYf58rYPCF4MsvdlmF+sPmxcPDptM
         /9S7y++NNoC0emGWVz4gjwCupiEa6+X9fQ4O71kHE5dvDCYRdWKEgV3Sw4EdMPefhuRP
         uH8F0joTp6DtP6JQvMNG5ELsdDd6Xrs4SbsJWOE/ddfk2JhgueLMhdJSD6teK3gmZ8yD
         iI8I9WftrI8UrMlj5IkI+q60K8WYi3GOQbydD4r8xmWzbMdsKQMqurLom+93G/8D5JeA
         QOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RjUNbTIqJZ7vZFXU0J/nlNoPzSxeq8gjLM1m16WmeUg=;
        b=YDHiEIgS3V7GvkUqGK2zkkisMJVSwxFBbHxobi8LfCYFe0bRUxFQLMwIhCVNt33uvY
         9z8O1IX+W46PfF0sn28Erbi6ZO0M9EHqlFmttXwrT4kacSnmnbp7fHuXSN8EQKueGEu1
         rfge5XKUuq/pzFdFTAzIcKPH5gPW/NmBeTk20zs9W3I6z1Ymt5AcnjcynhTXOj8Tk3ux
         6RyZ2rnT5gZiYu/EhRLr5M5r82Ujg95Vl0qFUjweQgql5tQDLK0dzyRTcTBY2vN9uunn
         UGrl6efxQjWzd+pErtEwWIEx03zsD9FI5tslEs3g/bC5d8P1fI/1gvqghAzzqqN9gHNx
         7/bA==
X-Gm-Message-State: ALQs6tAw7M3vCmkVTS1X9Yvwru8VJmhU3gqy0KjdrGeROp984nVmeBLU
        kQg1XUvyFRVE56jNO3gNWPCwx9ny
X-Google-Smtp-Source: AIpwx48S+gp6tOcbIQKteKW1xm19liGOTXHHDlvGP+eagNQ/mOeva4nRzOPxvRhVVyb92OjuLJOq+Q==
X-Received: by 2002:adf:91a2:: with SMTP id 31-v6mr26866177wri.124.1524729075183;
        Thu, 26 Apr 2018 00:51:15 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w6-v6sm3424551wra.16.2018.04.26.00.51.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Apr 2018 00:51:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] .gitattributes: add a diff driver for Python
Date:   Thu, 26 Apr 2018 07:50:58 +0000
Message-Id: <20180426075058.9322-4-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180426075058.9322-1-avarab@gmail.com>
References: <20180426075058.9322-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Declare that the *.py files in our tree are Python for the purposes of
diffing, and as in 00ddc9d13c ("Fix build with core.autocrlf=true",
2017-05-09) set eol=lf on them, which makes sense like with the *.perl
files.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitattributes b/.gitattributes
index aa08dd219d..1bdc91e282 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -4,6 +4,7 @@
 *.perl eol=lf diff=perl
 *.pl eof=lf diff=perl
 *.pm eol=lf diff=perl
+*.py eol=lf diff=python
 /Documentation/git-*.txt eol=lf
 /command-list.txt eol=lf
 /GIT-VERSION-GEN eol=lf
-- 
2.17.0.290.gded63e768a

