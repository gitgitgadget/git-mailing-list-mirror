Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D54EF1F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 00:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbeJGHei (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 03:34:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38842 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeJGHei (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 03:34:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id 193-v6so5009830wme.3
        for <git@vger.kernel.org>; Sat, 06 Oct 2018 17:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zHLOrE4s32B6Jer2hu0klNKf8oQaj7Am1P1msiJcp8M=;
        b=o/qZuDj4lgIqRMEWvJBmZj352UAH0IGIzhpY9FqS+wEKs6w2IZLfzLRI6eLqODpkrp
         KzCGIkbkD22jDsJiW+XdZfXhdfEMueClGpJcskhz4yvFu/0IIJSgjj6u4IfnHUIcOPNs
         2/xwzkgZ12sT7WznuiB8cYPvH6s6uz6XyhApoqIyvHRrakwOxSi2XoyOBlHc3TajDhMP
         csjYKBjd9WBlw+pNiidNbBFyhpJHSyE2rSMs5U31LOLYZbEXmZDz6BTWp2FtoN/qRiuf
         6NokD3fL0176M8lMZ5xzgFb8gnOlMtqN7ODZIvk0SW/QYk5bTA4nuhF6iS/1u5mXg8CM
         ubHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zHLOrE4s32B6Jer2hu0klNKf8oQaj7Am1P1msiJcp8M=;
        b=sQuK+gmTdJIOICRjl55WzIcOHdrJHY6KGm/0Ahz3pBzDkOEAfACXrrZGqtjvc8fmXV
         R7jjZnYF7qinw+kkITcCh0pKFqzrAvX70jwFX5vI9lNScqdcwly4dPsUj/wQNQfANxtD
         Yp/gfSMOsZhk8g3X9xbxSJggoo9VwQe1UaYrxMfYSCtszYvmgdDihgwnoEEgBlCC6492
         t2txNDlut96ADK2veKukDxmwvEGXirRgT7bd+sWR6Czbt+Qb4CMUdjET5CW9e7tu6/a7
         gJ0mpnYyZz1knfuNLFsJ3tF2LVW8gHNngLpqTWBZg0edrnP2SctWVV53mD+1pUO/K8dy
         nIKw==
X-Gm-Message-State: ABuFfoiTKABMgHYpK/Kz6ZYYgkG48yiQkq4e9qh6LscEPAu13WLkBvXp
        +xNET1CILLLKY4tWDJY0CkE=
X-Google-Smtp-Source: ACcGV62lj/mA6zCEQO1LnfGbrfn37oGJHIqcgrMKjx22f4l4efmKIx8kn3dfEJ5C/0fRRNBOVatLFw==
X-Received: by 2002:a1c:d9cc:: with SMTP id q195-v6mr10760760wmg.23.1538872160633;
        Sat, 06 Oct 2018 17:29:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o13sm7642372wrx.53.2018.10.06.17.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 17:29:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, ao2@ao2.it
Subject: Re: [PATCH] builtin/grep.c: remote superflous submodule code
References: <20181005224557.31420-1-sbeller@google.com>
Date:   Sun, 07 Oct 2018 09:29:18 +0900
In-Reply-To: <20181005224557.31420-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 5 Oct 2018 15:45:57 -0700")
Message-ID: <xmqqlg7avbtt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> In f9ee2fcdfa (grep: recurse in-process using 'struct repository',
> 2017-08-02), we introduced a call to repo_read_gitmodules in builtin/grep
> to simplify the submodule handling.
>
> After ff6f1f564c4 (submodule-config: lazy-load a repository's .gitmodules
> file, 2017-08-03) this is no longer necessary, but that commit did not
> cleanup the whole tree, but just show cased the new way how to deal with
> submodules in ls-files.
>
> Cleanup the only remaining caller to repo_read_gitmodules outside of
> submodule.c

Well, submodule-config.c has its implementation and another caller,
which technically is outside submodule.c ;-)  repo_read_gitmodules
has two more callers in unpack-trees.c these days, so perhaps we can
do without this last paragraph.

