Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 646B51F404
	for <e@80x24.org>; Fri, 10 Aug 2018 19:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeHJV5D (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 17:57:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36921 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbeHJV5D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 17:57:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so2943706wmc.2
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 12:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jKl3bATlSawPo+1tN9Qqw/YD9sDX3iFIT3UTdKr1tuo=;
        b=UcwMBydPHJlcVnIT0XwfFMk0BDJp+PrMvzxESCaqfrhiLvykE+bhlRF4706ennRRcd
         o2Zxyw7oXLBY0g+Tro0zPVpSz4zHYr6n3NZklTfYnnTIvns6KvLx+lSb5QUDLoyg6IXx
         CyNONAMG+rR59JEtjpAyNEToJWXlw+a49VwsHrQnMC22e7JPpoROaLia/fKHqL8fcLv/
         SYpsT3pE9mXwywmSIHXwndxP6aU/HDkSwc5r7EDXVz/6Rx7dxvbLkUomlgCCkuLJRDbJ
         wadIymnIxjXQL9Gky9sFmx7qPyYSvePMRbhp2nnjzYrkygJOL2LkMvBpToQeo5z7CxI8
         7mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jKl3bATlSawPo+1tN9Qqw/YD9sDX3iFIT3UTdKr1tuo=;
        b=gXqxJ2wPazBITIGi97/QDOzRnCXbRfe5OAPq6F/aMVhHLY94IkY2BHZy7Ru5MwPOqH
         tkp6Xv+EkfekFY78BLF0zGVulv+4odNR0InIPI03TezwYKIkiSTkHrBaqe2moZeDcehn
         0GHj9hIXNKx11s4sgiHf0bZxOzqp1HmxOC9LF1+YdOGsCuNnU0lxX3a8XGzCYEq/RvIP
         LKRgLNYdn/zrJWlGUHVX2KbGZ5wU5YNzyr7R3phidctk/yoLsX6l3GSZnXXHiqysHyVF
         wxkjlyAGMRtAFLe9F7H3+vYLkOoq4UNjc7cyeYWKDrpnyLBAmW/Q3XWg/uE6RhK1uEmt
         uRgg==
X-Gm-Message-State: AOUpUlGhFVJ1WSxxu4agwcFh/9QZPSdEVt6XK0Pb3Omueg4dnmbrNSDk
        YIRSxuhPUDzkoG7JJgM/VEc=
X-Google-Smtp-Source: AA+uWPwyQ8cCiqzyxcMrl+ETnjAYl8Lkpjo5G75bVtdjZHwQErIRqjpHJMUOKchncN5xgLd2smoUXQ==
X-Received: by 2002:a1c:1c54:: with SMTP id c81-v6mr2203594wmc.147.1533929149281;
        Fri, 10 Aug 2018 12:25:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b13-v6sm13733165wrn.17.2018.08.10.12.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 12:25:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v6 11/20] rebase -i: rewrite complete_action() in C
References: <20180731180003.5421-1-alban.gruin@gmail.com>
        <20180810165147.4779-1-alban.gruin@gmail.com>
        <20180810165147.4779-12-alban.gruin@gmail.com>
Date:   Fri, 10 Aug 2018 12:25:47 -0700
In-Reply-To: <20180810165147.4779-12-alban.gruin@gmail.com> (Alban Gruin's
        message of "Fri, 10 Aug 2018 18:51:38 +0200")
Message-ID: <xmqq4lg281ms.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This rewrites complete_action() from shell to C.
>
> A new mode is added to rebase--helper (`--complete-action`), as well as
> a new flag (`--autosquash`).
>
> Finally, complete_action() is stripped from git-rebase--interactive.sh.
>
> The original complete_action() would return the code 2 when the todo
> list contained no actions.  This was a special case for rebase -i and
> -p; git-rebase.sh would then apply the autostash, delete the state
> directory, and die with the message "Nothing to do".  This cleanup is
> rewritten in C instead of returning 2.  As rebase -i no longer returns
> 2, the comment describing this behaviour in git-rebase.sh is updated to
> reflect this change.

Hmph.  It is easy enough to do the clean-up ourselves in this code,
instead of asking the caller to do so.  On the other hand, stashing
of local changes is done by the caller, so it feels a bit strange
way to divide the labor between the two parts.

Other than that design choice, the patch itself looks reasonable and
a fairly faithful reimplementation of what the scripted one did.

