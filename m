Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBA031F404
	for <e@80x24.org>; Fri, 30 Mar 2018 22:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeC3W0N (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 18:26:13 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:36499 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeC3W0M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 18:26:12 -0400
Received: by mail-wr0-f182.google.com with SMTP id y55so8984822wry.3
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 15:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A72sRX+B+EZ+QtLoIUivuQX6Ld/YVvJLbQCAGf7ZvZ8=;
        b=iaHWdqRuD18vv7+RMGhPDYPRjWT0dLhp4M1Qf7v2yyKGlvRGT7QIjjMvg9wA6HPgdn
         M4xWp8n54pBItZgXFixRAt7dbqJFWNgiRp8B+opYlYRiFriA/6u5AY10yrLLlOm4eYGs
         WloWoB8Gb9nWOo3r9ib0OShFqpLxdxEIqXqNBaeIXdNGjUSRGMh0sJCOPGJfSFTsLrRu
         heLzbsTBRWcRqokhxvEGKpAx6KC4OLB6bOmMOgzOOvm5RoGdFHwaWJUPEGidI5SbXurl
         LuWijWYALcYgTb35pz9+bm7bDeBW1awWilHlqnJilaVMxiiV5ugxqbTc+rA3VgP+XolX
         IMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A72sRX+B+EZ+QtLoIUivuQX6Ld/YVvJLbQCAGf7ZvZ8=;
        b=oEAxZN8xtqNgzsH1/KREPqY7ZlTed/19eo1WAyEUS/G8XCDJcyBcNDQlfO+pIuerEX
         UxxXTda9ACtGx5FxhgSunvnbHFhVzsdUc+e8OTMgDf0/LPPNciyfzznYHxwBBVzpw2ao
         xACy1VdC6yh4F3GhD1Zkl9m6iop4dJAbXqru/XDYiL5PTzQpXsMUX6tRqS290VozoZYd
         UlIdq5iXaa5wJAVymJXKOUTD6dspWL+8R6U30ifWqEx4VcRcUFfaKi4pNryClD/2g2v6
         8Z7Oes/McxEXF7SyN9peuTZIVmNVhA2O0oOQEsNjnWqw4L+JXZZQYJjCLentbdpVvHoU
         8vew==
X-Gm-Message-State: AElRT7HBSTFqrIyTTIzsryxxh2KR9FAgFCeQ+xQ18RjD4Rs38U1dbWVS
        9M28yjOHKHvGoEaBTfH6q/5UB0Xz
X-Google-Smtp-Source: AIpwx49bu1OtbzQEkI/SwJXSxRIwVOTVnJiJvVdSBkLXoHrjL1jbB7ULtFG921ivNkSfoH48jPLo1Q==
X-Received: by 10.223.179.18 with SMTP id j18mr413079wrd.33.1522448770738;
        Fri, 30 Mar 2018 15:26:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i52sm17917159wra.82.2018.03.30.15.26.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 15:26:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jameson Miller <jamill@microsoft.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] fast-import: fix a sparse 'NULL pointer' warning
References: <fdda3631-400c-1e6d-92b8-a68fc237a413@ramsayjones.plus.com>
Date:   Fri, 30 Mar 2018 15:26:09 -0700
In-Reply-To: <fdda3631-400c-1e6d-92b8-a68fc237a413@ramsayjones.plus.com>
        (Ramsay Jones's message of "Fri, 30 Mar 2018 23:22:05 +0100")
Message-ID: <xmqqin9d19q6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> This was going to be an email to Jameson, but I wasn't fast enough! :(
>
> This was originally written against the 'pu' branch, but since the
> 'jm/mem-pool' branch has graduated to 'next', I have rebased on 'next'.
>
> Perhaps this could be squashed into that branch when you re-build
> the 'next' branch at the beginning of the next cycle?

Thanks.  

Yes, that would be the most sensible thing to do, I would think, as
the topic itself (like many other branches that are merged to 'next'
during the pre-release feature freeze period) is not ready for the
'master' branch yet anyway.


