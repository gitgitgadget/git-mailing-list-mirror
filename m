Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA98C7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 22:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjFAW5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 18:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjFAW5y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 18:57:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDAA138
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 15:57:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96f5685f902so196280366b.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 15:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685660271; x=1688252271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pFrAgoJf6H6wqkULjnwtmqKbTc0ug8QYNL/8+uixZc0=;
        b=iXlCIN61FFLAYrXRR6rzNoa5oNooDIt5YHnuido/XyFCDa/5JaOxBRQadYcgVihymo
         5zksaXw1I9YeILkU369ZVd/Jy5QXcBAqbzxoLKBVAfe5+4E7gsX/FrtsS2yPwii29c1F
         0UDTknkpaJSDlCtBUvKqO80ls060FQZKxtgm6q3Hej43rB/UJ6fzqiTa8tVcWYlwMnLB
         keKS51LoSBf58TUsdEMhEF3LVuXqMPFequsul6jUNsp3hw9IyFSrHAXtLa7qr7JcpIur
         S2j6X+ypEUxXuPf80wCCEmr4sXjgRhD3OAPGGnYHtaRRYyjPbR/OIjprcXIosL25ZmHQ
         3L1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685660271; x=1688252271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFrAgoJf6H6wqkULjnwtmqKbTc0ug8QYNL/8+uixZc0=;
        b=NpVnjfoW+329rCdB7+g/doNQvh6GOovUIvCbK9Y4RXDk8txnScZ1i83qaIh5Zlwcws
         DM4mKQL8PAeJDtQjsUBpb0maBw53N74tYGOu9hKjk1mJpJ3+BlVzV+c/mXctWl8mX6tQ
         VMKNkQx8CxhPcT3uxxgZhs71V/1E6vZ4uGFwahq97lDpcK4Ws94lfsUsVRQvUTL1HXQD
         3pVgl3cX04dIfZXVtCJfCWOpIAS0C9GYz0aBUlWj4zH7N62gePAZ+enLIz/hvnqblVkr
         jRsseVK/2kA69pmRcWcVk5Fh4slxKCFwYpc7GRIJAX3lLquvdNWaFYGfYa0rswoe1Ug3
         /Khg==
X-Gm-Message-State: AC+VfDz1UYddnpFWJvCx8/D6RvnraPcauzj+GsOyks67OPKw+7lI02DU
        VMdO3g+dcX2JHqITcJ844NbtHApgiXoQzeXDvKOqNDmZLMYgVw==
X-Google-Smtp-Source: ACHHUZ5qKlk93g+jCzP/W0xtPu+3oLd4MKF7OqWziIuBznreND7mnqlZLSMvNjzQbfyKOBXHltKADunRTcyB8Ht7cE0=
X-Received: by 2002:a17:907:9610:b0:971:eb29:a086 with SMTP id
 gb16-20020a170907961000b00971eb29a086mr10688069ejc.75.1685660271289; Thu, 01
 Jun 2023 15:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <CA+3o5aPQ3BkbAn3u6qSMCkAfNgTcpjT+_ikdqAkkc69NBGybpw@mail.gmail.com>
 <kl6lzg5iztzw.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lzg5iztzw.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Fraser Hanson <fraser.hanson@gmail.com>
Date:   Thu, 1 Jun 2023 15:57:39 -0700
Message-ID: <CA+3o5aNgChKi-m6F_sYr4Sc+VXP-K2BCMpTpY8Km+kH5u9tkCQ@mail.gmail.com>
Subject: Re: git fetch recursion problem
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the theory!

This repo has no .gitmodules file.
I tried running `git fetch --no-recurse-submodules` in one of my
broken repos, but it does not prevent the bug from happening.

I also tried removing the submodule configuration in .git/config, that
had no effect either.

Maybe something is unusual on the server side.  I've set up my own git
server attempting to reproduce similar apache and git versions as on
our corporate mirror but so far cannot reproduce the bug.
I've compared the GIT_CURL_VERBOSE output to what I get for the same
repo from github, but it's not very helpful.
Github uses HTTP2 and my git client sends different service api calls
to github so there's not much basis for comparison here.

My main theory was that maybe the server-side git version was too old
to handle partial clones properly.
Partial clones were introduced in git 2.25.  On my test git server, I
set the server-side git version to 2.7.2.
This did not reproduce the bug -- on the client side using a recent
git version, I was still able to pull partial clones and then fetch
from origin after my local copy went out of date.
