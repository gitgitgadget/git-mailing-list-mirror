Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D742C636CC
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 14:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjBHOPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 09:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjBHOPI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 09:15:08 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AC237F1E
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 06:15:07 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p9so5576473ejj.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 06:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gnQ6+RPYTmdMTB83YCijjF6XmwaxZqPDHTBO+Mf6ih8=;
        b=fu1zrHnb1PZwME7TLgVHrp/eUBjgA8WE/XVqQysgVJtk9Jgrz3PJ97wI8IOfZ2lzhy
         hWKHdk3ms3p6X/la6TPHyg3OCMHQe8GSdyxnwN4Akdcw1fnpgjHHqEJo+gsFmyjSIIsF
         V6Xs+YH8SHvzN/hbnNWwsbA98Vh4TqVXfrJdS1Xsko2bn946rBQ6AJ9aUIqrqwYBtsdn
         KG96j4Wm1i9SiXRWuiy2JV4HQl3GTTYMpeCFrvnZSgQSyf+4+a7AWjM88Q+5lKiYulZ9
         ZD1wR66FL02HuknfFSYg/drBpmdv5lDnxPdDAf+O+YKLNJMo3iopTEN6b6dPsbEEhTXu
         rPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnQ6+RPYTmdMTB83YCijjF6XmwaxZqPDHTBO+Mf6ih8=;
        b=SnU/wn31qTkqACrzU/fxZxyZxiTrcpTTuMZCgvLc9O0rjDrc0SnFJaJn6WJt/KSc18
         9g9Pw4Lh1CLRBdKsg4bcYovkHWj41jxX6jVSEn4lO9JYZ1o6KSiOiAh6Jh/G8LGago8O
         WnLaiu5guATx2Ytj0NhkMp7eyTMo0N/2OgPzWO6DWXbRBxeYz6+nj6Us4I9OLINF/NpW
         zD8p7817c3JfIluT9KlEQ06WsmezKMp19cei+zOBaxc3P3lZKmnJCj6BWgaF0Go+7CWk
         vi8XYmoPC46flRuOWRXMNuZ34jkQy9WjFKd27geIbU2aSjODr87q74tnH7Bi9/Bp2FEz
         r7Kw==
X-Gm-Message-State: AO0yUKVNVedxSH7lYzyX4YWw4gdh62ZuL9k41Ps0gXHR4SkyK+sK9rfq
        PuLs8QxmabE0vt6rEHA98qTjk/LK4tZN4mfV
X-Google-Smtp-Source: AK7set8wg/6qllRFNeoNPzzbIO3Na7gden+m6e4ALJbj37vZQ4ifjbBE4QAH9o0bSnuDB9OfiiV10Q==
X-Received: by 2002:a17:907:3f11:b0:8aa:991:3923 with SMTP id hq17-20020a1709073f1100b008aa09913923mr7953784ejc.7.1675865706082;
        Wed, 08 Feb 2023 06:15:06 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id op27-20020a170906bcfb00b0084bfd56fb3bsm8277368ejb.162.2023.02.08.06.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 06:15:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPlE0-001NDP-29;
        Wed, 08 Feb 2023 15:15:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     William Blevins <wblevins001@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Unexpected (bug-like) behavior in `git ls-remote` matching.
Date:   Wed, 08 Feb 2023 15:08:56 +0100
References: <CALJHx121C+=mAmfWxko0PUy1QBjfezM4ft6uE1+cyiH3gaLQ2w@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <CALJHx121C+=mAmfWxko0PUy1QBjfezM4ft6uE1+cyiH3gaLQ2w@mail.gmail.com>
Message-ID: <230208.86o7q4z1jr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, William Blevins wrote:

> Setup as follows.
>
> example repo: git@github.com:owner/repo.git
> example branches:
> * ABC-1
> * feature/ABC-1
> * XBC-1
> * EABC-1
>
> These are all things that work as "expected".
> ```
> $ git ls-remote --heads git@github.com:owner/repo.git ABC-
> $ git ls-remote --heads git@github.com:owner/repo.git BC-1
> $ git ls-remote --heads git@github.com:owner/repo.git XBC-1
> <ref>    refs/head/XBC-1
> $ git ls-remote --heads git@github.com:owner/repo.git *BC-1
> <ref>    refs/head/ABC-1
> <ref>    refs/head/EABC-1
> <ref>    refs/head/XBC-1
> <ref>    refs/head/feature/ABC-1
> $ git ls-remote --heads git@github.com:owner/repo.git "[^/]ABC-1"
> <ref>    refs/head/EABC-1
> ```
>
> What is totally unexpected.... is the most simple search for ABC-1...
> ```
> $ git ls-remote --heads git@github.com:owner/repo.git ABC-1
> <ref>    refs/head/ABC-1
> <ref>    refs/head/feature/ABC-1
> ```

Aside from what Junio mentioned, I don't see why you'd think that the
result for "ABC-1" and "BC-1" is correct if you'd like your "ABC-1"
query to also find "EABC-1", but maybe I'm missing something obvious.

