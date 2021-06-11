Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A62FC48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 19:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49AF261364
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 19:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhFKT2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 15:28:34 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:36471 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhFKT2e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 15:28:34 -0400
Received: by mail-ed1-f51.google.com with SMTP id w21so38272506edv.3
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 12:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=PQ4fLa0CPaGkF8EEW8TbJ4lbXkM6taGft1tn5xR/W1A=;
        b=DmHDnNI0Ta7P5l79WOoEqstY2prkAqUbMUo8rlq0nkLxtC/FoTHxkj0h43pQ/EqDhp
         c8KwkHRFJqeo2hJm4jspG/ASqnXy5Bjgn86ukq1WsTWc+vAhxi8OHElXYCjTm3qyy3KB
         413M8b1pJOsGzdXKECuH/5pN/OUUSexZsGHY/jWXbNcwOd4DZzmxvyxNW8yuoVAquFiA
         +ZCbeofBmGVWg29mOJVF6bAOaqwloq5iLOzB6T7xHWTPG1ftIaooHZWZBebvHo1rTFMT
         UTkUxuhms/J7PkPlf8K17xGCw+pZyTy+oqPSj6rdVrRpH8NkUsqu5p6YJmQq5Qcp4wXW
         9Ctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=PQ4fLa0CPaGkF8EEW8TbJ4lbXkM6taGft1tn5xR/W1A=;
        b=bXn9JNwstf6upMJ5nBIpWkUaep9eFD/5WcK7pERyMjrTD9wJcBphxTO2+XmiACbbe0
         jQPjivbos2ZgQHaJYXBBlFJGKh7/cE20ETStnFd3lSMf8ND5kvLzhr5NAcgb1wasXlji
         XIvn9h4Kssu9HCcbfqq3w5KQ+wLhARKZkpVBOfG+dJyASa9x8IzAeAIH8pSAEUk636YI
         mEVWakqeoUsbneSu7gu5DJHRoEQWN8mDerBQ1g88bK/5lGxR9ejyY70l8/3wi7Qe36js
         VIKqkgyRVUgMexzPcP3Bt7pMkinEHpMg+chAxvzd+nRUbTZsTyaiKigNJyoWN53JVxdt
         HdQQ==
X-Gm-Message-State: AOAM530JI04y4d48lmbssXwAbz5g0H1UDfnNb3UW1rjd1LdP68TTcOEg
        25cZrH0caskuzeKeCqnjChGYPuW4ufZSvpc=
X-Google-Smtp-Source: ABdhPJxmdPxfCP9k5SL/hzwZFgTAnTg9zTars29l80v0CVZKX74dLJeevelB5/mBLJfmTMcKoZUCVA==
X-Received: by 2002:aa7:cb8b:: with SMTP id r11mr5227393edt.233.1623439526575;
        Fri, 11 Jun 2021 12:25:26 -0700 (PDT)
Received: from ?IPv6:2a04:2419:8503:3080:e190:2f64:3160:22af? ([2a04:2419:8503:3080:e190:2f64:3160:22af])
        by smtp.gmail.com with ESMTPSA id a2sm2396087ejp.1.2021.06.11.12.25.25
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 12:25:26 -0700 (PDT)
From:   Timothy Madden <terminatorul@gmail.com>
Subject: Wrong tabs in terminal output for git diff
To:     git@vger.kernel.org
Message-ID: <8d3f8cf4-24ec-1271-ccd3-70db24f53523@gmail.com>
Date:   Fri, 11 Jun 2021 22:25:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ro
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

For git diff and git show commands, terminal output appears with wrong 
tab stops (missaligned).

Because diff operation inserts a new column at character position 1, for 
the +, - and space characters, the diff content appears shifted to the 
right by 1 column. But not the tab stop positions. So relative to the 
text, the tab stops now appear off-by-one (shifted to the left).

This results in text that appearing missaligned, even though the 
original file looks fine before the diff.

I believe this is not a new issue, since git gui does the right thing 
and the tab stops are aligned properly in the GUI.

Is it possible please to fix diff output as well, when used in the 
terminal (interactive mode) ?

(I can include screenshots but I am not sure what the mailing list 
policy is about that)

--
Thank you,
Timothy Madden

