Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15A461F404
	for <e@80x24.org>; Wed, 17 Jan 2018 01:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeAQBEz (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 20:04:55 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37487 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbeAQBEx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 20:04:53 -0500
Received: by mail-oi0-f67.google.com with SMTP id e144so11998186oib.4
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 17:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qWHd8QuLpteH537fd1WqoS9RMwbVZVNSrmyTafQbXdI=;
        b=nZ2J+TNEYUICw4twJqjIRvKyPQzBQqAdAs1ajB5Jdt4YqHfv+RftPLLnpwqnrn8igP
         GEJ8ZW7MpieGEzJDdIIdSnIt/HuRPBVMG2Ho71wOuIpBn4HW6leZ1x1N5on7p/4myDLX
         RJuNmn/u5guaN1PAIM5kqXypI/9LfNwz2AWZdABSAoOwHhkYen9GONKkorq7IFJ3KUYs
         cWGslvRnSv0zOmF3EWXyL7W6wTAlOH2IDXwW5tOdxjwIcG+Hvw12GDDVcHLieL4u8fjX
         O58on5W/PNqkAjZIb0jxtMfBKtHHzahAM2/9KQzvR7d+9hxKu/lkUaaemErD/eqJrwSh
         r3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qWHd8QuLpteH537fd1WqoS9RMwbVZVNSrmyTafQbXdI=;
        b=Kq8VMFLOcQk7zWGGjPhGaUfruh04XWDdEXZeQVKUeMMw02YVkNz1cT8osWVZR8WRt3
         sUSzmbjYDyQU0tnd+mK/+NKbJFM9bSqyFYsLs0+ZVukkzNsPuxEGKvXFA4/kdXTZiiGI
         dQxh/ySY2OGCLSGTm2dg3sy7jxIYL5Ikvl1WS3u5kxG7U1rV30UDfo+nzIMMubCpdTWA
         xZQjUB6Qx87XxIgP96oSyh+V6blXup5ggl3rlXoTU8LE8w56kjzxGbYYgDhQmQAUwX2P
         mDviuFbGAGb4RFn5P2zxtOguy089+8YGZSjU5tQxcrvB67jayOy9COkD//wxyzHQbq+p
         YSng==
X-Gm-Message-State: AKwxytdCQVrYS4ijVCv9zrL3yXSsrHp7T64Bnkti8RnHG5N6Hznbvmue
        LqL3z9hU1xy6/DDsMB4+3MAIXj3QGq7MDI6D5hQ=
X-Google-Smtp-Source: ACJfBoufrNA8OFY9FNZbOTIwc/nF+bCXHkMXgx4trzBQF9UJdewWaIn1Sk9iEm3aUgDn684BgXbqItqbqb58BGrzHkk=
X-Received: by 10.202.76.214 with SMTP id z205mr132257oia.183.1516151092459;
 Tue, 16 Jan 2018 17:04:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Tue, 16 Jan 2018 17:04:21 -0800 (PST)
In-Reply-To: <xmqqd129vd17.fsf@gitster.mtv.corp.google.com>
References: <20180116092349.11330-1-pclouds@gmail.com> <xmqqd129vd17.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 17 Jan 2018 08:04:21 +0700
Message-ID: <CACsJy8AzU_WUFvhBKZ76korGJoMy9-6XXx7kZUKyz2GoHgxXGg@mail.gmail.com>
Subject: Re: [PATCH] diff.c: flush stdout before printing rename warnings
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 2:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> The diff output is buffered in a FILE object and could still be
>> partially buffered when we print these warnings (directly to fd 2).
>> The output is messed up like this
>>
>>  worktree.c                                   |   138 +-
>>  worktree.h        warning: inexact rename detection was skipped due to =
too many files.
>>                            |    12 +-
>>  wrapper.c                                    |    83 +-
>>
>> It gets worse if the warning is printed after color codes for the graph
>> part are already printed. You'll get a warning in green or red.
>>
>> Flush stdout first, so we can get something like this instead:
>>
>>  xdiff/xutils.c                               |    42 +-
>>  xdiff/xutils.h                               |     4 +-
>>  1033 files changed, 150824 insertions(+), 69395 deletions(-)
>> warning: inexact rename detection was skipped due to too many files.
>
> The patch sort-of makes sense, and I am not sure if any of the
> issues that show rooms for potential improvements I'll mention are
> worth doing.
>
>  - This matters only when the standard output and the starndard error
>    are going to the same place.

Which is usually true when pager is involved because we redirect
stderr to the pager too 61b80509e3 (sending errors to stdout under
$PAGER - 2008-02-16)

>    It also would be conceptually nicer to
>    flush stderr as well even though it is by default not fully
>    buffered.

There's more than that. I briefly considered if the same thing could
happen elsewhere, this is not the only place we use buffered stdio.
But since it's just a minor annoyance, I stuck to minimal fixes and
the "fix as we see" approach instead of scanning the whole code base
and preventing similar cases.
--=20
Duy
