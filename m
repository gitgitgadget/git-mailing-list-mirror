Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44BEC20248
	for <e@80x24.org>; Sun, 14 Apr 2019 04:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbfDNEhK (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 00:37:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36354 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfDNEhK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 00:37:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so7033879pgc.3
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 21:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eXze/Tys9MalNfasXRvdaEArHC2LVyqrh9zaP4/bWLs=;
        b=Xar8NPtVsXnedstRQ9Vsxkpx1JWKKxsNBVyX3REHGmRFFN5zJ6Z56114OsCwr24YzG
         RpAmykBDgVOJpPKxh/7STYkT1OkY/UzzSICXmDwEgYtKa+klr+AL6ooWjY9JHRJus45t
         dkKUKI1ng6P+TkeMvW/Kt5kRyQ7MJEUooOvc8hCAjXuyxO89mA/vXXK+CjG0LHL4c2tx
         V974vXa0LNSV87mehQdz7hjYUNaeX0qKcZVRs/DCjPb1awHWEZQ0XZzs+a3/O6+EpucY
         cY2FydDmt29zPFNWvlzok5jX5PUtTsC+BlN6djI8jLwcTyZVMKeEpmsngSDzr5wHRoFv
         m/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eXze/Tys9MalNfasXRvdaEArHC2LVyqrh9zaP4/bWLs=;
        b=C1IjT7IEVa2hhd9UZpdGl9sZijlMMyFoGi+/cPc2aOqTH+T/gLBc8CAmhnNTQu0nGm
         Ah9qWn2VHHpG+6MzOql7xXf18aEGVz2f81YaAWX1g0+RwWxLLLRrCJVJHOlGoZY8hRSo
         KdCmBoIP424sxQAPJX2+1JfeejmpOaCia2SnvnXD1fiTt0B1ELa8denbGoYJJ/CA3/UK
         ZYiBjA69Ilo+4TqcFsQSll+IWGq5Ez/Yle0bcKPT1hMidsQAn46wGJRXFzUmHbJe+Y7t
         2dTcWLl4hkzA1cH+AMfARTapdQucwSwI5xzeCOAgQAYUdNGWHudiSC9xb55OphCaxnxv
         LeOQ==
X-Gm-Message-State: APjAAAUm3C5DV8a6FDG+XRNz0ArcrTKxmpCg9JfbqekSBjT4rmwuQiGw
        zn5KngYW4vxpwgn8mGpnzeY=
X-Google-Smtp-Source: APXvYqxczEMgH6OzKV/LyCERSxLY6OQGc/AAiQfukjTgwcXeSCHxd9VEdVuNRaguaMra6anwYHCUdg==
X-Received: by 2002:a62:41dc:: with SMTP id g89mr67711314pfd.109.1555216629619;
        Sat, 13 Apr 2019 21:37:09 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id b7sm131336825pfj.67.2019.04.13.21.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 21:37:08 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        johannes.schindelin@gmx.de, peff@peff.net,
        rohit.ashiwal265@gmail.com
Subject: Re: [PATCH 1/2] archive: replace write_or_die() calls with write_block_or_die()
Date:   Sun, 14 Apr 2019 10:06:02 +0530
Message-Id: <20190414043602.9729-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <xmqqzhouwizg.fsf@gitster-ct.c.googlers.com>
References: <xmqqzhouwizg.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey jch!

I'll change the signature of the function in next revision.

Thanks
Rohit

