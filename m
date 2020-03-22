Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0006AC4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 16:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A6420724
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 16:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqmn0vWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgCVQPo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 12:15:44 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45328 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgCVQPo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 12:15:44 -0400
Received: by mail-oi1-f195.google.com with SMTP id l22so1388984oii.12
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=chiJ/X/7HeEvKFn4JIhXzzwh9uJt83uXWXYHMOrIn1I=;
        b=eqmn0vWWy+9g2seBebNF+fnvH3xdB3+4t3AMk+y6zPhesin3aPHTpAPgAoC3HdcJno
         eAgxgpJUjTlFf7VKnQECuer9OFgm6gIKoqnN0qbvv3uAnXsEMRdoz6lUXILah8EeBYk0
         h3tl2lJu47/CWg+QKjI6C46Rdw9E9ILNdnIJofwP0oW/8DbMLBwIhaJiaY6Ni9o1mZ/N
         NiVfbYfeY7bH2Lin+8hYpMlfuqH2jalIsWZ5Y+x/JOSHDwKcIToniDqdumwLHOZa/nD6
         bQPu76ZKXQVWnJaHCAnbjOEXEzGWAyKE4vY5DYbJxTSgQxpVGDz75pzMeHOW4D/gsJEH
         kgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=chiJ/X/7HeEvKFn4JIhXzzwh9uJt83uXWXYHMOrIn1I=;
        b=m3KB/GBlhFjtxwzW9yOe473sQlBiYcm5QcptLd/igDERBHkmFOHWSsvRpibB23xQrA
         FzmyXjtLOiMmhtGLZw5iwR/4qKYiwdyCyqsW4DRaaYjc+hA8bB5aj8uki44bc/nXbGBz
         whgQ2bPxILwPCIP8mYadPcPYNN8sJnZQPWb3WUiBlagn/zqgYaW+xHO6MfNetpFVnrjC
         6S7iz8uA8fkfqYYf77vB9kj5PANONwQ5D+c9KVylmBVIQlDXNjiEaFAeba8+yQGhc/9h
         yvmAqa4GRdey8OoFh3EIVBLWtZQOvUcnMSN17Ev7pqkqjRgDf+rr78oUU3uH9VPLcJp0
         lYwA==
X-Gm-Message-State: ANhLgQ33dq/81rE8JTIAtWnmDz+FYls232WeyhbZ8WgFC+XjcczBqocv
        G0jJXYN+jTBD6NukjJleiJxxgLNmyIjLbzpPZG+fiT8c
X-Google-Smtp-Source: ADFU+vvC7QzrxLWtNFN1PTDcBHDAeHm0f71ut8rOnGV08Rq9JGW8XTi5u0Qa3hjoDZ/0PHOH2bFdlajZDtu9SdpsXT8=
X-Received: by 2002:aca:ec16:: with SMTP id k22mr14398836oih.177.1584893743408;
 Sun, 22 Mar 2020 09:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHMHMxW=muHe5qqndtdzR_md6KFQqwEonko-2gXC_q973JgB5w@mail.gmail.com>
 <xmqq8sjs8k3k.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8sjs8k3k.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Sun, 22 Mar 2020 18:15:06 +0200
Message-ID: <CAHMHMxVKXsBRFt7L5BSFZmW02SvisQa-9g7ibn1Dd6cXh1Nefg@mail.gmail.com>
Subject: Re: git stash push/save/create all return exit code 0, even if no
 object was created
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 22 Mar 2020 at 17:50, Junio C Hamano <gitster@pobox.com> wrote:
>
> This has been asked and answered recently at least twice, I think.
>
> https://lore.kernel.org/git/01020169a7ad6af3-ad50e2d1-19fb-46eb-b397-759f8d579e8b-000000@eu-west-1.amazonses.com/
>
> https://lore.kernel.org/git/CADZUK1cjvifbFYk9w6+vE95jgEBuwjoOi_1QfZHoPFBXuXHCCg@mail.gmail.com/
>
> I think these previous ones wanted something more relevant to "git
> stash", in the sense that they wanted to be able to
>
>         git stash
>         do some other things
>         do many other things
>         if earlier "git stash" produced an entry
>                 git stash pop
>
> and the answer to that may be "use stash create upfront, save it
> away yourself in a variable or something, then use that to restore"

I guess I was too much into my stuff, and couldn't think straight on
how to search for this. Apologies, and thank you! :-)

Maybe I find https://public-inbox.org/git/20190927230747.yjdeaen34nnpcchy@camp.crustytoothpaste.net/
| grep -vP '^??' (or git-status-filtering equivalent; I'm in a rush to
commit this e-mail) somehow useful in my case

> But to me your use case does not look like it has much to "git
> stash".  If a user wants to ask "is my working tree and the index
> dirty (iow, have I made any changes)?", wouldn't "git status" be the
> right tool for the job?  It even has an option to produce output
> designed to be machine readable.

I tried to minimize the message, and left that important part out. I
am also part of the first case.

Then my fear/question remains:
* Wouldn't it be safer if it was "securely" stored in `refs/stash`
(i.e. `git stash push`) instead of `sha1="$(git stash create)"; echo
"Created autostash: ${sha1}"`?
  How is `rebase.autoStash = true` protected from "stuff" happening?
  A tin-foil hat example that I'm thinking is terminal output lost for
some reason and git rebase ancestor is killed -9.
  Or is there is "not much" to protect against?
* ... then `git stash` won't clean what it just stored. Is the
solution to also run `git reset --hard` here?
--
With regards,
Ntentos Stavros
