Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,PLING_QUERY,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3408420969
	for <e@80x24.org>; Fri, 31 Mar 2017 16:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933211AbdCaQFZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 12:05:25 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:33843 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933182AbdCaQFY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 12:05:24 -0400
Received: by mail-wr0-f181.google.com with SMTP id l43so112044162wre.1
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 09:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=zpKEiXzccS1Q4DyhKdg5LMJguPCLeRGm2lwNL9qgZUM=;
        b=NZoewxF8HMniZL9qqHq1URQ74UxATtGUnKb8OlLX/xlqqDKa87iTcXbjtxXA2Rv9kx
         Z9sbscGPxluhqXQC+b7gB45IW3cuTmWCC1tQIh0bbxHzstokGIC7O+C3ywo+F8XgGXV0
         b2NH9/JKIj357RJlzSL+cj4QW6DLuKf+oNTAy0A8LgRS7MMDStxIASmTD9kavoqBVE87
         nZQ7LF1IvVhbK11ALUmf5XRVCQN5XjlJtN6u9TbhbZQvt68j7Qm+S5lipwAp0UZYU+sG
         L+xaGm26ORndC6bU42ZqHiUv1LodlUMB+9MMl/9aZnNQFk5mk+WSbz0yktn3mj1+tLUS
         NPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=zpKEiXzccS1Q4DyhKdg5LMJguPCLeRGm2lwNL9qgZUM=;
        b=lunfmcToy9KKryk4A1C+ew28/3YjTy3kqkGno9BE39jseMdkBOfIQNKspx7a7Cd04a
         EO0vAJctrsUt2dnhiWk+pulqrKEdLmgq/TdIG+y7S+zgoaJwHKSHeep1/N88FBVom2O+
         Kua/Ht4eyOlbqBYr/X09cXrLQWfaC/LCdPyujHzvsdPZl+0nppyVSZX5TWaer96lqmeS
         QeRjFV7nJSAgLvrjb8XTJ6H4pMuOEqcH+8tU30ZRaf2mIoBNtPSM3LU3PbVnkrp5lkFj
         Z/o9MtrSI6GxnB2BrK84983JspHpDX6WKTlY/KUGRzGMWJM+CvKwI2IBWAgVevcSlbwO
         vWhw==
X-Gm-Message-State: AFeK/H2Fxqajz5i3Z2gxLSvp4+tzycU+GmElZwiNhu/u73dYK6gdKlQv/ZXM4cFNP0gqKg==
X-Received: by 10.223.136.214 with SMTP id g22mr3526229wrg.37.1490976321746;
        Fri, 31 Mar 2017 09:05:21 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r11sm6138832wrb.16.2017.03.31.09.05.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 09:05:20 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: SHA1 collision in production repo?! (probably not)
Date:   Fri, 31 Mar 2017 18:05:17 +0200
Message-Id: <4D74C1D4-9EA7-4A17-AFC5-0B54B4A6DD0E@gmail.com>
Cc:     Jeff King <peff@peff.net>
To:     Git List <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just got a report with the following output after a "git fetch" operation
using Git 2.11.0.windows.3 [1]:

remote: Counting objects: 5922, done.
remote: Compressing objects: 100% (14/14), done.
error: inflate: data stream error (unknown compression method)
error: unable to unpack 6acd8f279a8b20311665f41134579b7380970446 header
fatal: SHA1 COLLISION FOUND WITH 6acd8f279a8b20311665f41134579b7380970446 !
fatal: index-pack failed

I would be really surprised if we discovered a SHA1 collision in a production
repo. My guess is that this is somehow triggered by a network issue (see data
stream error). Any tips how to debug this?

Thanks,
Lars

[1] Git for Windows build based on Git v2.11.0
