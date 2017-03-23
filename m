Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127A820958
	for <e@80x24.org>; Thu, 23 Mar 2017 17:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932209AbdCWRRr (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 13:17:47 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37327 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755601AbdCWRRq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 13:17:46 -0400
Received: by mail-wm0-f53.google.com with SMTP id n11so1963061wma.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 10:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=+NOA/gwTdPtIIc992tav6IKvhDfza/28P4yrtxAWo50=;
        b=QsKoFF6XdknDv/gM5i80rLM7nFRChW2MkaH6tUkJdBZm9mn93NMFYsfsdmwXoIQtZG
         zaXCyYDG/l8hZiRT9wRm21L/P0DUA9WdVqkSjt6F2dZKZDKcj8ZSbFZv/4lynjfuK9RX
         N9CC5awQO6yRs5hy4xc6G8GtqEbV5oQDXUa9kshpKfrJ4l7xwf/+BZZbk2nErkImrcXp
         WeCMPAGKkeeKARqSFfwolU7RuCF+7ZxQDXvyq06LoWl/bGC+2TfW8pnjddyjQX8ZJwuy
         WNN3yx0SzeQIoAUox/b7viJWm5M8sIaXSBwtNLIcStI/YJvovF/LkH84zyMxftp9qjhx
         xOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=+NOA/gwTdPtIIc992tav6IKvhDfza/28P4yrtxAWo50=;
        b=lZQ4Bhkq4f9UMKEebJE8uPtPntefXUJZHL51eVCMIRZCZSC2j1BrJ/XqgwDxKpSqeI
         rLUcpa1fj5qwWSOxjYoT9kfg2CCvXB1c3koFqb1s7aDJZR11tRcxGq/12XssVBRbihZP
         b6efNXW8ON1rrwcF7HCRnLrnORdRWZ/jtv+Kgz7P/LsqQZsljnlmG27fI/QEbgT0byJr
         w1FaVjzIThkpbo/bCARj25+mQOuy6dJGiPpZp5Blmz9HYuX4wjOr9JrzV6MBE2GT9Slu
         5tRJjCQOLVu6vb7zqQrSl8BIOLkxMW8j7GqQtyYTrX/4nCdWPCIw3V5Y52vJaanXQbVq
         i9pA==
X-Gm-Message-State: AFeK/H2CEeJ9oXXBxJyseOKkOYY7y/taF9YJwN+nUaGOfswR8ga+GiViLs0RdxLaaLruMA==
X-Received: by 10.28.131.77 with SMTP id f74mr13785870wmd.109.1490289464736;
        Thu, 23 Mar 2017 10:17:44 -0700 (PDT)
Received: from [192.168.1.66] (85-220-82-70.dsl.dynamic.simnet.is. [85.220.82.70])
        by smtp.googlemail.com with ESMTPSA id 92sm6632639wrh.8.2017.03.23.10.17.43
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 10:17:44 -0700 (PDT)
To:     git@vger.kernel.org
From:   Ulrik Sverdrup <ulrik.sverdrup@gmail.com>
Subject: Bug: Revert with -m 0 says no -m was given
Message-ID: <12e6fae3-a341-3dcd-0920-c3df2d54d0a8@gmail.com>
Date:   Thu, 23 Mar 2017 18:17:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Git produces a misleading error when you tell it `git revert -m 0`. The
user error is that the parent should be greater than zero, but git
doesn't help you. (I forgot that the first parent is 1 and not 0.)

$ git revert -m 0 abc
error: commit abc... is a merge but no -m option was given.
fatal: revert failed

Git already handles too large m correctly:

$ git revert -m 3 abc
error: commit abc... does not have parent 3
fatal: revert failed

-Ulrik
