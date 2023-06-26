Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AEFEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 17:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjFZRgF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 13:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjFZRft (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 13:35:49 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8362F2699
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 10:35:20 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-262e3c597b9so1351169a91.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687800920; x=1690392920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZl88FY7si5AcM1yRg8QLcgFBVq5QI11PI97WqEO7jM=;
        b=U11EusHtlh5WXIArxB7MBcsDDtR4cEH7w9ycRgjtmtybl94hHI/HcXVcT+CuSZWlU3
         TB7cA4MQ18REFU03pHvQ5x3IeOlGV+f3CW+hbXdYtVCWR1/wy6Bf2a6+kLRihYqttzH0
         H4twvpNTNgUekMcO3XmvJ+8qkQqlIOoKYyL5BFvBnspqi5i8yJrm1s+3S5m9AfgPBqYJ
         IzIQDY49/rC1NHx4WvkwVyMv8LcX65qzSW8eMBh5kkE4FlWIZ6YYw63LYtd/NxZGuUqT
         0FYdxhYsQl+f+KpyQxKMiwo6PAr3W9KrN703C+ZcPw95sfFdCT3zzaufKTqb0rBzqyo2
         PjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687800920; x=1690392920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZl88FY7si5AcM1yRg8QLcgFBVq5QI11PI97WqEO7jM=;
        b=XbtChnDDgGS281bCNRXy75o8hPFkrFW+9TfLnP+xxk/k0OOCBL/WgCcMIwcbBYFwgr
         MlPr4Lax/VVc2MSa6KO82/pGUEjYEOXHOO98sE3tADC1+XBCGw/KDXFjW39/B+eEBKXi
         +X0URyQb8BHVy6uBW6hHFo47Yjj5sgMRMuyIZiu1FtGJYsOUvs9PlfVAZYBzPAXKdBW3
         WcD2rrg+vGsY6CVX9a64gjCV67Yrvo2TBMnkQcdsjuub/rp61MeqGwp6CRza020ldGW/
         rf1HeyDw5JrG33scZMh24jQi2cxWk1Eidw1OTKArsEgCHg4pKN7tRKzEZRTTnMI/UKSu
         jxVw==
X-Gm-Message-State: AC+VfDzafUE+INB7vbsUYO0PbWVaFOs0lnF7s/BVPXk8uQ1/KmRkviFh
        saeWQUCyVRxv9YbmIjtBOAtbKChljhOxuUgnsO6P9jVCLD4=
X-Google-Smtp-Source: ACHHUZ674JSybleLWOjBy0j3WFlby6qKD5F3sENdqTwXY3qxZOYrDZ7NWWFOWmDG3MkiBDmSlou/ZAXXPcM4WD+laXo=
X-Received: by 2002:a17:90a:670d:b0:262:e6d2:2d6 with SMTP id
 n13-20020a17090a670d00b00262e6d202d6mr4797527pjj.47.1687800919811; Mon, 26
 Jun 2023 10:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDGPD5UK8+Z0ksX-tv2Rs8ESZ+LCY-Tic-dZSGV0QNStFN=Pg@mail.gmail.com>
 <004c01d9a842$77e75ee0$67b61ca0$@nexbridge.com>
In-Reply-To: <004c01d9a842$77e75ee0$67b61ca0$@nexbridge.com>
From:   =?UTF-8?B?SXbDoW4gRXhww7NzaXRv?= <byjokese@gmail.com>
Date:   Mon, 26 Jun 2023 19:35:06 +0200
Message-ID: <CAPDGPD4dftJenksUJePrHNjkXWJqQ+wTH9jaP_7BcgY8SMki7Q@mail.gmail.com>
Subject: Re: Git question rewarding git merge and its exit codes
To:     rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks so much for the suggestions. I already thought on the first
one, comparing the SHA's, but not always same SHA's will ensure the
merge will have changes to be made (ideological would be the correct,
but some workflows won't ensure it). Will take a look using
-no--commit and take a look with git status and the porcelain flag.
That may be easier and more secure.

Thanks for the answers.

Ivan

El lun, 26 jun 2023 a las 17:25, <rsbecker@nexbridge.com> escribi=C3=B3:
>
> On Monday, June 26, 2023 8:15 AM, Iv=C3=A1n Exp=C3=B3sito wrote:
> >Recently, we have been working on some automations for Git, especially a=
uto-
> >merging some branches. Just noticed that when using: git merge --commit =
--no-ff -m
> >"test message", and no changes are needed, git returns  "Already up-to-d=
ate" with
> >exit code 0. Is this correct? Git hasn't done anything, so not sure how =
correct is to
> >return 0 for success when nothing has been done. We have here a problem =
because
> >the only way we can detect if a commit has been made or not is to check =
the return
> >text, which is not the best idea for future-proof, or changes in the ret=
urn text.
> >
> >Is this exit code as defined, or maybe is something we would need to loo=
k into for
> >future improvements? Is there any other alternatives to detect what has =
happened,
> >not comparing the standard output text?
>
> If you want to script this, use --no-commit instead of --commit. After th=
e merge runs, use git status --porcelain to determine whether merge perform=
ed any actions involving staging to unstaged (conflicts) files. This remove=
s the need to use the completion code.
>
> --Randall
>
> --
> Brief whoami: NonStop&UNIX developer since approximately
> UNIX(421664400)
> NonStop(211288444200000000)
> -- In real life, I talk too much.
>
>
>
