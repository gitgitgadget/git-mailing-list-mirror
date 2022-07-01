Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40FDC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 11:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbiGALKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 07:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237268AbiGALKc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 07:10:32 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BB738188
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 04:10:27 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 205so1013146ybe.3
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 04:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DQEWWEGAWnfdQyW6DLCYDu2Ab7hr34evcWceLkxnZ/g=;
        b=GCreQK/CqKkYRym1PvtoG6VLoRKpicfCQdKV1L2t9rKj74lLXVW/QCI2P5mK9PPHdA
         afPCiRBIeti4szX4edeet8Kbii4f3RtC9WDV50tjdC+XtbL/0J9Yico6lO4IiT/3Pwcd
         LLkVxBewDoonU7ZDRQqrir1HS764t3XxjtwmkxHK15keXsVPIlHJyi47rRapTV4AiUiP
         RmtRx623FWeW9py2f0KNT6lpu4WQJVnKscMaRDnlTY4Gxvn7xIK9KUfyrXXL/G73LNXm
         WjufVjWSrEwxoN71vkPXUgwN2MjU5vk8xfsy7YHWChhtjSOzzZ2ji2wTgUOBJPU4kcyV
         deBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DQEWWEGAWnfdQyW6DLCYDu2Ab7hr34evcWceLkxnZ/g=;
        b=V7BKJzb44MoVhG6VOEhw9vkz8Jk1jSgwHMgh+JaEQjycjeJmtBx5+9y7yzjAkAqB73
         ZNwFnmAE1vt6UUcy7IKr62bAIQt7u89y00ssEjiwA1w4h7yok41EtBjgF1t1OEG+Bg75
         VyiWqaDKK6IbpqDb3ZRK71hAJ0JCPlvdYDn/gNAXZPGEfJdwOfKPNujynGyY0dSCB9J3
         3HbtazjGzimrREH76/6NMrPDeJ0azpjDLIaghDZEbQ/eiSv8Cw4J+R1A9xy7eBTmfVxg
         ISNksCXzvI1fDwhBU0LasSlGfmkK0FcHdVHSMJdPh69dCac4S/wF386WExNDOGBqx4Cr
         RW2w==
X-Gm-Message-State: AJIora/dht4tjFnEGf6RgEALYNxcim8kSCVdHS3sZrM+dP5FE2OkQ7fx
        aYQQj27yebtiXK4KSIpflakJcSiXiz0nKqmOLkc=
X-Google-Smtp-Source: AGRyM1u+EwNfKPHk4npr22xaA9ZsYeJAHemzyF145IOB6d/q2iCLR5qy9bufNQ3L4uSES1vrWw3fh++S6rEoTdPSnBA=
X-Received: by 2002:a25:9e82:0:b0:669:b38d:e93e with SMTP id
 p2-20020a259e82000000b00669b38de93emr14454469ybq.242.1656673826955; Fri, 01
 Jul 2022 04:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220630152757.yxwhijvj5xoosrws@meerkat.local>
 <CAP8UFD1Ar13wqQP0ecb37saShSVj5Gxcjdpz=pckXZ7X9TRfSQ@mail.gmail.com> <xmqqh741decp.fsf@gitster.g>
In-Reply-To: <xmqqh741decp.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 1 Jul 2022 13:10:15 +0200
Message-ID: <CAP8UFD11yVhNK0zr1A9AkTyEOHfC9fBjgZTNHDWHA0=zmJWprQ@mail.gmail.com>
Subject: Re: Non-interactively rewording commit messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 11:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:

> > Have you tried `git interpret-trailers`?
>
> Do you mean a
>
>         git fast-export |
>         git interpret-trailers |
>         git fast-import
>
> pipeline?

I was thinking about using ways that are described a bit in the `git
interpret-trailers` doc. And I was thinking about using  =CC=80git rebase
-i` and either adding "exec ..." lines to the todo list (possibly with
`--exec ...` ) or maybe using "reword ..."

About ways that are described in the `git interpret-trailers` doc, there is=
:

* the following example with `git format-patch`:

      =E2=80=A2   Extract the last commit as a patch, and add a Cc and a
Reviewed-by trailer to it:

              $ git format-patch -1
              0001-foo.patch
              $ git interpret-trailers --trailer 'Cc: Alice
<alice@example.com>' --trailer 'Reviewed-by: Bob <bob@example.com>'
0001-foo.patch >0001-bar.patch

* the example with a commit-msg hook that uses git interpret-trailers

BTW using interpret-trailers' --in-place option might be better than
handling files the way it's done in both these examples.
