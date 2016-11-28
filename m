Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 103961FC96
	for <e@80x24.org>; Mon, 28 Nov 2016 09:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932487AbcK1Jd7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 04:33:59 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36284 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932474AbcK1Jd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 04:33:57 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so17843209wma.3
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 01:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1OZVaqCGUmeG8RsYJZMDPHU/OplGz+XpilgOL0ps2XE=;
        b=J6XHZOSsn4ZnwI3FNeKdXOPF1s28RSBtT/SKcXz8VWY282EHbb9IiXRulJ+lcdF+/L
         kneJ238qxcwo/K1A6E3JJLuxQzP5xPYrs0etz3wmncX59avMgBGyehg81lpKMIwW/fm1
         thBldKbByybAvJTw/o0+B4yvZvAsQl5DigtJMVXFufYCHVYbycj1F9pw02GDmEOUuI95
         lAYAc/2ZnsytTA2/ZcTA0p6zRiQiOx4esxLTVwSiQoi/iXHUG4UAMnC6DvkPyjceuRj6
         eDmqi8GPMlUte3hoZLwI+3JZji+8noORUt1/fLYZP/dWMVkRrKgYdZyf6eytG+nex/9K
         BcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1OZVaqCGUmeG8RsYJZMDPHU/OplGz+XpilgOL0ps2XE=;
        b=WvUnwVXrD0mYqMbXsyOLbRbX81Ocbu49r9QR3RpKdrV7219dmTEpQNy1dFCYL0KxM7
         QBgGjU/J28WTioKLQBSfqnDquNRLHEMsTF6OXsAzOS00g6tqBl9nnXDTGA04S1xfY3cu
         eAauI6TAJ4Vogn+9l6qN0OveKxZxBKxq20V1rZJX3YFwYllV/eiLtMh5vWepffsqZYtq
         EBrXJPgpIgcATrdJJOSadSSN6QVqnfYfmlLBsinVDUWSkGIXB4tbN1RpuT2aI2p9B/1q
         QhEjbu8sTmCf/DWHaNULmCNF2+JtDDLIFnGd6BtQsys9RXN2BDyi/JiAdAebtP8ZMtC1
         L0SA==
X-Gm-Message-State: AKaTC023bN14RCDEhUBbwU9U8JSPpw0mv+zZt3pGAVAHwTiNHNGBXJB1GGYqSnAzg8Skfw==
X-Received: by 10.28.41.70 with SMTP id p67mr17967337wmp.4.1480325630952;
        Mon, 28 Nov 2016 01:33:50 -0800 (PST)
Received: from kursancew-t5810.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id d64sm27875797wmh.3.2016.11.28.01.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 01:33:49 -0800 (PST)
From:   Vinicius Kursancew <viniciusalexandre@gmail.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Vinicius Kursancew <viniciusalexandre@gmail.com>
Subject: [PATCH] allow git-p4 to create shelved changelists
Date:   Mon, 28 Nov 2016 09:33:17 +0000
Message-Id: <1480325598-12344-1-git-send-email-viniciusalexandre@gmail.com>
X-Mailer: git-send-email 2.6.0-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch adds a "--shelve" option to the submit subcommand, it will
save the changes to a perforce shelve instead of commiting them.

Vinicius Kursancew (1):
  git-p4: allow submit to create shelved changelists.

 Documentation/git-p4.txt |  5 +++++
 git-p4.py                | 36 ++++++++++++++++++++++--------------
 t/t9807-git-p4-submit.sh | 31 +++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 14 deletions(-)

-- 
2.6.0-rc1

