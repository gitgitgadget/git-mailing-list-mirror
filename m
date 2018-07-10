Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A91E1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbeGJSaS (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:30:18 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34180 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387994AbeGJSaS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:30:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id s13-v6so13307439wmc.1
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2dvZjSRFJwSNexmw4dcg7nfIWyrhYJ+7RUMsdHqt9qA=;
        b=KnV+wG0r/2fW6fYCnjE4mYkk+StBKINRi1068hsQJjCdgqdRrS7S8MRAuv0pM28ZNd
         dYIHz/+/9fMsJabk1DalHdpquhIKQ8SOuNNVr/GBLXL2LbFGsjlIojoaHQrpWQX3XfxT
         avRyJAs/VRr8af9ttHy1HdedXXpATi7O5n9cCZxxwheG/He/OTUFpALD7u7KX4IF2oXg
         jPl+sBYRuqiBLUEpgEfeRmykpmA5ut5iSxAGEuNTULadRxi9LDsZEi9t7npo6r7Pu1L1
         YScCYzHNFTNo7iu2aKETmal4XLIsPzeThk7VVhuZZ+osg7S6wtBB4AJkPNT0tMeDyr9Z
         6TqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2dvZjSRFJwSNexmw4dcg7nfIWyrhYJ+7RUMsdHqt9qA=;
        b=pR1lkwach3+TXENGD/QkC3+iLB8hBbc8NlcaGV9IYoMXjHHuqvs6ZEH9kkMau/Ikps
         oVOEhMWvtlUH+zmYsL/MfuLH08on9b4V9RkWuvARWKTnU7l82CBAWH2WZWragCFHGn25
         QTzzG7ROfI8lDeKFff4PEtQHT+7rbxzMhHuBrqp/dWJJZE9ImyYmmJ5jX9iglbIynVhQ
         udYxUixscmpTpdlA9r6LCgxA2/i7hici6eBj3qna8WnUD8pEvuL6TdgdLznxBSGYPrfJ
         opaADslBdnukIWUb3w70NO/GfFgwal+8yPnuLu39Zna/nCS4p9PbIW4LcRg5EQ25Oc6F
         lGEA==
X-Gm-Message-State: APt69E2Rv7JER64mqCCYdsh57wdWvVu1Fsw0K+rvrcpkaxdIYTu8UNIA
        s5ZN7j/MesiVbERKSYD2iuw=
X-Google-Smtp-Source: AAOMgpepK7Prm7CrMxjIhHwX+gS7tRkADuB1po9bwOFCc4HemM3wnqKw1BLI5N/jwG8bLeJdaNiH5A==
X-Received: by 2002:a1c:2482:: with SMTP id k124-v6mr14238734wmk.87.1531247405851;
        Tue, 10 Jul 2018 11:30:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m144-v6sm20362070wma.36.2018.07.10.11.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 11:30:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v3 08/13] sequencer: refactor append_todo_help() to write its message to a buffer
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180710121557.6698-1-alban.gruin@gmail.com>
        <20180710121557.6698-9-alban.gruin@gmail.com>
Date:   Tue, 10 Jul 2018 11:30:04 -0700
In-Reply-To: <20180710121557.6698-9-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 10 Jul 2018 14:15:52 +0200")
Message-ID: <xmqqd0vv6j0z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> diff --git a/rebase-interactive.h b/rebase-interactive.h
> index 155219e74..c0ba83be3 100644
> --- a/rebase-interactive.h
> +++ b/rebase-interactive.h
> @@ -1,7 +1,12 @@
>  #ifndef REBASE_INTERACTIVE_H
>  #define REBASE_INTERACTIVE_H
>  
> -int append_todo_help(unsigned edit_todo, unsigned keep_empty);
> +#include <cache.h>
> +#include <strbuf.h>

Even though arguments can be made that using angle-bracket to refer
to our own headers like the above is more kosher, such a clean-up is
not part of the GSoC topic, so let's refrain from doing a little
crusade like this and imitate the way the other existing files
include things.

Actually, unless there is a definition of the structure that you
require in your header file to define your own structure, we are
better off not including another header from your own header.

Whoever includes "rebase-interactive.h", if it needs to know what
strbuf looks like in order to call append_todo_help(), should
include "strbuf.h" itself.  Those who only need to call
append_todo_help_to_file or edit_todo_list hence do not need to know
about strbuf, if such a caller existed, should not be forced to
include "strbuf.h".

> +
> +void append_todo_help(unsigned edit_todo, unsigned keep_empty,
> +		      struct strbuf *buf);
> +int append_todo_help_to_file(unsigned edit_todo, unsigned keep_empty);
>  int edit_todo_list(unsigned flags);
>  
>  #endif
