Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D16E2022F
	for <e@80x24.org>; Fri, 24 Feb 2017 17:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbdBXRxG (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 12:53:06 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36380 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751246AbdBXRxE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 12:53:04 -0500
Received: by mail-pg0-f66.google.com with SMTP id z128so3791894pgb.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 09:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2Lm2XEhj554nhLanYfHnNl+075jWs6q2zbzsQt5MUhE=;
        b=bzwxng7jPO2NNkDuYXAm2jj6cb85uXcA8mDUNZb4F7w5sYpmZIWgH0YD2NS21NWeWI
         fQituPlS6jGmUIsGhCki6j2cIP0N/ROchqVkIh2I+SpeG38xl0YjymU6uJNrbw4EMXAR
         yFSqya6ucR3mgjMRHbTUMOPrSU/AsxPRhugCdGQJea+JMS/Uqq8QXPj2ZkbDFZ1/aUu5
         8pOHJEA4E9Jcsfohdmrz1nYlcjTfpYHjXD2JSS+AkCLRQ+YUpq/07Ri1ARV/1gGFq+pP
         VzqCRFMeF6zwYBJCOzqBD71j/jj66fm5UTc5uUmxmE/PnAFkmunrWBgZrT5dIRH15qZg
         79Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2Lm2XEhj554nhLanYfHnNl+075jWs6q2zbzsQt5MUhE=;
        b=NRd3c/XNsa9E4EbHbH9mGG1N/8XMq6fd02z2dTFUnnp18apiamZiOFsaf2cCWbLo4l
         hRniC4wrBtrmIebFsD8uCIW4rN/5zBlwxkBNskf6T1dnGjBk98F+FYfaaU13U91EtqyW
         hINs0DhscRK4TLCVq8aKN8zsSJk0gzjhBGhMgdgUDjqoNpFOk6Zz1d0Qics+++ZQMVsE
         8lfsx8LVCpBIdz1lZQVEVAeFofyUNZZGJefReSjD2B9RMwsHV8i5QNanPMA3Cq8WT88K
         JPeZC7ZL9cRmqen1IDl6aNHQ1WtC17Fug/xrVSMvDlmcOLwl+QOSmKhGmQgyhBS2thtF
         xWxw==
X-Gm-Message-State: AMke39lTn9PO4Le7hi+GVx9vLYIafyaYeoDhyriRCvijQVGsKXEckqSf+bCzzbs+c8l+Mw==
X-Received: by 10.99.67.6 with SMTP id q6mr4909551pga.156.1487958783887;
        Fri, 24 Feb 2017 09:53:03 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id p73sm16283542pfj.47.2017.02.24.09.53.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 09:53:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christophe Macabiau <christophemacabiau@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: fatal error when diffing changed symlinks
References: <CAC0icTZ87yeYndPFyjD4nkJBcw5SC-bgUJYbEzYqH7YhSFZvuQ@mail.gmail.com>
Date:   Fri, 24 Feb 2017 09:53:02 -0800
In-Reply-To: <CAC0icTZ87yeYndPFyjD4nkJBcw5SC-bgUJYbEzYqH7YhSFZvuQ@mail.gmail.com>
        (Christophe Macabiau's message of "Fri, 24 Feb 2017 12:47:38 +0100")
Message-ID: <xmqqshn34gsh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christophe Macabiau <christophemacabiau@gmail.com> writes:

> with the commands below, you will get :
>
>> fatal: bad object 0000000000000000000000000000000000000000
>> show 0000000000000000000000000000000000000000: command returned error: 128
>>
>
> I am using version 2.5.5 fedora 23
>
> cd /tmp
> mkdir a
> cd a
> git init
> touch b
> ln -s b c
> git add .
> git commit -m 'first'
> touch d
> rm c
> ln -s d c
> git difftool --dir-diff

A slightly worse is that the upcoming Git will ship with a rewritten
"difftool" that makes the above sequence segfault.  As either way is
bad, I do not particularly think the rewritten one needs to be
reverted (it would give "fatal: bad object" then, and would not fix
your problem), but it needs to be looked at.

Thanks for a report.

