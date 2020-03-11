Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ABCC0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 18:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7983620737
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 18:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1rsh5ir"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbgCKS4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:56:55 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:44606 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbgCKS4z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 14:56:55 -0400
Received: by mail-lj1-f175.google.com with SMTP id a10so3526268ljp.11
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HVDt1VG+RWmyQ/Dz1ww03un/AulJuTRMMHCE/MUqlN4=;
        b=C1rsh5iranQI0LSZYDRRGU3FcSjehbB//0OoK1YuvXU9zkRDRS1+tb/F4v4vNDNb14
         JKyQNBr10vkXrCDy8f4RjylwBgp5zVrKzP2HEVgizLPOIJ4THsFKCjaNZ7xtE33Mx5YO
         rtOEMLahHd9FtYyobDrWffmabqaOZqzFB1+JB6hiPB30U+oZ+9ytyzvx8VTxaCQZfMzi
         nD7SB3l88Fqq1u3O//c8nLUKPTHJJdmFlRURhKUVgBZ9BnzOjWjVCnrXyfEME8EFV/be
         WyNw8LralJR4anabYjTwfmxE/LLdjk7ngLhIelyBLmj5T7x5syGq6jN6EmV8ZkFxkeoH
         Zizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HVDt1VG+RWmyQ/Dz1ww03un/AulJuTRMMHCE/MUqlN4=;
        b=OmHMBcdzWNecujznOUmU8TIKCjn2pHvqsIivmJgQ934Y1pneHONZFtZJNTSLz82pcM
         UDEX5/3yhCcVLyLFWdbjMvYrUnbyj9tw46xi2KJz7D60ODOHGucux/ABmq0WHSQYxSC3
         VQ3XriZ2fKpcvFCaeZ/gyvDGgylEK9BmMxJ+vgK9lvKQSePGCdgBx5eptGRB8qIaLCyt
         37coY0tPXJJTudCDG6RTgIplNdaSsmppL65J64/WKX8+8SpLB2Wweaz/8H8RFm1eGqLP
         yZuYeB/isbveY93/aHs/9UHiAusCeOZzFAa/t3VffOtV4Q8WsLxjF+L+DBxOfbBHhw92
         MSyg==
X-Gm-Message-State: ANhLgQ1H5f0XweRRUZOMYZjCgTig93u2YFRCe5BezTlVt5OGDZYIBJTc
        KgwdwvjHmyxpxe9o7jr8rv4LJ8o9cZKvSLt/jTKMw1whabGVrw==
X-Google-Smtp-Source: ADFU+vvKv/dTnXZbKeHcm9UoagVuaNKRGHhoS13i31eAAW6zZSulTvXUpyvHKGrXNtpwifpWXe9eN61CdemXzchxkf4=
X-Received: by 2002:a2e:804b:: with SMTP id p11mr2952877ljg.50.1583953012958;
 Wed, 11 Mar 2020 11:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAGa6KtSgGOLVjHdubwRW=Bvnjnp2PoP7jJ5_NxNWGFLrVYT9SA@mail.gmail.com>
 <2001043.V3P9HlvaID@mfick-lnx>
In-Reply-To: <2001043.V3P9HlvaID@mfick-lnx>
From:   Christos Pappas <chrispappas99@gmail.com>
Date:   Wed, 11 Mar 2020 20:56:44 +0200
Message-ID: <CAGa6KtQ2dQWPWxbk2MH8QJxemM8QD_O=B3aYzsP5AH-sN-7PSw@mail.gmail.com>
Subject: Re: [Feature request] Give non-unique names to commits for grouping
To:     Martin Fick <mfick@codeaurora.org>
Cc:     git@vger.kernel.org, annulen@yandex.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your answers.

From what I can deduce, both of your suggestions require that the
commit messages(or notes) must have some special text for which we can
search for, which is hacky and would be different on every repository.

What I am suggesting is something like, labels on GitHub, hashtags on
Social-Media, or Tags in News sites. It's a well known concept so it
will be easy to understand and use.

We could initially create the concept of marks/labels/{another name}
('tags' is already in use by another git command) and then
incrementally enhance the git commands to use this functionality (like
the example I gave above, with git blame).


=CE=A3=CF=84=CE=B9=CF=82 =CE=A4=CE=B5=CF=84, 11 =CE=9C=CE=B1=CF=81 2020 =CF=
=83=CF=84=CE=B9=CF=82 6:00 =CE=BC.=CE=BC., =CE=BF/=CE=B7 Martin Fick
<mfick@codeaurora.org> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
>
> On Wednesday, March 11, 2020 1:16:09 AM MDT Christos Pappas wrote:
> > I suggest that we should have the option to mark each commit with a
> > category name, that is not necessarily unique (like 'tags') so we
> > could have commit groups.
> > For example we could:
> > git mark {commit_id} {name}
> >
> > Then we could give special functionality to some commands based on
> > those "marks".
> > For example if we had marked a few commits with the name 'fix_typo'
> > git log --mark fix_typo. Show all the commits marked with 'fix_typo'
> > git blame --mark fix_typo Run git blame but ignore commits with 'fix_ty=
po'
>
> Perhaps git notes could be used to do something like this?
>
> -Martin
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code
> Aurora Forum, hosted by The Linux Foundation
