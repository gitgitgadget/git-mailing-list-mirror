Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05082EB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 17:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjF3Riw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 13:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjF3Riu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 13:38:50 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66893199B
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 10:38:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565ba5667d5so19808847b3.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688146728; x=1690738728;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMICm5lI7wio9pGiJVbFPub3sN9eBVw0ryqL+d46H1s=;
        b=EWP0+S3pIwIxGKdQA+0ThEYmnh1MoWSX2I8R9Ntcji9hEvr3TVRmlhE7MvjfO2Qwpc
         wFFZHPgJQ7gFqG0+COzMeRWvI1VoDGObo5/iIkfc4eCvjb/9izX0mWF1d1Paega1sgNz
         fk3Wrn9oGG8LDEC32uAIe81yJZpSG2lzGhqDwLJznjufiCz/xKKDoEtDduanPxl5pY7P
         NFd09qR9PVpKnLjeAuq81mEcfHf8Y0Io7b04xLHXyCLMCrGV/CMcAhm16NEVdDHRymDi
         0Wx7NvR+U7/etGxd0IJakCjigkbQB255VsuhP9GJS5HIF3H0VzmNELpuip7rAXW+Q5h2
         mwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688146728; x=1690738728;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WMICm5lI7wio9pGiJVbFPub3sN9eBVw0ryqL+d46H1s=;
        b=i+vfJg/o7aO+uaWGZ9W3na7ItTLIgv3A3T02gc/aEU7EwacXkoUYEeN7A4dtPbOL8f
         EZE2aAlv7FMbroFp2k6Z4PdyBYhMf1K7SUHaSup/6/sJtmgZLYroGRUHxrnn6Li0jA97
         nL4TSxCSkSQngwHVHp70cHvujnc+WJzj98ychi+6gZOAp/QMVrcvVrbMoRc9Fu8M2nFv
         3QznHl70EAcoeWpuUWUcRF/+/gYbjlctnnHLTsLFT/Kae2KH0l1wQSpK6m+XETM+v6Sa
         peAuGE5gmetXmKFKQVca3q5vbWyiIliP1XdITrJjFIdcOFGfqYaxDCsiBT/R9RGIKReT
         Lf9w==
X-Gm-Message-State: ABy/qLah9VQJGRMaKAAGFd4YPcXJnvQVpQFgHXQxCh9oBN+71H6DE+/0
        MAfMMDWYZ30SvaAq+uHBbwEiDHKHb/8=
X-Google-Smtp-Source: APBJJlHJb4Cm4kfi8tggBzT4V/9z4oCco1WHX4LHH6pXkwbFnEVTMkfCgCcCnVJsXaH11+oOLLnJPj4TsC4=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a25:cc96:0:b0:c1d:4fce:460 with SMTP id
 l144-20020a25cc96000000b00c1d4fce0460mr27142ybf.4.1688146728598; Fri, 30 Jun
 2023 10:38:48 -0700 (PDT)
Date:   Fri, 30 Jun 2023 10:38:47 -0700
In-Reply-To: <20230630-staid-welcome-howl-da79f0@meerkat>
Mime-Version: 1.0
References: <5C7CF0D9-4C6F-4207-BA4B-8AC9B472BD75@apple.com> <20230630-staid-welcome-howl-da79f0@meerkat>
Message-ID: <owly1qhs97fc.fsf@fine.c.googlers.com>
Subject: Re: "git commit -m" bug
From:   Linus Arver <linusa@google.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Ruben Ticehurst-James <rs_ticehurstjames@apple.com>
Cc:     git@vger.kernel.org, git-security@googlegroups.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Fri, Jun 30, 2023 at 02:30:55PM +0100, 'Ruben Ticehurst-James' via Git=
 Security wrote:
>> Hello I am reporting a (potential) bug in git:=20
>>=20
>> when I use triple exclamation marks in a commit message (for an example)=
:
>>=20
>> git commit -m =E2=80=9CWORKING!!! WOOOO=E2=80=9D (command above was git =
add .)
>>=20
>> or=20
>>=20
>> git commit -m "Checking !!! Git=E2=80=9D (command above was ls)
>>=20
>> It will instead copy over the last command I used. The two above command=
s produce this output:=20
>
> This is done by your shell (bash). For example, try this:
>
> echo "hello"
> echo "hello!!"
>
> -K

@Ruben: For completeness, if you use single quotes the exclamantion
points should stay as-is (double quotes expand variables and special
things like `!!`, but single quotes do not).

Cheers,
Linus
