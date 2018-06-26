Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 539701F516
	for <e@80x24.org>; Tue, 26 Jun 2018 10:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933294AbeFZKFx (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 06:05:53 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34861 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932963AbeFZKFw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 06:05:52 -0400
Received: by mail-wr0-f172.google.com with SMTP id c13-v6so6657450wrq.2
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 03:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0CkCxL5Noker3Vs/XmdRMvLNrJCFm4a2grThOUT0zCo=;
        b=oeRKXq3eV9TzcYrjZdB222SHhO2wbqrvtHeC28KOa2xkLkIMF+S0b7wpGt1EDZI1Zz
         OaGGPDzybyGLd+MR1lMnRj2p3X1kU5obQZmP4bDYYB+S0CCEKKRRZFBwjgbaXQlA+hv8
         Pzz2jXxq6mSP7kuZWC8KEkDJDjS5/luQZH6jHrBHiSVbPyy+wNgYoQWAEdnZ/N8VPrmZ
         ql1ChQQNKKkiKTC4UttCpmgSSfu5iebKZ5fRwL6rHnthHZ5jbKQorUDYcvkesjaY7OKr
         ZvthBYjES/Nu3PD00pscd/mMMMvwEYe52oRzPwR3E1z9PubzDeCV4Nm0IqvuHtQllKz6
         NQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0CkCxL5Noker3Vs/XmdRMvLNrJCFm4a2grThOUT0zCo=;
        b=j4fuyReNM2PnYt79cXmtlRMLM7Q/+PR94qaTXbobp68ZjoJGdZviyNfW/ju500cYh0
         netT0nRIT1nwPGoy/mSRl+Z3Tpo0SDDHlG0H5NjZgtvn7nfUh0McBQwHLrh2YeGRxlXm
         V/Ur2stj6CQ9u6xZmzpIjIi/5dSDO5wy4IDErOikpCXoLYXZvtjQpGhKe5SNZISsehJI
         JmF5VoiZfEiAwaMx7Th+j56pAJpjpwfKcyCaPYGzvWhyqLBX2NIYcixnQJtWwNoSnrUK
         KHb600x47ftJANrj9gb/e8h5ELx0zGJ9e4meE+8/+bdwz+vDhYzRXZm2Q/F5iKT0iV7G
         MQeQ==
X-Gm-Message-State: APt69E1i1RhJIi6y7WogQ9R8cfdw3WoHO4rSoR2vDE9oo0vpP8dKj8WW
        mYcZnonvsPkylj4GAUS1mlcUyiYG
X-Google-Smtp-Source: AAOMgpdFUUBbraWnSGA5V+hqEXYEDVUDS7jCl1jqCKzs91mziva0l0d2TKGfh0USsBYPfuUTJmZHxA==
X-Received: by 2002:adf:e790:: with SMTP id n16-v6mr902587wrm.136.1530007550971;
        Tue, 26 Jun 2018 03:05:50 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.googlemail.com with ESMTPSA id y8-v6sm1855050wrq.35.2018.06.26.03.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:05:49 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH 0/1] sequencer: print an error message if append_todo_help() fails
Date:   Tue, 26 Jun 2018 12:04:28 +0200
Message-Id: <20180626100429.10169-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, append_todo_help() does not warn the user if an error occurs
when trying to write to the todo file.  This patch addresses this
problem.

This patch is based on ag/rebase-i-append-todo-help.

Alban Gruin (1):
  sequencer: print an error message if append_todo_help() fails

 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.18.0

