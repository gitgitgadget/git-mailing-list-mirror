Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589551F453
	for <e@80x24.org>; Tue, 16 Oct 2018 05:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeJPNEM (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 09:04:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40299 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeJPNEL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 09:04:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id d2-v6so23816093wro.7
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 22:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7caSdLKGZITjPvF85jMbP9dSQR1O1g+svPJDgEVrjy8=;
        b=Lfb10yiT5AQtTTeBmFzQPCPuZFLXBbn156W2NZV5tDEfRyQB6rtzoWZaJtTX82wRZ1
         7BF5PEwBU1P0KEvbHbyP0BGPb1O+UzxLJgbbb1w9AsxFeH49A6Ek+UF9qoKsV5oZQHss
         wN+uuJaltQHLZqbFm+AteJlSHcO/05sGAHew89O2MdnUEW/KkUItytOMmV9Y3sF/44tc
         Ms385ju4zbLCou3u1SMwRp2gQ96QTJJrauyrq1AE8EUQTDa3nr88X3j9qQ5cxfGvoTI0
         CpoV0jtmY0oLgQF0sxSFmjT0twirbl/YcaCG17iLtYffpkes0peA2ZRVWUmFJM+Negad
         7urg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7caSdLKGZITjPvF85jMbP9dSQR1O1g+svPJDgEVrjy8=;
        b=YcDWSE/PeMZ8A+VNgs43yCPW0OFMk6AR5jJmUNn+UAgNgnf3CPbLwDOmOAfPGY+f3Y
         pl3mLjAfIcthF8HBLhowdAIVOQ1NHeiSV32Xg3bP87JIngwPN2/M6eS+MJQcm87w7lsb
         rHWV2H23jeCMbXQW8OXoWcZITQDnUZcJyk764JR045Zb7yVyUvPznBl8TTO080Nu6RpV
         g4VMCnnKnCLm4uglupX9mvBSiMI0ktQYlRoTQVkb2TNCJ42KIFxDV8H9/aNUgWeut44s
         99zVENudu+xxWQYYiqbHBX3ZaCWWeKZbt+xvd3dPjN9MgGwkFE8/L8cxMTtC+gh70Zzf
         aLIw==
X-Gm-Message-State: ABuFfoiZ7pGiv9GFkSE0Cn4kn64Qq33j+yA7nVravLaHR6BygGnfBDKO
        drYQ7L51ea6oW/qe7mgpxmc=
X-Google-Smtp-Source: ACcGV62swR/rJTHFOyua9LLlzC/YrfJRI7o8Qc2vq2ccOYdHIEwVu/k/0WemAqoM/2ZWWUQFlOkqXQ==
X-Received: by 2002:adf:a781:: with SMTP id j1-v6mr17011957wrc.277.1539666931977;
        Mon, 15 Oct 2018 22:15:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h63-v6sm8448011wmf.31.2018.10.15.22.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 22:15:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Jaewoong Jung <jungjw@google.com>
Subject: Re: [PATCH] submodule helper: convert relative URL to absolute URL if needed
References: <20181012215314.44266-1-sbeller@google.com>
        <20181016001949.173333-1-sbeller@google.com>
        <20181016003324.GA104911@aiede.svl.corp.google.com>
Date:   Tue, 16 Oct 2018 14:15:17 +0900
In-Reply-To: <20181016003324.GA104911@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 15 Oct 2018 17:33:24 -0700")
Message-ID: <xmqq4ldm1nh6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>>     git config submodule.active .
>>     git submodule update
>> fatal: repository '../plugins/codemirror-editor' does not exist
>> fatal: clone of '../plugins/codemirror-editor' into submodule path '/tmp/gerrit/plugins/codemirror-editor' failed
>> Failed to clone 'plugins/codemirror-editor'. Retry scheduled
>> [...]
>> fatal: clone of '../plugins/codemirror-editor' into submodule path '/tmp/gerrit/plugins/codemirror-editor' failed
>> Failed to clone 'plugins/codemirror-editor' a second time, aborting
>> [...]
>
> Thanks.
>
> "git log" and other tools have the ability to rewrap lines and will get
> confused by this transcript.  Can you indent it to unconfuse them?
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>
> Please also credit the bug reporter:
>
> Reported-by: Jaewoong Jung <jungjw@google.com>
>
> ...
> nit: inconsistent vertical whitespace (extra blank line?)
> ...
> I think this would be easier to read with all the release commands
> together:
> ...

All good points.
