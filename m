Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FC911F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbeGJSc2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:32:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37924 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732845AbeGJSc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:32:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id m1-v6so2910116wrg.5
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uz3KELOhA5tZitLiEY86v3ozK8B8HsUUyGGd8Jwf3YQ=;
        b=f8DhQ5A9Bou9LabCk806S+KOOtvk/QNxVEvtK8c20ltdnSCB6b8gSwl5D49C1BYG4i
         ks3FJ+7GyMV/hChDFijzJDr0KZBTf5/Eyd7sa+PHBwwTP07Ueffjhry3TQbgfdhRfap7
         aaa1rwJqNbQkAMj2bznWj8uHF6WGQvR/pLZGMnCHI0XfvVolNeES1MRcQMgmXWF16KE0
         oCH2NPiBFbgBadLOTUj9mT7NalRwzu4PhW1sKg9KxB6AUm4Mwz/zZAzLWwz06mGGLDY/
         PkEKBPApLP7FffmHxj8zwMfGhHJR1uz9dOsioPM3iA/fy/gMkzSvOLVPIds8tLLyomFk
         GNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uz3KELOhA5tZitLiEY86v3ozK8B8HsUUyGGd8Jwf3YQ=;
        b=KuS3UrWFHO0fakvZyT/A4HYtpyRrlK/MDHYr2kiSkaLtcVR8j3yNbFxynCwvNzW883
         XB3LhRY3a/oXeJn5jhMD+zeL2aPjEPNQyUG2H/Qh+NhMmjnor4v9j4sIB1Xl4tZMOcAr
         QU33y0wHt30O6hlQxlTlHD/gYqITUm71IYBqozPl3uvQ85gJPrG71nESVOw/87GATVpp
         fk8vffpSWIGgOGFNfLvSkKy5KUCS8lra9evtm1zVuOSMfz2DV9OPR64wmsnXLVhBQlIM
         CrNri/L/nf0dcwxfM9BWh+GFBYe9+a89DrOR5hKn/8ZcG4CWJSOc88GNK76BGKPVTsGU
         RSag==
X-Gm-Message-State: APt69E1XKM8Rh2fW7Icqc2te7HgkUoxI5LzaWsWbIpB2yYZxWEujlhCH
        OKM8eSPUlkZJFUDjqi+FuPrw4QqP
X-Google-Smtp-Source: AAOMgpeHsDEi4fqayLcgPcWOUMgmOHESAY80mN4/Bo2/4lA1gVOpJhQoqpigkNuBMu4WRUxgDjTWyA==
X-Received: by 2002:adf:fe42:: with SMTP id m2-v6mr13485332wrs.171.1531245646877;
        Tue, 10 Jul 2018 11:00:46 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r7-v6sm16287131wrn.83.2018.07.10.11.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 11:00:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v3 04/13] rebase-interactive: rewrite the edit-todo functionality in C
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180710121557.6698-1-alban.gruin@gmail.com>
        <20180710121557.6698-5-alban.gruin@gmail.com>
Date:   Tue, 10 Jul 2018 11:00:45 -0700
In-Reply-To: <20180710121557.6698-5-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 10 Jul 2018 14:15:48 +0200")
Message-ID: <xmqqtvp76kdu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This rewrites the edit-todo functionality from shell to C.
>
> To achieve that, a new command mode, `edit-todo`, is added, and the
> `write-edit-todo` flag is removed, as the shell script does not need to
> write the edit todo help message to the todo list anymore.
>
> The shell version is then stripped in favour of a call to the helper.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
> Unchanged from v2.

A quite straight-forward rewrite.  Looks sensible.
