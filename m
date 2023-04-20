Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3781CC77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 07:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjDTHEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 03:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjDTHEW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 03:04:22 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8C33A87
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 00:04:21 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-187af4a5437so460545fac.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 00:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681974260; x=1684566260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXLek5ZuyKoKV7N5AlDmhxzmhKfe2vUH9a/FgLyscXA=;
        b=V+TEfUA5FROJcLSaICrc5MJfaaydHgJjtrGG+7dwTeDO7izIzBKWSuqdXStPz4V+hr
         feemOrWUzPSBULoXJdfC5wZvrJIEAuLxxbgDovtS0d+fKaXumjVOhGqOtIVI8wtagXlM
         iREOZZKOidqk5NLoIODJYylI7SYpV5c5v8sxQo+ZEXuDQmZdm/iVuJTdOGAD8CTN4vpa
         XCQfuKcnhGKxPuFTMy40IqAiWBq0V0zVtPWovl5sggla++wdDuk7cowVXXntQznTToeo
         o40/ZfS/0NUSJBgstOGqgXGBUu1r16GHFV7f6yt7fS1CgQsUJz8CGbqIvZuj7qbGlisf
         QXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681974260; x=1684566260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXLek5ZuyKoKV7N5AlDmhxzmhKfe2vUH9a/FgLyscXA=;
        b=Of++1vUyuURJIg0qEuNk8eIpuYAawLWcdzKB/t3FyMRe7QZyxu/ZCtrA05pC0O6GmK
         Bx0RSHrpJYBIU7U1t0jgXUW9Xas8/DKCXiVTQrimjme6dH9yOCERvz7gUyejV2Zn2I81
         jDh02iAeHXEuGIhIseP2PA1sDaHemA5tA9nKCwU9TIHmaZ906m9eNo6VfrPfKHOFq9JW
         RhgoGFLaV8EVPBAQkCLdu0fWB5//b7+Wf9IpsRbVkDO3SrtQggA8DViKsTuRyBLAEh9V
         KGZXteOAnAa7wdA6uRT3k2BeZZKT+dfuDTY/71hP/EaE3hf/nPtJ29ypPIIaClHCKMjg
         ggCg==
X-Gm-Message-State: AAQBX9f6CPSaQVN+K+mqyLadgnm/CJZM5djCsxunNgi3idq/Z5NYNGOe
        1uHYHzxFlb9oukt6sdBfuAncdLE0bbVr/TV9L0I=
X-Google-Smtp-Source: AKy350YwGmPxDmH8tvegjFt1O7ba/Bx+uuoTqhzyJIQk2Oy8IbcEsLT0vhDKdySS6nhJ6H7f/NnIDDiqh1x2Zxar7ww=
X-Received: by 2002:a05:6871:278f:b0:187:a464:fe0d with SMTP id
 zd15-20020a056871278f00b00187a464fe0dmr233401oab.7.1681974260269; Thu, 20 Apr
 2023 00:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAAp-DqK=CPxpH0ZhA=k8GRFvSz3odoOLhOgAqfYSBpz28JK+hg@mail.gmail.com>
 <20230413190302.drmmdrkv7vfps3qg@tb-raspi4> <xmqqfs93y166.fsf@gitster.g>
In-Reply-To: <xmqqfs93y166.fsf@gitster.g>
From:   Ilya Kamenshchikov <ikamenshchikov@gmail.com>
Date:   Thu, 20 Apr 2023 09:04:09 +0200
Message-ID: <CAAp-DqKzutP2JQB25kzyMG56=sqArpqZ0341-ayaV48pca4skA@mail.gmail.com>
Subject: Re: Git branch capitalisation bug?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've recollected the history of how this issue occurred more and did
few more tests. I'm now working with branch named "feature/git_repro":
1) The error first occurred when I worked with a colleague on a same
branch, and he really used capital "Feature/branch".
2) today, after initial push and doing git log, local git believes it
to be "Feature/repro_git", while `ls-remote` says it's
"feature/repro_git"
```
$ git checkout -b feature/repro_git
$ git push --set-upstream origin feature/repro_git
$ git log
commit 846df8e6d2f921d0ee2e7c427ca174fae291b040 (HEAD ->
feature/repro_git, origin/Feature/repro_git)
$ git ls-remote origin | grep repro
                      (base) 08:44:31
846df8e6d2f921d0ee2e7c427ca174fae291b040 refs/heads/feature/repro_git
```
3) So I conclude there must be some local information saying branch
has Capitalised name, while on remote all is normal.
$ ls .git/refs/remotes/origin
Feature/
# note: doesn't contain "feature/"
---
My wild speculation now: when I first checked out the branch
Feature/branch of my colleague, git has rewritten
.git/refs/remotes/origin/feature as capitalised Feature.
---
I will try to reproduce this on public GitHub later.

Best Regards,
--
Ilya Kamen

On Thu, Apr 13, 2023 at 10:34=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
> > I am not sure, where this Capitalizations comes from.
> > I don't have an account on boschdevcloud.com to test.
> > Is it possible to reproduce it with a public repo ?
> > Otherwise, should we suspect boschdevcloud.com for it ?
> >
> > Any other thoughts from anybody ?
>
> In the transcript I do not see any "git pull" done from the other
> side, so the "origin/Feature/macos_tests" in the commit decoration
> that can be seen in the last part of the transcript may have been
> created locally.  Output from
>
>  $ git ls-remote origin | grep macos_tests
>
> might be a way to see which end of the connection has the issue.
>
