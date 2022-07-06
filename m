Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10537C433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 09:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiGFJSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 05:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiGFJS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 05:18:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B38D2645
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 02:18:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id k30so10323279edk.8
        for <git@vger.kernel.org>; Wed, 06 Jul 2022 02:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=TuKHGvbPax263fSFROaW4sL74e8ZFXbLfaScz9BZEt4=;
        b=Nv4Yqz+EVwMLC+r3cBGaYJNQb8ozp2DjGizee3ZSrgqJ/V9rZhezyvZfIKuGKX3a75
         5KIG/vl5kgxPXoexHX+e4hjngmbMkSjeWSmXmLvh1abANP10kJIQl8XaMLkNGoG1ezEH
         ZsHfSHlzrIqKb92Of0Y8h9i4RmduV7aLITQ9/lGvWRi7B8d/o8e1G0vRPw9hHMnsu9vN
         DA9O/XVLvmtempjD9YwvcELXOXy77cNB85bAFrUxGCPUyeCK6KkeYyjhXQcrGcSSspzQ
         fx8DS0g7mkcKs5PseTFROAYNX6qMkGxV5KOlw6vraCpKe00/tnyh7GZpFQR19eYSkAS4
         qlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=TuKHGvbPax263fSFROaW4sL74e8ZFXbLfaScz9BZEt4=;
        b=a6H/LyMsyvZeIup1dElcJijkGqetoLZRV7qXV4OC4E52Kt5EqgYJOY+8x41d0+xMRZ
         BYYA9f9LAECAtPDBwbyMHamOab5SP/Y9xoossfS5hXIWrvOEfuWhP/9TWaZD5Dmwxnnq
         yu60EXYrVtk2sE6jXBYY9CjtmoUfU1+AwuzZQOdkddKcaIWqTW/722mlTLKUot9wUTeP
         xoxWR9sg046YOA5pBzv+6LexoQnmJzQmCfp1dDLl6CRFOErskaxFVAaiXdGYZzSix5L0
         U4+XF7Wm3pV8SniC199cFTolZPIHnPRquMVNk4VkXmnNK2kdZCjOFsVeXrdlwIBbTZLd
         7tGA==
X-Gm-Message-State: AJIora/eqPKslidy59we85E9sxjVyNClfrVKnPzgYqRbCj9EPEXWbB+y
        CnS4BTpDK32uZtyZzbY76r4DDei35zD4AA==
X-Google-Smtp-Source: AGRyM1v0+Ki/ANd+/4L8qPCIn0IZmtxasZhKi4iMoCTmMkHJDLBtfGA24UW2Ju3kVJn7krpIWCtGVA==
X-Received: by 2002:aa7:cdd3:0:b0:43a:1b7d:dce3 with SMTP id h19-20020aa7cdd3000000b0043a1b7ddce3mr26540948edw.359.1657099105563;
        Wed, 06 Jul 2022 02:18:25 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t27-20020a17090616db00b0071cbc7487e1sm16983053ejd.69.2022.07.06.02.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 02:18:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o91Au-004EHz-AL;
        Wed, 06 Jul 2022 11:18:24 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sim Tov <smntov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: "mixed" or "merged" submodules
Date:   Wed, 06 Jul 2022 11:16:11 +0200
References: <CA+X_a+z-=K5BfDpMiWAnnVma6ihh6kUXb84CCrHL5gte5WykMw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CA+X_a+z-=K5BfDpMiWAnnVma6ihh6kUXb84CCrHL5gte5WykMw@mail.gmail.com>
Message-ID: <220706.867d4qa9b3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 05 2022, Sim Tov wrote:

> Hello,
>
> here  https://stackoverflow.com/q/72770397/1876484
>
> I asked this question:
>
> I'm aware of git submodules which dwell each in its own separate directory.
>
> 1. But is there such thing as "mixed" submodules whose content is
> "merged" together?
>
> For instance:
>
> - Submodule1 (path ./), consist of files `a.txt`, `b.txt` and
> directory `C` with the file `1.txt`
> - Submodule2 (path ./), consist of files `x.txt`, `y.txt` and
> directory `C` with the file `2.txt`
> - Resulting "mixed" repo of both submodules: files `a.txt`, `b.txt`,
> `x.txt`, `y.txt` and directory `C` with the files `1.txt`, `2.txt`
>
> 2. If it is not implemented in git - is there a workaround to achieve this?
>
> Here my use case:
>
> Both submodules - independent libraries (collection of books as plain
> text files), which have same structure (directories = book
> categories). I want to present the combined parent git repository as
> full collection of books, while both projects evolve independently and
> do not overlap (in terms of file names = books).
>
> I got a very detailed and informative answer. My question now - do you
> see any other practical use cases for such a feature? Would such a
> more general case of submodules be a good feature in git or not?

Good question, but to answer the thought experiment don't conflate
submodules with this, instead suppose that you have two branches A & B,
which have:

    A: A.txt
    B: B.txt

How will you create and maintain a third branch C which has the union of
the two?

The answer to that question will be the same as with the submodule case,
i.e. you'd need to have some third branch that you maintain (e.g. with a
push hook?) that would be a merge of the two, and ensure that you don't
have path conflicts there.

Then if you wanted to use such a branch as a submodule you'd grab that
down like you would any other branch.

